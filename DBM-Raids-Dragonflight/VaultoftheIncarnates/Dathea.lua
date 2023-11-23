local mod	= DBM:NewMod(2502, "DBM-Raids-Dragonflight", 3, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189813)
mod:SetEncounterID(2635)
mod:SetUsedIcons(8, 7, 6, 5, 4)
mod:SetHotfixNoticeRev(20221215000000)
mod:SetMinSyncRevision(20221014000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 387849 388302 376943 388410 375580 387943 385812 384273 387627 391382 395501",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 387857",
	"SPELL_AURA_APPLIED 391686 375580",
	"SPELL_AURA_APPLIED_DOSE 375580",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 387849 or ability.id = 388302 or ability.id = 376943 or ability.id = 388410 or ability.id = 375580) and type = "begincast"
 or ability.id = 391600 and type = "cast" and source.id = 189813
--]]
--Dathea, Ascended
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnMarkCast								= mod:NewCountAnnounce(391686, 3)
local warnRagingBurst							= mod:NewCountAnnounce(388302, 3, nil, nil, 86189)
local warnZephyrSlam							= mod:NewStackAnnounce(375580, 2, nil, "Tank|Healer")

local specWarnCoalescingStorm					= mod:NewSpecialWarningCount(387849, nil, nil, nil, 2, 2)
local specWarnConductiveMark					= mod:NewSpecialWarningMoveAway(391686, nil, nil, nil, 1, 2)
local yellConductiveMark						= mod:NewYell(391686, 28836)--Short text "Mark"
local specWarnCyclone							= mod:NewSpecialWarningCount(376943, nil, nil, nil, 2, 12)
local specWarnCrosswinds						= mod:NewSpecialWarningDodgeCount(388410, nil, nil, nil, 2, 2)--232722 "Slicing Tornado" better?
local specWarnZephyrSlam						= mod:NewSpecialWarningDefensive(375580, nil, nil, nil, 1, 2)
local specWarnZephyrSlamTaunt					= mod:NewSpecialWarningTaunt(375580, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerColaescingStormCD					= mod:NewCDCountTimer(79.1, 387849, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRagingBurstCD						= mod:NewCDCountTimer(79.1, 388302, 86189, nil, nil, 3)--Tornados
local timerConductiveMarkCD						= mod:NewCDCountTimer(25, 391686, nil, nil, nil, 3)
local timerCycloneCD							= mod:NewCDCountTimer(79.1, 376943, nil, nil, nil, 2)
local timerCrosswindsCD							= mod:NewCDCountTimer(33, 388410, nil, nil, nil, 3)--232722 "Slicing Tornado" better?
local timerZephyrSlamCD							= mod:NewCDCountTimer(15.7, 375580, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(391686, true)
--Volatile Infuser
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25903))
local warnBlowback								= mod:NewCastAnnounce(395501, 4)--Fallback warning, should know it's being cast even if not in distance of knockback, so you don't walk into it

local specWarnBlowback							= mod:NewSpecialWarningSpell(395501, nil, nil, nil, 2, 2)--Distance based warning, Ie in range of knockback
local specWarnDivertedEssence					= mod:NewSpecialWarningInterruptCount(387943, "HasInterrupt", nil, nil, 1, 2)
local specWarnAerialSlash						= mod:NewSpecialWarningDefensive(385812, nil, nil, nil, 1, 2)

local timerAerialSlashCD						= mod:NewCDTimer(12, 385812, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnVolatileInfuser", "ej25903", true, 5, {8, 7, 6, 5, 4})
--Thunder Caller
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25958))
local specWarnStormBolt							= mod:NewSpecialWarningInterruptCount(384273, false, nil, nil, 1, 2)

