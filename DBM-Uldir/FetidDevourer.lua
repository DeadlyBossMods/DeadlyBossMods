local mod	= DBM:NewMod(2146, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(133298)
mod:SetEncounterID(2128)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 262292 262288 262364 262277",
	"SPELL_CAST_SUCCESS 262370 274470",
	"SPELL_AURA_APPLIED 262313 262314 262378",
	"SPELL_AURA_APPLIED_DOSE 262313 262314",
	"SPELL_AURA_REMOVED 262313 262314",
	"SPELL_AURA_REMOVED_DOSE 262256"
)

--[[
(ability.id = 262292 or ability.id = 262288 or ability.id = 262364) and type = "begincast"
 or (ability.id = 262370 or ability.id = 274470) and type = "cast"
--]]
local warnFrenzy						= mod:NewSpellAnnounce(262378, 3)
local warnThrashNotTanking				= mod:NewSpellAnnounce(262277, 3, nil, "Tank|Healer")
local warnChuteVisual					= mod:NewAnnounce("addsSoon", 3, 262364)

local specWarnThrash					= mod:NewSpecialWarningDefensive(262277, "Tank", nil, nil, 1, 2)
local specWarnRottingRegurg				= mod:NewSpecialWarningDodge(262292, nil, nil, nil, 2, 2)
local specWarnShockwaveStomp			= mod:NewSpecialWarningCount(262288, nil, nil, nil, 2, 2)
local specWarnMalodorousMiasma			= mod:NewSpecialWarningYou(262313, nil, nil, nil, 1, 2)
local specWarnMalodorousMiasmaStack		= mod:NewSpecialWarningStack(262313, nil, 2, nil, nil, 1, 6)
local yellMalodorousMiasma				= mod:NewYell(262313)
local yellMalodorousMiasmaFades			= mod:NewFadesYell(262313)
local specWarnPutridParoxysm			= mod:NewSpecialWarningDefensive(262314, nil, nil, nil, 1, 2)
local specWarnPutridParoxysmStack		= mod:NewSpecialWarningStack(262314, nil, 2, nil, nil, 1, 6)
local yellPutridParoxysm				= mod:NewYell(262314)
local yellPutridParoxysmFades			= mod:NewFadesYell(262314)
local specWarnAdds						= mod:NewSpecialWarningAdds(262364, "Dps", nil, nil, 1, 2)

