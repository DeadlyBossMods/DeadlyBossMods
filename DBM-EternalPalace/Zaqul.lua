local mod	= DBM:NewMod(2349, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150859)
mod:SetEncounterID(2293)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 301141 292963 296257 303978 301068 303543 302593 296018 304733 296078 295814",
	"SPELL_CAST_SUCCESS 292963 302503 293509 303543 296018 302504 295444 294515 299708",
	"SPELL_SUMMON 300732",
	"SPELL_AURA_APPLIED 292971 292981 295480 300133 292963 302503 293509 295327 303971 296078 303543 296018 302504 295249",
	"SPELL_AURA_APPLIED_DOSE 292971",
	"SPELL_AURA_REMOVED 292971 292963 293509 303971 296078 303543 296018 295249",
	"SPELL_AURA_REMOVED_DOSE 292971",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://ptr.wowhead.com/spell=300635/gathering-nightmare track via nameplate number of stacks
--TODO, infoframe detecting number of players in each realm, and showing realm player is in?
--TODO, dark pulse absorb shield on custom infoframe
--TODO, warning filters/timer fades for images/split on mythic stage 4?
--TODO, void slam, who does it target? random or the tank? if random, can we target scan it?
--TODO, pause/resume (or reset) timers for boss shielding/split phase in stage 4 mythic?
--[[
(ability.id = 301141 or ability.id = 303543 or ability.id = 296018 or ability.id = 292963 or ability.id = 296257 or ability.id = 304733 or ability.id = 303978 or ability.id = 302593 or ability.id = 296078 or ability.id = 295814) and type = "begincast"
 or (ability.id = 292963 or ability.id = 302503 or ability.id = 296018 or ability.id = 302504 or ability.id = 303543 or ability.id = 295444 or ability.id = 294515 or ability.id = 299708) and type = "cast"
 or (ability.id = 300584 or ability.id = 293509 or ability.id = 296084) and type = "applydebuff"
 or ability.id = 292963 or ability.id = 302503 or ability.id = 296018 or ability.id = 302504
--]]
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnDiscipleofNzoth				= mod:NewTargetNoFilterAnnounce(292981, 4)
--Stage One: The Herald
local warnMindTether					= mod:NewTargetSourceAnnounce(295444, 3)
local warnSnapped						= mod:NewTargetNoFilterAnnounce(300133, 4, nil, "Tank|Healer")
local warnUnleashedNightmare			= mod:NewSpellAnnounce("ej20289", 3, 300732)
local warnDread							= mod:NewTargetNoFilterAnnounce(292963, 3, nil, "Healer")
--Stage Two: Grip of Fear
--Stage Three: Delirium's Descent
local warnDeliriumsDescent				= mod:NewCountAnnounce(304733, 3)
--Stage Four: All Pathways Open
local warnDreadScream					= mod:NewTargetNoFilterAnnounce(303543, 3, nil, "Healer")--Mythic
local warnManicDread					= mod:NewTargetNoFilterAnnounce(296018, 3, nil, "Healer")

local specWarnHysteria					= mod:NewSpecialWarningStack(292971, nil, 15, nil, nil, 1, 6)
--Stage One: The Herald
local specWarnHorrificSummoner			= mod:NewSpecialWarningSwitch("ej20172", "-Healer", nil, nil, 1, 2)
local specWarnCrushingGrasp				= mod:NewSpecialWarningDodge(292565, nil, nil, nil, 2, 2)
local yellDread							= mod:NewPosYell(292963)
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
local yellDreadScream					= mod:NewPosYell(303543)
local yellDreadScreamFades				= mod:NewIconFadesYell(303543)--Mythic
local specWarnVoidSlam					= mod:NewSpecialWarningDodge(302593, nil, nil, nil, 2, 2)--Mythic
local yellManicDread					= mod:NewPosYell(296018)
local yellManicDreadFades				= mod:NewIconFadesYell(296018)

