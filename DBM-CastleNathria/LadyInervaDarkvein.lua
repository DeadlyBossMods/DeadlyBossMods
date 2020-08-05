local mod	= DBM:NewMod(2420, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165521)
mod:SetEncounterID(2406)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325379 332665 331550 334017",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 325382 325936 324983 332664 335396",
	"SPELL_AURA_APPLIED_DOSE 325382",
	"SPELL_AURA_REMOVED 325382 332664 324983",
	"SPELL_PERIODIC_DAMAGE 325713",
	"SPELL_PERIODIC_MISSED 325713",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
	--"UPDATE_UI_WIDGET"
)

--TODO, verify tank stuff (power levels for runout, number of targets of shared cog, etc)
--TODO, also figure out optimized tank swap priority
--TODO, find out correct powere type for boss, which looks to be a widget api
--TODO, add pre debuff if blizz adds it for shared suffering
--TODO, rework timers further to include fact that timers differ at different energy levels (or is it based on which container is currently focused?)
--TODO, does https://shadowlands.wowhead.com/spell=331573/unconscionable-guilt need anything? doesn't say it stacks
--[[
--Sadly, most of timers not in combat log
(ability.id = 325379 or ability.id = 332665) and type = "begincast"
 or (ability.id = 331550 or ability.id = 334017) and type = "begincast"
--]]
local warnWarpedDesires							= mod:NewStackAnnounce(325382, 2, nil, "Tank|Healer")
local warnSharedCognition						= mod:NewTargetNoFilterAnnounce(325936, 4, nil, "Healer")
local warnBottledAnima							= mod:NewSpellAnnounce(325769, 2)
local warnSharedSuffering						= mod:NewTargetNoFilterAnnounce(324983, 3)
local warnConcentrateAnima						= mod:NewTargetNoFilterAnnounce(332664, 3)

local specWarnExposeDesires						= mod:NewSpecialWarningDefensive(325379, false, nil, nil, 1, 2)--Optional warning that the cast is happening toward you
local specWarnWarpedDesires						= mod:NewSpecialWarningTaunt(325382, false, nil, 2, 1, 2)
local specWarnHiddenDesire						= mod:NewSpecialWarningYou(335396, nil, nil, nil, 1, 2)
local specWarnHiddenDesireTaunt					= mod:NewSpecialWarningTaunt(335396, nil, nil, nil, 1, 2)
local yellHiddenDesire							= mod:NewYell(335396)--Remove if they fix bug with it splash damaging
--local specWarnChangeofHeart					= mod:NewSpecialWarningMoveAway(325384, nil, nil, nil, 3, 2)--Triggered by rank 3 Exposed Desires
--local yellChangeofHeartFades					= mod:NewFadesYell(325384)--^^
local specWarnSharedSuffering					= mod:NewSpecialWarningMoveTo(324983, nil, nil, nil, 1, 2)
local yellSharedSuffering						= mod:NewShortYell(324983)
local specWarnConcentrateAnimaAway				= mod:NewSpecialWarningMoveAway(332664, nil, nil, nil, 1, 2)--Rank 1-2
--local specWarnConcentrateAnimaTo				= mod:NewSpecialWarningMoveTo(332664, nil, nil, nil, 1, 2)--Rank 3 (rank 3 no longer in journal)
local yellConcentrateAnimaFades					= mod:NewFadesYell(332664, nil, nil, nil, "YELL")--^^
local specWarnGTFO								= mod:NewSpecialWarningGTFO(325713, nil, nil, nil, 1, 8)
--Anima Constructs
local specWarnCondemn							= mod:NewSpecialWarningInterrupt(331550, "HasInterrupt", nil, nil, 1, 2)--Don't really want to hard interrupt warning for something with 10 second cast, this is opt in

