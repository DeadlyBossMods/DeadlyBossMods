local mod	= DBM:NewMod(1163, "DBM-Party-WoD", 3, 536)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79545)
mod:SetEncounterID(1732)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 160681 166570",
	"SPELL_AURA_APPLIED_DOSE 160681 166570",
	"SPELL_CAST_START 163550 160680 160943",
	"UNIT_TARGETABLE_CHANGED"
)

local warnMortar				= mod:NewSpellAnnounce(163550, 3)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnSupressiveFire		= mod:NewTargetAnnounce(160681, 2)--In a repeating loop
--local warnGrenadeDown			= mod:NewAnnounce("warnGrenadeDown", 1, "ej9711", nil, DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej9711"))--Boss is killed by looting using these positive items on him.
--local warnMortarDown			= mod:NewAnnounce("warnMortarDown", 4, "ej9712", nil, DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej9712"))--So warn when adds that drop them die
local warnShrapnelBlast			= mod:NewCastAnnounce(160943, 4)
local warnPhase3				= mod:NewPhaseAnnounce(3)

local specWarnSupressiveFire	= mod:NewSpecialWarningYou(160681)
local yellSupressiveFire		= mod:NewYell(160681)
local specWarnShrapnelblast		= mod:NewSpecialWarningMove(160943, mod:IsTank(), nil, nil, 3)--160943 boss version, 166675 trash version.
local specWarnSlagBlast			= mod:NewSpecialWarningMove(166570)

local timerSupressiveFire		= mod:NewTargetTimer(10, 160681)

local grenade = EJ_GetSectionInfo(9711)
local mortar = EJ_GetSectionInfo(9712)
mod.vb.phase = 1

function mod:SupressiveFireTarget(targetname, uId)
	if not targetname then return end
	warnSupressiveFire:Show(targetname)
	if targetname == UnitName("player") then
		specWarnSupressiveFire:Show()
		yellSupressiveFire:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 160681 and args:IsDestTypePlayer() then
		timerSupressiveFire:Start(args.destName)
	elseif spellId == 166570 and args.destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnSlagBlast:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 163550 then
		warnMortar:Show()
	elseif spellId == 160680 then
		self:BossTargetScanner(79548, "SupressiveFireTarget", 0.2, 15)
	elseif spellId == 160943 and self:AntiSpam(2, 1) then
		warnShrapnelBlast:Show()
		specWarnShrapnelblast:Show()
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	self.vb.phase = self.vb.phase + 1
	if self.vb.phase == 2 then
		warnPhase2:Show()
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
	end
end
