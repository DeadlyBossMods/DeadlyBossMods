local mod	= DBM:NewMod("HeadlessHorseman", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23682, 23775)
--mod:SetModelID(22351)--Model doesn't work/render for some reason.
mod:RegisterCombat("combat")
mod:RegisterKill("say", L.SayCombatEnd)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_SAY"
)

local warnConflag				= mod:NewTargetAnnounce(42380, 3)
local warnSquashSoul			= mod:NewTargetAnnounce(42514, 2)
local warnHorsemanSoldiers		= mod:NewAnnounce("warnHorsemanSoldiers")
local warnHorsemanHead			= mod:NewAnnounce("warnHorsemanHead")

local timerCombatStart			= mod:NewTimer(17, "TimerCombatStart", 2457)--rollplay for first pull
local timerConflag				= mod:NewTargetTimer(4, 42380)
local timerSquashSoul			= mod:NewTargetTimer(15, 42514)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42380) then					-- Conflagration
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif args:IsSpellID(42514) then				-- Squash Soul
		warnSquashSoul:Show(args.destName)
		timerSquashSoul:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.HorsemanHead then			-- No combatlog event for head spawning, Emote works iffy(head doesn't emote First time, only 2nd/3rd)
		warnHorsemanHead:Show()
	elseif msg == L.HorsemanSoldiers then	-- Warning for adds spawning.
		warnHorsemanSoldiers:Show()
	end
end

do 
	local lastSummon = 0
	function mod:CHAT_MSG_SAY(msg)
		if msg == L.HorsemanSummon and GetTime() - lastSummon > 5 then		-- Summoned
			timerCombatStart:Start()
			lastSummon = GetTime()
		end
	end
end