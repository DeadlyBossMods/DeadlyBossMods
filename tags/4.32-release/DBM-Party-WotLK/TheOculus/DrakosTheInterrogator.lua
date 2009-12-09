local mod	= DBM:NewMod("DrakosTheInterrogator", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27654)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_DIED"
)

mod:AddBoolOption("MakeitCountTimer", true, "timer")

function mod:UNIT_DIED(args)
	if mod:IsDifficulty("heroic5") then
		if self.Options.MakeitCountTimer and not DBM.Bars:GetBar(L.MakeitCountTimer) then
			local guid = tonumber(args.destGUID:sub(9, 12), 16)
			if guid == 27654 then		-- Drakos The Interrogator
				DBM.Bars:CreateBar(1200, L.MakeitCountTimer)
			end
		end
	end
end