if tonumber((select(2, GetBuildInfo()))) < 13682 then return end
local mod	= DBM:NewMod("Malacrass5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5294 $"):sub(12, -3))
mod:SetCreatureID(24239)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSiphon			= mod:NewTargetAnnounce(43501, 3)
local warnSpiritBolts		= mod:NewSpellAnnounce(43383, 3)
local warnSpiritBoltsSoon	= mod:NewSoonAnnounce(43383, 5, 2)

local timerSiphon			= mod:NewTimer(30, "TimerSiphon")
local timerSpiritBolts		= mod:NewBuffActiveTimer(10, 43383)
local timerSpiritBoltsNext	= mod:NewNextTimer(36.5, 43383)

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
	end
end