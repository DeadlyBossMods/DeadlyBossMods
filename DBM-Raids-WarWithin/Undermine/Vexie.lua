if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2639, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(225821)--Gear Grinder, 225822 Vexie
mod:SetEncounterID(3009)
mod:SetHotfixNoticeRev(20250122000000)
mod:SetMinSyncRevision(20250122000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 471403 459943 466040 466042 459671 468216 468487 459974 459627 460603 460173",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 466615 471500 1216788 466368 465865 460116 468216",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 466615 471500 460116 468216",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, possible infoframe for https://www.wowhead.com/ptr-2/spell=473507/soaked-in-oil on mythic difficulty
--TODO, find a way to auto mark bikes?
--TODO, nameplate timer for hotwheels using https://www.wowhead.com/ptr-2/spell=1217853/hot-wheels ? (15)
--TODO, see if the fire spell is NOT private on easier difficulties using https://www.wowhead.com/ptr-2/spell=468216/incendiary-fire
--TODO, detect bomb targets with target scan of 459974?
--TODO, oil slick GTFO?
--TODO, nameplate aura for passive https://www.wowhead.com/ptr-2/spell=473636/high-maintenance trait?
--TODO, timer correction for missed interrupts for Tune-Up
--TODO, nameplate timer for repair CD?
--TODO, add https://www.wowhead.com/ptr-2/spell=467776/jobs-done ?
--[[
(ability.id = 459943 or ability.id = 459671 or ability.id = 468487 or ability.id = 459627) and type = "begincast"
or ability.id = 459978 and type = "applydebuff"
or ability.id = 460603 and tyep = "begincast" or ability.id = 466615 and type = "applybuff"
--]]
--Stage One: Fury Road
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30093))
----The Geargrinder (main boss)
--local warnProtectivePlating						= mod:NewCountAnnounce(466615, 2)--Stacks of plating Remaining
local warnSpewOil									= mod:NewIncomingCountAnnounce(459666, 2)
local warnIncendiaryFire							= mod:NewIncomingCountAnnounce(468207, 2)

local specWarnUnrelentingcarnage					= mod:NewSpecialWarningSpell(471403, nil, nil, nil, 2, 2)
local specWarnCallbikers							= mod:NewSpecialWarningSwitchCount(459943, "Dps", nil, nil, 1, 2)
local specWarnBombVoyage							= mod:NewSpecialWarningDodgeCount(459974, nil, nil, nil, 2, 2)
local specWarnTankBuster							= mod:NewSpecialWarningDefensive(459627, nil, nil, nil, 1, 2)
local specWarnTankBusterTaunt						= mod:NewSpecialWarningTaunt(459627, nil, nil, nil, 1, 2)
local specWarnIncendiaryFire						= mod:NewSpecialWarningYou(468216, nil, nil, nil, 1, 12)--For non private version
local yellIncendiaryFire							= mod:NewShortYell(468216)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerUnrelentingcarnageCD						= mod:NewAITimer(97.3, 471403, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerCallbikersCD								= mod:NewCDCountTimer(28.1, 459943, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSpewOilCD								= mod:NewCDCountTimer(97.3, 459666, nil, nil, nil, 3)
local timerIncendiaryFireCD							= mod:NewCDCountTimer(35.3, 468207, nil, nil, nil, 3)
local timerBombVoyageCD								= mod:NewCDCountTimer(97.3, 459974, nil, nil, nil, 3)
local timerTankBusterCD								= mod:NewCDCountTimer(97.3, 459627, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(459669, true, 459666, 1)--Spew Oil
mod:AddPrivateAuraSoundOption(468486, true, 468207, 2)--Incendiary Fire (Mythic only?)
----Geargrinder Biker
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30118))
local warnBlazeofGlory								= mod:NewCastAnnounce(466040, 2)

local specWarnOilCanisterSoak						= mod:NewSpecialWarningSoakCount(1216731, nil, nil, nil, 2, 2, 4)
local specWarnCarryingOil							= mod:NewSpecialWarningYou(1216788, nil, nil, nil, 1, 2)
local specWarnHotWheels								= mod:NewSpecialWarningYou(466368, nil, nil, nil, 1, 2)
local yellHotWheels									= mod:NewShortYell(466368)
--Stage Two: Pit Stop
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30094))

local specWarnMechanicalBreakdown					= mod:NewSpecialWarningCount(460603, nil, nil, nil, 2, 2)
local specWarnRepair								= mod:NewSpecialWarningInterruptCount(460173, "HasInterrupt", nil, nil, 1, 2)

