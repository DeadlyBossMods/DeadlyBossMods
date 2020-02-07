local mod	= DBM:NewMod(2169, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134445)--Zek'vhozj, 134503/qiraji-warrior
mod:SetEncounterID(2136)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 6, 7, 8)
mod:SetHotfixNoticeRev(17776)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 264382 265358 267180 267239 270620 265231 265530",
	"SPELL_CAST_SUCCESS 264382 271099 181089",
	"SPELL_AURA_APPLIED 265264 265360 265662 265646 265237",
	"SPELL_AURA_APPLIED_DOSE 265264",
	"SPELL_AURA_REMOVED 265360 265662",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, icons for Roiling Deceit?
--[[
(ability.id = 267239 or ability.id = 265231 or ability.id = 265530 or ability.id = 264382 or ability.id = 265358) and type = "begincast"
 or (ability.id = 181089 or ability.id = 271099) and type = "cast"
 or ability.id = 265360 and type = "applydebuff"
 or (ability.id = 267180 or ability.id = 270620) and type = "begincast"
--]]
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnVoidLash						= mod:NewStackAnnounce(265264, 2, nil, "Tank")
--Stage One: Chaos
local warnEyeBeam						= mod:NewTargetCountAnnounce(264382, 2, nil, nil, nil, nil, nil, nil, true)
--Stage Two: Deception
local warnRoilingDeceit					= mod:NewTargetCountAnnounce(265360, 4, nil, nil, nil, nil, nil, nil, true)
local warnCasterAddsRemaining			= mod:NewAddsLeftAnnounce("ej18397", 2, 31700)
--Stage Three: Corruption
local warnCorruptorsPact				= mod:NewTargetCountAnnounce(265662, 2, nil, nil, nil, nil, nil, nil, true)--Non Filtered Alert
local warnWillofCorruptor				= mod:NewTargetAnnounce(265646, 4, nil, false)

