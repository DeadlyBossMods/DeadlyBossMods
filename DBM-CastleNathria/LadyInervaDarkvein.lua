local mod	= DBM:NewMod(2420, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167517)
mod:SetEncounterID(2406)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325379 325774 325064 332665 331550",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 325382 325936 324983 332664",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 325382 325936 324983 332664",
	"SPELL_PERIODIC_DAMAGE 325713",
	"SPELL_PERIODIC_MISSED 325713"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify tank stuff (power levels for runout, number of targets of shared cog, etc)
--TODO, find out correct powere type for boss, or alternate means of detecting the bosses spell ranks
--TODO, near 100% chance trigger for bottled anima is wrong. it's really hard to guess the correct one with no clear cast spellId, it's probably not a CLEU trigger
--TODO, verify shared suffering spellIds and combat log order being valid way of attributing links
--TODO, does https://shadowlands.wowhead.com/spell=331573/unconscionable-guilt need anything?
local warnSharedCognition						= mod:NewTargetNoFilterAnnounce(325936, 4, nil, "Healer")
local warnBottledAnima							= mod:NewSpellAnnounce(325769, 2)
local warnSharedSuffering						= mod:NewTargetNoFilterAnnounce(309980, 3)
local warnConcentrateAnima						= mod:NewTargetAnnounce(332664, 3)
--Anima Constructs
local warnCondemn								= mod:NewCountAnnounce(331550, 2, nil, "HasInterrupt")

