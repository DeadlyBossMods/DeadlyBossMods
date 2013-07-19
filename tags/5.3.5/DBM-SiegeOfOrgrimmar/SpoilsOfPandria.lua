local mod	= DBM:NewMod(870, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71889)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--Massive Crate of Goods
local warnReturnToStone			= mod:NewTargetAnnounce(145489, 2)
local warnSetToBlow				= mod:NewSpellAnnounce(145996, 3)
--Stout Crate of Goods
local warnMatterScramble		= mod:NewSpellAnnounce(145288, 3)
local warnEnergize				= mod:NewSpellAnnounce(145461, 3)--May be script spellid that doesn't show in combat log
local warnShapeForm				= mod:NewSpellAnnounce(142934, 3)
local warnReconstitute			= mod:NewSpellAnnounce(142947, 3)
local warnMantidSwarm			= mod:NewSpellAnnounce(142539, 3)
local warnResidue				= mod:NewCastAnnounce(145786, 4, nil, nil, mod:IsMagicDispeller())
local warnRageoftheEmpress		= mod:NewCastAnnounce(145812, 4, nil, nil, mod:IsMagicDispeller())
local warnWindStorm				= mod:NewSpellAnnounce(145816, 3)--Stunable?
--Lightweight Crate of Goods
local warnHardenFlesh			= mod:NewSpellAnnounce(144922, 2, nil, false)
local warnSparkofLife			= mod:NewSpellAnnounce(142694, 3)
local warnBlazingCharge			= mod:NewTargetAnnounce(145717, 3)--many spell ids, maybe not right one
local warnBubblingAmber			= mod:NewSpellAnnounce(145746, 3)
local warnEnrage				= mod:NewTargetAnnounce(145692, 3)
--Crate of Pandaren Relics
local warnKegToss				= mod:NewSpellAnnounce(146213, 2)
local warnBreathofFire			= mod:NewSpellAnnounce(146222, 3)
local warnGustingCraneKick		= mod:NewSpellAnnounce(146180, 3)
local warnPathofBlossoms		= mod:NewTargetAnnounce(146256, 3)

--Massive Crate of Goods
local specWarnSetToBlow			= mod:NewSpecialWarningPreWarn(145996, nil, 4)
--Stout Crate of Goods
local specWarnMatterScramble	= mod:NewSpecialWarningSpell(145288, nil, nil, nil, 2)
local specWarnShapeForm			= mod:NewSpecialWarningSpell(142934, nil, nil, nil, 2)--Maybe needs to just be personal move warning instead, need fight experience
local specWarnMantidSwarm		= mod:NewSpecialWarningSpell(142539, mod:IsTank())
local specWarnResidue			= mod:NewSpecialWarningSpell(145786, mod:IsMagicDispeller())
local specWarnRageoftheEmpress	= mod:NewSpecialWarningSpell(145812, mod:IsMagicDispeller())
--Lightweight Crate of Goods
local specWarnHardenFlesh		= mod:NewSpecialWarningInterrupt(144922, mod:IsMelee())
local specWarnSparkofLife		= mod:NewSpecialWarningSwitch(142694, mod:IsRangedDps())--Assumed, based on 250k damage per second pulses within 4 yards of target
local specWarnEnrage			= mod:NewSpecialWarningDispel(145692, mod:CanRemoveEnrage())--Question is, do we want to dispel it? might make this off by default since kiting it may be more desired than dispeling it
--Crate of Pandaren Relics
local specWarnGustingCraneKick	= mod:NewSpecialWarningSpell(146180, nil, nil, nil, 2)

--Massive Crate of Goods
local timerSetToBlow			= mod:NewBuffFadesTimer(30, 145996)
--Lightweight Crate of Goods
local timerEnrage				= mod:NewTargetTimer(10, 145692)

local countdownSetToBlow		= mod:NewCountdownFades(29, 145996)

mod:AddBoolOption("InfoFrame")

local returnToStoneTargets = {}

local function warnReturnToStoneTargets()
	warnReturnToStone:Show(table.concat(returnToStoneTargets, "<, >"))
	table.wipe(returnToStoneTargets)
end

function mod:BlazingChargeTarget(targetname)
	if not targetname then
		print("DBM DEBUG: BlazingChargeTarget Scan failed")
		return
	end
	warnBlazingCharge:Show(targetname)
end

function mod:PathofBlossomsTarget(targetname)
	if not targetname then
		print("DBM DEBUG: PathofBlossomsTarget Scan failed")
		return
	end
	warnPathofBlossoms:Show(targetname)
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(returnToStoneTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 145996 then--Assumed it even fires a CAST_START event, and that it hits ALL players
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
			self:Schedule(32, hideRangeFrame)
		end
	elseif args.spellId == 145288 then
		warnMatterScramble:Show()
		specWarnMatterScramble:Show()
	elseif args.spellId == 145461 then
		warnEnergize:Show()
	elseif args.spellId == 142934 then
		warnShapeForm:Show()
		specWarnShapeForm:Show()
	elseif args.spellId == 142947 then
		warnReconstitute:Show()
	elseif args.spellId == 142539 then
		warnMantidSwarm:Show()
		specWarnMantidSwarm:Show()
	elseif args.spellId == 145786 then
		warnResidue:Show()
		specWarnResidue:Schedule(3)
	elseif args.spellId == 145816 then
		warnWindStorm:Show()
	elseif args.spellId == 145812 then
		warnRageoftheEmpress:Show()
		specWarnRageoftheEmpress:Schedule(3)
	elseif args.spellId == 144922 then
		local source = args.sourceName
		warnHardenFlesh:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnHardenFlesh:Show(source)
		end
	elseif args.spellId == 146222 then
		warnBreathofFire:Show()
	elseif args.spellId == 146180 then
		warnGustingCraneKick:Show()
		specWarnGustingCraneKick:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142694 then
		warnSparkofLife:Show()
		specWarnSparkofLife:Show()
	elseif args.spellId == 145717 then
		self:BossTargetScanner(args.sourceGUID, "BlazingChargeTarget", 0.025, 12)
	elseif args.spellId == 145746 then
		warnBubblingAmber:Show()
	elseif args.spellId == 146213 then
		warnKegToss:Show()
	elseif args.spellId == 146256 then
		self:BossTargetScanner(args.sourceGUID, "PathofBlossomsTarget", 0.025, 12)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145489 then
		returnToStoneTargets[#returnToStoneTargets + 1] = args.destName
		self:Unschedule(warnReturnToStoneTargets)
		self:Schedule(0.5, warnReturnToStoneTargets)
	elseif args.spellId == 145996 and args:IsPlayer() then
		countdownSetToBlow:Start()
		timerSetToBlow:Start()
		specWarnSetToBlow:Schedule(26)
	elseif args.spellId == 145692 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		timerEnrage:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 145996 and args:IsPlayer() then
		countdownSetToBlow:Cancel()
		timerSetToBlow:Cancel()
		specWarnSetToBlow:Cancel()
	elseif args.spellId == 145692 then
		timerEnrage:Cancel(args.destName)
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
