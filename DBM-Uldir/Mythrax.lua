local mod	= DBM:NewMod(2194, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134546)--138324 Xalzaix
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
	"SPELL_CAST_SUCCESS 272533",
	"SPELL_AURA_APPLIED 274693 272407 272536 274230",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 272407 272536 274230",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify and enable tank stuff if assumptions are correct.
--TODO, add massive claw? "Massive Claw-274772-npc:134546 = pull:6.2, 11.1, 9.0, 11.0, 9.0, 11.1, 9.0, 11.1, 9.0, 11.0, 9.0, 11.0, 9.0, 11.0, 9.0, 11.0, 9.0, 11.1, 9.1, 10.9, 8.9, 11.0, 9.0, 11.0, 9.0
--TODO, detect Obliteration Blast target?
--TODO, move timerObliterationBlastCD to success?
--Stage One: Oblivion's Call
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--local warnImminentRuin					= mod:NewTargetAnnounce(272536, 2)
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

--Stage One: Oblivion's Call
local specWarnEssenceShearDodge			= mod:NewSpecialWarningDodge(274693, false, nil, nil, 3, 2)
local specWarnEssenceShear				= mod:NewSpecialWarningDefensive(274693, nil, nil, nil, 1, 2)
local specWarnEssenceShearOther			= mod:NewSpecialWarningTaunt(274693, nil, nil, nil, 1, 2)
local specWarnObliterationBlast			= mod:NewSpecialWarningDodge(273538, nil, nil, nil, 2, 2)--Mythic
local specWarnOblivionSphere			= mod:NewSpecialWarningSwitch(272407, "RangedDps", nil, nil, 1, 2)
local yellOblivionSphere				= mod:NewYell(272407)
local specWarnImminentRuin				= mod:NewSpecialWarningMoveAway(272536, nil, nil, nil, 1, 2)
local yellImminentRuin					= mod:NewYell(272536, 139073)--Short name "Ruin"
local yellImminentRuinFades				= mod:NewFadesYell(272536, 139073)
local specWarnImminentRuinNear			= mod:NewSpecialWarningClose(272536, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: Fury of the C'thraxxi
local specWarnObliterationbeam			= mod:NewSpecialWarningDodge(272115, nil, nil, nil, 2, 2)--Generic for now
--local specWarnObliterationbeamYou		= mod:NewSpecialWarningRun(272115, nil, nil, nil, 4, 2)--Generic for now
local specWarnVisionsofMadness			= mod:NewSpecialWarningSwitch(273949, "-Healer", nil, nil, 1, 2)
local specWarnMindFlay					= mod:NewSpecialWarningInterrupt(274019, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerEssenceShearCD				= mod:NewNextSourceTimer(19.9, 274693, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--All timers generlaly 20 but 19.9 can happen and DBM has to use lost known time
local timerObliterationBlastCD			= mod:NewNextSourceTimer(19.9, 273538, nil, nil, nil, 3)
local timerOblivionSphereCD				= mod:NewNextCountTimer(19.9, 272407, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerImminentRuinCD				= mod:NewNextTimer(19.9, 272536, nil, nil, nil, 3)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerVeil							= mod:NewBuffActiveTimer(60, 274230, nil, nil, nil, 6)
local timerObliterationbeamCD			= mod:NewCDCountTimer(12.1, 272115, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerVisionsoMadnessCD			= mod:NewNextTimer(20, 273949, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownOblivionSphere			= mod:NewCountdown(19.9, 272407, nil, nil, 3)
local countdownEssenceShear				= mod:NewCountdown("Alt20", 274693, "Tank", nil, 3)
local countdownImminentRuin				= mod:NewCountdown("AltTwo20", 272536, "-Tank", nil, 3)

--mod:AddSetIconOption("SetIconBeam", 272115, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(272146, true)

mod.vb.phase = 1
mod.vb.ruinCast = 0
mod.vb.sphereCast = 0
mod.vb.beamCast = 0
local beamTimers = {20, 14, 10, 12}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.ruinCast = 0
	self.vb.sphereCast = 0
	--timerEssenceShearCD:Start(3.2-delay, BOSS)--START
	--countdownEssenceShear:Start(3.2-delay)
	timerObliterationBlastCD:Start(9.2-delay, BOSS)
	timerOblivionSphereCD:Start(20-delay, 1)
	countdownOblivionSphere:Start(20-delay)
	--timerImminentRuinCD:Start(1-delay)--Cast instantly on pull
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(272146))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 272146, 1)
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
	if spellId == 273282 then
		if not self:IsTanking("player", "boss1", nil, true) and DBM:UnitDebuff("player", 274693) then
			specWarnEssenceShearDodge:Show()
			specWarnEssenceShearDodge:Play("shockwave")
		end
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 134546 then--Main boss
			timerEssenceShearCD:Start(19.9, BOSS, args.sourceGUID)
			countdownEssenceShear:Start(19.9)
		else--Big Adds (cid==139381)
			timerEssenceShearCD:Start(22.5, DBM_ADD, args.sourceGUID)
		end
	elseif spellId == 273538 then--Antispammed since he casts double on mythic
		if self:AntiSpam(3, 1) then
			specWarnObliterationBlast:Show()
			specWarnObliterationBlast:Play("watchwave")
		end
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 134546 then--Main boss
			timerObliterationBlastCD:Start(19.9, BOSS, args.sourceGUID)
			countdownEssenceShear:Start(19.9)
		else--Big Adds (cid==139381)
			--timerObliterationBlastCD:Start(22.5, DBM_ADD, args.sourceGUID)
		end
	elseif spellId == 273810 then
		self.vb.phase = 2
		self.vb.beamCast = 0
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerEssenceShearCD:Stop()
		countdownEssenceShear:Cancel()
		timerObliterationBlastCD:Stop()
		timerOblivionSphereCD:Stop()
		countdownOblivionSphere:Cancel()
		timerImminentRuinCD:Stop()
		countdownImminentRuin:Cancel()
		timerVisionsoMadnessCD:Start(11.5)
		timerObliterationbeamCD:Start(20)
	elseif spellId == 272115 then
		self.vb.beamCast = self.vb.beamCast + 1
		specWarnObliterationbeam:Show()
		specWarnObliterationbeam:Play("watchstep")
		local timer = beamTimers[self.vb.beamCast+1]
		if timer then
			timerObliterationbeamCD:Start(timer, self.vb.beamCast+1)
		end
	elseif spellId == 273949 then
		specWarnVisionsofMadness:Show()
		specWarnVisionsofMadness:Play("killmob")
		timerVisionsoMadnessCD:Start()
	elseif spellId == 274019 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 272533 then
		self.vb.ruinCast = self.vb.ruinCast + 1
		if self.vb.ruinCast == 1 then
			timerImminentRuinCD:Start(15, self.vb.ruinCast+1)--Cast instantly on pull, and then second one is 15 seconds after first
			countdownImminentRuin:Start(15)
		else--Rest are all 20
			timerImminentRuinCD:Start(20, self.vb.ruinCast+1)
			countdownImminentRuin:Start(20)
		end
	--[[elseif spellId == 272404 and self:AntiSpam(10, 1) then--Use if for some reason the UNIT event disappears
		self.vb.sphereCast = self.vb.sphereCast + 1
		specWarnOblivionSphere:Show()
		specWarnOblivionSphere:Play("killmob")
		if self.vb.sphereCast % 3 == 0 then--3, 6, 9, etc
			--Oblivion Sphere-272177-npc:134546 = pull:20.1, 20.0, 20.0, 40.1, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0
			timerOblivionSphereCD:Start(40, self.vb.sphereCast+1)
			countdownOblivionSphere:Start(40)
		else
			timerOblivionSphereCD:Start(20, self.vb.sphereCast+1)
			countdownOblivionSphere:Start(20)
		end--]]
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
	elseif spellId == 274230 then
		timerVeil:Start()
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
	elseif spellId == 274230 then--Boss active again
		self.vb.sphereCast = 0--Does this reset? does it follow same rules? 40 seconds after each multiple of 3?
		timerVeil:Stop()
		timerObliterationbeamCD:Stop()--Not sure it stops, didn't get far enough
		timerVisionsoMadnessCD:Stop()--Not sure it stops, didn't get far enough
		timerEssenceShearCD:Start(3, BOSS)--START
		countdownEssenceShear:Start(3)
		timerObliterationBlastCD:Start(9)
		timerImminentRuinCD:Start(17)--SUCCESS
		countdownImminentRuin:Start(17)
		timerOblivionSphereCD:Start(20, 1)
		countdownOblivionSphere:Start(20)
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
	if cid == 138492 then--Oblivion Sphere
		--TODO, infoframe add tracking
	elseif cid == 139487 then--Vision of Madness
		--TODO, infoframe add tracking
	elseif cid == 139381 then--N'raqi Destroyer
		--TODO, infoframe add tracking
		timerEssenceShearCD:Stop(DBM_ADD, args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 272177 then--Oblivion Sphere (yes it's in combat log, but needs antispam event since it fires twice there)
		self.vb.sphereCast = self.vb.sphereCast + 1
		specWarnOblivionSphere:Show()
		specWarnOblivionSphere:Play("killmob")
		if self.vb.sphereCast % 3 == 0 then--3, 6, 9, etc
			--Oblivion Sphere-272177-npc:134546 = pull:20.1, 20.0, 20.0, 40.1, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0
			timerOblivionSphereCD:Start(40, self.vb.sphereCast+1)
			countdownOblivionSphere:Start(40)
		else
			timerOblivionSphereCD:Start(20, self.vb.sphereCast+1)
			countdownOblivionSphere:Start(20)
		end
	end
end
