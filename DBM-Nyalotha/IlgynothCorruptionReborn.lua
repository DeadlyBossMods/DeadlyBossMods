local mod	= DBM:NewMod(2374, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158328)
mod:SetEncounterID(2345)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod.noBossDeathKill = true--Instructs mod to ignore 158328 deaths, since it might die 4x on this fight
mod:SetHotfixNoticeRev(20200130000000)--2020, 1, 30
--mod:SetMinSyncRevision(20190716000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 309961 311401 310788 318383",
	"SPELL_CAST_SUCCESS 311401 311159 314396 319005",
	"SPELL_AURA_APPLIED 309961 311367 310322 315094 311159 313759",
	"SPELL_AURA_APPLIED_DOSE 309961",
	"SPELL_AURA_REMOVED 311367 315094 311159 313759",
	"SPELL_PERIODIC_DAMAGE 310322",
	"SPELL_PERIODIC_MISSED 310322",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, https://ptr.wowhead.com/spell=312486/recurring-nightmare need DBM hand holding? Maybe we can track them on infoframe if required?
--[[
(ability.id = 309961 or ability.id = 311401) and type = "begincast"
 or (ability.id = 311401 or ability.id = 311159 or ability.id = 314396 or ability.id = 319005) and type = "cast"
 or ability.id = 310788
--]]
--Stage 01: The Corruptor, Reborn
local warnEyeofNZoth						= mod:NewStackAnnounce(309961, 2, nil, "Tank")
local warnTouchoftheCorruptor				= mod:NewTargetNoFilterAnnounce(311367, 4)
local warnFixate							= mod:NewTargetAnnounce(315094, 2)
--Stage 02: The Organs of Corruption
local warnCursedBlood						= mod:NewTargetAnnounce(311159, 2)
local warnAbsorbingCharge					= mod:NewTargetNoFilterAnnounce(318383, 3)

--Stage 01: The Corruptor, Reborn
local specWarnEyeofNZoth					= mod:NewSpecialWarningStack(309961, nil, 2, nil, nil, 1, 6)
local specWarnEyeofNZothTaunt				= mod:NewSpecialWarningTaunt(309961, nil, nil, nil, 1, 2)
local specWarnTouchoftheCorruptor			= mod:NewSpecialWarningYou(311367, nil, nil, nil, 1, 2)
local yellTouchoftheCorruptor				= mod:NewYell(311367)
local specWarnCorruptorsGaze				= mod:NewSpecialWarningSpell(310319, nil, 202046, nil, 2, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(310322, nil, nil, nil, 1, 8)
local specWarnFixate						= mod:NewSpecialWarningYou(315094, nil, nil, nil, 1, 2)
--Stage 02: The Organs of Corruption
local specWarnCursedBlood					= mod:NewSpecialWarningMoveAway(311159, nil, nil, nil, 1, 2)
local yellCursedBlood						= mod:NewShortYell(311159)
local yellCursedBloodFades					= mod:NewShortFadesYell(311159)
local specWarnPumpingBlood					= mod:NewSpecialWarningInterruptCount(310788, "HasInterrupt", nil, nil, 1, 2)
local specWarnAbsorbingCharge				= mod:NewSpecialWarningYou(318383, nil, nil, nil, 3, 2)
local yellAbsorbingCharge					= mod:NewYell(318383)

--mod:AddTimerLine(BOSS)
--Stage 01: The Corruptor, Reborn
local timerEyeofNZothCD						= mod:NewCDTimer(17, 309961, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--16.6-17.4 (0ld), new seems more stable 17
local timerTouchoftheCorruptorCD			= mod:NewCDCountTimer(64.4, 311401, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON, nil, 1, 4)--64.4-68
local timerCorruptorsGazeCD					= mod:NewCDCountTimer(32.2, 310319, 202046, nil, nil, 3)--32.8-34 Shorttext "Beam"
--Stage 02: The Organs of Corruption
local timerCursedBloodCD					= mod:NewNextCountTimer(18, 311159, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerAbsorbingChargeCD				= mod:NewNextTimer(18.3, 318383, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(11, 311159)
mod:AddInfoFrameOption(315094, true)
mod:AddSetIconOption("SetIconOnMC", 311367, false, false, {1, 2, 3, 4, 5, 6, 7})
mod:AddSetIconOption("SetIconOnOoze", "ej20988", false, true, {8})--Perma disabled in LFR
mod:AddSetIconOption("SetIconOnCusedBlood", 313759, false, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddBoolOption("SetIconOnlyOnce", true)--If disabled, as long as living oozes are up, the skull will bounce around to lowest health mob continually, which is likely not desired by most, thus this defaulted on
mod:AddMiscLine(DBM_CORE_OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InterruptBehavior", {"Two", "Three", "Four", "Five"}, "Two", "misc")

--mod.vb.phase = 1
mod.vb.TouchofCorruptorIcon = 1
mod.vb.IchorCount = 0
mod.vb.interruptBehavior = "Two"
mod.vb.organPhase = false
mod.vb.bloodIcon = 1
mod.vb.bloodCount = 0
mod.vb.mcCount = 0
mod.vb.beamCount = 0

local addsTable = {}
local autoMarkScannerActive = false
local autoMarkBlocked = false
local fixatedTargets = {}
local castsPerGUID = {}

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	local OozeName, fixateName = DBM:EJ_GetSectionInfo(20988), DBM:GetSpellInfo(315094)
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Ooze Count
		if mod.vb.IchorCount > 0 then
			addLine(OozeName, mod.vb.IchorCount)
		end
		--Fixate target names
		if #fixatedTargets > 0 then
			addLine("---"..fixateName.."---")
			for i=1, #fixatedTargets do
				local name = fixatedTargets[i]
				addLine(name, "")
			end
		end
		--No Oozes alive and no fixates left, auto hide infoframe
		if #sortedLines == 0 then
			DBM.InfoFrame:Hide()
		end
		return lines, sortedLines
	end
end

local autoMarkOozes
do
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax
	autoMarkOozes = function(self)
		self:Unschedule(autoMarkOozes)
		if self.vb.IchorCount == 0 then
			autoMarkScannerActive = false
			autoMarkBlocked = false
			return
		end--None left, abort scans
		local lowestUnitID = nil
		local lowestHealth = 100
		local found = false
		for i = 1, 40 do
			local UnitID = "nameplate"..i
			local GUID = UnitGUID(UnitID)
			if GUID then
				local cid = self:GetCIDFromGUID(GUID)
				if cid == 159514 then
					local unitHealth = UnitHealth(UnitID) / UnitHealthMax(UnitID)
					if unitHealth < lowestHealth then
						lowestHealth = unitHealth
						lowestUnitID = UnitID
					end
				end
			end
		end
		if lowestUnitID then
			SetRaidTarget(lowestUnitID, 8)
			found = true
		end
		if found and self.Options.SetIconOnlyOnce then
			--Abort until invoked again
			autoMarkScannerActive = false
			autoMarkBlocked = true
			return
		end
		self:Schedule(1, autoMarkOozes, self)
	end
end

function mod:AbsorbingChargeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnAbsorbingCharge:Show()
		specWarnAbsorbingCharge:Play("targetyou")
		yellAbsorbingCharge:Yell()
	else
		warnAbsorbingCharge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	--DBM Core Special Variables
	self.vb.bossLeft = 4--Ilgynoth plus 3 organs
	self.numBoss = 4--^^
	--Regular Variables
	--self.vb.phase = 1
	self.vb.TouchofCorruptorIcon = 1
	self.vb.IchorCount = 0
	self.vb.bloodIcon = 1
	self.vb.bloodCount = 0
	self.vb.mcCount = 0
	self.vb.beamCount = 0
	self.vb.interruptBehavior = self.Options.InterruptBehavior--Default it to whatever user has it set to, until group leader overrides it
	self.vb.organPhase = false
	autoMarkScannerActive = false
	autoMarkBlocked = false
	table.wipe(addsTable)
	table.wipe(fixatedTargets)
	table.wipe(castsPerGUID)
	timerEyeofNZothCD:Start(5.2-delay)--START
	timerCorruptorsGazeCD:Start(12.2-delay, 1)
	berserkTimer:Start(600-delay)--Confirmed heroic and normal
	if self:IsHard() then
		timerTouchoftheCorruptorCD:Start(50.7-delay, 1)--SUCCESS
		if self:IsMythic() then
			timerCursedBloodCD:Start(20-delay)
			timerCursedBloodCD:UpdateInline(DBM_CORE_MAGIC_ICON)
		end
	end
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Two" then
			self:SendSync("Two")
		elseif self.Options.InterruptBehavior == "Three" then
			self:SendSync("Three")
		elseif self.Options.InterruptBehavior == "Four" then
			self:SendSync("Four")
		elseif self.Options.InterruptBehavior == "Five" then
			self:SendSync("Five")
		end
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 309961 then
		timerEyeofNZothCD:Start()
	elseif spellId == 311401 then
		self.vb.TouchofCorruptorIcon = 1
	elseif spellId == 310788 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		if (self.vb.interruptBehavior == "Two" and castsPerGUID[args.sourceGUID] == 2) or (self.vb.interruptBehavior == "Three" and castsPerGUID[args.sourceGUID] == 3) or (self.vb.interruptBehavior == "Four" and castsPerGUID[args.sourceGUID] == 4) or (self.vb.interruptBehavior == "Five" and castsPerGUID[args.sourceGUID] == 5) then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		--timerPumpingBloodCD:Start(nil, count+1, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnPumpingBlood:Show(args.sourceName, count)
			if count == 1 then
				specWarnPumpingBlood:Play("kick1r")
			elseif count == 2 then
				specWarnPumpingBlood:Play("kick2r")
			elseif count == 3 then
				specWarnPumpingBlood:Play("kick3r")
			elseif count == 4 then
				specWarnPumpingBlood:Play("kick4r")
			elseif count == 5 then
				specWarnPumpingBlood:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnPumpingBlood:Play("kickcast")
			end
		end
	elseif spellId == 318383 then
		timerAbsorbingChargeCD:Start(18.3, args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "AbsorbingChargeTarget", 0.1, 8)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 311401 then
		self.vb.mcCount = self.vb.mcCount + 1
		timerTouchoftheCorruptorCD:Start(nil, self.vb.mcCount+1)
	elseif spellId == 311159 or spellId == 314396 then--Non Mythic, Mythic
		self.vb.bloodCount = self.vb.bloodCount + 1
		timerCursedBloodCD:Start(self:IsMythic() and 45 or 18, self.vb.bloodCount+1)
		if self:IsMythic() then
			self.vb.bloodIcon = 1
			timerCursedBloodCD:UpdateInline(DBM_CORE_MAGIC_ICON, self.vb.bloodCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 309961 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnEyeofNZoth:Show(amount)
					specWarnEyeofNZoth:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and (not remaining or remaining and remaining < 15) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnEyeofNZothTaunt:Show(args.destName)
						specWarnEyeofNZothTaunt:Play("tauntboss")
					else
						warnEyeofNZoth:Show(args.destName, amount)
					end
				end
			else
				warnEyeofNZoth:Show(args.destName, amount)
			end
		end
	elseif spellId == 311367 then
		warnTouchoftheCorruptor:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnTouchoftheCorruptor:Show()
			specWarnTouchoftheCorruptor:Play("targetyou")
			yellTouchoftheCorruptor:Yell()
		end
		if self.Options.SetIconOnMC and self.vb.TouchofCorruptorIcon < 8 then
			self:SetIcon(args.destName, self.vb.TouchofCorruptorIcon)
		end
		self.vb.TouchofCorruptorIcon = self.vb.TouchofCorruptorIcon + 1
	elseif spellId == 310322 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 315094 then--Ooze Fixate
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() and self:AntiSpam(4, 3) then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
		end
		if not addsTable[args.sourceGUID] then
			addsTable[args.sourceGUID] = true
			self.vb.IchorCount = self.vb.IchorCount + 1
			if self.Options.SetIconOnOoze and not self:IsLFR() and not autoMarkScannerActive and not autoMarkBlocked then
				autoMarkScannerActive = true
				self:Schedule(2.5, autoMarkOozes, self)--TODO, maybe speed up or slow down slightly
			end
		end
		if not tContains(fixatedTargets, args.destName) then
			table.insert(fixatedTargets, args.destName)
		end
		if self.Options.InfoFrame then
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false, true)
			else
				DBM.InfoFrame:Update()
			end
		end
	elseif spellId == 311159 or spellId == 313759 then--Non Mythic, Mythic
		warnCursedBlood:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCursedBlood:Show()
			specWarnCursedBlood:Play("runout")
			yellCursedBlood:Yell()
			if spellId == 311159 then--Non Mythic
				yellCursedBloodFades:Countdown(spellId)
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(11)
				end
			end
		end
		if spellId == 313759 then--Mythic Only Option
			if self.Options.SetIconOnCusedBlood then
				self.SetIcon(args.destName, self.vb.bloodIcon)
			end
			self.vb.bloodIcon = self.vb.bloodIcon + 1
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 311367 then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 315094 then
		local uId = DBM:GetRaidUnitId(args.destName)
		--Person could have more than one fixate, so we need to see if they still have one before removing from table
		if uId and not DBM:UnitDebuff(uId, spellId) then
			tDeleteItem(fixatedTargets, args.destName)
			if self.Options.InfoFrame then
				DBM.InfoFrame:Update()
			end
		end
	elseif spellId == 311159 or spellId == 313759 then
		if args:IsPlayer() then
			yellCursedBloodFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if spellId == 313759 then--Mythic Only Option
			if self.Options.SetIconOnCusedBlood then
				self.SetIcon(args.destName, 0)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 310322 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 159514 then--blood-of-nyalotha
		self.vb.IchorCount = self.vb.IchorCount - 1
		addsTable[args.destGUID] = nil
		if self.Options.SetIconOnOoze and not self:IsLFR() and not autoMarkScannerActive then
			autoMarkBlocked = false
			autoMarkScannerActive = true
			autoMarkOozes(self)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif cid == 163678 then--Clotted Corruption
		timerAbsorbingChargeCD:Stop(args.destGUID)
	end
end

--Placeholder. Maybe correct maybe totally wrong
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--SPELL_CAST_SUCCESS 319005 appears in combat log for phase change on mythic, but don't be fooled, it doesn't exist on non mythic. Parry exists in all modes
	if spellId == 110470 and self:AntiSpam(3, 1) then--Reduce Parry and Block Chance 100% (Organ phase begin)
		self.vb.organPhase = true
		--self.vb.phase = self.vb.phase + 0.5
		timerCorruptorsGazeCD:Stop()
		timerTouchoftheCorruptorCD:Stop()
		timerEyeofNZothCD:Stop()
		if not self:IsMythic() then
			self.vb.bloodCount = 0
			timerCursedBloodCD:Start(3, 1)
		else
			timerAbsorbingChargeCD:Start(9)--Can't know GUID here, but only place to start it
		end
	elseif spellId == 311577 then--Damaged Organ (organs "dying")
		self.vb.organPhase = false
		self.vb.bossLeft = self.vb.bossLeft - 1
		--self.vb.phase = self.vb.phase + 0.5
	elseif spellId == 310433 then--Corruptor's Gaze
		specWarnCorruptorsGaze:Show()
		specWarnCorruptorsGaze:Play("watchstep")
		timerCorruptorsGazeCD:Start(nil, self.vb.beamCount+1)
	elseif spellId == 312204 then--Il'gynoth's Morass
		--Start timers here, not at organ death
		--it's possible to screw up organ phase so bad that you leave it without killing any of them
		table.wipe(castsPerGUID)
		self.vb.beamCount = 0
		if not self:IsMythic() then
			timerCursedBloodCD:Stop()
		end
		timerEyeofNZothCD:Start(6)--START
		timerCorruptorsGazeCD:Start(12, 1)
		if self:IsHard() then
			self.vb.mcCount = 0
			timerTouchoftheCorruptorCD:Start(51.5, 1)--SUCCESS
		end
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Two" then
		self.vb.interruptBehavior = "Two"
	elseif msg == "Three" then
		self.vb.interruptBehavior = "Three"
	elseif msg == "Four" then
		self.vb.interruptBehavior = "Four"
	elseif msg == "Five" then
		self.vb.interruptBehavior = "Five"
	end
end
