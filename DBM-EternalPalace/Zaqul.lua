local mod	= DBM:NewMod(2349, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(151586)
mod:SetEncounterID(2293)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 292565 292963 296257 296262 303978 301068 303543 302593 296018",
	"SPELL_CAST_SUCCESS 292963 302503 302219 293509 303543 296018 302504",
	"SPELL_SUMMON 300732",
	"SPELL_AURA_APPLIED 292971 292981 295480 295495 300133 292963 302503 293509 295327 303971 296078 303543 296018 302504",
	"SPELL_AURA_APPLIED_DOSE 292971",
	"SPELL_AURA_REMOVED 292971 292963 293509 303971 296078 303543 296018",
	"SPELL_AURA_REMOVED_DOSE 292971",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify portal of madness event
--TODO, verify spellIds for Mind Tether
--TODO, https://ptr.wowhead.com/spell=300635/gathering-nightmare track via nameplate number of stacks
--TODO, infoframe detecting number of players in each realm, and showing realm player is in?
--TODO, real phase triggers (especially phase 4 which is harder to dirty code like 2 and 3 were)
--TODO, dark pulse absorb shield on custom infoframe
--TODO, warning filters/timer fades for images/split on mythic stage 4?
--TODO, void slam, who does it target? random or the tank? if random, can we target scan it?
--TODO, pause/resume (or reset) timers for boss shielding/split phase in stage 4
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnDiscipleofNzoth				= mod:NewTargetNoFilterAnnounce(292981, 4)
--Stage One: The Herald
local warnMindTether					= mod:NewTargetSourceAnnounce(295444, 3)
local warnSnapped						= mod:NewTargetNoFilterAnnounce(300133, 4, nil, "Tank|Healer")
local warnUnleashedNightmare			= mod:NewSpellAnnounce("ej20289", 3, 300732)
local warnDread							= mod:NewTargetNoFilterAnnounce(292963, 3, nil, "Healer")
--Stage Two: Grip of Fear
--Stage Three: Delirium's Descent
--Stage Four: All Pathways Open
local warnDreadScream					= mod:NewTargetNoFilterAnnounce(303543, 3, nil, "Healer")--Mythic
local warnManicDread					= mod:NewTargetNoFilterAnnounce(296018, 3, nil, "Healer")

local specWarnHysteria					= mod:NewSpecialWarningStack(292971, nil, 15, nil, nil, 1, 6)
--Stage One: The Herald
local specWarnHorrificSummoner			= mod:NewSpecialWarningSwitch("ej20172", "-Healer", nil, nil, 1, 2)
local specWarnCrushingGrasp				= mod:NewSpecialWarningDodge(292565, nil, nil, nil, 2, 2)
local yellDreadFades					= mod:NewIconFadesYell(292963)
--Stage Two: Grip of Fear
local specWarnManifedNightmares			= mod:NewSpecialWarningYou(293509, nil, nil, nil, 1, 2)
local yellManifedNightmares				= mod:NewYell(293509)
local yellManifedNightmaresFades		= mod:NewShortFadesYell(293509)
local specWarnMaddeningEruption			= mod:NewSpecialWarningMoveTo(292996, "Tank", nil, nil, 1, 2)
--Stage Three: Delirium's Descent
local specWarShatteredPsyche			= mod:NewSpecialWarningDispel(295327, "Healer", nil, 3, 1, 2)
--Stage Four: All Pathways Open
local specWarnDarkPulse					= mod:NewSpecialWarningSwitch(303978, "-Healer", nil, nil, 1, 2)
local specWarnPsychoticSplit			= mod:NewSpecialWarningSwitch(301068, "-Healer", nil, nil, 1, 2)
local yellDreadScreamFades				= mod:NewIconFadesYell(303543)--Mythic
local specWarnVoidSlam					= mod:NewSpecialWarningDodge(302593, nil, nil, nil, 2, 2)--Mythic
local yellManicDreadFades				= mod:NewIconFadesYell(296018)

--local specWarnGTFO					= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: The Herald
local timerPortalofMadnessCD			= mod:NewAITimer(30.4, 294545, nil, nil, nil, 1)
local timerCrushingGraspCD				= mod:NewAITimer(30.4, 292565, nil, nil, nil, 3)
local timerDreadCD						= mod:NewAITimer(30.4, 292963, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)
--Stage Two: Grip of Fear
local timerManifestNightmaresCD			= mod:NewAITimer(58.2, 293509, nil, nil, nil, 3)
local timerMaddeningEruptionCD			= mod:NewAITimer(58.2, 292996, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage Three: Delirium's Descent
--Stage Four: All Pathways Open
local timerDarkPulseCD					= mod:NewAITimer(58.2, 303978, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)--Non Mythic
local timerPsychoticSplitCD				= mod:NewAITimer(58.2, 301068, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)--Mythic
local timerDreadScreamCD				= mod:NewAITimer(58.2, 303543, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)--Mythic
local timerVoidSlamCD					= mod:NewAITimer(58.2, 302593, nil, nil, nil, 3)--Mythic
local timerDarkPassageD					= mod:NewAITimer(58.2, 299705, nil, nil, nil, 1)--All
local timerManicDreadCD					= mod:NewAITimer(30.4, 296018, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(292971, true)
mod:AddSetIconOption("SetIconDread", 292963, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconDreadScream", 303543, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconManicDreadScream", 296018, true, false, {1, 2, 3})

mod.vb.phase = 1
mod.vb.dreadIcon = 1
--mod.vb.nightmaresCount = 0
local HysteriaStacks = {}

function mod:OnCombatStart(delay)
	table.wipe(HysteriaStacks)
	self.vb.phase = 1
	self.vb.dreadIcon = 1
	--self.vb.nightmaresCount = 0
	timerPortalofMadnessCD:Start(1-delay)
	timerCrushingGraspCD:Start(1-delay)
	timerDreadCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(292971))
		DBM.InfoFrame:Show(10, "table", HysteriaStacks, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 292565 then
		specWarnCrushingGrasp:Show()
		specWarnCrushingGrasp:Play("farfromline")
		timerCrushingGraspCD:Start()
	elseif spellId == 303543 or spellId == 296018 or spellId == 292963 then--302503 and 302504 excluded (LFR ids)
		self.vb.dreadIcon = 1
	elseif spellId == 296257 and self.vb.phase < 2 then--Opening Fear Realm
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerPortalofMadnessCD:Stop()
		timerCrushingGraspCD:Stop()
		timerDreadCD:Stop()
		timerPortalofMadnessCD:Start(2)
		timerCrushingGraspCD:Start(2)
		timerDreadCD:Start(2)
		timerManifestNightmaresCD:Start(2)
		timerMaddeningEruptionCD:Start(2)
	elseif spellId == 296262 and self.vb.phase < 3 then--Opening Delirium Realm
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerCrushingGraspCD:Stop()
		timerDreadCD:Stop()
		timerManifestNightmaresCD:Stop()
		timerMaddeningEruptionCD:Stop()
		timerPortalofMadnessCD:Start(3)
		timerCrushingGraspCD:Start(3)
		timerDreadCD:Start(3)
	elseif spellId == 303978 then--Dark Pulse
		specWarnDarkPulse:Show()
		specWarnDarkPulse:Play("attackshield")
		timerDarkPulseCD:Start()
	elseif spellId == 301068 then
		specWarnPsychoticSplit:Show()
		specWarnPsychoticSplit:Play("changetarget")
		timerPsychoticSplitCD:Start()
		timerDreadScreamCD:Start(4)
		timerVoidSlamCD:Start(4)
	elseif spellId == 302593 then
		specWarnVoidSlam:Show()
		specWarnVoidSlam:Play("shockwave")
		timerVoidSlamCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 292963 or spellId == 302503 then--Dread
		timerDreadCD:Start()
	elseif spellId == 296018 or spellId == 302504 then--Manic Dread (302504 LFR)
		timerManicDreadCD:Start()
	elseif spellId == 302219 and self.vb.phase < 4 then--Reality Portal (shit detection for mythic, needs replacing)
		self.vb.phase = 4
		timerCrushingGraspCD:Stop()
		timerDreadCD:Stop()
		timerCrushingGraspCD:Start(4)
		timerDarkPassageD:Start(4)
		if self:IsMythic() then
			timerPsychoticSplitCD:Start(4)
		else
			timerDarkPulseCD:Start(4)
		end
		timerManicDreadCD:Start(4)
	elseif spellId == 293509 then
		timerManifestNightmaresCD:Start()
	elseif spellId == 303543 then
		timerDreadScreamCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 300732 then
		warnUnleashedNightmare:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 292971 then
		local amount = args.amount or 1
		HysteriaStacks[args.destName] = amount
		if args:IsPlayer() and (amount >= 15 and amount % 2 == 1) then--15, 17, 19
			specWarnHysteria:Show(amount)
			specWarnHysteria:Play("stackhigh")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(HysteriaStacks)
		end
	elseif spellId == 292981 then
		warnDiscipleofNzoth:CombinedShow(1, args.destName)
	elseif spellId == 295480 or spellId == 295495 then
		warnMindTether:Show(args.sourceName, args.destName)
	elseif spellId == 300133 then
		warnSnapped:Show(args.destName)
	elseif spellId == 292963 or spellId == 302503 then
		warnDread:CombinedShow(0.3, args.destName)
		if spellId == 292963 then--Non LFR
			local icon = self.vb.dreadIcon
			if args:IsPlayer() then
				yellDreadFades:Countdown(10, nil, icon)
			end
			if self.Options.SetIconDread then
				self:SetIcon(args.destName, icon)
			end
			self.vb.dreadIcon = self.vb.dreadIcon + 1
		end
	elseif spellId == 296018 or spellId == 302504 then
		warnManicDread:CombinedShow(0.3, args.destName)
		if spellId == 296018 then--Non LFR
			local icon = self.vb.dreadIcon
			if args:IsPlayer() then
				yellManicDreadFades:Countdown(10, nil, icon)
			end
			if self.Options.SetIconManicDreadScream then
				self:SetIcon(args.destName, icon)
			end
			self.vb.dreadIcon = self.vb.dreadIcon + 1
		end
	elseif spellId == 303543 then--Mythic Only
		warnDreadScream:CombinedShow(0.3, args.destName)
		local icon = self.vb.dreadIcon
		if args:IsPlayer() then
			yellDreadScreamFades:Countdown(10, nil, icon)
		end
		if self.Options.SetIconDreadScream then
			self:SetIcon(args.destName, icon)
		end
		self.vb.dreadIcon = self.vb.dreadIcon + 1
	elseif spellId == 293509 then
		--self.vb.nightmaresCount = self.vb.nightmaresCount + 1
		if args:IsPlayer() then
			specWarnManifedNightmares:Show()
			specWarnManifedNightmares:Play("targetyou")
			yellManifedNightmares:Yell()
			yellManifedNightmaresFades:Countdown(6)
		end
	elseif spellId == 295327 then
		if self:CheckDispelFilter() then
			specWarShatteredPsyche:CombinedShow(1, args.destName)
			specWarShatteredPsyche:ScheduleVoice(1, "helpdispel")
		end
	elseif spellId == 303971 or spellId == 296078 then--Dark Pulse
		--timerDarkPassageD:Stop()
		--timerCrushingGraspCD:Stop()
		--timerManicDreadCD:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 292971 then
		HysteriaStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(HysteriaStacks)
		end
	elseif spellId == 292963 then--Non LFR
		if args:IsPlayer() then
			yellDreadFades:Cancel()
		end
		if self.Options.SetIconDread then
			self:SetIcon(args.destName, 0)
		end
	if spellId == 296018 then--Non LFR
		if args:IsPlayer() then
			yellManicDreadFades:Cancel()
		end
		if self.Options.SetIconManicDreadScream then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 303543 then--Mythic Only
		if args:IsPlayer() then
			yellDreadScreamFades:Cancel()
		end
		if self.Options.SetIconDreadScream then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 293509 then
		--self.vb.nightmaresCount = self.vb.nightmaresCount - 1
		if args:IsPlayer() then
			yellManifedNightmaresFades:Cancel()
		end
	elseif spellId == 303971 or spellId == 296078 then--Dark Pulse
		--timerDarkPassageD:Start()
		--timerCrushingGraspCD:Start()
		--timerManicDreadCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 292971 then
		HysteriaStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(HysteriaStacks)
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 154175 then--Horric Summoner

	elseif cid == 154682 then--echo-of-fear
		timerDreadScreamCD:Stop()
	elseif cid == 154685 then--echo-of-delirium
		timerVoidSlamCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 294542 then--Portal of Madness
		specWarnHorrificSummoner:Show()
		specWarnHorrificSummoner:Play("bigmob")
		timerPortalofMadnessCD:Start()
	elseif (spellId == 302145 or spellId == 294957) and self:AntiSpam(5, 1) then
		specWarnMaddeningEruption:Show(L.Tear)
		specWarnMaddeningEruption:Play("moveboss")
		timerMaddeningEruptionCD:Start()
	elseif spellId == 299703 then--Dark Passage
		specWarnHorrificSummoner:Show()
		specWarnHorrificSummoner:Play("bigmob")
		timerDarkPassageD:Start()
	end
end
