if GetBuildInfo() ~= "5.4.0" then return end
local mod	= DBM:NewMod(856, "DBM-FallOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71859)--haromm
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

--Dogs
local warnRend						= mod:NewStackAnnounce(144304, 2)--Dont have an idea of frequently yet so just a general anounce for now. tank warnings later

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--90%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--80%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--70%
--local warnRustedIronTotem			= mod:NewSpellAnnounce(144290, 3)--Heroic

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewTargetAnnounce(144215, 3)--Not tank flagged, but probably tank debuff, leaving for everyone just in case though. this plus FrostStorm Bolt= one dead MF
local warnToxicMists				= mod:NewTargetAnnounce(144089, 3)
local warnFoulStream				= mod:NewSpellAnnounce(144090, 3)--Check if targetscanning will work here (or if spell itself has a target emote or something)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 3)
--Wavebinder Kardris
local warnFrostStormBolt			= mod:NewSpellAnnounce(144214, 3)--Who is this cast on? random people or active tank?
local warnFoulGeyser				= mod:NewSpellAnnounce(143990, 3)--This may be cast on an actual target player instead of location, as such some changes will be needed
local warnFallingAsh				= mod:NewSpellAnnounce(143973, 4)

--Earthbreaker Haromm
local specWarnFroststormStrike		= mod:NewSpecialWarningSpell(144215, mod:IsTank())
local specWarnAshenWall				= mod:NewSpecialWarningSwitch(144070, not mod:IsHealer())--Assumed, are they adds we have to pick up or kill as dps?
--Wavebinder Kardris
local specWarnFrostStormBolt		= mod:NewSpecialWarningSpell(144214, mod:IsTank())--Assume for now it's on tank, change later if it's not.
local specWarnFallingAsh			= mod:NewSpecialWarningSpell(143973, nil, nil, nil, 2)--Seems like an everyone waring.

--Earthbreaker Haromm
local timerFroststormStrike			= mod:NewTargetTimer(60, 144215, nil, mod:IsTank())
--local timerFroststormStrikeCD		= mod:NewCDTimer(60, 144215, nil, mod:IsTank())
--local timerToxicMistsCD			= mod:NewCDTimer(60, 144089)
--local timerFoulStreamCD			= mod:NewCDTimer(42, 144090)
--local timerAshenWallCD			= mod:NewCDTimer(42, 144070)
--Wavebinder Kardris
--local timerFrostStormBoltCD		= mod:NewCDTimer(60, 144214)
--local timerFoulGeyserCD			= mod:NewCDTimer(42, 143990)
--local timerFallingAshCD			= mod:NewCDTimer(42, 143973)

mod:AddBoolOption("RangeFrame")--This is more or less assumed from Foul Geyser (143990)
mod:AddBoolOption("SetIconOnToxicMists", false)

local toxicMistsTargets = {}
local toxicMistsTargetsIcons = {}

local function warnToxicMistTargets()
	warnToxicMists:Show(table.concat(toxicMistsTargets, "<, >"))
	table.wipe(toxicMistsTargets)
end

local function ClearToxicMistTargets()
	table.wipe(toxicMistsTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetToxicIcons()
		table.sort(toxicMistsTargetsIcons, sort_by_group)
		local toxicIcon = 1
		for i, v in ipairs(toxicMistsTargetsIcons) do
			self:SetIcon(v, toxicIcon)
			toxicIcon = toxicIcon + 1
		end
		self:Schedule(1.5, ClearToxicMistTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	table.wipe(toxicMistsTargets)
--	timerFroststormStrikeCD:Start(-delay)
--	timerFrostStormBoltCD:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144214 then
		warnFrostStormBolt:Show()
		specWarnFrostStormBolt:Show()
--		timerFrostStormBoltCD:Start()
	elseif args.spellId == 144090 then
		warnFoulStream:Show()
--		timerFoulStreamCD:Start()
	elseif args.spellId == 143990 then
		warnFoulGeyser:Show()
--		timerFoulGeyserCD:Start()
	elseif args.spellId == 144070 then
		warnAshenWall:Show()
		specWarnAshenWall:Show()
--		timerAshenWallCD:Start()
	elseif args.spellId == 143973 then
		warnFallingAsh:Show()
		specWarnFallingAsh:Show()
--		timerFallingAshCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144288 then
		warnPoisonmistTotem:Show()
--		timerToxicMistsCD:Start()
	elseif args.spellId == 144289 then
		warnFoulstreamTotem:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
--		timerFoulStreamCD:Start()
--		timerFoulGeyserCD:Start()
	elseif args.spellId == 144290 then
		warnAshflareTotem:Show()
--		timerAshenWallCD:Start()
--		timerFallingAshCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif args.spellId == 144215 then
		warnFroststormStrike:Show(args.destName)
		timerFroststormStrike:Start(args.destName)
--		timerFroststormStrikeCD:Start()
		specWarnFroststormStrike:Show()
	elseif args.spellId == 144089 and not args:IsDestTypeHostile() then
		toxicMistsTargets[#toxicMistsTargets + 1] = args.destName
--		timerToxicMistsCD:Start()
		self:Unschedule(warnToxicMistTargets)
		self:Schedule(0.5, warnToxicMistTargets)
		if self.Options.SetIconOnToxicMists and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(toxicMistsTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetToxicIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetToxicIcons")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
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
