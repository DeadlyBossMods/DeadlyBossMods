local mod	= DBM:NewMod(1202, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77182)
mod:SetEncounterID(1696)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156877 156240 156179",
	"SPELL_AURA_APPLIED 156370 155898 155819",
	"SPELL_AURA_APPLIED_DOSE 155819",
	"SPELL_AURA_REMOVED 156370 155898"
)

local warnBlackrockBarrage			= mod:NewSpellAnnounce(156877, 2)
local warnAcidTorrent				= mod:NewSpellAnnounce(156240, 3)
local warnRetchedBlackrock			= mod:NewTargetAnnounce(156179, 3)--Target scanning assumed. (can it be avoided? if so add special warning to move)
local warnExplosiveShard			= mod:NewTargetAnnounce(156370, 4)
local warnRollingFury				= mod:NewTargetAnnounce(155898, 4)
local warnHungerDrive				= mod:NewStackAnnounce(155819, 3, nil, false)--Similar to thok, count may be useful. We'll see

local specWarnBlackrockBarrage		= mod:NewSpecialWarningInterrupt(156877, false)--How much is it spammed? should this be on by default?
local specWarnAcidTorrent			= mod:NewSpecialWarningSpell(156240, mod:IsTank(), nil, nil, 3)
local specWarnExplosiveShard		= mod:NewSpecialWarningYou(156370)
local yellExplosiveShard			= mod:NewYell(156370)
local specWarnRollingFury			= mod:NewSpecialWarningSpell(155898, nil, nil, nil, 2)
local specWarnRollingFuryEnded		= mod:NewSpecialWarningFades(155898)

--local timerBlackrockBarrageCD		= mod:NewNextTimer(30, 156879)
--local timerAcidTorrentCD			= mod:NewNextTimer(30, 156240)

mod:AddRangeFrameOption(7, 156370)--Tooltip of 156388 (explosion spellid that goes off at end of debuff) says 7, Unverified

function mod:RetchedBlackrockTarget(targetname, uId)
	if not targetname then return end
	warnRetchedBlackrock:Show(targetname)
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156877 then
		warnBlackrockBarrage:Show()
		specWarnBlackrockBarrage:Show(args.sourceName)
--		timerBlackrockBarrageCD:Start()
	elseif spellId == 156240 then
		warnAcidTorrent:Show()
		specWarnAcidTorrent:Show()
--		timerAcidTorrentCD:Start()
	elseif spellId == 156179 then
		self:BossTargetScanner(77182, "RetchedBlackrockTarget", 0.02, 16)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156370 then
		warnExplosiveShard:Show(args.destName)
		if args:IsPlayer() then
			specWarnExplosiveShard:Show()
			yellExplosiveShard:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(7)
			end
		end
	elseif spellId == 155898 then
		warnRollingFury:Show(args.destName)
	elseif spellId == 155819 then
		local amount = args.amount or 1
		warnHungerDrive:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156370 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 155898 then
		specWarnRollingFuryEnded:Show()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
