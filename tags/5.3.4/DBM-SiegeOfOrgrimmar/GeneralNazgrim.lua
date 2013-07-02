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
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Nazgrim Core Abilities
local warnSunder					= mod:NewStackAnnounce(143494, 2)--Will add special warnings and such when know cd and stack count needed for swaps
local warnBonecracker				= mod:NewTargetAnnounce(143638, 2, nil, mod:IsHealer())
local warnBattleStance				= mod:NewSpellAnnounce(143589, 2)
local warnBerserkerStance			= mod:NewSpellAnnounce(143594, 3)
local warnDefensiveStance			= mod:NewSpellAnnounce(143593, 4)
local warnAdds						= mod:NewCountAnnounce("ej7920", 3)
--Nazgrim Rage Abilities
local warnHeroicShockwave			= mod:NewSpellAnnounce(143500, 2)
local warnKorkronBanner				= mod:NewSpellAnnounce(143536, 3)
local warnRavager					= mod:NewSpellAnnounce(143872, 3)
local warnWarSong					= mod:NewSpellAnnounce(143503, 4)
local warnCoolingOff				= mod:NewTargetAnnounce(143484, 1)
--Kor'kron Adds
local warnIronstorm					= mod:NewSpellAnnounce(143420, 3, nil, mod:IsMelee())
local warnArcaneShock				= mod:NewSpellAnnounce(143432, 3)--Could not find valid wowhead spellid
local warnMagistrike				= mod:NewSpellAnnounce(143431, 3, nil, mod:IsMelee())
local warnAssasinsMark				= mod:NewTargetAnnounce(143480, 3)
local warnEarthShield				= mod:NewTargetAnnounce(143475, 4, nil, mod:IsMagicDispeller())
local warnEmpoweredChainHeal		= mod:NewSpellAnnounce(143473, 4)
local warnHealingTideTotem			= mod:NewSpellAnnounce(143474, 4)

--Nazgrim Core Abilities
local specWarnAdds					= mod:NewSpecialWarningCount("ej7920", not mod:IsHealer())
local specWarnSunder				= mod:NewSpecialWarningStack(143494, mod:IsTank(), 5)
local specWarnSunderOther			= mod:NewSpecialWarningTarget(143494, mod:IsTank())
local specWarnBerserkerStance		= mod:NewSpecialWarningSpell(143594, false)--In case you want to throttle damage some
local specWarnDefensiveStance		= mod:NewSpecialWarningSpell(143593)--Definitely OFF DPS
--Nazgrim Rage Abilities
local specWarnHeroicShockwave		= mod:NewSpecialWarningSpell(143500, nil, nil, nil, 2)
local specWarnKorkronBanner			= mod:NewSpecialWarningSwitch(143536, mod:IsDps())
local specWarnRavager				= mod:NewSpecialWarningSpell(143872, false)
local specWarnWarSong				= mod:NewSpecialWarningSpell(143503, nil, nil, nil, 3)
--Kor'kron Adds
local specWarnIronstorm				= mod:NewSpecialWarningInterrupt(143420, mod:IsMelee())--Only needs to be interrupted if melee are near it
local specWarnArcaneShock			= mod:NewSpecialWarningInterrupt(143432)--Should all be interupted, it's a ranged attack that hurts if not interrupted (increases in damage every missed interrupt)
local specWarnMagistrike			= mod:NewSpecialWarningInterrupt(143431, mod:IsMelee())--Only needs to be interrupted if melee are near it
local specWarnEmpoweredChainHeal	= mod:NewSpecialWarningInterrupt(143473)--Concerns everyone, if not interrupted will heal boss for a TON
local specWarnAssassinsMark			= mod:NewSpecialWarningYou(143480)
local specWarnEarthShield			= mod:NewSpecialWarningDispel(143475, mod:IsMagicDispeller())
local specWarnHealingTideTotem		= mod:NewSpecialWarningSwitch(143474, false)--Not everyone needs to switch, should be turned on by assigned totem mashing people.

