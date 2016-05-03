local mod	= DBM:NewMod(1743, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103769)----TODO, verify
mod:SetEncounterID(1872)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--TODO< figure out debuff count
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 208944 208887 209590 209620 221864 209568 209617 209595 208807 210387 210022 213739 211618 209168 209971",
	"SPELL_CAST_SUCCESS 209597",
	"SPELL_AURA_APPLIED 209615 213716 209242 209244 209246 209973 209598",
	"SPELL_AURA_REFRESH 209973",
	"SPELL_AURA_APPLIED_DOSE 209615 209973",
	"SPELL_AURA_REMOVED 209973 209598",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, phases obviously.
--TODO, elemental spawn triggers
--TODO, Figure out Fast Time and Slow Time mechanics
--TODO, figure out interrupt order/count assistant for stuff
--TODO, determine which interrupts are off by default, if any
--TODO, figure out permaliative torment and get target announce correct. Not even going to try drycoding this cause it might create spam if broken
--TODO, 209615/ablation is probably a swap mechanic that stacks. Coded as such for now until proven otherwise
--TODO, figure out correct Beam IDs and stuff
--TODO, figure out some voice choices for some unvoiced special warnings.
--TODO, how many balls need soaking? journal says it's a dps job too so currently warning is dps only.
--TODO, figure out if Ablating Explotion refreshes and tanks control when it expires by refreshing it.
--TODO, figure out how to do yell countdowns on Conflexive Burst. It'll probably require UNIT_AURA player scanning with constant checking of time remaining.
--TODO, are tanks enough to keep Ablative Pulse Interrupted? Dps have enough stuff to interrupt so hopefully tanks can worry about boss on their own
--Base
local warnStopTime					= mod:NewSpellAnnounce(208944, 2)
local warnTimeElementals			= mod:NewSpellAnnounce(208887, 3)
local warnTemporalisis				= mod:NewSpellAnnounce(209595, 3)
----Recursive Elemental
local warnCompressedTime			= mod:NewSpellAnnounce(209590, 3)
----Expedient Elemental
--Time Layer 1
local warnPermaliativeTorment		= mod:NewSpellAnnounce(210387, 4)
local warnAblation					= mod:NewStackAnnounce(209615, 2, nil, "Tank")
--Time Layer 2
local warnDelphuricBeam				= mod:NewTargetAnnounce(214278, 3)
local warnAblatingExplosion			= mod:NewTargetAnnounce(214278, 3)
--Time Layer 3
local warnConflexiveBurst			= mod:NewTargetAnnounce(209598, 4)

----Recursive Elemental
local specWarnCompressedTime		= mod:NewSpecialWarningDodge(209590)
local specWarnRecursion				= mod:NewSpecialWarningInterrupt(209620, "HasInterrupt")
local specWarnBlast					= mod:NewSpecialWarningInterrupt(221864, "HasInterrupt")
----Expedient Elemental
local specWarnExoRelease			= mod:NewSpecialWarningInterrupt(209568, "HasInterrupt")
local specWarnExpedite				= mod:NewSpecialWarningInterrupt(209617, "HasInterrupt")
--Time Layer 1
local specWarnArcaneticRing			= mod:NewSpecialWarningSpell(208807, nil, nil, nil, 2)
--Time Layer 2
local specWarnDelphuricBeam			= mod:NewSpecialWarningRun(214278, nil, nil, nil, 1, 2)
local yellDelphuricBeam				= mod:NewYell(214278)
local specWarnEpochericOrb			= mod:NewSpecialWarningSpell(214278, "Dps", nil, nil, 1, 2)
local yellAblatingExplosion			= mod:NewFadesYell(214278)
--Time Layer 3
local specWarnSpanningSingularity	= mod:NewSpecialWarningDodge(209168, nil, nil, nil, 2, 2)
local specWarnConflexiveBurst		= mod:NewSpecialWarningYou(209598, nil, nil, nil, 1, 2)
local specWarnAblativePulse			= mod:NewSpecialWarningInterrupt(209971, "HasInterrupt")