local castsPerGUID = {}
mod.vb.addIcon = 8
mod.vb.stormCount = 0
mod.vb.burstCount = 0
mod.vb.markCount = 0
mod.vb.cycloneCount = 0
mod.vb.crosswindCount = 0
mod.vb.slamCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.addIcon = 8
	self.vb.stormCount = 0
	self.vb.burstCount = 0
	self.vb.markCount = 0
	self.vb.cycloneCount = 0
	self.vb.crosswindCount = 0
	self.vb.slamCount = 0
	timerConductiveMarkCD:Start(4.6-delay, 1)
	timerRagingBurstCD:Start(7-delay, 1)
	if self:IsHard() then
		timerZephyrSlamCD:Start(15.7-delay, 1)
		timerCrosswindsCD:Start(25.5-delay, 1)
		timerCycloneCD:Start(35.2-delay, 1)
		timerColaescingStormCD:Start(70-delay, 1)--70-73 (check ito it being 73 consistently on mythic)
	else
		timerZephyrSlamCD:Start(9.4-delay, 1)
		timerCrosswindsCD:Start(28.9-delay, 1)
		timerCycloneCD:Start(45.2-delay, 1)
		timerColaescingStormCD:Start(80-delay, 1)
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(391686))
--		DBM.InfoFrame:Show(self:IsMythic() and 20 or 10, "playerdebuffstacks", 391686)
--	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 387849 then
		self.vb.addIcon = 8
		self.vb.stormCount = self.vb.stormCount + 1
		specWarnCoalescingStorm:Show(self.vb.stormCount)
		specWarnCoalescingStorm:Play("mobsoon")
		--Timers reset by storm
		if self:IsMythic() then
			timerConductiveMarkCD:Restart(19.5, self.vb.markCount+1)
			timerZephyrSlamCD:Restart(30, self.vb.slamCount+1)--30-33
			timerCrosswindsCD:Restart(40, self.vb.crosswindCount+1)--40-45, but always a minimum of 40 from heer
			timerColaescingStormCD:Start(86.2, self.vb.stormCount+1)
		elseif self:IsHeroic() then
			timerZephyrSlamCD:Restart(20.7, self.vb.slamCount+1)
			timerCrosswindsCD:Restart(30.4, self.vb.crosswindCount+1)--40-45, but always a minimum of 40 from heer
			timerConductiveMarkCD:Restart(35, self.vb.markCount+1)
			timerColaescingStormCD:Start(75.5, self.vb.stormCount+1)
		else
			timerConductiveMarkCD:Restart(9.7, self.vb.markCount+1)
			timerZephyrSlamCD:Restart(15.7, self.vb.slamCount+1)
			timerCrosswindsCD:Restart(34, self.vb.crosswindCount+1)
			timerColaescingStormCD:Start(86.2, self.vb.stormCount+1)
		end
	elseif spellId == 388302 then
		self.vb.burstCount = self.vb.burstCount + 1
		warnRagingBurst:Show(self.vb.burstCount)
		timerRagingBurstCD:Start(self:IsHeroic() and 75 or 86.2, self.vb.burstCount+1)
	elseif spellId == 376943 then
		self.vb.cycloneCount = self.vb.cycloneCount + 1
		specWarnCyclone:Show(self.vb.cycloneCount)
		specWarnCyclone:Play("pullin")
		timerCycloneCD:Start(self:IsHeroic() and 75 or 86.2, self.vb.cycloneCount+1)
		if timerZephyrSlamCD:GetRemaining(self.vb.slamCount+1) < 13.2 then
			timerZephyrSlamCD:Restart(13.2, self.vb.slamCount+1)--13.2-15
		end
	elseif spellId == 388410 then
		self.vb.crosswindCount = self.vb.crosswindCount + 1
		specWarnCrosswinds:Show(self.vb.crosswindCount)
		specWarnCrosswinds:Play("farfromline")
		--If storm comes before cross winds would come off CD, storm will reset the CD anyways so don't start here
		if timerColaescingStormCD:GetRemaining(self.vb.stormCount+1) > 35 then
			timerCrosswindsCD:Start(nil, self.vb.crosswindCount+1)
		end
		if timerZephyrSlamCD:GetRemaining(self.vb.slamCount+1) < 6 then
			timerZephyrSlamCD:Restart(6, self.vb.slamCount+1)--6-8
		end
	elseif spellId == 375580 then
		self.vb.slamCount = self.vb.slamCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnZephyrSlam:Show()
			specWarnZephyrSlam:Play("carefly")
		end
		timerZephyrSlamCD:Start(nil, self.vb.slamCount+1)
	elseif spellId == 387943 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnVolatileInfuser and self.vb.addIcon > 3 then--Only use up to 5 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnVolatileInfuser")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnDivertedEssence:Show(args.sourceName, count)
			if count < 6 then
				specWarnDivertedEssence:Play("kick"..count.."r")
			else
				specWarnDivertedEssence:Play("kickcast")
			end
		end
	elseif spellId == 385812 then
		timerAerialSlashCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) and self:AntiSpam(3, 1) then
			specWarnAerialSlash:Show()
			specWarnAerialSlash:Play("defensive")
		end
	elseif spellId == 384273 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnStormBolt:Show(args.sourceName, count)
			if count < 6 then
				specWarnStormBolt:Play("kick"..count.."r")
			else
				specWarnStormBolt:Play("kickcast")
			end
		end
	elseif spellId == 387627 or spellId == 391382 or spellId == 395501 then
		if self:CheckBossDistance(args.sourceGUID, true, 13289, 28) then
			specWarnBlowback:Show()
			specWarnBlowback:Play("carefly")
		else
			warnBlowback:Show()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 387857 then--Zephyr Guardian
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnVolatileInfuser and self.vb.addIcon > 3 then--Only use up to 5 icons
				self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnVolatileInfuser")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		timerAerialSlashCD:Start(6, args.destGUID)
--	elseif spellId == 384757 then--Thunder Caller

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 391686 then
		if args:IsPlayer() then
			specWarnConductiveMark:Show()
			specWarnConductiveMark:Play("range5")
			yellConductiveMark:Yell()
		end
	elseif spellId == 375580 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if amount >= 2 and (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnZephyrSlamTaunt:Show(args.destName)
			specWarnZephyrSlamTaunt:Play("tauntboss")
		else
			warnZephyrSlam:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 192934 then--Volatile Infuser
		timerAerialSlashCD:Stop(args.destGUID)
--	elseif cid == 194647 then--Thunder Caller

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 391600 or spellId == 391595) and self:AntiSpam(3, 2) then--391595 confirmed, 391600 i'm keeping for now in case it's used on mythics
		self.vb.markCount = self.vb.markCount + 1
		warnMarkCast:Show(self.vb.markCount)
		timerConductiveMarkCD:Start(self:IsHard() and 25 or 31.5, self.vb.markCount+1)
	end
end
