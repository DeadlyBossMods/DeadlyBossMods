local mod	= DBM:NewMod(1202, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77182)
mod:SetEncounterID(1696)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156877 156240 156179",
	"SPELL_AURA_APPLIED 155819",
	"SPELL_AURA_APPLIED_DOSE 155819",
	"SPELL_AURA_REMOVED 155819",
	"SPELL_CAST_SUCCESS 156390",
	"SPELL_PERIODIC_DAMAGE 156203",
	"SPELL_PERIODIC_MISSED 156203",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[Berserk?
"<4.4 14:25:47> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#true#true#Oregorger#Creature:0:3314:1205:13906:77182
"<328.2 14:31:10> CHAT_MSG_RAID_BOSS_EMOTE#Oregorger has gone insane from hunger!#Oregorger#####0#0##0#164#0000000000000000#0#false#false", -- [5]--]]
--TODO, check into http://beta.wowhead.com/spell=155923 on mythic
local warnBlackrockBarrage			= mod:NewSpellAnnounce(156877, 2, nil, false)
local warnAcidTorrent				= mod:NewSpellAnnounce(156240, 3)
local warnRetchedBlackrock			= mod:NewTargetAnnounce(156179, 3)
local warnHungerDrive				= mod:NewSpellAnnounce(165127, 4)
local warnHungerDriveStack			= mod:NewStackAnnounce(155819, 3, nil, false)--Similar to thok, count may be useful measure of how long to drag phase out for.

local specWarnBlackrockBarrage		= mod:NewSpecialWarningInterrupt(156877, false)--Strategy dependant
local specWarnAcidTorrent			= mod:NewSpecialWarningSpell(156240, "Tank", nil, nil, 3)
local yellRetchedBlackrock			= mod:NewYell(156179)
local specWarnRetchedBlackrock		= mod:NewSpecialWarningMove(156203, nil, nil, nil, nil, nil, true)
local specWarnExplosiveShard		= mod:NewSpecialWarningDodge(156390, "Melee")--No target scanning available. prefers melee if I remember correctly. Double check this!
local specWarnHungerDrive			= mod:NewSpecialWarningSpell(165127, nil, nil, nil, 2)
local specWarnHungerDriveEnded		= mod:NewSpecialWarningFades(165127)

--local timerBlackrockBarrageCD		= mod:NewCDTimer(30, 156879)--Far to variable. probably based on energy as well as if previous ones interrupted or not.
local timerAcidTorrentCD			= mod:NewCDTimer(12, 156240)--Every 12-15 seconds
local timerExplosiveShardCD			= mod:NewCDTimer(12, 156390)--Every 12-20 seconds
local timerRetchedBlackrockCD		= mod:NewCDTimer(17, 156179)--Every 17-18 seconds

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRetchedBlackrock			= mod:NewVoice(156203)  --runaway
local voiceBlackrockBarrage			= mod:NewVoice(156877, false)

--local berserkTimer					= mod:NewBerserkTimer(324)--May not be exact science. may be phase based instead, like tsulong. Needs more than one log to verify. Only saw one berserk.

--mod.vb.barrageCount = 0

function mod:RetchedBlackrockTarget(targetname, uId)
	if not targetname then return end
	warnRetchedBlackrock:Show(targetname)
	if targetname == UnitName("player") then
		yellRetchedBlackrock:Yell()
	end
end

function mod:OnCombatStart(delay)
--	self.vb.barrageCount = 0
	timerAcidTorrentCD:Start(11.5-delay)
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156877 then
--		self.vb.barrageCount = self.vb.barrageCount + 1
		warnBlackrockBarrage:Show()
		specWarnBlackrockBarrage:Show(args.sourceName)
		voiceBlackrockBarrage:Play("kickcast")
--		timerBlackrockBarrageCD:Start()
--		if (self:IsMythic() and self.vb.barrageCount == 5) or (not self:IsMythic() and self.vb.barrageCount == 3) then--Always in sets of 3/5
--			self.vb.barrageCount = 0
--		end
	elseif spellId == 156240 then
		if self.Options.SpecWarn156240spell then
			specWarnAcidTorrent:Show()
		else
			warnAcidTorrent:Show()
		end
		timerAcidTorrentCD:Start()
	elseif spellId == 156179 then
		self:BossTargetScanner(77182, "RetchedBlackrockTarget", 0.02, 16)
		timerRetchedBlackrockCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155819 then
		local amount = args.amount or 1
		warnHungerDriveStack:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155819 then
		specWarnHungerDriveEnded:Show()
		voicePhaseChange:Play("phasechange")
--		self.vb.barrageCount = 0
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156390 then
		specWarnExplosiveShard:Show()
		timerExplosiveShardCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156203 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnRetchedBlackrock:Show()
		voiceRetchedBlackrock:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 165127 then--Hunger Dive Phase
		timerRetchedBlackrockCD:Cancel()
		timerAcidTorrentCD:Cancel()
		timerExplosiveShardCD:Cancel()
		specWarnHungerDrive:Show()
		voicePhaseChange:Play("phasechange")
	end
end
