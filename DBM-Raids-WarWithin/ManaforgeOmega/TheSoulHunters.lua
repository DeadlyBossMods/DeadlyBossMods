local mod	= DBM:NewMod(2688, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237660, 237661, 237662)
mod:SetEncounterID(3122)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20250818000000)
mod:SetMinSyncRevision(20250818000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1227355 1227809 1218103 1241833 1222337 1242259 1231501 1232568 1232569 1227117 1240891 1245726",
	"SPELL_CAST_SUCCESS 1233672 1241833",--1227058
	"SPELL_AURA_APPLIED 1226493 1233093 1233863 1218103",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1233093 1233863 1245978 1242133",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, https://www.wowhead.com/ptr-2/spell=1222310/unending-hunger stack counter for personal?
--TODO, targetscan voidstep?
--TODO, warn https://www.wowhead.com/ptr-2/spell=1247415/weakened-prey ?
--TODO, tank swaps based on https://www.wowhead.com/ptr-2/spell=1221490/fel-singed or just after every eye beam pushback?
--TODO, warn https://www.wowhead.com/ptr-2/spell=1249198/unstable-soul ?
--TODO, https://www.wowhead.com/ptr-2/spell=1233381/withering-flames tracker?
--[[
(ability.id = 1231501 or ability.id = 1232568 or ability.id = 1232569) and type = "begincast" or (ability.id = 1242133 or ability.id = 1245978) and type = "removebuff"
--]]
--General
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerBerserkCD								= mod:NewBerserkTimer(600)
--Adarus Duskblaze
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32500))
local specWarnVoidstep								= mod:NewSpecialWarningDodgeCount(1227355, nil, nil, nil, 2, 2)
local specWarnEradicate								= mod:NewSpecialWarningDodgeCount(1245726, nil, nil, nil, 2, 2)

local timerVoidstepCD								= mod:NewNextCountTimer(97.3, 1227355, nil, nil, nil, 3)--29.0, 26.2
local timerEradicateCD								= mod:NewNextCountTimer(97.3, 1245726, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCollapsingStarCD							= mod:NewNextTimer(97.3, 1233093, nil, nil, nil, 6)
--Velaryn Bloodwrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31792))
local warnTheHunt									= mod:NewTargetCountAnnounce(1227809, 2, nil, nil, nil, nil, nil, nil, true)

local specWarnBladeDance							= mod:NewSpecialWarningDodgeCount(1241306, nil, nil, nil, 2, 2)
local specWarnEyebeam								= mod:NewSpecialWarningDefensive(1218103, nil, nil, nil, 1, 13)
local specWarnEyeBeamTaunt							= mod:NewSpecialWarningTaunt(1218103, nil, nil, nil, 1, 2)

