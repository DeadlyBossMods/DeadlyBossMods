local mod	= DBM:NewMod(1195, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78948, 99999)--78948 Tectus, 80557 Mote of Tectus, 80551 Shard of Tectus
mod:SetEncounterID(1722)--Hopefully win will work fine off this because otherwise tracking shard deaths is crappy
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162475 162968 162894 163312",
	"SPELL_CAST_SUCCESS 162518",
	"SPELL_AURA_APPLIED 162346"
)

--Tectus
local warnEarthenPillar				= mod:NewSpellAnnounce(162518, 3)
local warnTectonicUpheaval			= mod:NewSpellAnnounce(162475, 3)
local warnCrystallineBarrage		= mod:NewTargetAnnounce(162346, 3)
--Night-Twisted NPCs
local warnEarthenFlechettes			= mod:NewSpellAnnounce(162968, 3, nil, mod:IsTank())
local warnGiftOfEarth				= mod:NewSpellAnnounce(162894, 4, nil, mod:IsTank())
local warnRavingAssault				= mod:NewSpellAnnounce(163312, 3)--Target scanning? Emote?

local specWarnTectonicUpheaval		= mod:NewSpecialWarningSwitch(162475)
local specWarnEarthenPillar			= mod:NewSpecialWarningSpell(162518, nil, nil, nil, 2)
local specWarnCrystallineBarrage	= mod:NewSpecialWarningRun(162894)
--Night-Twisted NPCs
local specWarnEarthenFlechettes		= mod:NewSpecialWarningSpell(162968, mod:IsTank())--Change to "move" warning if it's avoidable
local specWarnGiftOfEarth			= mod:NewSpecialWarningSpell(162894, mod:IsTank())

--local timerCrushersCallCD			= mod:NewNextTimer(30, 162475)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162475 and self:AntiSpam(5, 1) then--Antispam assumed.
		warnTectonicUpheaval:Show()
		specWarnTectonicUpheaval:Show()
	elseif spellId == 162968 then
		warnEarthenFlechettes:Show()
		specWarnEarthenFlechettes:Show()
	elseif spellId == 162894 then
		warnGiftOfEarth:Show()
		specWarnGiftOfEarth:Show()
	elseif spellId == 163312 then
		warnRavingAssault:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 162518 then
		warnEarthenPillar:Show()
		specWarnEarthenPillar:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 162346 then
		warnCrystallineBarrage:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCrystallineBarrage:Show()
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
