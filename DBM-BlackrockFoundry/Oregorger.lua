local mod	= DBM:NewMod(1202, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77182)
mod:SetEncounterID(1696)
mod:SetZone()
mod:SetHotfixNoticeRev(12963)
mod.respawnTime = 15

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156240 156179",
	"SPELL_AURA_REMOVED 155819 156834",
	"SPELL_AURA_REMOVED_DOSE 156834",
	"SPELL_CAST_SUCCESS 156390 156834 155898",
	"SPELL_PERIODIC_DAMAGE 156203",
	"SPELL_ABSORBED 156203",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[Berserk?
"<4.4 14:25:47> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#true#true#Oregorger#Creature:0:3314:1205:13906:77182
"<328.2 14:31:10> CHAT_MSG_RAID_BOSS_EMOTE#Oregorger has gone insane from hunger!#Oregorger#####0#0##0#164#0000000000000000#0#false#false", -- [5]--]]
local warnAcidTorrent				= mod:NewCountAnnounce(156240, 3)
local warnRetchedBlackrock			= mod:NewTargetAnnounce("OptionVersion2", 156179, 3, nil, "Ranged")
local warnCollectOre				= mod:NewCountAnnounce(165184, 2)
local warnRollingFury				= mod:NewCountAnnounce(155898, 3, nil, false)

local specWarnBlackrockBarrage		= mod:NewSpecialWarningInterruptCount(156877, false, nil, nil, nil, 3)--Off by default since only interruptors want this on for their duty
local specWarnAcidTorrent			= mod:NewSpecialWarningCount(156240, "Tank", nil, nil, 3)--No voice filter, because voice is for tank swap that comes AFTER breath, this warning is to alert tank they need to move into position to soak breath, NOT taunt
local yellRetchedBlackrock			= mod:NewYell(156179)
local specWarnRetchedBlackrockNear	= mod:NewSpecialWarningClose(156179)
local specWarnRetchedBlackrock		= mod:NewSpecialWarningMove(156203, nil, nil, nil, nil, 2)
local specWarnExplosiveShard		= mod:NewSpecialWarningDodge(156390, "MeleeDps", nil, 3)--No target scanning available. targets ONLY melee (except tanks)
local specWarnHungerDrive			= mod:NewSpecialWarningSpell("ej9964", nil, nil, nil, 2)
local specWarnHungerDriveEnded		= mod:NewSpecialWarningFades("ej9964")

local timerBlackrockSpinesCD		= mod:NewCDTimer(18.5, 156834, nil, nil, nil, 4)--20-23 (cd for barrages themselves too inconsistent and useless. but CD for when he recharges his spines, quite consistent)
local timerAcidTorrentCD			= mod:NewCDCountTimer(13, 156240, nil, "Tank|Healer", 2, 5)
local timerExplosiveShardCD			= mod:NewCDTimer(12, 156390, nil, "MeleeDps", 3)--Every 12-20 seconds
local timerExplosiveShard			= mod:NewCastTimer(3.5, 156390, nil, "MeleeDps")
local timerRetchedBlackrockCD		= mod:NewCDTimer(15.5, 156179, nil, "Ranged", 2)

local countdownAcidTorrent			= mod:NewCountdown(13, 156240, "Tank")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRetchedBlackrock			= mod:NewVoice(156203)  --runaway
local voiceBlackrockBarrage			= mod:NewVoice(156877, false)--kickcast
local voiceAcidTorrent				= mod:NewVoice(156240)--changemt after 3 seconds (after cast finishes)

mod:AddDropdownOption("InterruptBehavior", {"Smart", "Fixed"}, "Smart", "misc")

mod.vb.torrentCount = 0
mod.vb.rollCount = 0
mod.vb.interruptCount = 0

local lastOre = 0 -- not need sync

