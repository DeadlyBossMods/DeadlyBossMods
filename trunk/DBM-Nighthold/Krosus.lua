local mod	= DBM:NewMod(1713, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101002)
mod:SetEncounterID(1842)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
mod:SetHotfixNoticeRev(15020)
mod.respawnTime = 25--or 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205368 205370 205420 209017 206352 205862 205361",
	"SPELL_AURA_APPLIED 206677 205344",
	"SPELL_AURA_APPLIED_DOSE 206677",
	"SPELL_AURA_REMOVED 205344",
	"UNIT_DIED"
)

--TODO, improve info frame to show active mob count on top of burning pitch on player true/false? instead of just being burning pitch list for entire raid?
local warnExpelOrbDestro			= mod:NewTargetCountAnnounce(205344, 4)
local warnSlam						= mod:NewCountAnnounce(205862, 2)--Regular slams don't need special warn, only bridge smashing ones

local specWarnSearingBrand			= mod:NewSpecialWarningStack(206677, nil, 10, nil, 1, 2)--Lets go with 10 for now
local specWarnSearingBrandOther		= mod:NewSpecialWarningTaunt(206677, nil, nil, nil, 1, 2)
local specWarnFelBeam				= mod:NewSpecialWarningDodge(205368, nil, nil, nil, 2, 2)
local specWarnOrbDestro				= mod:NewSpecialWarningMoveAway(205344, nil, nil, nil, 3, 2)
local yellOrbDestro					= mod:NewFadesYell(205344)
local specWarnBurningPitch			= mod:NewSpecialWarningCount(205420, nil, nil, nil, 2, 6)
local specWarnSlam					= mod:NewSpecialWarningDodge(205862, nil, nil, nil, 3, 2)--every 3rd slam level 3 special warning
local specWarnFelBlast				= mod:NewSpecialWarningInterrupt(209017, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelBurst				= mod:NewSpecialWarningInterrupt(206352, "HasInterrupt", nil, nil, 1, 2)

local timerSearingBrand				= mod:NewTargetTimer(20, 206677, nil, "Tank", nil, 5)
local timerFelBeamCD				= mod:NewNextCountTimer(16, 205368, nil, nil, nil, 3)
local timerOrbDestroCD				= mod:NewNextCountTimer(16, 205344, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--Not that deadly on non mythic but on mythic it is
local timerBurningPitchCD			= mod:NewNextCountTimer(16, 205420, nil, "-Tank", nil, 5)
local timerSlamCD					= mod:NewNextCountTimer(30, 205862, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

local berserkTimer					= mod:NewBerserkTimer(360)--technically not a berserk, but raid instantly wipes during final bridge smash, at 6 minutes.

local countdownBigSlam				= mod:NewCountdown(90, 205862)
local countdownOrbDestro			= mod:NewCountdownFades("AltTwo5", 205344)

local voiceSearingBrand				= mod:NewVoice(206677)--tauntboss
local voiceFelBeam					= mod:NewVoice(205368)--moveleft/moveright
local voiceOrbDestro				= mod:NewVoice(205344)--runout
local voiceBurningPitch				= mod:NewVoice(205420)--watchstep/helpsoak(new)
local voiceSlam						= mod:NewVoice(205862)--justrun
local voiceFelBlast					= mod:NewVoice(209017, "HasInterrupt")--kickcast
local voiceFelBurst					= mod:NewVoice(206352, "HasInterrupt")--kickcast

mod:AddRangeFrameOption(5, 206352)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)
mod:AddInfoFrameOption(215944, false)
mod:AddArrowOption("ArrowOnBeam", 205368, true)

local burningPitchDebuff = GetSpellInfo(215944)
local mobGUIDs = {}
local lolBeamTimers = {5, 15, 30, 30, 23, 27, 30, 44, 14, 16, 14, 16, 22, 60}--about 14 seconds missing, maybe?
--TODO, does heroic have diff beam timers from normal?
local beamMythicTimers = {6, 16, 16, 16, 14, 16, 27, 55, 26, 5, 21.3, 4.7, 12.2, 12, 4.8, 13.2, 19, 4.8, 25.2, 4.8}--205370/205368 Combined (up to 5:18, missing 42 seconds)
--Other stuff
local lolOrbTimers = {70.0, 40.0, 60.0, 25.0, 60.0, 37.0, 15.0, 15.0, 30.0}
local orbTimers = {22, 58, 23, 63, 26, 25, 15, 15, 15, 30, 55}--
local orbMythicTimers = {13, 62, 27, 25, 14.9, 15, 15, 30, 55.1, 38}
local lolBurningPitchTimers = {38.0, 102.0, 85.0, 90.0}
local burningPitchTimers = {52, 84, 90, 93}
local burningPitchMythicTimers = {45.0, 90, 93.9, 78}--38.0, 102.0, 85.0, 90.0
mod.vb.burningEmbers = 0
mod.vb.slamCount = 0
mod.vb.beamCount = 0
mod.vb.orbCount = 0
mod.vb.pitchCount = 0

function mod:OnCombatStart(delay)
	table.wipe(mobGUIDs)
	self.vb.burningEmbers = 0
	self.vb.slamCount = 0
	self.vb.beamCount = 0
	self.vb.orbCount = 0
	self.vb.pitchCount = 0
	if self:IsMythic() then
		timerFelBeamCD:Start(6-delay, 1)
		timerOrbDestroCD:Start(13-delay, 1)
		timerBurningPitchCD:Start(52-delay, 1)
		timerSlamCD:Start(-delay, 1)
		countdownBigSlam:Start(-delay)
		berserkTimer:Start(-delay)
	elseif self:IsHeroic() then
		timerFelBeamCD:Start(5-delay, 1)
		timerOrbDestroCD:Start(22-delay, 1)
		timerBurningPitchCD:Start(52-delay, 1)
		timerSlamCD:Start(-delay, 1)
		countdownBigSlam:Start(-delay)
		berserkTimer:Start(-delay)
	else
		timerFelBeamCD:Start(5-delay, 1)
		timerSlamCD:Start(-delay, 1)
		timerBurningPitchCD:Start(38-delay, 1)
		timerOrbDestroCD:Start(70-delay, 1)
		countdownBigSlam:Start(-delay)
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(burningPitchDebuff)
		DBM.InfoFrame:Show(5, "reverseplayerbaddebuff", burningPitchDebuff)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end
end

--(ability.id = 205368 or ability.id = 205370) and type = "begincast"
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205368 or spellId == 205370 then--205370 left, 205368 right
		self.vb.beamCount = self.vb.beamCount + 1
		specWarnFelBeam:Show(self.vb.beamCount)
		local nextCount = self.vb.beamCount + 1
		local timers = self:IsMythic() and beamMythicTimers[nextCount] or lolBeamTimers[nextCount]
		if timers then
			timerFelBeamCD:Start(timers, nextCount)
		end
		if spellId == 205368 then--Coming from right
			voiceFelBeam:Play("moveleft")
			if self.Options.ArrowOnBeam then
				DBM.Arrow:ShowStatic(90, 4)
			end
		else--coming from left
			voiceFelBeam:Play("moveright")
			if self.Options.ArrowOnBeam then
				DBM.Arrow:ShowStatic(270, 4)
			end
		end
	elseif spellId == 205420 then
		self.vb.pitchCount = self.vb.pitchCount+ 1
		specWarnBurningPitch:Show(self.vb.pitchCount)
		if UnitDebuff("player", burningPitchDebuff) then
			voiceBurningPitch:Play("watchstep")
		else
			voiceBurningPitch:Play("helpsoak")
		end
		local nextCount = self.vb.pitchCount + 1
		local timers = self:IsMythic() and burningPitchMythicTimers[nextCount] or self:IsHeroic() and burningPitchTimers[nextCount] or lolBurningPitchTimers[nextCount]
		if timers then
			timerBurningPitchCD:Start(nil, nextCount)
		end
	elseif spellId == 209017 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFelBlast:Show(args.sourceName)
		voiceFelBlast:Play("kickcast")
	elseif spellId == 206352 then
		if not mobGUIDs[args.sourceGUID] then
			mobGUIDs[args.sourceGUID] = true
			self.vb.burningEmbers = self.vb.burningEmbers + 1
			if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Show(5)
			end
		end
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnFelBurst:Show(args.sourceName)
			voiceFelBurst:Play("kickcast")
		end
	elseif spellId == 205862 then
		self.vb.slamCount = self.vb.slamCount + 1
		timerSlamCD:Start(nil, self.vb.slamCount+1)
		if self.vb.slamCount % 3 == 0 then
			specWarnSlam:Show()
			voiceSlam:Play("justrun")
			countdownBigSlam:Start()
		else
			warnSlam:Show(self.vb.slamCount)
		end
	elseif spellId == 205361 then
		self.vb.orbCount = self.vb.orbCount + 1
		local nextCount = self.vb.orbCount+1
		local timers = self:IsMythic() and orbMythicTimers[nextCount] or self:IsHeroic() and orbTimers[nextCount] or lolOrbTimers[nextCount]
		if timers then
			timerOrbDestroCD:Start(timers, nextCount)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206677 then
		local amount = args.amount or 1
		timerSearingBrand:Start(args.destName)
		if amount >= 10 then
			if args:IsPlayer() then
				specWarnSearingBrand:Show(amount)
				voiceSearingBrand:Play("changemt")
			else
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnSearingBrandOther:Show(args.destName)
					voiceSearingBrand:Play("tauntboss")
				end
			end
		end
	elseif spellId == 205344 then
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnOrbDestro:Show()
			voiceOrbDestro:Play("runout")
			yellOrbDestro:Yell(5)
			yellOrbDestro:Schedule(4, 1)
			yellOrbDestro:Schedule(3, 2)
			yellOrbDestro:Schedule(2, 3)
			countdownOrbDestro:Start()
		else
			warnExpelOrbDestro:Show(self.vb.orbCount, args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205344 then
		if args:IsPlayer() then
			yellOrbDestro:Cancel()
			countdownOrbDestro:Cancel()
		end		
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104262 then--Burning Ember
		self.vb.burningEmbers = self.vb.burningEmbers - 1
		mobGUIDs[args.destGUID] = nil
		if self.Options.RangeFrame and self.vb.burningEmbers == 0 then
			DBM.RangeCheck:Hide()
		end
	end
end
