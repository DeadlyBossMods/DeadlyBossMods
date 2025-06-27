if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2688, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237660, 237661, 237662)
mod:SetEncounterID(3122)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20250627000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1234565 1222244 1227355 1227809 1218103 1241833 1222337 1242259 1231501 1232568 1232569 1227117",
	"SPELL_CAST_SUCCESS 1227058 1245384 1225154 1227113",
	"SPELL_AURA_APPLIED 1226493 1233093 1233863",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1233093 1233863 1242133",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, find Devourer's Ire initial cast event and debuffs
--TODO, https://www.wowhead.com/ptr-2/spell=1222310/unending-hunger stack counter for personal?
--TODO, targetscan voidstep?
--TODO, prep mythic mechanics
--TODO, detect hunt targets
--TODO, warn https://www.wowhead.com/ptr-2/spell=1247415/weakened-prey ?
--TODO, tank swaps based on https://www.wowhead.com/ptr-2/spell=1221490/fel-singed or just after every eye beam pushback?
--TODO, warn https://www.wowhead.com/ptr-2/spell=1249198/unstable-soul ?
--Adarus Duskblaze
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32500))
local warnConsume									= mod:NewCountAnnounce(1234565, 3)

local specWarnVoidstep								= mod:NewSpecialWarningDodgeCount(1227355, nil, nil, nil, 2, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerConsumeCD								= mod:NewAITimer(97.3, 1234565, nil, nil, nil, 2)
local timerVoidstepCD								= mod:NewAITimer(97.3, 1227355, nil, nil, nil, 3)
--Velaryn Bloodwrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31792))
local warnFelInferno								= mod:NewCountAnnounce(1245384, 3)

local specWarnBladeDance							= mod:NewSpecialWarningDodgeCount(1227058, nil, nil, nil, 2, 2)
local specWarnEyebeam								= mod:NewSpecialWarningDefensive(1218103, nil, nil, nil, 1, 13)

local timerTheHuntCD								= mod:NewAITimer(97.3, 1227809, nil, nil, nil, 3)
local timerBladeDanceCD								= mod:NewAITimer(97.3, 1227058, nil, nil, nil, 3)
local timerEyeBeamCD								= mod:NewAITimer(97.3, 1218103, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFelInfernoCD								= mod:NewAITimer(97.3, 1245384, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--Ilyssa Darksorrow
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31791))
local warnImmolationAura							= mod:NewCountAnnounce(1225154, 2)

local specWarnFractured								= mod:NewSpecialWarningDefensive(1241833, nil, nil, nil, 1, 2)
local specWarnShatteredSoul							= mod:NewSpecialWarningTaunt(1226493, false, nil, nil, 1, 2)
local specWarnSpiritBombs							= mod:NewSpecialWarningCount(1242259, nil, nil, nil, 2, 2)

local timerFracturedCD								= mod:NewAITimer(97.3, 1241833, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSpiritBombsCD							= mod:NewAITimer(97.3, 1242259, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerImmolationAuraCD							= mod:NewAITimer(97.3, 1225154, nil, nil, nil, 2)
--Intermission: The Ceaseless Hunger
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32566))
local warnCollapsingStarOver						= mod:NewEndAnnounce(1233093, 1)

local specWarnCollapsingStar						= mod:NewSpecialWarningSpell(1233093, nil, nil, nil, 2, 2)
--Intermission: The Demon Within
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32552))
local warnFelRushOver								= mod:NewEndAnnounce(1233863, 1)

local specWarnFelRush								= mod:NewSpecialWarningDodge(1233863, nil, nil, nil, 2, 2)
--Intermission: The Unrelenting Pain
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32545))
local warnInfernalStrike							= mod:NewSpellAnnounce(1227113, 2)
local warnFelDevastation							= mod:NewSpellAnnounce(1227117, 3)

mod.vb.consumeCount = 0
mod.vb.voidstepCount = 0
mod.vb.huntCount = 0
mod.vb.bladeDanceCount = 0
mod.vb.eyeBeamCount = 0
mod.vb.felInfernoCount = 0
mod.vb.fracturedCount = 0
mod.vb.spiritBombsCount = 0
mod.vb.immolationAuraCount = 0

