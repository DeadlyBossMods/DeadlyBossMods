local mod	= DBM:NewMod(2602, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "story,lfr,normal,heroic,mythic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(227323)
mod:SetEncounterID(2922)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 437592 456623 437417 439814 440899 440883 437093 447076 447411 450191 449940 449986 447950 448458",
	"SPELL_CAST_SUCCESS 439299",
	"SPELL_AURA_APPLIED 451320 441958 436800 440885 447207 453990 464056 447967 462558 451278",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 451320 447207 453990 462558 451278",
	"SPELL_PERIODIC_DAMAGE 443403",
	"SPELL_PERIODIC_MISSED 443403",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify reactive toxin spellids/events
--TODO, figure out how reactive toxin works and make mod less crappy
--TODO, figure out Silken Tomb targetting and make mod less crappy
--TODO, figure out Liquefy targetting and make mod less crappy
--TODO, get right web blades event
--TODO, fix Wrest spellIds
--TODO, Phase 2 Entropic Conduit mythic mechanics
--TODO, add https://www.wowhead.com/beta/spell=448660/acid-bolt to stage 2 if it is not spammed
--TODO, add shadowblast nameplate timer
--TODO, add Gloom Orb nameplate timer?
--General Stuff
local warnPhase									= mod:NewPhaseChangeAnnounce(0, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(441958, nil, nil, nil, 1, 8)
--Stage One: A Queen's Venom
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnReactiveToxin							= mod:NewTargetAnnounce(437592, 3)
local warnSilkenTomb							= mod:NewCountAnnounce(439814, 2)

local specWarnReactiveToxin						= mod:NewSpecialWarningMoveAway(437592, nil, nil, nil, 1, 2)
local yellReactiveToxin							= mod:NewShortYell(437592)
local yellReactiveToxinFades					= mod:NewShortFadesYell(437592)
local specWarnConcentratedToxin					= mod:NewSpecialWarningYou(451278, nil, nil, nil, 1, 2)
local yellConcentratedToxin						= mod:NewShortYell(451278)
local yellConcentratedToxinFades				= mod:NewShortFadesYell(451278)
local specWarnVenomNova							= mod:NewSpecialWarningSoakCount(437417, nil, nil, nil, 2, 2)
--local specWarnSilkenTomb						= mod:NewSpecialWarningYou(439814, nil, nil, nil, 1, 2)
--local yellSilkenTomb							= mod:NewShortYell(439814)
local specWarnLiquefy							= mod:NewSpecialWarningDefensive(440899, nil, nil, nil, 1, 2)
local specWarnLiquefyTaunt						= mod:NewSpecialWarningTaunt(440899, nil, nil, nil, 1, 2)
local specWarnLiquefyNonTank					= mod:NewSpecialWarningYou(440885, nil, nil, nil, 1, 2)
local specWarnFeast								= mod:NewSpecialWarningDefensive(437093, nil, nil, nil, 1, 2)
local specWarnWebBlades							= mod:NewSpecialWarningDodgeCount(439299, nil, nil, nil, 2, 2)

local timerReactiveToxinCD						= mod:NewAITimer(49, 437592, nil, nil, nil, 3)
local timerVenomNovaCD							= mod:NewAITimer(49, 437417, nil, nil, nil, 3)
local timerSilkenTombCD							= mod:NewAITimer(49, 439814, nil, nil, nil, 3)
local timerLiquefyCD							= mod:NewAITimer(49, 440899, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerWebBladesCD							= mod:NewAITimer(49, 439299, nil, nil, nil, 3)

--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)
--Intermission: The Spider's Web
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28755))
local specWarnWrest							= mod:NewSpecialWarningCount(447411, nil, nil, nil, 2, 12)

local timerWrestCD							= mod:NewAITimer(49, 447411, nil, nil, nil, 3)

mod:AddInfoFrameOption(447076, true)

--Stage Two: Royal Ascension
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28756))
--Mythic Stuff here

mod:AddNamePlateOption("NPAuraOnEchoingConnection", 453990)
----Queen Ansurek
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29628))
local timerAcidicApocalypse					= mod:NewCastTimer(105, 449940, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
----Ascended Voidspeaker
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29633))
local specWarnShadowblast					= mod:NewSpecialWarningInterruptCount(447950, nil, nil, nil, 1, 2)
----Devoted Worshipper
local specWarnGloomTouch					= mod:NewSpecialWarningMoveAway(464056, nil, nil, nil, 1, 2)
local yellGloomTouch						= mod:NewShortYell(464056)
local specWarnCosmicRupture					= mod:NewSpecialWarningYou(447967, nil, nil, nil, 1, 2, 4)
local yellCosmicRupture						= mod:NewShortFadesYell(447967)
local specWarnCosmicApocalypse				= mod:NewSpecialWarningSpell(448458, nil, nil, nil, 3, 2)
---Chamber Guardian
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29642))


