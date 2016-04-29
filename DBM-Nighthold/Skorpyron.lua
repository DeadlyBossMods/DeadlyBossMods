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
	"SPELL_AURA_APPLIED 204531 204459 204697 204744",
	"SPELL_AURA_REMOVED 204459 204697",
	"SPELL_PERIODIC_DAMAGE 204744",
	"SPELL_PERIODIC_MISSED 204744",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_INTERRUPTED boss1"
)

--TODO, Mythic Transform casts still push timers back by 3-6 seconds. timer correction gets even more tedius with that so feeling lazy about that for now.
--I believe he'll just use whatever abilities he's ready to use after his stun is gone. So maybe just extend timers that expire during stun, or just leave be.
local warnBrokenShard				= mod:NewSpellAnnounce(204292, 2, nil, false)
local warnVulnerable				= mod:NewTargetAnnounce(204459, 1)
local warnCallScorp					= mod:NewSpellAnnounce(204372, 3)

local specWarnTether				= mod:NewSpecialWarningYou(204531, nil, nil, nil, 1, 2)
local specWarnArcanoslash			= mod:NewSpecialWarningDefensive(204275, "Tank", nil, nil, 1, 2)
local specWarnCallofScorp			= mod:NewSpecialWarningSwitch(204372, "Tank", nil, nil, 1, 2)--Determine common strat for dps switching
local specWarnFocusedBlast			= mod:NewSpecialWarningDodge(204471, nil, nil, nil, 2, 2)
local specWarnShockwave				= mod:NewSpecialWarningMoveTo(204316, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(158986), nil, 3, 2)
local specWarnVulnerableStarted		= mod:NewSpecialWarningSwitch(204459, false, nil, nil, 1)
local specWarnVulnerableOver		= mod:NewSpecialWarningEnd(204459, false, nil, nil, 1)--Special warning because anything that came off cd during stun, is being cast immediately
local specWarnToxicChit				= mod:NewSpecialWarningMove(204744, nil, nil, nil, 1, 2)