--Base
local timerTimeElementalsCD			= mod:NewAITimer(16, 163101, nil, nil, nil, 1)
----Recursive Elemental
----Expedient Elemental
--Time Layer 1
--local timerPermaliativeTormentCD	= mod:NewAITimer(16, 210387, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Time Layer 2
--local timerDelphuricBeamCD		= mod:NewAITimer(16, 214278, nil, nil, nil, 3)
local timerEpochericOrbCD			= mod:NewAITimer(16, 210022, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerAblatingExplosion		= mod:NewTargetTimer(6, 210022, nil, nil, nil, 2)
--Time Layer 3
local timerSpanningSingularityCD	= mod:NewAITimer(16, 209168, nil, nil, nil, 3)
local timerConflexiveBurstCD		= mod:NewAITimer(16, 209597, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerAblativePulseCD			= mod:NewAITimer(16, 163101, nil, "Tank", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--Base
--Time Layer 1
--Time Layer 2
local countdownAblatingExplosion	= mod:NewCountdownFades("AltTwo6", 209973)
--Time Layer 3

--Base
----Recursive Elemental
local voiceRecursion				= mod:NewVoice(209620, "HasInterrupt")--kickcast
local voiceBlast					= mod:NewVoice(221864, "HasInterrupt")--kickcast
----Expedient Elemental
local voiceExoRelease				= mod:NewVoice(209568, "HasInterrupt")--kickcast
local voiceExpedite					= mod:NewVoice(209617, "HasInterrupt")--kickcast
--Time Layer 1
--Time Layer 2
local voiceDelphuricBeam			= mod:NewVoice(214278)--laserrun
local voiceEpochericOrb				= mod:NewVoice(210022, "Dps")--161612(catch balls)
--Time Layer 3
local voiceSpanningSingularity		= mod:NewVoice(209168)--watchstep
local voiceConflexiveBurst			= mod:NewVoice(209598)--targetyou (review for better voice)
local voiceAblativePulse			= mod:NewVoice(209971, "HasInterrupt")--kickcast

--mod:AddRangeFrameOption("5")
mod:AddSetIconOption("SetIconOnConflexiveBurst", 209598)
mod:AddInfoFrameOption(209598)
--mod:AddHudMapOption("HudMapOnMC", 163472)

mod.vb.burstDebuffCount = 0

function mod:OnCombatStart(delay)
	self.vb.burstDebuffCount = 0
	timerTimeElementalsCD:Start(1-delay)
	DBM:AddMsg("Between the unknown phase changes and the number of extra spellids in use on this fight, AI timers will be very hit or miss.")
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 208944 then--Time Stop
		warnStopTime:Show()
	elseif spellId == 208887 then--Summon Time ELementals
		warnTimeElementals:Show()
		timerTimeElementalsCD:Start()
	elseif spellId == 209590 then
		warnCompressedTime:Show()
	elseif spellId == 209620 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnRecursion:Show(args.sourceName)
			voiceRecursion:Play("kickcast")
		end
	elseif spellId == 221864 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnBlast:Show(args.sourceName)
			voiceBlast:Play("kickcast")
		end
	elseif spellId == 209568 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExoRelease:Show(args.sourceName)
			voiceExoRelease:Play("kickcast")
		end
	elseif spellId == 209617 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExpedite:Show(args.sourceName)
			voiceExpedite:Play("kickcast")
		end
	elseif spellId == 209971 then
		timerAblativePulseCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnAblativePulse:Show(args.sourceName)
			voiceAblativePulse:Play("kickcast")
		end
	elseif spellId == 209595 then
		warnTemporalisis:Show()
	elseif spellId == 208807 then
		specWarnArcaneticRing:Show()
	elseif spellId == 210387 then
		warnPermaliativeTorment:Show()
	elseif spellId == 210022 or spellId == 213739 or spellId == 211618 then--God help this boss and it's spellids 213739 211618
		specWarnEpochericOrb:Show()
		voiceEpochericOrb:Play("161612")
		timerEpochericOrbCD:Start()
	elseif spellId == 209168 then
		specWarnSpanningSingularity:Show()
		voiceSpanningSingularity:Play("watchstep")
		timerSpanningSingularityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 209597 then
		timerConflexiveBurstCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209615 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 then--Every 3 stacks for now
				warnAblation:Show(args.destName, amount)
			end
		end
	elseif spellId == 213716 or spellId == 209242 or spellId == 209244 or spellId == 209246 then--Could be any one of these, or multiple
		warnDelphuricBeam:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnDelphuricBeam:Show()
			voiceDelphuricBeam:Play("laserrun")
			yellDelphuricBeam:Yell()
		end
	elseif spellId == 209973 then
		warnAblatingExplosion:Show(args.destName)
		timerAblatingExplosion:Start(args.destName)
		countdownAblatingExplosion:Cancel()
		countdownAblatingExplosion:Start()
		if args:IsPlayer() then
			yellAblatingExplosion:Cancel()
			yellAblatingExplosion:Schedule(3, 3)
			yellAblatingExplosion:Schedule(4, 2)
			yellAblatingExplosion:Schedule(5, 1)
		end
	elseif spellId == 209598 then
		self.vb.burstDebuffCount = self.vb.burstDebuffCount + 1
		warnConflexiveBurst:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnConflexiveBurst:Show()
			voiceConflexiveBurst:Play("targetyou")
		end
		if self.Options.SetIconOnConflexiveBurst then
			self:SetAlphaIcon(0.5, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	end
end
mod.SPELL_AURA_RESFRESH = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209973 then
		timerAblatingExplosion:Stop(args.destName)
		countdownAblatingExplosion:Cancel()
		if args:IsPlayer() then
			yellAblatingExplosion:Cancel()
		end
	elseif spellId == 209598 then
		self.vb.burstDebuffCount = self.vb.burstDebuffCount - 1
		warnConflexiveBurst:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			--Cancel yells when they are added
		end
		if self.Options.SetIconOnConflexiveBurst then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.InfoFrame and self.vb.burstDebuffCount == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 209030 then--Time Layer Change
	
	elseif spellId == 209123 then--Go Up a Time Layer
	
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
