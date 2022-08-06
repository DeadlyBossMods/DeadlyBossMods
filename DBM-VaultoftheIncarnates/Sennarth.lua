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
	"SPELL_CAST_START 371976 372082 373405 372045 372129 374112 373027 371983",
	"SPELL_CAST_SUCCESS 372765 372051",
	"SPELL_SUMMON 372242 372843",
	"SPELL_AURA_APPLIED 371976 372082 372030 372044 385083",
	"SPELL_AURA_APPLIED_DOSE 372030 385083",
	"SPELL_AURA_REMOVED 371976 372082 372030",
	"SPELL_AURA_REMOVED_DOSE 372030",
--	"SPELL_PERIODIC_DAMAGE 372055",
--	"SPELL_PERIODIC_MISSED 372055",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, right breath of ice trigger and target scan for it if applicable
--TODO, GTFO for icy Ground?
--TODO, verify Call Spiderlings trigger that's best to use and add auto marking if spell summon works and it's not too many
--TODO, kill or aggregate eruption warning if it's just an aoe fest
--TODO, proper/cleaner stage 1 to 1.5 and back to 1 code, as well as proper stage 2 start trigger
--TODO, maybe phase 2 on https://www.wowhead.com/beta/spell=372648/pervasive-cold instead
--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Stage One: Ice Climbers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24883))
local warnBreathofIce							= mod:NewSpellAnnounce(372051, 2)
local warnChillingBlast							= mod:NewTargetAnnounce(371976, 2)
local warnEnvelopingWebs						= mod:NewTargetNoFilterAnnounce(372082, 3)
local warnWrappedInWebs							= mod:NewTargetNoFilterAnnounce(372044, 4)
local warnCallSpiderlings						= mod:NewSpellAnnounce(372238, 2)
local warnCausticEruption						= mod:NewCountAnnounce(372045, 3)

local specWarnChillingBlast						= mod:NewSpecialWarningMoveAway(371976, nil, nil, nil, 1, 2)
local yellChillingBlast							= mod:NewYell(371976)
local yellChillingBlastFades					= mod:NewShortFadesYell(371976)
local specWarnEnvelopingWebs					= mod:NewSpecialWarningPos(372082, nil, nil, nil, 1, 2)
local yellEnvelopingWebs						= mod:NewPosYell(372082)
local yellEnvelopingWebsFades					= mod:NewIconFadesYell(372082)
local specWarnStickyWebbing						= mod:NewSpecialWarningStack(372030, nil, 8, nil, nil, 1, 6)
local specWarnGossamerBurst						= mod:NewSpecialWarningSpell(373405, nil, nil, nil, 2, 12)
local specWarnWebBlast							= mod:NewSpecialWarningTaunt(385083, nil, nil, nil, 1, 2)

local timerBreathofIceCD						= mod:NewAITimer(35, 372051, nil, nil, nil, 3)
local timerChillingBlastCD						= mod:NewAITimer(35, 371976, nil, nil, nil, 3)
local timerEnveloopingWebsCD					= mod:NewAITimer(35, 372082, nil, nil, nil, 3)
local timerGossamerBurstCD						= mod:NewAITimer(35, 373405, nil, nil, nil, 2)
local timerCallSpiderlingsCD					= mod:NewAITimer(35, 372238, nil, nil, nil, 1)
local timerWebBlastCD							= mod:NewAITimer(35, 372129, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(372030, false)--Useful raid leader tool, but not needed by everyone
mod:AddSetIconOption("SetIconOnWeb", 372082, true, false, {1, 2, 3})
--Intermission: Guardians of Frost
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24898))
local warnFrostbreathArachnid						= mod:NewSpellAnnounce(372843, 2)

local specWarnFreezingBreath						= mod:NewSpecialWarningDefensive(374112, nil, nil, nil, 1, 2)

local timerFreezingBreathCD							= mod:NewAITimer(35, 374112, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: Cold Peak
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24885))
local warnApexofIce									= mod:NewCastAnnounce(372539, 3)
local warnSuffocatinWebs							= mod:NewTargetNoFilterAnnounce(373027, 3)