--General
local specWarnSurgingDarkness			= mod:NewSpecialWarningDodge(265451, nil, nil, nil, 3, 2)
local specWarnMightofVoid				= mod:NewSpecialWarningDefensive(267312, nil, nil, nil, 1, 2)
local specWarnShatter					= mod:NewSpecialWarningTaunt(265237, nil, nil, nil, 1, 2)
local specWarnAdds						= mod:NewSpecialWarningAdds(31700, nil, nil, nil, 1, 2, 4)--Generic Warning only used on Mythic
--Stage One: Chaos
local specWarnEyeBeamSoon				= mod:NewSpecialWarningSoon(264382, nil, nil, nil, 1, 2)
local specWarnEyeBeam					= mod:NewSpecialWarningMoveAwayCount(264382, nil, nil, 2, 3, 2)
local yellEyeBeam						= mod:NewCountYell(264382)
--Stage Two: Deception
local specWarnRoilingDeceit				= mod:NewSpecialWarningMoveTo(265360, nil, nil, nil, 3, 7)
local yellRoilingDeceit					= mod:NewCountYell(265360)
local yellRoilingDeceitFades			= mod:NewFadesYell(265360)
local specWarnVoidbolt					= mod:NewSpecialWarningInterrupt(267180, "HasInterrupt", nil, nil, 1, 2)
--Stage Three: Corruption
local specWarnOrbOfCorruption			= mod:NewSpecialWarningCount(267239, nil, nil, nil, 2, 7)
local yellCorruptorsPact				= mod:NewFadesYell(265662)
local specWarnWillofCorruptorSoon		= mod:NewSpecialWarningSoon(265646, nil, nil, nil, 3, 2)
local specWarnWillofCorruptor			= mod:NewSpecialWarningSwitch(265646, "Dps", nil, 2, 1, 2)
local specWarnEntropicBlast				= mod:NewSpecialWarningInterrupt(270620, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(GENERAL)
local timerSurgingDarknessCD			= mod:NewCDTimer(82.8, 265451, nil, "Melee", nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 3)--60 based on energy math
local timerMightofVoidCD				= mod:NewCDTimer(37.6, 267312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerTitanSparkCD					= mod:NewCDTimer(37.6, 264954, nil, "Healer", nil, 2)
local timerAddsCD						= mod:NewAddsTimer(120, 31700, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Generic Timer only used on Mythic
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerQirajiWarriorCD				= mod:NewCDTimer(60, "ej18071", nil, nil, nil, 1, 31700)--UNKNOWN, TODO
local timerEyeBeamCD					= mod:NewCDTimer(40, 264382, nil, nil, nil, 3, nil, nil, nil, not mod:IsTank() and 3, 5)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerAnubarCasterCD				= mod:NewCDTimer(80, "ej18397", nil, nil, nil, 1, 31700)--82
local timerRoilingDeceitCD				= mod:NewCDTimer(45, 265360, nil, nil, nil, 3)--61
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerOrbofCorruptionCD			= mod:NewCDCountTimer(50, 267239, nil, nil, nil, 5)
local timerOrbLands						= mod:NewTimer(45, "timerOrbLands", 267239, nil, nil, 5)--61

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 264382)
mod:AddBoolOption("EarlyTankSwap", false)
mod:AddSetIconOption("SetIconOnAdds", 267192, true, true, {1, 2, 3})
mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {6, 7, 8})

mod.vb.phase = 1
mod.vb.orbCount = 0
mod.vb.addIcon = 1
mod.vb.eyeCount = 0
mod.vb.roilingCount = 0
mod.vb.corruptorsPactCount = 0
mod.vb.casterAddsRemaining = 0

function mod:EyeBeamTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(5, 5) then
		specWarnEyeBeam:Show(self.vb.eyeCount)
		specWarnEyeBeam:Play("runout")
		yellEyeBeam:Yell(self.vb.eyeCount)
	else
		warnEyeBeam:Show(self.vb.eyeCount, targetname)
	end
	if self.Options.SetIconOnEyeBeam then
		self:SetIcon(targetname, 9-self.vb.eyeCount, 5)
	end
end

function mod:RollingTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(5, 6) then
		specWarnRoilingDeceit:Show(DBM_CORE_ROOM_EDGE)
		specWarnRoilingDeceit:Play("runtoedge")
		yellRoilingDeceit:Yell(self.vb.roilingCount)
		yellRoilingDeceitFades:Countdown(12)
	else
		warnRoilingDeceit:Show(self.vb.roilingCount, targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.orbCount = 0
	self.vb.addIcon = 1
	self.vb.eyeCount = 0
	self.vb.roilingCount = 0
	self.vb.corruptorsPactCount = 0
	self.vb.casterAddsRemaining = 0
	--Same in All
	timerTitanSparkCD:Start(10-delay)
	timerMightofVoidCD:Start(15-delay)
	timerEyeBeamCD:Start(52-delay)--52-54
	if self:IsLFR() then
		timerSurgingDarknessCD:Start(41-delay)--Custom for LFR
	else
		timerSurgingDarknessCD:Start(25-delay)--Same in rest of them
		if self:IsMythic() then
			timerAddsCD:Start(62.7)--Both adds with custom adds trigger
			timerRoilingDeceitCD:Start(26.5)--CAST_START
		else
			timerQirajiWarriorCD:Start(56-delay)--56-58 regardless
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 264382 then
		self.vb.eyeCount = self.vb.eyeCount + 1
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "EyeBeamTarget", 0.1, 8, true, nil, nil, nil, true)
	elseif spellId == 265358 then
		self.vb.roilingCount = self.vb.roilingCount + 1
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "RollingTarget", 0.1, 8, true, nil, nil, nil, true)
	elseif spellId == 267180 then
		--timerVoidBoltCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVoidbolt:Show(args.sourceName)
			specWarnVoidbolt:Play("kickcast")
		end
	elseif spellId == 267239 and self:AntiSpam(15, 4) then--Backup, in case emote doesn't fire for more than first one
		specWarnOrbOfCorruption:Show(1)
		specWarnOrbOfCorruption:Play("161612")--catch balls
		timerOrbLands:Start(8, 1)
	elseif spellId == 270620 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEntropicBlast:Show(args.sourceName)
		specWarnEntropicBlast:Play("kickcast")
	elseif spellId == 265231 then--First Void Lash
		timerMightofVoidCD:Start()
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnMightofVoid:Show()
			specWarnMightofVoid:Play("defensive")
		end
	elseif spellId == 265530 then
		specWarnSurgingDarkness:Show()
		specWarnSurgingDarkness:Play("watchstep")
		if not self:IsMythic() then
			timerSurgingDarknessCD:Start(84)
		else
			timerSurgingDarknessCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 264382 then--Backup, in case target scan breaks
		if args:IsPlayer() and self:AntiSpam(5, 5) then
			specWarnEyeBeam:Show(self.vb.eyeCount)
			specWarnEyeBeam:Play("runout")
			yellEyeBeam:Yell(self.vb.eyeCount)
		end
		if self.vb.eyeCount == 3 and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 271099 then--Mythic Summon Adds
		self.vb.casterAddsRemaining = self.vb.casterAddsRemaining + 3
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		timerAddsCD:Start()
	elseif spellId == 181089 then
		self.vb.phase = self.vb.phase + 1
		timerMightofVoidCD:Stop()
		timerMightofVoidCD:Start(30)
		timerSurgingDarknessCD:Stop()
		timerSurgingDarknessCD:Start(79.1)
		if self.vb.phase == 2 then
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			if not self:IsMythic() then
				timerQirajiWarriorCD:Stop()
				timerEyeBeamCD:Stop()
				if not self:IsLFR() then
					timerAnubarCasterCD:Start(20.5)
				end
				timerRoilingDeceitCD:Start(22)--CAST_START
			else--Mythic Stage 2 is final stage, start final stage timer
				timerAddsCD:Stop()
				timerOrbofCorruptionCD:Start(12, 1)--Assumed
			end
		elseif self.vb.phase == 3 then--Should only happen on non mythic
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerAnubarCasterCD:Stop()
			timerRoilingDeceitCD:Cancel()
			timerOrbofCorruptionCD:Start(12, 1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265264 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnVoidLash:Show(args.destName, amount)
		end
	elseif spellId == 265237 and not args:IsPlayer() then
		if self.Options.EarlyTankSwap then
			specWarnShatter:Show(args.destName)
			specWarnShatter:Play("tauntboss")
		else
			specWarnShatter:Schedule(4.5, args.destName)
			specWarnShatter:ScheduleVoice(4.5, "tauntboss")
		end
	elseif spellId == 265360 then
		if args:IsPlayer() and self:AntiSpam(5, 6) then
			specWarnRoilingDeceit:Show(DBM_CORE_ROOM_EDGE)
			specWarnRoilingDeceit:Play("runtoedge")
			yellRoilingDeceit:Yell(self.vb.roilingCount)
			yellRoilingDeceitFades:Countdown(spellId)
		end
	elseif spellId == 265662 then
		if self:AntiSpam(5, 7) then
			self.vb.corruptorsPactCount = self.vb.corruptorsPactCount + 1
			specWarnOrbOfCorruption:Show(self.vb.corruptorsPactCount+1)--+1 cause this is pre warning for next orb
			specWarnOrbOfCorruption:Play("161612")
			timerOrbLands:Start(15, self.vb.corruptorsPactCount+1)
		end
		warnCorruptorsPact:CombinedShow(0.5, self.vb.corruptorsPactCount, args.destName)--Combined in case more than one soaks same ball (will happen in lfr/normal for sure or farm content for dps increases)
		if args:IsPlayer() then
			yellCorruptorsPact:Countdown(spellId)
			specWarnWillofCorruptorSoon:Schedule(26)
			specWarnWillofCorruptorSoon:ScheduleVoice(26, "takedamage")--use this voice? can you off yourself before the MC?
		end
	elseif spellId == 265646 then
		warnWillofCorruptor:CombinedShow(0.5, args.destName)
		if not DBM:UnitDebuff("player", args.spellName) then
			specWarnWillofCorruptor:Show()
			specWarnWillofCorruptor:Play("findmc")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 265360 then
		if args:IsPlayer() then
			yellRoilingDeceitFades:Cancel()
		end
	elseif spellId == 265662 then
		if args:IsPlayer() then
			yellCorruptorsPact:Cancel()
			specWarnWillofCorruptorSoon:Cancel()
			specWarnWillofCorruptorSoon:CancelVoice()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135824 then--Anub'ar Voidweaver
		self.vb.casterAddsRemaining = self.vb.casterAddsRemaining - 1
		warnCasterAddsRemaining:Show(self.vb.casterAddsRemaining)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 and not self:IsMythic() then--Spawn Qiraji Warrior
		timerQirajiWarriorCD:Start()
	elseif spellId == 267192 and not self:IsMythic() then--Spawn Anub'ar Caster
		self.vb.casterAddsRemaining = self.vb.casterAddsRemaining + 3
		timerAnubarCasterCD:Start()--80
	elseif spellId == 265437 then--Roiling Deceit
		self.vb.roilingCount = 0
		--here because this spell ID fires at beginning of each set ONCE
		timerRoilingDeceitCD:Schedule(6, 60)--Same in all
	elseif spellId == 264746 then--Eye beam
		self.vb.eyeCount = 0
		specWarnEyeBeamSoon:Show()
		specWarnEyeBeamSoon:Play("Scattersoon")
		--here because this spell ID fires at beginning of each set ONCE
		if self:IsMythic() then
			timerEyeBeamCD:Schedule(6, 60)
		elseif self:IsLFR() then
			timerEyeBeamCD:Schedule(6, 50)
		else
			timerEyeBeamCD:Schedule(6, 40)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 267019 then--Titan Spark
		if self:IsMythic() and self.vb.phase < 2 or self.vb.phase < 3 then
			timerTitanSparkCD:Start(20)
		else
			timerTitanSparkCD:Start(10)
		end
	elseif spellId == 267191 then--Anub'ar Caster Summon Cosmetic Beam
		if not GetRaidTargetIndex(uId) then--Not already marked
			if self.Options.SetIconOnAdds then
				SetRaidTarget(uId, self.vb.addIcon)
			end
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon == 4 then
				self.vb.addIcon = 1
			end
		end
	end
end
