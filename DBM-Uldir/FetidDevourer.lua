local mod	= DBM:NewMod(2146, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(133298)
mod:SetEncounterID(2128)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 262292 262288 262364 262277",
	"SPELL_CAST_SUCCESS 262370",
	"SPELL_AURA_APPLIED 262313 262314 262378",
	"SPELL_AURA_REMOVED 262313 262314",
	"SPELL_AURA_REMOVED_DOSE 262256",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnFrenzy						= mod:NewSpellAnnounce(262378, 3)
local warnThrashNotTanking				= mod:NewSpellAnnounce(262277, 3, nil, "Tank|Healer")

local specWarnThrash					= mod:NewSpecialWarningDefensive(262277, "Tank", nil, nil, 1, 2)
local specWarnRottingRegurg				= mod:NewSpecialWarningDodge(262292, nil, nil, nil, 2, 2)
local specWarnShockwaveStomp			= mod:NewSpecialWarningSpell(262288, nil, nil, nil, 2, 2)
local specWarnMalodorousMiasma			= mod:NewSpecialWarningYou(262313, nil, nil, nil, 1, 2)
local specWarnDeadlyDisease				= mod:NewSpecialWarningDefensive(262314, nil, nil, nil, 1, 2)
local specWarnAdds						= mod:NewSpecialWarningAdds(262364, "Dps", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerThrashCD						= mod:NewCDTimer(6, 262277, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRottingRegurgCD				= mod:NewCDTimer(40.1, 262292, nil, nil, nil, 3)
local timerShockwaveStompCD				= mod:NewCDTimer(28.8, 262288, nil, nil, nil, 2)
local timerAddsCD						= mod:NewAddsTimer(54.8, 262364, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

local berserkTimer						= mod:NewBerserkTimer(369)

local countdownRottingRegurg			= mod:NewCountdown(40, 262292, true, nil, 4)
local countdownThrash					= mod:NewCountdown("Alt12", 262277, false, nil, 3)--off by default since it'd be a LOT of counting. But some might still want it
local countdownAdds						= mod:NewCountdown("AltTwo32", 262364, "Dps", nil, 5)

mod:AddRangeFrameOption("8/20")
mod:AddInfoFrameOption(262364, true)

local trackedAdds = {}

local updateInfoFrame
do
	local lines = {}
	local addedGUIDs = {}
	local floor, UnitCastingInfo, UnitHealth, UnitHealthMax = math.floor, UnitCastingInfo, UnitHealth, UnitHealthMax
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(addedGUIDs)
		--Check nameplates
		for i = 1, 40 do
			local UnitID = "nameplate"..i
			local GUID = UnitGUID(UnitID)
			if GUID and not addedGUIDs[GUID] then
				local cid = mod:GetCIDFromGUID(GUID)
				if cid == 133492 then
					local unitHealth = UnitHealth(UnitID) / UnitHealthMax(UnitID)
					local _, _, _, startTime, endTime = UnitCastingInfo(UnitID)
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
					local _, _, _, startTime, endTime = UnitCastingInfo(UnitID)
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

local updateRangeFrame
do
	local function debuffFilter(uId)
		if DBM:UnitDebuff(uId, 262313) or DBM:UnitDebuff(uId, 262314) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if DBM:UnitDebuff("player", 262314) then
			DBM.RangeCheck:Show(20)
		elseif DBM:UnitDebuff("player", 262313) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(trackedAdds)
	timerThrashCD:Start(6.7-delay)
	countdownThrash:Start(6.7-delay)
	if not self:IsEasy() then
		timerShockwaveStompCD:Start(26.1-delay)
		timerRottingRegurgCD:Start(40-delay)
		countdownRottingRegurg:Start(40-delay)
	else
		timerRottingRegurgCD:Start(31.4-delay)
		countdownRottingRegurg:Start(31.4-delay)
	end
	timerAddsCD:Start(55.1-delay)
	countdownAdds:Start(55.1-delay)
	berserkTimer:Start()
	if self:IsMythic() then
		updateRangeFrame(self)
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
	if spellId == 262292 then
		specWarnRottingRegurg:Show()
		specWarnRottingRegurg:Play("shockwave")
		if not self:IsEasy() then
			if self:IsMythic() then
				timerRottingRegurgCD:Start(37)--37
				countdownRottingRegurg:Start(37)--37
			else
				timerRottingRegurgCD:Start()--40
				countdownRottingRegurg:Start()--40
			end
		else
			timerRottingRegurgCD:Start(30.3)
			countdownRottingRegurg:Start(30.3)
		end
	elseif spellId == 262288 and self:AntiSpam(5, 1) then
		specWarnShockwaveStomp:Show()
		specWarnShockwaveStomp:Play("carefly")
		timerShockwaveStompCD:Start()
	elseif spellId == 262364 then--Enticing Essence
		if not trackedAdds[args.sourceGUID] then
			trackedAdds[args.sourceGUID] = true
		end
		if self.Options.InfoFrame and #trackedAdds > 0 and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
		end
		if self:AntiSpam(10, 2) then
			specWarnAdds:Show()
			specWarnAdds:Play("killmob")
			if self:IsEasy() then
				timerAddsCD:Start()
				countdownAdds:Start(54.8)
			else
				timerAddsCD:Start(59.8)
				countdownAdds:Start(59.8)
			end
		end
	elseif spellId == 262277 then
		timerThrashCD:Start()
		countdownThrash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 262370 then--Consume Corruption
		--2.5/3 energy per second, spell every 40/30 seconds there abouts (blizz energy formula still has standard variation)
		--This basically means every add that's eaten add takes 8/6 seconds off timer
		local elapsed, total = timerRottingRegurgCD:GetTime()--Grab current timer
		local adjustAmount = self:IsEasy() and 6 or self:IsMythic() and 7.4 or 8
		elapsed = elapsed + adjustAmount
		local remaining = total-elapsed
		countdownRottingRegurg:Cancel()
		timerRottingRegurgCD:Stop()--Trash old timer
		if remaining >= 3 then--It's worth showing updated timer
			timerRottingRegurgCD:Start(elapsed, total)--Construct new timer with adjustment
			countdownRottingRegurg:Start(remaining)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 262313 and args:IsPlayer() then
		specWarnMalodorousMiasma:Show()
		specWarnMalodorousMiasma:Play("targetyou")
		if self:IsMythic() then
			updateRangeFrame(self)
		end
	elseif spellId == 262314 and args:IsPlayer() then
		specWarnDeadlyDisease:Show()
		specWarnDeadlyDisease:Play("defensive")
		if self:IsMythic() then
			updateRangeFrame(self)
		end
	elseif spellId == 262378 then
		warnFrenzy:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 262313 or spellId == 262314) and args:IsPlayer() and self:IsMythic() then
		updateRangeFrame(self)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 262256 then
		local amount = args.amount or 0
		if amount == 1 then
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then--Not thrash target
				warnThrashNotTanking:Show()
			else
				specWarnThrash:Show()
				specWarnThrash:Play("defensive")
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 133492 then--Corruption Corpuscle
		trackedAdds[args.destGUID] = nil
		if self.Options.InfoFrame and #trackedAdds == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end
