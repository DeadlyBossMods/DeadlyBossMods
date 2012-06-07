local mod	= DBM:NewMod(660, "DBM-Party-MoP", 8, 311)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59303)
--mod:SetModelID(42264)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS"
)

local warnPiercingThrow			= mod:NewCountAnnounce(114021, 2)--This is tied to Death Blossom, it goes 2 peircing throw's then death blossom, then repeats.
local warnDeathBlossom			= mod:NewSpellAnnounce(114025, 3)--^^
local warnBloodyRage			= mod:NewSpellAnnounce(116140, 3)--Fight ends after 4 of these?

local timerPiercingThrowCD		= mod:NewNextTimer(6, 114021)--Blizz seems to have altered these to no longer be a static 6, but extend to 12 when call dog is used
local timerDeathBlossomCD		= mod:NewNextTimer(6, 114025)--Experimental code for this is used but if it doesn't work these will have to be CD bars.

local throwCount = 0
local barProgress = 0

--Heroic Pull 1 Throw/Blossom Pattern 12, 6, 6, Dog, 12, Dog, 12, 6, 6, 6, Dog, 12, 6, Dog, 12, 6, 6, Blood, 13.5, 6

function mod:OnCombatStart(delay)
	throwCount = 0
	barProgress = 0
	timerPiercingThrowCD:Start(12-delay)--12 on engage now? More data needed
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
	elseif args:IsSpellID(114025, 114242) then--wowhead says 114025 doesn't exist, but it certainly does. 114025 normal, 114242 heroic
		warnDeathBlossom:Show()
		timerPiercingThrowCD:Start()
	elseif args:IsSpellID(114259) then--Call Dog
		if timerPiercingThrowCD:IsStarted() then--When this is cast, it extend the current CD of throw/blossom from 6 to 12
			barProgress = timerPiercingThrowCD:GetTime() --So we see how far of 6 second cd we are into
			timerPiercingThrowCD:Update(12 - barProgress, 12)--then we subtrack it from 12, then update bar with what's remaining
		elseif timerDeathBlossomCD:IsStarted() then
			barProgress = timerDeathBlossomCD:GetTime() 
			timerDeathBlossomCD:Update(12 - barProgress, 12)
		end
	elseif args:IsSpellID(116140) then--Blood Rage(done calling dogs)
		throwCount = 0
		warnBloodyRage:Show()
		timerPiercingThrowCD:Start(13.5)
	end
end
