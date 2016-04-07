local mod	= DBM:NewMod(1706, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102263)
mod:SetEncounterID(1849)
mod:DisableESCombatDetection()--Remove if blizz fixes trash firing ENCOUNTER_START
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 204275 204372 204316 204471",
	"SPELL_SUMMON 204292",
	"SPELL_AURA_APPLIED 204531 204459 204697",
	"SPELL_AURA_REMOVED 204459 204697"
)

--TODO, boss still gains energy during vulnerable but I didn't really see enough data yet to determine if I should do anything special with timers
--I believe he'll just use whatever abilities he's ready to use after his stun is gone. So maybe just extend timers that expire during stun, or just leave be.
local warnBrokenShard				= mod:NewSpellAnnounce(204292, 2, nil, false)
local warnVulnerable				= mod:NewTargetAnnounce(204459, 1)
local warnCallScorp					= mod:NewSpellAnnounce(204372, 3)

local specWarnTether				= mod:NewSpecialWarningYou(204531, nil, nil, nil, 1, 2)
local specWarnArcanoslash			= mod:NewSpecialWarningDefensive(204275, "Tank", nil, nil, 1, 2)
local specWarnCallofScorp			= mod:NewSpecialWarningSwitch(204372, "Tank", nil, nil, 1, 2)--Determine common strat for dps switching
local specWarnNetherDischarge		= mod:NewSpecialWarningDodge(204471, nil, nil, nil, 2, 2)
local specWarnShockwave				= mod:NewSpecialWarningMoveTo(204316, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(158986), nil, 3, 2)
local specWarnVulnerableStarted		= mod:NewSpecialWarningSwitch(204459, false, nil, nil, 1)
local specWarnVulnerableOver		= mod:NewSpecialWarningEnd(204459, false, nil, nil, 1)--Special warning because anything that came off cd during stun, is being cast immediately

local timerArcanoslashCD			= mod:NewCDTimer(10, 204275, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCallofScorpidCD			= mod:NewCDTimer(18.2, 204372, nil, nil, nil, 1)--18-20 Unless delayed by shockwave then as high as 28-29
local timerShockwaveCD				= mod:NewCDTimer(58.3, 204316, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--58-60
local timerNetherDischargeCD		= mod:NewCDTimer(30.3, 204471, nil, nil, nil, 3)--30-34
local timerVulnerable				= mod:NewBuffFadesTimer(15, 204459, nil, nil, nil, 6)

local countdownShockwave			= mod:NewCountdown(58.3, 204316)
local countdownNetherDischarge		= mod:NewCountdown("Alt30.3", 204471)

local voiceTether					= mod:NewVoice(204531)-- "180880" for "break chain"
local voiceArcanoslash				= mod:NewVoice(204275, "Tank")--defensive
local voiceCallScorp				= mod:NewVoice(204372)--killmob
local voiceShockwave				= mod:NewVoice(204316)--findshelter/safenow
local voiceNetherDischarge			= mod:NewVoice(204471)--"watchstep". "shockwave" makes more sense, but may confuse users because boss has an actual ability called "shockwave"

--mod:AddRangeFrameOption(10, 204531)
mod:AddSetIconOption("SetIconOnVolatileScorpion", 204697, true, true)
--mod:AddHudMapOption("HudMapOnMC", 163472)

mod.vb.volatileScorpCount = 0

local shardName = GetSpellInfo(204292)

function mod:OnCombatStart(delay)
	self.vb.volatileScorpCount = 0
	timerArcanoslashCD:Start(5-delay)
	timerNetherDischargeCD:Start(13-delay)
	countdownNetherDischarge:Start(13-delay)
	timerCallofScorpidCD:Start(20.5-delay)
	timerShockwaveCD:Start(57-delay)
	countdownShockwave:Start(57-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 204275 and self:AntiSpam(5, 1) then
		specWarnArcanoslash:Show()
		voiceArcanoslash:Play("defensive")
		timerArcanoslashCD:Start()
	elseif spellId == 204372 then
		timerCallofScorpidCD:Start()
		if self.Options.SpecWarn204372switch and self:AntiSpam(3.5, 2) then--Even if enabled, only special warn once every 3.5 seconds
			specWarnCallofScorp:Show()
			voiceCallScorp:Play("killmob")
		else
			warnCallScorp:Show()
		end
	elseif spellId == 204316 then
		specWarnShockwave:Show(shardName)
		voiceShockwave:Play("findshelter")
		voiceShockwave:Cancel()--In case boss stutter cases or starts cast over
		voiceShockwave:Schedule(3.5, "safenow")
		timerShockwaveCD:Start()
		countdownShockwave:Start()
		local elapsed, total = timerCallofScorpidCD:GetTime()
		local remaining = total - elapsed
		if remaining < 11 then--delayed by shockwave
			timerCallofScorpidCD:Stop()
			if total == 0 then--Just in case timer expired just before cast
				DBM:Debug("experimental timer extend firing for call of scorpid. Extend amount: "..11)
				timerCallofScorpidCD:Start(11)
			else
				local extend = 11 - remaining
				DBM:Debug("experimental timer extend firing for call of scorpid. Extend amount: "..extend)
				timerCallofScorpidCD:Update(elapsed, total+extend)
			end
		end
	elseif spellId == 204471 then
		specWarnNetherDischarge:Show()
		voiceNetherDischarge:Play("watchstep")
		timerNetherDischargeCD:Start()
		countdownNetherDischarge:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 204292 then
		warnBrokenShard:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204531 then
		if args:IsPlayer() then
			specWarnTether:Show()
			voiceTether:Play("180880")
		end
	elseif spellId == 204459 then
		if self.Options.SpecWarn204459switch then
			specWarnVulnerableStarted:Show()
		else
			warnVulnerable:Show(args.destName)
		end
		timerVulnerable:Start()
	elseif spellId == 204697 then--Red scorpion
		if self.Options.SpecWarn204372switch and self:AntiSpam(3.5, 2) then--Even if enabled, only special warn once every 3.5 seconds
			specWarnCallofScorp:Show()
			voiceCallScorp:Play("killmob")
		else
			warnCallScorp:Show()
		end
		self.vb.volatileScorpCount = self.vb.volatileScorpCount + 1
		if self.Options.SetIconOnVolatileScorpion then
			local icon = 9 - self.vb.volatileScorpCount
			self:ScanForMobs(args.destGUID, 0, icon, 1, 0.1, 10, "SetIconOnVolatileScorpion")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 204459 then
		specWarnVulnerableOver:Show()
	elseif spellId == 204697 then--Red scorpion
		self.vb.volatileScorpCount = self.vb.volatileScorpCount - 1
	end
end
