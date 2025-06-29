if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2684, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233814)
mod:SetEncounterID(3129)
mod:SetHotfixNoticeRev(20250629000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1219450 1219263 1219531 1220489 1220553 1220555 1234733",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1219459 1219439 1219607",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1219459 1219439 1219607 1220618 1220981 1220982",
	"SPELL_PERIODIC_DAMAGE 1219354",
	"SPELL_PERIODIC_MISSED 1219354"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, properly detect intake cast
--TODO do anything with https://www.wowhead.com/ptr-2/spell=1223364/powered-automaton ?
--TODO verify purge IDs
--[[
(ability.id = 1220489 or ability.id = 1220553 or ability.id = 1220555 or ability.id = 1234733) and type = "begincast"
 or (ability.id = 1220618 or ability.id = 1220981 or ability.id = 1220982) and type = "removebuff"
--]]
--Stage One: Purge The Intruders
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(31626))
local warnManifestMatrices							= mod:NewTargetAnnounce(1219450, 3)
local warnEradicatingSalvo							= mod:NewTargetCountAnnounce(1219531, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnManifestMatrices						= mod:NewSpecialWarningMoveAway(1219450, nil, nil, nil, 1, 2)
local yellManifestMatrices							= mod:NewShortYell(1219450)
local yellManifestMatricesFades						= mod:NewShortFadesYell(1219450)
local specWarnObliterationArcanocannon				= mod:NewSpecialWarningYou(1219263, nil, nil, nil, 1, 2)
local yellObliterationArcanocannon					= mod:NewShortYell(1219263)
local yellObliterationArcanocannonFades				= mod:NewShortFadesYell(1219263)
local specWarnObliterationArcanocannonOther			= mod:NewSpecialWarningTaunt(1219263, nil, nil, nil, 1, 2)
local specWarnEradicatingSalvo						= mod:NewSpecialWarningYouPosCount(1219531, nil, nil, nil, 1, 2)
local yellEradicatingSalvo							= mod:NewShortPosYell(1219531, nil, nil, nil, "YELL")
local yellEradicatingSalvoFades						= mod:NewIconFadesYell(1219531, nil, nil, nil, "YELL")
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1219354, nil, nil, nil, 1, 8)

mod:AddSetIconOption("SetIconOnEradicatingSalvo", 1219531, true, 0, {1, 2})

local timerManifestMatricesCD						= mod:NewVarCountTimer("v33.1-38.9", 1219450, nil, nil, nil, 3)
local timerObliterationArcanocannonCD				= mod:NewVarCountTimer("v34.0-36.5", 1219263, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEradicatingSalvoCD						= mod:NewVarCountTimer("v34.0-36.5", 1219531, nil, nil, nil, 3)
--Stage Two: The Sieve Awakens
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(31634))
local specWarnProtocolPurge							= mod:NewSpecialWarningCount(1220489, nil, nil, nil, 3, 2)

local timerProtocolPurgeCD							= mod:NewCDCountTimer(97.3, 1220489, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)
local timerCleansetheChamberCD						= mod:NewCDCountTimer(97.3, 1234733, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)

