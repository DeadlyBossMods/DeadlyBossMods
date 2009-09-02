local mod = DBM:NewMod("Champions", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453, 34461)
-- 34460, 34469, 34467, 34468, 34471, 34465, 34466, 34473, 34472, 34470, 34463, 34474, 34475

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

mod:SetBossHealthInfo(
-- Horde
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
-- Alliance
	--34461, L.Tyrius,
	--34460, L.Kavina,
	--34469, L.Melador,
	--34467, L.Alyssia,
	--34468, L.Noozle,
	--34471, L.Baelnor,
	--34465, L.Velanaa,
	--34466, L.Anthar,
	--34473, L.Brienna,
	--34472, L.Irieth,
	--34470, L.Saamul,
	--34463, L.Shaabad,
	--34474, L.Serissa,
	--34475, L.Shocuul
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
	if args:IsSpellID(65817, 68142) and args:IsPlayer() then
		specWarnHellfire:Show()
	end
end

