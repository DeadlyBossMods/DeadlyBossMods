local mod	= DBM:NewMod(2482, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(187967)
mod:SetEncounterID(2592)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 371976 372082 373405 374112 373027 371983 372539",
	"SPELL_CAST_SUCCESS 372238 181113",
	"SPELL_SUMMON 372242 372843",
	"SPELL_AURA_APPLIED 371976 372082 372030 372044 385083 373048",
	"SPELL_AURA_APPLIED_DOSE 372030 385083",
	"SPELL_AURA_REMOVED 371976 372082 372030 373048",
	"SPELL_AURA_REMOVED_DOSE 372030",
--	"SPELL_INTERRUPT",
--	"SPELL_PERIODIC_DAMAGE 372055",
--	"SPELL_PERIODIC_MISSED 372055",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, GTFO for icy Ground?
--TODO, timers need more work, but it'll be helpful when phase change events added to combat log or at very least transcriptor for easier table reading.
--[[
(ability.id = 371976 or ability.id = 372082 or ability.id = 373405 or ability.id = 372539 or ability.id = 373027 or ability.id = 371983) and type = "begincast"
 or (ability.id = 372238 or ability.id = 372648) and type = "cast"
 or ability.id = 181113 and source.id = 189234
 or ability.id = 372539 and type = "interrupt"
--]]
--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Stage One: Ice Climbers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24883))
local warnChillingBlast							= mod:NewTargetAnnounce(371976, 2)
local warnEnvelopingWebs						= mod:NewTargetNoFilterAnnounce(372082, 3)
local warnWrappedInWebs							= mod:NewTargetNoFilterAnnounce(372044, 4)
local warnCallSpiderlings						= mod:NewCountAnnounce(372238, 2)

local specWarnChillingBlast						= mod:NewSpecialWarningMoveAway(371976, nil, nil, nil, 1, 2)
local yellChillingBlast							= mod:NewYell(371976)
local yellChillingBlastFades					= mod:NewShortFadesYell(371976)
local specWarnEnvelopingWebs					= mod:NewSpecialWarningYouPos(372082, nil, nil, nil, 1, 2)
local yellEnvelopingWebs						= mod:NewPosYell(372082)
local yellEnvelopingWebsFades					= mod:NewIconFadesYell(372082)
local specWarnStickyWebbing						= mod:NewSpecialWarningStack(372030, nil, 3, nil, nil, 1, 6)
local specWarnGossamerBurst						= mod:NewSpecialWarningSpell(373405, nil, nil, nil, 2, 12)
local specWarnWebBlast							= mod:NewSpecialWarningTaunt(385083, nil, nil, nil, 1, 2)

local timerChillingBlastCD						= mod:NewCDCountTimer(18.5, 371976, nil, nil, nil, 3)--18.5-54.5
local timerEnvelopingWebsCD						= mod:NewCDCountTimer(24, 372082, nil, nil, nil, 3)--24-46.9
local timerGossamerBurstCD						= mod:NewCDCountTimer(36.9, 373405, nil, nil, nil, 2)--36.9-67.6
local timerCallSpiderlingsCD					= mod:NewCDCountTimer(25.1, 372238, nil, nil, nil, 1)--17.6-37
local timerPhaseCD								= mod:NewPhaseTimer(30)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(372030, false)--Useful raid leader tool, but not needed by everyone
mod:AddSetIconOption("SetIconOnWeb", 372082, true, false, {1, 2, 3})
--Intermission: Guardians of Frost
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24898))
local warnFrostbreathArachnid						= mod:NewSpellAnnounce(372843, 2)

local specWarnFreezingBreath						= mod:NewSpecialWarningDefensive(374112, nil, nil, nil, 1, 2)

local timerFreezingBreathCD							= mod:NewCDTimer(11.1, 374112, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: Cold Peak
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24885))
local warnApexofIce									= mod:NewCastAnnounce(372539, 3)
local warnSuffocatinWebs							= mod:NewTargetNoFilterAnnounce(373027, 3)

local specWarnSuffocatingWebs						= mod:NewSpecialWarningYouPos(373027, nil, nil, nil, 1, 2)
local yellSuffocatingWebs							= mod:NewPosYell(373027)
local yellSuffocatingWebsFades						= mod:NewIconFadesYell(373027)
local specWarnRepellingBurst						= mod:NewSpecialWarningSpell(371983, nil, nil, nil, 2, 12)