local specWarnTheHunt								= mod:NewSpecialWarningYou(1227809, nil, nil, nil, 1, 17)
local yellTheHunt									= mod:NewShortYell(1227809, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellTheHuntFades								= mod:NewShortFadesYell(1227809, nil, nil, nil, "YELL")

local timerTheHuntCD								= mod:NewNextCountTimer(31.9, 1227809, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3)
local timerBladeDanceCD								= mod:NewNextCountTimer(31.9, 1241306, nil, nil, nil, 3)
local timerEyeBeamCD								= mod:NewNextCountTimer(31.9, 1218103, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFelRushCD								= mod:NewNextTimer(97.3, 1233863, nil, nil, nil, 6)
--Ilyssa Darksorrow
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31791))
local specWarnFractured								= mod:NewSpecialWarningDefensive(1241833, nil, nil, nil, 1, 2)
local specWarnFracturedTaunt						= mod:NewSpecialWarningTaunt(1241833, nil, nil, nil, 1, 2)
local specWarnShatteredSoul							= mod:NewSpecialWarningTaunt(1226493, false, nil, nil, 1, 2)
local specWarnSpiritBombs							= mod:NewSpecialWarningCount(1242259, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
local specWarnSigilofChains							= mod:NewSpecialWarningCount(1240891, nil, 395745, nil, 2, 12)

local timerFracturedCD								= mod:NewNextCountTimer(31.9, 1241833, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSpiritBombsCD							= mod:NewNextCountTimer(31.9, 1242259, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerSigilofChainsCD							= mod:NewNextCountTimer(31.9, 1240891, 395745, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic only
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
local warnInfernalStrike							= mod:NewSpellAnnounce(1227113, 2, nil, nil, nil, nil, 47482)--Shortname "Leap"
local warnFelDevastation							= mod:NewSpellAnnounce(1227117, 3)

mod.vb.intermissionCount = 0
mod.vb.consumeCount = 0
mod.vb.voidstepCount = 0
mod.vb.eradicateCount = 0
mod.vb.eradicateSubCount = 0
mod.vb.huntCount = 0
mod.vb.huntSubCount = 0
mod.vb.bladeDanceCount = 0
mod.vb.eyeBeamCount = 0
mod.vb.fracturedCount = 0
mod.vb.spiritBombsCount = 0
mod.vb.sigilsCount = 0
mod.vb.VelarnDead = false
mod.vb.IlyssaDead = false
mod.vb.AdarusDead = false
local seenShadow = {}--Eradicate antispam that's more accurate than using antispam object

function mod:OnCombatStart(delay)
	self.vb.intermissionCount = 0
	self.vb.consumeCount = 0
	self.vb.voidstepCount = 0
	self.vb.eradicateCount = 0
	self.vb.eradicateSubCount = 0
	self.vb.huntCount = 0
	self.vb.bladeDanceCount = 0
	self.vb.eyeBeamCount = 0
	self.vb.fracturedCount = 0
	self.vb.spiritBombsCount = 0
	self.vb.sigilsCount = 0
	self.vb.VelarnDead = false
	self.vb.IlyssaDead = false
	self.vb.AdarusDead = false
	timerFracturedCD:Start(15-delay, 1)--Same in all
	if self:IsMythic() then
		timerEyeBeamCD:Start(19.5-delay, 1)
		timerVoidstepCD:Start(26.4-delay, 1)
		timerBladeDanceCD:Start(29.2-delay, 1)
		timerSpiritBombsCD:Start(32-delay, 1)
		timerSigilofChainsCD:Start(39.4-delay, 1)
		timerTheHuntCD:Start(41.8-delay, 1)
		timerEradicateCD:Start(53.2-delay, "1-1")
		timerCollapsingStarCD:Start(108-delay)--First special
	elseif self:IsHeroic() then
		timerEyeBeamCD:Start(19.7-delay, 1)
		timerVoidstepCD:Start(32.6-delay, 1)
		timerBladeDanceCD:Start(29.6-delay, 1)
		timerSpiritBombsCD:Start(32.4-delay, 1)
		timerTheHuntCD:Start(42.5-delay, 1)
		timerCollapsingStarCD:Start(110.3-delay)--First special
	else
		timerEyeBeamCD:Start(19.8-delay, 1)
		timerVoidstepCD:Start(33-delay, 1)
		timerBladeDanceCD:Start(29.9-delay, 1)
		timerSpiritBombsCD:Start(32.9-delay, 1)
		timerTheHuntCD:Start(43.1-delay, 1)
		timerCollapsingStarCD:Start((self:IsLFR() and 113.3 or 110.3)-delay)--First special (maybe the LFR thing is a fluke?)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1227355 then
		self.vb.voidstepCount = self.vb.voidstepCount + 1
		specWarnVoidstep:Show(self.vb.voidstepCount)
		specWarnVoidstep:Play("watchstep")
		if self:IsMythic() then
			if self.vb.voidstepCount == 1 then--On mythic only 2 are cast before intermission instead of 3
				timerVoidstepCD:Start(33.7, self.vb.voidstepCount+1)
			end
		else
			if self.vb.voidstepCount == 1 then
				timerVoidstepCD:Start(self:IsHeroic() and 30.7 or 31.7, self.vb.voidstepCount+1)
			elseif self.vb.voidstepCount == 2 then
				timerVoidstepCD:Start(self:IsHeroic() and 28.1 or 28.7, self.vb.voidstepCount+1)
			end
		end
	elseif spellId == 1227809 and args:GetSrcCreatureID() == 237660 then--Only show casts by Velaryn Bloodwrath
		self.vb.huntCount = self.vb.huntCount + 1
		self.vb.huntSubCount = 0
		if self.vb.huntCount == 1 then
			timerTheHuntCD:Start(self:IsMythic() and 34 or self:IsHeroic() and 34.7 or 35.6, self.vb.huntCount+1)
		end
	elseif spellId == 1218103 then
		self.vb.eyeBeamCount = self.vb.eyeBeamCount + 1
		timerEyeBeamCD:Start(self:IsMythic() and 34 or self:IsHeroic() and 34.7 or 35.6, self.vb.eyeBeamCount+1)
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
		timerFracturedCD:Start(self:IsMythic() and 34 or self:IsHeroic() and 34.7 or 35.6, self.vb.fracturedCount)
	elseif spellId == 1242259 then
		self.vb.spiritBombsCount = self.vb.spiritBombsCount + 1
		specWarnSpiritBombs:Show(self.vb.spiritBombsCount)
		specWarnSpiritBombs:Play("aesoon")
		timerSpiritBombsCD:Start(self:IsMythic() and 34 or self:IsHeroic() and 34.7 or 35.6, self.vb.spiritBombsCount+1)
	elseif spellId == 1227117 then
		warnFelDevastation:Show()
	elseif spellId == 1240891 then
		self.vb.sigilsCount = self.vb.sigilsCount + 1
		specWarnSigilofChains:Show(self.vb.sigilsCount)
		specWarnSigilofChains:Play("pullin")
		if self.vb.sigilsCount == 1 then
			timerSigilofChainsCD:Start(34, self.vb.sigilsCount+1)
		end
	elseif spellId == 1245726 then
		if not seenShadow[args.sourceGUID] then
			seenShadow[args.sourceGUID] = true
			self.vb.eradicateSubCount = 1
			self.vb.eradicateCount = self.vb.eradicateCount + 1
			---@diagnostic disable-next-line: param-type-mismatch
			specWarnEradicate:Show(self.vb.eradicateCount .. "-" .. self.vb.eradicateSubCount)
			specWarnEradicate:Play("watchstep")
			if self.vb.eradicateCount == 1 then
				timerEradicateCD:Start(5, self.vb.eradicateCount .. "-" .. 2)
			end
		else
			self.vb.eradicateSubCount = self.vb.eradicateSubCount + 1
			if self.vb.eradicateSubCount == 4 and self.vb.eradicateCount == 1 then
				--This is the 4th shadow cast, so we can start the next set
				timerEradicateCD:Start(20.7, self.vb.eradicateCount+1 .. "-" .. 1)
			elseif self.vb.eradicateSubCount < 4 then
				timerEradicateCD:Start(5, self.vb.eradicateCount .. "-" .. self.vb.eradicateSubCount+1)
			end
		end
	elseif (spellId == 1231501 or spellId == 1232568 or spellId == 1232569) and self:AntiSpam(5, 1) then--Intermissions (Metamorphosis)
		self.vb.intermissionCount = self.vb.intermissionCount + 1
		--Reset Counts
		self.vb.voidstepCount = 0
		self.vb.huntCount = 0
		self.vb.bladeDanceCount = 0
		self.vb.eyeBeamCount = 0
		self.vb.fracturedCount = 0
		self.vb.spiritBombsCount = 0
		self.vb.sigilsCount = 0
		--Stop all timers
		timerVoidstepCD:Stop()
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
		timerSigilofChainsCD:Stop()
		timerEradicateCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1233672 then
		warnInfernalStrike:Show()
	elseif spellId == 1241833 and not args:IsPlayer() then
		specWarnFracturedTaunt:Show(args.destName)
		specWarnFracturedTaunt:Play("tauntboss")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1226493 then
		if not args:IsPlayer() then
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
	elseif spellId == 1218103 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnEyeBeamTaunt:Show(args.destName)
			specWarnEyeBeamTaunt:Play("tauntboss")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1233093 then--Ultimate
		warnCollapsingStarOver:Show()
	elseif spellId == 1233863 then--Ultimate
		warnFelRushOver:Show()
	elseif (spellId == 1242133 or spellId == 1245978) and self:AntiSpam(10, 2) then--Soul Tether/Soul Engorgement Ending
		if self:IsMythic() and self.vb.intermissionCount == 3 then--Custom mythic only rule
			if not self.vb.AdarusDead then
				timerVoidstepCD:Start(9.2, 1)
			end
			if not self.vb.VelarnDead then
				timerTheHuntCD:Start(7.6, 1)
			end
			if not self.vb.IlyssaDead then
				timerFracturedCD:Start(4.6, 1)
				timerSpiritBombsCD:Start(14.8, 1)
			end
			timerBerserkCD:Start(22.4)
		else
			if not self.vb.AdarusDead then
				timerVoidstepCD:Start(self:IsMythic() and 15 or self:IsHeroic() and 21 or 21.5, 1)
				if self:IsMythic() then
					timerEradicateCD:Start(41.8, "1-1")
				end
			end
			if not self.vb.VelarnDead then
				timerEyeBeamCD:Start(8, 1)--difference between difficulties is only .1 each, so we ignore it
				timerBladeDanceCD:Start(self:IsMythic() and 17.7 or self:IsHeroic() and 18.0 or 18.3, 1)
				timerTheHuntCD:Start(self:IsHeroic() and 30.4 or 31.5, 1)
			end
			if not self.vb.IlyssaDead then
				timerFracturedCD:Start(3.5, 1)--Same in all
				timerSpiritBombsCD:Start(self:IsMythic() and 20.4 or self:IsHeroic() and 20.9 or 21.4, 1)
				if self:IsMythic() then
					timerSigilofChainsCD:Start(27.9, 1)
				end
			end
		end
		if self.vb.intermissionCount == 1 then
			timerFelRushCD:Start(self:IsMythic() and 96.7 or self:IsHeroic() and 99.4 or 98.8)--98.8 on normal is some wierd kind of fluke, it's normally 101.7
		elseif self.vb.intermissionCount == 2 then
			timerFelDevastationCD:Start(self:IsMythic() and 96.7 or self:IsHeroic() and 99.4 or 101.7)--Third Special
		elseif not self:IsMythic() and self.vb.intermissionCount == 3 then
			timerBerserkCD:Start(self:IsHeroic() and 62.6 or 101.7)
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
		self.vb.AdarusDead = true
	elseif cid == 237660 then--Velaryn Bloodwrath
		timerTheHuntCD:Stop()
		timerBladeDanceCD:Stop()
		timerEyeBeamCD:Stop()
		self.vb.VelarnDead = true
	elseif cid == 237662 then--Ilyssa Darksorrow
		timerFracturedCD:Stop()
		timerSpiritBombsCD:Stop()
		timerSigilofChainsCD:Stop()
		self.vb.IlyssaDead = true
	end
end

--Non Mythic Hunt Handling
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetName)
	if msg:find("spell:1227809") then
		if targetName == UnitName("player") then
			specWarnTheHunt:Show()
			specWarnTheHunt:Play("lineyou")
			yellTheHunt:Yell()
			yellTheHuntFades:Countdown(6)
		else
			warnTheHunt:Show(self.vb.huntCount, targetName)
		end
	end
end

--Mythic Hunt Handling
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:1227809") then
		specWarnTheHunt:Show()
		specWarnTheHunt:Play("lineyou")
		yellTheHunt:Yell()
		yellTheHuntFades:Countdown(6)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:1227809") then
		--Incremented here due to likely desync from spell cast event and time it takes to collect syncs
		--But that also means count will be wrong if anyone is not using Bigwigs or DBM in the raid
		self.vb.huntSubCount = self.vb.huntSubCount + 1
		---@diagnostic disable-next-line: param-type-mismatch
		warnTheHunt:Show(self.vb.huntSubCount .."-".. self.vb.huntSubCount, targetName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1241254 then
		self.vb.bladeDanceCount = self.vb.bladeDanceCount + 1
		specWarnBladeDance:Show(self.vb.bladeDanceCount)
		specWarnBladeDance:Play("farfromline")
		timerBladeDanceCD:Start(self:IsMythic() and 34 or self:IsHeroic() and 34.7 or 35.6, self.vb.bladeDanceCount+1)
	end
end
