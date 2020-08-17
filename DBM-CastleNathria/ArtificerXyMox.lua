local mod	= DBM:NewMod(2418, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166644)
mod:SetEncounterID(2405)
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328437 335013 325399 327887 329770 328789 340758 329834 328880 342310 340807 340788",
	"SPELL_CAST_SUCCESS 325361 326271",
	"SPELL_AURA_APPLIED 328448 328468 325236 327902 327414",
	"SPELL_AURA_REMOVED 328448 328468",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add https://shadowlands.wowhead.com/spell=340842/soul-singe ?
--TODO, Blizzard fixed scripting for fight by a lot, making it more visible to addons and much easier to work with/understand, only problem left really is correcting Stasis Trap timer
--TODO, mythic's effect on the timer scripting
--[[
(ability.id = 328437 or ability.id = 335013 or ability.id = 325399 or ability.id = 327887 or ability.id = 340758 or ability.id = 329770 or ability.id = 329834 or ability.id = 328880 or ability.id = 328789 or ability.id = 342310 or ability.id = 340807 or ability.id = 340788) and type = "begincast"
 or (ability.id = 326271 or ability.id = 325361) and type = "cast"
--]]
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnDimensionalTear							= mod:NewTargetNoFilterAnnounce(328437, 3)
local warnHyperlightSpark							= mod:NewCountAnnounce(325399, 2, nil, false, 2)
--Sire Denathrius' Private Collection
local warnSpirits									= mod:NewSpellAnnounce(340758, 3)
local warnFixate									= mod:NewTargetAnnounce(327902, 3)
local warnPossession								= mod:NewTargetNoFilterAnnounce(327414, 4)
local warnSeedsofExtinction							= mod:NewSpellAnnounce(329834, 3, nil, nil, 130924)--Shortname "Root"

