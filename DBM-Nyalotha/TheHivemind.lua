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
	"SPELL_CAST_SUCCESS 307213 307201 314583 307637 307232",
	"SPELL_AURA_APPLIED 307583 307637 313460",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 307583 307637",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, switch to https://ptr.wowhead.com/spell=308166/hivemind event being applied/removed if it's better
--TODO, nameplate aura if units too close or too far from one another
--TODO, switch control timers to start on cast of previous type when not using AI timers
--TODO, add spawn timers,when right script is found
--TODO, figure out if Accelerated Evolution and Volatile Eruption are on a shared timer (and which one is cast is based on who is in control)
--TODO, if https://ptr.wowhead.com/spell=313129/mindless applies to players, nameplate aura it
--TODO, GTFO shit on the ground
--local warnDesensitizingSting				= mod:NewStackAnnounce(298156, 2, nil, "Tank")
--local warnCallofTender					= mod:NewCountAnnounce(305057, 2)
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
local specWarnSpawnAcidicAqir				= mod:NewSpecialWarningDodge(310340, nil, nil, nil, 2, 2)
local specWarnMindNumbingNova				= mod:NewSpecialWarningInterruptCount(313652, "HasInterrupt", nil, nil, 1, 2)
--Tek'ris
local specWarnAcceleratedEvolution			= mod:NewSpecialWarningTargetChange(307637, nil, nil, nil, 1, 2)
local specWarnNullificationBlast			= mod:NewSpecialWarningDodge(307968, nil, nil, nil, 2, 2)
local specWarnEchoingVoid					= mod:NewSpecialWarningMoveAway(307232, nil, nil, nil, 2, 2)
local specWarnEtropicEhco					= mod:NewSpecialWarningDodge(313692, nil, nil, nil, 3, 2)--Mythic

--mod:AddTimerLine(BOSS)
--General
local timerTekrissHiveControlCD				= mod:NewAITimer(84, 307213, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerKazirsHiveControlCD				= mod:NewAITimer(84, 307201, nil, nil, nil, 6, nil, nil, nil, 1, 5)
--local timerAddsCD							= mod:NewAddsTimer(120, 31700, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Generic Timer
--Ka'zir
local timerVolatileEruptionCD				= mod:NewAITimer(84, 307583, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerSpawnAcidicAqirCD				= mod:NewAITimer(84, 310340, nil, nil, nil, 3)
local timerMindNumbingNovaCD				= mod:NewAITimer(7.3, 313652, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Tek'ris
local timerAcceleratedEvolutionCD			= mod:NewAITimer(84, 307637, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 307232)--While 4 yards is supported, we want wiggle room
--mod:AddInfoFrameOption(275270, true)
mod:AddSetIconOption("SetIconOnAdds", 307582, true, true, {1, 2, 3, 4, 5})
mod:AddNamePlateOption("NPAuraOnVolatileEruption", 307583)
mod:AddNamePlateOption("NPAuraOnAcceleratedEvolution", 307637)

mod.vb.interruptCount = 0
mod.vb.addIcon = 1

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.addIcon = 1
	timerTekrissHiveControlCD:Start(1-delay)
	timerKazirsHiveControlCD:Start(1-delay)
	--Ka'zir
	timerVolatileEruptionCD:Start(1-delay)
	timerSpawnAcidicAqirCD:Start(1-delay)
	timerMindNumbingNovaCD:Start(1-delay)
	--Tek'ris
	timerAcceleratedEvolutionCD:Start(1-delay)
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

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307569 then
		warnDarkRecon:Show()
	elseif spellId == 307213 then
		specWarnTekrissHiveControl:Show(L.Together)
		specWarnTekrissHiveControl:Play("phasechange")
	elseif spellId == 307201 then
		specWarnKazirsHiveControl:Show(L.Apart)
		specWarnKazirsHiveControl:Play("phasechange")
	elseif spellId == 310340 then
		specWarnSpawnAcidicAqir:Show()
		specWarnSpawnAcidicAqir:Play("watchstep")--or farfromline
		timerSpawnAcidicAqirCD:Start()
	elseif spellId == 313652 then
		timerMindNumbingNovaCD:Start()
		if self.vb.interruptCount == 3 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnMindNumbingNova:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			specWarnMindNumbingNova:Play("kick1r")
		elseif kickCount == 2 then
			specWarnMindNumbingNova:Play("kick2r")
		elseif kickCount == 3 then
			specWarnMindNumbingNova:Play("kick3r")
		end
	elseif spellId == 307968 then
		specWarnNullificationBlast:Show()
		specWarnNullificationBlast:Play("shockwave")
	elseif spellId == 307232 then
		specWarnEchoingVoid:Show()
		specWarnEchoingVoid:Play("scatter")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307213 then
		--SUCCESS object smarter for actual phase update code, in case boss casts can be interrupted/stutter casts
		timerTekrissHiveControlCD:Start()
	elseif spellId == 307201 then
		--SUCCESS object smarter for actual phase update code, in case boss casts can be interrupted/stutter casts
		timerKazirsHiveControlCD:Start()
	elseif spellId == 314583 then
		timerVolatileEruptionCD:Start()
	elseif spellId == 307637 then
		self.vb.addIcon = 1
		timerAcceleratedEvolutionCD:Start()
	elseif spellId == 307232 then
		if self:IsMythic() then
			specWarnEtropicEhco:Show()
			specWarnEtropicEhco:Play("watchstep")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
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

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157253 then--Ka'zir

	elseif cid == 157254 then--Tek'ris

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 307369 then--Lesser Aqir Dummy
		DBM:Debug("Lesser Aqir Dummy")
		--timerAddsCD:Start()
	elseif spellId == 308367 then--Aquir Drone Spawn Visuals
		DBM:Debug("Aquir Drone Spawn Visuals")
	elseif spellId == 300887 then--Aqir Pod
		DBM:Debug("Aqir Pod")
	end
end

