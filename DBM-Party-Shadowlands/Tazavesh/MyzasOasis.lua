local mod	= DBM:NewMod(2452, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176564)
mod:SetEncounterID(2440)
mod:SetHotfixNoticeRev(20220405000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350916 350922 355438 350919 359028 357404 357513 357436 357542 359222",
	"SPELL_CAST_SUCCESS 181089",
	"SPELL_AURA_APPLIED 353706 353835",
	"SPELL_AURA_REMOVED 353706",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, detect and show who has what instrument on infoframe?
--TODO, detect and timer when new patrons enter stage?
--https://ptr.wowhead.com/spell=348566/throw-drink target scanable/worth adding chat yell to?
--https://ptr.wowhead.com/spell=353826/carrying-drink can be used to detect Brawling Patron spawns?
--Do more with Disruptive Patron?
--TODO, appropriate warning for Crowd Control
--TODO, upgrade drumroll to special warning?
--TODO, detect who vere is on, and distance check to that person to only alert solo for those near them (and who they're fixating)
--[[
(ability.id = 350916 or ability.id = 359028 or ability.id = 350916 or ability.id = 350922 or ability.id = 355438 or ability.id = 350919 or ability.id = 357404 or ability.id = 357513 or ability.id = 357436 or ability.id = 357542 or ability.id = 359222) and type = "begincast"
 or ability.id = 181089 and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--Stage One: Unruly Patrons
local warnRottenFood				= mod:NewSpellAnnounce(359222, 2)
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
local timerRottenFoodCD					= mod:NewNextTimer(10, 359222, nil, nil, nil, 3)
local timerSecuritySlamCD				= mod:NewCDTimer(13.7, 350916, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Reused for boss too
local timerMenacingShoutCD				= mod:NewCDTimer(15.8, 350922, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Reused for boss too
--Stage Two: Closing Time
local timerSupressionSparkCD			= mod:NewCDTimer(37.6, 355438, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON)
local timerCrowdControlCD				= mod:NewCDTimer(21.8, 350919, nil, nil, nil, 3)
--Hard Mode Timers
local timerDischordantSongCD			= mod:NewAITimer(15.8, 357404, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerDrumrollCD					= mod:NewAITimer(15.8, 357513, nil, nil, nil, 2)
local timerInfectiousSoloCD				= mod:NewAITimer(15.8, 357436, nil, nil, nil, 2)
local timerRipChordCD					= mod:NewAITimer(15.8, 357542, nil, nil, nil, 3)

mod:AddRangeFrameOption(5, 359222)
mod:AddNamePlateOption("NPAuraOnRowdy", 353706)

local activeBossGUIDS = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	timerRottenFoodCD:Start(20.5-delay)
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
		if spellId == 350916 then--Security Guards
			timerSecuritySlamCD:Start(13.7, args.sourceGUID)
		else--Boss (stage 2)
			timerSecuritySlamCD:Start(15.8, args.sourceGUID)--15.8 but lowest spell priority, meaming it's often queued a long time
		end
	elseif spellId == 350922 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnMenacingShout:Show(args.sourceName)
			specWarnMenacingShout:Play("kickcast")
		end
		if args:GetSrcCreatureID() == 166970 then--Main boss
			timerMenacingShoutCD:Start(21.5, args.sourceGUID)
		else
			timerMenacingShoutCD:Start(25.5, args.sourceGUID)
		end
	elseif spellId == 355438 then
		specWarnSupressionSpark:Show()
		specWarnSupressionSpark:Play("scatter")
		timerSupressionSparkCD:Start()--Insufficient data to determine lowest time, only know FIRST and second usually 37-39 apart
	elseif spellId == 350919 then
		specWarnCrowdControl:Show()
		specWarnCrowdControl:Play("shockwave")
		timerCrowdControlCD:Stop()--Boss can stutter cast, no desire to get debug about it
		timerCrowdControlCD:Start()--21.8
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
	elseif spellId == 359222 and self:AntiSpam(4, 1) then
		warnRottenFood:Show()
		timerRottenFoodCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181089 then
		self:SetStage(2)
		timerSecuritySlamCD:Start(6.4, args.sourceGUID)--Boss version 6.4-8.6
		timerMenacingShoutCD:Start(12.5, args.sourceGUID)--Boss version
		timerSupressionSparkCD:Start(19.8)
		timerCrowdControlCD:Start(27.1)
	end
end

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
		timerSecuritySlamCD:Stop(args.destGUID)
		timerMenacingShoutCD:Stop(args.destGUID)
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
