local mod	= DBM:NewMod(2460, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181548, 181551, 181546, 181549)
mod:SetEncounterID(2544)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20211220000000)
mod:SetMinSyncRevision(20211220000000)
--mod.respawnTime = 29
mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360295 360636 365272 361066 360845 364241 361304 361568 365126 366062 361300",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 361566 360333",
	"SPELL_AURA_APPLIED 360687 365269 361067 361278 362352 361608 361689 364839 366234",
	"SPELL_AURA_APPLIED_DOSE 361608",
	"SPELL_AURA_REMOVED 360687 361067 361278 361608",
	"SPELL_AURA_REMOVED_DOSE 361608 361689",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, warn on pinning volley emote instead (pre warning instead of warning when channel starts)
--TODO, warn on Wild Stampede emote instead?
--TODO, Find Phase 3 cd of necrotic ritual (between casts)
--TODO, maybe add https://ptr.wowhead.com/spell=362270/anima-shelter tracking to infoframe? seems like might already be crowded though just monitoring sin stacks and deathtouch
--TODO, tanks wap for Wracking Pain? Feels like tank should just eat it vs putting 2 bosses on one tank for only 25%
--[[
(ability.id = 360295 or ability.id = 360636 or ability.id = 365272 or ability.id = 361066 or ability.id = 361304 or ability.id = 361568 or ability.id = 365126 or ability.id = 361300 or ability.id = 366062) and type = "begincast"
 or ability.id = 361789 and type = "cast" or ability.id = 360838
 or (ability.id = 361278 or ability.id = 366234) and (type = "applybuff" or type = "applydebuff")
 or (ability.id = 360845 or ability.id = 361044) and type = "begincast"
--]]
local ProtoWar, ProtoDuty, ProtoRenewl, ProtoAbsolution = DBM:EJ_GetSectionInfo(24125), DBM:EJ_GetSectionInfo(24130), DBM:EJ_GetSectionInfo(24135), DBM:EJ_GetSectionInfo(24139)
--General
local warnCompleteRecon							= mod:NewCastAnnounce(366062, 4)
--Stage One: War and Duty
----Prototype of War
mod:AddOptionLine(ProtoWar, "announce")
local warnRunecarversDeathtouch					= mod:NewTargetNoFilterAnnounce(360687, 3)
----Prototype of Duty
mod:AddOptionLine(ProtoDuty, "announce")
local warnAscensionsCall						= mod:NewCountAnnounce(361066, 2)
local warnBastionsWard							= mod:NewCastAnnounce(360845, 1)
local warnPinned								= mod:NewTargetNoFilterAnnounce(362352, 4)
--Stage Two: Sin and Seed
----Prototype of Absolution

