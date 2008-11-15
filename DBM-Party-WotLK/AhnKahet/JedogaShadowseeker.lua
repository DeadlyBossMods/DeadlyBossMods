local mod = DBM:NewMod("JedogaShadowseeker", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29310)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_HEALTH",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warningPhase2Soon		= mod:NewAnnounce("WarningPhase2Soon", 3, 55089)
local warningPhase2Now		= mod:NewAnnounce("WarningPhase2Now", 3, 55089)
local warningThundershock	= mod:NewAnnounce("WarningThundershock", 3, 56926)

local phase

function mod:OnCombatStart()
	phase = 0
end

function mod:UNIT_HEALTH(arg1)
	if UnitName(arg1) == L.name then
		local h = UnitHealth(arg1)
		if (h < 80 and h > 75) or (h < 55 and h > 50) or (h < 30 and h > 25) then
			if not phase then
				phase = 1
				warningPhase2Soon:Show()
			end
		else
			phase = 0
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 56926 then
		warningThundershock:Show()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, sender)
	if msg == L.Emote and sender == L.name then
		warningPhase2Now:Show()
	end
end