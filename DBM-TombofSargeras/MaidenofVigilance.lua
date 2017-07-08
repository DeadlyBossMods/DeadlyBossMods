local mod	= DBM:NewMod(1897, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118289)
mod:SetEncounterID(2052)
mod:SetZone()
mod:SetUsedIcons(4, 1)
mod:SetHotfixNoticeRev(16285)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235271 241635 241636 235267",
	"SPELL_CAST_SUCCESS 239153 237722",
	"SPELL_AURA_APPLIED 235240 235213 235117 240209 235028 236061 234891",
	"SPELL_AURA_REFRESH 235240 235213",
	"SPELL_AURA_REMOVED 235117 240209 235028 234891",
	"SPELL_PERIODIC_DAMAGE 238408 238028",
	"SPELL_PERIODIC_MISSED 238408 238028",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: range frame? seems impractical at moment, if someone shows up range frame it's already too late.
--TODO, new voices, "Fel infusion" and "Light Infusion" and "Jump In Pit"
--TODO, Better taunting system for hammers. I suspect a two camp strat with tank in appropriate camp taunting during hammer cast
--TODO, some kind of shield health tracker
--TODO, wrath of the creators stack counter for when stacks too high and about to wipe
--TODO, Mass instability is in combat log now, but not enough data to fix timers for it yet (except for first on pull)
--TODO, some kind of relevant warning for Spont Fragmentation
--[[
(ability.id = 235267 or ability.id = 235271 or ability.id = 241635 or ability.id = 241636) and type = "begincast" or
(ability.id = 239153 or ability.id = 237722) and type = "cast" or
(ability.id = 235028 or ability.id = 234891) and (type = "applybuff" or type = "removebuff")
--]]
--Stage One
local warnUnstableSoul				= mod:NewTargetAnnounce(235117, 4, nil, false)--Might be spammy so off by default. Infoframe will do better job with this one
local warnMassShit					= mod:NewCountAnnounce(235267, 2)
--Stage Two
local warnEssenceFragments			= mod:NewSpellAnnounce(236061, 2)

