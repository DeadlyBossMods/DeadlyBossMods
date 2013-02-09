if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(829, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68905, 68904)--Lu'lin 68905, Suen 68904
mod:SetModelID(46975)--Lu'lin, 46974 Suen

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Darkness
local warnNight							= mod:NewSpellAnnounce("ej7641", 2, 108558)
local warnCosmicBarrage					= mod:NewSpellAnnounce(136752, 2)
local warnTearsOfSun					= mod:NewSpellAnnounce(137404, 3)
local warnBeastOfNightmares				= mod:NewTargetAnnounce(137375, 3, nil, mod:IsTank() or mod:IsHealer())
--Light
local warnDay							= mod:NewSpellAnnounce("ej7645", 2, 122789)
local warnLightOfDay					= mod:NewSpellAnnounce(138823, 2, nil, false)--Spammy, but leave it as an option at least
local warnFanOfFlames					= mod:NewStackAnnounce(137408, 2, nil, mod:IsTank() or mod:IsHealer())
local warnFlamesOfPassion				= mod:NewSpellAnnounce(137414, 3)--Todo, check target scanning
local warnIceCommet						= mod:NewSpellAnnounce(137419, 2)
--Dusk
---No logs for this :(

--Darkness
local specWarnCosmicBarrage				= mod:NewSpecialWarningSpell(136752, false, nil, nil, true)
local specWarnTearsOfSun				= mod:NewSpecialWarningSpell(137404, nil, nil, nil, true)
local specWarnBeastOfNightmares			= mod:NewSpecialWarningSpell(137375, mod:IsTank())
--Light
local specWarnFanOfFlames				= mod:NewSpecialWarningStack(137408, mod:IsTank(), 2)
local specWarnFanOfFlamesOther			= mod:NewSpecialWarningTarget(137408, mod:IsTank())
local specWarnIceCommet					= mod:NewSpecialWarningSpell(137419, false)

--Dusk
---:(

--Darkness
--Light of Day (137403) has a HIGHLY variable cd variation, every 6-14 seconds. Not to mention it requires using SPELL_DAMAGE and SPELL_MISSED. for now i'm excluding it on purpose
local timerDayCD						= mod:NewNextTimer(184, "ej7645", nil, nil, nil, 122789)--Probably just need localizing, no short text version.
local timerCosmicBarrageCD				= mod:NewCDTimer(23, 136752)
local timerTearsOfTheSunCD				= mod:NewCDTimer(40, 137404)
local timerBeastOfNightmaresCD			= mod:NewCDTimer(50, 137375)
--Light
local timerNightCD						= mod:NewNextTimer(184, "ej7641", nil, nil, nil, 130013)
local timerLightOfDayCD					= mod:NewCDTimer(6, 138823)--In this phase we do track it so we can time shadows usage, although it's still highly variable. Plus in this phase since boss isn't hiding we can detect it without SPELL_DAMAGE
local timerFanOfFlamesCD				= mod:NewNextTimer(12, 137408, nil, mod:IsTank() or mod:IsHealer())
local timerFanOfFlames					= mod:NewTargetTimer(30, 137408, nil, mod:IsTank())
local timerFlamesOfPassionCD			= mod:NewCDTimer(30, 137414)
local timerIceCommetCD					= mod:NewNextTimer(25, 137419)
--Dusk
---:(

mod:AddBoolOption("RangeFrame")--For various abilities that target even melee. SO yes, even melee need to spread out or not come.

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136752) then
		warnCosmicBarrage:Show()
		specWarnCosmicBarrage:Show()
		if timerDayCD:GetTime() < 165 then
			timerCosmicBarrageCD:Start()
		end
	elseif args:IsSpellID(137404) then
		warnTearsOfSun:Show()
		specWarnTearsOfSun:Show()
		if timerDayCD:GetTime() < 145 then
			timerTearsOfTheSunCD:Start()
		end
	elseif args:IsSpellID(137375) then
		warnBeastOfNightmares:Show(args.destName)
		specWarnBeastOfNightmares:Show()
		if timerDayCD:GetTime() < 135 then
			timerBeastOfNightmaresCD:Start()
		end
	elseif args:IsSpellID(137408) then
		warnFanOfFlames:Show(args.destName, args.amount or 1)
		timerFanOfFlamesCD:Start(args.destName)
		timerFanOfFlamesCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnFanOfFlames:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(137408)) and not UnitIsDeadOrGhost("player") then
				specWarnFanOfFlamesOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(137408) then
		timerFanOfFlamesCD:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(137414) then
		warnFlamesOfPassion:Show()
		timerFlamesOfPassionCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(137419) then
		warnIceCommet:Show()
		specWarnIceCommet:Show()
		timerIceCommetCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137105 and self:AntiSpam(2, 1) then--Suen Ports away (Night Phase)
		timerLightOfDayCD:Cancel()
		timerFanOfFlamesCD:Cancel()
		timerFlamesOfPassionCD:Cancel()
		warnNight:Show()
		timerDayCD:Start()
		timerCosmicBarrageCD:Start(17)
		timerTearsOfTheSunCD:Start(23)
		timerBeastOfNightmaresCD:Start()
	elseif spellId == 137187 and self:AntiSpam(2, 2) then--Lu'lin Ports away (Day Phase)
		timerCosmicBarrageCD:Cancel()
		timerTearsOfTheSunCD:Cancel()
		timerBeastOfNightmaresCD:Cancel()
		warnDay:Show()
		timerNightCD:Start()
		timerLightOfDayCD:Start()
		timerFanOfFlamesCD:Start()
		timerFlamesOfPassionCD:Start(12.5)
		timerIceCommetCD:Start()
	elseif spellId == 138823 and self:AntiSpam(2, 3) then
		warnLightOfDay:Show()
		timerLightOfDayCD:Start()
	end
end

