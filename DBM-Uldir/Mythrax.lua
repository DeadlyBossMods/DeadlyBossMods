local mod	= DBM:NewMod(2194, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134546)--138324 Xalzaix
mod:SetEncounterID(2135)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(17895)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 273282 273538 273810 272115 274019 279157",
	"SPELL_CAST_SUCCESS 272533 273949 276922 272404",
	"SPELL_AURA_APPLIED 274693 272407 272536",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 272407 272536 279157",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add massive claw? "Massive Claw-274772-npc:134546 = pull:6.2, 11.1, 9.0, 11.0, 9.0, 11.1, 9.0, 11.1, 9.0, 11.0, 9.0, 11.0, 9.0, 11.0, 9.0, 11.0, 9.0, 11.1, 9.1, 10.9, 8.9, 11.0, 9.0, 11.0, 9.0
--[[
(ability.id = 273282 or ability.id = 273538 or ability.id = 273810 or ability.id = 272115 or ability.id = 279157) and type = "begincast"
 or (ability.id = 272533 or ability.id = 272404 or ability.id = 273949 or ability.id = 276922) and type = "cast"
 or ability.id = 274019 and type = "begincast"
 or ability.id = 274230 and type = "removebuff"
--]]
--Stage One: Oblivion's Call
local warnPhase						= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnOblivionSphere			= mod:NewCountAnnounce(272407, 4)
local warnVoidEchoes				= mod:NewCountAnnounce(279157, 4)
--Stage Two:
local warnDestroyerRemaining			= mod:NewAddsLeftAnnounce("ej18508", 2, 274693)

