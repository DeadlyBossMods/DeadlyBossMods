local mod	= DBM:NewMod(2372, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157253, 157254)--Ka'zir and Tek'ris
mod:SetEncounterID(2333)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)--Refine when max number of mythic Volatile Eruption is known
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
mod:SetMinSyncRevision(20191109000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307569 307213 307201 310340 307968 307232 313652 307582",
	"SPELL_CAST_SUCCESS 308178 307232 312868 312710 307635 308360",
	"SPELL_AURA_APPLIED 307637 313460 307377 307227 313672",
	"SPELL_AURA_REMOVED 307637",
	"SPELL_PERIODIC_DAMAGE 313672",
	"SPELL_PERIODIC_MISSED 313672"
)

--TODO, nameplate aura if units too close or too far from one another?
--TODO, if https://ptr.wowhead.com/spell=313129/mindless applies to players, nameplate aura it
--TODO, lfr timers
--[[
(ability.id = 307569 or ability.id = 307213 or ability.id = 307201 or ability.id = 310340 or ability.id = 313652 or ability.id = 307968 or ability.id = 307232 or ability.id = 307582) and type = "begincast"
 or (ability.id = 308178 or ability.id = 307635 or ability.id = 307232 or ability.id = 312868 or ability.id = 312710) and type = "cast"
 or (ability.id = 307377 or ability.id = 307227) and type = "applybuff"
--]]
--General
local warnDarkRecon							= mod:NewCastAnnounce(307569, 4)
--Ka'zir
--Tek'ris
local warnNullification						= mod:NewTargetNoFilterAnnounce(313460, 4)--Might feel spammy in a mass fuckup situation, but in most cases on by default should be fine

--General
local specWarnTekrissHiveControl			= mod:NewSpecialWarningCount(307213, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(307213), nil, 2, 2)--Keep Together
local specWarnKazirsHiveControl				= mod:NewSpecialWarningCount(307201, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(307201), nil, 2, 2)--Keep Apart
local specWarnGTFO							= mod:NewSpecialWarningGTFO(313672, nil, nil, nil, 1, 8)
--Ka'zir
local specWarnVolatileEruption				= mod:NewSpecialWarningTargetChange(307583, nil, 155037, nil, 1, 2)
local specWarnSpawnAcidicAqir				= mod:NewSpecialWarningDodgeCount(310340, nil, nil, nil, 2, 2)
local specWarnMindNumbingNova				= mod:NewSpecialWarningInterruptCount(313652, "HasInterrupt", 242396, nil, 1, 2)
--Tek'ris
local specWarnAcceleratedEvolution			= mod:NewSpecialWarningTargetChange(307637, nil, 75610, nil, 1, 2)
local specWarnNullificationBlast			= mod:NewSpecialWarningDodgeCount(307968, nil, 158259, nil, 2, 2)
local specWarnEchoingVoid					= mod:NewSpecialWarningMoveAway(307232, nil, nil, nil, 2, 2)
local specWarnFixate						= mod:NewSpecialWarningYou(308360, false, nil, nil, 1, 2)
local specWarnEtropicEhco					= mod:NewSpecialWarningDodge(313692, nil, nil, nil, 3, 2)--Mythic

