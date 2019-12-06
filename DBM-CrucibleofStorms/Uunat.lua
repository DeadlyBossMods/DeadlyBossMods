local mod	= DBM:NewMod(2332, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(145371)
mod:SetEncounterID(2273)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20190505173730)
mod:SetMinSyncRevision(20190505173730)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 293653 285185 285416 285376 285345 285453 285820 285638 285427 285562 285685",
	"SPELL_CAST_SUCCESS 284851 285652 293653",
	"SPELL_SUMMON 286165",
	"SPELL_AURA_APPLIED 286459 286457 286458 284583 293663 293662 293661 284851 285345 287693 285333 285652 286310 284768 284569 284684 284722",
	"SPELL_AURA_REMOVED 286459 286457 286458 284583 293663 293662 293661 284851 287693 285333 286310 284768 284569 284684 284722",
	"UNIT_DIED"
)

--TODO, somehow detect abyssal collapse and absorb remaining and time remaining on infoframe and detect cast for a target warning as well
--TODO, special warning for storm instead of regular? I feel like since players control the cast, it just needs to be general for now
--TODO, do more with Oblivion Tear?
--TODO, do more with Void Crash?
--[[
(ability.id = 293653 or ability.id = 285185 or ability.id = 285416 or ability.id = 285376 or ability.id = 285345 or ability.id = 285453 or ability.id = 285820 or ability.id = 285638 or ability.id = 285427 or ability.id = 285562 or ability.id = 285685) and type = "begincast"
 or (ability.id = 284851 or ability.id = 285652) and type = "cast"
 or ability.id = 286310
 or (ability.id = 284768 or ability.id = 284569 or ability.id = 284684)
--]]
--Undying 2 first, Eye 2 second
--Heroic https://www.warcraftlogs.com/reports/VNWqBp9v6JXzTYRd#fight=17&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20293653%20or%20ability.id%20%3D%20285185%20or%20ability.id%20%3D%20285416%20or%20ability.id%20%3D%20285376%20or%20ability.id%20%3D%20285345%20or%20ability.id%20%3D%20285453%20or%20ability.id%20%3D%20285820%20or%20ability.id%20%3D%20285638%20or%20ability.id%20%3D%20285427%20or%20ability.id%20%3D%20285562%20or%20ability.id%20%3D%20285685)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20284851%20or%20ability.id%20%3D%20285652)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20286310%20%20or%20(ability.id%20%3D%20284768%20or%20ability.id%20%3D%20284569%20or%20ability.id%20%3D%20284684)
--Mythic https://www.warcraftlogs.com/reports/Dq1vBHCx6k3KnZJY#fight=50&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20293653%20or%20ability.id%20%3D%20285185%20or%20ability.id%20%3D%20285416%20or%20ability.id%20%3D%20285376%20or%20ability.id%20%3D%20285345%20or%20ability.id%20%3D%20285453%20or%20ability.id%20%3D%20285820%20or%20ability.id%20%3D%20285638%20or%20ability.id%20%3D%20285427%20or%20ability.id%20%3D%20285562%20or%20ability.id%20%3D%20285685)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20284851%20or%20ability.id%20%3D%20285652)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20286310%20%20or%20(ability.id%20%3D%20284768%20or%20ability.id%20%3D%20284569%20or%20ability.id%20%3D%20284684)

