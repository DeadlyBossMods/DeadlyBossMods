local mod	= DBM:NewMod(2354, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(153142)
mod:SetEncounterID(2304)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297402 297398 297324",
	"SPELL_CAST_SUCCESS 298055 296725 296944",
	"SPELL_SUMMON 296555",
	"SPELL_AURA_APPLIED 296650 296725 296943 296940 296942 296939 296941 296938",
	"SPELL_AURA_REMOVED 296650 296943 296940 296942 296939 296941 296938",
	"SPELL_PERIODIC_DAMAGE 296752",
	"SPELL_PERIODIC_MISSED 296752",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify and correct rippling wave event
--TODO, verify combat start timers ok where they are.
--TODO, expand infoframe functions to include arcing stuff?
local warnShield						= mod:NewTargetNoFilterAnnounce(296650, 2, nil, nil, nil, nil, nil, 2)
local warnShieldOver					= mod:NewEndAnnounce(296650, 2, nil, nil, nil, nil, nil, 2)
local warnCoral							= mod:NewCountAnnounce(296555, 2)
local warnCrushingDepths				= mod:NewTargetNoFilterAnnounce(297324, 4)
local warnUpsurge						= mod:NewSpellAnnounce(298055, 3)

local specWarnRipplingWave				= mod:NewSpecialWarningCount(296688, nil, nil, nil, 2, 2)
local specWarnCrushingDepths			= mod:NewSpecialWarningMoveAway(297324, nil, nil, nil, 1, 2)
local yellCrushingDepths				= mod:NewYell(297324)
local specWarnCrushingNear				= mod:NewSpecialWarningClose(297324, nil, nil, nil, 1, 2)
local specWarnBarnacleBash				= mod:NewSpecialWarningTaunt(296725, nil, nil, nil, 1, 2)
local specWarnArcingAzerite				= mod:NewSpecialWarningMoveTo(296944, nil, nil, nil, 3, 6)
local yellArcingAzerite					= mod:NewPosYell(296944, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local yellArcingAzeriteFades			= mod:NewIconFadesYell(296944)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(296752, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerShieldCD						= mod:NewAITimer(30.4, 296650, nil, nil, nil, 6)
local timerCoralGrowthCD				= mod:NewAITimer(30.4, 296555, nil, nil, nil, 3)
local timerRipplingwaveCD				= mod:NewAITimer(30.4, 296688, nil, nil, nil, 3)
local timerCrushingDepthsCD				= mod:NewAITimer(30.4, 297324, nil, nil, nil, 3)
local timerUpsurgeCD					= mod:NewAITimer(30.4, 298055, nil, nil, nil, 3)
local timerBarnacleBashCD				= mod:NewAITimer(58.2, 296725, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerArcingAzeriteCD				= mod:NewAITimer(30.4, 296944, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

mod:AddRangeFrameOption("4/12")
mod:AddInfoFrameOption(296650, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)

--mod.vb.phase = 1
mod.vb.coralGrowth = 0
mod.vb.ripplingWave = 0

function mod:CrushingTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then
		if targetname == UnitName("player") then
			specWarnCrushingDepths:Show()
			specWarnCrushingDepths:Play("runout")
			yellCrushingDepths:Yell()
		elseif self:CheckNearby(12, targetname) then
			specWarnCrushingNear:Show(targetname)
			specWarnCrushingNear:Play("runaway")
		else
			warnCrushingDepths:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.coralGrowth = 0
	self.vb.ripplingWave = 0
	--No timers on pull for now, in theory they should start with shield applying when boss engages
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297402 or spellId == 297398 or spellId == 297324 then
		timerCrushingDepthsCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "CrushingTarget", 0.1, 16, true, nil, nil, nil, false)--Does this target tank? if not, change false to true
	elseif spellId == 267180 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
		--	specWarnVoidbolt:Show(args.sourceName)
			--specWarnVoidbolt:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 298055 then
		warnUpsurge:Show()
		timerUpsurgeCD:Start()
	elseif spellId == 296725 then
		timerBarnacleBashCD:Start()
	elseif spellId == 296944 then

	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 296555 and self:AntiSpam(3, 1) then
		self.vb.coralGrowth = self.vb.coralGrowth + 1
		warnCoral:Show(self.vb.coralGrowth)
		timerCoralGrowthCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296650 then
		warnShield:Show(args.destName)
		warnShield:Play("phasechange")
		self.vb.coralGrowth = 0
		self.vb.ripplingWave = 0
		timerUpsurgeCD:Stop()
		timerBarnacleBashCD:Stop()
		timerCrushingDepthsCD:Stop()
		timerArcingAzeriteCD:Stop()
		timerCoralGrowthCD:Start(1)
		timerRipplingwaveCD:Start(1)
		timerCrushingDepthsCD:Start(1)
		timerUpsurgeCD:Start(1)
		timerBarnacleBashCD:Start(1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs("boss1"))
		end
		if self.Options.RangeFrame then
			if self:IsRanged() then
				DBM.RangeCheck:Show(12)
			else
				DBM.RangeCheck:Show(4)
			end
		end
	elseif spellId == 296725 then
		if not args:IsPlayer() then
			specWarnBarnacleBash:Show(args.destName)
			specWarnBarnacleBash:Play("tauntboss")
		end
	elseif spellId == 296943 or spellId == 296940 or spellId == 296942 or spellId == 296939 or spellId == 296941 or spellId == 296938 then--Arcing Azerite
		if (spellId == 296943 or spellId == 296940) and args:IsPlayer() then--Purple K
			specWarnArcingAzerite:Show("|TInterface\\Icons\\Boss_OdunRunes_Purple.blp:12:12|tNE|TInterface\\Icons\\Boss_OdunRunes_Purple.blp:12:12|t")
			specWarnArcingAzerite:Play("mm3")
			yellArcingAzerite:Yell(3, "", 3)
			yellArcingAzeriteFades:Countdown(8, nil, 3)
		elseif (spellId == 296942 or spellId == 296939) and args:IsPlayer() then--Orange N
			specWarnArcingAzerite:Show("|TInterface\\Icons\\Boss_OdunRunes_Orange.blp:12:12|tSE|TInterface\\Icons\\Boss_OdunRunes_Orange.blp:12:12|t")
			specWarnArcingAzerite:Play("mm2")
			yellArcingAzerite:Yell(2, "", 2)
			yellArcingAzeriteFades:Countdown(8, nil, 2)
		elseif (spellId == 296941 or spellId == 296938) and args:IsPlayer() then--Green box
			specWarnArcingAzerite:Show("|TInterface\\Icons\\Boss_OdunRunes_Green.blp:12:12|tN|TInterface\\Icons\\Boss_OdunRunes_Green.blp:12:12|t")
			specWarnArcingAzerite:Play("mm4")
			yellArcingAzerite:Yell(4, "", 4)
			yellArcingAzeriteFades:Countdown(8, nil, 4)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271965 then
		warnShieldOver:Show()
		warnShieldOver:Play("phasechange")
		--timerShieldCD:Start()
		timerCoralGrowthCD:Stop()
		timerRipplingwaveCD:Stop()
		timerCrushingDepthsCD:Stop()
		timerUpsurgeCD:Stop()
		timerBarnacleBashCD:Stop()
		timerCrushingDepthsCD:Start(2)
		timerUpsurgeCD:Start(2)
		timerBarnacleBashCD:Start(2)
		timerArcingAzeriteCD:Start(2)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			DBM.InfoFrame:Show(2, "enemypower", 2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif spellId == 296943 or spellId == 296940 or spellId == 296942 or spellId == 296939 or spellId == 296941 or spellId == 296938 then--Arcing Azerite
		if args:IsPlayer() then
			yellArcingAzeriteFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 296752 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135824 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 296671 and self:AntiSpam(5, 2) then--Rippling Wave
		self.vb.ripplingWave = self.vb.ripplingWave + 1
		specWarnRipplingWave:Show(self.vb.ripplingWave)
		specWarnRipplingWave:Play("watchwave")
		timerRipplingwaveCD:Start()
	end
end