--Stage One: War and Duty
----Prototype of War
mod:AddOptionLine(ProtoWar, "specialannounce")
mod:AddOptionLine(ProtoWar, "yell")
local specWarnNecroticRitual					= mod:NewSpecialWarningSwitch(360295, "-Healer", nil, nil, 1, 2)
local specWarnDeathtouch						= mod:NewSpecialWarningMoveAway(360687, nil, nil, nil, 1, 2)
local yellDeathtouch							= mod:NewShortPosYell(360687)
----Prototype of Duty
mod:AddOptionLine(ProtoDuty, "specialannounce")
mod:AddOptionLine(ProtoDuty, "yell")
local specWarnHumblingStrikes					= mod:NewSpecialWarningDefensive(365272, nil, nil, nil, 1, 2)
local specWarnHumblingStrikesTaunt				= mod:NewSpecialWarningTaunt(365269, nil, nil, nil, 1, 2)
local specWarnPinningVolley						= mod:NewSpecialWarningDodge(361278, nil, nil, nil, 2, 2)--Is it dodgeable?
local yellPinned								= mod:NewShortYell(362352)
--Stage Two: Sin and Seed
----Prototype of Renewal
mod:AddOptionLine(ProtoRenewl, "specialannounce")
--mod:AddOptionLine(ProtoRenewl, "yell")
local specWarnAnimabolt							= mod:NewSpecialWarningInterrupt(362383, false, nil, nil, 1, 2)--Kinda spammed, opt in, not opt out
local specWarnWildStampede						= mod:NewSpecialWarningDodge(361304, nil, nil, nil, 2, 2)
local specWarnAnimastorm						= mod:NewSpecialWarningMoveTo(362132, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
----Prototype of Absolution
mod:AddOptionLine(ProtoAbsolution, "specialannounce")
--mod:AddOptionLine(ProtoRenewl, "yell")
local specWarnSinfulProjection					= mod:NewSpecialWarningMoveAway(364839, nil, nil, nil, 2, 2)--Sound 2 because everyone gets it
local specWarnWrackingPain						= mod:NewSpecialWarningSpell(365126, nil, nil, nil, 1, 2)--Change to moveto?
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(361789, nil, nil, nil, 4, 2)

--mod:AddTimerLine(BOSS)

local timerCompleteRecon						= mod:NewCastTimer(20, 366062, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
--Stage One: War and Duty
----Prototype of War
mod:AddTimerLine(ProtoWar)
local timerNecroticRitualCD						= mod:NewCDTimer(71.4, 360295, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRunecarversDeathtouchCD				= mod:NewCDTimer(57.1, 360687, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Prototype of Duty
mod:AddTimerLine(ProtoDuty)
local timerHumblingStrikesCD					= mod:NewCDTimer(35.7, 365272, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAscensionsCallCD						= mod:NewCDTimer(57.1, 365272, nil, nil, nil, 1)
local timerPinningVolleyCD						= mod:NewCDTimer(64.1, 361278, nil, nil, nil, 3)
--Stage Two: Sin and Seed
----Prototype of Renewal
mod:AddTimerLine(ProtoRenewl)
local timerWildStampedeCD						= mod:NewCDTimer(28.8, 361304, nil, nil, nil, 3)
local timerWitheringSeedCD						= mod:NewCDTimer(96.2, 361568, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerAnimastormCD							= mod:NewCDTimer(28.8, 366234, nil, nil, nil, 2)
----Prototype of Absolution
mod:AddTimerLine(ProtoAbsolution)
local timerWrackingPainCD						= mod:NewCDTimer(44, 365126, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewCDCountTimer(56.2, 361789, nil, nil, nil, 2)--Also timer for sinful projections, the two mechanics are intertwined

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360687, true)
mod:AddIconLine(ProtoWar)
mod:AddSetIconOption("SetIconOnDeathtouch", 360687, false, false, {1, 2, 3, 4})--Technically only 2 debuffs go out, but we allow for even a bad group to have two sets of them out. Off by default do to conflict with seeds
mod:AddSetIconOption("SetIconOnRitualist", 360333, true, true, {5, 6, 7, 8})
mod:AddIconLine(ProtoRenewl)
mod:AddSetIconOption("SetIconOnSeed", 361566, true, true, {1, 2, 3, 4})
mod:AddNamePlateOption("NPAuraOnWrackingPain", 361689, true)

local deathtouchTargets = {}
local wardTargets = {}
local SinStacks = {}
mod.vb.callCount = 0
mod.vb.seedIcon = 1
mod.vb.ritualistIcon = 8
mod.vb.HandCount = 0
mod.vb.stampedeCast = 0

local updateInfoFrame
do
	local tsort, twipe = table.sort, table.wipe
	local lines, sortedLines = {}, {}
	local tempLines, tempLinesSorted = {}, {}
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
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
	self.vb.seedIcon = 1
	self.vb.HandCount = 0
	self:SetStage(1)
	--Necro
	timerNecroticRitualCD:Start(11.5-delay)
	timerRunecarversDeathtouchCD:Start(47.2-delay)
	--Kyrian
	timerHumblingStrikesCD:Start(11.5-delay)
	timerAscensionsCallCD:Start(42.9-delay)--Time til USCS anyways
	timerPinningVolleyCD:Start(63-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(26, "function", updateInfoFrame, false, true, true)--26 to show up to 4 debuffs and 20 sin stacks plus 2 headers
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
	if spellId == 360295 then
		self.vb.ritualistIcon = 8
		specWarnNecroticRitual:Show()
		specWarnNecroticRitual:Play("killmob")
		timerNecroticRitualCD:Start()
	elseif spellId == 360636 then
		timerRunecarversDeathtouchCD:Start(self.vb.phase == 1 and 57.1 or 123.2)
	elseif spellId == 365272 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnHumblingStrikes:Show()
			specWarnHumblingStrikes:Play("defensive")
		end
		timerHumblingStrikesCD:Start(self.vb.phase == 1 and 35.7 or 50)
	elseif spellId == 361066 then
		DBM:AddMsg("Ascensions call addedd back to combat log, notify DBM authors")
	elseif spellId == 360845 then
		warnBastionsWard:Show()
	elseif spellId == 364241 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAnimabolt:Show(args.sourceName)
		specWarnAnimabolt:Play("kickcast")
	--"<249.69 23:34:19> [DBM_Debug] CHAT_MSG_RAID_BOSS_EMOTE fired: Prototype of Renewal's Wild Stampede(361304)#2", -- [20927]
	--"<251.50 23:34:21> [CLEU] SPELL_CAST_START#Creature-0-4170-2481-3524-183421-0001BBBDD7#Wild Stampede##nil#361304#Wild Stampede#nil#nil", -- [21128]
	elseif spellId == 361304 then
		self.vb.stampedeCast = self.vb.stampedeCast + 1
		specWarnWildStampede:Show()
		specWarnWildStampede:Play("watchstep")
		--CD a little wierd and needs more monitoring.
		--"Wild Stampede-361604-npc:181546-00003BB832 = pull:142.9, 37.5, 25.0, 25.0, 60.2, 74.1, 76.7", -- [31]
		--"Wild Stampede-361604-npc:181546-00003BBA3D = pull:72.9, 37.2, 25.0, 25.0, 97.5, 25.0, 25.0", -- [20]
		--"Wild Stampede-361604-npc:181546-00003BBFF8 = pull:92.2, 37.2, 25.0, 25.5, 60.6, 77.2, 72.8, 75.4", -- [28]
		--"Wild Stampede-361604-npc:181546-00003BC2D5 = pull:99.6, 37.2, 25.0, 25.0, 58.2, 75.0, 76.7", -- [29]
		--"Wild Stampede-361604-npc:181546-00003BBDD7 = pull:105.7, 37.5, 25.0, 25.0, 48.2, 75.4, 73.7, 77.1", -- [30]
		timerWildStampedeCD:Start(self.vb.phase == 2 and self.vb.stampedeCast == 1 and 37.5 or self.vb.phase == 3 and 72.8 or 25)
	elseif spellId == 361568 then
		self.vb.seedIcon = 1
		timerWitheringSeedCD:Start(self.vb.phase == 2 and 95.6 or 74.4)
	elseif spellId == 365126 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnWrackingPain:Show()
			specWarnWrackingPain:Play("shockwave")
		end
		timerWrackingPainCD:Start(self.vb.phase == 2 and 44 or 50)
	elseif spellId == 366062 then
		warnCompleteRecon:Show()
		timerCompleteRecon:Start()
	elseif spellId == 361300 and self:AntiSpam(4, 1) then--Reconstruction
		self:SetStage(0)
		self.vb.stampedeCast = 0
		--Timers stoped in clearalldebuffs cast, here we only start them because that way we can use WCLs to maintain/update them
		if self.vb.phase == 2 then
			--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Start(26)
			timerHandofDestructionCD:Start(79.8, 1)
			--prototype-of-renewal (Night Fae)
			timerWitheringSeedCD:Start(18.5)
			timerAnimastormCD:Start(39.5)
			timerWildStampedeCD:Start(73)
		else--Stage 3
			--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Start(41.1)
			timerHandofDestructionCD:Start(104.5, 1)
			--prototype-of-duty (Kyrian)
			timerHumblingStrikesCD:Start(41.1)
			timerPinningVolleyCD:Start(58.1)--Or 53.5 to emote
			timerAscensionsCallCD:Start(121.2)
			--prototype-of-renewal (Night Fae)
			timerWitheringSeedCD:Start(17.8)
			timerWildStampedeCD:Start(27.3)--Or 25.5 to emote
			timerAnimastormCD:Start(53.3)
			--prototype-of-war (Necro)
			timerRunecarversDeathtouchCD:Start(129.5)
			timerNecroticRitualCD:Start(135.3)
		end
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
	if spellId == 361566 then--Withering Seeds
		if self.Options.SetIconOnSeed then
			self:ScanForMobs(args.destGUID, 2, self.vb.seedIcon, 1, nil, 12, "SetIconOnSeed", true)
		end
		self.vb.seedIcon = self.vb.seedIcon + 1--ascending from 1
	elseif spellId == 360333 then--Necrotic Ritualist
		if self.Options.SetIconOnRitualist then
			self:ScanForMobs(args.destGUID, 2, self.vb.ritualistIcon, 1, nil, 12, "SetIconOnRitualist", true)
		end
		self.vb.ritualistIcon = self.vb.ritualistIcon - 1--Descending from 8
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
		timerPinningVolleyCD:Start(self.vb.phase == 1 and 64.1 or 83.3)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 362352 then
		if args:IsPlayer() then
			yellPinned:Yell()
		end
		warnPinned:CombinedShow(0.5, args.destName)
	elseif spellId == 361608 then
		local amount = args.amount or 1
		SinStacks[args.destName] = amount
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update(0.4)--400ms batching to batch initial application and safe a lot of cpu
		end
	elseif spellId == 361689 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnWrackingPain then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 35)
		end
	elseif spellId == 364839 and args:IsPlayer() then
		specWarnSinfulProjection:Show()
		specWarnSinfulProjection:Play("scatter")
	elseif spellId == 366234 then
		specWarnAnimastorm:Show(DBM_COMMON_L.SHELTER)
		specWarnAnimastorm:Play("findshelter")
		timerAnimastormCD:Start(self.vb.phase == 2 and 67.4 or 165.4)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 181548 then--Prototype of Absolution (Venthyr)
		timerWrackingPainCD:Stop()
		timerHandofDestructionCD:Stop()
	elseif cid == 181551 then--prototype-of-duty (Kyrian)
		timerHumblingStrikesCD:Stop()
		timerAscensionsCallCD:Stop()
		timerPinningVolleyCD:Stop()
	elseif cid == 181546 then--prototype-of-renewal (Night Fae)
		timerWildStampedeCD:Stop()
		timerWitheringSeedCD:Stop()
		timerAnimastormCD:Stop()
	elseif cid == 181549 then--prototype-of-war (Necro)
		timerNecroticRitualCD:Stop()
		timerRunecarversDeathtouchCD:Stop()
--	elseif cid == 182045 then--Necrotic Ritual Skeletons

	end
end

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
	if spellId == 34098 then--ClearAllDebuffs (Boss Leaving)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 181548 then--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Stop()
			timerHandofDestructionCD:Stop()
		elseif cid == 181551 then--prototype-of-duty (Kyrian)
			timerHumblingStrikesCD:Stop()
			timerAscensionsCallCD:Stop()
			timerPinningVolleyCD:Stop()
		elseif cid == 181546 then--prototype-of-renewal (Night Fae)
			timerWildStampedeCD:Stop()
			timerWitheringSeedCD:Stop()
			timerAnimastormCD:Stop()
		elseif cid == 181549 then--prototype-of-war (Necro)
			timerNecroticRitualCD:Stop()
			timerRunecarversDeathtouchCD:Stop()
		end
	elseif spellId == 361066 then--Ascension's Call
		self.vb.callCount = self.vb.callCount + 1
		warnAscensionsCall:Show(self.vb.callCount)
		timerAscensionsCallCD:Start(self.vb.phase == 1 and 57.1 or 123.3)
	elseif spellId == 361791 and self:AntiSpam(10, 10) then--Script Activating to cast Hand of Destruction (2 sec faster than SUCCESS 361789)
		self.vb.HandCount = self.vb.HandCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		timerHandofDestructionCD:Start(self.vb.phase == 2 and 56.2 or 75, self.vb.HandCount+1)
	end
end