mod.vb.matricesCount = 0
mod.vb.arcanocannonCount = 0
mod.vb.eradicatingSalvoCount = 0
mod.vb.radicatingIcon = 1
mod.vb.purgeCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.matricesCount = 0
	self.vb.arcanocannonCount = 0
	self.vb.eradicatingSalvoCount = 0
	self.vb.radicatingIcon = 1
	self.vb.purgeCount = 0
	timerManifestMatricesCD:Start(11.1-delay, 1)
	timerObliterationArcanocannonCD:Start(20.9-delay, 1)
	timerEradicatingSalvoCD:Start(30.7-delay, 1)
	timerProtocolPurgeCD:Start(61.2-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1219450 then
		self.vb.matricesCount = self.vb.matricesCount + 1
		local timer = self.vb.purgeCount == 1 and 33.1 or self.vb.purgeCount == 4 and "v35.2-38.9" or 35.2
		timerManifestMatricesCD:Start(timer, self.vb.matricesCount+1)
	elseif spellId == 1219263 then
		self.vb.arcanocannonCount = self.vb.arcanocannonCount + 1
		local timer = self.vb.purgeCount == 4 and "v34.0-36.5" or 34
		timerObliterationArcanocannonCD:Start(timer, self.vb.arcanocannonCount+1)
	elseif spellId == 1219531 then
		self.vb.eradicatingSalvoCount = self.vb.eradicatingSalvoCount + 1
		self.vb.radicatingIcon = 1
		local timer = self.vb.purgeCount == 4 and "v34.0-36.5" or 34
		timerEradicatingSalvoCD:Start(timer, self.vb.eradicatingSalvoCount+1)
	elseif spellId == 1220489 or spellId == 1220553 or spellId == 1220555 then
		self:SetStage(2)
		self.vb.purgeCount = self.vb.purgeCount + 1
		specWarnProtocolPurge:Show(self.vb.purgeCount)
		specWarnProtocolPurge:Play("findshelter")
		--Stop all timers
		timerManifestMatricesCD:Stop()
		timerObliterationArcanocannonCD:Stop()
		timerEradicatingSalvoCD:Stop()
	elseif spellId == 1234733 and self.vb.purgeCount < 4 then
		self.vb.purgeCount = 4
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1219459 then
		warnManifestMatrices:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnManifestMatrices:Show()
			specWarnManifestMatrices:Play("runout")
			yellManifestMatrices:Yell()
			yellManifestMatricesFades:Countdown(spellId)
		end
	elseif spellId == 1219439 then
		if args:IsPlayer() then
			specWarnObliterationArcanocannon:Show()
			specWarnObliterationArcanocannon:Play("runout")
			yellObliterationArcanocannon:Yell()
			yellObliterationArcanocannonFades:Countdown(spellId)
		else
			specWarnObliterationArcanocannonOther:Show(args.destName)
			specWarnObliterationArcanocannonOther:Play("tauntboss")
		end
	elseif spellId == 1219607 then
		local icon = self.vb.radicatingIcon
		if self.Options.SetIconOnEradicatingSalvo then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnEradicatingSalvo:Show(self.vb.eradicatingSalvoCount, self:IconNumToTexture(icon))
			specWarnEradicatingSalvo:Play("targetyou")
			yellEradicatingSalvo:Yell(icon, icon)
			yellEradicatingSalvoFades:Countdown(spellId, nil, icon)
		end
		warnEradicatingSalvo:CombinedShow(0.3, self.vb.eradicatingSalvoCount, args.destName)
		self.vb.radicatingIcon = self.vb.radicatingIcon + 1
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1219459 then
		if args:IsPlayer() then
			yellManifestMatricesFades:Cancel()
		end
	elseif spellId == 1219439 then
		if args:IsPlayer() then
			yellObliterationArcanocannonFades:Cancel()
		end
	elseif spellId == 1219607 then
		if self.Options.SetIconOnEradicatingSalvo then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellEradicatingSalvoFades:Cancel()
		end
	elseif spellId == 1220618 or spellId == 1220981 or spellId == 1220982 then--Purge Removed
		self:SetStage(1)
		--restart Timers
		self.vb.matricesCount = 0
		self.vb.arcanocannonCount = 0
		self.vb.eradicatingSalvoCount = 0
		self.vb.radicatingIcon = 1
		timerManifestMatricesCD:Start("v5.9-6.8", 1)
		timerObliterationArcanocannonCD:Start(2)
		timerEradicatingSalvoCD:Start("v27.7-28.8", 1)
		if self.vb.purgeCount < 3 then
			timerProtocolPurgeCD:Start(94, self.vb.purgeCount+1)
		else
			timerCleansetheChamberCD:Start(93.3, self.vb.purgeCount+1)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1219354 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
