local mod	= DBM:NewMod("SanguineDepthsTrash", "DBM-Party-Shadowlands", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 320991 321038 324103 326827 328170",
	"SPELL_CAST_SUCCESS 324086",
	"SPELL_AURA_APPLIED 334673 321038 324089 324086",
	"SPELL_AURA_REMOVED 326827"
)

--https://www.wowhead.com/guides/sanguine-depths-shadowlands-dungeon-strategy-guide
--TODO, verify echoing thrust actually targets only tank, and that it can be side stepped
--TODO, more trash warnings? this is all that was in guide
--General
local warnZralisEssence						= mod:NewTargetNoFilterAnnounce(324089, 1)
local warnShiningRadiance					= mod:NewTargetNoFilterAnnounce(324086, 1)
local warnDreadBindings						= mod:NewFadesAnnounce(326827, 1)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Kryxis Trash
local specWarnSanctifiedMists				= mod:NewSpecialWarningMove(334673, "Tank", nil, nil, 1, 10)
local specWarnEchoingThrust					= mod:NewSpecialWarningDodge(320991, "Tank", nil, nil, 1, 2)
--Notable Grand Proctor Berylli
local specWarnWrackSoul						= mod:NewSpecialWarningInterrupt(321038, "HasInterrupt", nil, nil, 1, 2)
local specWarnWrackSoulDispel				= mod:NewSpecialWarningDispel(321038, "RemoveMagic", nil, nil, 1, 2)
--Notable General Kaal Trash
local specWarnGloomSquall					= mod:NewSpecialWarningMoveTo(324103, nil, nil, nil, 3, 2)--Boss version, trash version is 322903
local yellShiningRadiance					= mod:NewYell(324086, nil, nil, nil, "YELL")
--Unknown, user request
local specWarnDreadBindings					= mod:NewSpecialWarningRun(326827, nil, nil, nil, 4, 2)
local specWarnCraggyFracture				= mod:NewSpecialWarningDodge(328170, nil, nil, nil, 2, 2)

--local timerShiningRadiance					= mod:NewCDTimer(35, 324086, nil, nil, nil, 5)

local shelter = DBM:GetSpellInfo(324086)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 320991 and self:AntiSpam(3, 2) then
		specWarnEchoingThrust:Show()
		specWarnEchoingThrust:Play("shockwave")
	elseif spellId == 321038 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWrackSoul:Show(args.sourceName)
		specWarnWrackSoul:Play("kickcast")
	elseif spellId == 324103 then
		specWarnGloomSquall:Show(shelter)
		specWarnGloomSquall:Play("findshelter")
	elseif spellId == 326827 then
		specWarnDreadBindings:Show()
		specWarnDreadBindings:Play("justrun")
	elseif spellId == 328170 and self:AntiSpam(3, 2) then
		specWarnCraggyFracture:Show()
		specWarnCraggyFracture:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 324086 then
		warnShiningRadiance:Show(args.sourceName)
--		timerShiningRadiance:Start()
		if args:IsPlayerSource() then
			yellShiningRadiance:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 334673 and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnSanctifiedMists:Show()
		specWarnSanctifiedMists:Play("mobout")
	elseif spellId == 321038 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnWrackSoulDispel:Show(args.destName)
		specWarnWrackSoulDispel:Play("helpdispel")
	elseif spellId == 324089 then
		warnZralisEssence:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 326827 and args:IsPlayer() then
		warnDreadBindings:Show()
	end
end
