local mod	= DBM:NewMod(2688, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237660, 237661, 237662)
mod:SetEncounterID(3122)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20250727000000)
mod:SetMinSyncRevision(20250727000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1227355 1227809 1218103 1241833 1222337 1242259 1231501 1232568 1232569 1227117 1240891",
	"SPELL_CAST_SUCCESS 1233672",--1227058
	"SPELL_AURA_APPLIED 1226493 1233093 1233863",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1233093 1233863",
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
(ability.id = 1231501 or ability.id = 1232568 or ability.id = 1232569) and type = "begincast" or ability.id = 1242133 or ability.id = 1245978
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
local warnTheHunt									= mod:NewTargetCountAnnounce(1227809, 2, nil, nil, nil, nil, nil, nil, true)

local specWarnBladeDance							= mod:NewSpecialWarningDodgeCount(1241306, nil, nil, nil, 2, 2)
local specWarnEyebeam								= mod:NewSpecialWarningDefensive(1218103, nil, nil, nil, 1, 13)

local specWarnTheHunt								= mod:NewSpecialWarningYou(1227809, nil, nil, nil, 1, 17)
local yellTheHunt									= mod:NewShortYell(1227809, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellTheHuntFades								= mod:NewShortFadesYell(1227809, nil, nil, nil, "YELL")

local timerTheHuntCD								= mod:NewNextCountTimer(31.9, 1227809, nil, nil, nil, 3)
local timerBladeDanceCD								= mod:NewNextCountTimer(31.9, 1241306, nil, nil, nil, 3)
local timerEyeBeamCD								= mod:NewNextCountTimer(31.9, 1218103, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFelRushCD								= mod:NewNextTimer(97.3, 1233863, nil, nil, nil, 6)
--Ilyssa Darksorrow
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31791))
local specWarnFractured								= mod:NewSpecialWarningDefensive(1241833, nil, nil, nil, 1, 2)
local specWarnShatteredSoul							= mod:NewSpecialWarningTaunt(1226493, false, nil, nil, 1, 2)
local specWarnSpiritBombs							= mod:NewSpecialWarningCount(1242259, nil, nil, nil, 2, 2)
local specWarnSigilofChains							= mod:NewSpecialWarningCount(1240891, nil, nil, nil, 2, 12)

local timerFracturedCD								= mod:NewNextCountTimer(31.9, 1241833, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSpiritBombsCD							= mod:NewNextCountTimer(31.9, 1242259, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerSigilofChainsCD							= mod:NewNextCountTimer(31.9, 1240891, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic only
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
mod.vb.huntSubCount = 0
mod.vb.bladeDanceCount = 0
mod.vb.eyeBeamCount = 0
mod.vb.fracturedCount = 0
mod.vb.spiritBombsCount = 0
mod.vb.sigilsCount = 0
mod.vb.VelarnDead = false
mod.vb.IlyssaDead = false
mod.vb.AdarusDead = false

function mod:OnCombatStart(delay)
	self.vb.intermissionCount = 0
	self.vb.consumeCount = 0
	self.vb.voidstepCount = 0
	self.vb.huntCount = 0
	self.vb.bladeDanceCount = 0
	self.vb.eyeBeamCount = 0
	self.vb.fracturedCount = 0
	self.vb.spiritBombsCount = 0
	self.vb.sigilsCount = 0
	self.vb.VelarnDead = false
	self.vb.IlyssaDead = false
	self.vb.AdarusDead = false
	timerVoidstepCD:Start(self:IsMythic() and 25.8 or 31.4-delay, 1)--The only timer different on mythic
	timerTheHuntCD:Start(40.3-delay, 1)
	timerBladeDanceCD:Start(30-delay, 1)
	timerEyeBeamCD:Start(19.3-delay, 1)
	timerFracturedCD:Start(15-delay, 1)
	timerSpiritBombsCD:Start(31.1-delay, 1)
	timerCollapsingStarCD:Start(102-delay)--First special
	if self:IsMythic() then
		timerSigilofChainsCD:Start(37.9-delay, 1)
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
				timerVoidstepCD:Start(31.6, self.vb.voidstepCount+1)
			end
		else
			if self.vb.voidstepCount == 1 then
				timerVoidstepCD:Start(self:IsHeroic() and 29 or 30.3, self.vb.voidstepCount+1)
			elseif self.vb.voidstepCount == 2 then
				timerVoidstepCD:Start(self:IsHeroic() and 26.2 or 27.4, self.vb.voidstepCount+1)
			end
		end
	elseif spellId == 1227809 and args:GetSrcCreatureID() == 237660 then--Only show casts by Velaryn Bloodwrath
		self.vb.huntCount = self.vb.huntCount + 1
		self.vb.huntSubCount = 0
		if self.vb.huntCount == 1 then
			timerTheHuntCD:Start(self:IsMythic() and 31.9 or self:IsHeroic() and 32.6 or 34, self.vb.huntCount+1)
		end
	elseif spellId == 1218103 then
		self.vb.eyeBeamCount = self.vb.eyeBeamCount + 1
		timerEyeBeamCD:Start(self:IsMythic() and 31.9 or self:IsHeroic() and 32.6 or 34, self.vb.eyeBeamCount+1)
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
		timerFracturedCD:Start(self:IsMythic() and 31.9 or self:IsHeroic() and 32.6 or 34, self.vb.fracturedCount)
	elseif spellId == 1242259 then
		self.vb.spiritBombsCount = self.vb.spiritBombsCount + 1
		specWarnSpiritBombs:Show(self.vb.spiritBombsCount)
		specWarnSpiritBombs:Play("aesoon")
		timerSpiritBombsCD:Start(self:IsMythic() and 31.9 or self:IsHeroic() and 32.6 or 34, self.vb.spiritBombsCount+1)
	elseif spellId == 1227117 then
		warnFelDevastation:Show()
	elseif spellId == 1240891 then
		self.vb.sigilsCount = self.vb.sigilsCount + 1
		specWarnSigilofChains:Show(self.vb.sigilsCount)
		specWarnSigilofChains:Play("pullin")
		if self.vb.sigilsCount == 1 then
			timerSigilofChainsCD:Start(31.9, self.vb.sigilsCount+1)
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
		if self.vb.intermissionCount == 1 then
			--if not self.vb.AdarusDead then
				--timerVoidstepCD:Start(31.9, 1)--Not cast this time?
			--end
			if not self.vb.VelarnDead then
				timerEyeBeamCD:Start(39.7, 1)
				timerBladeDanceCD:Start(50.4, 1)
				timerTheHuntCD:Start(60.7, 1)
			end
			if not self.vb.IlyssaDead then
				timerFracturedCD:Start(35.5, 1)
				timerSpiritBombsCD:Start(51.4, 1)
				if self:IsMythic() then
					timerSigilofChainsCD:Start(58.4, 1)
				end
			end
			timerFelRushCD:Start(121)--Second Special (but what happens if Ilyssa dead?)
		elseif self.vb.intermissionCount == 2 then
			if not self.vb.AdarusDead then
				timerVoidstepCD:Start(46.2, 1)
			end
			if not self.vb.VelarnDead then
				timerEyeBeamCD:Start(39.7, 1)
				timerBladeDanceCD:Start(50.4, 1)
				timerTheHuntCD:Start(60.7, 1)
			end
			if not self.vb.IlyssaDead then
				timerFracturedCD:Start(35.5, 1)
				timerSpiritBombsCD:Start(51.4, 1)
				if self:IsMythic() then
					timerSigilofChainsCD:Start(58.4, 1)
				end
			end
			timerFelDevastationCD:Start(121)--Third Special
		elseif self.vb.intermissionCount == 3 then
			if not self.vb.AdarusDead then
				timerVoidstepCD:Start(40.8, 1)
			end
			if not self.vb.VelarnDead then
				timerTheHuntCD:Start(39.4, 1)
			end
			if not self.vb.IlyssaDead then
				timerFracturedCD:Start(36.5, 1)
				timerSpiritBombsCD:Start(46.1, 1)
			end
			timerBerserkCD:Start(52.5)
		--4th one is berserk, all 3 special at once
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
		specWarnBladeDance:Play("whirlwind")
		timerBladeDanceCD:Start(self:IsMythic() and 31.9 or self:IsHeroic() and 32.6 or 34, self.vb.bladeDanceCount+1)
	--Below code avoids needlessly starting timers during the intermission chaos and causing screen to be covered in timers
	--This will not start timers for abilities that occur during 3rd "endless" intermission so those will be started at meta start
	--elseif spellId == 1233388 then--Meta Land (Velaryn Bloodwrath)
	--	timerEyeBeamCD:Start(8.9, 1)
	--	timerBladeDanceCD:Start(17.5, 1)
	--	timerTheHuntCD:Start(30.3, 1)
	--elseif spellId == 1234694 then--Meta Land (Ilyssa Darksorrow)
	--	timerFracturedCD:Start(4.5, 1)
	--	timerSpiritBombsCD:Start(20.8, 1)
	--	if self:IsMythic() then
	--		timerSigilofChainsCD:Start(26.4, 1)
	--	end
	--elseif spellId == 1234724 then--Meta Land (Adarus Duskblaze)
	--	timerVoidstepCD:Start(21, 1)
	end
end