--General
local timerTekrissHiveControlCD				= mod:NewNextTimer(98.7, 307213, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerKazirsHiveControlCD				= mod:NewNextTimer(98.7, 307201, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerDarkReconCast					= mod:NewNextTimer(10, 307569, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON, nil, 3, 4)
--Ka'zir
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20710))
local timerVolatileEruptionCD				= mod:NewNextCountTimer(84, 307583, 155037, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerSpawnAcidicAqirCD				= mod:NewNextCountTimer(84, 310340, nil, nil, nil, 3)
local timerMindNumbingNovaCD				= mod:NewNextCountTimer(7.3, 313652, 242396, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerFlyerSwarmCD						= mod:NewNextCountTimer(120, 312710, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Tek'ris
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20713))
local timerAcceleratedEvolutionCD			= mod:NewNextCountTimer(84, 307637, 75610, nil, nil, 3, nil, DBM_CORE_TANK_ICON)
local timerNullificationBlastCD				= mod:NewNextCountTimer(84, 307968, 158259, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)
local timerEchoingVoidCD					= mod:NewNextCountTimer(84, 307232, nil, nil, nil, 2, nil, nil, nil, 3, 4)
local timerDronesCD							= mod:NewNextCountTimer(120, 312868, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 307232)--While 4 yards is supported, we want wiggle room
--mod:AddInfoFrameOption(308360, false)
mod:AddSetIconOption("SetIconOnAdds", 307637, true, true, {1, 2, 3, 4, 5, 6})
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
local seenAdds = {}
local allTimers = {
	["easy"] = {--(Heroic timers are just normal *0.9379 so I ported heroic timers back to normal by dividing them by 0.9379 and this checks out)
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {15.9, 16.0, 16.0, 20.0, 16.0, 23.3, 15.2, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 36.0, 16.0, 16.0, 16.0, 16.0, 23.9, 16.0, 17.3},
		----Spawn Acidic Aqir
		[310340] = {59.6, 69.3, 63.9, 66.6, 66.6, 66.6},
		----Volatile Eruption (SUCCESS)
		[308178] = {},--Not on Normal/LFR
		----Call Flyer Swarm (SUCCESS)
		[312710] = {67.6, 108.3, 98.3, 78.9},
		--Tek'ris
		----Nullification Blast
		[307968] = {28.0, 29.3, 25.2, 53.3, 26.6, 26.6, 27.9, 26.6, 26.6, 31.9, 26.6, 26.6, 26.6, 26.6, 26.6},
		----Accelerated Evolution (SUCCESS)
		[307635] = {},--Not on Normal/LFR
		----Echoing Void
		[307232] = {35.7, 70.6, 39.9, 77.3, 69.3, 73.3, 73.2},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {21.2, 92.4, 101.2, 96.2, 103.6}
	},
	["heroic"] = {--UPDATED on Live Jan 21
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {15.0, 14.9, 15.0, 18.8, 15.0, 21.9, 14.3, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 33.8, 15.0, 15.0, 15.0, 15.0, 22.5, 15.0, 16.3},
		----Spawn Acidic Aqir
		[310340] = {56.3, 65.0, 60.0, 62.5, 62.5, 62.5},
		----Volatile Eruption (SUCCESS)
		[308178] = {110.0, 185.1},
		----Call Flyer Swarm (SUCCESS)
		[312710] = {63, 101.5, 92.3, 73.9},
		--Tek'ris
		----Nullification Blast
		[307968] = {26.3, 27.5, 23.7, 50.0, 25.0, 25.0, 26.2, 25.0, 25.0, 30.0, 25.0, 25.0, 25.0, 25.0, 25.0},
		----Accelerated Evolution (SUCCESS)
		[307635] = {19.6, 181.2, 187.5},
		----Echoing Void
		[307232] = {33.8, 66.2, 37.5, 72.5, 65.0, 68.8, 68.7},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {20.2, 87.5, 93.9, 90.1, 97.2}
	},
	["mythic"] = {--Mythic timers are heroic * 0.8
		--Ka'zir
		----Mind-Numbing Nova
		[313652] = {12.0, 12.0, 12.0, 15.0, 12.0, 17.5, 11.5, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 27.0, 12.0, 12.0, 12.0, 12.0, 18.0, 12.0, 13.0},
		----Spawn Acidic Aqir
		[310340] = {45.0, 52.0, 48.0, 50.0, 50.0, 50.0},
		----Volatile Eruption (SUCCESS)
		[308178] = {88.5, 148.1},
		----Call Flyer Swarm (SUCCESS)
		[312710] = {50.4, 81.2, 73.8, 59.1},
		--Tek'ris
		----Nullification Blast
		[307968] = {22.1, 20.0, 20.0, 40.0, 20.0, 20.0, 21.0, 20.0, 20.0, 24.0, 20.0, 20.0, 20.0, 20.0, 20.0},
		----Accelerated Evolution (SUCCESS)
		[307635] = {15.7, 145.0, 150},
		----Echoing Void
		[307232] = {27.1, 53.0, 30.0, 58.0, 52.0, 55.0, 54.9},
		----Summon Drones Periodic (SUCCESS)
		[312868] = {16.1, 70, 75.1, 72, 77.7}
	},
}

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
	table.wipe(seenAdds)
	--Tek'ris's Hivemind Control instantly on pull
	if self:IsMythic() then
		self.vb.difficultyName = "mythic"
		--Ka'zir
		timerMindNumbingNovaCD:Start(12.1-delay, 1)
		timerSpawnAcidicAqirCD:Start(45.1-delay, 1)
		--timerFlyerSwarmCD:Start(59-delay, 1)
		timerVolatileEruptionCD:Start(88.6-delay, 1)
		--Tek'ris
		timerDronesCD:Start(16.1-delay, 1)
		timerAcceleratedEvolutionCD:Start(15.7-delay, 1)
		timerNullificationBlastCD:Start(22.1-delay, 1)
		timerEchoingVoidCD:Start(27.1-delay, 1)
	elseif self:IsHeroic() then
		self.vb.difficultyName = "heroic"
		--Ka'zir
		timerMindNumbingNovaCD:Start(15-delay, 1)
		timerSpawnAcidicAqirCD:Start(56.3-delay, 1)
		timerFlyerSwarmCD:Start(63-delay, 1)
		timerVolatileEruptionCD:Start(110-delay, 1)
		--Tek'ris
		timerDronesCD:Start(20.2-delay, 1)
		timerAcceleratedEvolutionCD:Start(19.6-delay, 1)
		timerNullificationBlastCD:Start(26.3-delay, 1)
		timerEchoingVoidCD:Start(33.8-delay, 1)
	else--Normal & LFR
		self.vb.difficultyName = "easy"
		--Copied from normal for now
		timerMindNumbingNovaCD:Start(15.9-delay, 1)
		timerSpawnAcidicAqirCD:Start(59.6-delay, 1)
		--timerVolatileEruptionCD:Start(111.9-delay, 1)--Never Seen in normal in journal
		timerFlyerSwarmCD:Start(67.6-delay, 1)
		--Tek'ris
		timerDronesCD:Start(21-delay, 1)
		timerNullificationBlastCD:Start(28-delay, 1)
		timerEchoingVoidCD:Start(35.7-delay, 1)
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
		timerDarkReconCast:Start()
	elseif spellId == 307213 then
		specWarnTekrissHiveControl:Show(L.Together)
		specWarnTekrissHiveControl:Play("phasechange")
		timerKazirsHiveControlCD:Start(self:IsMythic() and 73.9 or self:IsHeroic() and 92.4 or 98.7)
	elseif spellId == 307201 then
		specWarnKazirsHiveControl:Show(L.Apart)
		specWarnKazirsHiveControl:Play("phasechange")
		timerTekrissHiveControlCD:Start(self:IsMythic() and 73.9 or self:IsHeroic() and 92.4 or 98.7)
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
	elseif spellId == 307582 then
		specWarnVolatileEruption:Show(args.sourceName)
		specWarnVolatileEruption:Play("targetchange")
		if self.Options.NPAuraOnVolatileEruption then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 20)
		end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
		end
		self.vb.addIcon = self.vb.addIcon + 1
		if self.vb.addIcon == 7 then
			self.vb.addIcon = 1
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 308178 then
		--self.vb.addIcon = 1
		self.vb.VolatileEruptionCount = self.vb.VolatileEruptionCount + 1
		local timer = allTimers[self.vb.difficultyName][spellId][self.vb.VolatileEruptionCount+1]
		if timer then
			timerVolatileEruptionCD:Start(timer, self.vb.VolatileEruptionCount+1)
		end
	elseif spellId == 307635 then
		--self.vb.addIcon = 1
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
	elseif spellId == 308360 and args:IsPlayer() then
		specWarnFixate:Show()
		specWarnFixate:Play("targetyou")
	elseif spellId == 312868 then--Summon Drones Periodic
		DBM:Debug("Summon Drones Periodic is back in combat Log, tell MysticalOS")
		--self.vb.DronesCount = self.vb.DronesCount + 1
		--local timer = allTimers[self.vb.difficultyName][spellId][self.vb.DronesCount+1]
		--if timer then
		--	timerDronesCD:Start(timer, self.vb.DronesCount+1)
		--end
	elseif spellId == 312710 then--Call Flyer Swarm
		DBM:Debug("Call Flyer Swarm is back in combat Log, tell MysticalOS")
		--self.vb.FlyerSwarmCount = self.vb.FlyerSwarmCount + 1
		--local timer = allTimers[self.vb.difficultyName][spellId][self.vb.FlyerSwarmCount+1]
		--if timer then
		--	timerFlyerSwarmCD:Start(timer, self.vb.FlyerSwarmCount+1)
		--end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307637 then
		specWarnAcceleratedEvolution:CombinedShow(0.3, args.destName)
		specWarnAcceleratedEvolution:ScheduleVoice(0.3, "targetchange")
		if self.Options.NPAuraOnAcceleratedEvolution then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		--if self:AntiSpam(20, 1) then--TODO, better add icon reset location?
		--	self.vb.addIcon = 1
		--end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, 0.2, 12)
		end
		self.vb.addIcon = self.vb.addIcon + 1
		if self.vb.addIcon == 7 then
			self.vb.addIcon = 1
		end
	elseif spellId == 313460 then
		warnNullification:CombinedShow(0.5, args.destName)
	--Backup add detection because they removed the add scripts from combat log
	elseif (spellId == 307377 or spellId == 307227) and not seenAdds[args.destGUID] then--Void Infusion/Regeneration
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
		end
	elseif spellId == 313672 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 313672 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