local specWarnDimensionalTear						= mod:NewSpecialWarningYouPos(328437, nil, nil, nil, 1, 2)
local yellDimensionalTear							= mod:NewPosYell(328437)
local yellDimensionalTearFades						= mod:NewIconFadesYell(328437)
local specWarnGlyphofDestruction					= mod:NewSpecialWarningMoveAway(325361, nil, nil, nil, 1, 2)
local yellGlyphofDestruction						= mod:NewYell(325361)
local yellGlyphofDestructionFades					= mod:NewFadesYell(325361)
local specWarnGlyphofDestructionTaunt				= mod:NewSpecialWarningTaunt(325361, nil, nil, nil, 1, 2)
local specWarnStasisTrap							= mod:NewSpecialWarningDodge(326271, nil, nil, nil, 2, 2)
local specWarnRiftBlast								= mod:NewSpecialWarningDodge(335013, nil, nil, nil, 2, 2)
--Sire Denathrius' Private Collection
local specWarnFixate								= mod:NewSpecialWarningRun(327902, nil, nil, nil, 4, 2)
local specWarnEdgeofAnnihilation					= mod:NewSpecialWarningRun(328789, nil, 307421, nil, 4, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

mod:AddTimerLine(BOSS)
local timerDimensionalTearCD						= mod:NewCDTimer(25, 328437, nil, nil, nil, 3, nil, nil, true)
local timerGlyphofDestructionCD						= mod:NewCDTimer(27.9, 325361, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--27.9-58.6 for now
local timerStasisTrapCD								= mod:NewCDTimer(30.3, 326271, nil, nil, nil, 3)--30, except when it isn't, then it's math.random
local timerRiftBlastCD								= mod:NewCDTimer(36, 335013, nil, nil, nil, 3)--36.3 except when it's 26.8
local timerHyperlightSparkCD						= mod:NewCDTimer(15.8, 325399, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)--15.8 except when it's heavily spell queued
--Sire Denathrius' Private Collection
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22119))
local timerFleetingSpiritsCD						= mod:NewCDTimer(40.8, 340758, nil, nil, nil, 3)--40.8-46
local timerSeedsofExtinctionCD						= mod:NewCDTimer(43.7, 329770, 130924, nil, nil, 5)--43-49. Shortname "Root"
local timerEdgeofAnnihilationCD						= mod:NewCDTimer(44.3, 328789, 307421, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--Shortname "Annihilation"

--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconOnTear", 328437, true, false, {1, 2})

mod.vb.phase = 0
mod.vb.spartCount = 0
mod.vb.annihilationCount = 0
mod.vb.lastRotation = 0--0 rift, 1 ghosts, 2 roots, 3 annihilate

--Timer Notes
--Stasis trap triggers a 3.7 ICD when cast, so any ability coming off cd near stasis trap will be pushed back 3.7 seconds
--Tear seems to have a base CD of 25, but rarely is 25 except when stars align. The reason it's rarely 25 is that any time one of 3 crystals uses their special, x seconds are added to CD. In addition ICDs and spell queuing and all, it can be 35-47
--difficulties don't even act the same, because why be consistent when blizzards code is already dogshit.

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	self.vb.spartCount = 0
	self.vb.annihilationCount = 0
	self.vb.lastRotation = 0--0 tear, 1 ghosts, 2 roots, 3 annihilate, 4 Second tear
	timerHyperlightSparkCD:Start(5.7-delay)
	if self:IsHard() then
		timerStasisTrapCD:Start(10.5-delay)
	end
	timerDimensionalTearCD:Start(14)
	timerRiftBlastCD:Start(20.3-delay)
	timerGlyphofDestructionCD:Start(31.6-delay)--SUCCESS
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd(wipe, secondRun)
	if not secondRun and self:IsMythic() then
		DBM:AddMsg("Even with the fully re-scripted boss code blizz added to help mod authors out with timers, the biggest missing piece (Mythic) needs to be seen to understand how to code mythic timers. Sorry if current timers lead to confusion with todays test. They do not represent final mods quality. Thank you for helping test DBM")
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328437 or spellId == 342310 then
		if spellId == 328437 then--One scripted to rotator
			--Backup code if unit events vanish
			--[[if self.vb.phase == 1 then
				self.vb.lastRotation = 0
				timerFleetingSpiritsCD:Start(20.2)
			elseif self.vb.phase == 2 then
				self.vb.lastRotation = 0
				timerSeedsofExtinctionCD:Start(20.2)
			else
				--Unique 20sec Spell Rotation in this phase (Annihilate, Tear, Empty, Tear, repeat)
				if self.vb.lastRotation == 3 then--Last cast Annihilate
					self.vb.lastRotation = 0--Which means this cast is Tear 1
					if self:IsMythic() then

					else
						timerDimensionalTearCD:Start(40.4)--Which means next cast is tear 2
					end
				else--Last cast was Tear 1
					self.vb.lastRotation = 4--This cast is Tear 2
					timerEdgeofAnnihilationCD:Start(20.2)--Which means next cast begins cycle again at Annihilate
				end
			end--]]
		else--If boss is casting 342310 he's transitioning into a new phase and spawning initial rifts for that phase
			self.vb.phase = self.vb.phase + 1
			self.vb.lastRotation = self.vb.phase--Technically Tear is first in any phase, but it's not part of Spell Rotation script, first thing that script sees will always be phase ability
			timerDimensionalTearCD:Stop()--stop rift timer from Spell Rotator
			if self.vb.phase == 1 then
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
				warnPhase:Play("pone")
				timerFleetingSpiritsCD:Start(11)--Time until Crystal of Phantasms activation
			elseif self.vb.phase == 2 then
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
				warnPhase:Play("ptwo")
				timerFleetingSpiritsCD:Stop()
				timerSeedsofExtinctionCD:Start(6.2)
				--TODO, 2nd timer for mythic or a combined timer
			else--Phase 3
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
				warnPhase:Play("pthree")
				timerSeedsofExtinctionCD:Stop()
				timerEdgeofAnnihilationCD:Start(20.2)
				--TODO, 2nd timer for mythic or a combined timer
			end
		end
	elseif spellId == 335013 then
		specWarnRiftBlast:Show()
		specWarnRiftBlast:Play("farfromline")
		timerRiftBlastCD:Start()
	elseif spellId == 325399 then
		self.vb.spartCount = self.vb.spartCount + 1
		warnHyperlightSpark:Show(self.vb.spartCount)
		timerHyperlightSparkCD:Start()
	elseif spellId == 327887 then--First Spirits cast (Crystal of Phantasms)
		warnSpirits:Show()
	elseif spellId == 340758 then--Fleeting Spirits 2nd+ cast
--		self.vb.lastRotation = 1--0 rift, 1 ghosts, 2 roots, 3 annihilate
--		timerDimensionalTearCD:Start(20.2)
	elseif spellId == 329770 then--Root of Extinction first cast
		warnSeedsofExtinction:Show()
	elseif spellId == 340788 then--Roots of Extinction casts 2+
--		self.vb.lastRotation = 2--0 rift, 1 ghosts, 2 roots, 3 annihilate
--		timerDimensionalTearCD:Start(20.2)
	elseif spellId == 329834 then--Roots cast itself, for warning
		warnSeedsofExtinction:Show()
--	elseif spellId == 328880 then--Phase Change 3 (Edge of Annihilation)

	elseif spellId == 328789 then--Annihilate 2+ cast by boss, for timer handling
--		self.vb.lastRotation = 3--0 rift, 1 ghosts, 2 roots, 3 annihilate
--		timerDimensionalTearCD:Start(20.2)
	elseif spellId == 340807 then--Script for the ctual annihilate, where warning handling is done
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		specWarnEdgeofAnnihilation:Show(self.vb.annihilationCount)
		specWarnEdgeofAnnihilation:Play("justrun")
		specWarnEdgeofAnnihilation:ScheduleVoice(2, "keepmove")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325361 then
		timerGlyphofDestructionCD:Start()
	elseif spellId == 326271 and self:IsHard() then
		--Even fires in all difficulties even though it doesn't do anything on normal/LFR
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		warnDimensionalTear:CombinedShow(1, args.destName)
		local icon = 328448 and 1 or 2--This is better way to do it, but needs confirmation of combat log using both events first
		if args:IsPlayer() then
			specWarnDimensionalTear:Show(self:IconNumToTexture(icon))
			specWarnDimensionalTear:Play("mm"..icon)
			yellDimensionalTear:Yell(icon, icon, icon)
			yellDimensionalTearFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnTear then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 325236 then
		if args:IsPlayer() then
			specWarnGlyphofDestruction:Show()
			specWarnGlyphofDestruction:Play("runout")
			yellGlyphofDestruction:Yell()
			yellGlyphofDestructionFades:Countdown(spellId)
		else
			specWarnGlyphofDestructionTaunt:Show(args.destName)
			specWarnGlyphofDestructionTaunt:Play("tauntboss")
		end
	elseif spellId == 327902 then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
		end
	elseif spellId == 327414 then
		warnPossession:CombinedShow(1, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		if args:IsPlayer() then
			yellDimensionalTearFades:Cancel()
		end
		if self.Options.SetIconOnTear then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--Use if combat log method confuses mythic overlaps or this just ends up being cleaner to use
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342297 then--Broker Curator Phase 1 Spell Rotator
		if self.vb.lastRotation == 0 then--Last cast was tear
			self.vb.lastRotation = 1--Which means this cast is Spirits
			timerDimensionalTearCD:Start(20.2)--Which means next cast is tear
		else--Last cast was spirits
			self.vb.lastRotation = 0--Which means this cast is tear
			timerFleetingSpiritsCD:Start(20.2)--Which means next cast is spirits
		end
	elseif spellId == 342379 then--Broker Curator Phase 2 Spell Rotator
		if self.vb.lastRotation == 0 then--Last cacst as tear
			self.vb.lastRotation = 2--Which means this cast is seeds
			timerDimensionalTearCD:Start(20.2)--Which means next cast is tear
		else--Last cast was seeds
			self.vb.lastRotation = 0--Which means this cast is tear
			timerSeedsofExtinctionCD:Start(20.2)--Which means next cast is seeds
		end
	elseif spellId == 342380 then--Broker Curator Phase 3 Spell Rotator
		--Unique Rotation in this phase
		--Non Mythic: Annihilate, Tear, Empty, Tear, repeat
		--Mythic (Theory): Annihilate, Tear, seeds+spirits, Tear, repeat
		if self.vb.lastRotation == 3 then--Last cast Annihilate
			self.vb.lastRotation = 0--Which means this cast is Tear 1
			if self:IsMythic() then
				timerSeedsofExtinctionCD:Start(20.2)--Which means Seeds+Spirits next
				timerFleetingSpiritsCD:Start(20.2)
			else
				timerDimensionalTearCD:Start(40.4)--Which means next cast is tear 2
			end
		elseif self.vb.lastRotation == 0 then--Last cast was Tear 1
			if self:IsMythic() then
				self.vb.lastRotation = 2--This cast is seeds+spirits
				timerDimensionalTearCD:Start(20.2)
			else
				self.vb.lastRotation = 4--This cast is Tear 2
				timerEdgeofAnnihilationCD:Start(20.2)--Which means next cast begins cycle again at Annihilate
			end
		elseif self.vb.lastRotation == 2 then--Last cast was seeds+spirits on Mythic
			self.vb.lastRotation = 4--This cast is Tear 2
			timerEdgeofAnnihilationCD:Start(20.2)--Next cast is annihilation
		elseif self.vb.lastRotation == 4 then--Last cast was Tear 2
			self.vb.lastRotation = 3--Which means this cast is Annihilate
			timerDimensionalTearCD:Start(20.4)--Which means next cast is tear 1
		end
	end
end
