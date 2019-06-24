local mod	= DBM:NewMod(2168, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(137119)--Taloc
mod:SetEncounterID(2144)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 271296 271728 271895",
	"SPELL_CAST_SUCCESS 271224 275205 278888",
	"SPELL_AURA_APPLIED 271224 271965 275270 275189 275205 278888",
	"SPELL_AURA_REMOVED 271965 275189 275205 271224 278888",
	"SPELL_PERIODIC_DAMAGE 270290",
	"SPELL_PERIODIC_MISSED 270290"
)

--[[
(ability.id = 271296 or ability.id = 271728 or ability.id = 271895) and type = "begincast"
 or (ability.id = 271224 or ability.id = 275205 or ability.id = 278888) and type = "cast"
 or ability.id = 271965 and (type = "removebuff" or type = "applybuff")
--]]
local warnPoweringDown					= mod:NewSpellAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnPlastmaDischarge				= mod:NewTargetAnnounce(271225, 2)
local warnPoweringDownOver				= mod:NewEndAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnFixate						= mod:NewTargetAnnounce(275270, 2)

local specWarnPlasmaDischarge			= mod:NewSpecialWarningMoveAway(271225, nil, nil, nil, 3, 2)
local yellPlasmaDischarge				= mod:NewYell(271225)
local specWarnCudgelofGore				= mod:NewSpecialWarningMoveTo(271296, nil, nil, nil, 3, 2)
local specWarnCudgelofGoreEveryone		= mod:NewSpecialWarningRun(271296, nil, nil, nil, 4, 2)
local specWarnRetrieveCudgel			= mod:NewSpecialWarningDodge(271728, nil, nil, nil, 2, 2)
local specWarnSanguineStaticYou			= mod:NewSpecialWarningYou(272582, nil, nil, nil, 1, 2)
local specWarnSanguineStatic			= mod:NewSpecialWarningDodge(272582, nil, nil, nil, 2, 2)
local yellSanguineStatic				= mod:NewYell(272582)
local specWarnFixate					= mod:NewSpecialWarningYou(275270, nil, nil, nil, 1, 2)
local specWarnHardenedArteries			= mod:NewSpecialWarningMoveAway(275189, nil, nil, nil, 1, 2)
local yellHardenedArteries				= mod:NewYell(275189)
local yellHardenedArteriesFades			= mod:NewShortFadesYell(275189)
local specWarnHardenedArteriesNear		= mod:NewSpecialWarningClose(275189, nil, nil, nil, 1, 2)
local specWarnEnlargedHeart				= mod:NewSpecialWarningYou(275205, nil, nil, nil, 1, 2)
local yellEnlargedHeart					= mod:NewYell(275205)
local yellEnlargedHeartFades			= mod:NewFadesYell(275205)
local specWarnEnlargedHeartTaunt		= mod:NewSpecialWarningTaunt(275205, "Tank", nil, nil, 1, 2)
local specWarnEnlargedHeartOther		= mod:NewSpecialWarningMoveTo(275205, "-Tank", nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

mod:AddTimerLine(BOSS)
local timerPlasmaDischargeCD			= mod:NewCDCountTimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
local timerCudgelOfGoreCD				= mod:NewCDCountTimer(58.2, 271296, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON, nil, 1, 4)--60.4-63
local timerSanguineStaticCD				= mod:NewCDTimer(53.6, 272582, nil, nil, nil, 3)--60.4-63
local timerEnlargedHeartCD				= mod:NewCDCountTimer(60.4, 275205, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_TANK_ICON, nil, 2, 4)--60.4-63 (also timer for hardened, go out at same time, no need for two)
mod:AddTimerLine(DBM:GetSpellInfo(271965))
local timerPoweredDown					= mod:NewBuffActiveTimer(88.6, 271965, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(275270, true)

local bloodStorm = DBM:GetSpellInfo(270290)
local ignoreGTFO = false
mod.vb.plasmaCast = 0
mod.vb.cudgelCount = 0
mod.vb.enlargedCount = 0
mod.vb.phase = 1

function mod:StaticTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSanguineStaticYou:Show()
		specWarnSanguineStaticYou:Play("targetyou")
		yellSanguineStatic:Yell()
	else
		specWarnSanguineStatic:Show()
		specWarnSanguineStatic:Play("watchwave")
	end
end

function mod:OnCombatStart(delay)
	self.vb.plasmaCast = 0
	self.vb.cudgelCount = 0
	self.vb.enlargedCount = 0
	self.vb.phase = 1
	timerPlasmaDischargeCD:Start(5.9-delay, 1)
	timerSanguineStaticCD:Start(18-delay)
	timerCudgelOfGoreCD:Start(31.2-delay, 1)
	if self:IsMythic() then
		timerEnlargedHeartCD:Start(24-delay, 1)
	end
	ignoreGTFO = false
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 271296 then
		if self:AntiSpam(5, 4) then--Don't incriment counter on stutter casts because tank died.
			self.vb.cudgelCount = self.vb.cudgelCount + 1
		end
		timerCudgelOfGoreCD:Start(nil, self.vb.cudgelCount+1)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnCudgelofGore:Show(bloodStorm)
			specWarnCudgelofGore:Play("targetyou")--Better voice maybe, or custom voice
		else
			specWarnCudgelofGoreEveryone:Show()
			specWarnCudgelofGoreEveryone:Play("justrun")
		end
		if self:IsTank() then
			ignoreGTFO = true
		end
	elseif spellId == 271728 then
		ignoreGTFO = false
		specWarnRetrieveCudgel:Show()
		specWarnRetrieveCudgel:Play("chargemove")
	elseif spellId == 271895 then--Sanguine Static
		self:BossUnitTargetScanner("boss1", "StaticTarget")
		timerSanguineStaticCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 271224 or spellId == 278888) and self:AntiSpam(3, 1) then
		self.vb.plasmaCast = self.vb.plasmaCast + 1
		if self.vb.phase == 1 then
			if self.vb.plasmaCast == 1 then
				timerPlasmaDischargeCD:Start(41, self.vb.plasmaCast+1)
			else
				timerPlasmaDischargeCD:Start(35, self.vb.plasmaCast+1)
			end
		else
			if self.vb.plasmaCast == 1 then
				timerPlasmaDischargeCD:Start(40, self.vb.plasmaCast+1)
			elseif self.vb.plasmaCast == 2 then
				timerPlasmaDischargeCD:Start(32.8, self.vb.plasmaCast+1)
			else
				timerPlasmaDischargeCD:Start(30, self.vb.plasmaCast+1)
			end
		end
	elseif spellId == 275205 then
		self.vb.enlargedCount = self.vb.enlargedCount + 1
		timerEnlargedHeartCD:Start(nil, self.vb.enlargedCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271224 or spellId == 278888 then
		warnPlastmaDischarge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 5) then
			specWarnPlasmaDischarge:Show()
			specWarnPlasmaDischarge:Play("runout")
			specWarnPlasmaDischarge:ScheduleVoice(1.5, "keepmove")
			yellPlasmaDischarge:Yell()
		end
	elseif spellId == 271965 then
		if self:IsTank() then
			ignoreGTFO = true
		end
		warnPoweringDown:Show()
		warnPoweringDown:Play("phasechange")
		timerPoweredDown:Start()
		timerPlasmaDischargeCD:Stop()
		timerCudgelOfGoreCD:Stop()
		timerSanguineStaticCD:Stop()
		timerEnlargedHeartCD:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(275270))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 275270)
		end
	elseif spellId == 275270 and self:AntiSpam(2, args.destName) then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 275189 then
		if args:IsPlayer() then
			specWarnHardenedArteries:Show()
			specWarnHardenedArteries:Play("runout")
			yellHardenedArteries:Yell()
			yellHardenedArteriesFades:Countdown(spellId)
			specWarnHardenedArteriesNear:Cancel()--Cancel CombinedShow if you get affected
		elseif self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnHardenedArteriesNear:CombinedShow(0.5, args.destName)
			specWarnHardenedArteriesNear:ScheduleVoice(0.5, "runaway")
		end
	elseif spellId == 275205 then
		if args:IsPlayer() then
			specWarnEnlargedHeart:Show()
			specWarnEnlargedHeart:Play("runout")
			yellEnlargedHeart:Yell()
			yellEnlargedHeartFades:Countdown(spellId)
		else
			if not DBM:UnitDebuff("player", 275189) then
				specWarnEnlargedHeartOther:Show(args.destName)
				specWarnEnlargedHeartOther:Play("helpsoak")
			end
			specWarnEnlargedHeartTaunt:Show(args.destName)
			specWarnEnlargedHeartTaunt:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271965 then
		ignoreGTFO = false
		self.vb.plasmaCast = 0
		self.vb.cudgelCount = 0
		self.vb.enlargedCount = 0
		self.vb.phase = 2
		warnPoweringDownOver:Show()
		warnPoweringDownOver:Play("phasechange")
		timerPoweredDown:Stop()
		timerPlasmaDischargeCD:Start(12.8, 1)--6
		timerSanguineStaticCD:Start(27)--18
		timerCudgelOfGoreCD:Start(37, 1)--35
		if self:IsMythic() then
			timerEnlargedHeartCD:Start(30.7, 1)
		end
	elseif spellId == 275189 then
		if args:IsPlayer() then
			yellHardenedArteriesFades:Cancel()
		end
	elseif spellId == 275205 then
		if args:IsPlayer() then
			yellEnlargedHeartFades:Cancel()
		end
	elseif spellId == 271224 or spellId == 278888 then
		if args:IsPlayer() then
			specWarnPlasmaDischarge:CancelVoice()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) and not ignoreGTFO then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
