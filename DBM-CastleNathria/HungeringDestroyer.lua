local mod	= DBM:NewMod(2428, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164261)
mod:SetEncounterID(2383)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20201214000000)--2020, 12, 14
mod:SetMinSyncRevision(20201214000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 334522 329758 334266 329455 329774 338621",
	"SPELL_CAST_SUCCESS 329774",
	"SPELL_AURA_APPLIED 329298 334755 334228 332295 329725 334064",
	"SPELL_AURA_APPLIED_DOSE 334755 332295",
	"SPELL_AURA_REMOVED 329298 334755 334228",
	"RAID_BOSS_WHISPER"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine tune stacks for essence sap
--TODO, better way to detect expunge? It needs to be added to combat log
--TODO, choose what infoframe tracks, sap, or volatile. volatile will be new default sine it's useful to more difficulties. This is on hold until it's in combat log though
--[[
(ability.id = 334522 or ability.id = 334266 or ability.id = 329455 or ability.id = 329774 or ability.id = 338621) and type = "begincast"
 or ability.id = 329298 and type = "applydebuff"
--]]
local warnGluttonousMiasma						= mod:NewTargetNoFilterAnnounce(329298, 4, nil, nil, 212238)
local warnVolatileEjection						= mod:NewTargetNoFilterAnnounce(334266, 4, nil, nil, 202046)

local specWarnGluttonousMiasma					= mod:NewSpecialWarningYouPos(329298, nil, 212238, nil, 1, 2)
local yellGluttonousMiasma						= mod:NewShortPosYell(329298, 212238, false, 2)
local specWarnEssenceSap						= mod:NewSpecialWarningStack(334755, false, 8, nil, 2, 1, 6)--Mythic, spammy, opt in
local specWarnConsume							= mod:NewSpecialWarningRun(334522, nil, nil, nil, 4, 2)
local specWarnExpunge							= mod:NewSpecialWarningMoveAway(329725, nil, nil, nil, 1, 2)
local specWarnVolatileEjectionPerWarn			= mod:NewSpecialWarningSoon(334266, false, 202046, nil, 2, 2)--Optional prewarn special warning, for the cast (before you know the targets)
local specWarnVolatileEjection					= mod:NewSpecialWarningYou(334266, nil, 202046, nil, 1, 2)
local yellVolatileEjection						= mod:NewYell(334266, 202046)--ShortText "beam". Change to NewPosYell if it's ever added to combat log, can't be trusted as icon yell when relying on syncing
local specWarnGrowingHunger						= mod:NewSpecialWarningCount(332295, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.stack:format(6, 332295), nil, 1, 2)
local specWarnGrowingHungerOther				= mod:NewSpecialWarningTaunt(332295, nil, nil, nil, 1, 2)
local specWarnOverwhelm							= mod:NewSpecialWarningDefensive(329774, "Tank", nil, nil, 1, 2)
local specWarnOverwhelmTaunt					= mod:NewSpecialWarningTaunt(329774, nil, nil, nil, 1, 2)

local timerGluttonousMiasmaCD					= mod:NewCDCountTimer(23.8, 329298, 212238, nil, nil, 3, nil, nil, nil, 1, 3)--Short text, Miasma
local timerConsumeCD							= mod:NewNextCountTimer(119.8, 334522, nil, nil, nil, 2)
local timerExpungeCD							= mod:NewNextCountTimer(44.3, 329725, nil, nil, nil, 3)
local timerVolatileEjectionCD					= mod:NewNextCountTimer(35.9, 334266, 202046, nil, nil, 3)--202046 for beam
local timerDesolateCD							= mod:NewNextCountTimer(59.8, 329455, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerOverwhelmCD							= mod:NewNextCountTimer(11.9, 329774, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 3)

local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddSetIconOption("SetIconOnGluttonousMiasma", 329298, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnVolatileEjection2", 334266, true, false, {5, 6, 7, 8})
mod:AddInfoFrameOption(nil, true)
mod:AddBoolOption("SortDesc", false)
mod:AddBoolOption("ShowTimeNotStacks", false)

local GluttonousTargets = {}
local essenceSapStacks = {}
local playerEssenceSap, playerVolatile = false, false
mod.vb.volatileIcon = 5
mod.vb.volatileCast = 0
mod.vb.miasmaCount = 0
mod.vb.miasmaIcon = 2--Starting at 2 because 1 is reserved for melee
mod.vb.expungeCount = 0
mod.vb.consumeCount = 0
mod.vb.desolateCount = 0
mod.vb.overwhelmCast = 0
mod.vb.meleeFound = false

local updateInfoFrame
do
	local DBM = DBM
	local GetPartyAssignment, GetTime, UnitGroupRolesAssigned, UnitIsDeadOrGhost, UnitPosition = GetPartyAssignment, GetTime, UnitGroupRolesAssigned, UnitIsDeadOrGhost, UnitPosition
	local ipairs, mfloor, twipe, tsort = ipairs, math.floor, table.wipe, table.sort
	local lines, tempLines, tempLinesSorted, sortedLines = {}, {}, {}, {}
	local function sortFuncAsc(a, b) return tempLines[a] < tempLines[b] end
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(tempLines)
		twipe(tempLinesSorted)
		twipe(sortedLines)
		--Player Personal Checks at the top
		if playerEssenceSap then
			local spellName, _, currentStack, _, _, expireTime = DBM:UnitDebuff("player", 334755)
			if spellName and currentStack and expireTime then
				addLine(spellName.." ("..currentStack..")", mfloor(expireTime-GetTime()))
			end
		end
		if playerVolatile then
			local spellName2, _, _, _, _, expireTime2 = DBM:UnitDebuff("player", 334228)
			if spellName2 and expireTime2 then
				addLine(spellName2, mfloor(expireTime2-GetTime()))
			end
		end
		--Add entire raids Essence Sap players on Mythic
		if mod.Options.ShowTimeNotStacks then
			--Higher Performance check that scans all debuff remaining times
			for uId in DBM:GetGroupMembers() do
				if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) then--Exclude tanks and dead
					local unitName = DBM:GetUnitFullName(uId)
					local spellName3, _, _, _, _, expireTime3 = DBM:UnitDebuff(uId, 334755)
					if spellName3 and expireTime3 then
						tempLines[unitName] = mfloor(expireTime3-GetTime())
						tempLinesSorted[#tempLinesSorted + 1] = unitName
					else
						tempLines[unitName] = 0
						tempLinesSorted[#tempLinesSorted + 1] = unitName
					end
				end
			end
		else
			--More performance friendly check that just returns all player stacks (the default option)
			for uId in DBM:GetGroupMembers() do
				local _, _, _, mapId = UnitPosition(uId)
				if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) and mapId == 2296 then--Exclude tanks and dead and people not in zone
					local unitName = DBM:GetUnitFullName(uId)
					tempLines[unitName] = essenceSapStacks[unitName] or 0
					tempLinesSorted[#tempLinesSorted + 1] = unitName
				end
			end
		end
		--Sort debuffs, then inject into regular table
		if mod.Options.SortDesc then
			tsort(tempLinesSorted, sortFuncDesc)
		else
			tsort(tempLinesSorted, sortFuncAsc)
		end
		for _, name in ipairs(tempLinesSorted) do
			addLine(name, tempLines[name])
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	playerEssenceSap = false
	table.wipe(GluttonousTargets)
	table.wipe(essenceSapStacks)
	self.vb.volatileIcon = 5
	self.vb.volatileCast = 0
	self.vb.expungeCount = 0
	self.vb.consumeCount = 0
	self.vb.desolateCount = 0
	self.vb.overwhelmCast = 0
	self.vb.miasmaCount = 0
	self.vb.miasmaIcon = 2
	self.vb.meleeFound = false
	timerGluttonousMiasmaCD:Start(3-delay, 1)--Always same
	if self:IsLFR() then
		timerOverwhelmCD:Start(5.5-delay, 1)
		timerVolatileEjectionCD:Start(11.1-delay, 1)
		timerDesolateCD:Start(24.4-delay, 1)
		timerExpungeCD:Start(35.5-delay, 1)
		timerConsumeCD:Start(98.9-delay, 1)
	elseif self:IsNormal() then
		timerOverwhelmCD:Start(5.2-delay, 1)
		timerVolatileEjectionCD:Start(10.5-delay, 1)
		timerDesolateCD:Start(23.2-delay, 1)
		timerExpungeCD:Start(34.7-delay, 1)
		timerConsumeCD:Start(93-delay, 1)
	else
		timerOverwhelmCD:Start(5-delay, 1)
		timerVolatileEjectionCD:Start(10.1-delay, 1)
		timerDesolateCD:Start(22-delay, 1)
		timerExpungeCD:Start(32-delay, 1)
		timerConsumeCD:Start(89-delay, 1)
		if self:IsMythic() then
			berserkTimer:Start(420-delay)
		end
	end
--	berserkTimer:Start(-delay)
	if self:IsMythic() then
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			essenceSapStacks[unitName] = 0
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(22, "function", updateInfoFrame, false, false)
		end
	end
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		local unitName = DBM:GetUnitFullName(uId)
		if self:IsMythic() then
			local _, _, currentStack = DBM:UnitDebuff(uId, 329298)
			essenceSapStacks[unitName] = currentStack or 0
			if UnitIsUnit(uId, "player") and currentStack then
				playerEssenceSap = true
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(OVERVIEW)
				DBM.InfoFrame:Show(22, "function", updateInfoFrame, false, false)
			end
		end
		if DBM:UnitDebuff(uId, 329298) then
			if not tContains(GluttonousTargets, unitName) then
				table.insert(GluttonousTargets, unitName)
			end
		end
	end
	if DBM:UnitDebuff("player", 334228) then
		playerVolatile = true
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 334522 then
		self.vb.consumeCount = self.vb.consumeCount + 1
		specWarnConsume:Show(self.vb.consumeCount)
		specWarnConsume:Play("justrun")
		timerConsumeCD:Start(self:IsEasy() and 101 or 96, self.vb.consumeCount+1)
--	elseif spellId == 329758 then
--		timerExpungeCD:Start()
	elseif spellId == 338621 or spellId == 334266 then--LFR, everything else
		self.vb.volatileIcon = 5
		self.vb.volatileCast = self.vb.volatileCast + 1
		--Heroic, Mythic
		--10.1, 36.1, 12.0, 36.0, 36.0, 36.0, 12.0, 36.0, 36.1, 35.9, 12.1, 35.9, 36.0--OLD
		--10.0, 36.0, 36.0, 24.0, 36.0, 36.0, 24.0, 36.0, 36.0, 24.0", -- [4]--NEW
		--Normal, LFR?
		--Same pattern slowed down slightly
		specWarnVolatileEjectionPerWarn:Show()
		specWarnVolatileEjectionPerWarn:Play("specialsoon")
		if self.vb.volatileCast % 3 == 0 then
			timerVolatileEjectionCD:Start(self:IsLFR() and 27.8 or self:IsNormal() and 25.3 or 24, self.vb.volatileCast+1)--Minus isn't a bug, the counter is off by 2 for perfect timers
		else
			timerVolatileEjectionCD:Start(self:IsLFR() and 38.9 or self:IsNormal() and 37.8 or 35.9, self.vb.volatileCast+1)--Minus isn't a bug, the counter is off by 2 for perfect timers
		end
	elseif spellId == 329455 then
		--Heroic, mythic?
		--22.0, 36.0, 60.0, 36.0, 60.0, 36.0, 60.0", -- [2]
		self.vb.desolateCount = self.vb.desolateCount + 1
		if self.vb.desolateCount % 2 == 0 then
			timerDesolateCD:Start(self:IsLFR() and 66.6 or self:IsNormal() and 63.1 or 60, self.vb.desolateCount+1)
		else
			timerDesolateCD:Start(self:IsLFR() and 40 or self:IsNormal() and 37.8 or 36, self.vb.desolateCount+1)
		end
	elseif spellId == 329774 then
		self.vb.overwhelmCast = self.vb.overwhelmCast + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnOverwhelm:Show()
			specWarnOverwhelm:Play("defensive")
		end
		--Heroic (7, 14, 21, so every 7th cast, next is doubled)
		--5.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 24.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 24.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 24.0, 12.0, 12.0
		if self.vb.overwhelmCast % 7 == 0 then
			timerOverwhelmCD:Start(self:IsLFR() and 26.6 or self:IsNormal() and 25.2 or 24, self.vb.overwhelmCast+1)
		else
			timerOverwhelmCD:Start(self:IsLFR() and 13.3 or self:IsNormal() and 12.6 or 11.9, self.vb.overwhelmCast+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 329774 then
		if not args:IsPlayer() then
			specWarnOverwhelmTaunt:Show(args.destName)
			specWarnOverwhelmTaunt:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329298 then
		if self:AntiSpam(10, 3) then
			table.wipe(GluttonousTargets)
			self.vb.miasmaCount = self.vb.miasmaCount + 1
			self.vb.miasmaIcon = 2
			self.vb.meleeFound = false
			timerGluttonousMiasmaCD:Start(23.8, self.vb.miasmaCount+1)--Same in all difficulties
		end
		if not tContains(GluttonousTargets, args.destName) then
			table.insert(GluttonousTargets, args.destName)
		end
		local icon
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsMelee(uId, true) and not self.vb.meleeFound then
			icon = 1
			self.vb.meleeFound = true--Some sets can have more than 1 melee, this makes sure star isn't assigned to multiple
			DBM:Debug("First Melee Miasma found: "..args.destName, 2)
		else
			icon = self.vb.miasmaIcon < 5 and self.vb.miasmaIcon or 1--If icon is 5 then were no melee in this wave at all, force assign star to the final ranged
			self.vb.miasmaIcon = self.vb.miasmaIcon + 1
			DBM:Debug("Ranged/Second Melee Miasma found: "..args.destName, 2)
		end
		if self.Options.SetIconOnGluttonousMiasma then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnGluttonousMiasma:Show(self:IconNumToTexture(icon))
			specWarnGluttonousMiasma:Play("mm"..icon)--or "targetyou"
			yellGluttonousMiasma:Yell(icon, icon)
		else
			warnGluttonousMiasma:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 334755 then
		local amount = args.amount or 1
		essenceSapStacks[args.destName] = amount
		if args:IsPlayer() then
			if not playerEssenceSap then
				playerEssenceSap = true
			end
			if amount >= 8 then
				specWarnEssenceSap:Show(amount)
				specWarnEssenceSap:Play("stackhigh")
			end
		end
	elseif spellId == 334228 then
		if args:IsPlayer() then
			playerVolatile = true
		end
	elseif spellId == 332295 then
		local amount = args.amount or 1
		if amount >= 6 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnGrowingHunger:Show(amount)
				specWarnGrowingHunger:Play("changemt")
			else
				local targetName = self:GetBossTarget(164261)
				specWarnGrowingHungerOther:Show(targetName)
				specWarnGrowingHungerOther:Play("tauntboss")
			end
		end
	elseif spellId == 329725 and self:AntiSpam(10, 5) then
		self.vb.expungeCount = self.vb.expungeCount + 1
		specWarnExpunge:Show()
		specWarnExpunge:Play("scatter")
		if (self.vb.expungeCount) % 2 == 0 then
			local timer = self:IsLFR() and 66.6 or self:IsNormal() and 63.1 or 59.9
			timerExpungeCD:Start(timer, self.vb.expungeCount+1)
		else
			local timer = self:IsLFR() and 39.9 or self:IsNormal() and 37.9 or 35.8
			timerExpungeCD:Start(timer, self.vb.expungeCount+1)
		end
	elseif spellId == 334064 then
--		if args:IsPlayer() then
--			specWarnVolatileEjection:Show()
--			specWarnVolatileEjection:Play("targetyou")
--			yellVolatileEjection:Yell()
--		end
		if self:AntiSpam(4, args.destName) then
			if self.Options.SetIconOnVolatileEjection2 then
				local oldIcon = self:GetIcon(args.destName) or 0
				if oldIcon == 0 then--Do not change a miasma icon under any circomstance
					self:SetIcon(args.destName, self.vb.volatileIcon, 5)
				end
			end
			warnVolatileEjection:CombinedShow(0.75, args.destName)
			self.vb.volatileIcon = self.vb.volatileIcon + 1
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329298 then
		tDeleteItem(GluttonousTargets, args.destName)
	elseif spellId == 334755 then
		essenceSapStacks[args.destName] = 0
		if args:IsPlayer() then
			playerEssenceSap = false
		end
	elseif spellId == 334228 then
		if args:IsPlayer() then
			playerVolatile = false
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("334064") then
		specWarnVolatileEjection:Show()
		specWarnVolatileEjection:Play("targetyou")
		yellVolatileEjection:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("334064") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			if self.Options.SetIconOnVolatileEjection2 then
				local oldIcon = self:GetIcon(targetName) or 0
				if oldIcon == 0 then--Do not change a miasma icon under any circomstance
					self:SetIcon(targetName, self.vb.volatileIcon, 5)
				end
			end
			warnVolatileEjection:CombinedShow(0.75, targetName)
			self.vb.volatileIcon = self.vb.volatileIcon + 1
		end
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