local specWarnExposeDesires						= mod:NewSpecialWarningDefensive(325379, false, nil, nil, 1, 2)--Optional warning that the cast is happening toward you
local specWarnWarpedDesires						= mod:NewSpecialWarningTaunt(325382, nil, nil, nil, 1, 2)
local specWarnChangeofHeart						= mod:NewSpecialWarningMoveAway(325384, nil, nil, nil, 3, 2)--Triggered by rank 3 Exposed Desires
local yellChangeofHeartFades					= mod:NewFadesYell(325384)--^^
local specWarnSharedSuffering					= mod:NewSpecialWarningMoveTo(324983, nil, nil, nil, 1, 2)
--local yellSharedSuffering						= mod:NewShortYell(324983)
local yellSharedSufferingRepeater				= mod:NewIconRepeatYell(324983, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnConcentrateAnimaAway				= mod:NewSpecialWarningMoveAway(332664, nil, nil, nil, 1, 2)--Rank 1-2
local specWarnConcentrateAnimaTo				= mod:NewSpecialWarningMoveTo(332664, nil, nil, nil, 1, 2)--Rank 3
local yellConcentrateAnimaFades					= mod:NewFadesYell(332664, nil, nil, nil, "YELL")--^^
local specWarnGTFO								= mod:NewSpecialWarningGTFO(325713, nil, nil, nil, 1, 8)
--Anima Constructs
local specWarnCondemn							= mod:NewSpecialWarningInterrupt(331550, false, nil, nil, 1, 2)--Don't really want to hard interrupt warning for something with 10 second cast, this is opt in

--mod:AddTimerLine(BOSS)
local timerExposedDesiresCD						= mod:NewAITimer(16.6, 325379, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerBottledAnimaCD						= mod:NewAITimer(44.3, 325769, nil, nil, nil, 3)
local timerSinsandSufferingCD					= mod:NewAITimer(44.3, 325064, nil, nil, nil, 3)
local timerConcentratedAnimaCD					= mod:NewAITimer(44.3, 332665, nil, nil, nil, 1, nil, nil, nil, 1, 3)--Technically targetted(3) bar type as well, but since bar is both, and 2 other bars are already 3s, 1 makes more sense

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(325225, true)
mod:AddSetIconOption("SetIconOnSharedCog", 325936, true, false, {1, 2, 3})--TODO, number of icons needed
mod:AddSetIconOption("SetIconOnAdds", "ej21227", true, true, {4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)
--mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
--mod:AddDropdownOption("InterruptBehavior", {"Four", "Five", "Six", "NoReset"}, "Four", "misc")

mod.vb.addIcon = 8
local sharedCogIcons = {}
local SharedSufferingTargets = {}
local castsPerGUID = {}
local playerName = UnitName("player")

local function delayedWarpedDesiresCheck(self)
	local bossPower = UnitPower("boss1")--Alternate power or main boss powere?
	if bossPower and bossPower >= 75 then--Verify. rank 3 activating at 75 is total assumption
		specWarnChangeofHeart:Show()
		specWarnChangeofHeart:Play("runout")
		yellChangeofHeartFades:Countdown(5)
	end
end

local function warnSharedSufferingTargets(self)
	warnSharedSuffering:Show(table.concat(SharedSufferingTargets, "<, >"))
	table.wipe(SharedSufferingTargets)
end

local function sharedSufferingYellRepeater(self, text)
	yellSharedSufferingRepeater:Yell(text)
	self:Schedule(2, sharedSufferingYellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	table.wipe(sharedCogIcons)
	table.wipe(SharedSufferingTargets)
	table.wipe(castsPerGUID)
	timerExposedDesiresCD:Start(1-delay)
	timerBottledAnimaCD:Start(1-delay)
	timerSinsandSufferingCD:Start(1-delay)
	timerConcentratedAnimaCD:Start(1-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower")--TODO, add right power type
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
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
		table.wipe(sharedCogIcons)
		timerExposedDesiresCD:Start()
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnExposeDesires:Show()
			specWarnExposeDesires:Play("defensive")
		end
	elseif spellId == 325774 then
		warnBottledAnima:Show()
		timerBottledAnimaCD:Start()
	elseif spellId == 325064 then
		timerSinsandSufferingCD:Start()
	elseif spellId == 332665 then
		self.vb.addIcon = 8
		timerConcentratedAnimaCD:Start()
	elseif spellId == 331550 then
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
		local addnumber, count = #castsPerGUID, castsPerGUID[args.sourceGUID]
		if self.Options.SpecWarn331550interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
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
		else
			warnCondemn:Show(addnumber.."-"..count)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325379 then
		if args:IsPlayer() then
			self:Schedule(16, delayedWarpedDesiresCheck, self)--21-5, giving 5 seconds to run out
		else
			specWarnWarpedDesires:Show(args.destName)
			specWarnWarpedDesires:Play("tauntboss")
		end
	elseif spellId == 325936 then
		sharedCogIcons[#sharedCogIcons + 1] = args.destName
		warnSharedCognition:CombinedShow(0.3, args.destName)
		if self.Options.SetIconOnSharedCog then
			self:SetIcon(args.destName, #sharedCogIcons)
		end
	elseif spellId == 324983 then
		SharedSufferingTargets[#SharedSufferingTargets + 1] = args.destName
		self:Unschedule(warnSharedSufferingTargets)
		self:Schedule(0.3, warnSharedSufferingTargets, self)
		local icon
		if #SharedSufferingTargets % 2 == 0 then
			icon = #SharedSufferingTargets / 2--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			local playerIsInPair = false
			--TODO, likely not everyone in raid gets it, so this custom code is probably not needed
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			end
			if SharedSufferingTargets[#SharedSufferingTargets-1] == playerName then
				specWarnSharedSuffering:Show(SharedSufferingTargets[#SharedSufferingTargets])
				specWarnSharedSuffering:Play("gather")
				playerIsInPair = true
			elseif SharedSufferingTargets[#SharedSufferingTargets] == playerName then
				specWarnSharedSuffering:Show(SharedSufferingTargets[#SharedSufferingTargets-1])
				specWarnSharedSuffering:Play("gather")
				playerIsInPair = true
			end
			if playerIsInPair then--Only repeat yell on mythic and mythic+
				self:Unschedule(sharedSufferingYellRepeater)
				if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
				self:Schedule(2, sharedSufferingYellRepeater, self, icon)
				yellSharedSufferingRepeater:Yell(icon)
			end
		end
--		if args:IsPlayer() then
--			yellSharedSuffering:Yell()
--		end
	elseif spellId == 332664 then
		local bossPower = UnitPower("boss1")--Alternate power or main boss powere?
		if args:IsPlayer() then
			if bossPower and bossPower >= 75 then--Verify. rank 3 activating at 75 is total assumption
				specWarnConcentrateAnimaTo:Show(DBM_CORE_L.ALLIES)
				specWarnConcentrateAnimaTo:Play("gathershare")
				yellConcentrateAnimaFades:Countdown(spellId)--YELL (RED letters for soak)
			else
				specWarnConcentrateAnimaAway:Show()
				specWarnConcentrateAnimaAway:Play("runout")
				yellConcentrateAnimaFades:CountdownSay(spellId)--SAY (white letters for avoid)
			end
		else
			--Need allies to soak
			if bossPower and bossPower >= 75 then
				specWarnConcentrateAnimaTo:Show(args.destName)
				specWarnConcentrateAnimaTo:Play("gathershare")
			else
				warnConcentrateAnima:Show(args.destName)
			end
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 325379 then
		if args:IsPlayer() then
			yellChangeofHeartFades:Cancel()
		end
	elseif spellId == 325936 then
		if self.Options.SetIconOnSharedCog then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 324983 then
		if args:IsPlayer() then
			self:Unschedule(sharedSufferingYellRepeater)
		end
	elseif spellId == 332664 then
		if args:IsPlayer() then
			yellConcentrateAnimaFades:Cancel()
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

--[[
--TODO, maybe these scripts run, if so detecting ranks could be cleaner
--Concentrate Anima: Rank 1 326258, Rank 2 325922, rank 3 325923
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
