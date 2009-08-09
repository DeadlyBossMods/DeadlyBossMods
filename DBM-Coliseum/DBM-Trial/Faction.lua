local mod = DBM:NewMod("Faction", "DBM-Trial")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34441)

mod:RegisterCombat("combat", 34441)

mod:RegisterEvents(
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

function mod:OnCombatStart(delay)
end
