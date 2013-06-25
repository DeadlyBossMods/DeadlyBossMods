local mod	= DBM:NewMod(850, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71515)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Nazgrim Core Abilities
local warnSunder					= mod:NewStackAnnounce(143494, 2)--Will add special warnings and such when know cd and stack count needed for swaps
local warnBonecracker				= mod:NewSpellAnnounce(143638, 2)--Or 145568? (also probably change to target announce with more information)
local warnBattleStance				= mod:NewSpellAnnounce(143589, 2)
local warnBerserkerStance			= mod:NewSpellAnnounce(143594, 3)
local warnDefensiveStance			= mod:NewSpellAnnounce(143593, 3)
--Nazgrim Rage Abilities
local warnHeroicShockwave			= mod:NewSpellAnnounce(143713, 2)--Or one of the other 3 spellids
local warnKorkronBanner				= mod:NewSpellAnnounce(143591, 3)
local warnRavager					= mod:NewSpellAnnounce(143872, 3)
local warnWarSong					= mod:NewSpellAnnounce(143503, 4)
local warnCoolingOff				= mod:NewTargetAnnounce(143484, 1)
--Kor'kron Adds
local warnIronstorm					= mod:NewSpellAnnounce(143420, 3)--or 145566?
--local warnArcaneShock				= mod:NewSpellAnnounce(143420, 3)--Could not find valid wowhead spellid
local warnMagistrike				= mod:NewSpellAnnounce(143431, 3)
local warnAssasinsMark				= mod:NewTargetAnnounce(143480, 4)--Or 145561
local warnEarthShield				= mod:NewTargetAnnounce(143475, 4)
local warnEmpoweredChainHeal		= mod:NewSpellAnnounce(143473, 4)
local warnHealingTideTotem			= mod:NewSpellAnnounce(143474, 4)

--Nazgrim Core Abilities
--local specWarnSunder				= mod:NewSpecialWarningStack(143494, mod:IsTank(), 5)
--local specWarnSunderOther			= mod:NewSpecialWarningTarget(143494, mod:IsTank())
local specWarnBerserkerStance		= mod:NewSpecialWarningSpell(143594)
local specWarnDefensiveStance		= mod:NewSpecialWarningSpell(143593)
--Nazgrim Rage Abilities
local specWarnWarSong				= mod:NewSpecialWarningSpell(143503, nil, nil, nil, 2)
--Kor'kron Adds
--local specWarnIronstorm			= mod:NewSpecialWarningRun(143420)--Gonna guess these mobs cast it when low health?
--local specWarnArcaneShock			= mod:NewSpecialWarningInterrupt(143503)
local specWarnMagistrike			= mod:NewSpecialWarningInterrupt(143431)
local specWarnAssassinsMark			= mod:NewSpecialWarningYou(143480)
local specWarnEarthShield			= mod:NewSpecialWarningDispel(143475, mod:IsMagicDispeller())
local specWarnEmpoweredChainHeal	= mod:NewSpecialWarningInterrupt(143473)
local specWarnHealingTideTotem		= mod:NewSpecialWarningSwitch(143474, mod:IsDps())--Not sure of Health. probably doesn't need ALL dps, may make off by default so RL can assign to this

--Nazgrim Core Abilities
local timerSunder					= mod:NewTargetTimer(60, 143494, mod:IsTank() or mod:IsHealer())
--local timerSunderCD				= mod:NewCDTimer(12, 143494, mod:IsTank() or mod:IsHealer())

--Nazgrim Rage Abilities
local timerCoolingOff				= mod:NewBuffFadesTimer(15, 143484)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143638 then
		warnBonecracker:Show()
	elseif args.spellId == 143872 then
		warnRavager:Show()
	elseif args.spellId == 143503 then
		warnWarSong:Show()
		specWarnWarSong:Show()
	elseif args.spellId == 143420 then
		warnIronstorm:Show()
--		specWarnIronstorm:Show()
	elseif args.spellId == 143431 then
		warnMagistrike:Show()
		if source == UnitName("target") or source == UnitName("focus") then
			specWarnMagistrike:Show(args.sourceName)
		end
	elseif args.spellId == 143473 then
		warnEmpoweredChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then
			specWarnEmpoweredChainHeal:Show(args.sourceName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143589 then
		warnBattleStance:Show()
	elseif args.spellId == 143594 then
		warnBerserkerStance:Show()
		specWarnBerserkerStance:Show()
	elseif args.spellId == 143593 then
		warnDefensiveStance:Show()
		specWarnDefensiveStance:Show()
	elseif args.spellId == 143713 then
		warnHeroicShockwave:Show()
	elseif args.spellId == 143591 then
		warnKorkronBanner:Show()
	elseif args.spellId == 143474 then
		warnHealingTideTotem:Show()
		specWarnHealingTideTotem:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143494 then
		local amount = args.amount or 1
		warnSunder:Show(args.destName, amount)
		timerSunder:Start(args.destName)
--[[		if amount >= 5 then
			if args:IsPlayer() then
				specWarnSunder:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(143494)) and not UnitIsDeadOrGhost("player") then
					specWarnSunderOther:Show(args.destName)
				end
			end
		end--]]
	elseif args.spellId == 143484 then
		warnCoolingOff:Show(args.destName)
		timerCoolingOff:Start()
	elseif args.spellId == 143480 then
		warnAssasinsMark:Show(args.destName)
		if args:IsPlayer() then
			specWarnAssassinsMark:Show()
		end
	elseif args.spellId == 143475 then
		warnEarthShield:Show(args.destName)
		specWarnEarthShield:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143494 then
		timerSunder:Cancel(args.destName)
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
