local mod	= DBM:NewMod(2167, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135452)--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
mod:SetEncounterID(2141)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267787 268198",
	"SPELL_CAST_SUCCESS 267795 267945 267885 267878 269827 268089 277973 277961 277742",
	"SPELL_AURA_APPLIED 267787 274205 269051",
	"SPELL_AURA_APPLIED_DOSE 267787"
)

--More mythic timer work
--[[
ability.id = 267787 and type = "begincast"
 or (ability.id = 267795 or ability.id = 267945 or ability.id = 269827 or ability.id = 277973 or ability.id = 277961 or ability.id = 268089 or ability.id = 277742) and type = "cast"
--]]
local warnSunderingScalpel				= mod:NewStackAnnounce(267787, 3, nil, "Tank")
local warnWindTunnel					= mod:NewSpellAnnounce(267945, 2)
local warnDepletedEnergy				= mod:NewSpellAnnounce(274205, 1)
local warnCleansingPurgeFinish			= mod:NewTargetNoFilterAnnounce(268095, 4)

local specWarnSunderingScalpel			= mod:NewSpecialWarningDodge(267787, nil, nil, nil, 1, 2)
local specWarnPurifyingFlame			= mod:NewSpecialWarningDodge(267795, nil, nil, nil, 2, 2)
local specWarnClingingCorruption		= mod:NewSpecialWarningInterrupt(268198, "HasInterrupt", nil, nil, 1, 2)
local specWarnSurgicalBeam				= mod:NewSpecialWarningDodgeLoc(269827, nil, nil, nil, 3, 2)

--mod:AddTimerLine(Nexus)
local timerSunderingScalpelCD			= mod:NewNextTimer(23.1, 267787, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPurifyingFlameCD				= mod:NewNextTimer(23.1, 267795, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerWindTunnelCD					= mod:NewNextTimer(39.8, 267945, nil, nil, nil, 2)
local timerSurgicalBeamCD				= mod:NewCDSourceTimer(30, 269827, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerCleansingFlameCD				= mod:NewCastSourceTimer(180, 268095, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPurifyingFlame			= mod:NewCountdown(23, 267795, true, nil, 3)
local countdownSunderingScalpel			= mod:NewCountdown("Alt23", 267787, "Tank", nil, 3)
local countdownSurgicalBeam				= mod:NewCountdown("AltTwo30", 269827, nil, nil, 4)

mod:AddInfoFrameOption(268095, true)

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
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				if currentPower / maxPower * 100 >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		--Player personal checks
		--local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 267821)
		--if spellName and expireTime then--Personal Defense Grid. Same spellId is used for going through and lingering, but expire time will only exist for lingering
			--local remaining = expireTime-GetTime()
			--addLine(spellName, remaining)
		--end
		--TODO, player tracking per chamber if possible
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	timerSunderingScalpelCD:Start(5.9-delay)
	countdownSunderingScalpel:Start(5.9-delay)
	timerPurifyingFlameCD:Start(10.8-delay)
	countdownPurifyingFlame:Start(10.8-delay)
	timerWindTunnelCD:Start(20.6-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false)
	end
	if self:AntiSpam(3, 1) then
		--Do nothing
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267787 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSunderingScalpel:Show()
			specWarnSunderingScalpel:Play("shockwave")
		end
		timerSunderingScalpelCD:Start()
		countdownSunderingScalpel:Start()
	elseif spellId == 268198 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnClingingCorruption:Show(args.sourceName)
		specWarnClingingCorruption:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267795 then
		specWarnPurifyingFlame:Show()
		specWarnPurifyingFlame:Play("watchstep")
		timerPurifyingFlameCD:Start()
		countdownPurifyingFlame:Start()
	elseif spellId == 267878 then--Directional IDs for winds (Coming from east blowing to west?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267885 then--Directional IDs for winds (Coming from west blowing to east?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267945 then--Global Id for winds
		warnWindTunnel:Show()
		timerWindTunnelCD:Show()--40-47
	elseif spellId == 269827 or spellId == 277973 or spellId == 277961 or spellId == 277742 then
		if spellId == 277961 or spellId == 277742 then--Top
			specWarnSurgicalBeam:Show(DBM_CORE_TOP)
			timerSurgicalBeamCD:Start(40, DBM_CORE_TOP)--40-47
		elseif spellId == 277973 then--Sides
			specWarnSurgicalBeam:Show(DBM_CORE_SIDE)
			timerSurgicalBeamCD:Start(40, DBM_CORE_SIDE)--40-47
		else--Middle (chamber 3)
			specWarnSurgicalBeam:Show(DBM_CORE_MIDDLE)
			timerSurgicalBeamCD:Start(30, DBM_CORE_MIDDLE)--30-?
			countdownSurgicalBeam:Start()
			specWarnSurgicalBeam:ScheduleVoice(1.5, "keepmove")
		end
		specWarnSurgicalBeam:Play("laserrun")
	elseif spellId == 268089 and self:AntiSpam(3, 1) then--End Cast of Cleansing Purge
		warnCleansingPurgeFinish:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267787 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnSunderingScalpel:Show(args.destName, amount)
		end
	elseif spellId == 274205 then
		warnDepletedEnergy:Show()
	elseif spellId == 269051 then--Begin Cast of Cleansing Purge
		--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
		local cid = self:GetCIDFromGUID(args.destGUID)
		local time = self:IsMythic() and 123 or 180
		if cid == 136429 then
			timerCleansingFlameCD:Start(time, 1)
		elseif cid == 137022 then
			timerCleansingFlameCD:Start(time, 2)
			--if self:IsHard() then
			--	timerSurgicalBeamCD:Start(10, DBM_CORE_SIDE)--10-18, need more work to get this better if possible
			--	timerSurgicalBeamCD:Start(33, DBM_CORE_TOP)--33-41
			--end
		elseif cid == 137023 then
			timerCleansingFlameCD:Start(time, 3)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
