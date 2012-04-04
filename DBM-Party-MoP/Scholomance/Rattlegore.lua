local mod	= DBM:NewMod("Rattlegore", "DBM-Party-MoP", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59153)
--mod:SetModelID(31092)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE"
)


local warnBoneSpike		= mod:NewSpellAnnounce(113999, 3)

--local specwarnGetBoned	= mod:NewSpecialWarning("specwarnGetBoned")--Since i did this fight solo, i'm not sure if this is a tank only warning or if everyone needs it yet, until i know more i will refrain from enabling this
local specwarnSoulFlame	= mod:NewSpecialWarningMove(114009)--Not really sure what the point of this is yet. It's stupid easy to avoid and seems to serve no fight purpose yet, besides maybe cover some of the bone's you need for buff.

local timerBoneSpikeCD	= mod:NewNextTimer(7, 113999)

function mod:OnCombatStart(delay)
	timerBoneSpikeCD:Start(6.5-delay)
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(113996) and args:IsPlayer() then
		specwarnGetBoned:Show()
	end
end--]]

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(113999) then
		warnBoneSpike:Show()
		timerBoneSpikeCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 114009 or spellId == 115365) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specwarnSoulFlame:Show()
	end
end
