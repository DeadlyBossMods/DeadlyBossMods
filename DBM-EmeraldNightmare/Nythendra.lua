local mod	= DBM:NewMod(1703, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102672)
mod:SetEncounterID(1853)
mod:SetZone()
mod:SetUsedIcons(4, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 203552 202977 205070",
	"SPELL_CAST_SUCCESS 204463",
	"SPELL_AURA_APPLIED 204463 203096 205043",
	"SPELL_AURA_REMOVED 204463 203096 203552",
	"SPELL_PERIODIC_DAMAGE 203045",
	"SPELL_PERIODIC_MISSED 203045",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe improve timers by on fly corrections off breaths 1 and 2 to fix their accuracy a little do to variations
--TODO, Fix yellsi if they are still 1 second off for volatile rot in later tests.
--TODO, figure out wtf on the timers. they were completely different on mythic and again on LFR. Assume LFR are most current but recheck all others
--TODO, redo pull timers when boss is starting at 100 energy again
--consider countdowns if timers made more accurate.
local warnVolatileRot				= mod:NewTargetAnnounce(204463, 4)
local warnRot						= mod:NewTargetAnnounce(203096, 3)
local warnHeartofSwarm				= mod:NewSpellAnnounce(203552, 2)
local warnInfestedMind				= mod:NewTargetAnnounce(205043, 4)

local specWarnBreath				= mod:NewSpecialWarningDodge(202977, nil, nil, nil, 2, 2)
local specWarnVolatileRot			= mod:NewSpecialWarningRun(204463, nil, nil, nil, 3, 2)
local specWarnVolatileRotSwap		= mod:NewSpecialWarningTaunt(204463, nil, nil, nil, 1, 2)
local yellVolatileRot				= mod:NewFadesYell(204463)
local specWarnRot					= mod:NewSpecialWarningRun(203096, nil, nil, nil, 1, 2)
local yellRot						= mod:NewFadesYell(203096)
local specWarnInfestedGround		= mod:NewSpecialWarningMove(203045, nil, nil, nil, 1, 2)
local specWarnInfestedMind			= mod:NewSpecialWarningSwitch(205043, "Dps", nil, nil, 1, 2)
local specWarnSpreadInfestation		= mod:NewSpecialWarningInterrupt(205070, "HasInterrupt", nil, nil, 1, 2)

local timerBreathCD					= mod:NewCDCountTimer(37.5, 202977, nil, nil, nil, 3)--37-39
local timerVolatileRotCD			= mod:NewCDCountTimer(20.5, 204463, nil, "Tank", nil, 5)--20.5-24 variation
local timerRotCD					= mod:NewCDCountTimer(15, 203096, nil, nil, nil, 3)
local timerSwarm					= mod:NewBuffActiveTimer(23, 203552, nil, nil, nil, 6)
local timerSwarmCD					= mod:NewCDCountTimer(98, 203552, nil, nil, nil, 6)--Needs new sample size

local countdownBreath				= mod:NewCountdown(37.5, 202977)
local countdownVolatileRot			= mod:NewCountdown("Alt20.5", 204463, "Tank")

local voiceBreath					= mod:NewVoice(202977)--breathsoon
local voiceRot						= mod:NewVoice(203096)--runout
local voiceVolatileRot				= mod:NewVoice(204463)--runout/TauntBoss
local voiceInfestedGround			= mod:NewVoice(203045)--runaway
local voiceInfestedMind				= mod:NewVoice(205043, "Dps")--findmc
local voiceSpreadInfestation		= mod:NewVoice(205070, "HasInterrupt")--kickcast

mod:AddSetIconOption("SetIconOnRot", 203096)--Of course I'll probably be forced to change method when BW does their own thing, for compat.
mod:AddInfoFrameOption(204506)

mod.vb.breathCount = 0
mod.vb.rotCast = 0
mod.vb.volatileRotCast = 0
mod.vb.swarmCast = 0

function mod:OnCombatStart(delay)
	self.vb.breathCount = 0
	self.vb.rotCast = 0
	self.vb.volatileRotCast = 0
	self.vb.swarmCast = 0
	--Only start timers if boss isn't starting at 0 energy
	if UnitExists("boss1") and UnitPower("boss1") > 80 then
		timerRotCD:Start(6, 1)
		timerVolatileRotCD:Start(20, 1)--20-25.8 (22)
		timerBreathCD:Start(35-delay, 1)--35-40 variable (38)
		countdownBreath:Start(35-delay)
		timerSwarmCD:Start(86-delay, 1)--86-100 (91)
		DBM:AddMsg("Note, pull timers are subject to inaccuracies since they were changed after heroic was tested BUT didn't work right during mythic testing do to energy bug")
	else--Boss started at 0 energy and will go right into swarm phase after about 5 seconds
		timerSwarmCD:Start(5-delay, 1)
	end
	if self.Options.InfoFrame and self:IsMythic() then
		DBM.InfoFrame:SetHeader(GetSpellInfo(204506))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 204506)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203552 then
		--Cancel for good measure since blizzard is still tweaking fight
		timerRotCD:Stop()
		timerVolatileRotCD:Stop()
		timerBreathCD:Stop()
		countdownBreath:Cancel()
		--Cancel for good measure since blizzard is still tweaking fight
		self.vb.swarmCast = self.vb.swarmCast + 1
		warnHeartofSwarm:Show(self.vb.swarmCast)
		timerSwarm:Start()
	elseif spellId == 202977 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnBreath:Show(self.vb.breathCount)
		voiceBreath:Play("breathsoon")
		if self.vb.breathCount < 2 then
			timerBreathCD:Start(nil, self.vb.breathCount+1)
			countdownBreath:Start()
		end
	elseif spellId == 205070 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSpreadInfestation:Show(args.sourceName)
		voiceSpreadInfestation:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 204463 then
		self.vb.volatileRotCast = self.vb.volatileRotCast + 1
		if self.vb.volatileRotCast < 3 then
			timerVolatileRotCD:Start(nil, self.vb.volatileRotCast+1)
		end
		--Assumed Obsolete
