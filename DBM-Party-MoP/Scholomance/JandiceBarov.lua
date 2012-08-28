local mod	= DBM:NewMod(663, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7617 $"):sub(12, -3))
mod:SetCreatureID(59184)--59220 seem to be her mirror images
mod:SetModelID(40639)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--It looks like proper support of her other ability will require transcriptor.
--Whirl of illusion had no emote or spell cast trigger in combat log. (http://mop.wowhead.com/spell=113808 is probalby the cast trigger only transciptor will get)
--I can assume it uses UNIT_SPELLCAST_SUCCEEDED but that'd just be an assumption.
--She seems to use this ability based on health, based on what i saw, 66% and 33%, a bunch of mirror images spawn, and this is phase ends when you discover which one is the real Jandice Barov
--ALL of them have the same CID, 59220, there is no way to tell from combat log whether or not you killed real one, no other event. Again need transcriptor to determine when this phase ends just like phase beginning
--Worse come to worse, we can scan for SPELL_DAMAGE from Whirl of Illusion or maybe scan UNIT_AURA to see if we have a debuff (I don't remember). If we do, we are in phase 2, if we don't, we are not.
--I do know about 7-8 seconds after phase 2 ends she casts her first Rapidity again. that's the fight.
local warnWondrousRapidity		= mod:NewSpellAnnounce(114062, 3)
local warnGravityFlux			= mod:NewSpellAnnounce(114059, 2)
local warnWhirlofIllusion		= mod:NewSpellAnnounce(113808, 4)

local specWarnWondrousRapdity	= mod:NewSpecialWarningMove(114062, mod:IsTank())--Frontal cone fixate attack, easily dodged (in fact if you don't, i imagine it'll wreck you on heroic)

local timerWondrousRapidity		= mod:NewBuffFadesTimer(7.5, 114062)
local timerWondrousRapidityCD	= mod:NewNextTimer(14, 114062)
local timerGravityFlux			= mod:NewCDTimer(12, 114059) -- needs more review.

function mod:OnCombatStart(delay)
	timerWondrousRapidityCD:Start(6-delay)
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(114062) then
		timerWondrousRapidityCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(114062) then
		warnWondrousRapidity:Show()
		specWarnWondrousRapdity:Show()
		timerWondrousRapidity:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 114059 or spellId == 114047) and self:AntiSpam(2, 1) then -- found 2 spellids on first cast, 4 spellids total (114035, 114038, 114047, 114059). needs more logs to confirm whether spellid is correct.
		warnGravityFlux:Show()
		timerGravityFlux:Start()
--	"<330.7> Phylactery [[boss2:Summon Books::0:111669]]"
	elseif spellId == 113808 and self:AntiSpam(2, 2) then
		warnWhirlofIllusion:Show()
		timerGravityFlux:Cancel()
	end
end