--local specWarnGTFO					= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: The Herald
local timerHorrificSummonerCD			= mod:NewCDTimer(80.1, "ej20172", nil, nil, nil, 1, 294515, DBM_CORE_DAMAGE_ICON)
local timerCrushingGraspCD				= mod:NewCDTimer(31.4, 292565, nil, nil, nil, 3)
local timerDreadCD						= mod:NewCDTimer(75.4, 292963, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)--One dread timer used for all versions (cast by boss)
local timerMindTetherCD					= mod:NewCDTimer(47.8, 295444, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--52.3
--Stage Two: Grip of Fear
local timerManifestNightmaresCD			= mod:NewCDTimer(35, 293509, nil, nil, nil, 3)
local timerMaddeningEruptionCD			= mod:NewCDTimer(66.4, 292996, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage Three: Delirium's Descent
local timerDeliriumsDescentCD			= mod:NewCDTimer(35, 304733, nil, nil, nil, 3)
--Stage Four: All Pathways Open
local timerDarkPulseCD					= mod:NewCDTimer(93.5, 303978, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)
local timerManicDreadCD					= mod:NewCDTimer(75.4, 296018, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)--75-83
----Mythic
local timerPsychoticSplitCD				= mod:NewCDTimer(100, 301068, nil, nil, nil, 6, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON)--Mythic
local timerPsychoticSplit				= mod:NewCastTimer(25, 301068, nil, nil, nil, 5, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DAMAGE_ICON)
local timerDreadScreamCD				= mod:NewCDTimer(8.5, 303543, nil, "Healer", nil, 5, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_MAGIC_ICON)--Mythic
local timerVoidSlam						= mod:NewCastTimer(4.1, 302593, nil, nil, nil, 3)--Mythic

local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(292971, true)
mod:AddSetIconOption("SetIconDread", 292963, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconDreadScream", 303543, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconManicDreadScream", 296018, true, false, {1, 2, 3, 4})

mod.vb.phase = 1
mod.vb.dreadIcon = 1
mod.vb.DeliriumsDescentCount = 0
--mod.vb.nightmaresCount = 0
local HysteriaStacks = {}
local playerDRealm = false

function mod:OnCombatStart(delay)
	table.wipe(HysteriaStacks)
	self.vb.phase = 1
	self.vb.dreadIcon = 1
	self.vb.DeliriumsDescentCount = 0
	--self.vb.nightmaresCount = 0
	timerMindTetherCD:Start(3.3-delay)
	timerDreadCD:Start(12-delay)
	timerHorrificSummonerCD:Start(25.4-delay)--20 sec for event, but the portal happens 5 seconds AFTER event
	timerCrushingGraspCD:Start(30-delay)
	berserkTimer:Start(600-delay)
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
	if spellId == 301141 then
		specWarnCrushingGrasp:Show()
		specWarnCrushingGrasp:Play("farfromline")
		--In perfect scenario, not delayed very much if ever even by phase changes
		--Crushing Grasp-292565-npc:151034 = pull:31.9, 31.6, 31.6, 31.6, 35.6, 34.8
		timerCrushingGraspCD:Start()
	elseif spellId == 303543 or spellId == 296018 or spellId == 292963 then--302503 and 302504 excluded (LFR ids)
		self.vb.dreadIcon = 1
	elseif spellId == 296257 and self.vb.phase < 2 then--Opening Fear Realm
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		--Timers that never stop, but might need time added to them if they come off cd during transition
		--timerDreadCD:Stop()
		--New Stage 2 timers
		timerManifestNightmaresCD:Start(37.2)
		timerHorrificSummonerCD:SetFade(true)--Start fading this timer until P4, timer still exists on the script loop, but we just want to dim timer until it means something again
		--timerMaddeningEruptionCD:Start(1)--1-3 seconds after this cast
	elseif spellId == 304733 then--Delirium's Descent
		if self.vb.phase < 3 then
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--Timers actually stopped
			--timerManifestNightmaresCD:Stop()
			--Timers that never stop, but might need time added to them if they come off cd during transition
			--timerDreadCD:Stop()
			--timerCrushingGraspCD:Stop()
		end
		self.vb.DeliriumsDescentCount = self.vb.DeliriumsDescentCount + 1
		warnDeliriumsDescent:Show(self.vb.DeliriumsDescentCount)
		timerDeliriumsDescentCD:Start()
	elseif spellId == 303978 or spellId == 296078 then--Dark Pulse
		specWarnDarkPulse:Show()
		specWarnDarkPulse:Play("attackshield")
		timerDarkPulseCD:Start()
	elseif spellId == 295814 then
		specWarnPsychoticSplit:Show()
		specWarnPsychoticSplit:Play("changetarget")
		timerPsychoticSplitCD:Start()
		timerDreadScreamCD:Start(15.8)--SUCCESS
	elseif spellId == 301068 then
		timerPsychoticSplit:Start(25)
	elseif spellId == 302593 and playerDRealm then
		specWarnVoidSlam:Show()
		specWarnVoidSlam:Play("shockwave")
		timerVoidSlam:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 292963 or spellId == 302503 then--Dread
		--timerDreadCD:Start()
	elseif spellId == 296018 or spellId == 302504 then--Manic Dread (302504 LFR)
		timerManicDreadCD:Start()
--	elseif spellId == 293509 then
--		timerManifestNightmaresCD:Start()
	elseif spellId == 303543 then
		timerDreadScreamCD:Start()
	elseif spellId == 295444 then--Mind Tether
		--In perfect scenario, not delayed very much if ever even by phase changes
		--"Mind Tether-295444-npc:150859 = pull:4.0, 48.2, 52.3, 48.7, 48.7", -- [8]
		timerMindTetherCD:Start()
	elseif spellId == 294515 and self:AntiSpam(5, 1) then
		specWarnHorrificSummoner:Show()
		specWarnHorrificSummoner:Play("bigmob")
	elseif spellId == 299708 and self:AntiSpam(5, 1) then
		specWarnHorrificSummoner:Show()
		specWarnHorrificSummoner:Play("bigmob")
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
	elseif spellId == 295480 then--295495 other one
		warnMindTether:Show(args.sourceName, args.destName)
	elseif spellId == 300133 then
		warnSnapped:Show(args.destName)
	elseif spellId == 292963 or spellId == 302503 then
		warnDread:CombinedShow(0.3, args.destName)
		if spellId == 292963 then--Non LFR
			local icon = self.vb.dreadIcon
			if args:IsPlayer() then
				yellDread:Yell(icon, icon, icon)
				yellDreadFades:Countdown(spellId, nil, icon)
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
				yellManicDread:Yell(icon, icon, icon)
				yellManicDreadFades:Countdown(spellId, nil, icon)
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
			yellDreadScream:Yell(icon, icon, icon)
			yellDreadScreamFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconDreadScream then
			self:SetIcon(args.destName, icon)
		end
		self.vb.dreadIcon = self.vb.dreadIcon + 1
	elseif spellId == 293509 then
		--self.vb.nightmaresCount = self.vb.nightmaresCount + 1
		if self:AntiSpam(5, 2) then
			timerManifestNightmaresCD:Start()
		end
		if args:IsPlayer() then
			specWarnManifedNightmares:Show()
			specWarnManifedNightmares:Play("targetyou")
			yellManifedNightmares:Yell()
			yellManifedNightmaresFades:Countdown(spellId)
		end
	elseif spellId == 295327 then
		if self:CheckDispelFilter() then
			specWarShatteredPsyche:CombinedShow(1, args.destName)
			specWarShatteredPsyche:ScheduleVoice(1, "helpdispel")
		end
	elseif spellId == 303971 or spellId == 296078 then--Dark Pulse
		--timerManicDreadCD:Stop()
	elseif spellId == 295249 and args:IsPlayer() then
		playerDRealm = true
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
	elseif spellId == 296018 then--Non LFR
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
		--timerManicDreadCD:Start()
	elseif spellId == 295249 and args:IsPlayer() then
		playerDRealm = false
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
	if cid == 154682 then--echo-of-fear
		timerDreadScreamCD:Stop()
	elseif cid == 154685 then--echo-of-delirium
		timerVoidSlam:Stop()
	--elseif cid == 154175 then--Horric Summoner
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:292996") then--Maddening Eruption
		specWarnMaddeningEruption:Show(L.Tear)
		specWarnMaddeningEruption:Play("moveboss")
		timerMaddeningEruptionCD:Start()
	elseif (msg == L.Phase3 or msg:find(L.Phase3)) and self.vb.phase < 3 then
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--Timers that never stop, but might need time added to them if they come off cd during transition
		--timerDreadCD:Stop()
		--timerCrushingGraspCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 299711 then--Pick A Portal (script for horrors)
		--"Pick a Portal-299711-npc:150859 = pull:20.3, 60.7, 92.5, 63.2", -- [5]
		--Controller used for horrors even if we're in a phase one isn't cast, becauase we still want to know where the script is before we push boss.
		timerHorrificSummonerCD:Schedule(5)--Script runs 5 sec before spawn events, so we need to offset it
	elseif spellId == 299974 then--Pick a Dread (Script for dreads)
		--Controller used for dreads even if we're in a phase one isn't cast, becauase we still want to know where the script is before we push boss.
		timerDreadCD:Start()
	--elseif spellId == 301179 then--Pick a Ultimate (Script for Dark Pulse or mythic version Psychotic Split)

	elseif spellId == 296465 and self.vb.phase < 4 then--Energy Tracker (should work on all)
		self.vb.phase = 4
		timerDeliriumsDescentCD:Stop()
		timerMaddeningEruptionCD:Stop()
		--The time between last dread and first manic dread is always 65, so when he transitions into P4
		--Multiple logs confirm it literally just deletes 10 seconds off existing timer, no timer reset
		timerDreadCD:RemoveTime(10)
		timerHorrificSummonerCD:SetFade(false)--Unfade, they can start spawning again
		--TODO, sometimes the P4 transition timing causes the next nightmares to be skipped, if we can figure out exact timing of that, can do a +35 to existing timer?
		if self:IsMythic() then
			timerPsychoticSplitCD:Start(75.1)
		else
			timerDarkPulseCD:Start(75.1)
		end
	end
end
