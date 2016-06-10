local mod	= DBM:NewMod(1160, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76407)
mod:SetEncounterID(1682)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154442",
	"SPELL_SUMMON 154350",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnRitualOfBones			= mod:NewSpellAnnounce(154671, 4)
local warnOmenOfDeath			= mod:NewTargetAnnounce(154350, 3)
local warnMalevolence			= mod:NewSpellAnnounce(154442, 3, nil, nil, 2)--Some tank has terrible move. May need everyone

local specWarnRitualOfBones		= mod:NewSpecialWarningSpell(154671, nil, nil, nil, 2)
local specWarnOmenOfDeath		= mod:NewSpecialWarningMove(154350)
local specWarnOmenOfDeathNear	= mod:NewSpecialWarningClose(154350)
local yellOmenOfDeath			= mod:NewYell(154350)
local specWarnMalevolence		= mod:NewSpecialWarningDodge(154442, nil, nil, nil, 2, 2)

local timerRitualOfBonesCD		= mod:NewCDTimer(50.5, 154671, nil, nil, nil, 1, DBM_CORE_DAMAGE_ICON)
local timerOmenOfDeathCD		= mod:NewCDTimer(10.5, 154350, nil, nil, nil, 3)

local voiceRitualOfBones		= mod:NewVoice(154671)
local voiceOmenOfDeath			= mod:NewVoice(154350)
local voiceMalevolence			= mod:NewVoice(154442)

function mod:OmenOfDeathTarget(targetname, uId)
	if not targetname then return end
	warnOmenOfDeath:Show(targetname)
	if targetname == UnitName("player") then
		specWarnOmenOfDeath:Show()
		yellOmenOfDeath:Yell()
		voiceOmenOfDeath:Play("runaway")
	elseif self:CheckNearby(8, targetname) then
		specWarnOmenOfDeathNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	--timerOmenOfDeathCD:Start(8.5-delay)
	timerRitualOfBonesCD:Start(20-delay)
	voiceRitualOfBones:Schedule(18-delay, "specialsoon")
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 154442 then
		warnMalevolence:Show()
		specWarnMalevolence:Show()
		voiceMalevolence:Play("shockwave")
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 154350 then
		self:BossTargetScanner(76407, "OmenOfDeathTarget", 0.04, 15)
		timerOmenOfDeathCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 154671 then
		warnRitualOfBones:Show()
		specWarnRitualOfBones:Show()
		timerRitualOfBonesCD:Start()
		voiceRitualOfBones:Schedule(48.5, "specialsoon")
	end
end
