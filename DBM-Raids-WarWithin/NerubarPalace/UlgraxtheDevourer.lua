local mod	= DBM:NewMod(2607, "DBM-Raids-WarWithin", 3, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(215657)
mod:SetEncounterID(2902)
mod:SetHotfixNoticeRev(20241007000000)
mod:SetMinSyncRevision(20241007000000)
mod:SetZone(2657)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 441451 441452 435136 434697 445052 436203 436200 451412 443842 438012 445290 445123 435138",
	"SPELL_CAST_SUCCESS 434803",
	"SPELL_AURA_APPLIED 439419 455831 435138 434705 458129",
	"SPELL_AURA_REMOVED 458129 435138",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, auto marking with spell summon events? prio on bile soaked?
--TODO, announce deaths of adds (viscera)? depends how many adds there are. if it's 1-3 at a time, maybe. if it's 10 of em, no
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 434803 or ability.id = 441451 or ability.id = 441452 or ability.id = 435136 or ability.id = 434697 or ability.id = 445052 or ability.id = 436203 or ability.id = 436200 or ability.id = 451412 or ability.id = 443842 or ability.id = 438012 or ability.id = 445290 or ability.id = 445123 or ability.id = 435138) and type = "begincast"
 or ability.id = 434803 and type = "cast"
--]]
--Gleeful Brutality
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30011))
local warnStalkerNetting						= mod:NewTargetAnnounce(441452, 3, nil, false)--Non Mythic
local warnHardenedNetting						= mod:NewTargetAnnounce(455831, 3, nil, false)--Mythic
local warnVenomLash								= mod:NewCountAnnounce(435136, 3)
local warnDigestiveAcid							= mod:NewTargetAnnounce(435138, 3)
local warnHungeringBelows						= mod:NewCountAnnounce(438012, 3)