local specWarnSuffocatingWebs						= mod:NewSpecialWarningPos(373027, nil, nil, nil, 1, 2)
local yellSuffocatingWebs							= mod:NewPosYell(373027)
local yellSuffocatingWebsFades						= mod:NewIconFadesYell(373027)
local specWarnRepellingBurst						= mod:NewSpecialWarningSpell(371983, nil, nil, nil, 2, 12)

local timerSuffocatingWebsCD						= mod:NewAITimer(35, 373027, nil, nil, nil, 3)
local timerRepellingBurstCD							= mod:NewAITimer(35, 371983, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnSufWeb", 373027, true, false, {1, 2, 3})

local stickyStacks = {}
mod.vb.webIcon = 1
mod.vb.eruptionCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(stickyStacks)
	self.vb.webIcon = 1
	self.vb.eruptionCount = 0
	timerBreathofIceCD:Start(1-delay)
	timerChillingBlastCD:Start(1-delay)
	timerEnveloopingWebsCD:Start(1-delay)
	timerGossamerBurstCD:Start(1-delay)
	timerCallSpiderlingsCD:Start(1-delay)
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
		timerChillingBlastCD:Start()
	elseif spellId == 372082 then
		self.vb.webIcon = 1
		timerEnveloopingWebsCD:Start()
	elseif spellId == 373405 then
		specWarnGossamerBurst:Show()
		specWarnGossamerBurst:Play("pullin")
		timerGossamerBurstCD:Start()
	elseif spellId == 372045 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		warnCausticEruption:Show(self.vb.eruptionCount)
	elseif spellId == 372129 then
		timerWebBlastCD:Start()
	elseif spellId == 374112 then
		if self:IsTanking("player", nil, nil, nil, args.destGUID) then-- use self:IsTanking("player", "boss2", nil, true) if this gets boss unit id
			specWarnFreezingBreath:Show()
			specWarnFreezingBreath:Play("defensive")
		end
		timerFreezingBreathCD:Start()
	elseif spellId == 372539 then
		warnApexofIce:Show()
	elseif spellId == 373027 then
		self.vb.webIcon = 1
	elseif spellId == 371983 then
		specWarnRepellingBurst:Show()
		specWarnRepellingBurst:Play("carefly")
		timerRepellingBurstCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 372765 or spellId == 372051 then
		warnBreathofIce:Show()
		timerBreathofIceCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 372242 and self:AntiSpam(5, 1) then--Caustic Spiderling
		self.vb.eruptionCount = 0
		warnCallSpiderlings:Show()
		timerCallSpiderlingsCD:Start()
	elseif spellId == 372843 then--Frostbreath Arachnid
		warnFrostbreathArachnid:Show()
		timerFreezingBreathCD:Start(1)
		if self.vb.phase == 1 then
			self:SetStage(1.5)
			timerBreathofIceCD:Stop()
			timerChillingBlastCD:Stop()
			timerEnveloopingWebsCD:Stop()
			timerGossamerBurstCD:Stop()
			timerCallSpiderlingsCD:Stop()
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
	elseif spellId == 372082 then
		local amount = args.amount or 1
		stickyStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
		if args:IsPlayer() and amount >= 8 then
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
	elseif spellId == 372082 then
		stickyStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
	elseif spellId == 372539 then--Apex of Ice
		self:SetStage(2)
		timerChillingBlastCD:Start(2)
		timerSuffocatingWebsCD:Start(2)
		timerRepellingBurstCD:Start(2)
		timerCallSpiderlingsCD:Start(2)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 372082 then
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 189234 then--Frostbreath Arachnid
		self:SetStage(1)--Likely totally wrong
		timerFreezingBreathCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 372238 and self:AntiSpam(5, 1) then
		self.vb.eruptionCount = 0
		warnCallSpiderlings:Show()
		timerCallSpiderlingsCD:Start()
	end
end