function mod:RetchedBlackrockTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		if self:AntiSpam(2.5, 2) then
			specWarnRetchedBlackrock:Show()
		end
		yellRetchedBlackrock:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnRetchedBlackrockNear:Show(targetname)
	else
		warnRetchedBlackrock:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.torrentCount = 0
	self.vb.interruptCount = 0
	timerRetchedBlackrockCD:Start(4.5-delay)--5-7
	timerExplosiveShardCD:Start(9.5-delay)
	timerAcidTorrentCD:Start(11-delay, 1)
	countdownAcidTorrent:Start(12-delay)
	timerBlackrockSpinesCD:Start(13-delay)--13-16
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156240 then
		self.vb.torrentCount = self.vb.torrentCount + 1
		if self.Options.SpecWarn156240count then
			specWarnAcidTorrent:Show(self.vb.torrentCount)
		else
			warnAcidTorrent:Show(self.vb.torrentCount)
		end
		timerAcidTorrentCD:Start(nil, self.vb.torrentCount+1)
		countdownAcidTorrent:Start()
		voiceAcidTorrent:Schedule(3, "changemt")
	elseif spellId == 156179 then
		self:ScheduleMethod(0.1, "BossTargetScanner", 77182, "RetchedBlackrockTarget", 0.04, 16)--give 0.1 delay before scan start.
		timerRetchedBlackrockCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155819 then
		self.vb.torrentCount = 0
		self:UnregisterShortTermEvents()
		timerRetchedBlackrockCD:Start(5)
		timerExplosiveShardCD:Start(6)--7-9
		timerAcidTorrentCD:Start(11, 1)--11-12
		countdownAcidTorrent:Start(11)
		timerBlackrockSpinesCD:Start(13)
	elseif spellId == 156834 then
		local bossPower = UnitPower("boss1")
		if bossPower == 0 then return end--Avoid announce bug caused by SPELL_AURA_REMOVED fired at 0 energy, before boss going into frenzy)
		local expectedTotal = self:IsMythic() and 5 or 3
		if self.vb.interruptCount == expectedTotal then self.vb.interruptCount = 0 end--Even if this method is not used, keep info correct for sync
		self.vb.interruptCount = self.vb.interruptCount + 1--Even if this method is not used, keep info correct for sync
		local kickCount
		if self.Options.InterruptBehavior == "Smart" then
			local amount = args.amount or 0--amount reported for all (SPELL_AURA_APPLIED_DOSE) but 0 (SPELL_AURA_REMOVED)
			kickCount = expectedTotal - amount
		else
			kickCount = self.vb.interruptCount
		end
		specWarnBlackrockBarrage:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			voiceBlackrockBarrage:Play("kick1r")
		elseif kickCount == 2 then
			voiceBlackrockBarrage:Play("kick2r")
		elseif kickCount == 3 then
			voiceBlackrockBarrage:Play("kick3r")
		elseif kickCount == 4 then
			voiceBlackrockBarrage:Play("kick4r")
		elseif kickCount == 5 then
			voiceBlackrockBarrage:Play("kick5r")
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156390 then
		specWarnExplosiveShard:Show()
		timerExplosiveShard:Start()
		timerExplosiveShardCD:Start()
	elseif spellId == 156834 then--Boss has gained Barrage casts
		timerBlackrockSpinesCD:Start()
	elseif spellId == 155898 then
		self.vb.rollCount = self.vb.rollCount + 1
		warnRollingFury:Show(self.vb.rollCount)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156203 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 2) then
		specWarnRetchedBlackrock:Show()
		voiceRetchedBlackrock:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 165127 then--Hunger Dive Phase
		self.vb.feedingFrenzy = true
		self.vb.rollCount = 0
		timerBlackrockSpinesCD:Cancel()
		timerRetchedBlackrockCD:Cancel()
		timerAcidTorrentCD:Cancel()
		countdownAcidTorrent:Cancel()
		timerExplosiveShardCD:Cancel()
		specWarnHungerDrive:Show()
		voicePhaseChange:Play("phasechange")
		lastOre = 0
		self:RegisterShortTermEvents(
			"UNIT_POWER_FREQUENT boss1"
		)
	end
end

function mod:UNIT_POWER_FREQUENT()
	local ore = UnitPower("boss1")
	if (self:AntiSpam(10) or ore == 100) and lastOre ~= ore then
		lastOre = ore
		warnCollectOre:Show(ore)
		if ore == 100 then
			self.vb.interruptCount = 0
			specWarnHungerDriveEnded:Show()
			voicePhaseChange:Play("phasechange")
		end
	end
end
