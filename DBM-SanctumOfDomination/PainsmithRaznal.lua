local mod	= DBM:NewMod(2443, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(164406)
mod:SetEncounterID(2430)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210512000000)--2021-05-12
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS 348508 355568 355778 352052 348456 355504 355534",
	"SPELL_AURA_APPLIED 348508 355568 355778 355786 348456 355505",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 348508 355568 355778 355786 348456 355505"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://ptr.wowhead.com/spell=355786/blackened-armor
--TODO,, 3 diff weapons that literally do same thing, also are they tank swaps?
--TODO, correct spike triggers and intermission triggers
--https://ptr.wowhead.com/spells/uncategorized/name:spike?filter=21;2;90100
--local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
--local warnBloodLantern							= mod:NewTargetNoFilterAnnounce(341684, 2)

local specWarnRipplingHammer					= mod:NewSpecialWarningMoveAway(348508, nil, nil, nil, 1, 2)
local yellRipplingHammer						= mod:NewShortYell(348508)
local yellRipplingHammerFades					= mod:NewShortFadesYell(348508)
local specWarnRipplingHammerTaunt				= mod:NewSpecialWarningTaunt(348508, nil, nil, nil, 1, 2)
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
local specWarnShadowsteelChains					= mod:NewSpecialWarningMoveAway(355505, nil, nil, nil, 1, 2)
local yellShadowsteelChains						= mod:NewShortYell(355505)
local yellShadowsteelChainsFades				= mod:NewShortFadesYell(355505)
--local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerRipplingHammerCD						= mod:NewAITimer(17.8, 348508, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerCruciformAxeCD						= mod:NewAITimer(17.8, 355568, nil, nil, nil, 3)
local timerDualbladeScytheCD					= mod:NewAITimer(17.8, 355778, nil, nil, nil, 3)
local timerSpikedBallsCD						= mod:NewAITimer(23, 352052, nil, nil, nil, 3)
local timerFlameclaspTrapCD						= mod:NewAITimer(23, 348456, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)
local timerShadowsteelChainsCD					= mod:NewAITimer(23, 355504, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(355786, true)
--mod:AddSetIconOption("SetIconOnEcholocation", 342077, true, false, {1, 2, 3})

local debuffedPlayers = {}

local updateInfoFrame
do
	local twipe, tsort = table.wipe, table.sort
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
					tempLines[unitName] = expires
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
	table.wipe(debuffedPlayers)
	timerRipplingHammerCD:Start(1-delay)
	timerCruciformAxeCD:Start(1-delay)--Probably doesn't start here
	timerDualbladeScytheCD:Start(1-delay)--Probably doesn't start here
	timerSpikedBallsCD:Start(1-delay)
	timerShadowsteelChainsCD:Start(1-delay)
	if self:IsHard() then
		timerFlameclaspTrapCD:Start(1-delay)
	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(355786))
		DBM.InfoFrame:Show(20, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328857 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 348508 then
		timerRipplingHammerCD:Start()
	elseif spellId == 355568 then
		timerCruciformAxeCD:Start()
	elseif spellId == 355778 then
		timerDualbladeScytheCD:Start()
	elseif spellId == 352052 then
		timerSpikedBallsCD:Start()
	elseif spellId == 348456 then
		timerFlameclaspTrapCD:Start()
	elseif spellId == 355504 then--Might use debuff Id (355505) instead
		timerShadowsteelChainsCD:Start()
	elseif spellId == 355534 then--Shadowsteel Ember
		timerRipplingHammerCD:Stop()
		timerCruciformAxeCD:Stop()
		timerDualbladeScytheCD:Stop()
		timerSpikedBallsCD:Stop()
		timerFlameclaspTrapCD:Stop()
		timerShadowsteelChainsCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 348508 then
		if args:IsPlayer() then
			specWarnRipplingHammer:Show()
			specWarnRipplingHammer:Play("runout")
			yellRipplingHammer:Yell()
			yellRipplingHammerFades:Countdown(spellId)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--It's on a tank, tant the boss so they can get away
				specWarnRipplingHammerTaunt:Show(args.destName)
				specWarnRipplingHammerTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 355568 then
		if args:IsPlayer() then
			specWarnCruciformAxe:Show()
			specWarnCruciformAxe:Play("runout")
			yellCruciformAxe:Yell()
			yellCruciformAxeFades:Countdown(spellId)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--It's on a tank, tant the boss so they can get away
				specWarnCruciformAxeTaunt:Show(args.destName)
				specWarnCruciformAxeTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 355778 then
		if args:IsPlayer() then
			specWarnDualbladeScythe:Show()
			specWarnDualbladeScythe:Play("runout")
			yellDualbladeScythe:Yell()
			yellDualbladeScytheFades:Countdown(spellId)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--It's on a tank, tant the boss so they can get away
				specWarnDualbladeScytheTaunt:Show(args.destName)
				specWarnDualbladeScytheTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 355786 then
		if not tContains(debuffedPlayers, args.destName) then
			table.insert(debuffedPlayers, args.destName)
		end
	elseif spellId == 348456 then
		if args:IsPlayer() then
			specWarnFlameclaspTrap:Show()
			specWarnFlameclaspTrap:Play("runout")
			yellFlameclaspTrap:Yell()
			yellFlameclaspTrapFades:Countdown(spellId)
		end
	elseif spellId == 355505 then
		if args:IsPlayer() then
			specWarnShadowsteelChains:Show()
			specWarnShadowsteelChains:Play("runout")
			yellShadowsteelChains:Yell()
			yellShadowsteelChainsFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 348508 then
		if args:IsPlayer() then
			yellRipplingHammerFades:Cancel()
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
	if spellId == 342074 then

	end
end
--]]
