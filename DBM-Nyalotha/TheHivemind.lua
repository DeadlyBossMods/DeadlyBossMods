local mod	= DBM:NewMod(2372, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157253, 157254)--Ka'zir and Tek'ris
mod:SetEncounterID(2333)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5)--Refine when max number of mythic Volatile Eruption is known
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
mod:SetMinSyncRevision(20191109000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307569 307213 307201 310340 307968 307232 313652",
	"SPELL_CAST_SUCCESS 314583 307637 307232 312868 312710",
	"SPELL_AURA_APPLIED 307583 307637 313460",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 307583 307637"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, nameplate aura if units too close or too far from one another
--TODO, if https://ptr.wowhead.com/spell=313129/mindless applies to players, nameplate aura it
--TODO, GTFO shit on the ground
--TODO, warn for fixate (308360)?
--TODO, normal timers were RADICALLY different from heroic, to point that makes me think they probably changed up fight some. Heroic timers probably need redoing
--General
local warnDarkRecon							= mod:NewCastAnnounce(307569, 4)
--Ka'zir
--Tek'ris
local warnNullification						= mod:NewTargetNoFilterAnnounce(313460, 4)--Might feel spammy in a mass fuckup situation, but in most cases on by default should be fine

--General
local specWarnTekrissHiveControl			= mod:NewSpecialWarningCount(307213, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(307213), nil, 2, 2)--Keep Together
local specWarnKazirsHiveControl				= mod:NewSpecialWarningCount(307201, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(307201), nil, 2, 2)--Keep Apart
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--Ka'zir
local specWarnVolatileEruption				= mod:NewSpecialWarningTargetChange(307583, nil, nil, nil, 1, 2)
local specWarnSpawnAcidicAqir				= mod:NewSpecialWarningDodgeCount(310340, nil, nil, nil, 2, 2)
local specWarnMindNumbingNova				= mod:NewSpecialWarningInterruptCount(313652, "HasInterrupt", nil, nil, 1, 2)
--Tek'ris
local specWarnAcceleratedEvolution			= mod:NewSpecialWarningTargetChange(307637, nil, nil, nil, 1, 2)
local specWarnNullificationBlast			= mod:NewSpecialWarningDodgeCount(307968, nil, nil, nil, 2, 2)
local specWarnEchoingVoid					= mod:NewSpecialWarningMoveAway(307232, nil, nil, nil, 2, 2)
local specWarnEtropicEhco					= mod:NewSpecialWarningDodgeCount(313692, nil, nil, nil, 3, 2)--Mythic

--General
local timerTekrissHiveControlCD				= mod:NewNextTimer(69.6, 307213, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerKazirsHiveControlCD				= mod:NewNextTimer(69.6, 307201, nil, nil, nil, 6, nil, nil, nil, 1, 5)
--Ka'zir
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20710))
local timerVolatileEruptionCD				= mod:NewNextTimer(84, 307583, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerSpawnAcidicAqirCD				= mod:NewNextTimer(84, 310340, nil, nil, nil, 3)
local timerMindNumbingNovaCD				= mod:NewNextTimer(7.3, 313652, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerFlyerSwarmCD						= mod:NewNextTimer(120, 312710, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Tek'ris
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20713))
local timerAcceleratedEvolutionCD			= mod:NewNextTimer(84, 307637, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)
local timerNullificationBlastCD				= mod:NewNextTimer(84, 307968, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerEchoingVoidCD					= mod:NewNextTimer(84, 307232, nil, nil, nil, 2)
local timerDronesCD							= mod:NewNextTimer(120, 312868, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 307232)--While 4 yards is supported, we want wiggle room
--mod:AddInfoFrameOption(275270, true)
mod:AddSetIconOption("SetIconOnAdds", 307582, true, true, {1, 2, 3, 4, 5})
mod:AddNamePlateOption("NPAuraOnVolatileEruption", 307583)
mod:AddNamePlateOption("NPAuraOnAcceleratedEvolution", 307637)

mod.vb.interruptCount = 0
mod.vb.addIcon = 1
mod.vb.AccEvolutionCount = 0
mod.vb.FlyerSwarmCount = 0
mod.vb.EchoingVoidCount = 0
mod.vb.MindNumbingNovaCount = 0
mod.vb.NullificationBlastCount = 0
mod.vb.AcidicAqirCount = 0
mod.vb.DronesCount = 0
mod.vb.VolatileEruptionCount = 0
mod.vb.difficultyName = "None"
--local seenAdds = {}
--Timers (at least on heroic) have a point where you can just loop them, but since the loops don't match with other difficulties, it's a bit ugly to do
--Better to just hard code timers up until berserk as much as possible and not rely on loops that can change at any time
local allTimers = {
	["lfr"] = {
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {},
		----Spawn Acidic Aqir
		[310340] = {},
		----Volatile Eruption (SUCCESS)
		[314583] = {},
		----Call Flyer Swarm (SUCCESS)
		[312710] = {},
		--Tek'ris
		----Nullification Blast
		[307968] = {},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {},
		----Accelerated Evolution (SUCCESS)
		[307637] = {},
		----Echoing Void
		[307232] = {}
	},
	["normal"] = {--11-08-19 Timers
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {12.0, 12.0, 12.0, 15.0, 12.0, 17.5, 11.5, 12.0, 12.0, 11.9, 12.0, 12.0, 12.0, 12.0, 12.0, 11.9, 12.0, 27.0, 12.0, 12.0, 12.0, 12.0, 18.0, 12.0, 12.9},
		----Spawn Acidic Aqir
		[310340] = {45.0, 52.0, 48.0, 50.0, 50.1, 49.9},
		----Volatile Eruption (SUCCESS)
		[314583] = {},--Should exist on normal based on journal, but wasn't cast?
		----Call Flyer Swarm (SUCCESS)
		[312710] = {50.0, 70.1, 75.0, 60.0},
		--Tek'ris
		----Nullification Blast
		[307968] = {22.0, 20.0, 20.0, 40.0, 20.0, 20.0, 21.0, 20.0, 19.9, 24.0, 20.0, 20.0, 20.0, 19.9, 20.0},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {15.0, 70.0, 75.1, 73.0, 77.1},
		----Accelerated Evolution (SUCCESS)
		[307637] = {},--Don't exist on Normal
		----Echoing Void
		[307232] = {80.1, 30.0, 58.1, 52.0, 55.0}
	},
	["heroic"] = {--10-26-19 Timers
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {9.8, 50.1, 39.9, 45.0, 45.3, 100.2, 50.2, 39.8, 45.0, 45.0},
		----Spawn Acidic Aqir
		[310340] = {14.9, 30.1, 39.8, 20.0, 25.2, 34.8, 30.0, 100.5, 29.9, 40.1, 20.0, 24.8, 35.2, 29.9},
		----Volatile Eruption (SUCCESS)
		[314583] = {111.9, 108.5, 172.0},
		----Call Flyer Swarm (SUCCESS)
		[312710] = {121.9, 37.9, 95.0, 147.5, 38.1},
		--Tek'ris
		----Nullification Blast
		[307968] = {26.9, 28.0, 44.9, 25.0, 25.0, 32.0, 17.9, 25.0, 82.5, 28.2, 44.9, 25.0, 25.0, 32.1, 17.9},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {34.9, 76.5, 108.5, 95.4, 76.5},
		----Accelerated Evolution (SUCCESS)
		[307637] = {36.0, 280.3},
		----Echoing Void
		[307232] = {63.9, 16.0, 39.9, 45.0, 95.0, 84.5, 16.0, 40.0, 45.2}
	},
	["mythic"] = {
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {12.0, 12.0, 12.0, 15.0, 12.0, 17.5, 11.5, 12.0, 12.0, 11.9, 12.0, 12.0, 12.0, 12.0, 12.0, 11.9, 12.0, 27.0, 12.0, 12.0, 12.0, 12.0, 18.0, 12.0, 12.9},
		----Spawn Acidic Aqir
		[310340] = {45.0, 52.0, 48.0, 50.0, 50.1, 49.9},
		----Volatile Eruption (SUCCESS)
		[314583] = {},--Should exist on normal based on journal, but wasn't cast?
		----Call Flyer Swarm (SUCCESS)
		[312710] = {50.0, 70.1, 75.0, 60.0},
		--Tek'ris
		----Nullification Blast
		[307968] = {22.0, 20.0, 20.0, 40.0, 20.0, 20.0, 21.0, 20.0, 19.9, 24.0, 20.0, 20.0, 20.0, 19.9, 20.0},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {15.0, 70.0, 75.1, 73.0, 77.1},
		----Accelerated Evolution (SUCCESS)
		[307637] = {},--Don't exist on Normal
		----Echoing Void
		[307232] = {80.1, 30.0, 58.1, 52.0, 55.0}
	},
}

--/run DBM:GetModByName("2372"):SetMythicTimersToHeroic()
function mod:SetMythicTimersToHeroic()
	allTimers["mythic"] = allTimers["heroic"]
end
--/run DBM:GetModByName("2372"):SetMythicTimersToNormal()
function mod:SetMythicTimersToNormal()
	allTimers["mythic"] = allTimers["normal"]
end

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.addIcon = 1
	self.vb.AccEvolutionCount = 0
	self.vb.FlyerSwarmCount = 0
	self.vb.EchoingVoidCount = 0
	self.vb.MindNumbingNovaCount = 0
	self.vb.NullificationBlastCount = 0
	self.vb.AcidicAqirCount = 0
	self.vb.DronesCount = 0
	self.vb.VolatileEruptionCount = 0
	--table.wipe(seenAdds)
	--Tek'ris's Hivemind Control instantly on pull
	if self:IsMythic() then
		self.vb.difficultyName = "mythic"
	elseif self:IsHeroic() then
		self.vb.difficultyName = "heroic"
		--Ka'zir
		timerMindNumbingNovaCD:Start(9.8-delay, 1)
		timerSpawnAcidicAqirCD:Start(14.9-delay, 1)
		timerVolatileEruptionCD:Start(111.9-delay, 1)
		timerFlyerSwarmCD:Start(121.9-delay, 1)
		--Tek'ris
		timerNullificationBlastCD:Start(26.9-delay, 1)
		timerDronesCD:Start(34.9-delay, 1)
		timerAcceleratedEvolutionCD:Start(36-delay, 1)
		timerEchoingVoidCD:Start(63.9-delay, 1)
	elseif self:IsNormal() then
		self.vb.difficultyName = "normal"
		timerMindNumbingNovaCD:Start(12-delay, 1)
		timerSpawnAcidicAqirCD:Start(45-delay, 1)
		--timerVolatileEruptionCD:Start(111.9-delay, 1)--Never Seen but in journal
		timerFlyerSwarmCD:Start(50-delay, 1)
		--Tek'ris
		timerDronesCD:Start(15-delay, 1)
		timerNullificationBlastCD:Start(22-delay, 1)
		timerEchoingVoidCD:Start(80.1-delay, 1)
	else--LFR
		self.vb.difficultyName = "lfr"
	end
	if self.Options.NPAuraOnVolatileEruption or self.Options.NPAuraOnAcceleratedEvolution then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnVolatileEruption or self.Options.NPAuraOnAcceleratedEvolution then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307569 then
		warnDarkRecon:Show()
	elseif spellId == 307213 then
		specWarnTekrissHiveControl:Show(L.Together)
		specWarnTekrissHiveControl:Play("phasechange")
		timerKazirsHiveControlCD:Start(self:IsHard() and 69.6 or 74.1)
		timerFlyerSwarmCD:SetFade(true)
		timerDronesCD:SetFade(false)
	elseif spellId == 307201 then
		specWarnKazirsHiveControl:Show(L.Apart)
		specWarnKazirsHiveControl:Play("phasechange")
		timerTekrissHiveControlCD:Start(self:IsHard() and 69.6 or 74.1)
		timerFlyerSwarmCD:SetFade(false)
		timerDronesCD:SetFade(true)
	elseif spellId == 310340 then
		self.vb.AcidicAqirCount = self.vb.AcidicAqirCount + 1
		specWarnSpawnAcidicAqir:Show(self.vb.AcidicAqirCount)
		specWarnSpawnAcidicAqir:Play("watchstep")--or farfromline
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.AcidicAqirCount+1]
		if timer then
			timerSpawnAcidicAqirCD:Start(timer, self.vb.AcidicAqirCount+1)
		end
	elseif spellId == 313652 then
		self.vb.MindNumbingNovaCount = self.vb.MindNumbingNovaCount + 1
		specWarnMindNumbingNova:Show(args.sourceName, self.vb.MindNumbingNovaCount)
		specWarnMindNumbingNova:Play("kickcast")
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.MindNumbingNovaCount+1]
		if timer then
			timerMindNumbingNovaCD:Start(timer, self.vb.MindNumbingNovaCount+1)
		end
	elseif spellId == 307968 then
		self.vb.NullificationBlastCount = self.vb.NullificationBlastCount + 1
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnNullificationBlast:Show(self.vb.NullificationBlastCount)--So show tank warning
				specWarnNullificationBlast:Play("shockwave")
				break
			end
		end
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.NullificationBlastCount+1]
		if timer then
			timerNullificationBlastCD:Start(timer, self.vb.NullificationBlastCount+1)
		end
	elseif spellId == 307232 then
		self.vb.EchoingVoidCount = self.vb.EchoingVoidCount + 1
		specWarnEchoingVoid:Show(self.vb.EchoingVoidCount)
		specWarnEchoingVoid:Play("scatter")
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.EchoingVoidCount+1]
		if timer then
			timerEchoingVoidCD:Start(timer, self.vb.EchoingVoidCount+1)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314583 then
		self.vb.VolatileEruptionCount = self.vb.VolatileEruptionCount + 1
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.VolatileEruptionCount+1]
		if timer then
			timerVolatileEruptionCD:Start(timer, self.vb.VolatileEruptionCount+1)
		end
	elseif spellId == 307637 then
		self.vb.addIcon = 1
		self.vb.AccEvolutionCount = self.vb.AccEvolutionCount + 1
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.AccEvolutionCount+1]
		if timer then
			timerAcceleratedEvolutionCD:Start(timer, self.vb.AccEvolutionCount+1)
		end
	elseif spellId == 307232 then
		if self:IsMythic() then
			specWarnEtropicEhco:Show()
			specWarnEtropicEhco:Play("watchstep")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 312868 then--Summon Drones Periodic
		self.vb.DronesCount = self.vb.DronesCount + 1
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.DronesCount+1]
		if timer then
			timerDronesCD:Start(timer, self.vb.DronesCount+1)
		end
	elseif spellId == 312710 then--Call Flyer Swarm
		self.vb.FlyerSwarmCount = self.vb.FlyerSwarmCount + 1
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.FlyerSwarmCount+1]
		if timer then
			timerFlyerSwarmCD:Start(timer, self.vb.FlyerSwarmCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307583 then
		specWarnVolatileEruption:Show(args.destName)
		specWarnVolatileEruption:Play("targetchange")
		if self.Options.NPAuraOnVolatileEruption then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 20)
		end
	elseif spellId == 307637 then
		specWarnAcceleratedEvolution:CombinedShow(0.3, args.destName)
		specWarnAcceleratedEvolution:ScheduleVoice(0.3, "targetchange")
		if self.Options.NPAuraOnAcceleratedEvolution then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		if self:AntiSpam(20, 1) then--TODO, better add icon reset location?
			self.vb.addIcon = 1
		end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, 0.2, 12)
		end
		self.vb.addIcon = self.vb.addIcon + 1
	elseif spellId == 313460 then
		warnNullification:CombinedShow(0.5, args.destName)
	--Backup add detection in case they remove the add scripts from combat log
	--[[elseif (spellId == 307377 or spellId == 307227) and not seenAdds[args.destGUID] then--Void Infusion/Regeneration
		seenAdds[args.destGUID] = true
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 157256 and self:AntiSpam(10, 10) then--Aqir Darter
			self.vb.FlyerSwarmCount = self.vb.FlyerSwarmCount + 1
			local timer = allTimers[self.vb.difficultyName][312710][self.vb.FlyerSwarmCount+1]
			if timer then
				timerFlyerSwarmCD:Start(timer, self.vb.FlyerSwarmCount+1)
			end
		elseif cid == 157255 and self:AntiSpam(10, 11) then--Aqir Drone
			self.vb.DronesCount = self.vb.DronesCount + 1
			local timer = allTimers[self.vb.difficultyName][312868][self.vb.DronesCount+1]
			if timer then
				timerDronesCD:Start(timer, self.vb.DronesCount+1)
			end
		end--]]
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 307583 then
		if self.Options.NPAuraOnVolatileEruption then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 307637 then
		if self.Options.NPAuraOnAcceleratedEvolution then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
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
	if cid == 157253 then--Ka'zir

	elseif cid == 157254 then--Tek'ris

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 307369 then

	end
end
--]]
