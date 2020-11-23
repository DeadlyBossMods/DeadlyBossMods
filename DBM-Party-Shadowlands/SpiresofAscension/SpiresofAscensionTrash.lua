local mod	= DBM:NewMod("SpiresofAscensionTrash", "DBM-Party-Shadowlands", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 317936 317963 327413 328295 328137 328331",
	"SPELL_AURA_APPLIED 317936 317963 317661 328331"
)

--https://www.wowhead.com/guides/spires-of-ascension-shadowlands-dungeon-strategy-guide
--local warnDuelistDash					= mod:NewTargetNoFilterAnnounce(274400, 4)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Kin-Tara Trash
local specWarnForswornDoctrine				= mod:NewSpecialWarningInterrupt(317936, "HasInterrupt", nil, nil, 1, 2)
local specWarnForswornDoctrineDispel		= mod:NewSpecialWarningDispel(317936, "MagicDispeller", nil, nil, 1, 2)
local specWarnBurdenofKnowledge				= mod:NewSpecialWarningInterrupt(317963, "HasInterrupt", nil, nil, 1, 2)
local specWarnBurdenofKnowledgeDispel		= mod:NewSpecialWarningDispel(317963, "RemoveMagic", nil, nil, 1, 2)
local specWarnRebelliousFist				= mod:NewSpecialWarningInterrupt(327413, "HasInterrupt", nil, nil, 1, 2)
--Notable Ventunax Trash
local specWarnInsidiousVenomDispel			= mod:NewSpecialWarningDispel(317661, "RemoveMagic", nil, nil, 1, 2)
--Notable Oryphrion Trash
local specWarnGreaterMending				= mod:NewSpecialWarningInterrupt(328295, "HasInterrupt", nil, nil, 1, 2)
local specWarnDarkPulse						= mod:NewSpecialWarningInterrupt(328137, "HasInterrupt", nil, nil, 1, 2)
local specWarnForcedConfession				= mod:NewSpecialWarningInterrupt(328331, "HasInterrupt", nil, nil, 1, 2)
local specWarnForcedConfessionDispel		= mod:NewSpecialWarningDispel(328331, "RemoveMagic", nil, nil, 1, 2)
local specWarnForcedConfessionYou			= mod:NewSpecialWarningMoveAway(328331, nil, nil, nil, 1, 2)
local yellForcedConfession					= mod:NewYell(328331)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 317936 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnForswornDoctrine:Show(args.sourceName)
		specWarnForswornDoctrine:Play("kickcast")
	elseif spellId == 317963 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBurdenofKnowledge:Show(args.sourceName)
		specWarnBurdenofKnowledge:Play("kickcast")
	elseif spellId == 327413 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRebelliousFist:Show(args.sourceName)
		specWarnRebelliousFist:Play("kickcast")
	elseif spellId == 328295 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGreaterMending:Show(args.sourceName)
		specWarnGreaterMending:Play("kickcast")
	elseif spellId == 328137 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDarkPulse:Show(args.sourceName)
		specWarnDarkPulse:Play("kickcast")
	elseif spellId == 328331 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnForcedConfession:Show(args.sourceName)
		specWarnForcedConfession:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 317936 and self:AntiSpam(3, 5) then
		specWarnForswornDoctrineDispel:Show(args.destName)
		specWarnForswornDoctrineDispel:Play("helpdispel")
	elseif spellId == 317963 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnBurdenofKnowledgeDispel:Show(args.destName)
		specWarnBurdenofKnowledgeDispel:Play("helpdispel")
	elseif spellId == 317661 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnInsidiousVenomDispel:Show(args.destName)
		specWarnInsidiousVenomDispel:Play("helpdispel")
	elseif spellId == 328331 then
		local dispelWarned = false
		if self.Options.SpecWarn328331dispel and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
			specWarnForcedConfessionDispel:Show(args.destName)
			specWarnForcedConfessionDispel:Play("helpdispel")
			dispelWarned = true
		end
		if args:IsPlayer() then
			if not dispelWarned then--If player is a dispeller, they may have already gotten alert to dispel themselves
				specWarnForcedConfessionYou:Show()
				specWarnForcedConfessionYou:Play("runout")
			end
			yellForcedConfession:Yell()
		end
	end
end