--Eyes 2 first, Undying 2 second
--Heroic https://www.warcraftlogs.com/reports/VNWqBp9v6JXzTYRd#fight=19&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20293653%20or%20ability.id%20%3D%20285185%20or%20ability.id%20%3D%20285416%20or%20ability.id%20%3D%20285376%20or%20ability.id%20%3D%20285345%20or%20ability.id%20%3D%20285453%20or%20ability.id%20%3D%20285820%20or%20ability.id%20%3D%20285638%20or%20ability.id%20%3D%20285427%20or%20ability.id%20%3D%20285562%20or%20ability.id%20%3D%20285685)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20284851%20or%20ability.id%20%3D%20285652)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20286310%20%20or%20(ability.id%20%3D%20284768%20or%20ability.id%20%3D%20284569%20or%20ability.id%20%3D%20284684)
--Mythic https://www.warcraftlogs.com/reports/Dq1vBHCx6k3KnZJY#fight=47&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20293653%20or%20ability.id%20%3D%20285185%20or%20ability.id%20%3D%20285416%20or%20ability.id%20%3D%20285376%20or%20ability.id%20%3D%20285345%20or%20ability.id%20%3D%20285453%20or%20ability.id%20%3D%20285820%20or%20ability.id%20%3D%20285638%20or%20ability.id%20%3D%20285427%20or%20ability.id%20%3D%20285562%20or%20ability.id%20%3D%20285685)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20284851%20or%20ability.id%20%3D%20285652)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20286310%20%20or%20(ability.id%20%3D%20284768%20or%20ability.id%20%3D%20284569%20or%20ability.id%20%3D%20284684)
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnVoidShield					= mod:NewTargetNoFilterAnnounce(286310, 2, nil, nil, nil, nil, nil, 7)
--Relics of Power
local warnVoidRelic						= mod:NewTargetNoFilterAnnounce(284684, 1)
local warnOceanRelic					= mod:NewTargetNoFilterAnnounce(284768, 1)
local warnStormRelic					= mod:NewTargetNoFilterAnnounce(284569, 1)
local warnFeedbackVoid					= mod:NewYouAnnounce(286459, 2)
local warnFeedbackOcean					= mod:NewYouAnnounce(286457, 2)
local warnFeedbackStorm					= mod:NewYouAnnounce(284569, 2)
local warnStormofAnnihilation			= mod:NewTargetAnnounce(284583, 2)
local warnUmbrelShield					= mod:NewTargetNoFilterAnnounce(284722, 2)
local warnUmbralShellOver				= mod:NewFadesAnnounce(284722, 2)
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
local yellUnstableResonanceRelic		= mod:NewPosYell("ej18970", DBM_CORE_AUTO_YELL_CUSTOM_POSITION2, nil, nil, "YELL")
--Stage One: His All-Seeing Eyes
local specWarnTouchoftheEnd				= mod:NewSpecialWarningYou(284851, nil, nil, nil, 1, 2)
local specWarnTouchoftheEndTaunt		= mod:NewSpecialWarningTaunt(284851, nil, nil, nil, 1, 6)
local specWarnPiercingGaze				= mod:NewSpecialWarningCount(285367, nil, nil, nil, 2, 2)
local specWarnMaddeningEyesCast			= mod:NewSpecialWarningDodgeCount(285345, nil, nil, nil, 2, 2)
local specWarnMaddeningEyes				= mod:NewSpecialWarningYou(285345, nil, nil, nil, 1, 2)
local yellMaddeningEyes					= mod:NewYell(285345)
local specWarnGiftofNzothObscurity		= mod:NewSpecialWarningDodgeCount(285453, nil, nil, nil, 2, 2)
local specWarnCallUndyingGuardian		= mod:NewSpecialWarningSwitchCount(285820, "-Healer", nil, nil, 1, 2)
--Stage Two: His Dutiful Servants
local specWarnGiftofNzothHysteria		= mod:NewSpecialWarningCount(285638, nil, nil, nil, 2, 2)
local specWarnConsumeEssence			= mod:NewSpecialWarningInterruptCount(285427, false, nil, nil, 1, 2)
local specWarnUnknowableTerror			= mod:NewSpecialWarningRun(285562, nil, nil, nil, 4, 2)
local specWarnPrimordialMindbender		= mod:NewSpecialWarningSwitch("ej19118", "Dps", nil, nil, 1, 2)
--Stage Three: His Unwavering Gaze
local specWarnInsatiableTorment			= mod:NewSpecialWarningYou(285652, nil, nil, nil, 1, 2)
local yellInsatiableTorment				= mod:NewShortYell(285652, 142942)--Short text "Torment"
local specWarnGiftofNzothLunacy			= mod:NewSpecialWarningCount(285685, nil, nil, nil, 2, 2)

