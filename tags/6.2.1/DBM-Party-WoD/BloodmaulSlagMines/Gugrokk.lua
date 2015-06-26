local mod	= DBM:NewMod(889, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(74790)
mod:SetEncounterID(1654)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 150677 150784 150755",
	"SPELL_AURA_APPLIED 150678",
	"SPELL_PERIODIC_DAMAGE 150784",
	"SPELL_ABSORBED 150784"
)

--TODO, Add heroic ability "Flame Buffet"? Seems to just stack up over time and not really need warnings.
local warnMoltenBlast			= mod:NewCastAnnounce(150677, 4)
local warnUnstableSlag			= mod:NewSpellAnnounce(150677, 3)
local warnMagmaEruption			= mod:NewSpellAnnounce(150784, 3)
local warnMoltenCore			= mod:NewTargetAnnounce(150678, 2)

local specWarnMoltenBlast		= mod:NewSpecialWarningInterrupt(150677, "-Healer", nil, 2)
local specWarnUnstableSlag		= mod:NewSpecialWarningSwitch(150755, "Dps", nil, 2)
local specWarnMagmaEruptionCast	= mod:NewSpecialWarningSpell(150784, nil, nil, nil, 2)
local specWarnMagmaEruption		= mod:NewSpecialWarningMove(150784)
local specWarnMoltenCore		= mod:NewSpecialWarningDispel(150678, "MagicDispeller")

local timerMagmaEruptionCD		= mod:NewCDTimer(20, 150784)
local timerUnstableSlagCD		= mod:NewCDTimer(20, 150755)

local countdownUnstableSlag		= mod:NewCountdown(20, 150755)

local voiceMoltenBlast			= mod:NewVoice(150677, "-Healer")
local voiceUnstableSlag			= mod:NewVoice(150755, "Dps")
local voiceMagmaEruption		= mod:NewVoice(150784)
local voiceMoltenCore			= mod:NewVoice(150678, "MagicDispeller")

function mod:OnCombatStart(delay)
--	timerMagmaEruptionCD:Start(8-delay)--Poor sample size
	timerUnstableSlagCD:Start(-delay)--Also poor sample size but more likely to be correct.
	countdownUnstableSlag:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 150677 then
		warnMoltenBlast:Show()
		specWarnMoltenBlast:Show(args.sourceName)
		if self:IsTank() then
			voiceMoltenBlast:Play("kickcast")
		else
			voiceMoltenBlast:Play("helpkick")
		end
	elseif spellId == 150784 then
		warnMagmaEruption:Show()
		specWarnMagmaEruptionCast:Show()
		timerMagmaEruptionCD:Start()
	elseif spellId == 150755 then
		warnUnstableSlag:Show()
		specWarnUnstableSlag:Show()
		timerUnstableSlagCD:Start()
		countdownUnstableSlag:Start()
		voiceUnstableSlag:Play("mobkill")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 150678 and not args:IsDestTypePlayer() then
		if self.Options.SpecWarn150678dispel then
			specWarnMoltenCore:Show(args.destName)
		else
			warnMoltenCore:Show(args.destName)
		end
		voiceMoltenCore:Play("dispelboss")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 150784 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMagmaEruption:Show()
		voiceMagmaEruption:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
