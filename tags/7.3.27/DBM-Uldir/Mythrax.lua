local mod	= DBM:NewMod(2194, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(138324)--4 CIDs for Mythrax, need to wait to add, 138324 Xalzaix
mod:SetEncounterID(2135)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 273282 273538 273810 272115 273949 274019",
	"SPELL_CAST_SUCCESS 273282 272177 272394 272533",
	"SPELL_AURA_APPLIED 274693 272407 272536 272115",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 272407 272536",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, see if there is a way at all to detect Existence Fragment on self. Maybe nameplates, maybe UNIT_SPELLCAST from self
--TODO, verify and enable tank stuff if assumptions are correct.
--TODO, maybe additional warning to spread before Ruin is cast, a pre warning
--TODO, Oblivion's Veil is probably a stage change event and not a persistent mechanic of stage 2
--TODO, detect Obliteration Beam target. Probably a chat message or whisper. Remove aoe warning if target is possible
--TODO, N'raqi Destroyer come out with visions? tank mob?
--Stage One: Oblivion's Call
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--local warnImminentRuin					= mod:NewTargetAnnounce(272536, 2)
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

--Stage One: Oblivion's Call
local specWarnEssenceShearDodge			= mod:NewSpecialWarningDodge(274693, false, nil, nil, 2, 2)
local specWarnEssenceShear				= mod:NewSpecialWarningDefensive(274693, nil, nil, nil, 1, 2)
local specWarnEssenceShearOther			= mod:NewSpecialWarningTaunt(274693, nil, nil, nil, 1, 2)
local specWarnObliterationWave			= mod:NewSpecialWarningDodge(273538, nil, nil, nil, 2, 2)
local specWarnOblivionSphere			= mod:NewSpecialWarningSwitch(272407, "RangedDps", nil, nil, 1, 2)
local yellOblivionSphere				= mod:NewYell(272407, "Ball Luvin'")
local specWarnImminentRuin				= mod:NewSpecialWarningMoveAway(272536, nil, nil, nil, 1, 2)
local yellImminentRuin					= mod:NewYell(272536, 139073)--Short name "Ruin"
local yellImminentRuinFades				= mod:NewFadesYell(272536, 139073)
local specWarnImminentRuinNear			= mod:NewSpecialWarningClose(272536, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: Fury of the C'thraxxi
local specWarnObliterationbeam			= mod:NewSpecialWarningSpell(272115, nil, nil, nil, 2, 2)--Generic for now
local specWarnObliterationbeamYou		= mod:NewSpecialWarningRun(272115, nil, nil, nil, 4, 2)--Generic for now
local specWarnVisionsofMadness			= mod:NewSpecialWarningSwitch(273949, "-Healer", nil, nil, 1, 2)
local specWarnMindFlay					= mod:NewSpecialWarningInterrupt(274019, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerEssenceShearCD				= mod:NewAITimer(12.1, 274693, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerObliterationWaveCD			= mod:NewAITimer(12.1, 273538, nil, nil, nil, 3)
local timerOblivionSphereCD				= mod:NewAITimer(12.1, 272407, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerImminentRuinCD				= mod:NewAITimer(12.1, 272536, nil, nil, nil, 3)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerObliterationbeamCD			= mod:NewAITimer(12.1, 272115, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerVisionsoMadnessCD			= mod:NewAITimer(12.1, 273949, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownEssenceShear				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconBeam", 272115, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
--mod:AddInfoFrameOption(258040, true)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerEssenceShearCD:Start(1-delay)--SUCCESS
	timerObliterationWaveCD:Start(1-delay)
	timerOblivionSphereCD:Start(1-delay)
	timerImminentRuinCD:Start(1-delay)--SUCCESS
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273282 then
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if not (tanking or (status == 3)) and DBM:UnitDebuff("player", 274693) then
			specWarnEssenceShearDodge:Show()
			specWarnEssenceShearDodge:Play("shockwave")
		end
	elseif spellId == 273538 then
		specWarnObliterationWave:Show()
		specWarnObliterationWave:Play("watchwave")
		timerObliterationWaveCD:Start()
	elseif spellId == 273810 then
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerEssenceShearCD:Stop()
		timerObliterationWaveCD:Stop()
		timerOblivionSphereCD:Stop()
		timerImminentRuinCD:Stop()
		timerObliterationbeamCD:Start(2)
		timerVisionsoMadnessCD:Start(2)
	elseif spellId == 272115 then
		specWarnObliterationbeam:Show()
		specWarnObliterationbeam:Play("watchstep")
		timerObliterationbeamCD:Start()
	elseif spellId == 273949 then
		specWarnVisionsofMadness:Show()
		specWarnVisionsofMadness:Play("killmob")
		timerVisionsoMadnessCD:Start()
	elseif spellId == 274019 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 273282 then
		timerEssenceShearCD:Start()
	elseif (spellId == 272177 or spellId == 272394) and self:AntiSpam(10, 1) then--Either this or SPELL_SUMMON
		specWarnOblivionSphere:Show()
		specWarnOblivionSphere:Play("killmob")
		timerOblivionSphereCD:Start()
	elseif spellId == 272533 then
		timerImminentRuinCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274693 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			--local amount = args.amount or 1
			--if amount >= 2 then
				if args:IsPlayer() then
					specWarnEssenceShear:Show()
					specWarnEssenceShear:Play("defensive")
				else
					--local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					--local remaining
					--if expireTime then
					--	remaining = expireTime-GetTime()
					--end
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
						specWarnEssenceShearOther:Show(args.destName)
						specWarnEssenceShearOther:Play("tauntboss")
					--else
					--	warnEssenceShear:Show(args.destName, amount)
					--end
				end
			--else
				--warnEssenceShear:Show(args.destName, amount)
			--end
		end
	elseif spellId == 272407 then--Purple Ball Lovin
		
		if args:IsPlayer() then
			yellOblivionSphere:Yell()
		end
	elseif spellId == 272536 then
		if args:IsPlayer() then
			specWarnImminentRuin:Show()
			specWarnImminentRuin:Play("runout")
			yellImminentRuin:Yell()
			yellImminentRuinFades:Countdown(8)
		elseif self:CheckNearby(12, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnImminentRuinNear:CombinedShow(0.3, args.destName)--Combined show to prevent warning spam if multiple targets near you
			specWarnImminentRuinNear:CancelVoice()--Avoid spam
			specWarnImminentRuinNear:ScheduleVoice(0.3, "runaway")
		--else
			--warnImminentRuin:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 272115 then
		
		if args:IsPlayer() then
			specWarnObliterationbeamYou:Show()
			specWarnObliterationbeamYou:Play("laserrun")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 272407 then--Purple Ball Lovin
		--DO STUFF?
	elseif spellId == 272536 then
		--Icon Marking?
		if args:IsPlayer() then
			yellImminentRuinFades:Cancel()
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 138492 then--Oblivion Sphere
	
	elseif cid == 139487 then--Vision of Madness
	
	elseif cid == 139381 then--N'raqi Destroyer

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then

	end
end
--]]
