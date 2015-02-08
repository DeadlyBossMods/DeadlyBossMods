local mod	= DBM:NewMod(1202, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77182)
mod:SetEncounterID(1696)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156240 156179",
	"SPELL_AURA_REMOVED 155819 156834",
	"SPELL_AURA_REMOVED_DOSE 156834",
	"SPELL_CAST_SUCCESS 156390 156834",
	"SPELL_PERIODIC_DAMAGE 156203",
	"SPELL_PERIODIC_MISSED 156203",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[Berserk?
"<4.4 14:25:47> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#true#true#Oregorger#Creature:0:3314:1205:13906:77182
"<328.2 14:31:10> CHAT_MSG_RAID_BOSS_EMOTE#Oregorger has gone insane from hunger!#Oregorger#####0#0##0#164#0000000000000000#0#false#false", -- [5]--]]
local warnAcidTorrent				= mod:NewSpellAnnounce(156240, 3)
local warnRetchedBlackrock			= mod:NewTargetAnnounce("OptionVersion2", 156179, 3, nil, "Ranged")

local specWarnBlackrockBarrage		= mod:NewSpecialWarningInterruptCount(156877, false, nil, nil, nil, nil, 3)--Off by default since only interruptors want this on for their duty
local specWarnAcidTorrent			= mod:NewSpecialWarningSpell(156240, "Tank", nil, nil, 3)--No voice filter, because voice is for tank swap that comes AFTER breath, this warning is to alert tank they need to move into position to soak breath, NOT taunt
local yellRetchedBlackrock			= mod:NewYell(156179)
local specWarnRetchedBlackrockNear	= mod:NewSpecialWarningClose(156179)
local specWarnRetchedBlackrock		= mod:NewSpecialWarningMove(156203, nil, nil, nil, nil, nil, 2)
local specWarnExplosiveShard		= mod:NewSpecialWarningDodge("OptionVersion3", 156390, "MeleeDps")--No target scanning available. targets ONLY melee (except tanks)
local specWarnHungerDrive			= mod:NewSpecialWarningSpell(165127, nil, nil, nil, 2)
local specWarnHungerDriveEnded		= mod:NewSpecialWarningFades(165127)

local timerBlackrockSpinesCD		= mod:NewCDTimer(20, 156834)--20-23 (cd for barrages themselves too inconsistent and useless. but CD for when he recharges his spines, quite consistent)
local timerAcidTorrentCD			= mod:NewCDTimer("OptionVersion2", 13, 156240, nil, "Tank|Healer")
local timerExplosiveShardCD			= mod:NewCDTimer("OptionVersion3", 12, 156390, nil, "MeleeDps")--Every 12-20 seconds
local timerExplosiveShard			= mod:NewCastTimer(3.5, 156390, nil, "MeleeDps")
local timerRetchedBlackrockCD		= mod:NewCDTimer("OptionVersion2", 17, 156179, nil, "Ranged")--Every 17-23 seconds

local countdownAcidTorrent			= mod:NewCountdown(23, 156240, "Tank")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRetchedBlackrock			= mod:NewVoice(156203)  --runaway
local voiceBlackrockBarrage			= mod:NewVoice(156877, false)--kickcast
local voiceAcidTorrent				= mod:NewVoice(156240)--changemt after 3 seconds (after cast finishes)

--local berserkTimer				= mod:NewBerserkTimer(324)--Auto berserk when reaching 3rd hunger drive phase. Time bariable because phase slightly variable.

function mod:RetchedBlackrockTarget(targetname, uId)
	if not targetname then return end
	warnRetchedBlackrock:Show(targetname)
	if targetname == UnitName("player") then
		if self:AntiSpam(2.5, 2) then
			specWarnRetchedBlackrock:Show()
		end
		yellRetchedBlackrock:Yell()
	elseif self:CheckNearby(6, targetname) then
		specWarnRetchedBlackrockNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerRetchedBlackrockCD:Start(5-delay)--5-7
	timerExplosiveShardCD:Start(9.5-delay)
	timerAcidTorrentCD:Start(12-delay)--12-13
	countdownAcidTorrent:Start(12-delay)
	timerBlackrockSpinesCD:Start(13-delay)--13-16
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156240 then
		if self.Options.SpecWarn156240spell then
			specWarnAcidTorrent:Show()
		else
			warnAcidTorrent:Show()
		end
		timerAcidTorrentCD:Start()
		countdownAcidTorrent:Start()
		voiceAcidTorrent:Schedule(3, "changemt")
	elseif spellId == 156179 then
		self:BossTargetScanner(77182, "RetchedBlackrockTarget", 0.02, 16)
		timerRetchedBlackrockCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155819 then
		specWarnHungerDriveEnded:Show()
		voicePhaseChange:Play("phasechange")
		timerRetchedBlackrockCD:Start(5)
		timerExplosiveShardCD:Start(7)--7-9
		timerAcidTorrentCD:Start(11)--11-12
		countdownAcidTorrent:Start(11)
		timerBlackrockSpinesCD:Start(15)
	elseif spellId == 156834 then
		local amount = args.amount or 0--amount reported for all (SPELL_AURA_APPLIED_DOSE) but 0 (SPELL_AURA_REMOVED)
		local kickCount = self:IsMythic() and (5 - amount) or (3 - amount)
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
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156203 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 2) then
		specWarnRetchedBlackrock:Show()
		voiceRetchedBlackrock:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 165127 then--Hunger Dive Phase
		timerBlackrockSpinesCD:Cancel()
		timerRetchedBlackrockCD:Cancel()
		timerAcidTorrentCD:Cancel()
		countdownAcidTorrent:Cancel()
		timerExplosiveShardCD:Cancel()
		specWarnHungerDrive:Show()
		voicePhaseChange:Play("phasechange")
	end
end
