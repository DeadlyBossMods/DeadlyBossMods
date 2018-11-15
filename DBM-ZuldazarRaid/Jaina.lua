local mod	= DBM:NewMod(2343, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(138967)--146409 or 146416 probably
mod:SetEncounterID(2281)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 287565 287626 285177 285459 290036 288221 288345 288475 288719 289219 289940 290084 288619 288747",
	"SPELL_CAST_SUCCESS 285725 287925 287626 285257 289220",
	"SPELL_AURA_APPLIED 285212 287490 289387 287925 285253 287626 288199 290053 288219 288212 288374 288412 288434 289220",
	"SPELL_AURA_APPLIED_DOSE 285212 285253",
	"SPELL_AURA_REMOVED 285212 287925 287626 288199 290053 288219 288212 288374 289220",
	"SPELL_AURA_REMOVED_DOSE 285212",
	"SPELL_PERIODIC_DAMAGE 288297",
	"SPELL_PERIODIC_MISSED 288297",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, rework Avalaunche
--TODO, Gathering Blizzard improvements?
--TODO, add additional mythic only spells/timers
--TODO, add frequency and priority, special warnings, announce spawn location if possible, etc
--TODO, detect set charge barrels, and add them to infoframe with time remaining
--TODO, find correct script ID or emote for bombard. Emote is a pretty safe bet with blizzards history
--TODO, canceling bombard timer if no Corsairs are up?
--TODO, GTFO for fire? you kinda need to stand in it for ice counter
--TODO, more intermission 1 stuff?
--TODO, move ship debuff CD timers to actual cast events instead of debuff
--TODO, separate cast hand of frost from spread hand of frost spellIds
--TODO, enable hand of frost timer when can separate cast ID from spread ID and get boss cast event
--TODO, work out icefall cast time and events to make sure got right event for 10 second cast.
--TODO, verify elemental and P 2.5 phase end being based on elemental dying
--TODO, improve elemental CDS to use GUID to handle the split mechanic on mythic.
--TODO, so many overlapping tank mechanics and journal doesn't even talk about most of them except for the one they flag as NOT a tank mechanic in all but one phase, wtf?
--TODO, rework interrupt to use vectis interrupt per GUID code for mythic
--TODO, orb of frost targetting and improve voice/warning for it
--TODO, shattering lance script and warning/cast timer
--TODO, what spells do Prismatic Images copy, so it can be handled by timer code
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnFrozenSolid					= mod:NewTargetNoFilterAnnounce(287490, 4)
--Stage One: Burning Seas
local warnCorsair						= mod:NewSpellAnnounce("ej19690", 2, "Interface\\ICONS\\Inv_tabard_kultiran", nil, nil, nil, nil, 7)
local warnMarkedTarget					= mod:NewTargetAnnounce(288038, 2)
local warnSetCharge						= mod:NewSpellAnnounce(285725, 2)
local warnIceShard						= mod:NewStackAnnounce(285253, 2, nil, "Tank")
local warnTimeWarp						= mod:NewSpellAnnounce(287925, 3)
--Stage Two: Frozen Wrath
local warnBurningExplosion				= mod:NewCastAnnounce(288221, 3)
local warnBroadside						= mod:NewTargetNoFilterAnnounce(288212, 2)
local warnSiegebreaker					= mod:NewTargetNoFilterAnnounce(288374, 3)
--Intermission 2
local warnHeartofFrost					= mod:NewTargetAnnounce(289220, 2)
local warnFrostNova						= mod:NewCastAnnounce(289219, 3)
--local warnShatteringLance				= mod:NewCastAnnounce(288671, 4)

--General
local specWarnFreezingBlood				= mod:NewSpecialWarningYou(289387, nil, nil, nil, 1, 2)
--Stage One: Burning Seas
local specWarnMarkedTarget				= mod:NewSpecialWarningRun(288038, nil, nil, nil, 4, 2)
local yellMarkedTarget					= mod:NewYell(288038, nil, false)
local specWarnBombard					= mod:NewSpecialWarningDodge(285828, nil, nil, nil, 2, 2)
local specWarAvalaunche					= mod:NewSpecialWarningMoveAway(287565, nil, nil, nil, 1, 2)
local specWarAvalauncheTaunt			= mod:NewSpecialWarningTaunt(287565, nil, nil, nil, 1, 2)
local specWarGraspofFrost				= mod:NewSpecialWarningDispel(287626, "Healer", nil, nil, 1, 2)
local specWarnFreezingBlast				= mod:NewSpecialWarningDodge(285177, nil, nil, nil, 2, 2)
local specWarnRingofIce					= mod:NewSpecialWarningRun(285459, nil, nil, nil, 4, 2)
--Stage Two: Frozen Wrath
local specWarnGTFO						= mod:NewSpecialWarningGTFO(288297, nil, nil, nil, 1, 8)
local specWarnBroadside					= mod:NewSpecialWarningYou(288212, nil, nil, nil, 1, 2)
local yellBroadside						= mod:NewYell(288212)
local yellBroadsideFades				= mod:NewShortFadesYell(288212)
local specWarnSiegebreaker				= mod:NewSpecialWarningMoveAway(288374, nil, nil, nil, 3, 2)
local yellSiegebreaker					= mod:NewYell(288374, nil, nil, nil, "YELL")
local yellSiegebreakerFades				= mod:NewShortFadesYell(288374, nil, nil, nil, "YELL")
local specWarnHandofFrost				= mod:NewSpecialWarningYou(288412, nil, nil, nil, 1, 2)
local yellHandofFrost					= mod:NewYell(288412)
local specWarnHandofFrostNear			= mod:NewSpecialWarningClose(288412, nil, nil, nil, 1, 2)
local specWarnGlacialRay				= mod:NewSpecialWarningDodge(288345, nil, nil, nil, 2, 2)
local specWarnIcefall					= mod:NewSpecialWarningDodge(288475, nil, nil, nil, 2, 2)
--Intermission 2
local specWarnTideElemental				= mod:NewSpecialWarningSwitch(285257, "-Healer", nil, nil, 1, 2)
local specWarnHeartofFrost				= mod:NewSpecialWarningMoveAway(289220, nil, nil, nil, 1, 2)
local yellHeartofFrost					= mod:NewYell(289220)
local specWarnWaterBoltVolley			= mod:NewSpecialWarningInterrupt(290084, "HasInterrupt", nil, nil, 1, 2)
--Stage Three:
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(288619, nil, nil, nil, 2, 2)
local specWarnPrismaticImage			= mod:NewSpecialWarningSwitch(288747, "Dps", nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Stage One: Burning Seas
local timerCorsairCD					= mod:NewAITimer(55, "ej19690", nil, nil, nil, 1, "Interface\\ICONS\\Inv_tabard_kultiran")
local timerBombardCD					= mod:NewAITimer(55, 285828, nil, nil, nil, 3)
local timerAvalancheCD					= mod:NewAITimer(14.1, 287565, nil, nil, nil, 5, 2)
local timerGraspofFrostCD				= mod:NewAITimer(55, 287626, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerFreezingBlastCD				= mod:NewAITimer(55, 285177, nil, nil, nil, 3)
local timerRingofIceCD					= mod:NewAITimer(55, 285459, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
--Stage Two: Frozen Wrath
local timerBroadsideCD					= mod:NewAITimer(55, 288212, nil, nil, nil, 3)
local timerSiegebreakerCD				= mod:NewAITimer(55, 288374, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerCrystallineDustCD			= mod:NewAITimer(14.1, 289940, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerHandofFrostCD				= mod:NewAITimer(55, 288412, nil, nil, nil, 3)
local timerGlacialRayCD					= mod:NewAITimer(55, 288345, nil, nil, nil, 3)
local timerIcefallCD					= mod:NewAITimer(55, 288475, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerIcefall						= mod:NewCastTimer(55, 288475, nil, nil, nil, 3)
--Intermission 2
local timerHeartofFrostCD				= mod:NewAITimer(55, 289220, nil, nil, nil, 3)
local timerFrostNovaCD					= mod:NewAITimer(55, 289219, nil, nil, nil, 2)
local timerWaterBoltVolleyCD			= mod:NewAITimer(55, 290084, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage 3
local timerOrbofFrostCD					= mod:NewAITimer(55, 288619, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerPrismaticImageCD				= mod:NewAITimer(55, 288747, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Burning Seas
--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)
--Stage Two: Frozen Wrath

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(10, 289379)
mod:AddInfoFrameOption(285212, false)--Will be changed to true later, right now it'll probably though too many thousands of errors to be on by default
mod:AddNamePlateOption("NPAuraOnMarkedTarget", 288038)
mod:AddNamePlateOption("NPAuraOnTimeWarp", 287925)
mod:AddNamePlateOption("NPAuraOnRefractiveIce", 288219)
mod:AddSetIconOption("SetIconGraspofFrost", 287626, true)

mod.vb.phase = 1
mod.vb.corsairCount = 0
mod.vb.GraspofFrostIcon = 1
local ChillingTouchStacks = {}

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local sortedLines = {}
	local function sortFuncDesc(a, b) return ChillingTouchStacks[a] > ChillingTouchStacks[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				local adjustedPower = currentPower / maxPower * 100
				if adjustedPower >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		addLine(" ", " ")--Insert a blank entry to split the two debuffs
		--Chilling Touch Stacks
		--Sort debuffs by highest then inject into regular table
		if #ChillingTouchStacks > 0 then
			tsort(ChillingTouchStacks, sortFuncDesc)
			for _, name in ipairs(ChillingTouchStacks) do
				addLine(name, ChillingTouchStacks[name])
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.corsairCount = 0
	self.vb.GraspofFrostIcon = 1
	table.wipe(ChillingTouchStacks)
	timerCorsairCD:Start(1-delay)
	timerAvalancheCD:Start(1-delay)
	timerGraspofFrostCD:Start(1-delay)
	timerFreezingBlastCD:Start(1-delay)
	timerRingofIceCD:Start(1-delay)
	if self.Options.RangeFrame and self:IsMythic() then
		DBM.RangeCheck:Show(10)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnMarkedTarget or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnMarkedTarget or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 287565 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarAvalaunche:Show()
			specWarAvalaunche:Play("runout")
		else
			specWarAvalauncheTaunt:Show(UnitName("boss1target"))
			specWarAvalauncheTaunt:Play("tauntboss")
		end
		timerAvalancheCD:Start()
	elseif spellId == 287626 then
		self.vb.GraspofFrostIcon = 1
	elseif spellId == 285177 then
		specWarnFreezingBlast:Show()
		specWarnFreezingBlast:Play("shockwave")
		timerFreezingBlastCD:Start()
	elseif spellId == 285459 or spellId == 290036 then
		specWarnRingofIce:Show()
		specWarnRingofIce:Play("justrun")
		timerRingofIceCD:Start()
	elseif spellId == 288221 and self:AntiSpam(3, 3) then
		warnBurningExplosion:Show()
	elseif spellId == 288345 then
		specWarnGlacialRay:Show()
		specWarnGlacialRay:Play("watchstep")
		timerGlacialRayCD:Start()
	elseif spellId == 288475 then
		specWarnIcefall:Show()
		specWarnIcefall:Play("watchstep")
		timerIcefallCD:Start()
		timerIcefall:Start()
	elseif spellId == 288719 then--Flash Freeze
		self.vb.phase = 2.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
		warnPhase:Play("phasechange")
		timerBroadsideCD:Stop()
		timerSiegebreakerCD:Stop()
		timerCrystallineDustCD:Stop()
		timerAvalancheCD:Stop()
		--timerHandofFrostCD:Stop()
		timerGlacialRayCD:Stop()
		timerIcefallCD:Stop()
	elseif spellId == 289219 then
		warnFrostNova:Show()
		timerFrostNovaCD:Start()
	elseif spellId == 289940 then
		timerCrystallineDustCD:Start()
	elseif spellId == 290084 then
		timerWaterBoltVolleyCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWaterBoltVolley:Show(args.sourceName)
			specWarnWaterBoltVolley:Play("kickcast")
		end
	elseif spellId == 288619 then
		specWarnOrbofFrost:Show()
		specWarnOrbofFrost:Play("watchorb")
		timerOrbofFrostCD:Start()
	elseif spellId == 288747 then
		specWarnPrismaticImage:Show()
		specWarnPrismaticImage:Play("killmob")
		timerPrismaticImageCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285725 then
		warnSetCharge:Show()
	elseif spellId == 287925 then
		warnTimeWarp:Show()
	elseif spellId == 287626 then
		timerGraspofFrostCD:Start()
	elseif spellId == 285257 then
		specWarnTideElemental:Show()
		specWarnTideElemental:Play("bigmob")
		timerHeartofFrostCD:Start(2)
		timerFrostNovaCD:Start(2)
		if self:IsHard() then
			timerWaterBoltVolleyCD:Start(2)
		end
	elseif spellId == 289220 then
		timerHeartofFrostCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285253 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 then
				warnIceShard:Show(args.destName, amount)
			end
		end
	elseif spellId == 285212 then
		ChillingTouchStacks[args.destName] = args.amount or 1
	elseif spellId == 287490 then
		warnFrozenSolid:CombinedShow(0.5, args.destName)
	elseif spellId == 289387 then
		if args:IsPlayer() and self:AntiSpam(6, 1) then
			specWarnFreezingBlood:Show()
			specWarnFreezingBlood:Play("gathershare")
		end
	elseif spellId == 288038 then
		warnMarkedTarget:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnMarkedTarget:Show()
				specWarnMarkedTarget:Play("justrun")
				yellMarkedTarget:Yell()
			end
			if self.Options.NPAuraOnMarkedTarget then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
			end
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 40)
		end
	elseif spellId == 287626 then
		specWarGraspofFrost:CombinedShow(0.5, args.destName)
		specWarGraspofFrost:ScheduleVoice(0.5, "helpdispel")
		if self.Options.SetIconGraspofFrost then
			self:SetIcon(args.destName, self.vb.GraspofFrostIcon)
		end
		self.vb.GraspofFrostIcon = self.vb.GraspofFrostIcon + 1
	elseif spellId == 288199 or spellId == 290053 then--Howling Winds
		self.vb.phase = 1.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerCorsairCD:Stop()
		timerAvalancheCD:Stop()
		timerGraspofFrostCD:Stop()
		timerFreezingBlastCD:Stop()
		timerRingofIceCD:Stop()
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		warnBroadside:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBroadside:Show()
			specWarnBroadside:Play("targetyou")
			yellBroadside:Yell()
			yellBroadsideFades:Countdown(4)
		end
		timerBroadsideCD:Start()
	elseif spellId == 288374 then
		if args:IsPlayer() then
			specWarnSiegebreaker:Show()
			specWarnSiegebreaker:Play("runout")
			yellSiegebreaker:Yell()
			yellSiegebreakerFades:Countdown(8)
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Show(10)
			end
		else
			warnSiegebreaker:Show(args.destName)
		end
		timerSiegebreakerCD:Start()
	elseif spellId == 288412 or spellId == 288434 then
		if args:IsPlayer() then
			specWarnHandofFrost:Show()
			specWarnHandofFrost:Play("targetyou")
			yellHandofFrost:Yell()
		elseif self:CheckNearby(12, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnHandofFrostNear:Show(args.destName)
			specWarnHandofFrostNear:Play("watchstep")
		end
	elseif spellId == 289220 then
		if args:IsPlayer() then
			specWarnHeartofFrost:Show()
			specWarnHeartofFrost:Play("runout")
			yellHeartofFrost:Yell()
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Show(10)
			end
		else
			warnHeartofFrost:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 285212 then
		ChillingTouchStacks[args.destName] = nil
	elseif spellId == 288038 then
		if self.Options.NPAuraOnMarkedTarget then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 287626 then
		if self.Options.SetIconGraspofFrost then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 288199 or spellId == 290053 then--Howling Winds
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerBroadsideCD:Start(2)
		timerSiegebreakerCD:Start(2)
		timerCrystallineDustCD:Start(2)
		timerAvalancheCD:Start(2)
		--timerHandofFrostCD:Start(2)
		timerGlacialRayCD:Start(2)
		if not self:IsLFR() then
			timerIcefallCD:Start(2)
		end
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		if args:IsPlayer() then
			yellBroadsideFades:Cancel()
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			yellSiegebreakerFades:Cancel()
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 289220 then
		if args:IsPlayer() then
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 285212 then
		ChillingTouchStacks[args.destName] = args.amount or 1
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 288297 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146765 then--Tide Elemental (or one of these, 149144, 149501, 149558)
		timerHeartofFrostCD:Stop()
		timerFrostNovaCD:Stop()
		timerWaterBoltVolleyCD:Stop()
		--Probably totally wrong, but just to have it coded, it can be moved later
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerBroadsideCD:Start(3)
		timerSiegebreakerCD:Start(3)
		timerCrystallineDustCD:Start(3)
		timerGlacialRayCD:Start(3)
		if not self:IsLFR() then
			timerIcefallCD:Start(3)
			timerPrismaticImageCD:Start(3)
		end
		if self:IsHard() then
			timerOrbofFrostCD:Start(3)
		end
	--elseif cid == 149535 then--Icebound Image
	
	--elseif cid == 148965 then--Kul Tiran Marine

	--elseif cid == 147531 or cid == 147180 or cid == 146811 then
		--self.vb.corsairCount = self.vb.corsairCount - 1
		--if self.vb.corsairCount == 0 then
			--timerBombardCD:Stop()
		--end
	--elseif cid == 148631 then--Unexploded Ordinance
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:285828") then
		specWarnBombard:Show()
		specWarnBombard:Play("watchstep")
		timerBombardCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 288013 then--Corsair Picker
		warnCorsair:Show()
		timerCorsairCD:Start()
		timerBombardCD:Start(2)--Assumed
	elseif spellId == 288405 or spellId == 288401 then--Ability Callout Corsair on the Port Side
		DBM:Debug("Corsair on the Port Side")
	elseif spellId == 288407 or spellId == 288406 then--Ability Callout Corsair on the Starboard Side
		DBM:Debug("Corsair on the Starboard Side")
	end
end
