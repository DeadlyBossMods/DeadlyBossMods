local mod	= DBM:NewMod(965, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75964)
mod:SetEncounterID(1698)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153544 156793 153315",
	"SPELL_CAST_SUCCESS 165731",
	"SPELL_PERIODIC_DAMAGE 154043",
	"SPELL_ABSORBED 154043",
	"RAID_BOSS_EMOTE"
)

local warnSpinningBlade		= mod:NewSpellAnnounce(153544, 3)
local warnFourWinds			= mod:NewSpellAnnounce(156793, 4)
local warnWindFall			= mod:NewSpellAnnounce(153315, 2)
local warnPiercingRush		= mod:NewTargetAnnounce(165731, 2)--EJ shows tank warning but in my encounter it could target anyone. If this changes I'll tweak the default to tank/healer
local warnLensFlare			= mod:NewSpellAnnounce(154043, 3)

local specWarnSpinningBlade	= mod:NewSpecialWarningSpell(153544, false, nil, nil, 2)
local specWarnFourWinds		= mod:NewSpecialWarningSpell(156793, nil, nil, nil, 2)
local specWarnLensFlareCast	= mod:NewSpecialWarningSpell(154043, nil, nil, nil, 2)
local specWarnLensFlare		= mod:NewSpecialWarningMove(154043)

local timerFourWinds		= mod:NewBuffActiveTimer(18, 156793)
local timerFourWindsCD		= mod:NewCDTimer(30, 156793)

local voiceFourWinds		= mod:NewVoice(156793)
local voiceLensFlare		= mod:NewVoice(154043)

local skyTrashMod = DBM:GetModByName("SkyreachTrash")

function mod:OnCombatStart(delay)
	timerFourWindsCD:Start(-delay)
	if skyTrashMod.Options.RangeFrame and skyTrashMod.vb.debuffCount ~= 0 then--In case of bug where range frame gets stuck open from trash pulls before this boss.
		skyTrashMod.vb.debuffCount = 0--Fix variable
		DBM.RangeCheck:Hide()--Close range frame.
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153544 then
		warnSpinningBlade:Show()
		specWarnSpinningBlade:Show()
	elseif spellId == 156793 then
		warnFourWinds:Show()
		specWarnFourWinds:Show()
		timerFourWinds:Start()
		timerFourWindsCD:Start()
		voiceFourWinds:Play("wwsoon")
	elseif spellId == 153315 then
		warnWindFall:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 165731 then
		warnPiercingRush:Show(args.destName)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	warnLensFlare:Show()
	specWarnLensFlareCast:Show()
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 154043 and destGUID == UnitGUID("player") and self:AntiSpam(2) then
		specWarnLensFlare:Show()
		voiceLensFlare:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