local timerThrashCD						= mod:NewCDTimer(6, 262277, 74979, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Short Name "Thrash"
local timerRottingRegurgCD				= mod:NewCDTimer(40.1, 262292, 21131, nil, nil, 3)--Short Name "Breath"
local timerShockwaveStompCD				= mod:NewCDCountTimer(28.8, 262288, 116969, nil, nil, 2)--Short Name "Stomp"
local timerPreAddsCD					= mod:NewTimer(54.8, "chuteTimer", 262364, false, nil, 5)
local timerAddsCD						= mod:NewAddsTimer(54.8, 262364, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

local berserkTimer						= mod:NewBerserkTimer(330)

local countdownRottingRegurg			= mod:NewCountdown(40, 262292, true, nil, 4)
local countdownThrash					= mod:NewCountdown("Alt12", 262277, false, nil, 3)--off by default since it'd be a LOT of counting. But some might still want it
local countdownAdds						= mod:NewCountdown("AltTwo32", 262364, "Dps", nil, 5)

mod:AddRangeFrameOption("6/12")
mod:AddInfoFrameOption(262364, true)

mod.vb.stompCount = 0

local updateInfoFrame, openInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local floor, UnitCastingInfo, UnitHealth, UnitHealthMax, UnitExists = math.floor, UnitCastingInfo, UnitHealth, UnitHealthMax, UnitExists
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		local found = false
		for i = 2, 4 do--Adds do get Boss Unit IDs, so just need to check boss2-boss4
			local UnitID = "boss"..i
			if UnitExists(UnitID) then
				found = true
				local unitHealth = (UnitHealth(UnitID) / UnitHealthMax(UnitID)) * 100
				local _, _, _, _, endTime = UnitCastingInfo(UnitID)
				local time = ((endTime or 0) / 1000) - GetTime()
				if time and time > 0 then
					addLine(i.."--"..floor(unitHealth).."%", floor(time))
				else
					addLine(i.."--"..floor(unitHealth).."%", 0)
				end
			end
		end
		if not found then
			DBM.InfoFrame:Hide()
		end
		return lines, sortedLines
	end
	openInfoFrame = function(self, spellName)
		DBM.InfoFrame:SetHeader(spellName)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false)
	end
end

local updateRangeFrame
do
	local function debuffFilter(uId)
		if DBM:UnitDebuff(uId, 262313, 262314) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if DBM:UnitDebuff("player", 262314) then
			DBM.RangeCheck:Show(12)--Actuall 10 but buffer used for good measure
		elseif DBM:UnitDebuff("player", 262313) then
			DBM.RangeCheck:Show(6)--Actually 4 but buffer used for good measure
		else
			DBM.RangeCheck:Show(6, debuffFilter)--Actually 4 but buffer used for good measure
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.stompCount = 0
	timerThrashCD:Start(5.7-delay)
	countdownThrash:Start(5.7-delay)
	if not self:IsEasy() then
		timerShockwaveStompCD:Start(26.1-delay, 1)
		timerRottingRegurgCD:Start(40-delay)
		countdownRottingRegurg:Start(40-delay)
	else
		timerRottingRegurgCD:Start(31.4-delay)
		countdownRottingRegurg:Start(31.4-delay)
	end
	timerAddsCD:Start(55-delay)--Until Attackable, not the chute visuals
	countdownAdds:Start(55-delay)
	timerPreAddsCD:Start(45, DBM_ADDS)
	if self:IsMythic() then
		updateRangeFrame(self)
		timerPreAddsCD:Start(35, DBM_BIG_ADD)
	end
	berserkTimer:Start()--Until rumor confirmed, use this berserk timer in all modes
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
		specWarnRottingRegurg:Play("breathsoon")
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
		self.vb.stompCount = self.vb.stompCount + 1
		specWarnShockwaveStomp:Show(self.vb.stompCount)
		specWarnShockwaveStomp:Play("carefly")
		timerShockwaveStompCD:Start(nil, self.vb.stompCount+1)
	elseif spellId == 262364 then--Enticing Essence
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			self:Unschedule(openInfoFrame)
			self:Schedule(2, openInfoFrame, self, args.spellName)--delayed because Boss Unit Ids don't exist right away on cast start
		end
		if self:AntiSpam(10, 2) then
			specWarnAdds:Show()
			specWarnAdds:Play("killmob")
			local timer = self:IsMythic() and 75 or self:IsEasy() and 60 or 54.8
			timerAddsCD:Start(timer)
			countdownAdds:Start(timer)
			timerPreAddsCD:Start(timer-10, DBM_ADDS)
			if self:IsMythic() then
				timerPreAddsCD:Start(timer-20, DBM_BIG_ADD)
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
			timerRottingRegurgCD:Update(elapsed, total)--Construct new timer with adjustment
			countdownRottingRegurg:Start(remaining)
		end
	elseif spellId == 274470 and self:AntiSpam(5, 3) then
		warnChuteVisual:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 262313 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount == 1 then
			if self:IsMythic() then
				yellMalodorousMiasma:Yell()
			end
			specWarnMalodorousMiasma:Show()
			specWarnMalodorousMiasma:Play("targetyou")
		elseif self:AntiSpam(2, 4) then
			specWarnMalodorousMiasmaStack:Show(amount)
			specWarnMalodorousMiasmaStack:Play("stackhigh")
		end
		if self:IsMythic() then
			yellMalodorousMiasmaFades:Cancel()
			yellMalodorousMiasmaFades:Countdown(18)
			updateRangeFrame(self)
		end
	elseif spellId == 262314 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount == 1 then
			if self:IsMythic() then
				yellPutridParoxysm:Yell()
			end
			specWarnPutridParoxysm:Show()
			specWarnPutridParoxysm:Play("defensive")
		else
			specWarnPutridParoxysmStack:Show(amount)
			specWarnPutridParoxysmStack:Play("stackhigh")
		end
		if self:IsMythic() then
			yellPutridParoxysmFades:Cancel()
			yellPutridParoxysmFades:Countdown(6)
			updateRangeFrame(self)
		end
	elseif spellId == 262378 then
		warnFrenzy:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 262313 or spellId == 262314) and args:IsPlayer() and self:IsMythic() then
		updateRangeFrame(self)
		if spellId == 262313 then
			yellMalodorousMiasmaFades:Cancel()
		else
			yellPutridParoxysmFades:Cancel()
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 262256 then
		local amount = args.amount or 0
		if amount == 1 then
			if self:IsTanking("player", "boss1", nil, true) then
				warnThrashNotTanking:Show()
			else
				specWarnThrash:Show()
				specWarnThrash:Play("defensive")
			end
		end
	end
end
