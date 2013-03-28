local mod	= DBM:NewMod("HeadlessHorseman", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23682, 23775)
--mod:SetModelID(22351)--Model doesn't work/render for some reason.
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_SAY"
)

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

local warnConflag				= mod:NewTargetAnnounce(42380, 3)
local warnSquashSoul			= mod:NewTargetAnnounce(42514, 2)
local warnPhase					= mod:NewAnnounce("WarnPhase", 2, "Interface\\Icons\\Spell_Nature_WispSplode")
local warnHorsemanSoldiers		= mod:NewAnnounce("warnHorsemanSoldiers", 2, 97133)
local warnHorsemanHead			= mod:NewAnnounce("warnHorsemanHead", 3)

local timerCombatStart			= mod:NewTimer(17, "TimerCombatStart", 2457)--rollplay for first pull
local timerConflag				= mod:NewTargetTimer(4, 42380)
local timerSquashSoul			= mod:NewTargetTimer(15, 42514)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42380 then					-- Conflagration
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif args.spellId == 42514 then				-- Squash Soul
		warnSquashSoul:Show(args.destName)
		timerSquashSoul:Start(args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
--	"<48.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax - Command, Head Repositions::0:42410", -- [35]
	if spellName == GetSpellInfo(42410) then
		self:SendSync("HeadRepositions")
--	"<23.0> Headless Horseman:Possible Target<nil>:target:Headless Horseman Climax, Body Stage 1::0:42547", -- [1]
	elseif spellName == GetSpellInfo(42547) then
		self:SendSync("BodyStage1")
--	"<49.0> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 2::0:42548", -- [7]
	elseif spellName == GetSpellInfo(42548) then
		self:SendSync("BodyStage2")
--	"<70.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 3::0:42549", -- [13]
	elseif spellName == GetSpellInfo(42549) then
		self:SendSync("BodyStage3")
	end
end

--Use syncing since these unit events require "target" or "focus" to detect.
--At least someone in group should be targeting this stuff and sync it to those that aren't (like a healer)
function mod:OnSync(event, arg)
	if event == "HeadRepositions" then
		warnHorsemanHead:Show()
	elseif event == "BodyStage1" then
		warnPhase:Show(1)
	elseif event == "BodyStage2" then
		warnPhase:Show(2)
	elseif event == "BodyStage3" then
		warnPhase:Show(3)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.HorsemanSoldiers then	-- Warning for adds spawning. No CLEU or UNIT event for it.
		warnHorsemanSoldiers:Show()
	end
end

function mod:CHAT_MSG_SAY(msg)
	if msg == L.HorsemanSummon and self:AntiSpam(5) then		-- Summoned
		timerCombatStart:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 23775 then
		DBM:EndCombat(self)
	end
end