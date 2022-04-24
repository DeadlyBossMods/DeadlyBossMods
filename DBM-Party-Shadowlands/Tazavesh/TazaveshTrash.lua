local mod	= DBM:NewMod("TazaveshTrash", "DBM-Party-Shadowlands", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = false--in this zone, some of the hard modes are just making you do the boss with trash

mod:RegisterEvents(
	"SPELL_CAST_START 356548 352390 354297 356537 355888 355900 355930 355934 356001 357197 347775 355057 355225 355234 355132 355584 357226 357260 356407 356404",
	"SPELL_CAST_SUCCESS 357238",
	"SPELL_SUMMON 355132",
	"SPELL_AURA_APPLIED 355888 355915 355980 357229 357029 355581 356407",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 357029"
)

local warnHardLightBaton					= mod:NewTargetNoFilterAnnounce(355888, 3, nil, "Healer|RemoveMagic")--Customs Security
local warnRadiantPulse						= mod:NewSpellAnnounce(356548, 2)--Zo'honn
local warnBeamSplicer						= mod:NewSpellAnnounce(356001, 3)--Armored Overseer
local warnChronolightEnhancer				= mod:NewCastAnnounce(357229, 3, nil, nil, false)--Cartel Muscle
local warnHyperlightBomb					= mod:NewTargetAnnounce(357029, 3)--Cartel Smuggler
local warnVolatilePufferfish				= mod:NewCastAnnounce(355234, 3)--Various Murlocs

local specWarnGTFO							= mod:NewSpecialWarningGTFO(355581, nil, nil, nil, 1, 8)
local specWarnHardLightBaton				= mod:NewSpecialWarningInterrupt(355888, "Tank", nil, nil, 1, 2)--Customs Security
local specWarnDisruptionGrenade				= mod:NewSpecialWarningDodge(355900, nil, nil, nil, 2, 2)--Customs Security
local specWarnGlyphofRestraint				= mod:NewSpecialWarningDispel(355915, "RemoveMagic", nil, nil, 1, 2)--Interrogation Specialist
local specWarnSparkBurn						= mod:NewSpecialWarningInterrupt(355930, false, nil, nil, 1, 2)--Interrogation Specialist (Spam cast, so opt in)
local specWarnRefractionShield				= mod:NewSpecialWarningDispel(355980, "MagicDispeller", nil, nil, 1, 2)--Support Officer
local specWarnHardLightBarrier				= mod:NewSpecialWarningInterrupt(355934, "HasInterrupt", nil, nil, 1, 2)--Support Officer
local specWarnRiftBlasts					= mod:NewSpecialWarningDodge(352390, nil, nil, nil, 2, 2)--Zo'honn
local specWarnHyperlightBolt				= mod:NewSpecialWarningInterrupt(354297, false, nil, 2, 1, 2)--Support Officer/Zo'honn (Spammy if interrupt off CD
local specWarnEmpoweredGlyphofRestraint		= mod:NewSpecialWarningInterrupt(356537, "HasInterrupt", nil, nil, 1, 2)--Zo'honn casts this on everyone
local specWarnLightshardRetreat				= mod:NewSpecialWarningDodge(357197, nil, nil, nil, 2, 2)--Lightshard Retreat
local specWarnChronolightEnhancer			= mod:NewSpecialWarningRun(357229, "Tank", nil, nil, 4, 2)--Cartel Muscle
local specWarnHyperlightBomb				= mod:NewSpecialWarningMoveAway(357029, nil, nil, nil, 1, 2)--Cartel Smuggler
local yellHyperlightBomb					= mod:NewYell(357029)--Cartel Smuggler
local yellHyperlightBombFades				= mod:NewShortFadesYell(357029)--Cartel Smuggler
local specWarnSpamFilter					= mod:NewSpecialWarningInterrupt(347775, "HasInterrupt", nil, nil, 1, 2)--Mailroom
local specWarnJunkMail						= mod:NewSpecialWarningInterrupt(347903, false, nil, nil, 1, 2)--Mailroom (is this also spammed, off just in case)
local specWarnCryofMrrggllrrgg				= mod:NewSpecialWarningInterrupt(355057, "HasInterrupt", nil, nil, 1, 2)--Shellcrusher
local specWarnWaterbolt						= mod:NewSpecialWarningInterrupt(355225, false, nil, nil, 1, 2)--Various Murlocs (filler cast, optional interrupt)
local specWarnInvigoratingFishStickCast		= mod:NewSpecialWarningSpell(355132, nil, nil, nil, 1, 3)--Off by default, optional for those with stuns/disorientations that can interrupt
local specWarnInvigoratingFishStick			= mod:NewSpecialWarningSwitch(355132, "-Healer", nil, nil, 1, 2)--Various Murlocs
local specWarnChargedPulse					= mod:NewSpecialWarningRun(355584, nil, nil, nil, 4, 2)--Stormforged Guardian
local specWarnDriftingStar					= mod:NewSpecialWarningDodge(357226, nil, nil, nil, 2, 2)--Adorned Starseer
local specWarnWanderingPulsar				= mod:NewSpecialWarningSwitch(357238, "-Healer", nil, nil, 1, 2)--Adorned Starseer
local specWarnUnstableRift					= mod:NewSpecialWarningInterrupt(357260, "HasInterrupt", nil, nil, 1, 2)--Focused Ritualist
local specWarnAncientDread					= mod:NewSpecialWarningInterrupt(356407, "HasInterrupt", nil, nil, 1, 2)--Ancient Core Hound
local specWarnAncientDreadDispel			= mod:NewSpecialWarningDispel(356407, "RemoveCurse", nil, nil, 1, 2)--Ancient Core Hound
local specWarnLavaBreath					= mod:NewSpecialWarningInterrupt(356404, "HasInterrupt", nil, nil, 1, 2)--Ancient Core Hound

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 356548 and self:IsValidWarning(args.sourceGUID) then
		warnRadiantPulse:Show()
	elseif spellId == 352390 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnRiftBlasts:Show()
		specWarnRiftBlasts:Play("watchstep")
	elseif spellId == 355900 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnDisruptionGrenade:Show()
		specWarnDisruptionGrenade:Play("watchstep")
	elseif spellId == 357197 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnLightshardRetreat:Show()
		specWarnLightshardRetreat:Play("watchstep")
	elseif spellId == 357226 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnDriftingStar:Show()
		specWarnDriftingStar:Play("watchorb")
	elseif spellId == 354297 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHyperlightBolt:Show(args.sourceName)
		specWarnHyperlightBolt:Play("kickcast")
	elseif spellId == 356537 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEmpoweredGlyphofRestraint:Show(args.sourceName)
		specWarnEmpoweredGlyphofRestraint:Play("kickcast")
	elseif spellId == 355888 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHardLightBaton:Show(args.sourceName)
		specWarnHardLightBaton:Play("kickcast")
	elseif spellId == 355930 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSparkBurn:Show(args.sourceName)
		specWarnSparkBurn:Play("kickcast")
	elseif spellId == 355934 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHardLightBarrier:Show(args.sourceName)
		specWarnHardLightBarrier:Play("kickcast")
	elseif spellId == 347775 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSpamFilter:Show(args.sourceName)
		specWarnSpamFilter:Play("kickcast")
	elseif spellId == 347903 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnJunkMail:Show(args.sourceName)
		specWarnJunkMail:Play("kickcast")
	elseif spellId == 355057 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCryofMrrggllrrgg:Show(args.sourceName)
		specWarnCryofMrrggllrrgg:Play("kickcast")
	elseif spellId == 355225 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWaterbolt:Show(args.sourceName)
		specWarnWaterbolt:Play("kickcast")
	elseif spellId == 357260 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnstableRift:Show(args.sourceName)
		specWarnUnstableRift:Play("kickcast")
	elseif spellId == 356407 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAncientDread:Show(args.sourceName)
		specWarnAncientDread:Play("kickcast")
	elseif spellId == 356404 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnLavaBreath:Show(args.sourceName)
		specWarnLavaBreath:Play("kickcast")
	elseif spellId == 356001 and self:IsValidWarning(args.sourceGUID) then
		warnBeamSplicer:Show()
	elseif spellId == 357229 and self:IsValidWarning(args.sourceGUID) then
		warnChronolightEnhancer:Show()
	elseif spellId == 355234 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 6) then--Misc flagged because it can be interrupted or dodged and guide didn't emphasize either was super important
		warnVolatilePufferfish:Show()
	elseif spellId == 355132 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 5) then
		specWarnInvigoratingFishStickCast:Show()
		specWarnInvigoratingFishStickCast:Play("crowdcontrol")
	elseif spellId == 355584 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 1) then
		specWarnChargedPulse:Show()
		specWarnChargedPulse:Play("justrun")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 357238 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 5) then
		specWarnWanderingPulsar:Show()
		specWarnWanderingPulsar:Play("targetchange")
	end
