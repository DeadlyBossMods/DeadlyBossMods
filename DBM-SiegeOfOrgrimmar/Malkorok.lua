local mod	= DBM:NewMod(846, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71454)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Endless Rage
local warnBloodRage						= mod:NewSpellAnnounce(142879, 3)
local warnDisplacedEnergy				= mod:NewTargetAnnounce(142913, 3)
--Might of the Kor'kron
local warnArcingSmash					= mod:NewCastAnnounce(142815, 4)--Check for target scanning
local warnSeismicSlam					= mod:NewSpellAnnounce(142851, 3)--or 142849 (or possibly a UNIT even since neither of these seem like cast start event)
local warnBreathofYShaarj				= mod:NewSpellAnnounce(142842, 4)
local warnImplodingEnergy				= mod:NewSpellAnnounce(142986, 3)--142988 cast ID?
local warnFatalStrike					= mod:NewStackAnnounce(142990, 2, nil, mod:IsTank())

--Endless Rage
local specWarnBloodRage					= mod:NewSpecialWarningSpell(142879, nil, nil, nil, 2)
local specWarnBloodRageEnded			= mod:NewSpecialWarningFades(142879)
local specWarnDisplacedEnergy			= mod:NewSpecialWarningRun(142913)
local yellDisplacedEnergy				= mod:NewYell(142913)
--Might of the Kor'kron
local specWarnArcingSmash				= mod:NewSpecialWarningSpell(142815, nil, nil, nil, 2)--if target scanning works, change it up some
local specWarnBreathofYShaarj			= mod:NewSpecialWarningSpell(142842, nil, nil, nil, 2)
local specWarnImplodingEnergy			= mod:NewSpecialWarningSpell(142986, nil, nil, nil, 2)--I realize all 3 are using same sound, but i hope to change 1 or 2 of above to personal/near warnings with 1 sound. plus user can change sound to custom in gui anyways
local specWarnFatalStrike				= mod:NewSpecialWarningStack(142990, mod:IsTank(), 8)--stack guessed, based on CD
local specWarnFatalStrikeOther			= mod:NewSpecialWarningTarget(142990, mod:IsTank())

local timerBloodRage					= mod:NewBuffActiveTimer(22.5, 142879)--2.5sec cast plus 20 second duration
--local timerDisplacedEnergyCd			= mod:NewCDTimer(10, 142913)--2.5sec cast plus 20 second duration
--local timerBloodRageCD				= mod:NewNextTimer(50, 142879)
--Might of the Kor'kron
--local timerArcingSmashCD				= mod:NewCDTimer(40, 142815)
--local timerSeismicSlamCD				= mod:NewCDTimer(25, 142851)
--local timerBreathofYShaarjCD			= mod:NewCDTimer(50, 142842)
--local timerImplodingEnergyCD			= mod:NewCDTimer(50, 142986)
local timerFatalStrike					= mod:NewTargetTimer(30, 142990, mod:IsTank())
--local timerFatalStrikeCD				= mod:NewCDTimer(10, 142990)

local berserkTimer						= mod:NewBerserkTimer(360)

local soundDisplacedEnergy				= mod:NewSound(142913)

mod:AddBoolOption("RangeFrame", true)--Various things
mod:AddBoolOption("SetIconOnDisplacedEnergy", false)

local displacedEnergyTargets	= {}
local displacedEnergyTargetsIcons = {}
local displacedEnergyDebuff = GetSpellInfo(142913)
local playerDebuffs = 0

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, displacedEnergyDebuff)
	end
end

local function warnDisplacedEnergyTargets()
	if mod.Options.RangeFrame then
		if UnitDebuff("player", displacedEnergyDebuff) then--You have debuff, show everyone
			DBM.RangeCheck:Show(8, nil)
		else--You do not have debuff, only show players who do
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	end
	warnDisplacedEnergy:Show(table.concat(displacedEnergyTargets, "<, >"))
--	timerDisplacedEnergyCd:Start()--Probably doesn't get cast a second time? who knows, maybe it does
	table.wipe(displacedEnergyTargets)
end

local function ClearIconTargets()
	table.wipe(displacedEnergyTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetIcons()
		table.sort(displacedEnergyTargetsIcons, sort_by_group)
		local Icon = 1
		for i, v in ipairs(displacedEnergyTargetsIcons) do
			self:SetIcon(v, Icon)
			Icon = Icon + 1
		end
		self:Schedule(1.5, ClearIconTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	table.wipe(displacedEnergyTargets)
	table.wipe(displacedEnergyTargetsIcons)
	playerDebuffs = 0
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142879 then
		warnBloodRage:Show()
		specWarnBloodRage:Show()
		timerBloodRage:Start()
		--timerDisplacedEnergyCd:Start()--Likely starts here
	elseif args.spellId == 142815 then
		warnArcingSmash:Show()
		specWarnArcingSmash:Show()
--		timerArcingSmashCD:Start()
		if self.Options.RangeFrame then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
			DBM.RangeCheck:Hide()
		end
	elseif args.spellId == 142842 then
		warnBreathofYShaarj:Show()
		specWarnBreathofYShaarj:Show()
--		timerBreathofYShaarjCD:Start()
	elseif args.spellId == 142988 then
		warnImplodingEnergy:Show()
		specWarnImplodingEnergy:Show()
--		timerImplodingEnergyCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142851 then
		warnSeismicSlam:Show()
--		timerSeismicSlamCD:Start()
	elseif args.spellId == 142990 then--Assume it can be dodged/parried and trigger CD here
--		timerFatalStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142913 then
		displacedEnergyTargets[#displacedEnergyTargets + 1] = args.destName
		playerDebuffs = playerDebuffs + 1
		if args:IsPlayer() then
			specWarnDisplacedEnergy:Show()
			soundDisplacedEnergy:Play()
			yellDisplacedEnergy:Yell()
		end
		if self.Options.SetIconOnDisplacedEnergy and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(displacedEnergyTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetIcons")
			end
		end
		self:Unschedule(warnDisplacedEnergyTargets)
		self:Schedule(0.3, warnDisplacedEnergyTargets)
	elseif args.spellId == 142990 then
		local amount = args.amount or 1
		warnFatalStrike:Show(args.destName, amount)
		timerFatalStrike:Start(args.destName)
		if args:IsPlayer() then
			if amount >= 8 then--At this point the other tank SHOULD be clear.
				specWarnFatalStrike:Show(amount)
			end
		else--Taunt as soon as stacks are clear, regardless of stack count.
			if amount >= 5 and not UnitDebuff("player", GetSpellInfo(142990)) and not UnitIsDeadOrGhost("player") then
				specWarnFatalStrikeOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 142913 then
		playerDebuffs = playerDebuffs - 1
		if args:IsPlayer() and self.Options.RangeFrame and playerDebuffs >= 1 then
			DBM.RangeCheck:Show(10, debuffFilter)--Change to debuff filter based check since theirs is gone but there are still others in raid.
		end
		if self.Options.RangeFrame and playerDebuffs == 0 then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnDisplacedEnergy then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 142879 then
		specWarnBloodRageEnded:Show()
		if self.Options.RangeFrame then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
			DBM.RangeCheck:Show(5)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
