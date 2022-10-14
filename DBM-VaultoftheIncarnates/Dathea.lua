local mod	= DBM:NewMod(2502, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189813)
mod:SetEncounterID(2635)
mod:SetUsedIcons(8, 7, 6, 5, 4)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 387849 388302 376943 388410 375580 387943 385812 384273 387627 391382",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 384757 384757",
	"SPELL_AURA_APPLIED 391686 375580",
	"SPELL_AURA_APPLIED_DOSE 375580",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, refine range checker to not be needed at all times if a determinate pre warning can be detected or scheduled for new conductive marks going out, and all being gone
--TODO, add unstable gusts?
--TODO, how to handle Incubating Seeds, 50 yards is a big radius. can players avoid it by moving away or is it a "kill it very hard and very fast" thing https://www.wowhead.com/beta/spell=389049/incubating-seed
--[[
(ability.id = 387849 or ability.id = 388302 or ability.id = 376943 or ability.id = 388410 or ability.id = 375580) and type = "begincast"
 or ability.id = 391686 and type = "applydebuff" and source.id = 189813
--]]
--Dathea, Ascended
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25340))
local warnRagingBurst							= mod:NewCountAnnounce(388302, 3)
local warnZephyrSlam							= mod:NewStackAnnounce(375580, 2, nil, "Tank|Healer")

local specWarnCoalescingStorm					= mod:NewSpecialWarningCount(387849, nil, nil, nil, 2, 2)
local specWarnConductiveMark					= mod:NewSpecialWarningMoveAway(391686, nil, nil, nil, 1, 2)
local yellConductiveMark						= mod:NewYell(391686, 28836)--Short text "Mark"
local specWarnCyclone							= mod:NewSpecialWarningCount(376943, nil, nil, nil, 2, 12)
local specWarnCrosswinds						= mod:NewSpecialWarningDodgeCount(388410, nil, nil, nil, 2, 2)
local specWarnZephyrSlam						= mod:NewSpecialWarningDefensive(375580, nil, nil, nil, 1, 2)
local specWarnZephyrSlamTaunt					= mod:NewSpecialWarningTaunt(375580, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerColaescingStormCD					= mod:NewCDCountTimer(80, 387849, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRagingBurstCD						= mod:NewCDCountTimer(79.1, 388302, nil, nil, nil, 3)
local timerConductiveMarkCD						= mod:NewCDCountTimer(28.2, 391686, nil, nil, nil, 3)--28-30
local timerCycloneCD							= mod:NewCDCountTimer(79.1, 376943, nil, nil, nil, 2)
local timerCrosswindsCD							= mod:NewCDCountTimer(35.2, 388410, nil, nil, nil, 3)
local timerZephyrSlamCD							= mod:NewCDCountTimer(16.9, 375580, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(5, 391686)
--mod:AddInfoFrameOption(391686, true)
--Volatile Infuser
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25903))
local warnBlowback								= mod:NewCastAnnounce(387627, 4)--Fallback warning, should know it's being cast even if not in distance of knockback, so you don't walk into it

local specWarnBlowback							= mod:NewSpecialWarningSpell(387627, nil, nil, nil, 2, 2)--Distance based warning, Ie in range of knockback
local specWarnDivertedEssence					= mod:NewSpecialWarningInterruptCount(387943, "HasInterrupt", nil, nil, 1, 2)
local specWarnAerialSlash						= mod:NewSpecialWarningDefensive(385812, nil, nil, nil, 1, 2)

local timerAerialSlashCD						= mod:NewCDTimer(12, 385812, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnVolatileInfuser", "ej25903", true, true, {8, 7, 6, 5, 4})
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
	timerZephyrSlamCD:Start(15.8-delay, 1)
	timerCrosswindsCD:Start(25.6-delay, 1)
	timerCycloneCD:Start(36.6-delay, 1)
	timerColaescingStormCD:Start(76-delay, 1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(391686))
--		DBM.InfoFrame:Show(self:IsMythic() and 20 or 10, "playerdebuffstacks", 391686)
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
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
		timerColaescingStormCD:Start(nil, self.vb.stormCount+1)
		--Timers reset by storm
		timerConductiveMarkCD:Restart(9.5, self.vb.markCount+1)
		timerZephyrSlamCD:Restart(20, self.vb.slamCount+1)
		timerCrosswindsCD:Restart(31.2, self.vb.crosswindCount+1)
	elseif spellId == 388302 then
		self.vb.burstCount = self.vb.burstCount + 1
		warnRagingBurst:Show(self.vb.burstCount)
		timerRagingBurstCD:Start(nil, self.vb.burstCount+1)
	elseif spellId == 376943 then
		self.vb.cycloneCount = self.vb.cycloneCount + 1
		specWarnCyclone:Show(self.vb.cycloneCount)
		specWarnCyclone:Play("pullin")
		timerCycloneCD:Start(nil, self.vb.cycloneCount+1)
		timerZephyrSlamCD:Restart(15.7, self.vb.slamCount+1)
	elseif spellId == 388410 then
		self.vb.crosswindCount = self.vb.crosswindCount + 1
		specWarnCrosswinds:Show(self.vb.crosswindCount)
		specWarnCrosswinds:Play("farfromline")
		--If storm comes before cross winds would come off CD, storm will reset the CD anyways so don't start here
		if timerColaescingStormCD:GetRemaining(self.vb.stormCount+1) > 35 then
			timerCrosswindsCD:Start(nil, self.vb.crosswindCount+1)
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
			if count == 1 then
				specWarnDivertedEssence:Play("kick1r")
			elseif count == 2 then
				specWarnDivertedEssence:Play("kick2r")
			elseif count == 3 then
				specWarnDivertedEssence:Play("kick3r")
			elseif count == 4 then
				specWarnDivertedEssence:Play("kick4r")
			elseif count == 5 then
				specWarnDivertedEssence:Play("kick5r")
			else
				specWarnDivertedEssence:Play("kickcast")
			end
		end
	elseif spellId == 385812 then
		timerAerialSlashCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
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
			if count == 1 then
				specWarnStormBolt:Play("kick1r")
			elseif count == 2 then
				specWarnStormBolt:Play("kick2r")
			elseif count == 3 then
				specWarnStormBolt:Play("kick3r")
			elseif count == 4 then
				specWarnStormBolt:Play("kick4r")
			elseif count == 5 then
				specWarnStormBolt:Play("kick5r")
			else
				specWarnStormBolt:Play("kickcast")
			end
		end
	elseif spellId == 387627 or spellId == 391382 then
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
		if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
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
	if (spellId == 391600 or spellId == 391595) and self:AntiSpam(3, 1) then--391595 confirmed, 391600 i'm keeping for now in case it's used on mythics
		self.vb.markCount = self.vb.markCount + 1
		--If storm comes before mark would come off CD, storm will reset the CD anyways so don't start here
		if timerColaescingStormCD:GetRemaining(self.vb.stormCount+1) > 28 then
			timerConductiveMarkCD:Start(nil, self.vb.markCount+1)
		end
	end
end
