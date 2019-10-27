local mod	= DBM:NewMod(2372, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157253, 157254)--Ka'zir and Tek'ris
mod:SetEncounterID(2333)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5)--Refine when max number of mythic Volatile Eruption is known
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307569 307213 307201 310340 307968 307232",
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

--mod:AddTimerLine(BOSS)
--General
local timerTekrissHiveControlCD				= mod:NewNextTimer(69.6, 307213, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerKazirsHiveControlCD				= mod:NewNextTimer(69.6, 307201, nil, nil, nil, 6, nil, nil, nil, 1, 5)--69.6-70.5
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

--Timers on this fight are most accurate when sequenced out completely
--Each sequence has a loop that repeats, with exception of initial times, which are shorter than first number of all other loops
--4 out of 8 loops known, remaining 4 need more data and as such are just using known data thus far as hard coded squence with an end
local heroicTimers = {
	--Ka'zir
	--Mind-Numbing Nova
	--[313652] = {9.8, 50.1, 39.9, 45.0, 45.3, 100.2, 50.2, 39.8, 45.0, 45.0},--Real Heroic Data
	[313652] = {100.2, 50.2, 39.8, 45.0, 45.0},--Surmised Loop sequence
	--Spawn Acidic Aqir
	--[310340] = {14.9, 30.1, 39.8, 20.0, 25.2, 34.8, 30.0, 100.5, 29.9, 40.1, 20.0, 24.8, 35.2, 29.9},--Real Heroic Data
	[310340] = {100.5, 29.9, 39.8, 20.0, 24.8, 34.8, 29.9},--Surmised Loop sequence
	--Volatile Eruption (more data required to build a loop)
	[308178] = {111.9, 108.5, 172.0},
	--Call Flyer Swarm (more data required, but loop probably present with 147.5, 37.9, 95.0)
	[312710] = {121.9, 37.9, 95.0, 147.5, 38.1},
	--Tek'ris
	--Nullification Blast (loop present with 82.5, 28.0, 44.9, 25.0, 25.0, 32.0, 17.9, 25.0)
	--[307968] = {26.9, 28.0, 44.9, 25.0, 25.0, 32.0, 17.9, 25.0, 82.5, 28.2, 44.9, 25.0, 25.0, 32.1, 17.9},--Real Heroic Data
	[307968] = {82.5, 28.0, 44.9, 25.0, 25.0, 32.0, 17.9, 25.0},--Surmised Loop sequence
	--Summon Drones Periodic (more data required, but loop probably present with 95.4, 76.5, 108.5)
	[312868] = {34.9, 76.5, 108.5, 95.4, 76.5},
	--Accelerated Evolution (more data required)
	[308227] = {36.0, 280.3},
	--Echoing Void (loop present with 84.5, 16.0, 39.9, 45.0, 95.0)
	--[307232] = {63.9, 16.0, 39.9, 45.0, 95.0, 84.5, 16.0, 40.0, 45.2},--Real Heroic Data
	[307232] = {84.5, 16.0, 39.9, 45.0, 95.0},--Surmised Loop sequence
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
	--Tek'ris's Hivemind Control instantly on pull
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
		timerKazirsHiveControlCD:Start()
		timerFlyerSwarmCD:SetFade(true)
		timerDronesCD:SetFade(false)
	elseif spellId == 307201 then
		specWarnKazirsHiveControl:Show(L.Apart)
		specWarnKazirsHiveControl:Play("phasechange")
		timerTekrissHiveControlCD:Start()
		timerFlyerSwarmCD:SetFade(false)
		timerDronesCD:SetFade(true)
	elseif spellId == 310340 then
		self.vb.AcidicAqirCount = self.vb.AcidicAqirCount + 1
		specWarnSpawnAcidicAqir:Show(self.vb.AcidicAqirCount)
		specWarnSpawnAcidicAqir:Play("watchstep")--or farfromline
		local loop = (self.vb.AcidicAqirCount+1) % 7
		if loop == 0 then loop = 7 end
		local timer = heroicTimers[spellId][loop]
		if timer then
			timerSpawnAcidicAqirCD:Start(timer, self.vb.AcidicAqirCount+1)
		end
	elseif spellId == 313652 then
		self.vb.MindNumbingNovaCount = self.vb.MindNumbingNovaCount + 1
		specWarnMindNumbingNova:Show(args.sourceName, self.vb.MindNumbingNovaCount)
		specWarnMindNumbingNova:Play("kickcast")
		local loop = (self.vb.MindNumbingNovaCount+1) % 5
		if loop == 0 then loop = 5 end
		local timer = heroicTimers[spellId][loop]
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
		local loop = (self.vb.NullificationBlastCount+1) % 8
		if loop == 0 then loop = 8 end
		local timer = heroicTimers[spellId][loop]
		if timer then
			timerNullificationBlastCD:Start(timer, self.vb.NullificationBlastCount+1)
		end
	elseif spellId == 307232 then
		self.vb.EchoingVoidCount = self.vb.EchoingVoidCount + 1
		specWarnEchoingVoid:Show(self.vb.EchoingVoidCount)
		specWarnEchoingVoid:Play("scatter")
		local loop = (self.vb.EchoingVoidCount+1) % 5
		if loop == 0 then loop = 5 end
		local timer = heroicTimers[spellId][loop]
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
		local timer = heroicTimers[spellId][self.vb.VolatileEruptionCount+1]
		if timer then
			timerVolatileEruptionCD:Start(timer, self.vb.VolatileEruptionCount+1)
		end
	elseif spellId == 307637 then
		self.vb.addIcon = 1
		self.vb.AccEvolutionCount = self.vb.AccEvolutionCount + 1
		local timer = heroicTimers[spellId][self.vb.AccEvolutionCount+1]
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
		local timer = heroicTimers[spellId][self.vb.DronesCount+1]
		if timer then
			timerDronesCD:Start(timer, self.vb.DronesCount+1)
		end
	elseif spellId == 312710 then--Call Flyer Swarm
		self.vb.FlyerSwarmCount = self.vb.FlyerSwarmCount + 1
		local timer = heroicTimers[spellId][self.vb.FlyerSwarmCount+1]
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
