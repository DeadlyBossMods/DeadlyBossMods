local mod	= DBM:NewMod(2612, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214506)
mod:SetEncounterID(2919)
mod:SetUsedIcons(6, 4, 3, 7)
mod:SetHotfixNoticeRev(20240917000000)
--mod:SetMinSyncRevision(20240917000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 442526 442432 443003 443005 446700",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 446349 446694 446690 442263 442250 442250 440421 441362",--443274
--	"SPELL_AURA_APPLIED_DOSE 443274",
	"SPELL_AURA_REMOVED 446349 446694 446690 442263 442250 440421",
	"SPELL_PERIODIC_DAMAGE 442799",
	"SPELL_PERIODIC_MISSED 442799",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: At this time, i don't see a practical reason to announce players that only got https://www.wowhead.com/beta/spell=442704/poisoned-blood . It's just non dispelable inactionable damage that goes out to players who didn't get black blood (private aura)
--TODO, ingest code, it seems split between two diff abilities, so probably mid rework. Transfusion might have replaced Violent Discharge (or other way around)
--TODO, is Catalyze Mutation passive effect of ingest or a hard cast?
--TODO, figure out how the nature/shadow combo works for tank mechanic. hard to add taunt warnings right now since they might be bad advice, so for now only warning for casts
--https://www.wowhead.com/beta/spell=443021/volatile-concoction and https://www.wowhead.com/beta/spell=441368/volatile-concoction used too?
--TODO, nameplate timer for https://www.wowhead.com/beta/spell=438847/web-blast ?
--TODO, add https://www.wowhead.com/beta/spell=458212/necrotic-wound stacks?
--TODO, recheck option keys to match BW for weak aura compatability before live
--[[
(ability.id = 442526 or ability.id = 442432 or ability.id = 443003 or ability.id = 443005) and type = "begincast"
or ability.id = 446349 and type = "applydebuff"
or ability.id = 442432 and type = "removebuff"
or ability.id = 446700 and type = "begincast"
--]]
local warnExperimentalDosage					= mod:NewTargetCountAnnounce(442526, 3, nil, nil, 143340)--Shortname "Injection"

local specWarnExperimentalDosage				= mod:NewSpecialWarningMoveTo(442526, nil, 143340, nil, 1, 2)--Shortname "Injection"
local yellxperimentalDosage						= mod:NewShortPosYell(442526, 19873)--Shortname "Destroy Egg" (This name is NOT injected into shortnames api)
local yellxperimentalDosageFades				= mod:NewIconFadesYell(442526, 19873)--Shortname "Destroy Egg" (This name is NOT injected into shortnames api)
local specWarnIngestBlackBlood					= mod:NewSpecialWarningCount(442432, nil, 325225, nil, 2, 2)--Shortname "Container Breach"
local specWarnUnstableWeb						= mod:NewSpecialWarningMoveAway(446349, nil, 389280, nil, 1, 2)--Shortname "Web"
local yellUnstableWeb							= mod:NewShortYell(446349, 389280)
local specWarnVolatileConcoction				= mod:NewSpecialWarningDefensive(441362, nil, nil, nil, 1, 2)
local specWarnVolatileConcoctionTaunt			= mod:NewSpecialWarningTaunt(441362, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(442799, nil, nil, nil, 1, 8)

local timerExperimentalDosageCD					= mod:NewCDCountTimer(50, 442526, 143340, nil, nil, 3)--Shortname "Injection"
local timerIngestBlackBloodCD					= mod:NewCDCountTimer(167.7, 442432, 325225, nil, nil, 3)--Shortname "Container Breach"
local timerUnstableWebCD						= mod:NewCDCountTimer(30, 446349, 157317, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON..DBM_COMMON_L.MAGIC_ICON)--Shortname "Webs"
local timerVolatileConcoctionCD					= mod:NewCDCountTimer(20, 441362, DBM_COMMON_L.TANKDEBUFF.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnEggBreaker", 442526, true, 10, {6, 4, 3, 7, 1, 2})--Egg Breaker auto assign strat (Priority for melee > ranged > healer)
mod:AddDropdownOption("EggBreakerBehavior", {"MatchBW", "MatchEW", "UseAllAscending", "DisableIconsForRaid", "DisableAllForRaid"}, "MatchBW", "misc", nil, 442526)
--Colossal Spider
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28996))
local specWarnPoisonBurst						= mod:NewSpecialWarningInterrupt(446700, "HasInterrupt", nil, nil, 1, 2)

mod:AddNamePlateOption("NPAuraOnNecrotic2", 446694, false)
--Voracious Worm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28999))

mod:AddNamePlateOption("NPAuraOnRavenous2", 446690, false)
mod:AddSetIconOption("SetIconOnWorm", -28999, false, 5, {8, 7, 6, 5})
--Blood Parasite
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29003))
local specWarnFixate							= mod:NewSpecialWarningYou(442250, nil, nil, nil, 1, 2)

