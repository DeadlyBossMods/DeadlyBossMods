local mod	= DBM:NewMod("NyalothaTrash", "DBM-Nyalotha", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 310780 315011 159409 310839 315932 311550 311576 307403 306982 311544 314433",
	"SPELL_AURA_APPLIED 316623",
	"SPELL_AURA_REMOVED 316623"
)

--TODO, Burning Torrent-311623?
--TODO, verify trash version of annihilation uses same spellIds as boss
local warnPsychicDetonation					= mod:NewTargetNoFilterAnnounce(316623, 3)

local specWarnShadowSmash					= mod:NewSpecialWarningDodge(310780, nil, nil, nil, 2, 2)
local specWarnBurstingShadows				= mod:NewSpecialWarningDodge(315011, nil, nil, nil, 2, 2)
local specWarnDreadWind						= mod:NewSpecialWarningDodge(159409, nil, nil, nil, 2, 2)
local specWarnBrutalSmash					= mod:NewSpecialWarningDodge(315932, nil, nil, nil, 3, 2)--This will wreck even a tank, it does over 900k damage, airhorn
local specWarnRainofBlood					= mod:NewSpecialWarningDodge(311544, nil, nil, nil, 2, 2)
local specWarnSanguineFountain				= mod:NewSpecialWarningDodge(314433, nil, nil, nil, 2, 2)
local specWarnFeartheVoid					= mod:NewSpecialWarningSpell(311550, nil, nil, nil, 2, 2)--Aoe Fear
local specWarnPsychicDetonation				= mod:NewSpecialWarningMoveAway(316623, nil, nil, nil, 1, 2)
local yellPsychicDetonation					= mod:NewYell(316623)
local yellPsychicDetonationFades			= mod:NewShortFadesYell(316623)
local specWarnAnnihilation					= mod:NewSpecialWarningDodgeCount(307403, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(307403), nil, 2, 2)
local specWarnDirgefromBelow				= mod:NewSpecialWarningInterrupt(310839, "HasInterrupt", nil, nil, 1, 2)
local specWarnVoidBoltVolley				= mod:NewSpecialWarningInterrupt(311576, "HasInterrupt", nil, nil, 1, 2)

local playerName = UnitName("player")

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 310780 and self:AntiSpam(5, 1) then
		specWarnShadowSmash:Show()
		specWarnShadowSmash:Play("watchstep")
	elseif spellId == 315011 and self:AntiSpam(5, 1) then
		specWarnBurstingShadows:Show()
		specWarnBurstingShadows:Play("watchorb")
	elseif spellId == 159409 and self:AntiSpam(5, 1) then
		specWarnDreadWind:Show()
		specWarnDreadWind:Play("watchstep")
	elseif spellId == 315932 and self:AntiSpam(3, 1) then
		specWarnBrutalSmash:Show()
		specWarnBrutalSmash:Play("watchstep")
	elseif spellId == 311544 and self:AntiSpam(5, 1) then
		specWarnRainofBlood:Show()
		specWarnRainofBlood:Play("watchstep")
	elseif spellId == 314433 and self:AntiSpam(5, 1) then
		specWarnSanguineFountain:Show()
		specWarnSanguineFountain:Play("watchstep")
	elseif spellId == 311550 then
		specWarnFeartheVoid:Show()
		specWarnFeartheVoid:Play("fearsoon")
	elseif (spellId == 307403 or spellId == 306982) and self:AntiSpam(3, args.sourceName) then--Enemy, Player
		if spellId == 306982 and args.sourceName == playerName then return end--Don't warn, you're the caster
		--Can't filter/smart warn tanking though, well could but it'd be ugly without boss unit ID to fall on, so skipped for trash. Boss will use smarter warnings
		specWarnAnnihilation:Show(args.sourceName)
		specWarnAnnihilation:Play("shockwave")
	elseif spellId == 310839 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDirgefromBelow:Show(args.sourceName)
		specWarnDirgefromBelow:Play("kickcast")
	elseif spellId == 311576 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnVoidBoltVolley:Show(args.sourceName)
		specWarnVoidBoltVolley:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 316623 then
		warnPsychicDetonation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPsychicDetonation:Show()
			specWarnPsychicDetonation:Play("runout")
			yellPsychicDetonation:Yell()
			yellPsychicDetonationFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 316623 and args:IsPlayer() then
		yellPsychicDetonationFades:Cancel()
	end
end
