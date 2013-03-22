local mod	= DBM:NewMod("Greench", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54499)
mod:SetModelID(39021)
mod:SetZone(24)--Hillsbread Foothills

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnShrinkHeart			= mod:NewSpellAnnounce(101873, 2)
local warnSnowman				= mod:NewSpellAnnounce(101910, 2)
local warnSnowCrash				= mod:NewCastAnnounce(101907, 3)
local warnTree					= mod:NewSpellAnnounce(101938, 2)--Needs a custom icon, i'll find one soon.

local specWarnShrinkHeart		= mod:NewSpecialWarningMove(101860)

local timerShrinkHeartCD		= mod:NewCDTimer(32.5, 101873)
local timerSnowmanCD			= mod:NewCDTimer(10, 101910)--He alternates these
local timerTreeCD				= mod:NewCDTimer(10, 101938)
local timerCrushCD				= mod:NewCDTimer(5, 101885)--Used 5 seconds after tree casts (on the tree itself). Right before stomp he stops targeting tank. He has no target during stomp, usable for cast trigger? Only trigger in log is the stomp landing.
local timerSnowCrash			= mod:NewCastTimer(5, 101907)

function mod:OnCombatStart(delay)
	timerSnowmanCD:Start(-delay)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
--	The Abominable Greench:Possible Target<Omegathree>:target:Throw Strange Snowman Trigger::0:101942", -- [230]
	if spellName == GetSpellInfo(101942) then
		self:SendSync("SnowMan")
--	The Abominable Greench:Possible Target<Omegathree>:target:Throw Winter Veil Tree Trigger::0:101945", -- [493]
	elseif spellName == GetSpellInfo(101945) then
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
end