--Relics of Power
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19055))
local timerStormofAnnihilation			= mod:NewTargetTimer(15, 284583, 196871, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--Short text "Storm"
local timerUnstableResonanceCD			= mod:NewCDCountTimer(40.8, 293653, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--40.8-45
local timerUnstableResonance			= mod:NewBuffFadesTimer(15, 293653, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)--inlineIcon, keep, countdown, countdownMax
--Stage One: His All-Seeing Eyes
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19104))
local timerTouchoftheEndCD				= mod:NewCDCountTimer(25, 284851, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--25, but heavily affected by spell queueing or some kind of ability overlap protection
local timerOblivionTearCD				= mod:NewCDCountTimer(12.1, 285185, nil, nil, nil, 3)--12.1 but often delayed by other casts
local timerVoidCrashCD					= mod:NewCDCountTimer(31, 285416, nil, nil, nil, 3)
--local timerEyesofNzothCD				= mod:NewCDCountTimer(32.7, 285376, nil, nil, nil, 3)--32.7-36.4 (probably spell queuing)
local timerPiercingGazeCD				= mod:NewCDCountTimer(32.7, 285367, nil, nil, nil, 3)
local timerMaddeningEyesCD				= mod:NewCDCountTimer(32.7, 285345, nil, nil, nil, 3)
local timerCallUndyingGuardianCD		= mod:NewCDCountTimer(46.1, 285820, 234890, nil, nil, 1)--Short text "Guardian"
local timerGiftofNzothObscurityCD		= mod:NewCDCountTimer(42.1, 285453, 285477, nil, nil, 2)--Short text "Obscurity"
--Stage Two: His Dutiful Servants
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19105))
local timerUnknowableTerrorCD			= mod:NewCDTimer(40.1, 285562, nil, nil, nil, 3)
local timerMindBenderCD					= mod:NewCDCountTimer(61.1, "ej19118", 284485, nil, nil, 1, 285427, DBM_CORE_DAMAGE_ICON)--Shorttext "Mindbender"
local timerGiftofNzothHysteriaCD		= mod:NewCDCountTimer(42.5, 285638, 55975, nil, nil, 2)--Short text "Hysteria"
--Stage Three: His Unwavering Gaze
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19106))
local timerInsatiableTormentCD			= mod:NewCDCountTimer(23.1, 285652, 142942, nil, nil, 3)--Short text "Torment"
local timerGiftofNzothLunacyCD			= mod:NewCDCountTimer(42.6, 285685, L.Lunacy, nil, nil, 2)--Manually translated because no spell to short text it

local berserkTimer						= mod:NewBerserkTimer(780)

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(10, 293653)
mod:AddInfoFrameOption(293653, true)
mod:AddNamePlateOption("NPAuraOnBond", 287693)
mod:AddNamePlateOption("NPAuraOnFeed", 285307)
mod:AddNamePlateOption("NPAuraOnRegen", 285333)
mod:AddSetIconOption("SetIconOnAdds", "ej19118", true, true, {1, 2, 4})
mod:AddSetIconOption("SetIconOnRelics", "ej18970", true, false, {1, 3, 5, 6, 7})--only up to 3 are used, but it depends on what user sets UnstableBehavior2 to. 1 and 7 are not included in the default used by DBM/BW (SetTwo)
mod:AddDropdownOption("UnstableBehavior2", {"SetOne", "SetTwo", "SetThree", "SetFour", "SetFive", "SetSix"}, "SetTwo", "misc")--SetTwo is BW default (BW default used to be SetOne)

mod.vb.phase = 1
mod.vb.touchCount = 0
mod.vb.resonCount = 0
mod.vb.tearCount = 0
mod.vb.voidCrashCount = 0
mod.vb.nzothEyesCount = 0
mod.vb.activeUndying = 0
mod.vb.undyingCount = 0
mod.vb.tormentCount = 0
mod.vb.resonCastCount = 0
mod.vb.addIcon = 1--1 fowards
mod.vb.mindBenderCount = 0
mod.vb.tridentOcean, mod.vb.tempestCaller, mod.vb.voidstone = "None", "None", "None"
mod.vb.tridentDrop, mod.vb.tempestDrop, mod.vb.voidDrop = nil, nil, nil
mod.vb.umbrelTarget = nil
mod.vb.tridentOceanicon, mod.vb.tempestStormIcon, mod.vb.voidIcon = 6, 5, 3
local trackedFeedback1, trackedFeedback2, trackedFeedback3 = false, false, false
local playerAffected = false
local playerName = UnitName("player")
local playerHasRelic = false
local unitTracked = {}
local castsPerGUID = {}

