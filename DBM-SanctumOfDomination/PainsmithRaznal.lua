local mod	= DBM:NewMod(2443, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176523)
mod:SetEncounterID(2430)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20210706000000)--2021-07-06
mod:SetMinSyncRevision(20210513000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 357735",
	"SPELL_CAST_SUCCESS 348508 355568 355778 352052 348456 355504 355534",
	"SPELL_AURA_APPLIED 348508 355568 355778 355786 348456 355505 355525",
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
 or (ability.id = 348508 or ability.id = 355568 or ability.id = 355778 or ability.id = 352052 or ability.id = 348456 or ability.id = 355504 or ability.id = 355534) and type = "cast"
 or ability.id = 355525
 or ability.id = 355505 and type = "applydebuff"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
local warnShadowsteelChains						= mod:NewTargetNoFilterAnnounce(355505, 2)
local warnFlameclaspTrap						= mod:NewTargetNoFilterAnnounce(348456, 2)

local specWarnReverberatingHammer				= mod:NewSpecialWarningMoveAway(348508, nil, nil, nil, 1, 2)
local yellReverberatingHammer					= mod:NewShortYell(348508)
local yellReverberatingHammerFades				= mod:NewShortFadesYell(348508)
local specWarnReverberatingHammerTaunt			= mod:NewSpecialWarningTaunt(348508, nil, nil, nil, 1, 2)
local specWarnCruciformAxe						= mod:NewSpecialWarningMoveAway(355568, nil, nil, nil, 1, 2)
local yellCruciformAxe							= mod:NewShortYell(355568)
local yellCruciformAxeFades						= mod:NewShortFadesYell(355568)
local specWarnCruciformAxeTaunt					= mod:NewSpecialWarningTaunt(355568, nil, nil, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnDualbladeScythe					= mod:NewSpecialWarningMoveAway(355778, nil, nil, nil, 1, 2)
local yellDualbladeScythe						= mod:NewShortYell(355778)
local yellDualbladeScytheFades					= mod:NewShortFadesYell(355778)
local specWarnDualbladeScytheTaunt				= mod:NewSpecialWarningTaunt(355778, nil, nil, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnFlameclaspTrap					= mod:NewSpecialWarningMoveAway(348456, nil, nil, nil, 1, 2)
local yellFlameclaspTrap						= mod:NewShortYell(348456)
local yellFlameclaspTrapFades					= mod:NewShortFadesYell(348456)
local specWarnShadowsteelChains					= mod:NewSpecialWarningYouPos(355505, nil, nil, nil, 1, 2)
local yellShadowsteelChains						= mod:NewShortPosYell(355505)
local yellShadowsteelChainsFades				= mod:NewIconFadesYell(355505)
--local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerReverberatingHammerCD				= mod:NewCDTimer(32.8, 348508, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerCruciformAxeCD						= mod:NewCDTimer(17, 355568, nil, nil, nil, 3)
local timerDualbladeScytheCD					= mod:NewCDTimer(32.8, 355778, nil, nil, nil, 3)
local timerSpikedBallsCD						= mod:NewCDTimer(62.1, 352052, nil, nil, nil, 3)
local timerFlameclaspTrapCD						= mod:NewCDTimer(40.2, 348456, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)
local timerShadowsteelChainsCD					= mod:NewCDTimer(30.1, 355504, nil, nil, nil, 3)
local timerForgeWeapon							= mod:NewCastTimer(48, 355525, nil, nil, nil, 6)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(355786, true)
mod:AddSetIconOption("SetIconOnChains", 355505, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnFinalScream", 357735)

mod.vb.ChainsIcon = 1

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

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ChainsIcon = 1
	table.wipe(debuffedPlayers)
	timerShadowsteelChainsCD:Start(8.1-delay)
	if self:IsMythic() then
		timerCruciformAxeCD:Start(15-delay)--Axe instead of hammer
		timerSpikedBallsCD:Start(26.4-delay)
		timerFlameclaspTrapCD:Start(42.2-delay)
	else
		timerReverberatingHammerCD:Start(16-delay)
		timerSpikedBallsCD:Start(32.2-delay)
		if self:IsHeroic() then
			timerFlameclaspTrapCD:Start(48.2-delay)
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
		timerReverberatingHammerCD:Start()
	elseif spellId == 355568 then
		timerCruciformAxeCD:Start()
	elseif spellId == 355778 then
		timerDualbladeScytheCD:Start()
	elseif spellId == 352052 then
		DBM:AddMsg("Spiked Balls added to combat log, please report to DBM author")
	elseif spellId == 348456 then
		timerFlameclaspTrapCD:Start(self:IsMythic() and 48.2 or 40.2)--Might just need more data
	elseif spellId == 355504 then
		DBM:AddMsg("Shadowsteel Chains added to combat log, please report to DBM author")
	elseif spellId == 355534 then--Shadowsteel Ember
		timerReverberatingHammerCD:Stop()
		timerCruciformAxeCD:Stop()
		timerDualbladeScytheCD:Stop()
		timerSpikedBallsCD:Stop()
		timerFlameclaspTrapCD:Stop()
		timerShadowsteelChainsCD:Stop()
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
		else
			specWarnReverberatingHammerTaunt:Show(args.destName)
			specWarnReverberatingHammerTaunt:Play("tauntboss")
		end
	elseif spellId == 355568 then
		if args:IsPlayer() then
			specWarnCruciformAxe:Show()
			specWarnCruciformAxe:Play("runout")
			yellCruciformAxe:Yell()
			yellCruciformAxeFades:Countdown(spellId)
		else
			specWarnCruciformAxeTaunt:Show(args.destName)
			specWarnCruciformAxeTaunt:Play("tauntboss")
		end
	elseif spellId == 355778 then
		if args:IsPlayer() then
			specWarnDualbladeScythe:Show()
			specWarnDualbladeScythe:Play("runout")
			yellDualbladeScythe:Yell()
			yellDualbladeScytheFades:Countdown(spellId)
		else
			specWarnDualbladeScytheTaunt:Show(args.destName)
			specWarnDualbladeScytheTaunt:Play("tauntboss")
		end
	elseif spellId == 348456 then
		if args:IsPlayer() then
			specWarnFlameclaspTrap:Show()
			specWarnFlameclaspTrap:Play("runout")
			yellFlameclaspTrap:Yell()
			yellFlameclaspTrapFades:Countdown(spellId)
		end
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
	elseif spellId == 355568 then
		if args:IsPlayer() then
			yellCruciformAxeFades:Cancel()
		end
	elseif spellId == 355778 then
		if args:IsPlayer() then
			yellDualbladeScytheFades:Cancel()
		end
	elseif spellId == 355786 then
		tDeleteItem(debuffedPlayers, args.destName)
	elseif spellId == 348456 then
		if args:IsPlayer() then
			yellFlameclaspTrapFades:Cancel()
		end
	elseif spellId == 355525 then--Forge Weapon ending, boss returning
		timerForgeWeapon:Stop()
		self:SetStage(0)
		if self.vb.phase == 2 then
			if self:IsMythic() then
				timerShadowsteelChainsCD:Start(15)
				timerReverberatingHammerCD:Start(23.6)--Hammer on mythic
				timerSpikedBallsCD:Start(7)
				timerFlameclaspTrapCD:Start(52.8)
			else
				timerShadowsteelChainsCD:Start(15)
				timerCruciformAxeCD:Start(24)--Axe on heroic (and others?)
				timerSpikedBallsCD:Start(40)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(55.8)
				end
			end
		else--phase 3
			if self:IsMythic() then
				timerShadowsteelChainsCD:Start(15)
				timerDualbladeScytheCD:Start(24)
				timerSpikedBallsCD:Start(7)
				timerFlameclaspTrapCD:Start(52)
			else
				timerShadowsteelChainsCD:Start(15)
				timerDualbladeScytheCD:Start(24)
				timerSpikedBallsCD:Start(40)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(55.8)
				end
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
	if spellId == 352052 then--Spiked Balls
		timerSpikedBallsCD:Start(self:IsMythic() and 48.7 or 62.1)--Can be delayed by other casts?
		--TODO, more stage 2 mythic data, first one is 57.2 consistently, but what about rest?
	elseif spellId == 355504 then--Shadowsteel Chains
		self.vb.ChainsIcon = 1
		timerShadowsteelChainsCD:Start()
	elseif spellId == 355555 then--Upstairs (Boss leaving, faster to stop timers than Forge Weapon which happens 2 sec later)
		timerReverberatingHammerCD:Stop()
		timerCruciformAxeCD:Stop()
		timerDualbladeScytheCD:Stop()
		timerSpikedBallsCD:Stop()
		timerFlameclaspTrapCD:Stop()
		timerShadowsteelChainsCD:Stop()
--	elseif spellId == 356416 then--Weapon Picker (global picker)

	end
end
