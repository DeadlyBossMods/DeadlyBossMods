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
	"SPELL_PERIODIC_DAMAGE 459683",
	"SPELL_PERIODIC_MISSED 459683",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, possible infoframe for https://www.wowhead.com/ptr-2/spell=473507/soaked-in-oil on mythic difficulty
--TODO, find a way to auto mark bikes?
--TODO, nameplate timer for hotwheels using https://www.wowhead.com/ptr-2/spell=1217853/hot-wheels ? (15)
--TODO, detect bomb targets with target scan of 459974?
--TODO, nameplate aura for passive https://www.wowhead.com/ptr-2/spell=473636/high-maintenance trait?
--TODO, timer correction for missed interrupts for Tune-Up
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
local warnSpewOil									= mod:NewIncomingCountAnnounce(459678, 2)
local warnIncendiaryFire							= mod:NewIncomingCountAnnounce(468207, 2)

local specWarnUnrelentingcarnage					= mod:NewSpecialWarningSpell(471403, nil, nil, nil, 2, 2)
local specWarnCallbikers							= mod:NewSpecialWarningSwitchCount(459943, "Dps", nil, nil, 1, 2)
local specWarnBombVoyage							= mod:NewSpecialWarningDodgeCount(459978, false, nil, 2, 2, 2)--evert 8 seconds (4 on mythic) so off by default
local specWarnTankBuster							= mod:NewSpecialWarningDefensive(465865, nil, nil, nil, 1, 2)
local specWarnTankBusterTaunt						= mod:NewSpecialWarningTaunt(465865, nil, nil, nil, 1, 2)
local specWarnIncendiaryFire						= mod:NewSpecialWarningYou(468216, nil, nil, nil, 1, 12)--For some reason, blizzard gave a spell that has a 6 second pre debuff, an additional 4 second pre pre debuff private aura
local yellIncendiaryFire							= mod:NewShortYell(468216)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(459683, nil, nil, nil, 1, 8)

local timerUnrelentingcarnageCD						= mod:NewCDCountTimer(97.3, 471403, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerCallbikersCD								= mod:NewCDCountTimer(28.1, 459943, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSpewOilCD								= mod:NewCDCountTimer(97.3, 459678, nil, nil, nil, 3)
local timerIncendiaryFireCD							= mod:NewCDCountTimer(35.3, 468207, nil, nil, nil, 3)
local timerTankBusterCD								= mod:NewCDCountTimer(97.3, 465865, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(459669, true, 459678, 1)--Spew Oil
mod:AddPrivateAuraSoundOption(468486, true, 468207, 2)--Incendiary Fire--For some reason, blizzard gave a spell that has a 6 second pre debuff, an additional 4 second pre pre debuff private aura
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
	timerTankBusterCD:Start(6-delay, 1)
	timerSpewOilCD:Start(12.2-delay, 1)
	timerCallbikersCD:Start(20.2-delay, 1)
	timerIncendiaryFireCD:Start((self:IsHard() and 25.1 or 30.6)-delay, 1)
	if self:IsMythic() then
		timerUnrelentingcarnageCD:Start(121.6, 1)--Only difficulty observed on
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
		timerCallbikersCD:Start("v28-36.4", self.vb.bikersCount+1)
	elseif spellId == 466040 or spellId == 466042 then
		warnBlazeofGlory:Show()
	elseif spellId == 459671 then
		self.vb.spewOilCount = self.vb.spewOilCount + 1
		warnSpewOil:Show(self.vb.spewOilCount)
		--Mythic and Heroic need special handling for very first stage
		--Other difficulties don't seem to have that special case
		--"Spew Oil-459671-npc:225821-0000129545 = pull:12.1, 37.8, 37.7, Stage 2/36.7, Stage 1/49.7, 15.8/65.5/102.2, 21.8, 20.7, 20.7, 20.6, Stage 2/19.5, Stage 1/49.8, 15.7/65.5/85.0, 21.9, 20.6, 20.7, 20.7, 20.6",
		if self.vb.stageTotality == 1 then
			timerSpewOilCD:Start("v37.1-38.6", self.vb.spewOilCount+1)
		else
			timerSpewOilCD:Start("v20.6-23.2", self.vb.spewOilCount+1)
		end
	elseif (spellId == 468216 or spellId == 468487) then--468487 confirmed
		self.vb.fireCount = self.vb.fireCount + 1
		warnIncendiaryFire:Show(self.vb.fireCount)
		if self.vb.stageTotality == 1 then
			timerIncendiaryFireCD:Start("v25.3-36.5", self.vb.fireCount+1)
		else
			timerIncendiaryFireCD:Start("v35.3-36.7", self.vb.fireCount+1)
		end
	--elseif spellId == 459974 then
	--	self.vb.bombCount = self.vb.bombCount + 1
	--	specWarnBombVoyage:Show(self.vb.bombCount)
	--	specWarnBombVoyage:Play("watchstep")
	elseif spellId == 459627 then
		self.vb.tankBusterCount = self.vb.tankBusterCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnTankBuster:Show()
			specWarnTankBuster:Play("defensive")
		end
		--"Tank Buster-459627-npc:225821-0000129545 = pull:6.0, 23.2, 30.4, 25.5, 22.0, Stage 2/17.2, Stage 1/49.7, 9.8/59.4/76.6, 17.0, 17.0, 20.8, 21.7, 23.1, Stage 2/9.8, Stage 1/49.8, 9.6/59.4/69.2, 17.0, 17.0, 20.7, 20.6, 24.3",
		local timer
		--Seems to get spell queued more often on heroic and mythic
		if self:IsHard() then
			timer = self.vb.stageTotality == 1 and "v21.9-30.4" or "v16.7-24.4"
		else
			timer = self.vb.stageTotality == 1 and "v16.7-21.1" or "v17.0-20.7"
		end
		timerTankBusterCD:Start(timer, self.vb.tankBusterCount+1)
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
		--if self:GetStage(2) then--backup trigger that's slower
		--	self:SetStage(1)
		--	--Reset Counts
		--	self.vb.bikersCount = 0
		--	self.vb.soakCount = 0
		--	self.vb.spewOilCount = 0
		--	self.vb.fireCount = 0
		--	self.vb.bombCount = 0
		--	self.vb.tankBusterCount = 0
		--	--Restart stage 1 timers and end stage 2 timers
		--	--Same timers as initial stage, minus 3.5
		--	timerCallbikersCD:Start(allTimers[savedDifficulty][459943][1] - 3.5, 1)
		--	timerSpewOilCD:Start(allTimers[savedDifficulty][459671][1] - 3.5, 1)
		--	timerIncendiaryFireCD:Start(allTimers[savedDifficulty][468487][1] - 3.5, 1)
		--	timerTankBusterCD:Start(allTimers[savedDifficulty][459627][1] - 3.5, 1)
		--	timerUnrelentingcarnageCD:Start(allTimers[savedDifficulty][471403][1] - 3.5, 1)
		--end
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
			timerTankBusterCD:Stop()
		end
	elseif spellId == 460116 then
		timerTuneUp:Stop()
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
			--Same timers as initial stage, minus 3.5
			timerTankBusterCD:Start(6, 1)
			timerSpewOilCD:Start(12.2, 1)
			timerCallbikersCD:Start(20.7, 1)
			timerIncendiaryFireCD:Start(self:IsHard() and 25.5 or 30.6, 1)
			if self:IsMythic() then
				timerUnrelentingcarnageCD:Start(121.6, 1)--Only difficulty observed on
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459683 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

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
	end
end
