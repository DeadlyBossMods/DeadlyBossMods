local mod	= DBM:NewMod("AberrusTrash", "DBM-Aberrus", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 409612",
	"SPELL_AURA_APPLIED 411808",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 411808"
)

--TODO, icon mark shared suffering? Maybe when they fix ENCOUNTER_START, for now I don't want to risk trash mod messing with a boss mods icon marking
--Lady's Trash, minus bottled anima, which will need a unit event to detect it looks like
local warnSlimeInjection					= mod:NewTargetAnnounce(411808, 3)

local specWarnUmbralTorrent					= mod:NewSpecialWarningDodge(409612, nil, nil, nil, 2, 2)
local specWarnSlimeInjection				= mod:NewSpecialWarningMoveAway(411808, nil, nil, nil, 1, 2)
local yellSlimeInjection					= mod:NewYell(411808)
local yellSlimeInjectionFades				= mod:NewShortFadesYell(411808)
--local specWarnSharedSuffering				= mod:NewSpecialWarningYou(339607, nil, nil, nil, 1, 2)
--local specWarnDirgefromBelow				= mod:NewSpecialWarningInterrupt(310839, "HasInterrupt", nil, nil, 1, 2)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 409612 and self:AntiSpam(5, 2) then
		specWarnUmbralTorrent:Show()
		specWarnUmbralTorrent:Play("watchorb")
	--elseif spellId == 310839 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
	--	specWarnDirgefromBelow:Show(args.sourceName)
	--	specWarnDirgefromBelow:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 411808 then
		warnSlimeInjection:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSlimeInjection:Show()
			specWarnSlimeInjection:Play("runout")
			yellSlimeInjection:Yell()
			yellSlimeInjectionFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 411808 and args:IsPlayer() then
		if args:IsPlayer() then
			yellSlimeInjectionFades:Cancel()
		end
	end
end
--]]
