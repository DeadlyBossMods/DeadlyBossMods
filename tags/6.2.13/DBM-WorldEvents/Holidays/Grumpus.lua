local mod	= DBM:NewMod("Grumpus", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96448)
mod:SetModelID(64907)
mod:SetReCombatTime(10)
mod:SetZone(1116, 1159, 1331, 1158, 1153, 1152, 1330, 1160, 1154, 1464)--Draenor
mod:DisableWBEngageSync()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 101907",
	"SPELL_CAST_SUCCESS 101873",
	"SPELL_AURA_APPLIED 101860",
	"SPELL_AURA_APPLIED_DOSE 101860",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)


local warnShrinkHeart			= mod:NewSpellAnnounce(101873, 2)

local specWarnShrinkHeart		= mod:NewSpecialWarningMove(101860)

local timerShrinkHeartCD		= mod:NewCDTimer(32.5, 101873)

function mod:OnCombatStart(delay)
--	timerSnowmanCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 101907 then
		warnSnowCrash:Show()
		timerSnowCrash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 101873 then
		warnShrinkHeart:Show()
		timerShrinkHeartCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 101860 and args:IsPlayer() and self:AntiSpam(2) then
		specWarnShrinkHeart:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
--	The Abominable Greench:Possible Target<Omegathree>:target:Throw Strange Snowman Trigger::0:101942", -- [230]
	if spellId == 101942 then
		self:SendSync("SnowMan")
--	The Abominable Greench:Possible Target<Omegathree>:target:Throw Winter Veil Tree Trigger::0:101945", -- [493]
	elseif spellId == 101945 then
		self:SendSync("Tree")
	end
end

--Use syncing since these unit events require "target" or "focus" to detect.
--At least someone in group should be targeting this stuff and sync it to those that aren't (like a healer)
function mod:OnSync(event, arg)
	if event == "SnowMan" then
		warnSnowman:Show()
		timerTreeCD:Start()--Not a bug, it's intended to start opposite timer off each trigger.
	elseif event == "Tree" then
		warnTree:Show()
		timerCrushCD:Start()
		timerSnowmanCD:Start()
	end
end--]]
