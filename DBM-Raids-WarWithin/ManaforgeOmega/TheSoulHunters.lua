if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2688, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237660, 237661, 237662)
mod:SetEncounterID(3122)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20250628000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1227355 1227809 1218103 1241833 1222337 1242259 1231501 1232568 1232569 1227117",
	"SPELL_CAST_SUCCESS 1233672",--1227058
	"SPELL_AURA_APPLIED 1226493 1233093 1233863",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1233093 1233863 1242133",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, https://www.wowhead.com/ptr-2/spell=1222310/unending-hunger stack counter for personal?
--TODO, targetscan voidstep?
--TODO, prep mythic mechanics
--TODO, detect hunt targets
--TODO, warn https://www.wowhead.com/ptr-2/spell=1247415/weakened-prey ?
--TODO, tank swaps based on https://www.wowhead.com/ptr-2/spell=1221490/fel-singed or just after every eye beam pushback?
--TODO, warn https://www.wowhead.com/ptr-2/spell=1249198/unstable-soul ?
--TODO, https://www.wowhead.com/ptr-2/spell=1233381/withering-flames tracker?
--[[
(ability.id = 1231501 or ability.id = 1232568 or ability.id = 1232569) and type = "begincast" or ability.id = 1242133
--]]
--General
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerBerserkCD								= mod:NewBerserkTimer(600)
--Adarus Duskblaze
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32500))
local specWarnVoidstep								= mod:NewSpecialWarningDodgeCount(1227355, nil, nil, nil, 2, 2)

local timerVoidstepCD								= mod:NewNextCountTimer(97.3, 1227355, nil, nil, nil, 3)--29.0, 26.2
local timerCollapsingStarCD							= mod:NewNextTimer(97.3, 1233093, nil, nil, nil, 6)
--Velaryn Bloodwrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31792))
local specWarnBladeDance							= mod:NewSpecialWarningDodgeCount(1227058, nil, nil, nil, 2, 2)
local specWarnEyebeam								= mod:NewSpecialWarningDefensive(1218103, nil, nil, nil, 1, 13)

local timerTheHuntCD								= mod:NewNextCountTimer(32.6, 1227809, nil, nil, nil, 3)
local timerBladeDanceCD								= mod:NewNextCountTimer(32.6, 1227058, nil, nil, nil, 3)
local timerEyeBeamCD								= mod:NewNextCountTimer(32.6, 1218103, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFelRushCD								= mod:NewNextTimer(97.3, 1233863, nil, nil, nil, 6)
--Ilyssa Darksorrow
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31791))
local specWarnFractured								= mod:NewSpecialWarningDefensive(1241833, nil, nil, nil, 1, 2)
local specWarnShatteredSoul							= mod:NewSpecialWarningTaunt(1226493, false, nil, nil, 1, 2)
local specWarnSpiritBombs							= mod:NewSpecialWarningCount(1242259, nil, nil, nil, 2, 2)

