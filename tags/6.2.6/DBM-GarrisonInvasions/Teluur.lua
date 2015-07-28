local mod	= DBM:NewMod("Teluur", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90946)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180849",
	"SPELL_CAST_SUCCESS 180836",
	"SPELL_AURA_APPLIED 180837",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnPodlingSwarm			= mod:NewSpellAnnounce(180849, 2)
local warnEntanglement			= mod:NewTargetAnnounce(180836, 3)--Players who didn't move and got caught
local warnSpore					= mod:NewSpellAnnounce(180825, 3)--Hidden from combat log, until it's too late. Unit event gives enough time to run out but don't know who it's targeting then. target scanning seems to kinda work but not reliable enough. There is somewhat of a delay and often no target at all

local specWarnEntanglement		= mod:NewSpecialWarningDodge(180836, nil, nil, nil, 1, 2)--Dodgable. puts green swirly under random player. traps everyone there after 4 seconds. Target scanning not possible, warn everyone to check feet

local voiceEntanglement			= mod:NewVoice(180836) --watchstep

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180849 then
		warnPodlingSwarm:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180836 then
		specWarnEntanglement:Show()
		voiceEntanglement:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180837 and args:IsDestTypePlayer() then
		warnEntanglement:CombinedShow(1, args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 180825 and self:AntiSpam() then
		self:SendSync("Spore")
	end
end

function mod:OnSync(msg)
	if msg == "Spore" then
		warnSpore:Show()
	end
end
