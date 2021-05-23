local mod	= DBM:NewMod(2446, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175731)
mod:SetEncounterID(2436)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20200417000000)--2021-04-17
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 352589 352538 350732 352833 352660 356090 355352 350734",
--	"SPELL_CAST_SUCCESS 350496",
	"SPELL_AURA_APPLIED 352385 352394 350734 350496",--350534
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 352385 352394 350496 350534",
	"SPELL_PERIODIC_DAMAGE 350455",
	"SPELL_PERIODIC_MISSED 350455",
--	"UNIT_DIED"
	"CHAT_MSG_MONSTER_YELL"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 352589 or ability.id = 352538 or ability.id = 350732 or ability.id = 352833 or ability.id = 352660 or ability.id = 356090 or ability.id = 355352 or ability.id = 350734) and type = "begincast"
 or (ability.id = 352385 or ability.id = 350534) and (type = "applybuff" or type = "removebuff")
--]]
--TODO, fix timers more based around energy or energizing link, whichever one is confirmed to truly affect stuff like Sunder having massive delays
--TODO, do people really need a timer for purging protocol? it's based on bosses energy depletion rate (which is exactly 1 energy per second and visible on infoframe)
--In other words, infoframe energy tracker IS the timer, and his energy is constantly going up and down based on core strategy, timer would need aggressive updates from UNIT_POWER
local warnDisintegration						= mod:NewTargetNoFilterAnnounce(352833, 3)
local warnThreatNeutralization					= mod:NewTargetNoFilterAnnounce(350496, 2)
local warnFormSentry							= mod:NewCountAnnounce(352660, 2)
local warnObliterate							= mod:NewCountAnnounce(355352, 2)

--Cores
local specWarnRadiantEnergy						= mod:NewSpecialWarningMoveTo(350455, nil, nil, nil, 1, 2)
local specWarnMeltdown							= mod:NewSpecialWarningRun(352589, nil, nil, nil, 4, 2)--Change to appropriate text and priority
--Guardian
local specWarnPurgingProtocol					= mod:NewSpecialWarningCount(352538, nil, nil, nil, 2, 2)
local specWarnSunder							= mod:NewSpecialWarningDefensive(350732, nil, nil, nil, 1, 2)
local specWarnObliterate						= mod:NewSpecialWarningTaunt(350734, nil, nil, nil, 1, 2)
local specWarnObliterateCount					= mod:NewSpecialWarningCount(350734, false, nil, nil, 1, 2)
local specWarnDisintegration					= mod:NewSpecialWarningDodgeCount(352833, nil, nil, nil, 2, 2)
local yellDisintegration						= mod:NewYell(352833)
local specWarnThreatNeutralization				= mod:NewSpecialWarningMoveAway(350496, nil, nil, nil, 1, 2)
local yellThreatNeutralization					= mod:NewShortPosYell(350496)
local yellThreatNeutralizationFades				= mod:NewIconFadesYell(350496)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerEliminationPatternCD					= mod:NewCDCountTimer(31.6, 350735, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--31.656--33 now?
local timerDisintegrationCD						= mod:NewCDCountTimer(25.6, 352833, nil, nil, nil, 3)--, nil, nil, true
local timerFormSentryCD							= mod:NewCDCountTimer(25.6, 352660, nil, nil, nil, 1)--29.2-45 on mythic
local timerThreatNeutralizationCD				= mod:NewCDTimer(30.2, 350496, nil, nil, nil, 3)--31.7 but cast time taken off

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(10, 350496)
mod:AddInfoFrameOption(352394, true)
mod:AddSetIconOption("SetIconOnThreat", 350496, true, false, {1, 2, 3})

local radiantEnergy = DBM:GetSpellInfo(352394)
local playerSafe = false
local playersSafe = {}
mod.vb.coreActive = false
mod.vb.sentryCount = 0
mod.vb.beamCount = 0
mod.vb.protocolCount = 0
mod.vb.threatIcon = 1
mod.vb.patternCount = 0

local updateInfoFrame
do
	local DBM, DBM_CORE_L = DBM, DBM_CORE_L
	local UnitPower, UnitPowerMax, UnitName = UnitPower, UnitPowerMax, UnitName
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
		--Boss Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--Player safety status
		if mod.vb.coreActive then
			addLine(radiantEnergy, DBM_CORE_L.NOTSAFE)
			for uId in DBM:GetGroupMembers() do
				local unitName = DBM:GetUnitFullName(uId)
				if not playersSafe[unitName] then
					addLine(unitName, "")
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	playerSafe = false
	self.vb.sentryCount = 0
	self.vb.beamCount = 0
	self.vb.protocolCount = 0
	self.vb.patternCount = 0
	timerFormSentryCD:Start(5.8-delay, 1)
	timerDisintegrationCD:Start(15.6-delay, 1)
	timerEliminationPatternCD:Start(25.3-delay, 1)
	timerThreatNeutralizationCD:Start(self:IsMythic() and 8.3 or 38.9-delay)
	DBM:AddMsg("Experimental bar pausing in effect to try and make timers work better. It's WIP")
	--Infoframe setup (might not be needed)
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 352394) then
			local unitName = DBM:GetUnitFullName(uId)
			playersSafe[unitName] = true
		end
	end
	if DBM:UnitAura("boss1", 352385) then
		self.vb.coreActive = true
	else
		self.vb.coreActive = false
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(radiantEnergy)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 352394) then
		playerSafe = true
	end
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 352394) then
			local unitName = DBM:GetUnitFullName(uId)
			playersSafe[unitName] = true
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 352589 then
		specWarnMeltdown:Show()
		specWarnMeltdown:Play("justrun")
	elseif spellId == 352538 then
		self.vb.protocolCount = self.vb.protocolCount + 1
		specWarnPurgingProtocol:Show(self.vb.protocolCount)
		specWarnPurgingProtocol:Play("aesoon")
		if self.vb.protocolCount == 1 then
			--Pause timers, not 100% accurate but a bit more accurate than sequencing or doing nothing.
			--Done here because pausing on aura gain mathed worse than pausing here
			timerFormSentryCD:Pause(self.vb.sentryCount+1)
			timerThreatNeutralizationCD:Pause()
			timerEliminationPatternCD:Pause(self.vb.patternCount+1)
			timerDisintegrationCD:Pause(self.vb.beamCount+1)
		end
	elseif spellId == 350732 then
		self.vb.patternCount = self.vb.patternCount + 1
		timerEliminationPatternCD:Start(nil, self.vb.patternCount+1)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSunder:Show()
			specWarnSunder:Play("defensive")
		end
	elseif spellId == 352833 then
		self.vb.beamCount = self.vb.beamCount + 1
		specWarnDisintegration:Show(self.vb.beamCount)
		specWarnDisintegration:Play("farfromline")
		timerDisintegrationCD:Start(nil, self.vb.beamCount+1)
	elseif spellId == 352660 then
		self.vb.sentryCount = self.vb.sentryCount + 1
		warnFormSentry:Show(self.vb.sentryCount)
		timerFormSentryCD:Start(nil, self.vb.sentryCount+1)
	elseif spellId == 356090 then
		self.vb.threatIcon = 1
		timerThreatNeutralizationCD:Start()
	elseif spellId == 355352 or spellId == 350734 then--Mythic, Heroic
		if self.Options.SpecWarn355352count then
			specWarnObliterateCount:Show(self.vb.patternCount)
		else
			warnObliterate:Show(self.vb.patternCount)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350496 then
		self.vb.threatIcon = 1
		timerThreatNeutralizationCD:Start()--Work around a bug with stutter casting
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 352385 then--Energizing Link
		self.vb.coreActive = true
		self.vb.protocolCount = 0
		if not playerSafe then
			specWarnRadiantEnergy:Show(radiantEnergy)
			specWarnRadiantEnergy:Play("findshelter")
		end
	elseif spellId == 352394 then
		playersSafe[args.destName] = true
		if args:IsPlayer() then
			playerSafe = true
		end
	elseif spellId == 350734 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnObliterate:Show(args.destName)
			specWarnObliterate:Play("tauntboss")
		end
	elseif spellId == 350496 then
		local icon = self.vb.threatIcon
		if self.Options.SetIconOnThreat then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnThreatNeutralization:Show()
			specWarnThreatNeutralization:Play("runout")
			yellThreatNeutralization:Yell(icon, icon)
			yellThreatNeutralizationFades:Countdown(spellId, nil, icon)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		warnThreatNeutralization:CombinedShow(0.3, args.destName)
		self.vb.threatIcon = self.vb.threatIcon + 1