local timerArcanoslashCD			= mod:NewCDTimer(10, 204275, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCallofScorpidCD			= mod:NewCDTimer(20.3, 204372, nil, nil, nil, 1)--20-22 Unless delayed by shockwave/stun then as high as 40
local timerShockwaveCD				= mod:NewCDTimer(57.9, 204316, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--58-60
local timerFocusedBlastCD			= mod:NewCDTimer(30.4, 204471, nil, nil, nil, 3)--30-34
local timerVulnerable				= mod:NewBuffFadesTimer(15, 204459, nil, nil, nil, 6)
--These are all 46 unless delayed by shockwave or stun
local timerVolatileFragments		= mod:NewCDTimer(46, 214661, nil, nil, nil, 6)
local timerAcidicFragments			= mod:NewCDTimer(46, 214652, nil, nil, nil, 6)
local timerCrystallineFragments		= mod:NewCDTimer(46, 204292, nil, nil, nil, 6)

local countdownShockwave			= mod:NewCountdown(58.3, 204316)
local countdownCallofScorpid		= mod:NewCountdown("Alt20", 204372)
local countdownFocusedBlast			= mod:NewCountdown("AltTwo30.4", 204471)

local voiceTether					= mod:NewVoice(204531)-- "180880" for "break chain"
local voiceArcanoslash				= mod:NewVoice(204275, "Tank")--defensive
local voiceCallScorp				= mod:NewVoice(204372)--killmob
local voiceShockwave				= mod:NewVoice(204316)--findshelter/safenow
local voiceFocusedBlast				= mod:NewVoice(204471)--"watchstep". "shockwave" makes more sense, but may confuse users because boss has an actual ability called "shockwave"
local voiceToxicChit				= mod:NewVoice(204744)--runaway

mod:AddSetIconOption("SetIconOnVolatileScorpion", 204697, true, true)

mod.vb.volatileScorpCount = 0

local shardName = GetSpellInfo(204292)

function mod:OnCombatStart(delay)
	self.vb.volatileScorpCount = 0
	timerArcanoslashCD:Start(5-delay)
	timerFocusedBlastCD:Start(13-delay)
	countdownFocusedBlast:Start(13-delay)
	timerCallofScorpidCD:Start(-delay)
	countdownCallofScorpid:Start()
	timerShockwaveCD:Start(56.2-delay)
	countdownShockwave:Start(56.2-delay)
	if self:IsMythic() then
		timerVolatileFragments:Start(35-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 204275 and self:AntiSpam(5, 1) then
		specWarnArcanoslash:Show()
		voiceArcanoslash:Play("defensive")
		timerArcanoslashCD:Start()
	elseif spellId == 204372 then
		timerCallofScorpidCD:Start()
		countdownCallofScorpid:Start()
		if self.Options.SpecWarn204372switch and self:AntiSpam(3.5, 2) then--Even if enabled, only special warn once every 3.5 seconds
			specWarnCallofScorp:Show()
			voiceCallScorp:Play("killmob")
		else
			warnCallScorp:Show()
		end
	elseif spellId == 204316 then
		specWarnShockwave:Show(shardName)
		voiceShockwave:Play("findshelter")
		--voiceShockwave:Cancel()--In case boss stutter cases or starts cast over
		--voiceShockwave:Schedule(3.5, "safenow")
		timerShockwaveCD:Start()
		countdownShockwave:Start()
		local scorptAdjust = 11
		local blastElapsed, blastTotal = timerFocusedBlastCD:GetTime()
		local blastRemaining = blastTotal - blastElapsed
		if blastRemaining < 11 then--delayed by shockwave
			scorptAdjust = 14--Blast will always come before scorpid, if blast takes 11 second spot, scorpid is pushed to 14sec spot
			timerFocusedBlastCD:Stop()
			countdownFocusedBlast:Cancel()
			countdownFocusedBlast:Start(11)
			if blastTotal == 0 then--Just in case timer expired just before cast
				DBM:Debug("experimental timer extend firing for Focused Blast. Extend amount: "..11, 2)
				timerFocusedBlastCD:Start(11)
			else
				local extend = 11 - blastTotal
				DBM:Debug("experimental timer extend firing for Focused Blast. Extend amount: "..extend, 2)
				timerFocusedBlastCD:Update(blastElapsed, blastTotal+extend)
			end
		end
		local elapsed, total = timerCallofScorpidCD:GetTime()
		local remaining = total - elapsed
		if remaining < scorptAdjust then--delayed by shockwave
			timerCallofScorpidCD:Stop()
			countdownCallofScorpid:Cancel()
			if total == 0 then--Just in case timer expired just before cast
				DBM:Debug("experimental timer extend firing for call of scorpid. Extend amount: "..scorptAdjust, 2)
				timerCallofScorpidCD:Start(scorptAdjust)
				countdownCallofScorpid:Start(scorptAdjust)
			else
				local extend = scorptAdjust - remaining
				DBM:Debug("experimental timer extend firing for call of scorpid. Extend amount: "..extend, 2)
				timerCallofScorpidCD:Update(elapsed, total+extend)
				countdownCallofScorpid:Start(scorptAdjust)
			end
		end
	elseif spellId == 204471 then
		specWarnFocusedBlast:Show()
		voiceFocusedBlast:Play("watchstep")
		timerFocusedBlastCD:Start()
		countdownFocusedBlast:Start()
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
		timerFocusedBlastCD:Stop()
		countdownFocusedBlast:Cancel()
		timerCallofScorpidCD:Stop()
		countdownCallofScorpid:Cancel()
		local shockwaveElapsed, shockwaveTotal = timerShockwaveCD:GetTime()
		local shockwaveRemaining = shockwaveTotal - shockwaveElapsed
		if shockwaveRemaining < 14 then
			--Shockwave immediately coming out of stun
			--Shockwave will trigger new timers for scorpid and focused blast
			timerShockwaveCD:Stop()
			countdownShockwave:Cancel()
			timerShockwaveCD:Start(15)
			countdownShockwave:Start(15)
			DBM:Debug("experimental timer extend firing for shockwave. Extend amount: 14. Blast and scorpid will be delayed", 2)
		else
			--Focused blast coming out of stun followed by scorpid
			timerFocusedBlastCD:Start(18)
			countdownFocusedBlast:Start(18)
			timerCallofScorpidCD:Start(21)
			countdownCallofScorpid:Start(21)
			DBM:Debug("Shockwaves cd is long enough to allow Focused Blast to proceed next", 2)
		end
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
	elseif spellId == 204744 and args:IsPlayer() and self:AntiSpam(2, 3) then
		specWarnToxicChit:Show()
		voiceToxicChit:Play("runaway")
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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 204744 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnToxicChit:Show()
		voiceToxicChit:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 214800 then--Transform(Red)
		timerAcidicFragments:Start()
	elseif spellId == 215042 then--Transform(Green)
		timerCrystallineFragments:Start()
	elseif spellId == 215055 then--Transform(Blue)
		timerVolatileFragments:Start()
	end
end

--Shockwave does NOT go on cooldown if he doesn't finish cast. This happens if he gets stunned before cast finishes
function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 204316 then--Shockwave
		timerShockwaveCD:Stop()
		countdownShockwave:Cancel()
	end
end
