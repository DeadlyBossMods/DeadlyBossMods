local mod	= DBM:NewMod(1726, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103769)
mod:SetEncounterID(1864)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 207830 209443 208322 206653 210264 209034 205588",
	"SPELL_CAST_SUCCESS 206651 209158 209034",
	"SPELL_SUMMON 210264",
	"SPELL_AURA_APPLIED 208431 206651 205771 209158 211802 209034 210451",
	"SPELL_AURA_APPLIED_DOSE 206651 209158",
	"SPELL_AURA_REMOVED 208431 211802 206651 209158 209034 210451",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, across the board detect who doesn't gain corruption and assign them to tasks like meteor soaking, taunting boss, being nearest target to adds, etc
--TODO, infoframe for remaining tainted discharge maybe? Has to be combined with alt power infoframe
--TODO, figure out tank swaps, important spell alerts, etc.
--Nightmare Corruption
local warnDescentIntoMadness			= mod:NewTargetAnnounce(208431, 4)
--Stage One: The Decent Into Madness
local warnDarkeningSoul					= mod:NewStackAnnounce(206651, 3, nil, "Healer|Tank")
local warnTormentingFixation			= mod:NewTargetAnnounce(205771, 4)
--Stage Two: From the Shadows
local warnBlackeningSoul				= mod:NewStackAnnounce(209158, 3, nil, "Healer|Tank")
local warnNightmareInfusion				= mod:NewSpellAnnounce(209443, 3, nil, "Tank")
local warnBondsOfTerror					= mod:NewTargetAnnounce(209034, 2)
--Stage Three: Darkness and stuff
local warnNightmareTentacles			= mod:NewSpellAnnounce("ej12977", 3, 93708)

local specWarnDescentIntoMadness		= mod:NewSpecialWarningYou(208431)
local yellDescentIntoMadness			= mod:NewFadesYell(208431)
--Stage One: The Decent Into Madness
local specWarnNightmareBlades			= mod:NewSpecialWarningMoveAway(206656, nil, nil, nil, 1, 2)
local specWarnCorruptionHorror			= mod:NewSpecialWarningSwitch("ej12973", "-Healer", nil, nil, 1, 2)
local specWarnCorruptingNova			= mod:NewSpecialWarningSpell(207830, nil, nil, nil, 2, 2)
--local specWarnDarkeningSoul				= mod:NewSpecialWarningDispel(206651, "Healer", nil, nil, 1, 2)
local specWarnTormentingFixation		= mod:NewSpecialWarningMoveAway(205771, nil, nil, nil, 1, 2)
--Stage Two: From the Shadows
local specWarnBondsOfTerror				= mod:NewSpecialWarningMoveTo(209034, nil, nil, nil, 1, 2)
local specWarnCorruptionMeteorAway		= mod:NewSpecialWarningDodge(206308, "-Tank", nil, nil, 2, 2)
local specWarnCorruptionMeteorTo		= mod:NewSpecialWarningMoveTo(206308, "-Tank", nil, nil, 1, 2)
--local specWarnBlackeningSoul			= mod:NewSpecialWarningDispel(209158, "Healer", nil, nil, 1, 2)
local specWarnInconHorror				= mod:NewSpecialWarningSwitch("ej13162", "-Healer", nil, nil, 1, 2)