--	elseif spellId == 350534 then--Purging Protocol Activating
--		timerFormSentryCD:Pause(self.vb.sentryCount+1)
--		timerThreatNeutralizationCD:Pause()
--		timerEliminationPatternCD:Pause(self.vb.patternCount+1)
--		timerDisintegrationCD:Pause(self.vb.beamCount+1)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 352385 then--Energizing Link
		self.vb.coreActive = false
--		timerEliminationPatternCD:Start(12.5, self.vb.patternCount+1)--10 on heroic?
	elseif spellId == 352394 then
		playersSafe[args.destName] = nil
		if args:IsPlayer() then
			playerSafe = false
		end
	elseif spellId == 350496 then
		if args:IsPlayer() then
			yellThreatNeutralizationFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
			if self.Options.SetIconOnThreat then
				self:SetIcon(args.destName, 0)
			end
		end
	elseif spellId == 350534 then--Purging Protocol disabling
		--Resume timers, not 100% accurate but a bit more accurate than sequencing or doing nothing.
		timerFormSentryCD:Resume(self.vb.sentryCount+1)
		timerThreatNeutralizationCD:Resume()
		timerEliminationPatternCD:Resume(self.vb.patternCount+1)
		timerDisintegrationCD:Resume(self.vb.beamCount+1)
	end
end

--"<1155.70 23:16:13> [CHAT_MSG_MONSTER_YELL] Dissection!#Guardian of the First Ones###Champssh##0#0##0#282#nil#0#false#false#false#false", -- [14127]
--"<25.44 22:36:58> [CHAT_MSG_MONSTER_YELL] Dismantle.#Guardian of the First Ones###Tadorz##0#0##0#1980#nil#0#false#false#false#false", -- [305]
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, targetName)
	if msg == L.Dissection or msg:find(L.Dissection) or msg == L.Dismantle or msg:find(L.Dismantle) then
		self:SendSync("Dissection", targetName)
	end
end

function mod:OnSync(msg, target)
	if not self:IsInCombat() then return end
	if msg == "Dissection" then
		local targetName = DBM:GetUnitFullName(target) or target
		if targetName then
			warnDisintegration:Show(targetName)--Everyone needs to dodge it so everyone gets special warning. this is just informative message
			if targetName == UnitName("player") then
				yellDisintegration:Yell()
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 350455 and destGUID == UnitGUID("player") and not playerSafe and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
