local mod	= DBM:NewMod("Malacrass5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(24239)
mod:SetModelID(22332)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)
mod:SetMinCombatTime(30)	-- Prevent pre-maturely combat-end in cases where none targets the boss?

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
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

local timerSiphon			= mod:NewTimer(30, "TimerSiphon", 43501)
local timerSpiritBolts		= mod:NewBuffActiveTimer(5, 43383)
local timerSpiritBoltsNext	= mod:NewNextTimer(36, 43383)

local function getClass(name)
	local class = "unknown"
	if UnitName("player") == name then
		_, class = UnitClass("player")
	else
		local nameString = "%s-%s"	-- "PlayerName-RealmName"
		for i=1, GetNumPartyMembers() do
			local n,r = UnitName("party"..i)	-- arg1 = PlayerName , arg2 = RealmName
			if n == name or (n and r and nameString:format(n,r) == name) then
				_, class = UnitClass("party"..i)
				break
			end
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
		specWarnLifebloom:Show(args.destName)
	end
end

do 
	local lastSIS = 0--Last S.I.S. (Stand in shit)
	function mod:SPELL_PERIODIC_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
		if spellId == 43429 and destGUID == UnitGUID("player") and GetTime() - lastSIS > 3 then	--Paladin (Consecration)
			specWarnConsecration:Show()
			lastSIS = GetTime()
		elseif spellId == 43440 and destGUID == UnitGUID("player") and GetTime() - lastSIS > 3 then	--Warlock(Rain of Fire)
			specWarnRainofFire:Show()
			lastSIS = GetTime()
		elseif spellId == 61603 and destGUID == UnitGUID("player") and GetTime() - lastSIS > 3 then	--Death Knight(Death and Decay)
			specWarnDeathNDecay:Show()
			lastSIS = GetTime()
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end