mod:AddNamePlateOption("NPAuraOnAccelerated2", 442263, false)
mod:AddNamePlateOption("NPFixate", 442250, true)

--mod:AddInfoFrameOption(407919, true)
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.dosageCount = 0
mod.vb.ingestCount = 0
mod.vb.webCount = 0
mod.vb.tankCount = 0
mod.vb.EggBreakerBehavior = "MatchBW"
mod.vb.eggIcon = 1
local eggBreak = DBM:GetSpellName(177853)
local eggIcons = {}
local markOrder = { 6, 4, 3, 7 } -- blue, green, purple, red (wm 1-4)
local mythicMarkOrder = { 6, 6, 4, 4, 3, 3, 7, 7 } -- blue, green, purple, red (wm 1-4)
local echoMythicMarkOrder = { 6, 6, 4, 4, 1, 1, 2, 2 } -- blue, green, star, circle

function mod:OnCombatStart(delay)
	self.vb.dosageCount = 0
	self.vb.ingestCount = 0
	self.vb.webCount = 0
	self.vb.tankCount = 0
	self.vb.EggBreakerBehavior = self.Options.EggBreakerBehavior--Default it to whatever user has it set to, until group leader overrides it
	self.vb.eggIcon = 1
	timerVolatileConcoctionCD:Start(1.9, 1)
	timerIngestBlackBloodCD:Start(15.4, 1)--Time til USCS event, cast event is 19.6
--	timerExperimentalDosageCD:Start(33, 1)--Started by Injest black Blood
	if self:IsHard() then
		timerUnstableWebCD:Start(15, 1)
	end
	if self.Options.NPAuraOnNecrotic2 or self.Options.NPAuraOnRavenous2 or self.Options.NPAuraOnAccelerated2 or self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	--Group leader decides interrupt behavior
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.EggBreakerBehavior == "MatchBW" then
			self:SendSync("MatchBW")
		elseif self.Options.EggBreakerBehavior == "MatchEW" then
			self:SendSync("MatchEW")
		elseif self.Options.EggBreakerBehavior == "UseAllAscending" then
			self:SendSync("UseAllAscending")
		elseif self.Options.EggBreakerBehavior == "DisableIconsForRaid" then
			self:SendSync("DisableIconsForRaid")
		elseif self.Options.EggBreakerBehavior == "DisableAllForRaid" then
			self:SendSync("DisableAllForRaid")
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnNecrotic2 or self.Options.NPAuraOnRavenous2 or self.Options.NPAuraOnAccelerated2 or self.Options.NPFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 442526 then
		table.wipe(eggIcons)
		self.vb.dosageCount = self.vb.dosageCount + 1
		timerExperimentalDosageCD:Start(nil, self.vb.dosageCount+1)--50
		if self.Options.SetIconOnWorm then
			self:ScanForMobs(219046, 0, 8, 4, nil, 10, "SetIconOnWorm")
		end
	elseif spellId == 442432 and self:AntiSpam(5, 1) then--Ingest Black Blood
		--Timers that restart here
		timerExperimentalDosageCD:Start(16, self.vb.dosageCount+1)
		timerVolatileConcoctionCD:Start(18, self.vb.tankCount+1)
		if self:IsHard() then
			timerUnstableWebCD:Start(31, self.vb.webCount+1)
		end
--	elseif spellId == 446349 then
--		self.vb.webCount = self.vb.webCount + 1
--		timerUnstableWebCD:Start()
	elseif spellId == 443003 then--Nature (confirmed ID)
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVolatileConcoction:Show()
			specWarnVolatileConcoction:Play("defensive")
		end
		timerVolatileConcoctionCD:Start(nil, self.vb.tankCount+1)--20
	elseif spellId == 443005 then--Shadow (unconfirmed it's even used)
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVolatileConcoction:Show()
			specWarnVolatileConcoction:Play("defensive")
		end
		timerVolatileConcoctionCD:Start(nil, self.vb.tankCount+1)--20
	elseif spellId == 446700 then
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnPoisonBurst:Show(args.sourceName)
			specWarnPoisonBurst:Play("kickcast")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 442430 and self:AntiSpam(5, 1) then
		self.vb.ingestCount = self.vb.ingestCount + 1
		specWarnIngestBlackBlood:Show()
		specWarnIngestBlackBlood:Play("specialsoon")
		timerIngestBlackBloodCD:Start()
	end
end
--]]

