local mod	= DBM:NewMod(2347, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150653)
mod:SetEncounterID(2289)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 292270 292083",
	"SPELL_CAST_SUCCESS 292205 302135 292159",
	"SPELL_AURA_APPLIED 292307 292133 292138 289699 292167 301494 298595",
	"SPELL_AURA_APPLIED_DOSE 289699",
	"SPELL_AURA_REMOVED 292133 292138 298595",
	"SPELL_INTERRUPT"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO: Can boss cast Bioelectric Feelers during Cavitation, when tank is forced away from boss?
--TODO, figure out how to track who Piercing Barb is on.
local warnBioluminescentCloud			= mod:NewSpellAnnounce(292205, 2)
local warnToxicSpine					= mod:NewTargetNoFilterAnnounce(292167, 2, nil, "Healer")

local specWarnGazefromBelow				= mod:NewSpecialWarningYou(292307, nil, nil, nil, 3, 2)
local specWarnFeedingFrenzy				= mod:NewSpecialWarningCount(298424, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(18, 298424), nil, 1, 2)
local specWarnFeedingFrenzyOther		= mod:NewSpecialWarningTaunt(298424, nil, nil, nil, 1, 2)
local specWarnShockPulse				= mod:NewSpecialWarningCount(292270, nil, nil, nil, 2, 2)
local specWarnCavitation				= mod:NewSpecialWarningSpell(292083, nil, nil, nil, 2, 2)
--local specWarnPiercingBarb			= mod:NewSpecialWarningYou(301494, nil, nil, nil, 3, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerBioluminescentCloud			= mod:NewCastCountTimer(30.4, 292205, nil, nil, nil, 5)
local timerToxicSpineCD					= mod:NewNextTimer(25.5, 292167, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerShockPulseCD					= mod:NewNextCountTimer(34, 292270, nil, nil, nil, 2, nil, nil, nil, 1, 4)
local timerPiercingBarbCD				= mod:NewNextTimer(30, 301494, nil, nil, nil, 3)--Mythic
local timerCavitation					= mod:NewCastTimer(40, 292083, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(292133, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)

--mod.vb.phase = 1
mod.vb.cloudCount = 0
mod.vb.shockPulse = 0
local playerBio, playerBioTwo, playerBioThree = false, false, false

local updateInfoFrame
do
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
		--Player personal checks (Always Tracked)
		if playerBio then
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 292133)
			if spellName and expireTime then--Personal Tailwinds count
				local remaining = expireTime-GetTime()
				addLine(spellName, math.floor(remaining))
			end
		end
		if playerBioTwo then
			local spellName2, _, _, _, _, expireTime2 = DBM:UnitDebuff("player", 292138)
			if spellName2 and expireTime2 then--Personal Tailwinds count
				local remaining2 = expireTime2-GetTime()
				addLine(spellName2, math.floor(remaining2))
			end
		end
		if playerBioThree then
			local spellName3, _, _, _, _, expireTime3 = DBM:UnitDebuff("player", 298595)
			if spellName3 and expireTime3 then--Personal Tailwinds count
				local remaining3 = expireTime3-GetTime()
				addLine(spellName3, math.floor(remaining3))
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.cloudCount = 0
	self.vb.shockPulse = 0
	playerBio, playerBioTwo, playerBioThree = false, false, false
	timerToxicSpineCD:Start(self:isMythic() and 8-delay or 22.9-delay)
	timerShockPulseCD:Start(self:isMythic() and 23-delay or 26.5-delay, 1)
	if self:IsMythic() then
		timerPiercingBarbCD:Start(11-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
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

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 292133) then
		playerBio = true
	end
	if DBM:UnitDebuff("player", 292138) then
		playerBioTwo = true
	end
	if DBM:UnitDebuff("player", 298595) then
		playerBioThree = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 292270 then
		self.vb.shockPulse = self.vb.shockPulse + 1
		specWarnShockPulse:Show(self.vb.shockPulse)
		specWarnShockPulse:Play("aesoon")
		timerShockPulseCD:Start(self:isMythic() and 30 or 34, self.vb.shockPulse+1)
	elseif spellId == 292083 then
		specWarnCavitation:Show()
		specWarnCavitation:Play("phasechange")
		timerCavitation:Start()
		timerToxicSpineCD:Stop()
		timerShockPulseCD:Stop()
		timerPiercingBarbCD:Stop()
	elseif spellId == 292159 then
		warnToxicSpine:Show(args.destName)
		timerToxicSpineCD:Start(self:isMythic() and 20 or 25.5)
	end
--	elseif spellId == 267180 then
--		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
		--	specWarnVoidbolt:Show(args.sourceName)
			--specWarnVoidbolt:Play("kickcast")
--		end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 292205 or spellId == 302135 then
		self.vb.cloudCount = self.vb.cloudCount + 1
		timerBioluminescentCloud:Start(20, self.vb.cloudCount)
		if self:AntiSpam(5, 1) then
			warnBioluminescentCloud:Show()
		end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 292307 and args:IsPlayer() then
		specWarnGazefromBelow:Show()
		specWarnGazefromBelow:Play("targetyou")
	elseif spellId == 292133 then
		if args:IsPlayer() then
			playerBio = true
		end
	elseif spellId == 292138 then
		if args:IsPlayer() then
			playerBioTwo = true
		end
	elseif spellId == 298595 then
		if args:IsPlayer() then
			playerBioThree = true
		end
	elseif spellId == 289699 then
		local amount = args.amount or 1
		if amount >= 18 and self:AntiSpam(5, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnFeedingFrenzy:Show(amount)
				specWarnFeedingFrenzy:Play("changemt")
			else
				specWarnFeedingFrenzyOther:Show(args.destName)
				specWarnFeedingFrenzyOther:Play("tauntboss")
			end
		end
	elseif spellId == 292167 then
		warnToxicSpine:CombinedShow(0.3, args.destName)
	elseif spellId == 301494 then
		timerPiercingBarbCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 292133 then
		if args:IsPlayer() then
			playerBio = false
		end
	elseif spellId == 292138 then
		if args:IsPlayer() then
			playerBioTwo = false
		end
	elseif spellId == 298595 then
		if args:IsPlayer() then
			playerBioThree = false
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 292083 then
		timerCavitation:Stop()
		timerToxicSpineCD:Start(self:isMythic() and 8 or 20.8)
		timerShockPulseCD:Start(self:isMythic() and 23 or 25.7, self.vb.shockPulse+1)
		if self:IsMythic() then
			timerPiercingBarbCD:Start(11)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 150773 then--Shimmerskin Pufferfish

	elseif cid == 153779 then--Darkwater Jellyfish

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 then

	end
end
--]]