local specWarnCarnivorousContest				= mod:NewSpecialWarningMoveTo(434803, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local specWarnCarnivorousContestTarget			= mod:NewSpecialWarningYou(434803, nil, nil, DBM_COMMON_L.GROUPSOAK, 1, 2)
local yellCarnivorousContest					= mod:NewShortYell(434803, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellCarnivorousContestFades				= mod:NewShortFadesYell(434803, nil, nil, nil, "YELL")
local specWarnStalkersWebbing					= mod:NewSpecialWarningDodgeCount(441452, nil, 157317, nil, 2, 2)--aka Viscous Slobber apparently
local specWarnDigestiveAcid						= mod:NewSpecialWarningMoveTo(435138, nil, nil, nil, 1, 17)
local yellDigestiveAcid							= mod:NewShortYell(435138)
local yellDigestiveAcidFades					= mod:NewShortFadesYell(435138)
local specWarnBrutalCrush						= mod:NewSpecialWarningDefensive(434697, nil, nil, nil, 1, 2)
local specWarnTenderized						= mod:NewSpecialWarningTaunt(434705, nil, nil, nil, 1, 2)

local timerCarnivorousContestCD					= mod:NewCDCountTimer(36.0, 434803, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 3)
local timerStalkersWebbingCD					= mod:NewCDCountTimer(49, 441452, 157317, nil, nil, 3)--Shortname "Webs"
local timerVenomLashCD							= mod:NewCDCountTimer(32.9, 435136, nil, nil, nil, 2)
local timerBrutalCrushCD						= mod:NewCDCountTimer(13.0, 434697, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDigestiveAcidCD						= mod:NewCDCountTimer(47, 435138, nil, nil, nil, 3)
local timerPhaseChange							= mod:NewStageCountTimer(10, 438012, nil, nil, nil, 6)
local berserkTimer								= mod:NewBerserkTimer(600)
--Feeding Frenzy
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28845))
local warnJuggernautCharge						= mod:NewCountAnnounce(436200, 4, nil, nil, 100, nil, nil, 2)--Charges 2+ of the set

local specWarnChitteringSwarm					= mod:NewSpecialWarningSwitch(445052, nil, 310414, nil, 1, 2)
local specWarnSwallowingDarkness				= mod:NewSpecialWarningDodge(443842, nil, nil, nil, 2, 2)
local specWarnHulkingCrash						= mod:NewSpecialWarningDodge(445123, nil, 298588, nil, 2, 2)--Shortname "Crash"

local timerChitteringSwarmCD					= mod:NewCDTimer(49, 445052, 310414, nil, nil, 1)--Shortname "Swarm"
local timerJuggernautChargeCD					= mod:NewCDCountTimer(49, 436200, 100, nil, nil, 3)--Shortname "Charge"
local timerSwallowingDarknessCD					= mod:NewCDTimer(49, 443842, nil, nil, nil, 3)--Unsure of shortname, Swirl? Run away?
local timerHungeringBellowsCD					= mod:NewCDCountTimer(9, 438012, 143358, nil, nil, 2)--Shortname "Hunger"

mod.vb.lashingsCount = 0--Ability that's go smash and knock players around (Carnivorous Contest and Hulking Crash)
mod.vb.webbingChargeCount = 0--Abilities that leave webbing/Netting (Stalkers Webbing and Juggernaut
mod.vb.lashdarknessCount = 0--Abilities that remove webbing/netting (Venomous Lash and Swallowing Darkness)
mod.vb.brutalHungeringCount = 0--Abilities for tank/healer (Brutal Crush and Hungering Bellows)
mod.vb.digestiveCount = 0
local webName = DBM:GetSpellName(389280)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.lashingsCount = 0
	self.vb.webbingChargeCount = 0
	self.vb.lashdarknessCount = 0
	self.vb.brutalHungeringCount = 0
	self.vb.digestiveCount = 0
	timerBrutalCrushCD:Start(3, 1)--Can be delayed by kiting or pulling boss from far away, then get further spell queued
	timerVenomLashCD:Start(5, 1)
	timerStalkersWebbingCD:Start(9, 1)
	timerDigestiveAcidCD:Start(14.9, 1)
	timerCarnivorousContestCD:Start(33, 1)
	timerPhaseChange:Start(90, 2)--Needs monitoring. There have been pulls this came sooner
	berserkTimer:Start(-delay)--confirmed on normal and heroic
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 441451 or spellId == 441452 then
		self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
		specWarnStalkersWebbing:Show(self.vb.webbingChargeCount)
		specWarnStalkersWebbing:Play("watchstep")
		if self.vb.webbingChargeCount == 1 then
			timerStalkersWebbingCD:Start(43.9, self.vb.webbingChargeCount+1)
		end
	elseif spellId == 435136 then
		self.vb.lashdarknessCount = self.vb.lashdarknessCount + 1
		warnVenomLash:Show(self.vb.lashdarknessCount)
		if self.vb.lashdarknessCount % 3 == 1 then
			timerVenomLashCD:Start(25, self.vb.lashdarknessCount+1)
		elseif self.vb.lashdarknessCount % 3 == 2 then
			timerVenomLashCD:Start(28, self.vb.lashdarknessCount+1)
		end
	elseif spellId == 434697 then
		self.vb.brutalHungeringCount  = self.vb.brutalHungeringCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBrutalCrush:Show()
			specWarnBrutalCrush:Play("defensive")
		end
		--This code below will break if boss is kited around.
		--None the less, for most users, it provides a nicer experience then on fly timer correction
		if self.vb.brutalHungeringCount < 5 then
			timerBrutalCrushCD:Start(self.vb.brutalHungeringCount == 3 and 19 or 15, self.vb.brutalHungeringCount+1)
		end
	elseif spellId == 445052 then--Chittering Swarm
		specWarnChitteringSwarm:Show()
		specWarnChitteringSwarm:Play("killmob")
	elseif spellId == 436200 or spellId == 436203 then--First charge, subsiquent ones
		if spellId == 436200 then
			self.vb.webbingChargeCount = 0
			timerJuggernautChargeCD:Start(4.6, 1)
		else
			self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
			warnJuggernautCharge:Show(self.vb.webbingChargeCount)
			warnJuggernautCharge:Play("chargemove")
			if self.vb.webbingChargeCount < 4 then
				timerJuggernautChargeCD:Start(7.1, self.vb.webbingChargeCount+1)
			end
		end
	elseif spellId == 451412 or spellId == 443842 then--Hard/Easy assumed (hard has knockback, easy does not)
		specWarnSwallowingDarkness:Show()
		specWarnSwallowingDarkness:Play("watchstep")
	elseif spellId == 438012 then
		self.vb.brutalHungeringCount = self.vb.brutalHungeringCount + 1
		warnHungeringBelows:Show(self.vb.brutalHungeringCount)
		if self.vb.brutalHungeringCount % 4 == 0 then
			timerHungeringBellowsCD:Start(6, self.vb.brutalHungeringCount+1)
		else
			timerHungeringBellowsCD:Start(7, self.vb.brutalHungeringCount+1)
		end
	elseif spellId == 435138 then
		self.vb.digestiveCount = self.vb.digestiveCount + 1
		if self.vb.digestiveCount == 1 then
			timerDigestiveAcidCD:Start(47, self.vb.digestiveCount+1)
		end
	elseif spellId == 445290 or spellId == 445123 then--Cast during stage 2 / Entering Stage 2
		specWarnHulkingCrash:Show()
		specWarnHulkingCrash:Play("watchstep")
		if spellId == 445290 then--Seems scrapped
			DBM:Debug("Hulking Crash (445290) has returned", 1, true)
--			self.vb.lashingsCount = self.vb.lashingsCount + 1
--			timerHulkingCrashCD:Start(18, self.vb.lashingsCount+1)
		else--Phase change
			self:SetStage(2)
			self.vb.lashdarknessCount = 0
			self.vb.webbingChargeCount = 0
			self.vb.brutalHungeringCount = 0
			self.vb.lashingsCount = 0
			self.vb.digestiveCount = 0
			timerCarnivorousContestCD:Stop()
			timerStalkersWebbingCD:Stop()
			timerVenomLashCD:Stop()
			timerBrutalCrushCD:Stop()
			timerDigestiveAcidCD:Stop()
			timerChitteringSwarmCD:Start(6.8)--Cast only once
			timerJuggernautChargeCD:Start(11.8, 1)--Cast only once (but multi hit so still count timer)
			timerSwallowingDarknessCD:Start(48.1)--Cast only once
			--Technically these can also be started below by 441445
			timerHungeringBellowsCD:Start(59, 1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 434803 then
		self.vb.lashingsCount = self.vb.lashingsCount + 1
		if self.vb.lashingsCount == 1 then
			timerCarnivorousContestCD:Start(nil, self.vb.lashingsCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 439419 then
		warnStalkerNetting:CombinedShow(1.5, args.destName)
	elseif spellId == 455831 then
		warnHardenedNetting:CombinedShow(0.5, args.destName)
	elseif spellId == 435138 then
		warnDigestiveAcid:CombinedShow(1, args.destName)--Goes out really slow
		if args:IsPlayer() then
			specWarnDigestiveAcid:Show(webName)
			specWarnDigestiveAcid:Play("movetoweb")--Request final voice when blizzard finalizes spell name. is it web or is it drool/puddle. this matters
			yellDigestiveAcid:Yell()
			yellDigestiveAcidFades:Countdown(spellId)
		end
	elseif spellId == 434705 then
		if not args:IsPlayer() then
			local uID = DBM:GetUnitIdFromGUID(args.destGUID)
			---@diagnostic disable-next-line: param-type-mismatch
			if self:IsTanking(uID, "boss1") then--Filter non tank spec numpties in front of boss for some reason
				specWarnTenderized:Show(args.destName)
				specWarnTenderized:Play("tauntboss")
			end
		end
	elseif spellId == 458129 then
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnCarnivorousContestTarget:Show()
			specWarnCarnivorousContestTarget:ScheduleVoice(1.5, "gathershare")
			yellCarnivorousContest:Yell()
			yellCarnivorousContestFades:Countdown(spellId)
		elseif self:AntiSpam(3, 2) and not DBM:UnitDebuff("player", 455847) then
			specWarnCarnivorousContest:Show(self.vb.lashingsCount)
			if self:IsMythic() then
				if self.vb.lashingsCount == 1 then
					specWarnCarnivorousContest:ScheduleVoice(1.5, "shareone")
				else
					specWarnCarnivorousContest:ScheduleVoice(1.5, "sharetwo")
				end
			else
				specWarnCarnivorousContest:ScheduleVoice(1.5, "helpsoak")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 458129 then
		yellCarnivorousContestFades:Cancel()
	elseif spellId == 435138 then
		if args:IsPlayer() then
			yellDigestiveAcidFades:Countdown(spellId)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg:find("spell:434776") and self:AntiSpam(3, 1) then
		specWarnCarnivorousContestTarget:Show()
		specWarnCarnivorousContestTarget:Play("runout")
		specWarnCarnivorousContestTarget:ScheduleVoice(1.5, "gathershare")
		yellCarnivorousContest:Yell()
		yellCarnivorousContestFades:Countdown(8)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:434776") and self:AntiSpam(3, 2) and not DBM:UnitDebuff("player", 455847) then
		if targetName ~= UnitName("player") then
			specWarnCarnivorousContest:Show(targetName)
			if self:IsMythic() then
				if self.vb.lashingsCount == 1 then
					specWarnCarnivorousContest:Play("shareone")
				else
					specWarnCarnivorousContest:Play("sharetwo")
				end
			else
				specWarnCarnivorousContest:Play("helpsoak")
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--<168.89 20:49:18> [UNIT_SPELLCAST_SUCCEEDED] Ulgrax the Devourer(11.0%-100.0%){Target:Meeresdk} -Phase Transition None- [[boss1:Cast-3-2085-2657-32566-4
	--"<173.83 20:49:23> [UNIT_SPELLCAST_SUCCEEDED] Ulgrax the Devourer(10.4%-100.0%){Target:??} -Phase Transition P2 -> P1- [[boss1:Cast-3-2085-2657-32566-44142
	if spellId == 441425 and self:GetStage(2) then--Phase Transition None (Fires on both beginning and ending of phase 2)
		DBM:Debug("Phase change triggered by main transition from to 2 to 1")
		self:SetStage(1)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		self.vb.lashingsCount = 0
		self.vb.digestiveCount = 0
		timerChitteringSwarmCD:Stop()
		timerJuggernautChargeCD:Stop()
		timerSwallowingDarknessCD:Stop()
		timerHungeringBellowsCD:Stop()
		timerBrutalCrushCD:Start(7, 1)
		timerVenomLashCD:Start(9, 1)
		timerStalkersWebbingCD:Start(13, 1)
		timerDigestiveAcidCD:Start(19.2, 1)
		timerCarnivorousContestCD:Start(37, 1)
		timerPhaseChange:Start(94.9, 2)--Approx based oncomparison to stalker webbingg first cast, since no transcriptor logs this long
	--441425 with a stage 2 only check is primary, but has one fatal flaw, it lacks disconnect protection
	--(ie if someone reconnects and their stage is 1 and not 2. We use this fallback below because its a CERTAINTY it's stage 2 to 1 transition
	elseif spellId == 441427 and self:GetStage(2) then--Phase Transition P2 -> P1
		DBM:Debug("Phase change triggered by backup transition to 2 to 1")
		self:SetStage(1)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		self.vb.lashingsCount = 0
		timerChitteringSwarmCD:Stop()
		timerJuggernautChargeCD:Stop()
		timerSwallowingDarknessCD:Stop()
		timerHungeringBellowsCD:Stop()
		timerBrutalCrushCD:Start(2, 1)
		timerVenomLashCD:Start(4, 1)
		timerStalkersWebbingCD:Start(8, 1)
		timerCarnivorousContestCD:Start(32, 1)
		timerPhaseChange:Start(89.9, 2)--Approx based oncomparison to stalker webbingg first cast, since no transcriptor logs this long
	end
end
