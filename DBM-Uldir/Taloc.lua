local mod	= DBM:NewMod(2168, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134924)--Taloc 122276 or 134924
mod:SetEncounterID(2144)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 271296 271728",
	"SPELL_AURA_APPLIED 271224 271965",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 271225 271965",
	"SPELL_PERIODIC_DAMAGE 270290",
	"SPELL_PERIODIC_MISSED 270290",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1"
)

--TODO, add icon setting later when a good cleanup method is detectable.
--TODO, way to detect Volatile Droplet fixates? Maybe scan all nearby nameplates for Status 3 threat?
--TODO, detect Blood Spawns
--TODO, verify/fix SanguineStatic
--TODO, verify GTFO
local warnPoweringDown					= mod:NewSpellAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnPlastmaDischarge				= mod:NewTargetAnnounce(271225, 2)

local specWarnPlasmaDischarge			= mod:NewSpecialWarningMoveAway(271225, nil, nil, nil, 3, 2)
local yellPlasmaDischarge				= mod:NewYell(271225)
local specWarnCudgelofGore				= mod:NewSpecialWarningMoveTo(271296, nil, nil, nil, 3, 2)
local specWarnCudgelofGoreTaunt			= mod:NewSpecialWarningTaunt(271296, nil, nil, nil, 1, 2)
local specWarnRetrieveCudgel			= mod:NewSpecialWarningDodge(271728, nil, nil, nil, 2, 2)
local specWarnSanguineStatic			= mod:NewSpecialWarningDodge(272582, nil, nil, nil, 2, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 2)

mod:AddTimerLine(BOSS)
local timerPlasmaDischargeCD			= mod:NewAITimer(12.1, 271225, nil, nil, nil, 3)--Change to count later
local timerCudgelOfGoreCD				= mod:NewAITimer(12.1, 271296, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSanguineStaticCD				= mod:NewAITimer(12.1, 272582, nil, nil, nil, 3)
mod:AddTimerLine(DBM:GetSpellInfo(271965))
local timerPoweredDown					= mod:NewBuffActiveTimer(90, 271965, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRealityTear				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconPlasmaDischarge", 271225, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(272584, true)

local bloodStorm = DBM:GetSpellInfo(270290)

function mod:OnCombatStart(delay)
	timerPlasmaDischargeCD:Start(1-delay)
	timerCudgelOfGoreCD:Start(1-delay)
	timerSanguineStaticCD:Start(1-delay)
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
	if spellId == 271296 then
		timerCudgelOfGoreCD:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnCudgelofGore:Show(bloodStorm)
			specWarnCudgelofGore:Play("targetyou")--Better voice maybe, or custom voice
		else
			--Taunt boss now?
			--specWarnCudgelofGoreTaunt:Show()
			--specWarnCudgelofGoreTaunt:Play("tauntboss")
		end
	elseif spellId == 271728 then
		specWarnRetrieveCudgel:Show()
		specWarnRetrieveCudgel:Play("chargemove")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271224 then
		warnPlastmaDischarge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPlasmaDischarge:Show()
			specWarnPlasmaDischarge:Play("runout")
			specWarnPlasmaDischarge:ScheduleVoice(1.5, "keepmove")
			yellPlasmaDischarge:Yell()
		end
		if self:AntiSpam(8, 1) then--Temp location hopefully
			timerPlasmaDischargeCD:Start()
		end
	elseif spellId == 271965 then
		warnPoweringDown:Show()
		warnPoweringDown:Play("phasechange")
		timerPoweredDown:Start()
		timerPlasmaDischargeCD:Stop()
		timerCudgelOfGoreCD:Stop()
		timerSanguineStaticCD:Stop()
		if self.Options.AggroFrame then--Show aggro frame regardless if health frame is still up, it should be more important than health frame at this point. Shouldn't be blowing up traps while elementals are up.
			DBM.InfoFrame:SetHeader(L.Aggro)
			--Smart into frame that shows all players that have aggro that aren't tanks (if aggro i detectable on invisible stalkers anyways)
			DBM.InfoFrame:Show(5, "playeraggro", 2, true)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271225 then--Used later with icon feature

	elseif spellId == 271965 then
		timerPoweredDown:Stop()
		timerPlasmaDischargeCD:Start(2)
		timerCudgelOfGoreCD:Start(2)
		timerSanguineStaticCD:Start(2)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end
--]]

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 271895 then--Sanguine Static
		specWarnSanguineStatic:Show()
		specWarnSanguineStatic:Play("watchwave")
		timerSanguineStaticCD:Start()
	end
end