local timerSuffocatingWebsCD						= mod:NewCDCountTimer(48.8, 373027, nil, nil, nil, 3)--48.8-50
local timerRepellingBurstCD							= mod:NewCDCountTimer(34.2, 371983, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnSufWeb", 373027, true, false, {1, 2, 3})

local stickyStacks = {}
mod.vb.webIcon = 1
mod.vb.blastCount = 0
mod.vb.webCount = 0
mod.vb.burstCount = 0--Both bursts
mod.vb.spiderlingsCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(stickyStacks)
	self.vb.webIcon = 1
	self.vb.blastCount = 0
	self.vb.webCount = 0
	self.vb.burstCount = 0
	self.vb.spiderlingsCount = 0
	timerChillingBlastCD:Start(15.2-delay, 1)
	timerEnvelopingWebsCD:Start(17.9-delay, 1)
	timerGossamerBurstCD:Start(33.9-delay, 1)
--	timerCallSpiderlingsCD:Start(1-delay, 1)--1-3sec into pull
	timerPhaseCD:Start(43.1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(372030))
		DBM.InfoFrame:Show(20, "table", stickyStacks, 1)
	end
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
	if spellId == 371976 then
		self.vb.blastCount = self.vb.blastCount + 1
		--Seems to be cast 3 casts per movement, minus first, first started at movement, 2nd after first with longer cd then 3rd cast shorter cd after 2nd
		--Repeats on next movement
		--More consistent in stage 2
		timerChillingBlastCD:Start(self.vb.phase == 2 and 32 or self.vb.blastCount == 1 and 35 or 22, self.vb.blastCount+1)
	elseif spellId == 372082 then
		self.vb.webIcon = 1
		self.vb.webCount = self.vb.webCount + 1
		timerEnvelopingWebsCD:Start(nil, self.vb.webCount+1)
	elseif spellId == 373405 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnGossamerBurst:Show(self.vb.burstCount)
		specWarnGossamerBurst:Play("pullin")
		timerGossamerBurstCD:Start(nil, self.vb.burstCount+1)
	elseif spellId == 374112 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnFreezingBreath:Show()
			specWarnFreezingBreath:Play("defensive")
		end
		timerFreezingBreathCD:Start(nil, args.sourceGUID)
	elseif spellId == 372539 then
		warnApexofIce:Show()

		self:SetStage(2)
		self.vb.burstCount = 0
		self.vb.webCount = 0
		timerChillingBlastCD:Stop()
		timerEnvelopingWebsCD:Stop()
		timerGossamerBurstCD:Stop()
		timerCallSpiderlingsCD:Stop()
		--Stage 2 timers start here, but if she's not interrupted within 12 seconds, they start to queue up and become messy
		timerCallSpiderlingsCD:Start(12.3, self.vb.spiderlingsCount+1)
		timerChillingBlastCD:Start(14.8, self.vb.blastCount+1)
		timerSuffocatingWebsCD:Start(22.2, 1)
		timerRepellingBurstCD:Start(32.2, 1)
	elseif spellId == 373027 then
		self.vb.webIcon = 1
		self.vb.webCount = self.vb.webCount + 1
		timerSuffocatingWebsCD:Start(nil, self.vb.webCount+1)
	elseif spellId == 371983 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnRepellingBurst:Show(self.vb.burstCount)
		specWarnRepellingBurst:Play("carefly")
		timerRepellingBurstCD:Start(nil, self.vb.burstCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 372238 then
		self.vb.spiderlingsCount = self.vb.spiderlingsCount + 1
		warnCallSpiderlings:Show(self.vb.spiderlingsCount)
		if self.vb.phase == 2 then
			timerCallSpiderlingsCD:Start(30, self.vb.spiderlingsCount+1)
		else
			local remainingPhase = timerPhaseCD:GetRemaining()
			if remainingPhase < 25 then
				if self.vb.stageTotality ~= 1 then--Don't start timer if it's first movement timer
					timerCallSpiderlingsCD:Start(remainingPhase, self.vb.spiderlingsCount+1)
				end
			else
				timerCallSpiderlingsCD:Start(25, self.vb.spiderlingsCount+1)
			end
		end
	elseif spellId == 181113 then--Encounter Spawn
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 189234 then--Frostbreath Arachnid
			warnFrostbreathArachnid:Show()
			timerFreezingBreathCD:Start(6, args.sourceGUID)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 371976 then
		if args:IsPlayer() then
			specWarnChillingBlast:Show()
			specWarnChillingBlast:Play("runout")
			yellChillingBlast:Yell()
			yellChillingBlastFades:Countdown(spellId)
		end
		warnChillingBlast:CombinedShow(0.3, args.destName)
	elseif spellId == 372082 then
		local icon = self.vb.webIcon
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnEnvelopingWebs:Show(self:IconNumToTexture(icon))
			specWarnEnvelopingWebs:Play("mm"..icon)
			yellEnvelopingWebs:Yell(icon, icon)
			yellEnvelopingWebsFades:Countdown(spellId, nil, icon)
		end
		warnEnvelopingWebs:CombinedShow(0.5, args.destName)
		self.vb.webIcon = self.vb.webIcon + 1
	elseif spellId == 373048 then
		local icon = self.vb.webIcon
		if self.Options.SetIconOnSufWeb then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnSuffocatingWebs:Show(self:IconNumToTexture(icon))
			specWarnSuffocatingWebs:Play("mm"..icon)
			yellSuffocatingWebs:Yell(icon, icon)
			yellSuffocatingWebsFades:Countdown(spellId, nil, icon)
		end
		warnSuffocatinWebs:CombinedShow(0.5, args.destName)
		self.vb.webIcon = self.vb.webIcon + 1
	elseif spellId == 372030 then
		local amount = args.amount or 1
		stickyStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
		if args:IsPlayer() and amount >= 3 then
			specWarnStickyWebbing:Show(amount)
			specWarnStickyWebbing:Play("stackhigh")
		end
	elseif spellId == 372044 or spellId == 374104 then--Hard version, Easy version
		warnWrappedInWebs:CombinedShow(0.5, args.destName)
	elseif spellId == 385083 and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
		specWarnWebBlast:Show(args.destName)
		specWarnWebBlast:Play("tauntboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 371976 then
		if args:IsPlayer() then
			yellChillingBlastFades:Cancel()
		end
	elseif spellId == 372082 then
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellEnvelopingWebsFades:Cancel()
		end
	elseif spellId == 373048 then
		if self.Options.SetIconOnSufWeb then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellSuffocatingWebsFades:Cancel()
		end
	elseif spellId == 372030 then
		stickyStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 372030 then
		stickyStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 372055 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 372539 then
		--announce interrupt
	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 189234 then--Frostbreath Arachnid
		self:SetStage(1)--Likely totally wrong
		timerFreezingBreathCD:Stop(args.destGUID)
	end
end

--"<2.19 23:28:07> [ENCOUNTER_START] 2592#Sennarth, The Cold Breath#15#20", -- [26]
--"<45.37 23:28:50> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<146.08 23:30:31> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<245.88 23:32:10> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<300.23 23:33:05> [CLEU] SPELL_CAST_START#Creature-0-2085-2522-14007-187967-000040998B#Sennarth<12.0%-3.0%>##nil#372539#Apex of Ice#nil#nil", -- [23406]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("INV_MineSpider2_Crystal.blp") then
		self.vb.blastCount = 0
		timerGossamerBurstCD:Stop()
		timerChillingBlastCD:Stop()
		if self.vb.stageTotality == 1 then--First movement
			self:SetStage(1.25)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop stage 1 timers and basically restart them
			--Only first movement has delay on spiderlings, other movements summon them immediately
			timerCallSpiderlingsCD:Stop()
			timerCallSpiderlingsCD:Start(10)
			timerChillingBlastCD:Start(13, 1)
			timerGossamerBurstCD:Start(30, self.vb.burstCount+1)
			timerPhaseCD:Start(99.8)--Til next movement
		elseif self.vb.stageTotality == 2 then--Second movement
			self:SetStage(1.5)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop stage 1 timers and basically restart them
			timerChillingBlastCD:Start(16, 1)
			timerGossamerBurstCD:Start(33, self.vb.burstCount+1)
			timerPhaseCD:Start(99.8)--Til next movement
		else--Last movement
			self:SetStage(1.75)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop them for last time, and not restart them, stage 2 soon
			timerChillingBlastCD:Start(16, 1)
			timerGossamerBurstCD:Start(33, self.vb.burstCount+1)
			timerPhaseCD:Start(54.3)--Til Apex cast
		end
	end
end
