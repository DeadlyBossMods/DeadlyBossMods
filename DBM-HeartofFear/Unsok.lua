local mod	= DBM:NewMod(737, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62511)
mod:SetModelID(43126)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_POWER"
)

--[[WoL Reg Expression
(spellid = 45477 or spellid = 122540 or spellid = 122532 or spellid = 122348) and fulltype = SPELL_CAST_SUCCESS or (spellid =122784 or spellid =121949 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_APPLIED or (spellid =122370 or spellid = 122540 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_REMOVED or (spellid = 122408 or spellid = 122413 or spellid = 122398 or spellid = 122540) and fulltype = SPELL_CAST_START or fulltype = UNIT_DIED and (targetname = "Omegal" or targetname = "Shiramune")
--]]
--Boss
local warnReshapeLife			= mod:NewTargetAnnounce(122784, 4)
local warnAmberScalpel			= mod:NewSpellAnnounce(121994, 3)
local warnParasiticGrowth		= mod:NewTargetAnnounce(121949, 4, nil, mod:IsHealer())
--Construct
local warnAmberExplosion		= mod:NewCastAnnounce(122398, 3, nil, nil, false)--In case you want to get warned for all of them, but could be spammy later fight.
local warnStruggleForControl	= mod:NewTargetAnnounce(122395, 2)--Disabled in phase 3 as at that point it's just a burn.
local warnDestabalize			= mod:NewStackAnnounce(123059, 1, nil, false)--This can be super spammy so off by default.
--Living Amber
local warnLivingAmber			= mod:NewSpellAnnounce("ej6261", 2, nil, false)--122348 is what you check spawns with. ALso spamming and off by default
local warnBurningAmber			= mod:NewCountAnnounce("ej6567", 2, nil, false)--Keep track of Burning Amber Puddles. Spammy, but nessesary for constructs (most definitely tanks)
--Amber Monstrosity
local warnAmberCarapace			= mod:NewTargetAnnounce(122540, 4)--Monstrosity Shielding Boss (phase 2 start)
local warnMassiveStomp			= mod:NewCastAnnounce(122408, 3)
local warnAmberExplosionSoon	= mod:NewPreWarnAnnounce(122402, 10, 3)
local warnFling					= mod:NewSpellAnnounce(122413, 3)--think this always does his aggro target but not sure. If it does random targets it will need target scanning.

--Boss
local specwarnAmberScalpel		= mod:NewSpecialWarningSpell(121994, nil, nil, nil, true)
local specwarnReshape			= mod:NewSpecialWarningYou(122784)
local specwarnParasiticGrowth	= mod:NewSpecialWarningTarget(121949, mod:IsHealer())
--Construct
local specwarnAmberExplosionYou	= mod:NewSpecialWarningInterrupt(122398)--Only interruptable by the player controling construct casting, so only person that gets warning.
local specwarnAmberExplosionAM	= mod:NewSpecialWarning("specwarnAmberExplosionAM")--Generic not used because dbm can't tell optoins apart since they both have same spell name. This is Amber Monstrosity version of Amber Explosion (122402)
local specwarnAmberExplosion	= mod:NewSpecialWarningSpell(122398, nil, nil, nil, true)--One you can't interrupt (ie someone screwed up)
local specwarnWillPower			= mod:NewSpecialWarning("specwarnWillPower")--Some special warning about getting low on Will power needs to be here that tracks alternate UNIT_POWER on self.
--local specwarnBossDebuff		= mod:NewSpecialWarning("specwarnBossDebuff")--Some special warning that says "get your ass to boss and refresh debuff NOW" (Debuff stacks up to 255 with 10% damage taken increase every stack, keeping buff up and stacking is paramount to dps check)
--Living Amber
local specwarnBurningAmber		= mod:NewSpecialWarningMove(122504)--Standing in a puddle
--Amber Monstrosity
local specwarnAmberMonstrosity	= mod:NewSpecialWarningSwitch("ej6254", not mod:IsHealer())
local specwarnMassiveStomp		= mod:NewSpecialWarningSpell(122408, nil, nil, nil, true)

--Boss
local timerReshapeLifeCD		= mod:NewNextTimer(50, 122784)--50 second cd in phase 1-2, 15 second in phase 3. if no construct is up, cd is ignored and boss casts it anyways to make sure 1 is always up.
local timerAmberScalpelCD		= mod:NewCDTimer(40, 121994)--40 seconds after last one ENDED
local timerAmberScalpel			= mod:NewBuffActiveTimer(10, 121994)
local timerParasiticGrowthCD	= mod:NewCDTimer(35, 121949, nil, mod:IsHealer())--35-50 variation (most of the time 50, rare pulls he decides to use 35 sec cd instead)
local timerParasiticGrowth		= mod:NewTargetTimer(30, 121949, nil, mod:IsHealer())
--Construct
local timerAmberExplosionCD		= mod:NewNextSourceTimer(13, 122398)--13 second cd on player controled units, 18 seconds on non player controlled constructs
local timerDestabalize			= mod:NewTargetTimer(10, 123059)
local timerStruggleForControl	= mod:NewTargetTimer(5, 122395)
--Amber Monstrosity
local timerMassiveStompCD		= mod:NewCDTimer(18, 122540)--18-25 seconds variation
local timerFlingCD				= mod:NewCDTimer(25, 122413)--25-40sec variation.
local timerAmberExplosionAMCD	= mod:NewTimer(48, "timerAmberExplosionAMCD", 122402)--13 second cd on player controled units, 18 seconds on non player controlled constructs

mod:AddBoolOption("InfoFrame", false)--Needs more work.

local Puddles = 0
local Phase = 1

function mod:OnCombatStart(delay)
	Puddles = 0
	Phase = 1
	timerAmberScalpelCD:Start(9-delay)
	timerReshapeLifeCD:Start(20-delay)
	timerParasiticGrowthCD:Start(23.5-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader("Will Power")--This is a work in progress
		DBM.InfoFrame:Show(10, "playerpower", 1, ALTERNATE_POWER_INDEX)--At a point i need to add an arg that lets info frame show the 5 LOWEST not the 5 highest, instead of just showing 10
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123059) and not args:GetDestCreatureID() == 62691 then--Only track debuffs on boss, constructs, or monstrosity, ignore oozes.
		warnDestabalize:Show(args.destName, args.amount or 1)
		timerDestabalize:Start(args.destName)
	elseif args:IsSpellID(121949) then
		warnParasiticGrowth:Show(args.destName)
		specwarnParasiticGrowth:Show(args.destName)
		timerParasiticGrowth:Start(args.destName)
		timerParasiticGrowthCD:Start()
	elseif args:IsSpellID(122540) then
		Phase = 2
		warnAmberCarapace:Show(args.destName)
		specwarnAmberMonstrosity:Show()
		timerMassiveStompCD:Start(20)
		timerFlingCD:Start(33)
	elseif args:IsSpellID(122395) and Phase < 3 then
		warnStruggleForControl:Show(args.destName)
		timerStruggleForControl:Start(args.destName)
	elseif args:IsSpellID(122784) then
		warnReshapeLife:Show(args.destName)
		if args:IsPlayer() then
			specwarnReshape:Show()
		end
		if Phase < 3 then
			timerReshapeLifeCD:Start()
		else
			timerReshapeLifeCD:Start(15)--More often in phase 3
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122754) then
		timerDestabalize:Cancel(args.destName)
	elseif args:IsSpellID(121994) then
		timerAmberScalpelCD:Start()
	elseif args:IsSpellID(121949) then
		timerParasiticGrowth:Cancel(args.destName)
	elseif args:IsSpellID(122540) then--Phase 3
		Phase = 3
		timerMassiveStompCD:Cancel()
		timerFlingCD:Cancel()
		timerAmberExplosionAMCD:Cancel()
		warnAmberExplosionSoon:Cancel()
		--He does NOT reset reshape live cd here, he finishes out last one first, THEN starts using new one.
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122398) then
		warnAmberExplosion:Show()
		if args:GetSrcCreatureID() == 62701 then--Cast by a wild construct not controlled by player
			specwarnAmberExplosion:Show()
			timerAmberExplosionCD:Start(18, args.sourceName, args.sourceGUID)--Longer CD if it's a non player controlled construct. Everyone needs to see this bar because there is no way to interrupt these.
		elseif args.sourceGUID == UnitGUID("player") then--Cast by YOU
			specwarnAmberExplosionYou:Show(args.sourceName)
			timerAmberExplosionCD:Start(13, args.sourceName)--Only player needs to see this, they are only person who can do anything about it.
		end
	elseif args:IsSpellID(122402) then--Amber Monstrosity
		specwarnAmberExplosionAM:Show(args.spellName, args.sourceName)
		warnAmberExplosionSoon:Cancel()
		warnAmberExplosionSoon:Schedule(39)
		timerAmberExplosionAMCD:Start(49, args.sourceName, args.sourceGUID)
	elseif args:IsSpellID(122408) then
		warnMassiveStomp:Show()
		specwarnMassiveStomp:Show()
		timerMassiveStompCD:Start()
	elseif args:IsSpellID(122413) then
		warnFling:Show()
		timerFlingCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(122348) then
		warnLivingAmber:Show()
	elseif args:IsSpellID(121994) then
		warnAmberScalpel:Show()
		specwarnAmberScalpel:Show()
	elseif args:IsSpellID(122532) then
		Puddles = Puddles + 1
		warnBurningAmber:Show(Puddles)
	elseif args:IsSpellID(123156) then
		Puddles = Puddles - 1
		warnBurningAmber:Show(Puddles)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 122504 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specwarnBurningAmber:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_POWER(uId)
	if uId ~= "player" then return end
	if UnitPower(uId, ALTERNATE_POWER_INDEX) < 28 and not warnedWill then
		warnedWill = true
		specwarnWillPower:Show()
	elseif UnitPower(uId, ALTERNATE_POWER_INDEX) >= 32 and warnedWill then
		warnedWill = false
	end
end