--Nazgrim Core Abilities
local timerAddsCD					= mod:NewNextCountTimer(45, "ej7920")
local timerSunder					= mod:NewTargetTimer(60, 143494, mod:IsTank() or mod:IsHealer())
local timerSunderCD					= mod:NewCDTimer(10, 143494, mod:IsTank())
local timerBoneCD					= mod:NewCDTimer(30, 143638, mod:IsHealer())
local timerDefensiveStance			= mod:NewBuffActiveTimer(60, 143593)
--Nazgrim Rage Abilities
local timerCoolingOff				= mod:NewBuffFadesTimer(15, 143484)
--Kor'kron Adds
local timerEmpoweredChainHealCD		= mod:NewNextSourceTimer(6, 143473)

local countdownAdds					= mod:NewCountdown(45, "ej7920")
local countdownCoolingOff			= mod:NewCountdown(15, 143484, nil, nil, nil, nil, true)

local addsCount = 0
local boneTargets = {}
local UnitName = UnitName

local function warnBoneTargets()
	warnBonecracker:Show(table.concat(boneTargets, "<, >"))
	timerBoneCD:Start()
	table.wipe(boneTargets)
end

function mod:OnCombatStart(delay)
	addsCount = 0
	table.wipe(boneTargets)
	timerAddsCD:Start(-delay, 1)
	countdownAdds:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143872 then
		warnRavager:Show()
		specWarnRavager:Show()
	elseif args.spellId == 143503 then
		warnWarSong:Show()
		specWarnWarSong:Show()
	elseif args.spellId == 143420 then
		local source = args.sourceName
		warnIronstorm:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnIronstorm:Show(source)
		end
	elseif args.spellId == 143431 then
		local source = args.sourceName
		warnMagistrike:Show()
		if source == UnitName("target") or source == UnitName("focus") then
			specWarnMagistrike:Show(source)
		end
	elseif args.spellId == 143432 then
		local source = args.sourceName
		warnArcaneShock:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnArcaneShock:Show(source)
		end
	elseif args.spellId == 143473 then
		local source = args.sourceName
		warnEmpoweredChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then
			specWarnEmpoweredChainHeal:Show(source)
			timerEmpoweredChainHealCD:Start(source, args.sourceGUID)
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
		timerDefensiveStance:Start()
	elseif args.spellId == 143536 then
		warnKorkronBanner:Show()
		specWarnKorkronBanner:Show()
	elseif args.spellId == 143474 then
		warnHealingTideTotem:Show()
		specWarnHealingTideTotem:Show()
	elseif args.spellId == 143494 then--Because it can miss, we start CD here instead of APPLIED
		timerSunderCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143494 then
		local amount = args.amount or 1
		warnSunder:Show(args.destName, amount)
		timerSunder:Start(args.destName)
		if args:IsPlayer() then
			if amount >= 5 then--At this point the other tank SHOULD be clear.
				specWarnSunder:Show(amount)
			end
		else--Taunt as soon as stacks are clear, regardless of stack count.
			if not UnitDebuff("player", GetSpellInfo(143494)) and not UnitIsDeadOrGhost("player") then
				specWarnSunderOther:Show(args.destName)
			end
		end
	elseif args.spellId == 143484 then
		warnCoolingOff:Show(args.destName)
		timerCoolingOff:Start()
		countdownCoolingOff:Start()
	elseif args.spellId == 143480 then
		warnAssasinsMark:Show(args.destName)
		if args:IsPlayer() then
			specWarnAssassinsMark:Show()
		end
	elseif args.spellId == 143475 then
		warnEarthShield:Show(args.destName)
		specWarnEarthShield:Show(args.destName)
	elseif args.spellId == 143638 then
		boneTargets[#boneTargets + 1] = args.destName
		self:Unschedule(warnBoneTargets)
		self:Schedule(1.5, warnBoneTargets)--Takes a while to get on all targets. 1.5 seconds in 10 man, not sure about 25 man yet
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143494 then
		timerSunder:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71519 then--Kor'kron Warshaman
		timerEmpoweredChainHealCD:Cancel(args.destName, args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.newForces1 or msg == L.newForces2 or msg == L.newForces3 or msg == L.newForces4 or msg == L.newForces5 then
		addsCount = addsCount + 1
		warnAdds:Show(addsCount)
		specWarnAdds:Show(addsCount)
		timerAddsCD:Start(nil, addsCount+1)
		countdownAdds:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143500 then--Faster than combat log by 0.3-0.5 seconds
		warnHeroicShockwave:Show()
		specWarnHeroicShockwave:Show()
	end
end