--Stage One: The Decent Into Madness
local timerDarkeningSoulCD				= mod:NewCDTimer(6.1, 206651, nil, "Healer|Tank", nil, 5, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_TANK_ICON)
local timerNightmareBladesCD			= mod:NewNextTimer(15.7, 206656, nil, nil, nil, 3)
local timerLurkingEruptionCD			= mod:NewNextCountTimer(15.7, 208322, nil, nil, nil, 3)
local timerCorruptionHorrorCD			= mod:NewNextTimer(61.7, 210264, nil, nil, nil, 1)
local timerCorruptingNovaCD				= mod:NewNextTimer(20, 207830, nil, nil, nil, 2)
--Stage Two: From the Shadows
local timerBondsOfTerrorCD				= mod:NewCDTimer(14.6, 209034, nil, nil, nil, 3)
local timerCorruptionMeteorCD			= mod:NewNextTimer(31.5, 206308, nil, nil, nil, 3)
local timerBlackeningSoulCD				= mod:NewCDTimer(6.1, 209158, nil, "Healer|Tank", nil, 5, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_TANK_ICON)
local timerNightmareInfusionCD			= mod:NewCDTimer(61.5, 209443, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--61.5-62.5
local timerCallOfNightmaresCD			= mod:NewCDTimer(83, 205588, nil, nil, nil, 1)
--Stage Three: Darkness and stuff
local timerNightmareTentacleCD			= mod:NewCDTimer(21, "ej12977", nil, nil, nil, 1, 93708)


--Stage One: The Decent Into Madness
--local countdownMagicFire				= mod:NewCountdownFades(11.5, 162185)

local voicePhaseChange					= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
--Nightmare Corruption
--local voiceDescentIntoMadness			= mod:NewVoice(208431)
--Stage One: The Decent Into Madness
local voiceNightmareBlades				= mod:NewVoice(206656)--runout
local voiceCorruptionHorror				= mod:NewVoice("ej12973", "-Healer")--bigmob
local voiceCorruptingNova				= mod:NewVoice(207830, "HasInterrupt")--kickcast
--local voiceDarkeningSoul				= mod:NewVoice(206651, "Healer")--helpdispel
local voiceTormentingFixation			= mod:NewVoice(205771)--targetyou (iffy, is there no voice that says fixate, run?)
--Stage Two: From the Shadows
local voiceBondsOfTerror				= mod:NewVoice(209034)--linegather
local voiceCorruptionMeteor				= mod:NewVoice(206308)--gathershare/watchstep
--local voiceBlackeningSoul				= mod:NewVoice(209158, "Healer")--helpdispel
local voiceInconHorror					= mod:NewVoice("ej13162", "-Healer")--killmob

mod:AddInfoFrameOption("ej12970")
mod:AddRangeFrameOption(6, 208322)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnBlades", 211802)
mod:AddHudMapOption("HudMapOnBonds", 209034)

local lurkingTimers = {13.6, 26.3, 47.4, 20.7, 25.9}
local corruptionName = EJ_GetSectionInfo(12970)
local darkSoul, blackSoul = GetSpellInfo(206651), GetSpellInfo(209158)
local dreamSimulacrum = GetSpellInfo(206005)
local bladesTarget = {}
local playerName = UnitName("player")
local UnitDebuff = UnitDebuff
mod.vb.phase = 1
mod.vb.lurkingCount = 0
mod.vb.lastBonds = nil

local function isPlayerImmune()
	if UnitBuff("player", dreamSimulacrum) or UnitDebuff("player", dreamSimulacrum) then
		return true
	end
	return false
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", darkSoul) then
		DBM.RangeCheck:Show(32)
	elseif UnitDebuff("player", blackSoul) then
		DBM.RangeCheck:Show(10)--10 for tainted discharge?
	elseif self.vb.phase == 1 then
		DBM.RangeCheck:Show(6)
	else
		DBM.RangeCheck:Hide()
	end
end

local function bladesHUD(self)
	local previousTarget = nil
	for i = 1, #bladesTarget do
		local name = bladesTarget[i]
		DBMHudMap:RegisterRangeMarkerOnPartyMember(211802, "party", name, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(name, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		if previousTarget then
			--Combat log targets are backwards, who's targeted first is person who's hit last, at least with two targets and based on videos
			if playerName == previousTarget or playerName == name then--Player yellow lines
				DBMHudMap:AddEdge(1, 1, 0, 0.5, 6, name, previousTarget, nil, nil, nil, nil, 135)
			else--red lines
				DBMHudMap:AddEdge(1, 0, 0, 0.5, 6, name, previousTarget, nil, nil, nil, nil, 135)
			end
		end
		previousTarget = name
	end
	table.wipe(bladesTarget)--TODO, if this doesn't work well, move it to a new event
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.lurkingCount = 0
	self.vb.lastBonds = nil
	table.wipe(bladesTarget)
	timerDarkeningSoulCD:Start(-delay)
	timerLurkingEruptionCD:Start(13.6-delay)
	timerNightmareBladesCD:Start(18.5-delay)
	timerCorruptionHorrorCD:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(corruptionName)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBlades or self.Options.HudMapOnBonds then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 207830 then
		timerCorruptingNovaCD:Start(nil, args.sourceGUID)
		specWarnCorruptingNova:Show(args.sourceName)
		voiceCorruptingNova:Play("aesoon")
	elseif spellId == 209443 then
		warnNightmareInfusion:Show()
		timerNightmareInfusionCD:Start()
	elseif spellId == 208322 then--Lurking Eruption
		self.vb.lurkingCount = self.vb.lurkingCount + 1
		local timers = lurkingTimers[self.vb.lurkingCount+1]
		if timers then
			timerLurkingEruptionCD:Start(timers, self.vb.lurkingCount+1)
		end
	elseif spellId == 206653 then--Nightmare Blades (only version that has cast time
		timerNightmareBladesCD:Start()
	elseif spellId == 210264 then
		specWarnCorruptionHorror:Show()
		voiceCorruptionHorror:Play("bigadd")
	elseif spellId == 209034 then
		--reset here, for good measure, in case success fires after applied
		self.vb.lastBonds = nil
	elseif spellId == 205588 then
		specWarnInconHorror:Show()
		voiceInconHorror:Play("killmob")
		timerCallOfNightmaresCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206651 then
		timerDarkeningSoulCD:Start()
	elseif spellId == 209158 then
		timerBlackeningSoulCD:Start()
		if self.vb.phase == 1 then
			--Boss lacks a true phase change trigger, this is only real way of detecting it.
			--Fortunately this is a pretty accurate way of doing it, it seems. Boss syncronizes his timers to this point
			self.vb.phase = 2
			voicePhaseChange:Play("ptwo")
			timerNightmareBladesCD:Stop()
			timerLurkingEruptionCD:Stop()
			timerCorruptionHorrorCD:Stop()
			timerBondsOfTerrorCD:Start(9)--SUCCESS
			timerCorruptionMeteorCD:Start(17.5)
			timerNightmareInfusionCD:Start(24.3)
			timerCallOfNightmaresCD:Start(49)
			updateRangeFrame(self)
		end
	elseif spellId == 209034 then
		timerBondsOfTerrorCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 210264 then
		timerCorruptingNovaCD:Start(16.5, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 208431 then
		warnDescentIntoMadness:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnDescentIntoMadness:Show()
			yellDescentIntoMadness:Schedule(19, 1)
			yellDescentIntoMadness:Schedule(18, 2)
			yellDescentIntoMadness:Schedule(17, 3)
		end
	elseif spellId == 206651 then
		local amount = args.amount or 1
		warnDarkeningSoul:Show(args.destName, amount)
		--[[if isPlayerImmune() then
			specWarnDarkeningSoul:Show(args.destName)
			voiceDarkeningSoul:Play("helpdispel")
		end--]]
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 209158 then
		local amount = args.amount or 1
		warnBlackeningSoul:Show(args.destName, amount)
		--[[if isPlayerImmune() then
			specWarnBlackeningSoul:Show(args.destName)
			voiceBlackeningSoul:Play("helpdispel")
		end--]]
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 205771 then
		if args:IsPlayer() then
			specWarnTormentingFixation:Show()
			voiceTormentingFixation:Play("targetyou")
		else
			warnTormentingFixation:Show(args.destName)
		end
	elseif spellId == 211802 then
		if self.Options.HudMapOnBlades then
			self:Unschedule(bladesHUD)
			if not tContains(bladesTarget, args.destName) then
				bladesTarget[#bladesTarget+1] = args.destName
			end
			if #bladesTarget == 2 and self:IsHeroic() then--Know it's 2 on heroic, mythic is unknown to fallback scheduling below
				bladesHUD(self)
			else
				self:Schedule(1, bladesHUD, self)
			end
		end
		if args:IsPlayer() then
			specWarnNightmareBlades:Show()
			voiceNightmareBlades:Play("runout")
		end
	elseif spellId == 209034 or spellId == 210451 then
		warnBondsOfTerror:CombinedShow(0.5, args.destName)
		if spellId == 209031 then
		 	self.vb.lastBonds = args.destName
		else
		 	if args:IsPlayer() then
		 		specWarnBondsOfTerror:Show(self.vb.lastBonds)
		 		voiceBondsOfTerror:Play("linegather")
		 		if self.Options.HudMapOnBonds then
		 			DBMHudMap:RegisterRangeMarkerOnPartyMember(209034, "party", self.vb.lastBonds, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(self.vb.lastBonds, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		 			DBMHudMap:AddEdge(0, 1, 0, 0.5, 6, playerName, self.vb.lastBonds, nil, nil, nil, nil, 135)
		 		end
		 	elseif self.vb.lastBonds == playerName then
		 		specWarnBondsOfTerror:Show(args.destName)
		 		voiceBondsOfTerror:Play("linegather")
		 		if self.Options.HudMapOnBonds then
		 			DBMHudMap:RegisterRangeMarkerOnPartyMember(209034, "party", args.destName, 0.65, 6, nil, nil, nil, 0.8, nil, false):Appear():SetLabel(args.destName, nil, nil, nil, nil, nil, 0.8, nil, -15, 8, nil)
		 			DBMHudMap:AddEdge(0, 1, 0, 0.5, 6, playerName, args.destName, nil, nil, nil, nil, 135)
		 		end
		 	end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 208431 and args:IsPlayer() then
		yellDescentIntoMadness:Cancel()
	elseif spellId == 211802 then
		if self.Options.HudMapOnBlades then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 206651 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 209158 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 209034 or spellId == 210451 then
		if self.Options.HudMapOnBonds then
			DBMHudMap:FreeEncounterMarkerByTarget(209034, args.destName)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then--Corruption Horror
		timerCorruptingNovaCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 205843 then--The Dreaming
		--UNUSED
	elseif spellId == 206341 then--Corruption Meteor (not in combat log at all, targetting or even casting)
		if isPlayerImmune() then
			specWarnCorruptionMeteorTo:Show(TARGET)
			voiceCorruptionMeteor:Play("gathershare")
		else
			specWarnCorruptionMeteorAway:Show()
			voiceCorruptionMeteor:Play("watchstep")
		end
		timerCorruptionMeteorCD:Start()
	elseif spellId == 209464 and self:AntiSpam(5, 1) then--Spawn Tentacles
		warnNightmareTentacles:Show()
		timerNightmareTentacleCD:Start()
		if self.vb.phase < 3 then
			--Boss summons first set of these instantly at 30%. phase 3
			self.vb.phase = 3
			voicePhaseChange:Play("pthree")
			timerBondsOfTerrorCD:Stop()
			timerCallOfNightmaresCD:Stop()
			--These timers aren't SUPPOSED to cancel but they did during testing, this needs review.
			timerCorruptionMeteorCD:Stop()
			timerNightmareInfusionCD:Stop()
			--And this one is supposed to return, but didn't.
			--timerNightmareBladesCD:Start()
		end
	end
end
