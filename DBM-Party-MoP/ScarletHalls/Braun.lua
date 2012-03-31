local mod	= DBM:NewMod("Braun", "DBM-Party-MoP", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59303)
--mod:SetModelID(42264)--Still need correct modelId, wowhead has no data on this guy yet

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS"
)

local warnPiercingThrow			= mod:NewCountAnnounce(114021, 2)--This is tied to Death Blossom, it goes 2 peircing throw's then death blossom, then repeats.
local warnDeathBlossom			= mod:NewSpellAnnounce(114025, 3)--^^
local warnBloodyRage			= mod:NewCountAnnounce(116140, 3)--Fight ends after 4 of these?

local timerPiercingThrowCD		= mod:NewNextTimer(6, 114021)
local timerDeathBlossomCD		= mod:NewNextTimer(6, 114025)

local throwCount = 0
local bloodyCount = 0

function mod:OnCombatStart(delay)
	throwCount = 0
	bloodyCount = 0
	timerPiercingThrowCD:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(114021) then
		throwCount = throwCount + 1
		warnPiercingThrow:Show(throwCount)
		if throwCount < 2 then
			timerPiercingThrowCD:Start()
		else
			timerDeathBlossomCD:Start()
		end
	elseif args:IsSpellID(114025) then
		warnDeathBlossom:Show()
		timerPiercingThrowCD:Start()
	elseif args:IsSpellID(114259) then--Call Dog (cast 4x on normal)
		timerPiercingThrowCD:Cancel()
		timerDeathBlossomCD:Cancel()
	elseif args:IsSpellID(116140) then--Blood Rage(done calling dogs)
		throwCount = 0
		bloodyCount = bloodyCount + 1
		warnBloodyRage:Show(bloodyCount)
		timerPiercingThrowCD:Start(13.5)
	end
end
