local mod	= DBM:NewMod("DeOtherSideTrash", "DBM-Party-Shadowlands", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 334051 342869 333787 332671 332666 332706 332612 331927 332156 332084 340026",
	"SPELL_AURA_APPLIED 333227 332666 334493",
	"SPELL_AURA_REMOVED 333227"
)

--All warnings/recommendations drycoded from https://www.wowhead.com/guides/de-other-side-shadowlands-dungeon-strategy-guide
--Notable Ring Trash
local warnUndyingRage					= mod:NewTargetNoFilterAnnounce(333227, 4, nil, "Tank|Healer")
local warnEnragedMask					= mod:NewSpellAnnounce(342869, 2)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Ring Trash
local specWarnEruptingDarkness			= mod:NewSpecialWarningDodge(334051, nil, nil, nil, 2, 2)
local specWarnRage						= mod:NewSpecialWarningSpell(333787, "Healer", nil, nil, 2, 2)
local specWarnUndyingRage				= mod:NewSpecialWarningDispel(333227, "RemoveEnrage", nil, nil, 1, 2)
--Notable Hakkar Trash
local specWarnBladestorm				= mod:NewSpecialWarningRun(332671, "Melee", nil, nil, 2, 2)
local specWarnRenew						= mod:NewSpecialWarningInterrupt(332666, "HasInterrupt", nil, nil, 1, 2)
local specWarnRenewDispel				= mod:NewSpecialWarningDispel(332666, "MagicDispeller", nil, nil, 1, 2)
local specWarnHeal						= mod:NewSpecialWarningInterrupt(332706, "HasInterrupt", nil, nil, 1, 2)
local specWarnHealingwave				= mod:NewSpecialWarningInterrupt(332612, "HasInterrupt", nil, nil, 1, 2)
--Notable The Manastorms Trash
local specWarnHaywire					= mod:NewSpecialWarningMoveTo(331927, nil, nil, nil, 2, 2)
local specWarnSpinningUp				= mod:NewSpecialWarningRun(332156, "Melee", nil, nil, 2, 2)
local specWarnSelfCleaningCycle			= mod:NewSpecialWarningInterrupt(332084, "HasInterrupt", nil, nil, 1, 2)
--Notable Dealer Xy'exa Trash
local specWarnSporificShimmerdust		= mod:NewSpecialWarningJump(334493, nil, nil, nil, 1, 6)
local specWarnWailingGrief				= mod:NewSpecialWarningSpell(340026, nil, nil, nil, 2, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 generalized

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 334051 and self:AntiSpam(3, 2) then
		specWarnEruptingDarkness:Show()
		specWarnEruptingDarkness:Play("shockwave")
	elseif spellId == 342869 and self:AntiSpam(3, 6) then
		warnEnragedMask:Show()
	elseif spellId == 333787 and self:AntiSpam(5, 5) then
		specWarnRage:Show()
		specWarnRage:Play("aesoon")
	elseif spellId == 332671 and self:AntiSpam(5, 1) then
		specWarnBladestorm:Show()
		specWarnBladestorm:Play("justrun")
	elseif spellId == 332666 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRenew:Show(args.sourceName)
		specWarnRenew:Play("kickcast")
	elseif spellId == 332706 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	elseif spellId == 332612 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingwave:Show(args.sourceName)
		specWarnHealingwave:Play("kickcast")
	elseif spellId == 332084 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSelfCleaningCycle:Show(args.sourceName)
		specWarnSelfCleaningCycle:Play("kickcast")
	elseif spellId == 331927 and self:AntiSpam(4, 2) then
		specWarnHaywire:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnHaywire:Play("findshelter")
	elseif spellId == 332156 and self:AntiSpam(5, 1) then
		specWarnSpinningUp:Show()
		specWarnSpinningUp:Play("justrun")
	elseif spellId == 340026 then
		specWarnWailingGrief:Show()
		specWarnWailingGrief:Play("fearsoon")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 333227 and self:AntiSpam(3, 5) then
		if self.Options.SpecWarn333227dispel then
			specWarnUndyingRage:Show(args.destName)
			specWarnUndyingRage:Play("enrage")
		else
			warnUndyingRage:Show(args.destName)
		end
	elseif spellId == 332666 and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnRenewDispel:Show(args.destName)
		specWarnRenewDispel:Play("helpdispel")
	elseif spellId == 334493 and args:IsPlayer() then
		specWarnSporificShimmerdust:Show()
		specWarnSporificShimmerdust:Play("keepjump")
	end
end
