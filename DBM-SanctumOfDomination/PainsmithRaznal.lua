local mod	= DBM:NewMod(2443, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176523)
mod:SetEncounterID(2430)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(20210715000000)--2021-07-15
mod:SetMinSyncRevision(20210715000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 357735",
	"SPELL_CAST_SUCCESS 348508 355568 355778 348456 355504 355534",
	"SPELL_AURA_APPLIED 348508 355568 355778 355786 348456 355505 355525 352052",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 348508 355568 355778 355786 348456 355505 355525",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify infoframe usefulness
--TODO,
--https://ptr.wowhead.com/spells/uncategorized/name:spike?filter=21;2;90100
--[[
ability.id = 357735 and type = "begincast"
 or (ability.id = 348508 or ability.id = 355568 or ability.id = 355778 or ability.id = 348456 or ability.id = 355504 or ability.id = 355534) and type = "cast"
 or ability.id = 355525 or ability.id = 352052
 or (ability.id = 348456) and type = "applydebuff"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
local warnAxe									= mod:NewTargetCountAnnounce(355568, 1, nil, nil, 184055, nil, nil, nil, true)
local warnHammer								= mod:NewTargetCountAnnounce(348508, 1, nil, nil, 175798, nil, nil, nil, true)
local warnScythe								= mod:NewTargetCountAnnounce(355778, 1, nil, nil, 327953, nil, nil, nil, true)
local warnShadowsteelChains						= mod:NewTargetNoFilterAnnounce(355505, 2, nil, nil, 246367)
local warnFlameclaspTrap						= mod:NewTargetNoFilterAnnounce(348456, 2, nil, nil, 8312)
local warnEmbers								= mod:NewCountAnnounce(355534, 2, nil, nil, 264364)

local specWarnCruciformAxe						= mod:NewSpecialWarningMoveAway(355568, nil, 184055, nil, 1, 2)
local yellCruciformAxe							= mod:NewShortYell(355568, 184055)
local yellCruciformAxeFades						= mod:NewShortFadesYell(355568, 184055)
local specWarnCruciformAxeTaunt					= mod:NewSpecialWarningTaunt(355568, nil, 184055, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnReverberatingHammer				= mod:NewSpecialWarningMoveAway(348508, nil, 175798, nil, 1, 2)
local yellReverberatingHammer					= mod:NewShortYell(348508, 175798)
local yellReverberatingHammerFades				= mod:NewShortFadesYell(348508, 175798)
local specWarnReverberatingHammerTaunt			= mod:NewSpecialWarningTaunt(348508, nil, 175798, nil, 1, 2)
local specWarnDualbladeScythe					= mod:NewSpecialWarningMoveAway(355778, nil, 327953, nil, 1, 2)
local yellDualbladeScythe						= mod:NewShortYell(355778, 327953)
local yellDualbladeScytheFades					= mod:NewShortFadesYell(355778, 327953)
local specWarnDualbladeScytheTaunt				= mod:NewSpecialWarningTaunt(355778, nil, 327953, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnSpikedBalls						= mod:NewSpecialWarningSwitchCount(352052, nil, nil, nil, 1, 2)
local specWarnFlameclaspTrap					= mod:NewSpecialWarningYouPos(348456, nil, 8312, nil, 1, 2)
local yellFlameclaspTrap						= mod:NewShortPosYell(348456, 8312)
local yellFlameclaspTrapFades					= mod:NewIconFadesYell(348456, 8312)
local specWarnShadowsteelChains					= mod:NewSpecialWarningYouPos(355505, nil, 246367, nil, 1, 2)
local yellShadowsteelChains						= mod:NewShortPosYell(355505, 246367)
local yellShadowsteelChainsFades				= mod:NewIconFadesYell(355505, 246367)
--local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerCruciformAxeCD						= mod:NewCDCountTimer(19.4, 355568, 184055, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--"Axe"
local timerCruciformAxe							= mod:NewTargetTimer(6, 355568, 184055, nil, nil, 3)--"Axe"
local timerReverberatingHammerCD				= mod:NewCDCountTimer(19.4, 348508, 175798, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--"Hammer"
local timerReverberatingHammer					= mod:NewTargetTimer(6, 348508, 175798, nil, nil, 3)--"Hammer"
local timerDualbladeScytheCD					= mod:NewCDCountTimer(19.4, 355778, 327953, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--"Scythe"
local timerDualbladeScythe						= mod:NewTargetTimer(19.4, 355778, 327953, nil, nil, 3)--"Scythe"
local timerSpikedBallsCD						= mod:NewCDCountTimer(40.1, 352052, nil, nil, nil, 3, nil, DBM_CORE_L.DAMAGE_ICON)
local timerFlameclaspTrapCD						= mod:NewCDCountTimer(47.9, 348456, 8312, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)--"Trap"
local timerShadowsteelChainsCD					= mod:NewCDCountTimer(40.1, 355504, 246367, nil, nil, 3)--"Chains"
--Intermission
local timerForgeWeapon							= mod:NewCastTimer(48, 355525, nil, nil, nil, 6)
local timerEmbersCD								= mod:NewNextCountTimer(5, 355534, 264364, nil, nil, 3)--"Embers"
local timerAddsCD								= mod:NewAddsTimer(120, 357755, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(355786, true)
mod:AddSetIconOption("SetIconOnChains", 355505, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnTraps", 348456, true, false, {4, 5, 6, 7})
mod:AddNamePlateOption("NPAuraOnFinalScream", 357735)

mod.vb.ChainsIcon = 1
mod.vb.trapsIcon = 4
mod.vb.weaponCount = 0
mod.vb.ballsCount = 0
mod.vb.trapCount = 0
mod.vb.chainCount = 0
mod.vb.emberCount = 0

local debuffedPlayers = {}

local updateInfoFrame
do
	local twipe, tsort, mfloor = table.wipe, table.sort, math.floor
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
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
		--Boss Powers first (Change if weapons or other parts don't have power)
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				local adjustedPower = currentPower / maxPower * 100
				if adjustedPower >= 1 and adjustedPower ~= 100 then--Filter 100 power, to basically eliminate cced Adds
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		addLine(" ", " ")--Insert a blank entry to split the two debuffs
		--Debuffed players (UGLY code)
		if #debuffedPlayers > 0 then
			for i=1, #debuffedPlayers do
				local name = debuffedPlayers[i]
				local uId = DBM:GetRaidUnitId(name)
				local spellName, _, _, _, _, expires = DBM:UnitDebuff(uId, 355786)
				if expires then
					local unitName = DBM:GetUnitFullName(uId)
					local debuffTime = expires - GetTime()
					tempLines[unitName] = mfloor(debuffTime)
					tempLinesSorted[#tempLinesSorted + 1] = unitName
				end
			end
			--Sort debuffs by longeset remaining then inject into regular table
			tsort(tempLinesSorted, sortFuncDesc)
			for _, name in ipairs(tempLinesSorted) do
				addLine(name, tempLines[name])
			end
		end
		return lines, sortedLines
	end
end

local function repeatEmbers(self, expected)
	self.vb.emberCount = self.vb.emberCount + 1
	warnEmbers:Show(self.vb.emberCount)
	if self.vb.emberCount < expected then
		timerEmbersCD:Start(5, self.vb.emberCount+1)
		self:Schedule(5, repeatEmbers, self, expected)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ChainsIcon = 1
	self.vb.weaponCount = 0
	self.vb.ballsCount = 0
	self.vb.trapCount = 0
	self.vb.chainCount = 0
	table.wipe(debuffedPlayers)
	if self:IsMythic() then
		timerShadowsteelChainsCD:Start(8.1-delay, 1)
		timerCruciformAxeCD:Start(11-delay, 1)
		timerSpikedBallsCD:Start(16-delay, 1)
		timerFlameclaspTrapCD:Start(39-delay, 1)
	else
		timerShadowsteelChainsCD:Start(10.8-delay, 1)
		timerCruciformAxeCD:Start(16-delay, 1)
		timerSpikedBallsCD:Start(23.9-delay, 1)
		if self:IsHeroic() then
			timerFlameclaspTrapCD:Start(45-delay, 1)
		end
	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(355786))
		DBM.InfoFrame:Show(20, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnFinalScream then
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
	if self.Options.NPAuraOnFinalScream then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 357735 then
		if self.Options.NPAuraOnFinalScream then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 348508 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerReverberatingHammerCD:Start(nil, self.vb.weaponCount+1)
	elseif spellId == 355568 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerCruciformAxeCD:Start(nil, self.vb.weaponCount+1)
	elseif spellId == 355778 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerDualbladeScytheCD:Start(nil, self.vb.weaponCount+1)
	elseif spellId == 348456 then
		DBM:Debug("Traps added to combat log")
	elseif spellId == 355504 then
		self.vb.ChainsIcon = 1
		self.vb.chainCount = self.vb.chainCount + 1
		--They apply custom rule to only heroic in phase 2 and 3
		local timer = (self:IsHeroic() and self.vb.phase > 1 and 48.9) or 40.1
		timerShadowsteelChainsCD:Start(timer, self.vb.chainCount+1)
	elseif spellId == 355534 then--Shadowsteel Ember
		DBM:Debug("Embers added to combat log")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 355505 then
		local icon = self.vb.ChainsIcon
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnShadowsteelChains:Show(self:IconNumToTexture(icon))
			specWarnShadowsteelChains:Play("mm"..icon)
			yellShadowsteelChains:Yell(icon, icon)
			yellShadowsteelChainsFades:Countdown(spellId, nil, icon)
		end
		warnShadowsteelChains:CombinedShow(0.5, args.destName)
		self.vb.ChainsIcon = self.vb.ChainsIcon + 1
	elseif spellId == 355786 then
		if not tContains(debuffedPlayers, args.destName) then
			table.insert(debuffedPlayers, args.destName)
		end
	elseif spellId == 355525 then
		timerForgeWeapon:Start()
	elseif spellId == 348508 then
		if args:IsPlayer() then
			specWarnReverberatingHammer:Show()
			specWarnReverberatingHammer:Play("runout")
			yellReverberatingHammer:Yell()
			yellReverberatingHammerFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnReverberatingHammerTaunt:Show(args.destName)
			specWarnReverberatingHammerTaunt:Play("tauntboss")
		else
			warnHammer:Show(self.vb.weaponCount, args.destName)
		end
		timerReverberatingHammer:Start(args.destName)
	elseif spellId == 355568 then
		if args:IsPlayer() then
			specWarnCruciformAxe:Show()
			specWarnCruciformAxe:Play("runout")
			yellCruciformAxe:Yell()
			yellCruciformAxeFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnCruciformAxeTaunt:Show(args.destName)
			specWarnCruciformAxeTaunt:Play("tauntboss")
		else
			warnAxe:Show(self.vb.weaponCount, args.destName)
		end
		timerCruciformAxe:Start(args.destName)
	elseif spellId == 355778 then
		if args:IsPlayer() then
			specWarnDualbladeScythe:Show()
			specWarnDualbladeScythe:Play("runout")
			yellDualbladeScythe:Yell()
			yellDualbladeScytheFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnDualbladeScytheTaunt:Show(args.destName)
			specWarnDualbladeScytheTaunt:Play("tauntboss")
		else
			warnScythe:Show(self.vb.weaponCount, args.destName)
		end
		timerDualbladeScythe:Start(args.destName)
	elseif spellId == 348456 then
		if self:AntiSpam(5, 1) then
			self.vb.trapsIcon = 4
			self.vb.trapCount = self.vb.trapCount + 1
			local timer = (self:IsHeroic() and self.vb.phase > 1 and 47.9) or 40
			timerFlameclaspTrapCD:Start(timer, self.vb.trapCount+1)
		end
		local icon = self.vb.trapsIcon
		if self.Options.SetIconOnTraps then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFlameclaspTrap:Show(self:IconNumToTexture(icon))
			specWarnFlameclaspTrap:Play("mm"..icon)
			yellFlameclaspTrap:Yell(icon, icon)
			yellFlameclaspTrapFades:Countdown(spellId, nil, icon)
		end
		warnFlameclaspTrap:CombinedShow(0.5, args.destName)
		self.vb.trapsIcon = self.vb.trapsIcon + 1
	elseif spellId == 352052 then
		self.vb.ballsCount = self.vb.ballsCount + 1
		specWarnSpikedBalls:Show(self.vb.ballsCount)
		specWarnSpikedBalls:Play("targetchange")
		local timer = (self:IsHeroic() and self.vb.phase > 1 and 47.9) or 40.1
		timerSpikedBallsCD:Start(timer, self.vb.ballsCount+1)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 355505 then
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellShadowsteelChainsFades:Cancel()
		end
	elseif spellId == 348508 then
		if args:IsPlayer() then
			yellReverberatingHammerFades:Cancel()
		end
		timerReverberatingHammer:Stop(args.destName)
	elseif spellId == 355568 then
		if args:IsPlayer() then
			yellCruciformAxeFades:Cancel()
		end
		timerCruciformAxe:Stop(args.destName)
	elseif spellId == 355778 then
		if args:IsPlayer() then
			yellDualbladeScytheFades:Cancel()
		end
		timerDualbladeScythe:Stop(args.destName)
	elseif spellId == 355786 then
		tDeleteItem(debuffedPlayers, args.destName)
	elseif spellId == 348456 then
		if self.Options.SetIconOnTraps then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellFlameclaspTrapFades:Cancel()
		end
	elseif spellId == 355525 then--Forge Weapon ending, boss returning
		self:Unschedule(repeatEmbers)--For good measure, maybe down the line when people soloing, intermission will break/shorten
		timerForgeWeapon:Stop()
		self:SetStage(0)
		self.vb.weaponCount = 0
		self.vb.ballsCount = 0
		self.vb.trapCount = 0
		self.vb.chainCount = 0
		--Technically timers between stage 2 and 3 are same (minus weapon type change)
		--But I like having knobs to adjust in place if fight recieves adjustments down the line
		if self.vb.phase == 2 then
			if self:IsMythic() then--Timers from video, might be slightly off
				timerShadowsteelChainsCD:Start(10.9, 1)
				timerReverberatingHammerCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(20, 1)
				timerFlameclaspTrapCD:Start(38.1, 1)
			elseif self:IsHeroic() then
				timerShadowsteelChainsCD:Start(14.7, 1)
				timerReverberatingHammerCD:Start(17.1, 1)
				timerSpikedBallsCD:Start(26.1, 1)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(48.1, 1)
				end
			else
				timerShadowsteelChainsCD:Start(10.9, 1)
				timerReverberatingHammerCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(24.3, 1)
			end
		else--phase 3
			if self:IsMythic() then--Timers taken from P2, might not be right at all, could't find any clean P3 pulls in vods
				timerShadowsteelChainsCD:Start(10.9, 1)
				timerDualbladeScytheCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(20, 1)
				timerFlameclaspTrapCD:Start(38.1, 1)
			elseif self:IsHeroic() then
				timerShadowsteelChainsCD:Start(14.6, 1)
				timerDualbladeScytheCD:Start(17.1, 1)
				timerSpikedBallsCD:Start(26.1, 1)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(48.1, 1)
				end
			else
				timerShadowsteelChainsCD:Start(10.9, 1)
				timerDualbladeScytheCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(24.3, 1)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 179847 then--Shadowsteel Ember
		if self.Options.NPAuraOnFinalScream then
			DBM.Nameplate:Hide(true, args.destGUID, 357735)
		end
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
--]]

--Faster than combat log or not in combat log events
--"<67.84 22:36:16> [UNIT_SPELLCAST_SUCCEEDED] Painsmith Raznal(Andybruwu) -[DNT] Upstairs- [[boss1:Cast-3-2012-2450-9254-355555-003A1D8DC1:355555]]", -- [1092]
--"<70.30 22:36:19> [CLEU] SPELL_AURA_APPLIED#Creature-0-2012-2450-9254-176523-00001D8D02#Painsmith Raznal#Creature-0-2012-2450-9254-176523-00001D8D02#Painsmith Raznal#355525#Forge Weapon#BUFF#nil", -- [1138]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 355555 then--Upstairs (Boss leaving, faster to stop timers than Forge Weapon which happens 2 sec later)
		self.vb.emberCount = 0
		timerReverberatingHammerCD:Stop()
		timerCruciformAxeCD:Stop()
		timerDualbladeScytheCD:Stop()
		timerSpikedBallsCD:Stop()
		timerFlameclaspTrapCD:Stop()
		timerShadowsteelChainsCD:Stop()
		timerEmbersCD:Start(2.5, 1)
		self:Unschedule(repeatEmbers)
		self:Schedule(2.5, repeatEmbers, self, self:IsMythic() and 9 or 7)--Based on vods, may be off slightly
		if self:IsMythic() then--Based on vods, may be off slightly
			timerAddsCD:Start(49.5)
		end
	end
end