local updateInfoFrame
do
	local UnstableResonance, UmbrelShield = DBM:GetSpellInfo(293653), DBM:GetSpellInfo(284722)
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
		--Track Active Resonance Debuffs (Mythic)
		if mod.vb.resonCount > 0 then
			addLine(UnstableResonance, mod.vb.resonCount)
		end
		--Relics
		if mod.vb.tridentOcean ~= "None" then
			addLine(L.Ocean, mod.vb.tridentOcean)
		else--Show time since relic was dropped on ground
			if mod.vb.tridentDrop then
				addLine(L.Ocean, math.floor(GetTime()-mod.vb.tridentDrop))
			end
		end
		if mod.vb.tempestCaller ~= "None" then
			addLine(L.Storm, mod.vb.tempestCaller)
		else--Show time since relic was dropped on ground
			if mod.vb.tempestDrop then
				addLine(L.Storm, math.floor(GetTime()-mod.vb.tempestDrop))
			end
		end
		if mod.vb.voidstone ~= "None" then
			addLine(L.Void, mod.vb.voidstone)
		else--Show time since relic was dropped on ground
			if mod.vb.voidDrop then
				addLine(L.Void, math.floor(GetTime()-mod.vb.voidDrop))
			end
		end
		--Umbral Absorb Check (voidstone)
		if mod.vb.umbrelTarget then
			local uId = DBM:GetRaidUnitId(mod.vb.umbrelTarget)
			if uId then
				local absorbAmount = select(16, DBM:UnitDebuff(uId, 284722))
				if absorbAmount then
					addLine(UmbrelShield, math.floor(absorbAmount))
				end
			end
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
	--If player with relic, icons AND playername in red text
	if self.vb.resonCount > 0 and playerHasRelic then
		yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
		self:Schedule(2, updateResonanceYell, self, icon)
	--Not one of relics, just one of resonance targets, just double icons
	elseif playerAffected then
		yellUnstableResonanceSign:Yell(icon, "")
		self:Schedule(2, updateResonanceYell, self, icon)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.touchCount = 0
	self.vb.resonCount = 0
	self.vb.tearCount = 0
	self.vb.voidCrashCount = 0
	self.vb.nzothEyesCount = 0
	self.vb.activeUndying = 0
	self.vb.giftofNzothCount = 0
	self.vb.undyingCount = 0
	self.vb.tormentCount = 0
	self.vb.resonCastCount = 0
	self.vb.addIcon = 1
	self.vb.mindBenderCount = 0
	self.vb.tridentOcean, self.vb.tempestCaller, self.vb.voidstone = "None", "None", "None"
	self.vb.tridentDrop, self.vb.tempestDrop, self.vb.voidDrop = nil, nil, nil
	self.vb.umbrelTarget = nil
	trackedFeedback1, trackedFeedback2, trackedFeedback3 = false, false, false
	playerAffected = false
	playerHasRelic = false
	table.wipe(unitTracked)
	table.wipe(castsPerGUID)
	if self:IsHard() then
		timerVoidCrashCD:Start(6.1-delay, 1)
	end
	timerOblivionTearCD:Start(12.1-delay, 1)
	timerGiftofNzothObscurityCD:Start(20.6-delay, 1)
	timerTouchoftheEndCD:Start(26.5-delay, 1)
	timerCallUndyingGuardianCD:Start(30.3-delay, 1)
	--timerEyesofNzothCD:Start(40-delay, 1)
	timerPiercingGazeCD:Start(40-delay, 1)
	if self:IsMythic() then
		timerUnstableResonanceCD:Start(13.1-delay, 1)
		if self.Options.UnstableBehavior2 == "SetOne" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 5, 3--Square, Moon, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetOne") end
		elseif self.Options.UnstableBehavior2 == "SetTwo" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 6, 3--Moon, Square, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetTwo") end
		elseif self.Options.UnstableBehavior2 == "SetThree" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 1, 3--Moon, Star, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetThree") end
		elseif self.Options.UnstableBehavior2 == "SetFour" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 1, 3--Square, Star, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetFour") end
		elseif self.Options.UnstableBehavior2 == "SetFive" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 7, 3--Square, Cross, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetFive") end
		elseif self.Options.UnstableBehavior2 == "SetSix" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 7, 3--Moon, Cross, Diamond
			if UnitIsGroupLeader("player") then self:SendSync("SetSix") end
		end
	end
	berserkTimer:Start(self:IsMythic() and 540 or 780-delay)--780 verified on normal at least https://www.warcraftlogs.com/reports/rPQXVgaD6AnF4h2R#fight=8&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.name%20%3D%20%22Berserk%22
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(10, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnBond or self.Options.NPAuraOnFeed or self.Options.NPAuraOnRegen then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnTimerRecovery()
	if self.vb.tridentOcean == playerName then
		playerHasRelic = L.Ocean
	elseif self.vb.tempestCaller == playerName then
		playerHasRelic = L.Storm
	elseif self.vb.voidstone == playerName then
		playerHasRelic = L.Void
	end
	if playerHasRelic and self.vb.resonCount > 0 then
		local icon = self.vb.tridentOcean == playerName and self.vb.tridentOceanicon or self.vb.tempestCaller == playerName and self.vb.tempestStormIcon or self.vb.voidstone == playerName and self.vb.voidIcon
		yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
		self:Unschedule(updateResonanceYell)
		self:Schedule(2, updateResonanceYell, self, icon)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnBond or self.Options.NPAuraOnFeed or self.Options.NPAuraOnRegen then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 293653 then
		self.vb.resonCastCount = self.vb.resonCastCount + 1
		specWarnUnstableResonance:Show(self.vb.resonCastCount)
		specWarnUnstableResonance:Play("scatter")
		timerUnstableResonanceCD:Start(nil, self.vb.resonCastCount+1)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		--Update some Timers
		local tearElapsed, tearTotal = timerOblivionTearCD:GetTime(self.vb.tearCount+1)
		local tearExtend = 21.2 - (tearTotal-tearElapsed)
		DBM:Debug("timerOblivionTearCD extended by: "..tearExtend, 2)
		timerOblivionTearCD:Update(tearElapsed, tearTotal+tearExtend, self.vb.tearCount+1)
		if self.vb.phase == 1 then
			--Query correct timer
			if self.vb.nzothEyesCount % 2 == 0 then--Last eyes cast was maddening, next is piercing
				local eyesElapsed, eyesTotal = timerPiercingGazeCD:GetTime(self.vb.nzothEyesCount+1)
				local eyesExtend = 19.4 - (eyesTotal-eyesElapsed)
				DBM:Debug("timerPiercingGazeCD extended by: "..eyesExtend, 2)
				timerPiercingGazeCD:Update(eyesElapsed, eyesTotal+eyesExtend, self.vb.nzothEyesCount+1)
			else--Last eyes cast was piercing, next is maddening
				local eyesElapsed, eyesTotal = timerMaddeningEyesCD:GetTime(self.vb.nzothEyesCount+1)
				local eyesExtend = 19.4 - (eyesTotal-eyesElapsed)
				DBM:Debug("timerMaddeningEyesCD extended by: "..eyesExtend, 2)
				timerMaddeningEyesCD:Update(eyesElapsed, eyesTotal+eyesExtend, self.vb.nzothEyesCount+1)
			end
		end
	elseif spellId == 285185 then
		self.vb.tearCount = self.vb.tearCount + 1
		warnOblivionTear:Show(self.vb.tearCount)
		timerOblivionTearCD:Start(self.vb.phase == 3 and 12.1 or 16.1, self.vb.tearCount+1)
	elseif spellId == 285416 then
		self.vb.voidCrashCount = self.vb.voidCrashCount + 1
		warnVoidCrash:Show(self.vb.voidCrashCount)
		timerVoidCrashCD:Start(nil, self.vb.voidCrashCount+1)
	elseif spellId == 285376 then--Eyes of N'zoth (trigger for both spells below)
		self.vb.nzothEyesCount = self.vb.nzothEyesCount + 1
		--timerEyesofNzothCD:Start(32.7, self.vb.nzothEyesCount+1)
		--If stage 3, or an even cast in phase 1, next is piercing
		if self.vb.phase == 1 then
			if self.vb.nzothEyesCount % 2 == 0 then
				specWarnMaddeningEyesCast:Show(self.vb.nzothEyesCount)
				specWarnMaddeningEyesCast:Play("farfromline")
				timerPiercingGazeCD:Start(32.7, self.vb.nzothEyesCount+1)
				--Trigger the 10 second Undying 2 delay since Eyes 2 was first (no longer happens on mythic)
				if not self:IsMythic() and ((self.vb.undyingCount < 2) and (self.vb.nzothEyesCount == 2)) then
					timerCallUndyingGuardianCD:Stop()
					timerCallUndyingGuardianCD:Start(9.6, 2)
				end
			else
				specWarnPiercingGaze:Show(self.vb.nzothEyesCount)
				specWarnPiercingGaze:Play("specialsoon")--don't have anything better really
				timerMaddeningEyesCD:Start(32.7, self.vb.nzothEyesCount+1)
			end
		else--Phase 3 and all we get is piercing
			specWarnPiercingGaze:Show(self.vb.nzothEyesCount)
			specWarnPiercingGaze:Play("specialsoon")--don't have anything better really
			timerPiercingGazeCD:Start(self:IsMythic() and 40 or 47.5, self.vb.nzothEyesCount+1)
		end
	--elseif spellId == 285345 and self:AntiSpam(3, 1) then
		--specWarnMaddeningEyesCast:Show()
		--specWarnMaddeningEyesCast:Play("farfromline")
	elseif spellId == 285453 then
		self.vb.giftofNzothCount = self.vb.giftofNzothCount + 1
		specWarnGiftofNzothObscurity:Show(self.vb.giftofNzothCount)
		specWarnGiftofNzothObscurity:Play("watchstep")
		timerGiftofNzothObscurityCD:Start(nil, self.vb.giftofNzothCount+1)
	elseif spellId == 285820 then
		--Not a tank, or you are a tank and affected by Touch of the end (the tank that needs to deal with mob)
		self.vb.undyingCount = self.vb.undyingCount + 1
		if not self:IsTank() or DBM:UnitDebuff("player", 284851) then
			specWarnCallUndyingGuardian:Show(self.vb.undyingCount)
			specWarnCallUndyingGuardian:Play("bigmob")
		end
		timerCallUndyingGuardianCD:Start(self.vb.phase == 3 and 31.5 or 46.1, self.vb.undyingCount+1)
		--Trigger the 10 second eyes 2 delay since Undying 2 was first (no longer happens on mythic)
		if not self:IsMythic() and ((self.vb.phase == 1) and (self.vb.undyingCount == 2) and (self.vb.nzothEyesCount < 2)) then
			timerMaddeningEyesCD:Stop()
			timerMaddeningEyesCD:Start(9.6, 2)
		end
	elseif spellId == 285638 then
		self.vb.giftofNzothCount = self.vb.giftofNzothCount + 1
		specWarnGiftofNzothHysteria:Show(self.vb.giftofNzothCount)
		specWarnGiftofNzothHysteria:Play("aesoon")
		timerGiftofNzothHysteriaCD:Start(40.5, self.vb.giftofNzothCount+1)
	elseif spellId == 285562 and self:AntiSpam(8, 2) then
		specWarnUnknowableTerror:Show()
		specWarnUnknowableTerror:Play("fearsoon")
		specWarnUnknowableTerror:ScheduleVoice(1.5, "justrun")
		timerUnknowableTerrorCD:Start()
	elseif spellId == 285685 then
		self.vb.giftofNzothCount = self.vb.giftofNzothCount + 1
		specWarnGiftofNzothLunacy:Show(self.vb.giftofNzothCount)
		specWarnGiftofNzothLunacy:Play("stopattack")--Right voice?
		timerGiftofNzothLunacyCD:Start(nil, self.vb.giftofNzothCount+1)
	elseif spellId == 285427 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			--Increment icon for next cast/seticon
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon == 5 then--1, 2, 4
				self.vb.addIcon = 1--Reset to 1 if its 5
			elseif self.vb.addIcon == 3 then
				self.vb.addIcon = 4--Skip 3 and go to 4 if it's 3
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 284851 then
		self.vb.touchCount = self.vb.touchCount + 1
		timerTouchoftheEndCD:Start(nil, self.vb.touchCount+1)
	elseif spellId == 285652 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		local players = DBM:GetGroupSize() or 30--If for SOME reason GetGroupSize fails, we'll use lowest possible CD
		local timer = self:IsMythic() and 45 or 600/players
		timerInsatiableTormentCD:Start(timer, self.vb.tormentCount+1)
	elseif spellId == 293653 then--Unstable Resonance
		if self.Options.SetIconOnRelics then--Slghtly redundant, but in off chance they enabled an incompatible icon option such as torment icons, we want to reset icons to relics here
			self:SetIcon(self.vb.tridentOcean, self.vb.tridentOceanicon)
			self:SetIcon(self.vb.tempestCaller, self.vb.tempestStormIcon)
			self:SetIcon(self.vb.voidstone, self.vb.voidIcon)
		end
		if playerHasRelic then
			local icon = self.vb.tridentOcean == playerName and self.vb.tridentOceanicon or self.vb.tempestCaller == playerName and self.vb.tempestStormIcon or self.vb.voidstone == playerName and self.vb.voidIcon
			yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
			self:Unschedule(updateResonanceYell)
			self:Schedule(2, updateResonanceYell, self, icon)
		end
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
				specWarnUnstableResonanceVoid:Show(self:IconNumToTexture(self.vb.voidIcon))
				specWarnUnstableResonanceVoid:Play("mm"..self.vb.voidIcon)
				yellUnstableResonanceSign:Yell(self.vb.voidIcon, "")
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, self.vb.voidIcon)
				timerUnstableResonance:Start()
				playerAffected = true
			end
		elseif spellId == 293662 then--Ocean
			if args:IsPlayer() then
				specWarnUnstableResonanceOcean:Show(self:IconNumToTexture(self.vb.tridentOceanicon))
				specWarnUnstableResonanceOcean:Play("mm"..self.vb.tridentOceanicon)
				yellUnstableResonanceSign:Yell(self.vb.tridentOceanicon, "")
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, self.vb.tridentOceanicon)
				timerUnstableResonance:Start()
				playerAffected = true
			end
		elseif spellId == 293661 then--Storm
			if args:IsPlayer() then
				specWarnUnstableResonanceStorm:Show(self:IconNumToTexture(self.vb.tempestStormIcon))
				specWarnUnstableResonanceStorm:Play("mm"..self.vb.tempestStormIcon)
				yellUnstableResonanceSign:Yell(self.vb.tempestStormIcon, "")
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, self.vb.tempestStormIcon)
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
	elseif spellId == 286310 then--Void Shield
		warnVoidShield:Show(args.destName)
		warnVoidShield:Play("phasechange")
		timerVoidCrashCD:Stop()
		timerOblivionTearCD:Stop()
		timerTouchoftheEndCD:Stop()
		timerGiftofNzothObscurityCD:Stop()
		timerCallUndyingGuardianCD:Stop()
		--timerEyesofNzothCD:Stop()
		timerPiercingGazeCD:Stop()
		timerMaddeningEyesCD:Stop()
		timerGiftofNzothHysteriaCD:Stop()
		timerUnknowableTerrorCD:Stop()
		timerInsatiableTormentCD:Stop()
		timerGiftofNzothLunacyCD:Stop()
		timerMindBenderCD:Stop()
		timerUnstableResonanceCD:Stop()
	elseif spellId == 284768 then--Trident
		self.vb.tridentOcean = args.destName
		warnOceanRelic:Show(args.destName)
		local icon = self.vb.tridentOceanicon
		if args:IsPlayer() then
			playerHasRelic = L.Ocean
			if self.vb.resonCount > 0 then--Looted relic after resonance went out, update scheduler
				yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, icon)
			end
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 284569 then--Tempest
		self.vb.tempestCaller = args.destName
		warnStormRelic:Show(args.destName)
		local icon = self.vb.tempestStormIcon
		if args:IsPlayer() then
			playerHasRelic = L.Storm
			if self.vb.resonCount > 0 then--Looted relic after resonance went out, update scheduler
				yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, icon)
			end
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 284684 then--Void
		self.vb.voidstone = args.destName
		warnVoidRelic:Show(args.destName)
		local icon = self.vb.voidIcon
		if args:IsPlayer() then
			playerHasRelic = L.Void
			if self.vb.resonCount > 0 then--Looted relic after resonance went out, update scheduler
				yellUnstableResonanceRelic:Yell(icon, playerHasRelic, icon)
				self:Unschedule(updateResonanceYell)
				self:Schedule(2, updateResonanceYell, self, icon)
			end
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, self.vb.voidIcon)
		end
	elseif spellId == 284722 then--Umbrel
		self.vb.umbrelTarget = args.destName
		warnUmbrelShield:Show(args.destName)
	end
