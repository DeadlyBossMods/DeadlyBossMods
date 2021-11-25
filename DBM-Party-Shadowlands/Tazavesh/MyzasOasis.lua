local mod	= DBM:NewMod(2452, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176564)
mod:SetEncounterID(2440)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350916 350922 355438 350919 359028 357404 357513 357436 357542",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 353706 353835",
	"SPELL_AURA_REMOVED 353706",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, detect and show who has what instrument on infoframe?
--TODO, detect and timer when new patrons enter stage?
--https://ptr.wowhead.com/spell=348566/throw-drink target scanable/worth adding chat yell to?
--https://ptr.wowhead.com/spell=353826/carrying-drink can be used to detect Brawling Patron spawns?
--Do more with Disruptive Patron?
--TODO, stage 2 detection (UNIT_TARGETABLE_CHANGED or INSTANCE_ENCOUNTER_ENGAGE_UNIT)
--TODO, appropriate warning for Crowd Control
--TODO, upgrade drumroll to special warning?
--TODO, detect who vere is on, and distance check to that person to only alert solo for those near them (and who they're fixating)
--Stage One: Unruly Patrons
local warnSuppression				= mod:NewTargetNoFilterAnnounce(353835, 2)
local warnSecuritySlam				= mod:NewSpellAnnounce(350916, 2)
--Stage Two: Closing Time

--Hard Mode
local warnDrumroll					= mod:NewSpellAnnounce(357513, 2)
local warnRipChord					= mod:NewSpellAnnounce(357542, 2)

--Stage One: Unruly Patrons
local specWarnSecuritySlam			= mod:NewSpecialWarningDefensive(350916, nil, nil, nil, 1, 2)--Reused for boss too
--local yellEmbalmingIchor			= mod:NewYell(327664)
local specWarnMenacingShout			= mod:NewSpecialWarningInterrupt(350922, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)
--Stage Two: Closing Time
local specWarnSupressionSpark		= mod:NewSpecialWarningMoveAway(350916, nil, nil, nil, 2, 2)
local specWarnCrowdControl			= mod:NewSpecialWarningDodge(350919, nil, nil, nil, 2, 2)
--Hard Mode Mechanics
local specWarnDischordantSong		= mod:NewSpecialWarningInterrupt(357404, "HasInterrupt", nil, nil, 1, 2)
local specWarnInfectiousSolo		= mod:NewSpecialWarningRun(357436, nil, nil, nil, 4, 2)

--Stage One: Unruly Patrons
--Oasis Security
--local timerSecuritySlamCD			= mod:NewCDTimer(15.8, 350916, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Reused for boss too
--local timerMenacingShoutCD			= mod:NewCDTimer(15.8, 350922, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--Stage Two: Closing Time
local timerSupressionSparkCD			= mod:NewAITimer(15.8, 355438, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON)
local timerCrowdControlCD				= mod:NewAITimer(15.8, 350919, nil, nil, nil, 3)
--Hard Mode Timers
local timerDischordantSongCD			= mod:NewAITimer(15.8, 357404, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerDrumrollCD					= mod:NewAITimer(15.8, 357513, nil, nil, nil, 2)
local timerInfectiousSoloCD				= mod:NewAITimer(15.8, 357436, nil, nil, nil, 2)
local timerRipChordCD					= mod:NewAITimer(15.8, 357542, nil, nil, nil, 3)

mod:AddRangeFrameOption(5, 356482)
mod:AddNamePlateOption("NPAuraOnRowdy", 353706)

local activeBossGUIDS = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	if self.Options.NPAuraOnRowdy then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(activeBossGUIDS)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnRowdy then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350916 or spellId == 359028 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnSecuritySlam:Show()
			specWarnSecuritySlam:Play("defensive")
		else
			warnSecuritySlam:Show()
		end
--		timerSecuritySlamCD:Start(nil, args.sourceGUID)
	elseif spellId == 350922 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnMenacingShout:Show(args.sourceName)
			specWarnMenacingShout:Play("kickcast")
		end
		--timerMenacingShoutCD:Start(nil, args.sourceGUID)
	elseif spellId == 355438 then
		specWarnSupressionSpark:Show()
		specWarnSupressionSpark:Play("scatter")
		timerSupressionSparkCD:Start()
	elseif spellId == 350919 then
		specWarnCrowdControl:Show()
		specWarnCrowdControl:Play("shockwave")
		timerCrowdControlCD:Start()
	elseif spellId == 357404 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDischordantSong:Show(args.sourceName)
			specWarnDischordantSong:Play("kickcast")
		end
		timerDischordantSongCD:Start()
	elseif spellId == 357513 then
		warnDrumroll:Show()
		timerDrumrollCD:Start()
	elseif spellId == 357436 then
		specWarnInfectiousSolo:Show()
		specWarnInfectiousSolo:Play("justrun")
		timerInfectiousSoloCD:Start()
	elseif spellId == 357542 then
		warnRipChord:Show()
		timerRipChordCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320359 then
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 353706 then
		if self.Options.NPAuraOnRowdy then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 353835 then
		warnSuppression:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 353706 then
		if self.Options.NPAuraOnRowdy then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--https://ptr.wowhead.com/npc=176565/disruptive-patron
--https://ptr.wowhead.com/npc=180159/brawling-patron
--https://ptr.wowhead.com/npc=176562/brawling-patron
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 179269 then--Oasis Security
--		timerSecuritySlamCD:Stop(args.destGUID)
--		timerMenacingShoutCD:Stop(args.destGUID)
	elseif cid == 180399 then--Evaile
		timerDischordantSongCD:Stop()
	elseif cid == 180485 then--Hips
		timerDrumrollCD:Stop()
	elseif cid == 180470 then--Verethian
		timerInfectiousSoloCD:Stop()
	elseif cid == 180484 then--Vilt
		timerRipChordCD:Stop()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and UnitCanAttack("player", unitID) then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 176564 and self.vb.phase == 1 then
				self:SetStage(2)
				timerSupressionSparkCD:Start(2)
				timerCrowdControlCD:Start(2)
				--timerSecuritySlamCD:Start(2, unitGUID)--Boss version
				--timerMenacingShoutCD:Start(2, unitGUID)--Boss version
			end
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
