local mod	= DBM:NewMod(887, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75786)
mod:SetEncounterID(1652)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153247 152940 152939",
	"SPELL_AURA_APPLIED 153227",
	"SPELL_PERIODIC_DAMAGE 153227",
	"SPELL_ABSORBED 153227"
)

local warnFieryBoulder			= mod:NewCountAnnounce(153247, 3)
local warnHeatWave				= mod:NewSpellAnnounce(152940, 3)
local warnBurningSlag			= mod:NewSpellAnnounce(152939, 3)

local specWarnFieryBoulder		= mod:NewSpecialWarningSpell(153247, nil, nil, 2, 2, 2)--Important to everyone
local specWarnHeatWave			= mod:NewSpecialWarningSpell(152940, false, nil, nil, 2, 2)
local specWarnBurningSlag		= mod:NewSpecialWarningSpell(152939, false, nil, nil, 2)
local specWarnBurningSlagFire	= mod:NewSpecialWarningMove(152939, nil, nil, nil, 2, 2)

local timerFieryBoulderCD		= mod:NewNextTimer(13.3, 153247, nil, nil, nil, 3)--13.3-13.4 Observed
local timerHeatWave				= mod:NewBuffActiveTimer(9.5, 152940)
local timerHeatWaveCD			= mod:NewNextTimer(9.5, 152940, nil, nil, nil, 2)--9.5-9.8 Observed
local timerBurningSlagCD		= mod:NewNextTimer(10.7, 152939, nil, nil, nil, 3)--10.7-11 Observed

local voiceFieryBoulder			= mod:NewVoice(153247)
local voiceHeatWave				= mod:NewVoice(152940)
local voiceBurningSlag			= mod:NewVoice(152939)

mod.vb.boulderCount = 0
mod.vb.burningSlagCast = false--More robust than using a really huge anti spam, because this will work with recovery, antispam won't

function mod:OnCombatStart(delay)
	self.vb.boulderCount = 0
	self.vb.burningSlagCast = false
	timerFieryBoulderCD:Start(8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153247 then--Boulder
		if self.vb.burningSlagCast then self.vb.burningSlagCast = false end
		self.vb.boulderCount = self.vb.boulderCount + 1
		warnFieryBoulder:Show(self.vb.boulderCount)
		specWarnFieryBoulder:Show()
		if self.vb.boulderCount == 1 then
			voiceFieryBoulder:Play("153247")
		end
		if self.vb.boulderCount == 3 then
			timerHeatWaveCD:Start()
			self.vb.boulderCount = 0
		else
			timerFieryBoulderCD:Start(3.5)--Not to be confused with cast timer, that's 3 seconds. The previous meteor WILL hit ground before next cast.
		end
	elseif spellId == 152940 then--Heat Wave
		warnHeatWave:Show()
		specWarnHeatWave:Show()
		timerHeatWave:Start()
		timerBurningSlagCD:Start()
		voiceHeatWave:Play("aesoon")
	elseif spellId == 152939 and not self.vb.burningSlagCast then--Burning Slag
		self.vb.burningSlagCast = true
		warnBurningSlag:Show()
		specWarnBurningSlag:Show()
		timerFieryBoulderCD:Start()
		--voiceBurningSlag:Play("firecircle") not proper voice. disable.
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 153227 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnBurningSlagFire:Show()
		voiceBurningSlag:Play("runaway")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153227 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBurningSlagFire:Show()
		voiceBurningSlag:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
