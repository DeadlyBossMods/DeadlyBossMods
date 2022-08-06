local mod	= DBM:NewMod(2418, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166644)
mod:SetEncounterID(2405)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20210214000000)--2021, 02, 14
mod:SetMinSyncRevision(20201214000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328437 335013 325399 327887 329770 328789 340758 329834 328880 342310 340788 342854 329107 340807",
	"SPELL_CAST_SUCCESS 325361 326271 325399 181089",
	"SPELL_AURA_APPLIED 328448 328468 325236 327902 327414",
	"SPELL_AURA_REMOVED 328448 328468 325236",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"CHAT_MSG_MONSTER_YELL"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add https://shadowlands.wowhead.com/spell=340842/soul-singe ?
--[[
(ability.id = 328437 or ability.id = 335013 or ability.id = 325399 or ability.id = 327887 or ability.id = 340758 or ability.id = 329770 or ability.id = 329834 or ability.id = 328880 or ability.id = 328789 or ability.id = 342310 or ability.id = 340807 or ability.id = 340788 or ability.id = 342854) and type = "begincast"
 or (ability.id = 326271 or ability.id = 325361 or ability.id = 181089) and type = "cast"
--]]
mod:AddTimerLine(BOSS)
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnDimensionalTear							= mod:NewTargetNoFilterAnnounce(328437, 3, nil, nil, 327770)
local warnHyperlightSpark							= mod:NewCountAnnounce(325399, 2, nil, false, 2)

local specWarnDimensionalTear						= mod:NewSpecialWarningYouPos(328437, 327770, nil, nil, 1, 2)
local yellDimensionalTear							= mod:NewPosYell(328437, 327770)
local yellDimensionalTearFades						= mod:NewIconFadesYell(328437, 327770)
local specWarnGlyphofDestruction					= mod:NewSpecialWarningMoveAwayCount(325361, nil, nil, nil, 1, 2)
local yellGlyphofDestruction						= mod:NewYell(325361)
local yellGlyphofDestructionFades					= mod:NewShortFadesYell(325361)
local specWarnGlyphofDestructionTaunt				= mod:NewSpecialWarningTaunt(325361, nil, nil, nil, 1, 2)
local specWarnStasisTrap							= mod:NewSpecialWarningDodge(326271, nil, nil, nil, 2, 2)
local specWarnRiftBlast								= mod:NewSpecialWarningDodge(335013, nil, nil, nil, 2, 2)

local timerDimensionalTearCD						= mod:NewCDTimer(25, 328437, 327770, nil, nil, 3)
local timerGlyphofDestructionCD						= mod:NewCDCountTimer(27.9, 325361, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--27.9-58.6 for now
local timerGlyphofDestruction						= mod:NewTargetTimer(4, 325361, nil, nil, 2, 2, nil, DBM_COMMON_L.TANK_ICON)
local timerStasisTrapCD								= mod:NewCDTimer(30.3, 326271, nil, nil, nil, 3)--30, except when it's reset by phase changes
local timerRiftBlastCD								= mod:NewCDTimer(36, 335013, nil, nil, nil, 3)--36.3 except when it's reset by phase changes
local timerHyperlightSparkCD						= mod:NewCDTimer(15.8, 325399, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--15.8 except when it's heavily spell queued
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnTear", 328437, true, false, {1, 2})
--Sire Denathrius' Private Collection
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22119))
local warnSpirits									= mod:NewSpellAnnounce(340758, 3, nil, nil, 263222)
local warnFixate									= mod:NewTargetAnnounce(327902, 3)
local warnPossession								= mod:NewTargetNoFilterAnnounce(327414, 4)
local warnSeedsofExtinction							= mod:NewSpellAnnounce(329834, 3, nil, nil, 205446)--Shortname "Planting Seeds"
local warnUnleashPower								= mod:NewCountAnnounce(342854, 4)

local specWarnFixate								= mod:NewSpecialWarningRun(327902, nil, nil, nil, 4, 2)
local specWarnEdgeofAnnihilation					= mod:NewSpecialWarningRun(328789, nil, 307421, nil, 4, 2)

local timerFleetingSpiritsCD						= mod:NewCDTimer(40.8, 340758, 263222, nil, nil, 3)--40.8-46
local timerSeedsofExtinctionCD						= mod:NewCDTimer(43.7, 329770, 205446, nil, nil, 5)--43-49. Shortname "Planting Seeds"
local timerExtinction								= mod:NewCastTimer(16, 329107, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerEdgeofAnnihilationCD						= mod:NewCDTimer(44.3, 328789, 307421, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Annihilation"
local timerEdgeofAnnihilation						= mod:NewCastTimer(10, 328789, 307421, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)
local timerUnleashPowerCD							= mod:NewCDTimer(40.8, 342854, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.DEADLY_ICON)

mod:GroupSpells(340758, 327902)--Spirits and their fixate
mod:GroupSpells(329770, 329107)--Seeds of extinction and their cast

mod.vb.spartCount = 0
mod.vb.tearIcon = 1
mod.vb.annihilationCount = 0
mod.vb.destructionCount = 0
mod.vb.unleashCount = 0
mod.vb.p3FirstCast = 0--1- Tear, 2 - Annihilate
mod.vb.hyperInProgress = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spartCount = 0
	self.vb.tearIcon = 1
	self.vb.annihilationCount = 0
	self.vb.destructionCount = 0
	self.vb.unleashCount = 0
	self.vb.p3FirstCast = 0--1- Tear, 2 - Annihilate
	self.vb.hyperInProgress = false
	timerHyperlightSparkCD:Start(5-delay)
	if self:IsHard() then
		timerStasisTrapCD:Start(10.5-delay)
	end
	timerDimensionalTearCD:Start(14)
	timerRiftBlastCD:Start(20.3-delay)
	timerFleetingSpiritsCD:Start(25)
	timerGlyphofDestructionCD:Start(31.6-delay, 1)--SUCCESS
--	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328437 or spellId == 342310 then
		self.vb.tearIcon = 1
		if spellId == 328437 then--One scripted to rotator
			if self.vb.phase == 1 then
				timerFleetingSpiritsCD:Start(20.2)
			elseif self.vb.phase == 2 then
				timerSeedsofExtinctionCD:Start(self:IsMythic() and 25 or 20.2)
			else--Phase 3
				--To notify user of a bug that sometimes happens when boss casts annihilate/Unleashed power twice in a row instead of alternating, making fight harder to do
				if self.vb.p3FirstCast == 0 then
					self.vb.p3FirstCast = 1
				end
				if self:IsMythic() then
					timerUnleashPowerCD:Start(40)
				else
					timerDimensionalTearCD:Start(25)--(26.75)
				end
			end
		else--If boss is casting 342310 he's transitioning into a new phase and spawning initial rifts for that phase
			--Stop timers if they weren't stopped by earlier yell triggers
			timerDimensionalTearCD:Stop()--stop rift timer from Spell Rotator if it wasn't stopped by earlier phase change scripts
			timerFleetingSpiritsCD:Stop()
			timerSeedsofExtinctionCD:Stop()
		end
	elseif spellId == 335013 then
		specWarnRiftBlast:Show()
		specWarnRiftBlast:Play("farfromline")
		timerRiftBlastCD:Start()
	elseif spellId == 325399 then
		self.vb.spartCount = self.vb.spartCount + 1
		warnHyperlightSpark:Show(self.vb.spartCount)
		timerHyperlightSparkCD:Start()
		self.vb.hyperInProgress = true
--	elseif spellId == 327887 then--First Spirits cast (Crystal of Phantasms)
	--	warnSpirits:Show()
	--	timerDimensionalTearCD:Start(25)--Timer for first tear after activation. Activations don't fire spell rotator
--	elseif spellId == 340758 then--Fleeting Spirits 2nd+ cast (but only in phase 1, phase 2 and 3 mythic don't fire this event)
--		timerDimensionalTearCD:Start(20.2)
	elseif spellId == 329770 then--Root of Extinction first cast
--		warnSeedsofExtinction:Show()
		if self.vb.phase < 2 then--In case user playing in language with unlocalized phase 2 yell
			self:SetStage(2)
			timerDimensionalTearCD:Stop()
			timerFleetingSpiritsCD:Stop()
		end
		timerDimensionalTearCD:Start(33.5)
	elseif spellId == 340788 then--Seeds of Extinction casts 2+ (the one rotator is linked to)
		timerDimensionalTearCD:Start(self:IsMythic() and 25 or 20.2)
	elseif spellId == 329834 then--Seeds cast itself, for warnings
		warnSeedsofExtinction:Show()
	elseif spellId == 329107 and self:AntiSpam(3, 1) then--Seeds Extinction Cast
		timerExtinction:Start()
	elseif spellId == 328880 then--Phase Change 3 (Edge of Annihilation)
		if self.vb.phase < 3 then--In case boss doesn't cast 342310, which happens in rare cases
			self:SetStage(3)
			self.vb.p3FirstCast = 0--1- Tear, 2 - Annihilate
			timerDimensionalTearCD:Stop()
			timerSeedsofExtinctionCD:Stop()
		end
		--TODO, monitor for blizzard having fixed this issue https://us.forums.blizzard.com/en/wow/t/feedback-mythic-artificer-xymox/617893/5
		--Mythic could be either Unleash OR tear first. if it's actually annihilation next it's a wipe
		if self:IsMythic() then
			self.vb.unleashCount = 1
			warnUnleashPower:Show(1)
			timerEdgeofAnnihilationCD:Start(7.2)
			timerSeedsofExtinctionCD:Start(11.4)
			timerFleetingSpiritsCD:Start(13.6)
			timerDimensionalTearCD:Start(30)--Or Unleashed power
		else
			timerDimensionalTearCD:Start(35.2)
		end
	elseif spellId == 340807 then--Annihilate 2+ cast by boss, for timer handling
		if self.vb.p3FirstCast == 0 then
			self.vb.p3FirstCast = 2
			DBM:AddMsg("This is very likely a bugged pull. This may cause you to wipe. Refer to https://us.forums.blizzard.com/en/wow/t/feedback-mythic-artificer-xymox/617893/5")
		end
		timerDimensionalTearCD:Start(25.2)
	elseif spellId == 328789 then--Script for the actual annihilate, where warning handling is done
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		specWarnEdgeofAnnihilation:Show(self.vb.annihilationCount)
		specWarnEdgeofAnnihilation:Play("justrun")
		specWarnEdgeofAnnihilation:ScheduleVoice(2, "keepmove")
		timerEdgeofAnnihilation:Start()
	elseif spellId == 342854 then--Unleash Power, cast in mythic phase 3 to activate all relics at once (replaces 340807 which is not cast on mythic)
		if self.vb.p3FirstCast == 0 then
			self.vb.p3FirstCast = 2
			DBM:AddMsg("This is very likely a bugged pull. This may cause you to wipe. Refer to https://us.forums.blizzard.com/en/wow/t/feedback-mythic-artificer-xymox/617893/5")
		end
		self.vb.unleashCount = self.vb.unleashCount + 1
		warnUnleashPower:Show(self.vb.unleashCount)
		--Unleash Power 1: Spirits, delay, Seeds+Annihilation
		timerDimensionalTearCD:Start(40)
		--Starts at 2 because first tri is actually activated on Annihilationn relic activation
		if self.vb.unleashCount == 2 then
			timerFleetingSpiritsCD:Start(3)
			timerSeedsofExtinctionCD:Start(11)
			timerEdgeofAnnihilationCD:Start(11)
		--Unleash Power 2: Annihilate, Spirits, seeds
		elseif self.vb.unleashCount == 3 then
			timerEdgeofAnnihilationCD:Start(3)
			timerFleetingSpiritsCD:Start(6)
			timerSeedsofExtinctionCD:Start(13)
		--Unleash Power 3: Seeds, unknown, unknown
		elseif self.vb.unleashCount == 4 then
			timerSeedsofExtinctionCD:Start(3)
			timerEdgeofAnnihilationCD:Start(11)
			--timerFleetingSpiritsCD:Start(13)--Unknown
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325361 then
		self.vb.destructionCount = self.vb.destructionCount + 1
		timerGlyphofDestructionCD:Start(nil, self.vb.destructionCount+1)
	elseif spellId == 326271 and self:IsHard() then
		--Even fires in all difficulties even though it doesn't do anything on normal/LFR
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	elseif spellId == 325399 then
		self.vb.hyperInProgress = false
	elseif spellId == 181089 then
		self:SetStage(0)
		if self.vb.phase == 2 then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			timerStasisTrapCD:Stop()
			timerRiftBlastCD:Stop()
			timerHyperlightSparkCD:Stop()
			timerGlyphofDestructionCD:Stop()--Glyph is auto cast on transition yells, in addition starts a custom non 36 timer for first one in each phase
			timerFleetingSpiritsCD:Stop()
			timerDimensionalTearCD:Stop()
			--If hyper is in progress, boss actually finishes it and the phase change CD isn't triggered
			if not self.vb.hyperInProgress then
				timerHyperlightSparkCD:Start(5.5)--5.5-6
			else--When this happens, it doesn't get recast for a full minute (Old)
				timerHyperlightSparkCD:Start(25)--New, it's no longer a minute?
			end
			timerDimensionalTearCD:Start(14)
			timerRiftBlastCD:Start(20)
			timerSeedsofExtinctionCD:Start(21.6)
			timerGlyphofDestructionCD:Start(27.8, self.vb.destructionCount+1)--SUCCESS
			if self:IsHard() then
				timerStasisTrapCD:Start(10.7)
			end
		elseif self.vb.phase == 3 then
			self.vb.p3FirstCast = 0--1- Tear, 2 - Annihilate/Unleashed
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerStasisTrapCD:Stop()
			timerRiftBlastCD:Stop()
			timerHyperlightSparkCD:Stop()
			timerGlyphofDestructionCD:Stop()--Glyph is auto cast on transition yells, in addition starts a custom non 36 timer for first one in each phase
			timerSeedsofExtinctionCD:Stop()
			timerDimensionalTearCD:Stop()
			--If hyper is in progress, boss actually finishes it and the phase change CD isn't triggered
			if not self.vb.hyperInProgress then
				timerHyperlightSparkCD:Start(5.5)--5.5-7
			else--When this happens, it doesn't get recast for a full minute
				timerHyperlightSparkCD:Start(60)
			end
			timerDimensionalTearCD:Start(14.4)
			timerRiftBlastCD:Start(45.9)
			timerGlyphofDestructionCD:Start(53.5, self.vb.destructionCount+1)--SUCCESS
			if self:IsHard() then
				timerStasisTrapCD:Start(10.7)
			end
			if self:IsMythic() then
				timerUnleashPowerCD:Start(20)--Time until phase 3 activation edge of annihilation spell
			else
				timerEdgeofAnnihilationCD:Start(27)--Time until actual annihilation cast, not edge of annihilation
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		local icon = self.vb.tearIcon
		if self.Options.SetIconOnTear then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDimensionalTear:Show(self:IconNumToTexture(icon))
			specWarnDimensionalTear:Play("mm"..icon)
			yellDimensionalTear:Yell(icon, icon, icon)
			yellDimensionalTearFades:Countdown(spellId, nil, icon)
		end
		warnDimensionalTear:CombinedShow(1, args.destName)
		self.vb.tearIcon = self.vb.tearIcon + 1
	elseif spellId == 325236 then
		if args:IsPlayer() then
			specWarnGlyphofDestruction:Show(self.vb.destructionCount)
			specWarnGlyphofDestruction:Play("runout")
			yellGlyphofDestruction:Yell()
			yellGlyphofDestructionFades:Countdown(spellId)
		else
			specWarnGlyphofDestructionTaunt:Show(args.destName)
			specWarnGlyphofDestructionTaunt:Play("tauntboss")
		end
		timerGlyphofDestruction:Start(self:IsEasy() and 8 or 4, args.destName)
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

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		if args:IsPlayer() then
			yellDimensionalTearFades:Cancel()
		end
		if self.Options.SetIconOnTear then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 325236 then
		if args:IsPlayer() then
			yellGlyphofDestructionFades:Cancel(spellId)
		end
		timerGlyphofDestruction:Stop(args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--Only activation that lacks a CLEU event for the actual activations. Stage 1 has a boss cast, but on mythic that doesn't exist in stage 2 or 3, this does
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:327887") then
		warnSpirits:Show()
		if self.vb.phase == 1 then
			timerDimensionalTearCD:Start(20.2)
		end
	end
end