---@param self DBMMod
local function sortEggBreaker(self)
	table.sort(eggIcons, DBM.SortByMeleeRangedHealer)
	for i = 1, #eggIcons do
		local name = eggIcons[i]
		local icon
		if self.vb.EggBreakerBehavior == "MatchBW" then
			icon = (self:IsMythic() and mythicMarkOrder[i] or markOrder[i])
		elseif self.vb.EggBreakerBehavior == "MatchEW" then
			icon = (self:IsMythic() and echoMythicMarkOrder[i] or markOrder[i])
		elseif self.vb.EggBreakerBehavior == "UseAllAscending" then
			icon = i
		else--Disable Icons and Disable all for raid
			icon = 0
		end
		if icon > 0 and self.Options.SetIconOnEggBreaker and (not self:IsMythic() or (self:IsMythic() and i % 2 == 1)) then
			--Mythic uses same icons in pairs, so people are paired up with same mark, can't mark both so only marks 1 of them
			self:SetIcon(name, icon)
		end
		if name == DBM:GetMyPlayerInfo() then
			specWarnExperimentalDosage:Show(eggBreak)
			--if icon > 0 then
			--	specWarnExperimentalDosage:Play("mm"..icon)
			--else
				specWarnExperimentalDosage:Play("movetoegg")
			--end
			if self.vb.EggBreakerBehavior ~= "DisableAllForRaid" then
				yellxperimentalDosage:Yell(icon)
				yellxperimentalDosageFades:Countdown(440421, nil, icon)
			end
		end
	end
	warnExperimentalDosage:Show(self.vb.dosageCount+1, table.concat(eggIcons, "<, >"))
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 446349 then
		if args:IsPlayer() then
			specWarnUnstableWeb:Show()
			specWarnUnstableWeb:Play("runout")
			yellUnstableWeb:Yell()
		end
	elseif spellId == 446694 then
		if self.Options.NPAuraOnNecrotic2 then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 446690 then
		if self.Options.NPAuraOnRavenous2 then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 442263 then
		if self.Options.NPAuraOnAccelerated2 then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 442250 then
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("targetyou")
			end
			if self.Options.NPFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, nil, nil, true)
			end
		end
	elseif spellId == 440421 then
		eggIcons[#eggIcons+1] = args.destName
		local expectedTotal = self:IsMythic() and 8 or 4
		local alivePlayers = DBM:NumRealAlivePlayers()
		--Auto scale expected if there aren't enough living players to meet it
		if expectedTotal > alivePlayers then
			expectedTotal = alivePlayers
		end
		self:Unschedule(sortEggBreaker)
		if #eggIcons == expectedTotal then
			sortEggBreaker(self)
		else
			self:Schedule(0.5, sortEggBreaker, self)--Fallback in case scaling targets for normal/heroic
		end
	elseif spellId == 441362 and not args:IsPlayer() then
		specWarnVolatileConcoctionTaunt:Show(args.destName)
		specWarnVolatileConcoctionTaunt:Play("tauntboss")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 446694 then
		if self.Options.NPAuraOnNecrotic2 then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 446690 then
		if self.Options.NPAuraOnRavenous2 then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 442263 then
		if self.Options.NPAuraOnAccelerated2 then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 442250 then
		if args:IsPlayer() then
			if self.Options.NPFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 440421 then
		if self.Options.SetIconOnEggBreaker and self.vb.EggBreakerBehavior ~= "DisableAllForRaid" then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellxperimentalDosageFades:Cancel()
		end
--	elseif spellId == 446349 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 442799 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 219045 then--Colossal Spider

	--elseif cid == 219046 then--Voracious WOrm

	--elseif cid == 220626 then--Blood Parasite

	end
end
--]]

--"<17.52 03:58:20> [UNIT_SPELLCAST_SUCCEEDED] Broodtwister Ovi'nax(97.9%-0.0%){Target:Threetuandk} -Ingest Black Blood- [[boss1:Cast-3-2085-2657-8295-442430-00130EE7DC:442430]]",
-- "<21.20 03:58:23> [CLEU] SPELL_CAST_START#Creature-0-2085-2657-8295-214506-00000EE7C2#Broodtwister Ovi'nax(97.1%-0.0%)##nil#442432#Ingest Black Blood#nil#nil"
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 446344 then--Unstable Web
		self.vb.webCount = self.vb.webCount + 1
		timerUnstableWebCD:Start(nil, self.vb.webCount+1)
	elseif spellId == 442430 then
		self.vb.ingestCount = self.vb.ingestCount + 1
		specWarnIngestBlackBlood:Show(self.vb.ingestCount)
		specWarnIngestBlackBlood:Play("specialsoon")
		timerIngestBlackBloodCD:Start(nil, self.vb.ingestCount+1)
		timerUnstableWebCD:Stop()
		timerVolatileConcoctionCD:Stop()
		timerExperimentalDosageCD:Stop()
		--Timers restarted by CLEU event since that's easier to verify on WCLs
		--This just warns earlier than CLEU events and stops timers at earliest point
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "MatchBW" then
		self.vb.EggBreakerBehavior = "MatchBW"
	elseif msg == "MatchEW" then
		self.vb.EggBreakerBehavior = "MatchEW"
	elseif msg == "UseAllAscending" then
		self.vb.EggBreakerBehavior = "UseAllAscending"
	elseif msg == "DisableIconsForRaid" then
		self.vb.EggBreakerBehavior = "DisableIconsForRaid"
	elseif msg == "DisableAllForRaid" then
		self.vb.EggBreakerBehavior = "DisableAllForRaid"
	end
end
