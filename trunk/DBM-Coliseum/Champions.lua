local mod = DBM:NewMod("Champions", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

mod:SetBossHealthInfo(
	34458, L.Gorgrim,
	34451, L.Birana,
	34459, L.Erin,
	34448, L.Rujkah,
	34449, L.Ginselle,
	34445, L.Liandra,
	34456, L.Malithas,
	34447, L.Caiphus,
	34441, L.Vivienne,
	34454, L.Mazdinah,
	34444, L.Thrakgar,
	34455, L.Broln,
	34450, L.Harkzog,
	34453, L.Narrhok
)


local warnHellfire			= mod:NewAnnounce("WarnHellfire", 1)
local specWarnHellfire		= mod:NewSpecialWarning("SpecWarnHellfire")


function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65816, 68145) then
		warnHellfire:Show()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(65817, 68142) then
		if args.destName == UnitName("player") then
			specWarnHellfire:Show()
		end
	end
end

