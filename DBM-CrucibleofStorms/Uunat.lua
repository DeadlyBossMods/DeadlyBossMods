local mod	= DBM:NewMod(2332, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetCreatureID(145371)
mod:SetEncounterID(2273)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 6, 7, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 293653 285185 285416 285376 285345 285453 285820 285638 285427 285562 285685",
	"SPELL_CAST_SUCCESS 284851 285652",
	"SPELL_SUMMON 286165",
	"SPELL_AURA_APPLIED 286459 286457 286458 284583 293663 293662 293661 284851 285345 287693 285333 285652 286310",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 286459 286457 286458 284583 293663 293662 293661 284851 287693 285333 285652 286310",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, improve the overall infoframe
--TODO, somehow detect abyssal collapse and absorb remaining and time remaining on infoframe and detect cast for a target warning as well
--TODO, special warning for storm instead of regular? I feel like since players control the cast, it just needs to be general for now
--TODO, do more with Oblivion Tear?
--TODO, do more with Void Crash?
--TODO, Improve eye warnings/timers with alternation in P1 and only spell name in P3
--TODO, do more with piercing Gaze of N'Zoth?
--TODO, detect Primordial Mindbender spawns in a better way
--TODO, improve icon code. need to see rate debuffs go out, how many at once, etc.
--[[
(ability.id = 293653 or ability.id = 285185 or ability.id = 285416 or ability.id = 285376 or ability.id = 285345 or ability.id = 285453 or ability.id = 285820 or ability.id = 285638 or ability.id = 285427 or ability.id = 285562 or ability.id = 285685) and type = "begincast"
 or (ability.id = 284851 or ability.id = 285652) and type = "cast"
 or ability.id = 286310
--]]
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnVoidShield					= mod:NewTargetNoFilterAnnounce(286310, 2, nil, nil, nil, nil, nil, 7)
--Relics of Power
local warnFeedbackVoid					= mod:NewYouAnnounce(286459, 2)
local warnFeedbackOcean					= mod:NewYouAnnounce(286457, 2)
local warnFeedbackStorm					= mod:NewYouAnnounce(286458, 2)
local warnStormofAnnihilation			= mod:NewTargetAnnounce(284583, 2)
--Stage One: His All-Seeing Eyes
local warnOblivionTear					= mod:NewCountAnnounce(285185, 2)
local warnVoidCrash						= mod:NewCountAnnounce(285416, 2)
local warnMaddeningEyes					= mod:NewTargetNoFilterAnnounce(285345, 4)
--local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")
--Stage Two: His Dutiful Servants
--Stage Three: His Unwavering Gaze
local warnInsatiableTorment				= mod:NewTargetNoFilterAnnounce(285652, 2)

local specWarnUnstableResonance			= mod:NewSpecialWarningMoveAway(293653, nil, nil, nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--Multiple specialwarings for same event, because this way users can customize sound for each sign
local specWarnUnstableResonanceVoid		= mod:NewSpecialWarningYouPos(293663, nil, nil, nil, 1, 6)
local specWarnUnstableResonanceOcean	= mod:NewSpecialWarningYouPos(293662, nil, nil, nil, 1, 6)
local specWarnUnstableResonanceStorm	= mod:NewSpecialWarningYouPos(293661, nil, nil, nil, 1, 6)
local yellUnstableResonanceSign			= mod:NewPosYell(293653, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--Stage One: His All-Seeing Eyes
local specWarnTouchoftheEnd				= mod:NewSpecialWarningYou(284851, nil, nil, nil, 1, 2)
local specWarnTouchoftheEndTaunt		= mod:NewSpecialWarningTaunt(284851, nil, nil, nil, 1, 6)
local specWarnMaddeningEyesCast			= mod:NewSpecialWarningDodge(285345, nil, nil, nil, 2, 2)
local specWarnMaddeningEyes				= mod:NewSpecialWarningYou(285345, nil, nil, nil, 1, 2)
local yellMaddeningEyes					= mod:NewYell(285345)
local specWarnGiftofNzothObscurity		= mod:NewSpecialWarningDodge(285453, nil, nil, nil, 2, 2)
local specWarnCallUndyingGuardian		= mod:NewSpecialWarningSwitch(285820, "-Healer", nil, nil, 1, 2)
--Stage Two: His Dutiful Servants
local specWarnGiftofNzothHysteria		= mod:NewSpecialWarningCount(285638, nil, nil, nil, 2, 2)
local specWarnConsumeEssence			= mod:NewSpecialWarningInterruptCount(285427, false, nil, nil, 1, 2)
local specWarnUnknowableTerror			= mod:NewSpecialWarningRun(285562, nil, nil, nil, 4, 2)
local specWarnPrimordialMindbender		= mod:NewSpecialWarningSwitch("ej19118", "Dps", nil, nil, 1, 2)

--Stage Three: His Unwavering Gaze
local specWarnInsatiableTorment			= mod:NewSpecialWarningYou(285652, nil, nil, nil, 1, 2)
local yellInsatiableTorment				= mod:NewYell(285652)
local specWarnGiftofNzothLunacy			= mod:NewSpecialWarningCount(285685, nil, nil, nil, 2, 2)

--Relics of Power
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerStormofAnnihilation			= mod:NewTargetTimer(15, 284583, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerUnstableResonanceCD			= mod:NewAITimer(55, 293653, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerUnstableResonance			= mod:NewBuffFadesTimer(15, 293653, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
--Stage One: His All-Seeing Eyes
local timerTouchoftheEndCD				= mod:NewCDTimer(25, 284851, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--25, but heavily affected by spell queueing or some kind of ability overlap protection
local timerOblivionTearCD				= mod:NewCDCountTimer(12.1, 285185, nil, nil, nil, 3)--12.1 but often delayed by other casts
local timerVoidCrashCD					= mod:NewCDCountTimer(31, 285416, nil, nil, nil, 3)
local timerEyesofNzothCD				= mod:NewCDCountTimer(32.7, 285376, nil, nil, nil, 3)--32.7-36.4 (probably spell queuing)
local timerCallUndyingGuardianCD		= mod:NewCDTimer(47, 285820, nil, nil, nil, 1)
local timerGiftofNzothObscurityCD		= mod:NewCDTimer(42.1, 285453, nil, nil, nil, 2)
--Stage Two: His Dutiful Servants
local timerUnknowableTerrorCD			= mod:NewCDTimer(40.5, 285562, nil, nil, nil, 3)
local timerMindBenderCD					= mod:NewCDCountTimer(61.1, "ej19118", 284485, nil, nil, 1, 285427, DBM_CORE_DAMAGE_ICON)--Shorttext, Mindbender
local timerGiftofNzothHysteriaCD		= mod:NewCDCountTimer(42.5, 285638, nil, nil, nil, 2)
--Stage Three: His Unwavering Gaze
local timerInsatiableTormentCD			= mod:NewCDTimer(23.1, 285652, nil, nil, nil, 3)
local timerGiftofNzothLunacyCD			= mod:NewCDCountTimer(42.6, 285685, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Relics of Power
--local countdownResonance				= mod:NewCountdown(50, 293653, nil, nil, 10)
local countdownResonanceFades			= mod:NewCountdownFades(15, 293653, nil, nil, 5)
--Stage One: His All-Seeing Eyes
--Stage Two: His Dutiful Servants
--Stage Three: His Unwavering Gaze
--local countdownTouchoftheEnd			= mod:NewCountdown("Alt12", 284851, "Tank", nil, 3)
--local countdownFelstormBarrage		= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(10, 293653)
--mod:AddInfoFrameOption(258040, true)
mod:AddNamePlateOption("NPAuraOnBond", 287693)
mod:AddNamePlateOption("NPAuraOnFeed", 285307)
mod:AddNamePlateOption("NPAuraOnRegen", 285333)
mod:AddNamePlateOption("NPAuraOnConsume", 285427)
mod:AddSetIconOption("SetIconTorment", 285652, true)
mod:AddSetIconOption("SetIconOnAdds", 285427, true, true)

mod.vb.phase = 1
mod.vb.resonCount = 0
mod.vb.tearCount = 0
mod.vb.voidCrashCount = 0
mod.vb.nzothEyesCount = 0
mod.vb.activeUndying = 0
mod.vb.HysteriaCount = 0
mod.vb.LunacyCount = 0
mod.vb.tormentIcon = 1--1 forwards
mod.vb.addIcon = 8--8 backwards
mod.vb.mindBenderCount = 0
local trackedFeedback1, trackedFeedback2, trackedFeedback3 = false, false, false
local playerAffected = false
local unitTracked = {}
local castsPerGUID = {}
local interruptTextures = {[1] = 2178508, [2] = 2178501, [3] = 2178502, [4] = 2178503, [5] = 2178504, [6] = 2178505, [7] = 2178506, [8] = 2178507,}--Fathoms Deck

local updateInfoFrame
do
	local UnstableResonance = DBM:GetSpellInfo(293653)
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Umbral Absorb Checks
		--[[for uId in DBM:GetGroupMembers() do
			local absorbAmount = select(16, DBM:UnitDebuff(uId, 284722))
			if absorbAmount then
				local unitName = DBM:GetUnitFullName(uId)
				addLine(unitName, math.floor(absorbAmount))
			end
		end--]]
		--Bosses Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--Track Active Resonance Debuffs
		if mod.vb.resonCount > 0 then
			addLine(UnstableResonance, mod.vb.resonCount)
		end
		--Player personal checks (Checked if you have feedback)
		if trackedFeedback1 then--Void
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 286459)
			local remaining = expireTime-GetTime()
			if spellName and expireTime then
				addLine(spellName, math.floor(remaining))
			end
		end
		if trackedFeedback2 then--Ocean
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 286457)
			local remaining = expireTime-GetTime()
			if spellName and expireTime then
				addLine(spellName, math.floor(remaining))
			end
		end
		if trackedFeedback3 then--Storm
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 286458)
			local remaining = expireTime-GetTime()
			if spellName and expireTime then
				addLine(spellName, math.floor(remaining))
			end
		end
		return lines, sortedLines
	end
end

local function updateResonanceYell(self, icon)
	if not self.Options.ResonanceYellFilter then return end
	if playerAffected then
		yellUnstableResonanceSign:Yell(icon, "", icon)
		self:Schedule(2, updateResonanceYell, self, icon)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.resonCount = 0
	self.vb.tearCount = 0
	self.vb.voidCrashCount = 0
	self.vb.nzothEyesCount = 0
	self.vb.activeUndying = 0
	self.vb.HysteriaCount = 0
	self.vb.LunacyCount = 0
	self.vb.tormentIcon = 1
	self.vb.addIcon = 8
	self.vb.mindBenderCount = 0
	trackedFeedback1, trackedFeedback2, trackedFeedback3 = false, false, false
	playerAffected = false
	table.wipe(unitTracked)
	table.wipe(castsPerGUID)
	if self:IsHard() then
		timerVoidCrashCD:Start(6.1-delay, 1)
	end
	timerOblivionTearCD:Start(12.1-delay, 1)
	timerTouchoftheEndCD:Start(26.7-delay)
	timerGiftofNzothObscurityCD:Start(20.6-delay)
	timerCallUndyingGuardianCD:Start(30.3-delay)
	timerEyesofNzothCD:Start(42-delay, 1)
	if self:IsMythic() then
		timerUnstableResonanceCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnBond or self.Options.NPAuraOnFeed or self.Options.NPAuraOnRegen or self.Options.NPAuraOnConsume then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnBond or self.Options.NPAuraOnFeed or self.Options.NPAuraOnRegen or self.Options.NPAuraOnConsume then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 293653 then
		specWarnUnstableResonance:Show()
		specWarnUnstableResonance:Play("scatter")
		timerUnstableResonanceCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif spellId == 285185 then
		self.vb.tearCount = self.vb.tearCount + 1
		warnOblivionTear:Show(self.vb.tearCount)
		timerOblivionTearCD:Start(nil, self.vb.tearCount+1)
	elseif spellId == 285416 then
		self.vb.voidCrashCount = self.vb.voidCrashCount + 1
		warnVoidCrash:Show(self.vb.voidCrashCount)
		timerVoidCrashCD:Start(nil, self.vb.voidCrashCount+1)
	elseif spellId == 285376 then
		self.vb.nzothEyesCount = self.vb.nzothEyesCount + 1
		timerEyesofNzothCD:Start(nil, self.vb.nzothEyesCount+1)
	elseif spellId == 285345 and self:AntiSpam(3, 1) then
		specWarnMaddeningEyesCast:Show()
		specWarnMaddeningEyesCast:Play("farfromline")
	elseif spellId == 285453 then
		specWarnGiftofNzothObscurity:Show()
		specWarnGiftofNzothObscurity:Play("watchstep")
		timerGiftofNzothObscurityCD:Start()
	elseif spellId == 285820 then
		--Not a tank, or you are a tank and affected by Touch of the end (the tank that needs to deal with mob)
		if not self:IsTank() or DBM:UnitDebuff("player", 284851) then
			specWarnCallUndyingGuardian:Show()
			specWarnCallUndyingGuardian:Play("bigmob")
		end
		timerCallUndyingGuardianCD:Start()
	elseif spellId == 285638 then
		self.vb.HysteriaCount = self.vb.HysteriaCount + 1
		specWarnGiftofNzothHysteria:Show(self.vb.HysteriaCount)
		specWarnGiftofNzothHysteria:Play("aesoon")
		timerGiftofNzothHysteriaCD:Start(40.5, self.vb.HysteriaCount+1)
	elseif spellId == 285562 and self:AntiSpam(8, 2) then
		specWarnUnknowableTerror:Show()
		specWarnUnknowableTerror:Play("fearsoon")
		specWarnUnknowableTerror:ScheduleVoice(1.5, "justrun")
		timerUnknowableTerrorCD:Start()
	elseif spellId == 285685 then
		self.vb.LunacyCount = self.vb.LunacyCount + 1
		specWarnGiftofNzothLunacy:Show(self.vb.LunacyCount)
		specWarnGiftofNzothLunacy:Play("stopattack")--Right voice?
		timerGiftofNzothLunacyCD:Start(nil, self.vb.LunacyCount+1)
	elseif spellId == 285427 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 10)
			end
			self.vb.addIcon = self.vb.addIcon - 1
			if self.vb.addIcon == 5 then--8-6
				self.vb.addIcon = 8
			end
			if self:AntiSpam(5, 3) then
				self.vb.mindBenderCount = self.vb.mindBenderCount + 1
				specWarnPrimordialMindbender:Show(self.vb.mindBenderCount)
				specWarnPrimordialMindbender:Play("killmob")
				timerMindBenderCD:Start(nil, self.vb.mindBenderCount+1)
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnConsumeEssence:Show(args.sourceName, count)
			if count == 1 then
				specWarnConsumeEssence:Play("kick1r")
			elseif count == 2 then
				specWarnConsumeEssence:Play("kick2r")
			elseif count == 3 then
				specWarnConsumeEssence:Play("kick3r")
			elseif count == 4 then
				specWarnConsumeEssence:Play("kick4r")
			elseif count == 5 then
				specWarnConsumeEssence:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnConsumeEssence:Play("kickcast")
			end
		end
		if self.Options.NPAuraOnConsume then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, interruptTextures[count])
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 284851 then
		timerTouchoftheEndCD:Start()
	elseif spellId == 285652 then
		timerInsatiableTormentCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 286165 then
		self.vb.activeUndying = self.vb.activeUndying + 1
		if self.Options.NPAuraOnFeed and self.vb.activeUndying == 1 then--This should only happen if previous count was 0, so re-enable scanner
			self:RegisterOnUpdateHandler(function(self)
				for i = 1, 40 do
					local UnitID = "nameplate"..i
					local GUID = UnitGUID(UnitID)
					local cid = self:GetCIDFromGUID(GUID)
					if cid == 139059 then
						local unitPower = UnitPower(UnitID)
						if not unitTracked[GUID] then unitTracked[GUID] = "None" end
						if (unitPower < 30) then
							if unitTracked[GUID] ~= "Green" then
								unitTracked[GUID] = "Green"
								DBM.Nameplate:Show(true, GUID, 276299, 463281)
							end
						elseif (unitPower < 60) then
							if unitTracked[GUID] ~= "Yellow" then
								unitTracked[GUID] = "Yellow"
								DBM.Nameplate:Hide(true, GUID, 276299, 463281)
								DBM.Nameplate:Show(true, GUID, 276299, 460954)
							end
						elseif (unitPower < 90) then
							if unitTracked[GUID] ~= "Red" then
								unitTracked[GUID] = "Red"
								DBM.Nameplate:Hide(true, GUID, 276299, 460954)
								DBM.Nameplate:Show(true, GUID, 276299, 463282)
							end
						elseif (unitPower < 100) then
							if unitTracked[GUID] ~= "Critical" then
								unitTracked[GUID] = "Critical"
								DBM.Nameplate:Hide(true, GUID, 276299, 463282)
								DBM.Nameplate:Show(true, GUID, 276299, 237521)
							end
						end
					end
				end
			end, 1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 286459 then--Void Feedback
		if args:IsPlayer() then
			trackedFeedback1 = true
			warnFeedbackVoid:Show()
		end
	elseif spellId == 286457 then--Ocean Feedback
		if args:IsPlayer() then
			trackedFeedback2 = true
			warnFeedbackOcean:Show()
		end
	elseif spellId == 286458 then--Storm Feedback
		if args:IsPlayer() then
			trackedFeedback3 = true
			warnFeedbackStorm:Show()
		end
	elseif spellId == 284583 then
		warnStormofAnnihilation:Show(args.destName)
		timerStormofAnnihilation:Start(args.destName)
	elseif spellId == 293663 or spellId == 293662 or spellId == 293661 then--Unstable Resonance (all)
		self.vb.resonCount = self.vb.resonCount + 1
		if spellId == 293663 then--Void
			if args:IsPlayer() then
				specWarnUnstableResonanceVoid:Show(self:IconNumToTexture(3))
				specWarnUnstableResonanceVoid:Play("mm"..3)
				yellUnstableResonanceSign:Yell(3, "", 3)--Purple Diamond
				self:Schedule(2, updateResonanceYell, self, 3)
				countdownResonanceFades:Start()
				timerUnstableResonance:Start()
				playerAffected = true
			end
		elseif spellId == 293662 then--Ocean
			if args:IsPlayer() then
				specWarnUnstableResonanceOcean:Show(self:IconNumToTexture(6))
				specWarnUnstableResonanceOcean:Play("mm"..6)
				yellUnstableResonanceSign:Yell(6, "", 6)--Blue Square
				self:Schedule(2, updateResonanceYell, self, 6)
				countdownResonanceFades:Start()
				timerUnstableResonance:Start()
				playerAffected = true
			end
		elseif spellId == 293661 then--Storm
			if args:IsPlayer() then
				specWarnUnstableResonanceStorm:Show(self:IconNumToTexture(1))
				specWarnUnstableResonanceStorm:Play("mm"..1)
				yellUnstableResonanceSign:Yell(1, "", 1)--Yellow Star
				self:Schedule(2, updateResonanceYell, self, 1)
				countdownResonanceFades:Start()
				timerUnstableResonance:Start()
				playerAffected = true
			end
		end
	elseif spellId == 284851 then
		if args:IsPlayer() then
			specWarnTouchoftheEnd:Show()
			specWarnTouchoftheEnd:Play("runout")
		else
			--Filter non tanks, because some asshole is gonna be in front of boss that shouldn't be (especially in LFR)
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnTouchoftheEndTaunt:Show(args.destName)
				specWarnTouchoftheEndTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 285345 then
		if args:IsPlayer() then
			specWarnMaddeningEyes:Show()
			specWarnMaddeningEyes:Play("targetyou")
			yellMaddeningEyes:Yell()
		else
			warnMaddeningEyes:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 287693 then--Sightless Bond on Boss
		if self.Options.NPAuraOnBond then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 285333 then--Unnatural Regeneration
		if self.Options.NPAuraOnRegen then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 285652 then
		if args:IsPlayer() then
			specWarnInsatiableTorment:Show()
			specWarnInsatiableTorment:Play("targetyou")
			yellInsatiableTorment:Yell()
		else
			warnInsatiableTorment:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconTorment then
			self:SetIcon(args.destName, self.vb.tormentIcon)
		end
		self.vb.tormentIcon = self.vb.tormentIcon + 1
	elseif spellId == 286310 then--Void Shield
		warnVoidShield:Show(args.destName)
		warnVoidShield:Play("phasechange")
		timerVoidCrashCD:Stop()
		timerOblivionTearCD:Stop()
		timerTouchoftheEndCD:Stop()
		timerGiftofNzothObscurityCD:Stop()
		timerCallUndyingGuardianCD:Stop()
		timerEyesofNzothCD:Stop()
		timerGiftofNzothHysteriaCD:Stop()
		timerUnknowableTerrorCD:Stop()
		timerInsatiableTormentCD:Stop()
		timerGiftofNzothLunacyCD:Stop()
		timerMindBenderCD:Stop()
		timerUnstableResonanceCD:Stop()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286459 then--Void
		if args:IsPlayer() then
			trackedFeedback1 = false
		end
	elseif spellId == 286457 then--Ocean
		if args:IsPlayer() then
			trackedFeedback2 = false
		end
	elseif spellId == 286458 then--Storm
		if args:IsPlayer() then
			trackedFeedback3 = false
		end
	elseif spellId == 284583 then
		timerStormofAnnihilation:Stop(args.destName)
	elseif spellId == 293663 or spellId == 293662 or spellId == 293661 then--Unstable Resonance (all)
		self.vb.resonCount = self.vb.resonCount - 1
		if args:IsPlayer() then
			self:Unschedule(updateResonanceYell)
			countdownResonanceFades:Cancel()
			timerUnstableResonance:Stop()
			playerAffected = false
		end
		if self.Options.RangeFrame and self.vb.resonCount == 0 then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 287693 then
		if self.Options.NPAuraOnBond then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 285333 then--Unnatural Regeneration
		if self.Options.NPAuraOnRegen then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 285652 then
		if self.Options.SetIconTorment then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 286310 and self:IsInCombat() then--Void Shield
		self.vb.phase = self.vb.phase + 1
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		self.vb.tearCount = 0--Maybe not reset?
		if self.vb.phase == 2 then
			timerVoidCrashCD:Stop()
			timerOblivionTearCD:Start(13.3, 1)
			timerUnknowableTerrorCD:Start(18.2)
			timerTouchoftheEndCD:Start(22.2)
			timerCallUndyingGuardianCD:Start(32)
			timerMindBenderCD:Start(34.4, 1)
			timerGiftofNzothHysteriaCD:Start(40.5, 1)
			if self:IsMythic() then
				timerUnstableResonanceCD:Start(2)
			end
		elseif self.vb.phase == 3 then--Assumed, unsubstanciated
			self.vb.nzothEyesCount = 0
			--Timers and stuff
			timerInsatiableTormentCD:Start(12.1)
			timerOblivionTearCD:Start(13.3, 1)
			timerTouchoftheEndCD:Start(21.9)
			timerCallUndyingGuardianCD:Start(26.7)
			timerGiftofNzothLunacyCD:Start(40.1, 1)
			if self:IsMythic() then
				timerUnstableResonanceCD:Start(3)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146829 then--Undying Guardian
		self.vb.activeUndying = self.vb.activeUndying - 1
		if self.Options.NPAuraOnFeed then
			DBM.Nameplate:Hide(true, args.destGUID)
			unitTracked[args.destGUID] = nil
			if self.vb.activeUndying == 0 then
				self:UnregisterOnUpdateHandler()
			end
		end
	elseif cid == 146940 then--Primordial Mindbender
		castsPerGUID[args.destGUID] = nil
		if self.Options.NPAuraOnConsume then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	--elseif cid == 147024 then--Unknowable Terror
		--timerUnknowableTerrorCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then

	end
end
--]]