local castsPerGUID = {}
--P1
mod.vb.novaCount = 0
mod.vb.tombCount = 0
mod.vb.tankComboCount = 0
mod.vb.webBladesCount = 0
--Intermission 1
mod.vb.wrestCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.novaCount = 0
	self.vb.tombCount = 0
	self.vb.tankComboCount = 0
	self.vb.webBladesCount = 0
	self.vb.wrestCount = 0
	timerReactiveToxinCD:Start(1-delay)
	timerVenomNovaCD:Start(1-delay)
	timerSilkenTombCD:Start(1-delay)
	timerLiquefyCD:Start(1-delay)
	timerWebBladesCD:Start(1-delay)
	if self.Options.NPAuraOnEchoingConnection then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnEchoingConnection then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 437592 or spellId == 456623 then
		timerReactiveToxinCD:Start()
	elseif spellId == 437417 then
		self.vb.novaCount = self.vb.novaCount + 1
		specWarnVenomNova:Show(self.vb.novaCount)
		if not DBM:UnitDebuff("player", 441692) then--Reaction Trauma (can't soak)
			specWarnVenomNova:Play("helpsoak")--Maybe something more specific like movetopool?
		else
			specWarnVenomNova:Play("watchwave")
		end
		timerVenomNovaCD:Start()
	elseif spellId == 439814 then
		self.vb.tombCount = self.vb.tombCount + 1
		warnSilkenTomb:Show(self.vb.tombCount)
		timerSilkenTombCD:Start()
	elseif spellId == 440899 or spellId == 440883 then--Non Mythic / Mythic (assumed)
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnLiquefy:Show()
			specWarnLiquefy:Play("defensive")
		end
		timerLiquefyCD:Start()
	elseif spellId == 437093 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFeast:Show()
			specWarnFeast:Play("defensive")
		end
	elseif spellId == 447076 then--Predation
		self:SetStage(1.5)
		timerReactiveToxinCD:Stop()
		timerVenomNovaCD:Stop()
		timerSilkenTombCD:Stop()
		timerLiquefyCD:Stop()
		timerWebBladesCD:Stop()
		warnPhase:Show(1.5)
		warnPhase:Play("phasechange")

		timerWrestCD:Start(1)
	elseif spellId == 447411 or spellId == 450191 then--Intermission Left / Phase 2 right
		self.vb.wrestCount = self.vb.wrestCount + 1
		specWarnWrest:Show(self.vb.wrestCount)
		specWarnWrest:Play("pullin")
		timerWrestCD:Start()
	elseif spellId == 449940 then
		timerAcidicApocalypse:Start()
	elseif spellId == 449986 then
		self:SetStage(3)
		warnPhase:Show(3)
		warnPhase:Play("pthree")
		timerAcidicApocalypse:Stop()
	elseif spellId == 447950 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnShadowblast:Show(args.sourceName, count)
			if count < 6 then
				specWarnShadowblast:Play("kick"..count.."r")
			else
				specWarnShadowblast:Play("kickcast")
			end
		end
	elseif spellId == 448458 then
		specWarnCosmicApocalypse:Show()
		specWarnCosmicApocalypse:Play("stilldanger")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439299 and self:AntiSpam(5, 3) then
		self.vb.webBladesCount = self.vb.webBladesCount + 1
		specWarnWebBlades:Show(self.vb.webBladesCount)
		specWarnWebBlades:Play("watchstep")
		timerWebBladesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 451320 then
		warnReactiveToxin:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnReactiveToxin:Show()
			specWarnReactiveToxin:Play("runout")
			yellReactiveToxin:Yell()
			yellReactiveToxinFades:Countdown(spellId)
		end
	elseif spellId == 441958 and args:IsPlayer() and self:AntiSpam(3, 1) then--Grasping Silk
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 436800 and not args:IsPlayer() then
		specWarnLiquefyTaunt:Show(args.destName)
		specWarnLiquefyTaunt:Play("tauntboss")
	elseif spellId == 440885 and args:IsPlayer() then
		specWarnLiquefyNonTank:Show()
		specWarnLiquefyNonTank:Play("targetyou")
	elseif spellId == 447207 then--Predation Shield
		if self.Options.Infoframe then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 453990 then
		if self.Options.NPAuraOnEchoingConnection then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 464056 or spellId == 447967 then
		if args:IsPlayer() then
			specWarnGloomTouch:Show()
			specWarnGloomTouch:Play("runout")
			yellGloomTouch:Yell()
		end
	elseif spellId == 462558 then
		if args:IsPlayer() then
			specWarnCosmicRupture:Show()
			specWarnCosmicRupture:Play("targetyou")
			yellCosmicRupture:Countdown(spellId)
		end
	elseif spellId == 451278 then
		if args:IsPlayer() then
			specWarnConcentratedToxin:Show()
			specWarnConcentratedToxin:Play("targetyou")
			yellConcentratedToxin:Yell()
			yellConcentratedToxinFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 451320 then
		if args:IsPlayer() then
			yellReactiveToxinFades:Cancel()
		end
	elseif spellId == 447207 then--Predation Shield
		self:SetStage(2)
		warnPhase:Show(2)
		warnPhase:Play("ptwo")
		self.vb.wrestCount = 0
		timerWrestCD:Stop()
		timerWrestCD:Start(2)
		if self.Options.Infoframe then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 453990 then
		if self.Options.NPAuraOnEchoingConnection then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 462558 then
		if args:IsPlayer() then
			yellCosmicRupture:Cancel()
		end
	elseif spellId == 451278 then
		if args:IsPlayer() then
			yellConcentratedToxinFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 443403 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 439299 and self:AntiSpam(5, 3) then
		self.vb.webBladesCount = self.vb.webBladesCount + 1
		specWarnWebBlades:Show(self.vb.webBladesCount)
		specWarnWebBlades:Play("watchstep")
		timerWebBladesCD:Start()
	end
end
