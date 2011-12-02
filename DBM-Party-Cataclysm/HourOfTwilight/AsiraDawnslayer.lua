local mod	= DBM:NewMod("AsiraDawnslayer", "DBM-Party-Cataclysm", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54968)
mod:SetModelID(38995)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)
mod:SetMinCombatTime(15)	-- need to do another run to confirm it works

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnSmokeBomb		= mod:NewSpellAnnounce(103558, 2)
local warnBladeBarrier	= mod:NewSpellAnnounce(103419, 3)
local warnMarkofSilence	= mod:NewSpellAnnounce(102726, 3, nil, false)
local warnFireTotem		= mod:NewSpellAnnounce(108374, 1)

local timerSmokeBomb	= mod:NewNextTimer(24, 103558)
local timerFireTotem	= mod:NewNextTimer(23, 108374)
local timerMarkofSilence= mod:NewNextTimer(8, 102726)	

function mod:OnCombatStart(delay)
--	timerMarkofSilence:Start(5-delay)	-- inaccurate ? 
--	timerSmokeBomb:Start(16-delay)		-- inaccurate ? 
--	timerFireTotem:Start(22-delay)		-- inaccurate ?
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103558) then
		warnSmokeBomb:Show()
		timerSmokeBomb:Start()
	elseif args:IsSpellID(103419) then
		warnBladeBarrier:Show()
	elseif args:IsSpellID(102726) then
		warnMarkofSilence:Show()
		timerMarkofSilence:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(108374) and self:IsInCombat() then
		warnFireTotem:Show()
		timerFireTotem:Start()
	end
end