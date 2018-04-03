local mod	= DBM:NewMod(2146, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(133298)
mod:SetEncounterID(2128)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 262292 262288 262364",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 262256 262313 262314 262378",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
	"SPELL_ENERGIZE 262370",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify thrash buff detection and improve it
--TODO, review defaults for Miasma. Might only warn disease by default, not pre debuff (miasma)
--TODO, add spawn timers? Seems like gluth 2.0
local warnMalodorousMiasma				= mod:NewTargetAnnounce(262313, 2)
local warnFrenzy						= mod:NewSpellAnnounce(262378, 3)

local specWarnThrash					= mod:NewSpecialWarningDefensive(262277, "Tank", nil, nil, 1, 2)
local specWarnRottingRegurg				= mod:NewSpecialWarningDodge(262277, nil, nil, nil, 2, 2)
local specWarnShockwaveStomp			= mod:NewSpecialWarningSpell(262288, nil, nil, nil, 2, 2)
local specWarnMalodorousMiasma			= mod:NewSpecialWarningYou(262313, nil, nil, nil, 1, 2)
local specWarnDeadlyDisease				= mod:NewSpecialWarningDefensive(262314, nil, nil, nil, 1, 2)
--local specWarnRealityTear				= mod:NewSpecialWarningStack(244016, nil, 2, nil, nil, 1, 6)
--local specWarnHowlingShadows			= mod:NewSpecialWarningInterrupt(245504, "HasInterrupt", nil, nil, 1, 2)
--local yellFelSilkWrap					= mod:NewYell(244949)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(Nexus)
local timerThrashCD						= mod:NewAITimer(12.1, 262277, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRottingRegurgCD				= mod:NewAITimer(12.1, 262292, nil, nil, nil, 3)
local timerShockwaveStompCD				= mod:NewAITimer(12.1, 262288, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRealityTear				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(262364, true)

local infoSpellName = GetSpellInfo(262364)

local updateInfoFrame
do
	local lines = {}
	local addedGUIDs = {}
	local floor, UnitCastingInfo, UnitHealth, UnitHealthMax = math.floor, UnitCastingInfo, UnitHealth, UnitHealthMax
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(addedGUIDs)
		--Check nameplates
		for i = 1, 25 do
			local UnitID = "nameplate"..i
			local GUID = UnitGUID(UnitID)
			if GUID and not addedGUIDs[GUID] then
				local cid = mod:GetCIDFromGUID(GUID)
				if cid == 133492 then
					local unitHealth = UnitHealth(UnitID) / UnitHealthMax(UnitID)
					local _, _, _, _, startTime, endTime = UnitCastingInfo(UnitID)
					local time = ((endTime or 0) - (startTime or 0)) / 1000
					if time then
						lines[floor(unitHealth).."%"] = floor(time)
					end
				end
			end
		end
		--Check raid targets
		for uId in DBM:GetGroupMembers() do
			local UnitID = uId.."target"
			local GUID = UnitGUID(UnitID)
			if GUID and not addedGUIDs[GUID] then
				local cid = mod:GetCIDFromGUID(GUID)
				if cid == 133492 then
					local unitHealth = UnitHealth(UnitID) / UnitHealthMax(UnitID)
					local _, _, _, _, startTime, endTime = UnitCastingInfo(UnitID)
					if startTime and endTime then
						local time = (endTime - startTime) / 1000
						lines[floor(unitHealth).."%"] = floor(time)
					end
				end
			end
		end
		return lines
	end
end

function mod:OnCombatStart(delay)
	infoSpellName = GetSpellInfo(262364)
	timerThrashCD:Start(1-delay)
	timerRottingRegurgCD:Start(1-delay)
	timerShockwaveStompCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(infoSpellName)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
	end
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
	if spellId == 262292 then
		specWarnRottingRegurg:Show()
		specWarnRottingRegurg:Play("shockwave")
		timerRottingRegurgCD:Start()
	elseif spellId == 262288 then
		specWarnShockwaveStomp:Show()
		specWarnShockwaveStomp:Play("carefly")
		timerShockwaveStompCD:Start()
	elseif spellId == 262364 then--Enticing Essence
		--Do stuff?
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245050 then--Delusions

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 262256 then
		specWarnThrash:Show()
		specWarnThrash:Play("defensive")
		timerThrashCD:Start()
	elseif spellId == 262313 then
		warnMalodorousMiasma:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnMalodorousMiasma:Show()
			specWarnMalodorousMiasma:Play("targetyou")
		end
	elseif spellId == 262314 then
		
		if args:IsPlayer() then
			specWarnDeadlyDisease:Show()
			specWarnDeadlyDisease:Play("defensive")
		end
	elseif spellId == 262378 then
		warnFrenzy:Show()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if spellId == 262370 and destGUID == UnitGUID("boss1") then--Consume Corruption
		DBM:Debug("SPELL_ENERGIZE fired on Boss, Updating Timers: "..amount)
		--Update when power gain rate is known and whic ability timers affected by it and need updating
--[[		local bossPower = UnitPower("boss1")
		bossPower = bossPower / 4--4 energy per second, smash every 25 seconds there abouts.
		local remaining = 25-bossPower
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(remaining)
		timerShatteringSmashCD:Stop()--Prevent timer debug when updating timer
		timerShatteringSmashCD:Start(remaining, self.vb.smashCount+1)--]]
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244383 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 133492 then--Corruption Corpuscle

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then

	end
end
--]]
