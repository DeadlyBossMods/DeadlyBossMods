local mod	= DBM:NewMod(1897, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118289)
mod:SetEncounterID(2052)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235271 241635 241636",
	"SPELL_CAST_SUCCES 235267 239114",
	"SPELL_AURA_APPLIED 235240 235213 235117 240209 237722 235028 236061",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 235240 235213 235117 240209 235028",
	"SPELL_INTERRUPT",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: range frame? seems impractical at moment, if someone shows up range frame it's already too late.
--TODO, new voices, "Fel infusion" and "Light Infusion" and "Move to Pit"
--TODO, figure out hammers to better impliment a taunting system. I suspect a two camp strat with tank in appropriate camp taunting during hammer cast
--TODO, some kind of shield health tracker
--TODO, wrath of the creators stack counter. Can't find right spellID for a drycode
--Stage One
local warnUnstableSoul				= mod:NewTargetAnnounce(235117, 4, nil, false)--Might be spammy so off by default. Infoframe will do better job with this one
--Stage Two
local warnEssenceFragments			= mod:NewSpellAnnounce(236061, 2)

--Stage One: Divide and Conquer
local specWarnInfusion				= mod:NewSpecialWarningSpell(235271, nil, nil, nil, 2, 2)
local specWarnFelInfusion			= mod:NewSpecialWarningYou(235240, nil, nil, nil, 1, 7)
local specWarnLightInfusion			= mod:NewSpecialWarningYou(235213, nil, nil, nil, 1, 7)
local specWarnUnstableSoul			= mod:NewSpecialWarningMoveTo(235117, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(235117), nil, 3, 7)
local yellUnstableSoul				= mod:NewFadesYell(235117)--While learning the fight this will be spammy, but also nessesary
local specWarnLightHammer			= mod:NewSpecialWarningCount(241635, nil, nil, nil, 2, 2)
local specWarnFelhammer				= mod:NewSpecialWarningCount(241636, nil, nil, nil, 2, 2)
--Stage Two
local specWarnWrathofCreators		= mod:NewSpecialWarningInterrupt(234891, "HasInterrupt", nil, nil, 1, 2)

--Stage One: Divide and Conquer
local timerInfusionCD				= mod:NewAITimer(31, 235271, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerHammersCD				= mod:NewAITimer(31, "ej14871", nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--To be made count timer. 1580740 spell texture?
local timerMassInstabilityCD		= mod:NewAITimer(31, 235267, nil, nil, nil, 3)
--Mythic
local timerSpontFragmentationCD		= mod:NewAITimer(31, 239114, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage One: Divide and Conquer
--local countdownInfusion			= mod:NewCountdown(33, 235271)

--Stage One: Divide and Conquer
local voiceInfusion					= mod:NewVoice(235271)--scatter
local voiceFelInfusion				= mod:NewVoice(235240)--felinfusion
local voiceLightInfusion			= mod:NewVoice(235213)--lightinfusion
local voiceUnsableSoul				= mod:NewVoice(235117)--movetopit
--Stage Two
local voiceWrathofCreators			= mod:NewVoice(234891, "HasInterrupt")--kickcast

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(235117, true)
--mod:AddRangeFrameOption("5/8/15")
mod:AddNamePlateOption("NPAuraOnInfusion", 235271)

mod.vb.unstableSoulCount = 0
mod.vb.hammerCount = 0
local AegynnsWard = GetSpellInfo(236420)
local felDebuff, lightDebuff = GetSpellInfo(235240), GetSpellInfo(235213)

function mod:OnCombatStart(delay)
	self.vb.unstableSoulCount = 0
	self.vb.hammerCount = 0
	timerInfusionCD:Start(1-delay)--2
	timerHammersCD:Start(1-delay)--13.8
	timerMassInstabilityCD:Start(1-delay)
	if self:IsMythic() then
		timerSpontFragmentationCD:Start(1-delay)
	end
	if self.Options.NPAuraOnInfusion then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnInfusion then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235271 then
		specWarnInfusion:Show()
		voiceInfusion:Play("scatter")
		timerInfusionCD:Start()
	elseif spellId == 241635 then--Light Hammer
		self.vb.hammerCount = self.vb.hammerCount + 1
		specWarnLightHammer:Show(self.vb.hammerCount)
		timerHammersCD:Start()
	elseif spellId == 241636 then--Fel Hammer
		self.vb.hammerCount = self.vb.hammerCount + 1
		specWarnFelhammer:Show(self.vb.hammerCount)
		timerHammersCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 235267 then
		timerMassInstabilityCD:Start()
	elseif spellId == 239114 then
		timerSpontFragmentationCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 235240 then--Fel Infusion
		if args:IsPlayer() then
			specWarnFelInfusion:Show()
			voiceFelInfusion:Play("felinfusion")
		end
		if self.Options.NPAuraOnInfusion then
			DBM.Nameplate:Show(false, args.destName, spellId)
		end
	elseif spellId == 235213 then--Light Infusion
		if args:IsPlayer() then
			specWarnLightInfusion:Show()
			voiceLightInfusion:Play("lightinfusion")
		end
		if self.Options.NPAuraOnInfusion then
			DBM.Nameplate:Show(false, args.destName, spellId)
		end
	elseif spellId == 235117 or spellId == 240209 then
		self.vb.unstableSoulCount = self.vb.unstableSoulCount + 1
		warnUnstableSoul:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnUnstableSoul:Show(AegynnsWard)
			if not self:IsLFR() then
				yellUnstableSoul:Yell(8)
				yellUnstableSoul:Schedule(7, 1)
				yellUnstableSoul:Schedule(6, 2)
				yellUnstableSoul:Schedule(5, 3)
				voiceUnsableSoul:Play("movetopit")
			else
				voiceUnsableSoul:Play("defensive")--Whatever, doens't matter in LFR. LFR doesn't need Aegwynn's Ward/pit
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	elseif spellId == 236061 then
		warnEssenceFragments:Show()
	elseif spellId == 237722 and self:AntiSpam(10, 1) then--Phase change probably
		timerSpontFragmentationCD:Stop()
		timerMassInstabilityCD:Stop()
		timerHammersCD:Stop()
		timerInfusionCD:Stop()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 228029 then
		if self.Options.NPAuraOnInfusion then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
	elseif spellId == 235213 then--Light Infusion
		if self.Options.NPAuraOnInfusion then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
	elseif spellId == 235117 or spellId == 240209 then
		self.vb.unstableSoulCount = self.vb.unstableSoulCount - 1
		if args:IsPlayer() then
			yellUnstableSoul:Cancel()
		end
		if self.Options.InfoFrame and self.vb.burstDebuffCount == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 235028 then--Bulwark Removed
		specWarnWrathofCreators:Show(args.destName)
		voiceWrathofCreators:Play("kickcast")
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 234891 then
		--Return to regular phase?
		timerSpontFragmentationCD:Start(2)
		timerMassInstabilityCD:Start(2)
		timerHammersCD:Start(2)
		timerInfusionCD:Start(2)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