end

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
	elseif spellId == 286310 and self:IsInCombat() then--Void Shield
		self.vb.phase = self.vb.phase + 1
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		self.vb.tearCount = 0--Maybe not reset?
		self.vb.touchCount = 0--Maybe not reset?
		self.vb.giftofNzothCount = 0--Always reset
		self.vb.undyingCount = 0--Maybe not reset?
		self.vb.tormentCount = 0--Maybe not reset?
		if self.vb.phase == 2 then
			timerVoidCrashCD:Stop()
			timerOblivionTearCD:Start(13.3, 1)
			timerUnknowableTerrorCD:Start(18.2)
			timerTouchoftheEndCD:Start(21.8, 1)
			timerCallUndyingGuardianCD:Start(31.5, 1)
			timerMindBenderCD:Start(34, 1)
			timerGiftofNzothHysteriaCD:Start(40.1, 1)
			if self:IsMythic() then
				timerUnstableResonanceCD:Start(33.5, self.vb.resonCastCount+1)
			end
		elseif self.vb.phase == 3 then
			self.vb.nzothEyesCount = 0--Only reset on 3 because doesn't exist in 2
			timerInsatiableTormentCD:Start(12.1, 1)
			timerOblivionTearCD:Start(13.3, 1)
			timerTouchoftheEndCD:Start(21.9, 1)
			timerCallUndyingGuardianCD:Start(26.7, 1)
			timerGiftofNzothLunacyCD:Start(40.1, 1)
			if self:IsMythic() then
				timerUnstableResonanceCD:Start(33.5, self.vb.resonCastCount+1)
				timerPiercingGazeCD:Start(62.5, 1)
			else
				timerPiercingGazeCD:Start(42.6, 1)
			end
		end
	elseif spellId == 284768 then--Trident
		self.vb.tridentOcean = "None"
		self.vb.tridentDrop = GetTime()
		if args:IsPlayer() then
			playerHasRelic = false
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 284569 then--Tempest
		self.vb.tempestCaller = "None"
		self.vb.tempestDrop = GetTime()
		if args:IsPlayer() then
			playerHasRelic = false
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 284684 then--Void
		self.vb.voidstone = "None"
		self.vb.voidDrop = GetTime()
		if args:IsPlayer() then
			playerHasRelic = false
		end
		if self.Options.SetIconOnRelics then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 284722 then--Umbrel
		self.vb.umbrelTarget = nil
		warnUmbralShellOver:Show()
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
	end
end

do
	--Delayed function just to make absolute sure RL sync overrides user settings after OnCombatStart functions run
	local function UpdateYellIcons(self, msg)
		if msg == "SetOne" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 5, 3--Square, Moon, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		elseif msg == "SetTwo" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 6, 3--Moon, Square, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		elseif msg == "SetThree" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 1, 3--Moon, Star, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		elseif msg == "SetFour" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 1, 3--Square, Star, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		elseif msg == "SetFive" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 6, 7, 3--Square, Cross, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		elseif msg == "SetSix" then
			self.vb.tridentOceanicon, self.vb.tempestStormIcon, self.vb.voidIcon = 5, 7, 3--Moon, Cross, Diamond
			DBM:AddMsg(L.DBMConfigMsg:format(msg))
		end
	end
	function mod:OnSync(msg)
		if not self:IsMythic() then return end--Just in case some shit lord sends syncs in LFR or something, we don't want to trigger DBMConfigMsg
		self:Schedule(3, UpdateYellIcons, self, msg)
	end
end