--		if self:IsMythic() then
--			timerVolatileRotCD:Start(42.5, self.vb.volatileRotCast+1)--42.5-48
--		else
--			timerVolatileRotCD:Start(nil, self.vb.volatileRotCast+1)
--		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204463 then
		if args:IsPlayer() then
			specWarnVolatileRot:Show()
			voiceVolatileRot:Play("runout")
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellVolatileRot:Schedule(remaining-1, 1)
				yellVolatileRot:Schedule(remaining-2, 2)
				yellVolatileRot:Schedule(remaining-3, 3)
			end
		else
			if self:IsTank() then
				specWarnVolatileRotSwap:Show(args.destName)
				voiceVolatileRot:Play("tauntboss")
			else
				warnVolatileRot:Show(args.destName)
			end
		end
	elseif spellId == 203096 then
		warnRot:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnRot:Show()
			voiceRot:Play("runout")
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellRot:Schedule(remaining-1, 1)
				yellRot:Schedule(remaining-2, 2)
				yellRot:Schedule(remaining-3, 3)
			end
		end
		if self.Options.SetIconOnRot then
			self:SetAlphaIcon(0.5, args.destName, 1)--Number of icons variable by raid size and duration of fight
		end
	elseif spellId == 205043 then
		warnInfestedMind:CombinedShow(0.5, args.destName)
		if self:AntiSpam(5, 2) then
			specWarnInfestedMind:Show()
			voiceInfestedMind:Play("findmc")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 204463 then
		if args:IsPlayer() then
			yellVolatileRot:Cancel()
		end
	elseif spellId == 203096 then
		if args:IsPlayer() then
			yellRot:Cancel()
		end
		if self.Options.SetIconOnRot then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 203552 then--Heart of swarm ending
		self.vb.breathCount = 0
		self.vb.rotCast = 0
		self.vb.volatileRotCast = 0
		timerRotCD:Start(13, 1)--Needs new samples
		timerVolatileRotCD:Start(30, 1)--Needs new samples
		timerBreathCD:Start(44, 1)--Needs new samples
		countdownBreath:Start(44)
		timerSwarmCD:Start(nil, self.vb.swarmCast+1)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203045 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnInfestedGround:Show()
		voiceInfestedGround:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 203095 then--CAST Doesn't show in combat log for some reason. Applied does but don't want to risk misses
		self.vb.rotCast = self.vb.rotCast + 1
		if self.vb.rotCast < 5 then
			timerRotCD:Start(nil, self.vb.rotCast+1)
		end
		--Assumed obsolete
--[[		if self.vb.rotCast == 1 then
--			if self:IsMythic() then
				timerRotCD:Start(45, 2)
--			else
--				timerRotCD:Start(33, 2)--33-36
--			end
		elseif not self:IsMythic() and self.vb.rotCast == 2 then
			timerRotCD:Start(18.5, 3)--18.5-22
		end--]]
	end
end