--Stage One: Divide and Conquer
local specWarnInfusion				= mod:NewSpecialWarningSpell(235271, nil, nil, nil, 2, 2)
local specWarnFelInfusion			= mod:NewSpecialWarningYou(235240, nil, nil, nil, 1, 7)
local specWarnLightInfusion			= mod:NewSpecialWarningYou(235213, nil, nil, nil, 1, 7)
local specWarnUnstableSoul			= mod:NewSpecialWarningMoveTo(235117, nil, nil, nil, 3, 7)
local yellUnstableSoul				= mod:NewShortFadesYell(235117)--While learning the fight this will be spammy, but also nessesary
local specWarnLightHammer			= mod:NewSpecialWarningCount(241635, nil, nil, nil, 2, 2)
local specWarnFelhammer				= mod:NewSpecialWarningCount(241636, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two
local specWarnWrathofCreators		= mod:NewSpecialWarningInterrupt(234891, "HasInterrupt", nil, nil, 1, 2)

--Stage One: Divide and Conquer
local timerInfusionCD				= mod:NewNextCountTimer(37.9, 235271, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerLightHammerCD			= mod:NewNextCountTimer(18, 241635, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFelHammerCD				= mod:NewNextCountTimer(18, 241636, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerMassInstabilityCD		= mod:NewNextCountTimer(31, 235267, nil, nil, nil, 3)
local timerBlowbackCD				= mod:NewNextTimer(81.1, 237722, nil, nil, nil, 6)--81-82
--Mythic
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerSpontFragmentationCD		= mod:NewCDTimer(8, 239153, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer					= mod:NewBerserkTimer(480)

--Stage One: Divide and Conquer
local countdownInfusion				= mod:NewCountdown("AltTwo", 235271)
local countdownLightHammer			= mod:NewCountdown(18, 241635)
local countdownFelHammer			= mod:NewCountdown("Alt18", 241636)

--Stage One: Divide and Conquer
local voiceInfusion					= mod:NewVoice(235271)--scatter
local voiceFelInfusion				= mod:NewVoice(235240)--felinfusion
local voiceLightInfusion			= mod:NewVoice(235213)--lightinfusion
local voiceUnsableSoul				= mod:NewVoice(235117)--jumpinpit
local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Stage Two
local voiceWrathofCreators			= mod:NewVoice(234891, "HasInterrupt")--kickcast

mod:AddSetIconOption("SetIconOnInfusion", 235271, true)
mod:AddInfoFrameOption(235117, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.unstableSoulCount = 0
mod.vb.hammerCount = 0
mod.vb.infusionCount = 0
mod.vb.spontFragmentationCount = 0
mod.vb.massShitCount = 0
mod.vb.shieldActive = false
local AegynnsWard = GetSpellInfo(236420)
local felDebuff, lightDebuff = GetSpellInfo(235240), GetSpellInfo(235213)

function mod:OnCombatStart(delay)
	self.vb.shieldActive = false
	self.vb.unstableSoulCount = 0
	self.vb.hammerCount = 2
	self.vb.infusionCount = 1
	self.vb.massShitCount = 1
	timerInfusionCD:Start(2-delay, 2)
	timerLightHammerCD:Start(12-delay, 3)--12-14
	countdownLightHammer:Start(12-delay)
	timerMassInstabilityCD:Start(22-delay, 2)
	timerBlowbackCD:Start(40.9-delay)
	if self:IsMythic() then
		self.vb.spontFragmentationCount = 0
		timerSpontFragmentationCD:Start(10-delay)
	end
	berserkTimer:Start(480-delay)--Heroic/normal confirmed, others assumed until seen
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235271 then
		specWarnInfusion:Show()
		voiceInfusion:Play("scatter")
		if self.vb.infusionCount == 1 then
			timerInfusionCD:Start(38, 2)
			countdownInfusion:Start(38)
		end
	elseif spellId == 241635 then--Light Hammer
		self.vb.hammerCount = self.vb.hammerCount + 1
		specWarnLightHammer:Show(self.vb.hammerCount)
		if self.vb.hammerCount < 4 then
			timerFelHammerCD:Start(18, self.vb.hammerCount+1)--20 on Mythic, 18 on LFR?
			countdownFelHammer:Start(18)
		end
	elseif spellId == 241636 then--Fel Hammer
		self.vb.hammerCount = self.vb.hammerCount + 1
		specWarnFelhammer:Show(self.vb.hammerCount)
		if self.vb.hammerCount == 2 then
			timerLightHammerCD:Start(18, 3)
			countdownLightHammer:Start(18)
		end
	elseif spellId == 235267 then
		self.vb.massShitCount = self.vb.massShitCount + 1
		warnMassShit:Show(self.vb.massShitCount)
		if self.vb.massShitCount == 1 then
			timerMassInstabilityCD:Start(36, 2)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 239153 then
		self.vb.spontFragmentationCount = self.vb.spontFragmentationCount + 1
		if self.vb.spontFragmentationCount < 4 then
			timerSpontFragmentationCD:Start(nil, self.vb.spontFragmentationCount+1)
		end
	elseif spellId == 237722 then--Blowback
		timerSpontFragmentationCD:Stop()
		timerMassInstabilityCD:Stop()
		timerInfusionCD:Stop()
		countdownInfusion:Cancel()
		timerLightHammerCD:Stop()
		countdownLightHammer:Cancel()
		timerFelHammerCD:Stop()
		countdownFelHammer:Cancel()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 235240 then--Fel Infusion
		if args:IsPlayer() then
			specWarnFelInfusion:Show()
			voiceFelInfusion:Play("felinfusion")
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self.Options.SetIconOnInfusion and self:IsTanking(uId) then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 235213 then--Light Infusion
		if args:IsPlayer() then
			specWarnLightInfusion:Show()
			voiceLightInfusion:Play("lightinfusion")
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self.Options.SetIconOnInfusion and self:IsTanking(uId) then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 235117 or spellId == 240209 then
		self.vb.unstableSoulCount = self.vb.unstableSoulCount + 1
		warnUnstableSoul:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self:IsEasy() then
				specWarnUnstableSoul:Schedule(5.75, AegynnsWard)--2.5 before expire, maybe adjust to 3
			else
				specWarnUnstableSoul:Schedule(6.75, AegynnsWard)
			end
			if not self:IsLFR() then
				yellUnstableSoul:Countdown(8)
				if self:IsEasy() then
					voiceUnsableSoul:Schedule(5.75, "jumpinpit")
				else
					voiceUnsableSoul:Schedule(6.75, "jumpinpit")
				end
			else
				voiceUnsableSoul:Play("defensive")--Whatever, doens't matter in LFR. LFR doesn't need Aegwynn's Ward/pit
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() and not self.vb.shieldActive then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	elseif spellId == 236061 then
		warnEssenceFragments:Show()
	elseif spellId == 234891 then
		local shieldname = GetSpellInfo(235028)
		self.vb.shieldActive = true
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(shieldname)
			DBM.InfoFrame:Show(2, "enemyabsorb", shieldname)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 235240 then--Fel Infusion
		--[[if self.Options.SetIconOnInfusion then
			local uId = DBM:GetRaidUnitId(args.destName)
			local currentIcon = GetRaidTargetIndex(uId) or 0
			if self:IsTanking(uId) and currentIcon ~= 1 then--Fel infusion removed but light infusion icon is already set, don't touch it
				self:SetIcon(args.destName, 0)
			end
		end--]]
	elseif spellId == 235213 then--Light Infusion
		--[[if self.Options.SetIconOnInfusion then
			local uId = DBM:GetRaidUnitId(args.destName)
			local currentIcon = GetRaidTargetIndex(uId) or 0
			if self:IsTanking(uId) and currentIcon ~= 4 then--Light infusion removed but fel infusion icon is already set, don't touch it
				self:SetIcon(args.destName, 0)
			end
		end-]]
	elseif spellId == 235117 or spellId == 240209 then
		self.vb.unstableSoulCount = self.vb.unstableSoulCount - 1
		if args:IsPlayer() then
			yellUnstableSoul:Cancel()
		end
		if self.Options.InfoFrame and self.vb.unstableSoulCount == 0 and not self.vb.shieldActive then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 235028 then--Bulwark Removed
		specWarnWrathofCreators:Show(args.destName)
		voiceWrathofCreators:Play("kickcast")
	elseif spellId == 234891 then--Wrath Interrupted
		self.vb.shieldActive = false
		self.vb.hammerCount = 0
		self.vb.infusionCount = 0
		self.vb.massShitCount = 0
		timerInfusionCD:Start(2, 1)
		timerLightHammerCD:Start(14, 1)
		countdownLightHammer:Start(14)
		timerMassInstabilityCD:Start(22, 1)
		timerBlowbackCD:Start()
		if self:IsMythic() then
			self.vb.spontFragmentationCount = 0
			--timerSpontFragmentationCD:Start(nil, 1)
		end
		if self.Options.InfoFrame then
			local spellName = GetSpellInfo(235117)
			DBM.InfoFrame:SetHeader(spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", spellName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 238408 or spellId == 238028) and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
