local mod	= DBM:NewMod("TheaterofPainTrash", "DBM-Party-Shadowlands", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 341902 341969 330614 342139 333861 330562 333294",
	"SPELL_CAST_SUCCESS 330810",
	"SPELL_AURA_APPLIED 341902 333241"
)

--TODO, verify https://shadowlands.wowhead.com/spell=333861/ricocheting-blade target scanning
--https://www.wowhead.com/guides/theater-of-pain-shadowlands-dungeon-strategy-guide
local warnRicochetingBlade					= mod:NewTargetNoFilterAnnounce(333861, 4)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Affront of Challengers Trash
local specWarnUnholyFervor					= mod:NewSpecialWarningInterrupt(341902, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnholyFervorDispel			= mod:NewSpecialWarningDispel(341902, "MagicDispeller", nil, nil, 1, 2)
local specWarnRagingTantrumDispel			= mod:NewSpecialWarningDispel(333241, "RemoveEnrage", nil, nil, 1, 2)
--Notable Gorechop Trash
local specWarnWitheringDischarge			= mod:NewSpecialWarningInterrupt(341969, "HasInterrupt", nil, nil, 1, 2)
local specWarnVileEruption					= mod:NewSpecialWarningDodge(330614, nil, nil, nil, 2, 2)
--Notable Xav the Unfallen Trash
local specWarnBattleTrance					= mod:NewSpecialWarningInterrupt(342139, "HasInterrupt", nil, nil, 1, 2)
local specWarnRicochetingBlade				= mod:NewSpecialWarningMoveAway(333861, nil, nil, nil, 1, 2)
local yellRicochetingBlade					= mod:NewYell(333861)
local specWarnDemoralizingShout				= mod:NewSpecialWarningInterrupt(330562, "HasInterrupt", nil, nil, 1, 2)
--Notable Kul'tharok Trash
local specWarnBindSoul						= mod:NewSpecialWarningInterrupt(330810, "HasInterrupt", nil, nil, 1, 2)
local specWarnDeathWinds					= mod:NewSpecialWarningDodge(333294, nil, nil, nil, 2, 2)--Maybe change to airhorn?
--Other trash that apparently wasn't notable enough for guide
local specWarnBoneSpikes					= mod:NewSpecialWarningDodge(331237, nil, nil, nil, 2, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:RicochetingTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnRicochetingBlade:Show()
		specWarnRicochetingBlade:Play("runout")
		yellRicochetingBlade:Yell()
	else
		warnRicochetingBlade:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 341902 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnholyFervor:Show(args.sourceName)
		specWarnUnholyFervor:Play("kickcast")
	elseif spellId == 341969 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWitheringDischarge:Show(args.sourceName)
		specWarnWitheringDischarge:Play("kickcast")
	elseif spellId == 342139 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBattleTrance:Show(args.sourceName)
		specWarnBattleTrance:Play("kickcast")
	elseif spellId == 330562 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDemoralizingShout:Show(args.sourceName)
		specWarnDemoralizingShout:Play("kickcast")
	elseif spellId == 330614 and self:AntiSpam(3, 2) then
		specWarnVileEruption:Show()
		specWarnVileEruption:Play("watchstep")
	elseif spellId == 333294 and self:AntiSpam(3, 2) then
		specWarnDeathWinds:Show()
		specWarnDeathWinds:Play("watchstep")
	elseif spellId == 331237 and self:AntiSpam(3, 2) then
		specWarnBoneSpikes:Show()
		specWarnBoneSpikes:Play("watchstep")
	elseif spellId == 333861 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 330810 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBindSoul:Show(args.sourceName)
		specWarnBindSoul:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 341902 and self:AntiSpam(3, 5) then
		specWarnUnholyFervorDispel:Show(args.destName)
		specWarnUnholyFervorDispel:Play("helpdispel")
	elseif spellId == 333241 and self:AntiSpam(3, 5) then
		specWarnRagingTantrumDispel:Show(args.destName)
		specWarnRagingTantrumDispel:Play("enrage")
--	elseif spellId == 258323 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
--		specWarnBestialWrath:Show(args.destName)
--		specWarnBestialWrath:Play("helpdispel")
	end
end
