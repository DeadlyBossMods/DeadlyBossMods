local mod = DBM:NewMod("Sindragosa", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36853)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("YELL", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"


-- Frost Beacon
local warnFrostBeacon		= mod:NewTargetAnnounce(70126)
local specWarnFrostBeacon	= mod:NewSpecialWarning("SpecWarnFrostBeacon")
local beaconTargets = {}

-- Airphase
local warnAirphase		= mod:NewAnnounce("WarnAirphase")
local nextAirphase		= mod:NewTimer(110, "NextAirphase")

-- Blistering Cold
local warnBlisteringCold	= mod:NewAnnounce("WarnBlisteringCold", 3, 70117, isMelee)
local castBlisteringCold	= mod:NewCastTimer(5, 70117)



function mod:OnCombatStart(delay)
	nextAirphase:Start(50-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70126) then
		self:UnscheduleMethod("warnBeacon")
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnFrostBeacon:Show()
		end
		self:ScheduleMethod(0.2, "warnBeacon")
	end
end

function mod:warnBeacon()
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70117) then
		warnBlisteringCold:Show()
	end
end	

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAirphase then
		self:SendSync("Airphase")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Airphase" then
		warnAirphase:Show()
		nextAirphase:Start()
	end
end
		