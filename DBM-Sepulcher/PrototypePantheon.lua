local mod	= DBM:NewMod(2460, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(175730)
mod:SetEncounterID(2544)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 364240 360295 360636 365272 361066 360845 364241 361304 361568 364865 365126",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 361566",
	"SPELL_AURA_APPLIED 360687 365269 361067 361278 362352 365422 362132 361608 361689",
	"SPELL_AURA_APPLIED_DOSE 361608",
	"SPELL_AURA_REMOVED 360687 361067 361278 365422 361608",
	"SPELL_AURA_REMOVED_DOSE 361608 361689",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, mythic might use https://ptr.wowhead.com/spell=366062/complete-reconstruction
--TODO, gloom bolt spammed or infrequent enough that timer and announce feel decent?
--TODO, auto mark Necrotic Ritualists, https://ptr.wowhead.com/spell=360333/necrotic-ritual maybe?
--TODO, is https://ptr.wowhead.com/spell=361277/pinning-volley used for volley instead. Is kyrians name Kalisthene?
--TODO, fix phase detection, it's likely flat wrong for p1 to p2 and p2 to p3 is non existant
--TODO, frequency of anima bolt isn't known to whether it needs a 2 or 3 person rotation, or if it's just spammed and a warning for it would just be annoying
--TODO, work on icons for icon options to ensure no overlap/stepping on one another. Both mechanics have valid reason to use icons but seeds will probably take prio
--TODO, maybe add https://ptr.wowhead.com/spell=362270/anima-shelter tracking to infoframe? seems like might already be crowded though just monitoring sin stacks and deathtouch
--TODO, tanks wap for Wracking Pain? Feels like tank should just eat it vs putting 2 bosses on one tank for only 25%
--TODO, verfy hand, but blizzard likely copy/pasted mechanic so the script that matches effects of sires hand is 361791
--Stage One: War and Duty
----Prototype of War
local warnRunecarversDeathtouch					= mod:NewTargetNoFilterAnnounce(360687, 3)
----Prototype of Duty
local warnAscensionsCall						= mod:NewCountAnnounce(361066, 2)
local warnBastionsWard							= mod:NewCastAnnounce(360845, 1)
local warnPinned								= mod:NewTargetNoFilterAnnounce(362352, 4)
--Stage Two: Sin and Seed
----Prototype of Absolution

--Stage One: War and Duty
----Prototype of War
local specWarnNecroticRitual					= mod:NewSpecialWarningSwitch(360295, "-Healer", nil, nil, 1, 2)
local specWarnDeathtouch						= mod:NewSpecialWarningMoveAway(360687, nil, nil, nil, 1, 2)
local yellDeathtouch							= mod:NewShortPosYell(360687)
----Prototype of Duty
local specWarnHumblingStrikes					= mod:NewSpecialWarningDefensive(365272, nil, nil, nil, 1, 2)
local specWarnHumblingStrikesTaunt				= mod:NewSpecialWarningTaunt(365269, nil, nil, nil, 1, 2)
local specWarnPinningVolley						= mod:NewSpecialWarningDodge(361278, nil, nil, nil, 2, 2)--Is it dodgeable?
local yellPinned								= mod:NewShortYell(362352)
--Stage Two: Sin and Seed
----Prototype of Renewal
local specWarnAnimabolt							= mod:NewSpecialWarningInterrupt(362383, false, nil, nil, 1, 2)
local specWarnWildStampede						= mod:NewSpecialWarningDodge(361304, nil, nil, nil, 2, 2)
local specWarnAnimastorm						= mod:NewSpecialWarningMoveTo(362132, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
----Prototype of Absolution
local specWarnSinfulProjection					= mod:NewSpecialWarningDodge(364865, nil, nil, nil, 2, 2)
local specWarnWrackingPain						= mod:NewSpecialWarningSpell(365126, nil, nil, nil, 1, 2)--Change to moveto?
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(361789, nil, nil, nil, 4, 2)

--mod:AddTimerLine(BOSS)
--Stage One: War and Duty
----Prototype of War
local timerGloomBoltCD							= mod:NewAITimer(28.8, 364240, nil, nil, nil, 3)
local timerNecroticRitualCD						= mod:NewAITimer(28.8, 360295, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRunecarversDeathtouchCD				= mod:NewAITimer(28.8, 360687, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Prototype of Duty
local timerHumblingStrikesCD					= mod:NewAITimer(28.8, 365272, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAscensionsCallCD						= mod:NewAITimer(28.8, 365272, nil, nil, nil, 1)
local timerPinningVolleyCD						= mod:NewAITimer(28.8, 361278, nil, nil, nil, 3)
--Stage Two: Sin and Seed
----Prototype of Renewal
local timerWildStampedeCD						= mod:NewAITimer(28.8, 361304, nil, nil, nil, 3)
local timerWitheringSeedCD						= mod:NewAITimer(28.8, 361568, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
----Prototype of Absolution
local timerSinfulProjectionCD					= mod:NewAITimer(28.8, 364865, nil, nil, nil, 3)
local timerWrackingPainCD						= mod:NewAITimer(28.8, 365126, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewAITimer(44.3, 361789, nil, nil, nil, 2)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360687, true)
mod:AddSetIconOption("SetIconOnDeathtouch", 360687, true, false, {1, 2, 3, 4})--Technically only 2, but we allow for even a bad group to have two sets of them out.
mod:AddSetIconOption("SetIconOnSeed", 361566, true, true, {5, 6, 7, 8})--Unknown quantity of seeds
mod:AddNamePlateOption("NPAuraOnWrackingPain", 361689, true)

local deathtouchTargets = {}
local wardTargets = {}
local SinStacks = {}
local expectedStacks = 6
mod.vb.callCount = 0
mod.vb.seedIcon = 5
mod.vb.HandCount = 0

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local sortedLines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--First, Runecarvers Deathtouch mechanics
		local firstdebuff = false
		for i = 1, 4 do
			if deathtouchTargets[i] then
				if not firstdebuff then
					firstdebuff = true
					addLine(L.Deathtouch, L.Dispel)--Set header for this section
				end
				local name = deathtouchTargets[i]
				if wardTargets[name] then
					addLine(name, "|cFF088A08"..YES.."|r")--Show green for safe dispel
				else
					addLine(name, "|cFFFF0000"..NO.."|r")--Show red for bad dispel
				end
			end
		end
		--Second, Sin stacks
		local hasSin = false
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			local count = SinStacks[unitName]
			if count then
				if not hasSin then
					hasSin = true
					addLine(L.Sin, L.Stacks)--Set header for this section
				end
				tempLines[unitName] = count
				tempLinesSorted[#tempLinesSorted + 1] = unitName
			end
		end
		--Sort Sin debuffs by highest then inject into regular table
		if hasSin then
			tsort(tempLinesSorted, sortFuncDesc)
			for _, name in ipairs(tempLinesSorted) do
				addLine(name, tempLines[name])
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(deathtouchTargets)
	table.wipe(wardTargets)
	table.wipe(SinStacks)
	self.vb.callCount = 0
	self.vb.seedIcon = 5
	self.vb.HandCount = 0
	self:SetStage(1)
	--Necro
	timerGloomBoltCD:Start(1-delay)
	timerNecroticRitualCD:Start(1-delay)
	timerRunecarversDeathtouchCD:Start(1-delay)
	--Kyrian
	timerHumblingStrikesCD:Start(1-delay)
	timerAscensionsCallCD:Start(1-delay)
	timerPinningVolleyCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(10, "function", updateInfoFrame, false, true, true)
	end
	if self:IsMythic() then
		expectedStacks = 6
	else
		if self:IsHeroic() then
			expectedStacks = 5
		else
			expectedStacks = 4
		end
	end
	if self.Options.NPAuraOnWrackingPain then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnWrackingPain then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 364240 then
		timerGloomBoltCD:Start()
	elseif spellId == 360295 then
		specWarnNecroticRitual:Show()
		specWarnNecroticRitual:Play("killmob")
		timerNecroticRitualCD:Start()
	elseif spellId == 360636 then
		timerRunecarversDeathtouchCD:Start()
	elseif spellId == 365272 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnHumblingStrikes:Show()
			specWarnHumblingStrikes:Play("defensive")
		end
		timerHumblingStrikesCD:Start()
	elseif spellId == 361066 then
		self.vb.callCount = self.vb.callCount + 1
		warnAscensionsCall:Show(self.vb.callCount)
		timerAscensionsCallCD:Start()
	elseif spellId == 360845 then
		warnBastionsWard:Show()
	elseif spellId == 364241 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAnimabolt:Show(args.sourceName)
		specWarnAnimabolt:Play("kickcast")
	elseif spellId == 361304 then
		specWarnWildStampede:Show()
		specWarnWildStampede:Play("watchstep")
		timerWildStampedeCD:Start()
	elseif spellId == 361568 then
		self.vb.seedIcon = 5
		timerWitheringSeedCD:Start()
	elseif spellId == 364865 then
		specWarnSinfulProjection:Show()
		specWarnSinfulProjection:Play("watchstep")
		timerSinfulProjectionCD:Start()
	elseif spellId == 365126 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnWrackingPain:Show()
			specWarnWrackingPain:Play("shockwave")
		end
		timerWrackingPainCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353931 then

	end
end
--]]

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 346469 then--Withering Seeds
		if self.Options.SetIconOnSeed then
			self:ScanForMobs(args.destGUID, 2, self.vb.seedIcon, 1, nil, 12, "SetIconOnSeed", true)
		end
		self.vb.seedIcon = self.vb.seedIcon + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 360687 then
		local icon = 0
		local uId = DBM:GetRaidUnitId(args.destName)
		for i = 1, 4 do--Only up to 4 icons
			if not deathtouchTargets[i] then--Not yet assigned!
				icon = i
				deathtouchTargets[i] = args.destName--Assign player name for infoframe even if they already have icon
				local currentIcon = GetRaidTargetIndex(uId) or 9--We want to set "no icon" as max index for below logic
				if currentIcon > i then--Automatically set lowest icon index on target, meaning star favored over circle, circle favored over triangle, etc.
					if self.Options.SetIconOnDeathtouch then--Now do icon stuff, if enabled
						self:SetIcon(args.destName, i)
					end
				end
				break
			end
		end
		if args:IsPlayer() then
			specWarnDeathtouch:Show(self:IconNumToTexture(icon))
			specWarnDeathtouch:Play("targetyou")
			if icon > 0 and icon < 9 then
				yellDeathtouch:Yell(icon, icon)
			end
		end
		warnRunecarversDeathtouch:CombinedShow(0.3, args.destName)
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 365269 and not args:IsPlayer() then
		specWarnHumblingStrikesTaunt:Show(args.destName)
		specWarnHumblingStrikesTaunt:Play("tauntboss")
	elseif spellId == 361067 then
		wardTargets[args.destName] = true
	elseif spellId == 361278 then
		specWarnPinningVolley:Show()
		specWarnPinningVolley:Play("watchstep")
		timerPinningVolleyCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 362352 then
		if args:IsPlayer() then
			yellPinned:Yell()
		end
		warnPinned:CombinedShow(0.5, args.destName)
	elseif spellId == 362132 then
		specWarnAnimastorm:Show(DBM_COMMON_L.SHELTER)
		specWarnAnimastorm:Play("findshelter")
	elseif spellId == 361608 then
		local amount = args.amount or expectedStacks
		SinStacks[args.destName] = amount
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 361689 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnWrackingPain then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 35)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 360687 then
		for i = 1, 4 do
			if deathtouchTargets[i] and deathtouchTargets[i] == args.destName then--Found assignment matching this units name
				deathtouchTargets[i] = nil--remove assignment
			end
		end
		if self.Options.SetIconOnDeathtouch then
			self:SetIcon(args.destName, 0)
		end
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 361067 then
		wardTargets[args.destName] = nil
	elseif spellId == 361278 and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 365422 and self.vb.phase < 2 then--Ephemeral Exhaust
		self:SetStage(2)
		--Night Fae
		timerWildStampedeCD:Start(2)
		timerWitheringSeedCD:Start(2)
		--Venthyr
		timerSinfulProjectionCD:Start(2)
		timerHandofDestructionCD:Start(2)
	elseif spellId == 361608 then
		SinStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 361689 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnWrackingPain then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 361608 then
		SinStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 182045 then--Necrotic Ritual Skeletons

	end
end
-]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--https://ptr.wowhead.com/spell=365422/ephemeral-exhaust
--https://ptr.wowhead.com/npc=182822 (WitheringSeed)
--https://ptr.wowhead.com/npc=182664 (Wild Stampede)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 365422 then--ephemeral-exhaust
		--Necro
		timerGloomBoltCD:Stop()
		timerNecroticRitualCD:Stop()
		timerRunecarversDeathtouchCD:Stop()
		--Kyrian
		timerHumblingStrikesCD:Stop()
		timerAscensionsCallCD:Stop()
		timerPinningVolleyCD:Stop()
	elseif spellId == 361791 and self:AntiSpam(10, 10) then--Script Activating to cast Hand of Destruction
		self.vb.HandCount = self.vb.HandCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		timerHandofDestructionCD:Start()--, self.vb.HandCount+1
	end
end
