local mod	= DBM:NewMod("Malacrass5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(24239)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_PERIODIC_DAMAGE"
)

--Warriors and warlocks can too but only with right spec/pet. So they are not in the defaults.
local isDispeller = select(2, UnitClass("player")) == "PRIEST"
				or select(2, UnitClass("player")) == "SHAMAN"
				or select(2, UnitClass("player")) == "MAGE"
				or select(2, UnitClass("player")) == "HUNTER"

local warnSiphon			= mod:NewTargetAnnounce(43501, 3)
local warnSpiritBolts		= mod:NewSpellAnnounce(43383, 3)
local warnSpiritBoltsSoon	= mod:NewSoonAnnounce(43383, 5, 2)
local warnFireNovaTotem		= mod:NewSpellAnnounce(43436, 3)
local warnHolyLight			= mod:NewCastAnnounce(43451, 4)
local warnFlashHeal			= mod:NewCastAnnounce(43431, 4)
local warnHealingWave		= mod:NewCastAnnounce(43548, 4)
local warnLifebloom			= mod:NewTargetAnnounce(43421, 4)

local specWarnFireNovaTotem	= mod:NewSpecialWarningSpell(43436, false)
local specWarnHolyLight		= mod:NewSpecialWarningInterrupt(43451)
local specWarnFlashHeal		= mod:NewSpecialWarningInterrupt(43431)
local specWarnHealingWave	= mod:NewSpecialWarningInterrupt(43548)
local specWarnLifebloom		= mod:NewSpecialWarningDispel(43421, isDispeller)
local specWarnConsecration	= mod:NewSpecialWarningMove(43429)
local specWarnRainofFire	= mod:NewSpecialWarningMove(43440)
local specWarnDeathNDecay	= mod:NewSpecialWarningMove(61603)

local timerSiphon			= mod:NewTimer(30, "TimerSiphon")
local timerSpiritBolts		= mod:NewBuffActiveTimer(5, 43383)
local timerSpiritBoltsNext	= mod:NewNextTimer(36, 43383)

local function getClass(name)
	local class = "unknown"
	for i=1, GetNumPartyMembers() do
		if UnitName("party"..i) == name then
			_, class = UnitClass("party"..i)
			break
		end
	end
	class = class:sub(0, 1):upper()..class:sub(2):lower()
	return class
end

function mod:OnCombatStart(delay)
	timerSpiritBoltsNext:Start(15-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(43451) then					--Paladin Heal (Holy Light)
		warnHolyLight:Show()
		specWarnHolyLight:Show()
	elseif args:IsSpellID(43431) then				--Priest Heal (Flash Heal)
		warnFlashHeal:Show()
		specWarnFlashHeal:Show()
	elseif args:IsSpellID(43548) then				--Shaman Heal (Healing Wave)
		warnHealingWave:Show()
		specWarnHealingWave:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(43436) then					--Shaman (Fire Nova Totem)
		warnFireNovaTotem:Show()
		specWarnFireNovaTotem:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43501) then
		local class = getClass(args.destName)
		warnSiphon:Show(args.destName)
		timerSiphon:Start(args.spellName, class)
	elseif args:IsSpellID(43383) then
		warnSpiritBolts:Show()
		warnSpiritBoltsSoon:Schedule(31)
		timerSpiritBolts:Start()
		timerSpiritBoltsNext:Start()
	elseif args:IsSpellID(43421) then
		warnLifebloom:Show(args.destName)
		specWarnLifebloom(args.destName)
	end
end

do 
	local lastSIS = 0--Last S.I.S. (Stand in shit)
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(43429) and args:IsPlayer() and GetTime() - lastSIS > 3 then	--Paladin (Consecration)
			specWarnConsecration:Show()
			lastSIS = GetTime()
		elseif args:IsSpellID(43440) and args:IsPlayer() and GetTime() - lastSIS > 3 then	--Warlock(Rain of Fire)
			specWarnRainofFire:Show()
			lastSIS = GetTime()
		elseif args:IsSpellID(61603) and args:IsPlayer() and GetTime() - lastSIS > 3 then	--Death Knight(Death and Decay)
			specWarnDeathNDecay:Show()
			lastSIS = GetTime()
		end
	end
end