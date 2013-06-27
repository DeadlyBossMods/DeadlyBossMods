local mod	= DBM:NewMod(867, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71734)
--mod:SetQuestID(32744)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--Sha of Pride
local warnSwellingPride			= mod:NewSpellAnnounce(144400, 3)
local warnMark					= mod:NewTargetAnnounce(144351, 3)
local warnWoundedPride			= mod:NewTargetAnnounce(144358, 4, nil, mod:IsTank() or mod:IsHealer())
local warnSelfReflection		= mod:NewTargetAnnounce(144800, 3)
--Pride
local warnBurstingPride			= mod:NewTargetAnnounce(144911, 2)--If this drycode works i'll be very pleased with my assumption skills :)
local warnProjection			= mod:NewTargetAnnounce(145066, 3)--May not be right spellid
local warnBanishment			= mod:NewTargetAnnounce(145066, 3)--May not be right spellid
local warnOvercome				= mod:NewTargetAnnounce(144843, 3)--Damage increase version
local warnOvercomeMC			= mod:NewTargetAnnounce(144863, 4)--Mind control version (ie applied being hit by swelling pride while you have 144843)

--Sha of Pride
local specWarnSwellingPride		= mod:NewSpecialWarningMove(144400, nil, nil, nil, 2)
local specWarnWoundedPride		= mod:NewSpecialWarningSpell(144358, mod:IsTank())
--Pride
local specWarnBurstingPride		= mod:NewSpecialWarningYou(144911)
local specWarnProjection		= mod:NewSpecialWarningYou(145066)
local specWarnBanishment		= mod:NewSpecialWarningYou(145215, nil, nil, nil, 3)
local specWarnOvercome			= mod:NewSpecialWarningYou(144843, nil, nil, nil, 3)--Honestly, i have a feeling your best option if this happens is to find a way to kill yourself!

--Sha of Pride
--local timerSwellingPrideCD	= mod:NewCDTimer(33, 144400)--Energy based, like sha of fear breath, is it also 33?
--local timerMarkCD				= mod:NewCDTimer(33, 144351)
--local timerSelfReflectionCD	= mod:NewCDTimer(33, 144800)

mod:AddBoolOption("InfoFrame")
mod:AddBoolOption("SetIconOnMark", false)

local burstingPrideTargets = {}
local projectionTargets = {}
local banishmentTargets = {}
local overcomeTargets = {}
local overcomeMCTargets = {}
local markOfArroganceTargets = {}
local markOfArroganceIcons = {}
local selfReflectionTargets = {}
local prideLevel = EJ_GetSectionInfo(8255)
local playerName = UnitName("player")

local function warnBurstingPrideTargets()
	warnBurstingPride:Show(table.concat(burstingPrideTargets, "<, >"))
	table.wipe(burstingPrideTargets)
end

local function warnProjectionTargets()
	warnProjection:Show(table.concat(projectionTargets, "<, >"))
	table.wipe(projectionTargets)
end

local function warnBanishmentTargets()
	warnBanishment:Show(table.concat(banishmentTargets, "<, >"))
	table.wipe(banishmentTargets)
end

local function warnOvercomeTargets()
	warnOvercome:Show(table.concat(overcomeTargets, "<, >"))
	table.wipe(overcomeTargets)
end

local function warnOvercomeMCTargets()
	warnOvercomeMC:Show(table.concat(overcomeMCTargets, "<, >"))
	table.wipe(overcomeMCTargets)
end

local function warnMarkTargets()
	warnMark:Show(table.concat(markOfArroganceTargets, "<, >"))
--	timerMarkCD:Start()
	table.wipe(markOfArroganceTargets)
end

local function warnSelfReflectionTargets()
	warnSelfReflection:Show(table.concat(selfReflectionTargets, "<, >"))
--	timerSelfReflectionCD:Start()
	table.wipe(selfReflectionTargets)
end

local function ClearMarkTargets()
	table.wipe(markOfArroganceIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetMarkIcons()
		table.sort(markOfArroganceIcons, sort_by_group)
		local markIcon = 1
		for i, v in ipairs(markOfArroganceIcons) do
			self:SetIcon(v, markIcon)
			markIcon = markIcon + 1
		end
		self:Schedule(1.5, ClearMarkTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(prideLevel)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144400 then
		warnSwellingPride:Show()
		specWarnSwellingPride:Show()
--		timerSwellingPrideCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144911 then
		local source = args.sourceName
		burstingPrideTargets[#burstingPrideTargets + 1] = source
		self:Unschedule(warnBurstingPrideTargets)
		self:Schedule(0.5, warnBurstingPrideTargets)
		if source == playerName then
			specWarnBurstingPride:Show()
		end
	elseif args.spellId == 145066 then
		local source = args.sourceName
		projectionTargets[#projectionTargets + 1] = source
		self:Unschedule(warnProjectionTargets)
		self:Schedule(0.5, warnProjectionTargets)
		if source == playerName then
			specWarnProjection:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145215 then
		banishmentTargets[#banishmentTargets + 1] = args.destName
		self:Unschedule(warnBanishmentTargets)
		self:Schedule(0.5, warnBanishmentTargets)
		if args:IsPlayer() then
			specWarnBanishment:Show()
		end
	elseif args.spellId == 144843 then
		overcomeTargets[#overcomeTargets + 1] = args.destName
		self:Unschedule(warnOvercomeTargets)
		self:Schedule(0.5, warnOvercomeTargets)
		if args:IsPlayer() then
			warnOvercome:Show()
		end
	elseif args.spellId == 144863 then
		overcomeMCTargets[#overcomeMCTargets + 1] = args.destName
		self:Unschedule(warnOvercomeMCTargets)
		self:Schedule(0.5, warnOvercomeMCTargets)
	elseif args.spellId == 144351 then
		markOfArroganceTargets[#markOfArroganceTargets + 1] = args.destName
		self:Unschedule(warnMarkTargets)
		self:Schedule(0.5, warnMarkTargets)
		if self.Options.SetIconOnMark and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(markOfArroganceIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetMarkIcons")
			if (self:IsDifficulty("normal25", "heroic25") and #markOfArroganceIcons >= 8) or (self:IsDifficulty("normal10", "heroic10") and #markOfArroganceIcons >= 3) then
				self:SetMarkIcons()
			else
				if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(0.5, "SetMarkIcons")
				end
			end
		end
	elseif args.spellId == 144358 then
		warnWoundedPride:Show(args.destName)
		specWarnWoundedPride:Show()
	elseif args.spellId == 144800 then
		selfReflectionTargets[#selfReflectionTargets + 1] = args.destName
		self:Unschedule(warnSelfReflectionTargets)
		self:Schedule(0.5, warnSelfReflectionTargets)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138732 and args:IsPlayer() then
		timerIonization:Cancel()
		self:Unschedule(checkWaterIonization)
		if self.Options.RangeFrame and not UnitDebuff("player", GetSpellInfo(137422)) then--if you have 137422 we don't want to hide it either.
			DBM.RangeCheck:Hide()
		end
	end
end

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
