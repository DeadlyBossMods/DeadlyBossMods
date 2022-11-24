local mod	= DBM:NewMod(2439, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175726)--Skyja (TODO, add other 2 and set health to highest?)
mod:SetEncounterID(2429)
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20210720000000)--2021-07-20
mod:SetMinSyncRevision(20210713000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350202 350342 350339 350365 350283 350385 350467 352744 350541 350482 350687 350475 355294 352756 352752",
	"SPELL_CAST_SUCCESS 350286 350745",
	"SPELL_AURA_APPLIED 350202 350158 350109 351139 350039 350542 350184 350483 350012 350078",
	"SPELL_AURA_APPLIED_DOSE 350202 350542",
	"SPELL_AURA_REMOVED 350158 350109 351139 350039 350542 350184 350483",
--	"SPELL_AURA_REMOVED_DOSE 350542",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, tank swap stacks
--TODO, how many formless mass spawn in higher difficulties? Find out total needed icons
--TODO, marking anything else??
--[[
(ability.id = 350202 or ability.id = 350342 or ability.id = 350365 or ability.id = 352756 or ability.id = 350385 or ability.id = 352752 or ability.id = 350467 or ability.id = 352744 or ability.id = 350541 or ability.id = 350482 or ability.id = 350687 or ability.id = 350475 or ability.id = 355294 or ability.id = 350339) and type = "begincast"
 or (ability.id = 350745 or ability.id = 350286) and type = "cast"
 or (target.id = 177095 or target.id = 177094) and type = "death"
--]]
--Stage One: The Unending Voice
mod:AddOptionLine(DBM:EJ_GetSectionInfo(22877), "announce")
----Kyra, The Unending
mod:AddOptionLine(DBM:EJ_GetSectionInfo(23202), "announce")
local warnUnendingStrike						= mod:NewStackAnnounce(350202, 2, nil, "Tank|Healer")

local specWarnUnendingStrike					= mod:NewSpecialWarningStack(350202, nil, 3, nil, nil, 1, 6)
local specWarnUnendingStrikeTaunt				= mod:NewSpecialWarningTaunt(350202, nil, nil, nil, 1, 2)
local specWarnFormlessMass						= mod:NewSpecialWarningSwitchCount(350342, "Dps", nil, nil, 1, 2)
local specWarnSiphonVitality					= mod:NewSpecialWarningInterruptCount(350339, "HasInterrupt", nil, nil, 1, 2)
local specWarnWingsofRage						= mod:NewSpecialWarningRun(350365, nil, nil, nil, 4, 2)

local timerUnendingStrikeCD						= mod:NewCDTimer(6.7, 350202, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--6.7-14.7
local timerFormlessMassCD						= mod:NewCDCountTimer(47.3, 350342, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerWingsofRageCD						= mod:NewCDCountTimer(72.9, 350365, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnFormlessMass", 350342, true, true, {7, 8, 6})
----Signe, The Voice
mod:AddOptionLine(DBM:EJ_GetSectionInfo(23203), "announce")
--local warnBloodLantern						= mod:NewTargetNoFilterAnnounce(341684, 2)

local specWarnSoulfulBlast						= mod:NewSpecialWarningInterrupt(350283, false, nil, nil, 1, 2)--Opt in, only some should be doing this one, plus it's spammy as hell
local specWarnSongofDissolution					= mod:NewSpecialWarningInterrupt(350286, "HasInterrupt", nil, nil, 1, 2)
local specWarnReverberatingRefrain				= mod:NewSpecialWarningMoveTo(350385, nil, nil, nil, 3, 2)

local timerSongofDissolutionCD					= mod:NewCDCountTimer(19.4, 350286, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--19.4-25.5 (unless delayed massivley by another channel)
local timerReverberatingRefrainCD				= mod:NewCDCountTimer(73.1, 350385, nil, nil, nil, 2)
----Skyja, The First
mod:AddOptionLine(DBM:EJ_GetSectionInfo(23205), "announce")
local warnCalloftheValkyr						= mod:NewCountAnnounce(350467, 3)
local warnFragmentsofDestiny					= mod:NewTargetNoFilterAnnounce(350542, 3)
local warnFragmentsofDestinyStack				= mod:NewCountAnnounce(350542, 2)

local specWarnFragmentsofDestiny				= mod:NewSpecialWarningMoveAway(350542, nil, nil, nil, 1, 2)
local yellFragmentsofDestiny					= mod:NewShortPosYell(350542)--TODO, probably change to icon/numbered yell system based on icon/combatlog order

local timerCalloftheValkyrCD					= mod:NewCDCountTimer(52.3, 350467, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerFragmentsofDestinyCD					= mod:NewCDCountTimer(47.3, 350542, nil, nil, nil, 3, nil, nil, nil, 2, 3)

mod:AddInfoFrameOption(350542, true)
mod:AddSetIconOption("SetIconOnFragments", 350542, true, false, {1, 2, 3, 4})--Mythic says max 4, so probably the cap
------Call of the Val'kyr
mod:AddOptionLine(DBM:EJ_GetSectionInfo(23206), "announce")
local warnAnnhyldesBrightAegis					= mod:NewTargetNoFilterAnnounce(350158, 2, nil, "Tank")
local warnDaschlasMightyAnvil					= mod:NewTargetAnnounce(350184, 2)
local warnBrynjasMournfulDirge					= mod:NewTargetAnnounce(350109, 2, nil, false)--On half the raid
local warnArthurasCrushingGaze					= mod:NewTargetNoFilterAnnounce(350039, 3)

local specWarnAgathasEternalblade				= mod:NewSpecialWarningDodge(350012, nil, nil, nil, 2, 2)
local specWarnDaschlasMightyAnvil				= mod:NewSpecialWarningMoveAway(350184, nil, nil, nil, 1, 2)
local yellDaschlasMightyAnvil					= mod:NewShortYell(350184)
local yellDaschlasMightyAnvilFades				= mod:NewShortFadesYell(350184)
local specWarnAradnesFallingStrike				= mod:NewSpecialWarningSoak(350078, nil, nil, nil, 1, 2)
local specWarnBrynjasMournfulDirge				= mod:NewSpecialWarningMoveAway(350109, nil, nil, nil, 1, 2)
local yellBrynjasMournfulDirge					= mod:NewShortYell(350109)
local yellBrynjasMournfulDirgeFades				= mod:NewShortFadesYell(350109)
local specWarnArthurasCrushingGaze				= mod:NewSpecialWarningMoveTo(350039, nil, nil, nil, 3, 2)
local yellArthurasCrushingGaze					= mod:NewYell(350039, nil, nil, nil, "YELL")
local yellArthurasCrushingGazeFades				= mod:NewShortFadesYell(350039, nil, nil, nil, "YELL")

mod:AddNamePlateOption("NPAuraOnBrightAegis", 350158)
--Stage Two: The First of the Mawsworn
mod:AddOptionLine(DBM:EJ_GetSectionInfo(22879), "announce")
local warnPierceSoul							= mod:NewStackAnnounce(350475, 2, nil, "Tank|Healer")
local warnResentment							= mod:NewCountAnnounce(355294, 3)
local warnLinkEssence							= mod:NewTargetNoFilterAnnounce(350483, 3)

local specWarnPierceSoul						= mod:NewSpecialWarningStack(350475, nil, 4, nil, nil, 1, 6)
local specWarnPierceSoulTaunt					= mod:NewSpecialWarningTaunt(350475, nil, nil, nil, 1, 2)
local specWarnLinkEssence						= mod:NewSpecialWarningDefensive(350483, nil, nil, nil, 1, 2, 3)
local specWarnWordofRecall						= mod:NewSpecialWarningSpell(350687, nil, nil, nil, 2, 2, 3)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerPierceSoulCD							= mod:NewCDTimer(9.7, 350475, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerResentmentCD							= mod:NewCDCountTimer(21.8, 355294, nil, nil, nil, 2)
local timerLinkEssenceCD						= mod:NewCDCountTimer(37.6, 350483, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerWordofRecallCD						= mod:NewCDCountTimer(72.9, 350687, nil, nil, nil, 2, nil, DBM_COMMON_L.HEROIC_ICON)
local berserkTimer								= mod:NewBerserkTimer(600)

local castsPerGUID = {}
local fragmentTargets = {}
--local expectedDebuffs = 3

mod.vb.valksDead = 11--1 not dead, 2 dead. 10s Kyra and 1s Signe
--mod.vb.addIcon = 8
mod.vb.valkCount = 0
mod.vb.fragmentCount = 0
mod.vb.resentmentCount = 0
mod.vb.massCount = 0
mod.vb.wingCount = 0
mod.vb.songCount = 0
mod.vb.refrainCount = 0
mod.vb.recallCount = 0
mod.vb.linkEssence = 0

local updateInfoFrame
do
	local twipe = table.wipe
	local lines, sortedLines = {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		for i = 1, 8 do
			if fragmentTargets[i] then
				addLine(L.Fragment..i, fragmentTargets[i])
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	table.wipe(fragmentTargets)
--	expectedDebuffs = self:IsMythic() and 4 or 3
	self:SetStage(1)
	self.vb.valksDead = 11
--	self.vb.addIcon = 8
	self.vb.valkCount = 0
	self.vb.fragmentCount = 0
	self.vb.resentmentCount = 0
	self.vb.massCount = 0
	self.vb.songCount = 0
	self.vb.refrainCount = 0
	self.vb.recallCount = 0
	self.vb.linkEssence = 0
	--Kyra
	timerUnendingStrikeCD:Start(6.3-delay)
	timerFormlessMassCD:Start(12-delay, 1)
	timerWingsofRageCD:Start(39.1-delay, 1)
	--Signe
	timerSongofDissolutionCD:Start(15.4-delay, 1)--15-19
	timerReverberatingRefrainCD:Start(60.3-delay, 1)--60+
	--Skyja
	timerCalloftheValkyrCD:Start(10.4-delay, 1)--10.4-15
	if self:IsMythic() then
		timerFragmentsofDestinyCD:Start(4.5-delay, 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(10, "function", updateInfoFrame, false, true, true)
		end
	end
	berserkTimer:Start(300-delay)--Phase 1
	if self.Options.NPAuraOnBrightAegis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnBrightAegis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350202 then
		timerUnendingStrikeCD:Start(self:IsEasy() and 11.7 or 6.9)--TODO, mythic might be faster and LFR even slower
	elseif spellId == 350342 then
--		self.vb.addIcon = 8
		self.vb.massCount = self.vb.massCount + 1
		specWarnFormlessMass:Show(self.vb.massCount)
		specWarnFormlessMass:Play("killmob")
		timerFormlessMassCD:Start(nil, self.vb.massCount+1)
		if self.Options.SetIconOnFormlessMass then--Only use up to 5 icons
			self:ScanForMobs(177407, 0, 8, 2, nil, 12, "SetIconOnFormlessMass")
		end
	elseif spellId == 350339 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnFormlessMass and self.vb.addIcon > 3 then--Only use up to 5 icons
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnFormlessMass")
--			end
--			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnSiphonVitality:Show(args.sourceName, count)
			if count < 6 then
				specWarnSiphonVitality:Play("kick"..count.."r")
			else
				specWarnSiphonVitality:Play("kickcast")
			end
		end
	elseif spellId == 350365 or spellId == 352756 then
		self.vb.wingCount = self.vb.wingCount + 1
		specWarnWingsofRage:Show()
		specWarnWingsofRage:Play("justrun")
--		if self.vb.valksDead == 11 or self.vb.valksDead == 12 then
			timerWingsofRageCD:Start(spellId == 350365 and 72.9 or 70.4, self.vb.wingCount+1)--TODO, maybe phase one is also 70 but just not very often? it's super rare in phase 2 as well.
--		end
	elseif spellId == 350283 and self:CheckInterruptFilter(args.sourceGUID, false, false) then
		specWarnSoulfulBlast:Show(args.sourceName)
		specWarnSoulfulBlast:Play("kickcast")
	elseif spellId == 350385 or spellId == 352752 then
		self.vb.refrainCount = self.vb.refrainCount + 1
		specWarnReverberatingRefrain:Show(args.sourceName)
		specWarnReverberatingRefrain:Play("findshelter")
--		if self.vb.valksDead == 11 or self.vb.valksDead == 21 then
			timerReverberatingRefrainCD:Start(spellId == 350385 and 72.8 or 71.8, self.vb.refrainCount+1)
--		end
	elseif spellId == 350467 then
		self.vb.valkCount = self.vb.valkCount + 1
		warnCalloftheValkyr:Show(self.vb.valkCount)
		timerCalloftheValkyrCD:Start(nil, self.vb.valkCount+1)
	elseif spellId == 352744 or spellId == 350541 then
		self.vb.fragmentCount = self.vb.fragmentCount + 1
		local timer = self:IsMythic() and (self.vb.phase == 1 and 33.2 or 37.3) or 47.3
		timerFragmentsofDestinyCD:Start(timer, self.vb.fragmentCount+1)
	elseif spellId == 350482 then
		self.vb.linkEssence = self.vb.linkEssence + 1
		timerLinkEssenceCD:Start(nil, self.vb.linkEssence+1)
	elseif spellId == 350687 then
		self.vb.recallCount = self.vb.recallCount + 1
		specWarnWordofRecall:Show(self.vb.recallCount)
		specWarnWordofRecall:Play("specialsoon")
		timerWordofRecallCD:Start(nil, self.vb.recallCount+1)
	elseif spellId == 350475 then
		timerPierceSoulCD:Start()
	elseif spellId == 355294 then
		self.vb.resentmentCount = self.vb.resentmentCount + 1
		warnResentment:Show(self.vb.resentmentCount)
		timerResentmentCD:Start(nil, self.vb.resentmentCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350286 then
		self.vb.songCount = self.vb.songCount + 1
		timerSongofDissolutionCD:Start(self:IsEasy() and 37.6 or 19.4, self.vb.songCount+1)
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnSongofDissolution:Show(args.sourceName)
			specWarnSongofDissolution:Play("kickcast")
		end
	elseif spellId == 350745 then--Skyja's Advance
		self:SetStage(2)
		--self.vb.fragmentCount = 0
		timerCalloftheValkyrCD:Stop()
		timerPierceSoulCD:Start(9.3)--9.3-13.3
		timerResentmentCD:Start(27.5, 1)--27.5-33.6
		timerCalloftheValkyrCD:Start(self:IsEasy() and 30 or 42.6, 1)--42.6-44
		timerFragmentsofDestinyCD:Stop()
		timerFragmentsofDestinyCD:Start(14.1, self.vb.fragmentCount+1)--14.1-17.4. Heroic and normal confirmed, mythic and LFR?
		if self:IsHard() then--Heroic and Mythic
			timerLinkEssenceCD:Start(24.7, 1)
			timerWordofRecallCD:Start(72.5, 1)
		end
		if self.Options.InfoFrame and not self:IsMythic() then--Mechanic starts in phase 2 on heroic, it already started on mythic in phase 1
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true, true)
		end
		if self:IsMythic() then
			--TODO, actually see what happens if they aren't dead by the time these timers expire
			timerWingsofRageCD:Start(56.7, self.vb.wingCount+1)
			timerReverberatingRefrainCD:Start(95.7, self.vb.refrainCount+1)
		end
		berserkTimer:Cancel()--Tecnically not accurate, Phase 1 berserk stops when both valks die. TODO, separate object
		berserkTimer:Start(602)--Phase 2
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350202 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnUnendingStrike:Show(amount)
				specWarnUnendingStrike:Play("stackhigh")
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 6.7) and not UnitIsDeadOrGhost("player") then
					specWarnUnendingStrikeTaunt:Show(args.destName)
					specWarnUnendingStrikeTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end
	elseif spellId == 350475 then
		local amount = args.amount or 1
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnPierceSoul:Show(amount)
				specWarnPierceSoul:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnPierceSoulTaunt:Show(args.destName)
					specWarnPierceSoulTaunt:Play("tauntboss")
				else
					warnPierceSoul:Show(args.destName, amount)
				end
			end
		else
			warnPierceSoul:Show(args.destName, amount)
		end
	elseif spellId == 350158 then
		warnAnnhyldesBrightAegis:CombinedShow(0.3, args.destName)
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic (350109 LFR confirmed)
		warnBrynjasMournfulDirge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBrynjasMournfulDirge:Show()
			specWarnBrynjasMournfulDirge:Play("runout")
			yellBrynjasMournfulDirge:Yell()
			yellBrynjasMournfulDirgeFades:Countdown(spellId)
		end
	elseif spellId == 350039 then
		if args:IsPlayer() then
			specWarnArthurasCrushingGaze:Show(DBM_COMMON_L.ALLIES)
			specWarnArthurasCrushingGaze:Play("gathershare")
			yellArthurasCrushingGaze:Yell()
			yellArthurasCrushingGazeFades:Countdown(spellId)
		else
			warnArthurasCrushingGaze:Show(args.destName)
		end
	elseif spellId == 350542 then
		local amount = args.amount or 1
		local icon = 0
		local uId = DBM:GetRaidUnitId(args.destName)
		for i = 1, 8 do--Only up to 8 icons
			if not fragmentTargets[i] then--Not yet assigned!
				icon = i
				fragmentTargets[i] = args.destName--Assign player name for infoframe even if they already have icon
				local currentIcon = GetRaidTargetIndex(uId) or 9--We want to set "no icon" as max index for below logic
				if currentIcon > i then--Automatically set lowest icon index on target, meaning star favored over circle, circle favored over triangle, etc.
					if self.Options.SetIconOnFragments then--Now do icon stuff, if enabled
						self:SetIcon(args.destName, i)
					end
				end
				break
			end
		end
		if amount == 1 then--Initial application from boss only
			if args:IsPlayer() then
				specWarnFragmentsofDestiny:Show(self:IconNumToTexture(icon))
				specWarnFragmentsofDestiny:Play("targetyou")
				if icon > 0 and icon < 9 then
					yellFragmentsofDestiny:Yell(icon, icon)
				end
			end
			warnFragmentsofDestiny:CombinedShow(0.3, args.destName)
		else
			if args:IsPlayer() then
				warnFragmentsofDestinyStack:Show(amount)
			end
		end
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 350483 then
		warnLinkEssence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLinkEssence:Show()
			specWarnLinkEssence:Play("defensive")
		end
	elseif spellId == 350184 then
		warnDaschlasMightyAnvil:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDaschlasMightyAnvil:Show()
			specWarnDaschlasMightyAnvil:Play("scatter")
			yellDaschlasMightyAnvil:Yell()
			yellDaschlasMightyAnvilFades:Countdown(spellId)
		end
	elseif spellId == 350012 then
		specWarnAgathasEternalblade:Show()
		specWarnAgathasEternalblade:Play("farfromline")
	elseif spellId == 350078 then
		specWarnAradnesFallingStrike:Show()
		specWarnAradnesFallingStrike:Play("helpsoak")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350158 then
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic
		if args:IsPlayer() then
			yellBrynjasMournfulDirgeFades:Cancel()
		end
	elseif spellId == 350039 then
		if args:IsPlayer() then
			yellArthurasCrushingGazeFades:Cancel()
		end
	elseif spellId == 350542 then
		--Combat log doesn't fire for each dose, removed removes ALL stacks
		for i = 1, 8 do
			if fragmentTargets[i] and fragmentTargets[i] == args.destName then--Found assignment matching this units name
				fragmentTargets[i] = nil--remove assignment
			end
		end
		if self.Options.SetIconOnFragments then
			self:SetIcon(args.destName, 0)
		end
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 350184 then
		if args:IsPlayer() then
			yellDaschlasMightyAnvilFades:Cancel()
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177407 then--Formless Mass
		castsPerGUID[args.destGUID] = nil
	elseif cid == 177095 then--Kyra
		self.vb.valksDead = self.vb.valksDead + 10
		timerUnendingStrikeCD:Stop()
		timerFormlessMassCD:Stop()
		timerWingsofRageCD:Stop()
	elseif cid == 177094 then--Signe
		self.vb.valksDead = self.vb.valksDead + 1
		timerSongofDissolutionCD:Stop()
		timerReverberatingRefrainCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 350745 then--Skyja's Advance

	end
end
--]]