--Stage One: Oblivion's Call
local specWarnEssenceShearDodge			= mod:NewSpecialWarningDodge(274693, false, nil, nil, 3, 2)
local specWarnEssenceShear				= mod:NewSpecialWarningDefensive(274693, nil, nil, nil, 1, 2)
local specWarnEssenceShearOther			= mod:NewSpecialWarningTaunt(274693, nil, nil, nil, 1, 2)
local specWarnObliterationBlast			= mod:NewSpecialWarningDodge(273538, nil, nil, nil, 2, 2)
local yellOblivionSphere				= mod:NewYell(272407)
local specWarnImminentRuin				= mod:NewSpecialWarningYouPos(272536, nil, nil, nil, 1, 2)
local yellImminentRuin					= mod:NewPosYell(272536, 139073)--Short name "Ruin"
local yellImminentRuinFades				= mod:NewIconFadesYell(272536, 139073)
local specWarnImminentRuinNear			= mod:NewSpecialWarningClose(272536, false, nil, 2, 1, 2)
local specWarnLivingWeapon				= mod:NewSpecialWarningSwitch(276922, "RangedDps", nil, nil, 1, 2)--Mythic (include melee dps too? asuming do to spheres, a big no)
local specWarnVoidEchoes				= mod:NewSpecialWarningCount(279157, false, nil, 2, 2, 2)--Mythic
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: Fury of the C'thraxxi
local specWarnObliterationbeam			= mod:NewSpecialWarningDodgeCount(272115, nil, nil, nil, 2, 2)--Generic for now
--local specWarnObliterationbeamYou		= mod:NewSpecialWarningRun(272115, nil, nil, nil, 4, 2)--Generic for now
local specWarnVisionsofMadness			= mod:NewSpecialWarningSwitchCount(273949, "-Healer", nil, nil, 1, 2)
local specWarnMindFlay					= mod:NewSpecialWarningInterrupt(274019, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerEssenceShearCD				= mod:NewNextSourceTimer(19.5, 274693, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--All timers generlaly 20 but 19.9 can happen and DBM has to use lost known time
local timerObliterationBlastCD			= mod:NewNextSourceTimer(14.9, 273538, nil, nil, nil, 3)
local timerOblivionSphereCD				= mod:NewNextCountTimer(14.9, 272407, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerImminentRuinCD				= mod:NewNextCountTimer(14.9, 272536, nil, nil, nil, 3)
local timerLivingWeaponCD				= mod:NewNextTimer(60.5, 276922, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)--Mythic
local timerVoidEchoesCD					= mod:NewNextCountTimer(60.5, 279157, nil, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerIntermission					= mod:NewPhaseTimer(60)
local timerObliterationbeamCD			= mod:NewCDCountTimer(12.1, 272115, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerVisionsoMadnessCD			= mod:NewNextCountTimer(20, 273949, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownOblivionSphere			= mod:NewCountdown(19.9, 272407, nil, nil, 3)
local countdownEssenceShear				= mod:NewCountdown("Alt20", 274693, "Tank", nil, 3)
local countdownImminentRuin				= mod:NewCountdown("AltTwo20", 272536, "-Tank", nil, 3)

mod:AddSetIconOption("SetIconRuin", 272536, true)
mod:AddRangeFrameOption(5, 272407)
mod:AddInfoFrameOption(272146, true)

mod.vb.ruinCast = 0
mod.vb.sphereCast = 0
mod.vb.beamCast = 0
mod.vb.destroyersRemaining = 2
mod.vb.ruinIcon = 1
mod.vb.echoesCast = 0
mod.vb.isIntermission = false
mod.vb.visionsCount = 0
local beamTimers = {19.5, 24, 12, 12}--Changed for a 3rd time
local mythicBeamTimers = {19.5, 15, 15, 15}

function mod:OnCombatStart(delay)
	self.vb.ruinCast = 0
	self.vb.sphereCast = 0
	self.vb.beamCast = 0
	self.vb.ruinIcon = 1
	self.vb.echoesCast = 0
	self.vb.destroyersRemaining = 2
	self.vb.isIntermission = false
	self.vb.visionsCount = 0
	timerImminentRuinCD:Start(4.9-delay, 1)
	if self:IsMythic() then
		timerOblivionSphereCD:Start(7-delay, 1)
		countdownOblivionSphere:Start(7-delay)
		timerLivingWeaponCD:Start(15.2)
	else
		timerOblivionSphereCD:Start(9-delay, 1)--Verify
		countdownOblivionSphere:Start(9-delay)
	end
	timerObliterationBlastCD:Start(14.9-delay, BOSS)
	timerEssenceShearCD:Start(19-delay, BOSS)--START
	countdownEssenceShear:Start(19-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(272146))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 272146, 1)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
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
			timerEssenceShearCD:Start(19.5, BOSS, args.sourceGUID)
			countdownEssenceShear:Start(19.5)
		else--Big Adds (cid==139381)
			if self:AntiSpam(3, 1) then
				timerEssenceShearCD:Start(19.5, DBM_ADD)
			end
		end
	elseif spellId == 273538 then--Antispammed since he casts double on mythic
		if self:AntiSpam(3, 2) then
			specWarnObliterationBlast:Show()
			specWarnObliterationBlast:Play("watchwave")
		end
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 134546 then--Main boss
			if self:IsMythic() then
				timerObliterationBlastCD:Start(20, BOSS)
			else
				timerObliterationBlastCD:Start(14.9, BOSS)
			end
		else--Big Adds (cid==139381)
			timerObliterationBlastCD:Start(12, DBM_ADD)
		end
	elseif spellId == 273810 then--Timers start here, because we have to factor boss movement
		timerOblivionSphereCD:Start(7)--Resets to 7
		countdownOblivionSphere:Start(7)--Still seems same in all
		if self:IsMythic() then
			timerObliterationbeamCD:Start(18.5, 1)
			timerVisionsoMadnessCD:Start(26.1, 1)
			timerIntermission:Start(75)
		else
			timerObliterationbeamCD:Start(20.5, 1)
			timerVisionsoMadnessCD:Start(31.5, 1)
			timerIntermission:Start(80)
		end
	elseif spellId == 272115 then
		self.vb.beamCast = self.vb.beamCast + 1
		specWarnObliterationbeam:Show(self.vb.beamCast)
		specWarnObliterationbeam:Play("watchstep")
		local timer = self:IsMythic() and mythicBeamTimers[self.vb.beamCast+1] or beamTimers[self.vb.beamCast+1]
		if timer then
			timerObliterationbeamCD:Start(timer, self.vb.beamCast+1)
		end
	elseif spellId == 274019 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	elseif spellId == 279157 then
		self.vb.echoesCast = self.vb.echoesCast + 1
		if self.Options.SpecWarn279157count2 then
			specWarnVoidEchoes:Show(self.vb.echoesCast)
			specWarnVoidEchoes:Play("aesoon")
		else
			warnVoidEchoes:Show(self.vb.echoesCast)
		end
		timerVoidEchoesCD:Start(9.7, self.vb.echoesCast+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 272533 then
		self.vb.ruinCast = self.vb.ruinCast + 1
		timerImminentRuinCD:Start(15, self.vb.ruinCast+1)
		countdownImminentRuin:Start(15)
	elseif spellId == 273949 then
		self.vb.visionsCount = self.vb.visionsCount + 1
		specWarnVisionsofMadness:Show(self.vb.visionsCount)
		specWarnVisionsofMadness:Play("killmob")
		if self.vb.visionsCount == 1 then
			timerVisionsoMadnessCD:Start(self:IsMythic() and 29.9 or 20, 2)
		end
	elseif spellId == 276922 then--Living Weapon
		self.vb.echoesCast = 0
		specWarnLivingWeapon:Show()
		specWarnLivingWeapon:Play("bigmob")
		timerVoidEchoesCD:Start(2.5, 1)
		timerObliterationBlastCD:Start(16.5, DBM_ADD)
		timerLivingWeaponCD:Start(60)
	elseif spellId == 272404 then
		self.vb.sphereCast = self.vb.sphereCast + 1
		warnOblivionSphere:Show(self.vb.sphereCast)
		if not self.vb.isIntermission then
			timerOblivionSphereCD:Start(15, self.vb.sphereCast+1)
			countdownOblivionSphere:Start(15)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274693 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				specWarnEssenceShear:Show()
				specWarnEssenceShear:Play("defensive")
			else
				local cid = self:GetCIDFromGUID(args.sourceGUID)
				if cid == 134546 then--Main boss
					specWarnEssenceShearOther:Show(args.destName)
					specWarnEssenceShearOther:Play("tauntboss")
				end
			end
		end
	elseif spellId == 272407 then--Purple Ball Lovin
		
		if args:IsPlayer() then
			yellOblivionSphere:Yell()
		end
	elseif spellId == 272536 then
		local icon = self.vb.ruinIcon
		if args:IsPlayer() then
			specWarnImminentRuin:Show(self:IconNumToTexture(icon))
			specWarnImminentRuin:Play("runout")--"mm"..icon
			yellImminentRuin:Yell(icon, icon, icon)
			yellImminentRuinFades:Countdown(12, nil, icon)
		elseif self:CheckNearby(12, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnImminentRuinNear:CombinedShow(0.3, args.destName)--Combined show to prevent warning spam if multiple targets near you
			specWarnImminentRuinNear:CancelVoice()--Avoid spam
			specWarnImminentRuinNear:ScheduleVoice(0.3, "runaway")
		--else
			--warnImminentRuin:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconRuin then
			self:SetIcon(args.destName, icon)
		end
		self.vb.ruinIcon = self.vb.ruinIcon + 1
		if self.vb.ruinIcon == 3 then
			self.vb.ruinIcon = 1
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 272407 then--Purple Ball Lovin
		--DO STUFF?
	elseif spellId == 272536 then
		if args:IsPlayer() then
			yellImminentRuinFades:Cancel()
		end
		if self.Options.SetIconRuin then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 279157 then--CLEU method of detecting add leaving, TODO, see if can detect it with IEEU or UNIT_TARGETABLE_CHANGED so it's reliable when add can be killed in 3 seconds (so, like next expansion :D)
		timerVoidEchoesCD:Stop()
		timerObliterationBlastCD:Stop(DBM_ADD)
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
	--elseif cid == 139487 then--Vision of Madness
		--TODO, infoframe add tracking
	elseif cid == 139381 then--N'raqi Destroyer
		self.vb.destroyersRemaining = self.vb.destroyersRemaining - 1
		warnDestroyerRemaining:Show(self.vb.destroyersRemaining)
		--TODO, infoframe add tracking
		if self.vb.destroyersRemaining == 0 then
			timerEssenceShearCD:Stop(DBM_ADD)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274558 then--Energy Drain [DNT] (can also use Override Display Power 279749)
		--Stop timers and set variables here, but don't start timers until boss finishes moving to center
		self.vb.beamCast = 0
		self.vb.destroyersRemaining = 2
		self.vb.visionsCount = 0
		self.vb.isIntermission = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerEssenceShearCD:Stop()
		countdownEssenceShear:Cancel()
		timerObliterationBlastCD:Stop()
		timerOblivionSphereCD:Stop()
		countdownOblivionSphere:Cancel()
		timerImminentRuinCD:Stop()
		countdownImminentRuin:Cancel()
		timerLivingWeaponCD:Stop()
	elseif spellId == 279748 then
		self.vb.sphereCast = 0
		self.vb.ruinCast = 0
		self.vb.isIntermission = false
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerObliterationbeamCD:Stop()
		timerVisionsoMadnessCD:Stop()
		if self:IsMythic() then
			timerImminentRuinCD:Start(5, 1)--SUCCESS
			countdownImminentRuin:Start(5)
			timerOblivionSphereCD:Start(7, 1)
			countdownOblivionSphere:Start(7)
			timerLivingWeaponCD:Start(16.6)
		else
			timerImminentRuinCD:Start(7.5, 1)--SUCCESS
			countdownImminentRuin:Start(7.5)
			timerOblivionSphereCD:Start(9, 1)
			countdownOblivionSphere:Start(9)
		end
		timerObliterationBlastCD:Start(15, BOSS)
		timerEssenceShearCD:Start(20, BOSS)--START
		countdownEssenceShear:Start(20)
	end
end