local timerFracturedCD								= mod:NewNextCountTimer(32.6, 1241833, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSpiritBombsCD							= mod:NewNextCountTimer(32.6, 1242259, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerFelDevastationCD							= mod:NewNextTimer(97.3, 1227117, nil, nil, nil, 6)
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

mod.vb.intermissionCount = 0
mod.vb.consumeCount = 0
mod.vb.voidstepCount = 0
mod.vb.huntCount = 0
mod.vb.bladeDanceCount = 0
mod.vb.eyeBeamCount = 0
mod.vb.fracturedCount = 0
mod.vb.spiritBombsCount = 0

function mod:OnCombatStart(delay)
	self.vb.intermissionCount = 0
	self.vb.consumeCount = 0
	self.vb.voidstepCount = 0
	self.vb.huntCount = 0
	self.vb.bladeDanceCount = 0
	self.vb.eyeBeamCount = 0
	self.vb.fracturedCount = 0
	self.vb.spiritBombsCount = 0
	timerVoidstepCD:Start(31.4-delay, 1)
	timerTheHuntCD:Start(40.7-delay, 1)
	timerBladeDanceCD:Start(30.2-delay, 1)
	timerEyeBeamCD:Start(19.3-delay, 1)
	timerFracturedCD:Start(15-delay, 1)
	timerSpiritBombsCD:Start(31.3-delay, 1)
	timerCollapsingStarCD:Start(102-delay)--First special
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1227355 then
		self.vb.voidstepCount = self.vb.voidstepCount + 1
		specWarnVoidstep:Show(self.vb.voidstepCount)
		specWarnVoidstep:Play("watchstep")
		if self.vb.voidstepCount == 1 then
			timerVoidstepCD:Start(29, self.vb.voidstepCount+1)
		elseif self.vb.voidstepCount == 2 then
			timerVoidstepCD:Start(26.2, self.vb.voidstepCount+1)
		end
	elseif spellId == 1227809 then
		self.vb.huntCount = self.vb.huntCount + 1
		if self.vb.huntCount == 1 then
			timerTheHuntCD:Start(nil, self.vb.huntCount+1)
		end
	elseif spellId == 1218103 then
		self.vb.eyeBeamCount = self.vb.eyeBeamCount + 1
		timerEyeBeamCD:Start(nil, self.vb.eyeBeamCount+1)
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
		timerFracturedCD:Start(nil, self.vb.fracturedCount)
	elseif spellId == 1242259 then
		self.vb.spiritBombsCount = self.vb.spiritBombsCount + 1
		specWarnSpiritBombs:Show(self.vb.spiritBombsCount)
		specWarnSpiritBombs:Play("aesoon")
		timerSpiritBombsCD:Start(nil, self.vb.spiritBombsCount+1)
	elseif spellId == 1227117 then
		warnFelDevastation:Show()
	elseif (spellId == 1231501 or spellId == 1232568 or spellId == 1232569) and self:AntiSpam(5, 1) then--Intermissions (Metamorphosis)
		self.vb.intermissionCount = self.vb.intermissionCount + 1
		--Reset Counts
		self.vb.voidstepCount = 0
		self.vb.huntCount = 0
		self.vb.bladeDanceCount = 0
		self.vb.eyeBeamCount = 0
		self.vb.fracturedCount = 0
		self.vb.spiritBombsCount = 0
		--Stop all timers
		timerVoidstepCD:Stop()
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
		if self.vb.intermissionCount == 1 then
			timerFelRushCD:Start(121)--Second Special
		elseif self.vb.intermissionCount == 2 then
			timerFelDevastationCD:Start(121)--Third Special
		else--All 3 specials
			timerBerserkCD:Start(52.5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1233672 then
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
		--Ugly but more accurate than just assuming all bosses are alive (in event one of em died early)
		local cid = self:GetCIDFromGUID(args.destGUID)
		local cid2 = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 237661 or cid2 == 237661) and self:AntiSpam(3, 2) then--Adarus Duskblaze
			timerVoidstepCD:Start(self.vb.intermissionCount == 3 and 9 or 20, 1)
		elseif (cid == 237660 or cid2 == 237660) and self:AntiSpam(3, 3) then--Velaryn Bloodwrath
			if self.vb.intermissionCount == 3 then
				timerTheHuntCD:Start(7.5, 1)
--				timerBladeDanceCD:Start(6, 1)--UNKNOWN
--				timerEyeBeamCD:Start(7.9, 1)--Not cast after 3rd intermission
			else
				timerBladeDanceCD:Start(6, 1)--Estimated, not in combat log
				timerEyeBeamCD:Start(7.9, 1)
				timerTheHuntCD:Start(29.3, 1)
			end
		elseif (cid == 237662 or cid2 == 237662) and self:AntiSpam(3, 4) then--Ilyssa Darksorrow
			if self.vb.intermissionCount == 3 then
				timerFracturedCD:Start(4.6, 1)
				timerSpiritBombsCD:Start(14.4, 1)
			else
				timerFracturedCD:Start(3.5, 1)
				timerSpiritBombsCD:Start(19.8, 1)
			end
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
		timerVoidstepCD:Stop()
	elseif cid == 237660 then--Velaryn Bloodwrath
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
	elseif cid == 237662 then--Ilyssa Darksorrow
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 1241254 then
		self.vb.bladeDanceCount = self.vb.bladeDanceCount + 1
		specWarnBladeDance:Show(self.vb.bladeDanceCount)
		specWarnBladeDance:Play("whirlwind")
		timerBladeDanceCD:Start(nil, self.vb.bladeDanceCount+1)
	end
end