--mod:AddTimerLine(BOSS)
local timerFocusContainerCD						= mod:NewNextTimer(120, "ej22424", nil, nil, nil, 6, 331456)
local timerExposedDesiresCD						= mod:NewCDTimer(8.5, 325379, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--8.5-25 because yeah, boss spell queuing+CD even changing when higher rank
local timerBottledAnimaCD						= mod:NewCDTimer(10.8, 325769, nil, nil, nil, 3)--10-36
local timerSinsandSufferingCD					= mod:NewCDTimer(44.3, 325064, nil, nil, nil, 3)
local timerConcentratedAnimaCD					= mod:NewCDTimer(35.4, 332665, nil, nil, nil, 1, nil, nil, nil, 1, 3)--Technically targetted(3) bar type as well, but since bar is both, and 2 other bars are already 3s, 1 makes more sense

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(325225, true)
mod:AddSetIconOption("SetIconOnSharedSuffering", 324983, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnAdds", "ej21227", true, true, {5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)
--mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
--mod:AddDropdownOption("InterruptBehavior", {"Four", "Five", "Six", "NoReset"}, "Four", "misc")

mod.vb.sufferingIcon = 1
mod.vb.addIcon = 8
mod.vb.containerActive = 0
local castsPerGUID = {}
local playerName = UnitName("player")

--[[
Notes:
1. Sequencing looks good at first, but it falls apart when changes to container power levels ranks must affect timers
2. It seems abilities get faster when the container for that ability is active, but that might be purely related to energy level
Possibility: Basetimer*energymodifier
Possibility2: Each ability just has two cds based on if container empowered or not and spell queuing + standard variations account for other variances
Possibility3: Same as 2, only each ability has 4 CDs, not 2 and timers of all 4 change with each container empowerment
Mod currently deploys number 2 for now since a lot more data needed to substanciate number 1, namely a working widget api for transcriptor or DBM debug to do more accessment
"Bottled Anima-325774-npc:165521 = pull:29.4, 34.0, 19.6, 26.8, 10.8, 14.9, 18.3, 17.4, 18.3, 33.7, 36.9, 36.5", -- [2]
"Bottled Anima-325774-npc:165521 = pull:29.3, 34.1, 19.6, 21.1, 17.9, 14.7, 18.4, 17.4, 17.9, 28.8, 38.3, 38.3", -- [2]

"Concentrate Anima-332665-npc:165521 = pull:54.6, 35.4, 36.6, 35.7, 35.4, 41.4, 37.7, 35.3", -- [1]
"Concentrate Anima-332665-npc:165521 = pull:54.6, 35.4, 37.8, 35.5, 73.1, 37.8, 35.8", -- [1]

"Hidden Desire-335322-npc:171801 = pull:13.9, 9.4, 8.5, 8.9, 9.3, 8.9, 9.7, 8.2, 9.8, 8.5, 17.1, 10.9, 11.0, 11.0, 11.7, 10.6, 13.4, 11.0, 25.2, 15.0, 13.4, 13.4, 13.4, 15.4, 12.6", -- [5]
"Hidden Desire-335322-npc:171801 = pull:13.9, 9.7, 9.8, 8.5, 9.3, 8.5, 9.8, 9.8, 8.6, 19.9, 11.8, 12.2, 11.0, 11.0, 13.2, 11.2, 11.0, 24.4, 14.6, 13.8, 13.0, 13.5, 13.0, 13.0", -- [5]

"Sins and Suffering-325064-npc:165521 = pull:18.0, 26.8, 26.5, 40.2, 33.0, 35.3, 29.3, 17.4, 19.5, 19.1, 18.3", -- [13]
"Sins and Suffering-325064-npc:165521 = pull:18.9, 26.8, 26.8, 26.9, 43.9, 35.7, 33.8, 17.5, 18.3, 19.5, 18.2", -- [18]
--]]

--[[
--TODO, rework this
local function delayedWarpedDesiresCheck(self)
	local bossPower = UnitPower("boss1")--Alternate power or main boss powere?
	if bossPower and bossPower >= 75 then--Verify. rank 3 activating at 75 is total assumption
		specWarnChangeofHeart:Show()
		specWarnChangeofHeart:Play("runout")
		yellChangeofHeartFades:Countdown(5)
	end
end
--]]

function mod:OnCombatStart(delay)
	self.vb.containerActive = 0
	table.wipe(castsPerGUID)
	timerExposedDesiresCD:Start(13.9-delay)
	timerSinsandSufferingCD:Start(18-delay)
	timerBottledAnimaCD:Start(29.3-delay)
	timerConcentratedAnimaCD:Start(54.6-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
--		DBM.InfoFrame:Show(3, "enemypower")--TODO, add right power type
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325379 then
		--1 Expose Desires (tank), 2 Bottled Anima (bouncing bottles), 3 Sins and Suffering (links), 4 Concentrate Anima (adds)
		timerExposedDesiresCD:Start(self.vb.containerActive == 1 and 8.2 or 10.6)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnExposeDesires:Show()
			specWarnExposeDesires:Play("defensive")
		end
	elseif spellId == 332665 then
		self.vb.addIcon = 8
		--1 Expose Desires (tank), 2 Bottled Anima (bouncing bottles), 3 Sins and Suffering (links), 4 Concentrate Anima (adds)
		timerConcentratedAnimaCD:Start(self.vb.containerActive == 4 and 35.3 or 35.3)--Not enough data to determine if it changes or not
	elseif spellId == 331550 or spellId == 334017 then--Conjured Manifestation / Harnessed Specter (only used if not actively tanked)
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds and self.vb.addIcon > 3 then--Only use up to 5 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
--		if (self.vb.interruptBehavior == "Four" and castsPerGUID[args.sourceGUID] == 4) or (self.vb.interruptBehavior == "Five" and castsPerGUID[args.sourceGUID] == 5) or (self.vb.interruptBehavior == "Six" and castsPerGUID[args.sourceGUID] == 6) then
--			castsPerGUID[args.sourceGUID] = 0
--		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCondemn:Show(args.sourceName, count)
			if count == 1 then
				specWarnCondemn:Play("kick1r")
			elseif count == 2 then
				specWarnCondemn:Play("kick2r")
			elseif count == 3 then
				specWarnCondemn:Play("kick3r")
			elseif count == 4 then
				specWarnCondemn:Play("kick4r")
			elseif count == 5 then
				specWarnCondemn:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnCondemn:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325382 then
		local amount = args.amount or 1
		warnWarpedDesires:Show(args.destName, amount)
		if args:IsPlayer() then
--			self:Unschedule(delayedWarpedDesiresCheck)
--			self:Schedule(16, delayedWarpedDesiresCheck, self)--21-5, giving 5 seconds to run out
		else
			specWarnWarpedDesires:Show(args.destName)
			specWarnWarpedDesires:Play("tauntboss")
		end
	elseif spellId == 325936 then
		warnSharedCognition:CombinedShow(0.3, args.destName)
	elseif spellId == 324983 then
		warnSharedSuffering:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSharedSuffering:Show()
			specWarnSharedSuffering:Play("targetyou")
			yellSharedSuffering:Yell()
		end
		if self.Options.SetIconOnSharedSuffering and self.vb.sufferingIcon < 4 then--Icons for this are nice, but reserve 5 of them for adds
			self:SetIcon(args.destName, self.vb.sufferingIcon)
		end
		self.vb.sufferingIcon = self.vb.sufferingIcon + 1
	elseif spellId == 332664 then
		local bossPower = UnitPower("boss1")--Alternate power or main boss powere?
		if args:IsPlayer() then
--			if bossPower and bossPower >= 75 then--Verify. rank 3 activating at 75 is total assumption
--				specWarnConcentrateAnimaTo:Show(DBM_CORE_L.ALLIES)
--				specWarnConcentrateAnimaTo:Play("gathershare")
--				yellConcentrateAnimaFades:Countdown(spellId)--YELL (RED letters for soak)
--			else
				specWarnConcentrateAnimaAway:Show()
				specWarnConcentrateAnimaAway:Play("runout")
				yellConcentrateAnimaFades:CountdownSay(spellId)--SAY (white letters for avoid)
--			end
		else
			--Need allies to soak
--			if bossPower and bossPower >= 75 then
--				specWarnConcentrateAnimaTo:Show(args.destName)
--				specWarnConcentrateAnimaTo:Play("gathershare")
--			else
				warnConcentrateAnima:Show(args.destName)
--			end
		end
	elseif spellId == 335396 then
		if args:IsPlayer() then
			specWarnHiddenDesire:Show()
			specWarnHiddenDesire:Play("targetyou")
			yellHiddenDesire:Yell()
		else
			specWarnHiddenDesireTaunt:Show(args.destName)
			specWarnHiddenDesireTaunt:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 325382 then
--		if args:IsPlayer() then
--			self:Unschedule(delayedWarpedDesiresCheck)
			--yellChangeofHeartFades:Cancel()
--		end
	elseif spellId == 332664 then
		if args:IsPlayer() then
			yellConcentrateAnimaFades:Cancel()
		end
	elseif spellId == 324983 then
		if self.Options.SetIconOnSharedSuffering then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 170199 then--Harnessed Specter

	elseif cid == 170197 then--Conjured Manifestation

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 325713 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--TODO, maybe these scripts run, if so detecting ranks could be cleaner
--Concentrate Anima: Rank 1 326258, Rank 2 325922, rank 3 325923
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 325774 then--Bottled Anima
		warnBottledAnima:Show()
		timerBottledAnimaCD:Start(self.vb.containerActive == 2 and 14.7 or 33.7)
	elseif spellId == 325064 then--Sins and Suffering
		self.vb.sufferingIcon = 1
		--1 Expose Desires (tank), 2 Bottled Anima (bouncing bottles), 3 Sins and Suffering (links), 4 Concentrate Anima (adds)
		timerSinsandSufferingCD:Start(self.vb.containerActive == 3 and 17.5 or 26.8)
	elseif spellId == 338749 then--Disable Container
		timerFocusContainerCD:Start(99.5)
		--1 Expose Desires (tank), 2 Bottled Anima (bouncing bottles), 3 Sins and Suffering (links), 4 Concentrate Anima (adds)
		self.vb.containerActive = self.vb.containerActive + 1
		if self.vb.containerActive == 5 then
			self.vb.containerActive = 1
		end
	end
end

--[[
	--Assmonkey
	"<1.02 18:39:08> [UPDATE_UI_WIDGET] widgetID:2401, widgetType:2, widgetSetID:2", -- [33]
	"<1.03 18:39:08> [UPDATE_UI_WIDGET] widgetID:2380, widgetType:2, widgetSetID:2", -- [34]
	"<1.03 18:39:08> [UPDATE_UI_WIDGET] widgetID:2399, widgetType:2, widgetSetID:2", -- [35]
	"<1.04 18:39:08> [UPDATE_UI_WIDGET] widgetID:2400, widgetType:2, widgetSetID:2", -- [36]
--]]