local timerTuneUp									= mod:NewCastTimer(45, 460116, nil, nil, nil, 6)

mod.vb.bikersCount = 0
mod.vb.soakCount = 0
mod.vb.spewOilCount = 0
mod.vb.fireCount = 0
mod.vb.bombCount = 0
mod.vb.tankBusterCount = 0
mod.vb.breakdownCount = 0
local castsPerGUID = {}
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		--Call Bikers
		[459943] = {20.7, 28.0, 35.4},
		--Spew Oil
		[459671] = {12.2, 21.9, 21.1, 20.3},
		--Incendiary Fire
		[468487] = {25.7, 31.0, 25.3},
		--Bomb Voyage
		[459974] = {5.0, 8.1, 7.9, 8.0, 8.1, 8.0, 7.9, 8.0, 8.0, 8.0},
		--Tank Buster
		[459627] = {6.4, 16.7, 17.1, 21.1, 20.3},
	},
	["heroic"] = {
		--Call Bikers
		[459943] = {20.7, 28.0, 35.4},
		--Spew Oil
		[459671] = {12.2, 21.9, 21.1, 20.3},
		--Incendiary Fire
		[468487] = {25.7, 31.0, 25.3},
		--Bomb Voyage
		[459974] = {5.0, 8.1, 7.9, 8.0, 8.1, 8.0, 7.9, 8.0, 8.0, 8.0},
		--Tank Buster
		[459627] = {6.4, 16.7, 17.1, 21.1, 20.3},
	},
	["normal"] = {
		--Call Bikers
		[459943] = {9.6, 17.2, 17.0, 20.7, 20.7},
		--Spew Oil
		[459671] = {15.8, 21.9, 20.6, 20.7, 20.7},
		--Incendiary Fire
		[468487] = {34.1, 35.3, 36.5},
		--Bomb Voyage
		[459974] = {7.6, 7.9, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0},
		--Tank Buster
		[459627] = {11.2, 17.1, 17.1, 20.7, 20.7},
	},
	--["lfr"] = {
	--	--Call Bikers
	--	[459943] = {},
	--	--Spew Oil
	--	[459671] = {},
	--	--Incendiary Fire
	--	[468216] = {},
	--	--Bomb Voyage
	--	[459974] = {},
	--	--Tank Buster
	--	[459627] = {},
	--},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.bikersCount = 0
	self.vb.soakCount = 0
	self.vb.spewOilCount = 0
	self.vb.fireCount = 0
	self.vb.bombCount = 0
	self.vb.tankBusterCount = 0
	self.vb.breakdownCount = 0
	table.wipe(castsPerGUID)
	self:EnablePrivateAuraSound(459669, "poolyou", 18)
	self:EnablePrivateAuraSound(468486, "flameyou", 12)
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerUnrelentingcarnageCD:Start(1-delay)--No Table
	timerCallbikersCD:Start(allTimers[savedDifficulty][459943][1]-delay, 1)
	timerSpewOilCD:Start(allTimers[savedDifficulty][459671][1]-delay, 1)
	timerIncendiaryFireCD:Start(allTimers[savedDifficulty][468216][1]-delay, 1)
	timerBombVoyageCD:Start(allTimers[savedDifficulty][459974][1]-delay, 1)
	timerTankBusterCD:Start(allTimers[savedDifficulty][459627][1]-delay, 1)
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 471403 then
		specWarnUnrelentingcarnage:Show()
		specWarnUnrelentingcarnage:Play("aesoon")
	elseif spellId == 459943 then
		self.vb.bikersCount = self.vb.bikersCount + 1
		specWarnCallbikers:Show(self.vb.bikersCount)
		specWarnCallbikers:Play("killmob")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.bikersCount+1)
		if timer then
			timerCallbikersCD:Start(timer, self.vb.bikersCount+1)
		end
	elseif spellId == 466040 or spellId == 466042 then
		warnBlazeofGlory:Show()
	elseif spellId == 459671 then
		self.vb.spewOilCount = self.vb.spewOilCount + 1
		warnSpewOil:Show(self.vb.spewOilCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.spewOilCount+1)
		if timer then
			timerSpewOilCD:Start(timer, self.vb.spewOilCount+1)
		end
	elseif (spellId == 468216 or spellId == 468487) then--468487 confirmed
		self.vb.fireCount = self.vb.fireCount + 1
		warnIncendiaryFire:Show(self.vb.fireCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, 468487, self.vb.fireCount+1)
		if timer then
			timerIncendiaryFireCD:Start(timer, self.vb.fireCount+1)
		end
	--elseif spellId == 459974 then
	--	self.vb.bombCount = self.vb.bombCount + 1
	--	specWarnBombVoyage:Show(self.vb.bombCount)
	--	specWarnBombVoyage:Play("watchstep")
	--	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.bombCount+1)
	--	if timer then
	--		timerBombVoyageCD:Start(timer, self.vb.bombCount+1)
	--	end
	elseif spellId == 459627 then
		self.vb.tankBusterCount = self.vb.tankBusterCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnTankBuster:Show()
			specWarnTankBuster:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.tankBusterCount+1)
		if timer then
			timerTankBusterCD:Start(timer, self.vb.tankBusterCount+1)
		end
	elseif spellId == 460173 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnRepair:Show(args.sourceName, count)
			if count < 6 then
				specWarnRepair:Play("kick"..tostring(count).."r")--"kick"..tostring(1).."r"
			else
				specWarnRepair:Play("kickcast")
			end
		end
	elseif spellId == 460603 then
		self.vb.breakdownCount = self.vb.breakdownCount + 1
		specWarnMechanicalBreakdown:Show(self.vb.breakdownCount)
		specWarnMechanicalBreakdown:Play("phasechange")--Maybe change to "watchstep"
		if self:GetStage(1) then
			self:SetStage(2)
			timerUnrelentingcarnageCD:Stop()
			timerCallbikersCD:Stop()
			timerSpewOilCD:Stop()
			timerIncendiaryFireCD:Stop()
			timerBombVoyageCD:Stop()
			timerTankBusterCD:Stop()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 468207  then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 466615 or spellId == 471500 then--Plating (remove the invalid ID later) (466615 confirmed valid)
		if self:GetStage(2) then
			self:SetStage(1)
			--Reset Counts
			self.vb.bikersCount = 0
			self.vb.soakCount = 0
			self.vb.spewOilCount = 0
			self.vb.fireCount = 0
			self.vb.bombCount = 0
			self.vb.tankBusterCount = 0
			--Restart stage 1 timers and end stage 2 timers
			timerUnrelentingcarnageCD:Start(2)--??
			timerBombVoyageCD:Start(5, 1)
			timerTankBusterCD:Start(6.3, 1)
			timerSpewOilCD:Start(12.4, 1)
			timerCallbikersCD:Start(20.5, 1)--20.5
			timerIncendiaryFireCD:Start(30.2, 1)
		end
	elseif spellId == 1216788 and args:IsPlayer() then
		specWarnCarryingOil:Show()
		specWarnCarryingOil:Play("targetyou")
	elseif spellId == 466368 then
		if args:IsPlayer() then
			specWarnHotWheels:Show()
			specWarnHotWheels:Play("chargemove")
			yellHotWheels:Yell()
		end
		--TODO, maybe add a warning for others too?
	elseif spellId == 465865 and not args:IsPlayer() then
		specWarnTankBusterTaunt:Show(args.destName)
		specWarnTankBusterTaunt:Play("tauntboss")
	elseif spellId == 460116 then
		timerTuneUp:Start()
	elseif spellId == 468216 and args:IsPlayer() then
		specWarnIncendiaryFire:Show()
		specWarnIncendiaryFire:Play("flameyou")
		yellIncendiaryFire:Yell()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 466615 or spellId == 471500 then--Plating (remove the invalid ID later) 466615 confirmed valid
		if self:GetStage(1) then
			self:SetStage(2)
			timerUnrelentingcarnageCD:Stop()
			timerCallbikersCD:Stop()
			timerSpewOilCD:Stop()
			timerIncendiaryFireCD:Stop()
			timerBombVoyageCD:Stop()
			timerTankBusterCD:Stop()
		end
	elseif spellId == 460116 then
		timerTuneUp:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 225804 then--Geargrinder Biker
		if self:IsMythic() then
			self.vb.soakCount = self.vb.soakCount + 1
			if not DBM:UnitDebuff("player", 473507) then
				specWarnOilCanisterSoak:Show(self.vb.soakCount)
				specWarnOilCanisterSoak:Play("helpsoak")
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 464841 then
		self.vb.bombCount = self.vb.bombCount + 1
		specWarnBombVoyage:Show(self.vb.bombCount)
		specWarnBombVoyage:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, 459974, self.vb.bombCount+1)
		if timer then
			timerBombVoyageCD:Start(timer, self.vb.bombCount+1)
		end
	end
end