end

function mod:SPELL_SUMMON(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 355132 and self:IsValidWarning(args.sourceGUID) then
		specWarnInvigoratingFishStick:Show()
		specWarnInvigoratingFishStick:Play("attacktotem")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 355888 and self:IsValidWarning(args.sourceGUID) then
		warnHardLightBaton:Show(args.destName)
	elseif spellId == 355915 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnGlyphofRestraint:Show(args.destName)
		specWarnGlyphofRestraint:Play("helpdispel")
	elseif spellId == 355980 and self:IsValidWarning(args.sourceGUID) and not args:IsDestTypePlayer() and self:AntiSpam(3, 5) then
		specWarnRefractionShield:Show(args.destName)
		specWarnRefractionShield:Play("helpdispel")
	elseif spellId == 356407 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnAncientDreadDispel:Show(args.destName)
		specWarnAncientDreadDispel:Play("helpdispel")
	elseif spellId == 357229 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 1) then
		specWarnChronolightEnhancer:Show()
		specWarnChronolightEnhancer:Play("justrun")
	elseif spellId == 357029 then
		if args:IsPlayer() then
			specWarnHyperlightBomb:Show()
			specWarnHyperlightBomb:Play("runout")
			yellHyperlightBomb:Yell()
			yellHyperlightBombFades:Countdown(spellId)
		else
			warnHyperlightBomb:Show(args.destName)
		end
	elseif spellId == 355581 and args:IsPlayer() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 357029 and args:IsPlayer() then
		yellHyperlightBombFades:Cancel()
	end
end