function mod:OnCombatStart(delay)
	self.vb.consumeCount = 0
	self.vb.voidstepCount = 0
	self.vb.huntCount = 0
	self.vb.bladeDanceCount = 0
	self.vb.eyeBeamCount = 0
	self.vb.felInfernoCount = 0
	self.vb.fracturedCount = 0
	self.vb.spiritBombsCount = 0
	self.vb.immolationAuraCount = 0
	timerConsumeCD:Start(1-delay)
	timerVoidstepCD:Start(1-delay)
	timerTheHuntCD:Start(1-delay)
	timerBladeDanceCD:Start(1-delay)
	timerEyeBeamCD:Start(1-delay)
	timerFelInfernoCD:Start(1-delay)
	timerFracturedCD:Start(1-delay)
	timerSpiritBombsCD:Start(1-delay)
	timerImmolationAuraCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1234565 or spellId == 1222244 then
		self.vb.consumeCount = self.vb.consumeCount + 1
		warnConsume:Show(self.vb.consumeCount)
		timerConsumeCD:Start()--, self.vb.consumeCount+1)
	elseif spellId == 1227355 then
		self.vb.voidstepCount = self.vb.voidstepCount + 1
		specWarnVoidstep:Show(self.vb.voidstepCount)
		specWarnVoidstep:Play("watchstep")
		timerVoidstepCD:Start()--nil, self.vb.voidstepCount+1
	elseif spellId == 1227809 then
		self.vb.huntCount = self.vb.huntCount + 1
		timerTheHuntCD:Start()--nil, self.vb.huntCount+1
	elseif spellId == 1218103 then
		self.vb.eyeBeamCount = self.vb.eyeBeamCount + 1
		timerEyeBeamCD:Start()--nil, self.vb.eyeBeamCount+1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEyebeam:Show()
			specWarnEyebeam:Play("pushbackincoming")
		end
	elseif spellId == 1241833 then
		self.vb.fracturedCount = self.vb.fracturedCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnFractured:Show()
			specWarnFractured:Play("defensive")
		end
		timerFracturedCD:Start()--nil, self.vb.fracturedCount
	elseif spellId == 1242259 then
		self.vb.spiritBombsCount = self.vb.spiritBombsCount + 1
		specWarnSpiritBombs:Show(self.vb.spiritBombsCount)
		specWarnSpiritBombs:Play("aesoon")
		timerSpiritBombsCD:Start()--nil, self.vb.spiritBombsCount+1
	elseif spellId == 1227117 then
		warnFelDevastation:Show()
	elseif (spellId == 1231501 or spellId == 1232568 or spellId == 1232569) and self:AntiSpam(3, 1) then--Intermissions (Metamorphosis)
		--Stop all timers
		timerConsumeCD:Stop()
		timerVoidstepCD:Stop()
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
		timerFelInfernoCD:Stop()
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
		timerImmolationAuraCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1227058 then
		self.vb.bladeDanceCount = self.vb.bladeDanceCount + 1
		specWarnBladeDance:Show(self.vb.bladeDanceCount)
		specWarnBladeDance:Play("whirlwind")
		timerBladeDanceCD:Start()--nil, self.vb.bladeDanceCount+1
	elseif spellId == 1245384 then
		self.vb.felInfernoCount = self.vb.felInfernoCount + 1
		warnFelInferno:Show(self.vb.felInfernoCount)
		timerFelInfernoCD:Start()--nil, self.vb.felInferno
	elseif spellId == 1225154 then
		self.vb.immolationAuraCount = self.vb.immolationAuraCount + 1
		warnImmolationAura:Show(self.vb.immolationAuraCount)
		timerImmolationAuraCD:Start()--nil, self.vb.immolationAura
	elseif spellId == 1227113 then
		warnInfernalStrike:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1226493 then
		if args:IsPlayer() then
			--Warn to taunt the other boss?
		else
			specWarnShatteredSoul:Show(args.destName)
			specWarnShatteredSoul:Play("tauntboss")
		end
	elseif spellId == 1233093 then--Ultimate
		specWarnCollapsingStar:Show()
		specWarnCollapsingStar:Play("runtoedge")
		specWarnCollapsingStar:ScheduleVoice(2, "helpsoak")
	elseif spellId == 1233863 then--Ultimate
		specWarnFelRush:Show()
		specWarnFelRush:Play("watchstep")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1233093 then--Ultimate
		warnCollapsingStarOver:Show()
	elseif spellId == 1233863 then--Ultimate
		warnFelRushOver:Show()
	elseif spellId == 1242133 then--Soul Engorgement
		local cid = self:GetCIDFromGUID(args.destGUID)
		local cid2 = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 237661 or cid2 == 237661) and self:AntiSpam(3, 2) then--Adarus Duskblaze
			timerConsumeCD:Start(2)
			timerVoidstepCD:Start(2)
		elseif (cid == 237660 or cid2 == 237660) and self:AntiSpam(3, 3) then--Velaryn Bloodwrath
			timerTheHuntCD:Start(2)
			timerBladeDanceCD:Start(2)
			timerEyeBeamCD:Start(2)
			timerFelInfernoCD:Start(2)
		elseif (cid == 237662 or cid2 == 237662) and self:AntiSpam(3, 4) then--Ilyssa Darksorrow
			timerFracturedCD:Start(2)
			timerSpiritBombsCD:Start(2)
			timerImmolationAuraCD:Start(2)
		end
	end
end


--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 237661 then--Adarus Duskblaze
		timerConsumeCD:Stop()
		timerVoidstepCD:Stop()
	elseif cid == 237660 then--Velaryn Bloodwrath
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
		timerFelInfernoCD:Stop()
	elseif cid == 237662 then--Ilyssa Darksorrow
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
		timerImmolationAuraCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
