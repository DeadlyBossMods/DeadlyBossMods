local mod	= DBM:NewMod(2169, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134445)--Zek'vhozj, 134503/qiraji-warrior
mod:SetEncounterID(2136)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 264382 267180 267239 270620",
	"SPELL_CAST_SUCCESS 265451 265452 265358",
	"SPELL_AURA_APPLIED 265264 264382 264219 265360 265662 265646",
	"SPELL_AURA_APPLIED_DOSE 265264",
	"SPELL_AURA_REMOVED 265360 265662",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, additional warnings/tweaks for shatter and void lash
--TODO, icons for Roiling Deceit if applied to more than one target at a time
--TODO, mark mind controlled players?
--TODO, phase change detection and timer updates
--TODO, titan spark frequency?
--local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnVoidLash						= mod:NewStackAnnounce(265264, 2, nil, "Tank")
--Stage One: Chaos
local warnEyeBeam						= mod:NewTargetAnnounce(264382, 2)
local warnFixate						= mod:NewTargetAnnounce(264219, 2)
--Stage Two: Deception
local warnRoilingDeceit					= mod:NewTargetAnnounce(265360, 4)
--Stage Three: Corruption
local warnCorruptorsPact				= mod:NewTargetAnnounce(265662, 2)
local warnWillofCorruptor				= mod:NewTargetAnnounce(265646, 4, nil, false)

--General
local specWarnSurgingDarkness			= mod:NewSpecialWarningDodge(265451, nil, nil, nil, 3, 2)
local specWarnVoidLash					= mod:NewSpecialWarningStack(265264, nil, 2, nil, nil, 1, 6)
local specWarnVoidLashTaunt				= mod:NewSpecialWarningTaunt(265264, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage One: Chaos
local specWarnEyeBeam					= mod:NewSpecialWarningMoveAway(264382, nil, nil, nil, 1, 2)
local yellEyeBeam						= mod:NewYell(264382)
local specWarnFixate					= mod:NewSpecialWarningRun(264219, nil, nil, nil, 4, 2)
--Stage Two: Deception
local specWarnRoilingDeceit				= mod:NewSpecialWarningMoveTo(265360, nil, nil, nil, 3, 7)
local yellRoilingDeceit					= mod:NewYell(265360)
local yellRoilingDeceitFades			= mod:NewFadesYell(265360)
local specWarnVoidbolt					= mod:NewSpecialWarningInterrupt(267180, "HasInterrupt", nil, nil, 1, 2)
--Stage Three: Corruption
local specWarnOrbOfCorruption			= mod:NewSpecialWarningCount(267239, nil, nil, nil, 2, 7)
local yellCorruptorsPact				= mod:NewFadesYell(265662)
local specWarnWillofCorruptorSoon		= mod:NewSpecialWarningSoon(265646, nil, nil, nil, 3, 2)
local specWarnWillofCorruptor			= mod:NewSpecialWarningSwitch(265646, "RangedDps", nil, nil, 1, 2)
local specWarnEntropicBlast				= mod:NewSpecialWarningInterrupt(270620, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(GENERAL)
local timerSurgingDarknessCD			= mod:NewAITimer(12.1, 265451, nil, "Melee", nil, 2, nil, DBM_CORE_DEADLY_ICON)--60 based on energy math
local timerMightofVoidCD				= mod:NewAITimer(12.1, 267312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerEyeBeamCD					= mod:NewAITimer(12.1, 264382, nil, nil, nil, 3)
local timerQirajiWarriorCD				= mod:NewAITimer(12.1, "ej18071", nil, nil, nil, 1, 31700)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerRoilingDeceitCD				= mod:NewAITimer(12.1, 265360, nil, nil, nil, 3)
local timerVoidBoltCD					= mod:NewAITimer(19.9, 267180, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerOrbofCorruptionCD			= mod:NewAITimer(12.1, 267239, nil, nil, nil, 5)--Make count timer when not AI

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownVoidLash					= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 265360, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(265451, true)

mod.vb.phase = 1
mod.vb.orbCount = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.orbCount = 0
	timerMightofVoidCD:Start(1-delay)
	timerSurgingDarknessCD:Start(1-delay)--30 based on energy math
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(4, "enemypower", 2)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 243983 then
		timerEyeBeamCD:Start()
	elseif spellId == 267180 then
		timerVoidBoltCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnVoidbolt:Show(args.sourceName)
			specWarnVoidbolt:Play("kickcast")
		end
	elseif spellId == 267239 then
		self.vb.orbCount = self.vb.orbCount + 1
		specWarnOrbOfCorruption:Show(self.vb.orbCount)
		specWarnOrbOfCorruption:Play("161612")--catch balls
		timerOrbofCorruptionCD:Start()
	elseif spellId == 270620 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnEntropicBlast:Show(args.sourceName)
		specWarnEntropicBlast:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 265451 or spellId == 265452) and self:AntiSpam(5, 1) then--Eliminate one not used
		specWarnSurgingDarkness:Show()
		specWarnSurgingDarkness:Play("watchstep")
		timerSurgingDarknessCD:Start()
	elseif spellId == 265358 then
		timerRoilingDeceitCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265264 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnVoidLash:Show(amount)
					specWarnVoidLash:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") then
						specWarnVoidLashTaunt:Show(args.destName)
						specWarnVoidLashTaunt:Play("tauntboss")
					else
						warnVoidLash:Show(args.destName, amount)
					end
				end
			else
				warnVoidLash:Show(args.destName, amount)
			end
		end
	elseif spellId == 264382 then
		if args:IsPlayer() then
			specWarnEyeBeam:Show()
			specWarnEyeBeam:Play("runout")
			yellEyeBeam:Yell()
		else
			warnEyeBeam:Show(args.destName)
		end
	elseif spellId == 264219 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 265360 then
		if args:IsPlayer() then
			specWarnRoilingDeceit:Show(DBM_CORE_ROOM_EDGE)
			specWarnRoilingDeceit:Play("runtoedge")
			yellRoilingDeceit:Yell()
			yellRoilingDeceitFades:Countdown(12)
		else
			warnRoilingDeceit:Show(args.destName)
		end
	elseif spellId == 265662 then
		warnCorruptorsPact:CombinedShow(0.5, args.destName)--Combined in case more than one soaks same ball (will happen in lfr/normal for sure or farm content for dps increases)
		if args:IsPlayer() then
			yellCorruptorsPact:Countdown(20)
			specWarnWillofCorruptorSoon:Schedule(16)
			specWarnWillofCorruptorSoon:ScheduleVoice(16, "takedamage")--use this voice? can you off yourself before the MC?
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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 134503 then--Qiraji Warrior

	elseif cid == 135083 then--Guardian of Yogg-Saron
	
	elseif cid == 135824 then--Anub'ar Voidweaver
		timerVoidBoltCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 267312 then--Might of the Void
		timerMightofVoidCD:Start()
	elseif spellId == 264428 then--Qiraji Warrior Fixate Controller
		timerQirajiWarriorCD:Start()
	end
end
