local mod = DBM:NewMod("Thorim", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local enrageTimer		= mod:NewEnrageTimer(309)

local timerStormhammer		= mod:NewTimer(16, "TimerStormhammer", 62042)
local timerUnbalancingStrike	= mod:NewTimer(21, "TimerUnbalancingStrike", 62130)
local timerHardmode		= mod:NewTimer(189, "TimerHardmode", 62042)

local warnPhase2			= mod:NewAnnounce("WarningPhase2", 1)
local warnStormhammer		= mod:NewAnnounce("WarningStormhammer", 2, 62470)
local warnUnbalancingStrike	= mod:NewAnnounce("UnbalancingStrike", 4, 62130)	-- nice blizzard, very new stuff, hmm or not? ^^ aq40 4tw :)
local warningBomb			= mod:NewAnnounce("WarningBomb", 4)

local specWarnOrb			= mod:NewSpecialWarning("LightningOrb")


mod:AddBoolOption("RangeFrame")

function mod:OnCombatStart(delay)
	enrageTimer:Start()
	timerHardmode:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62042 then -- Storm Hammer
		warnStormhammer:Show(args.destName)

	elseif args.spellId == 62130 then	-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
		
	elseif args.spellId == 62526 then -- Runic Detonation
		self:SetIcon(args.destName, 8, 5)
		warningBomb:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62042 then -- Storm Hammer
		timerStormhammer:Schedule(2)
	elseif args.spellId == 62130 then	-- Unbalancing Strike
		timerUnbalancingStrike:Start()
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		self:SendSync("Phase2")
	end
end

local spam = 0
function mod:SPELL_DAMAGE(args)
	if args.spellId == 62017 then -- Lightning Shock
		if bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and GetTime() - spam > 5 then
			spam = GetTime()
			specWarnOrb:Show()
		end
	end
end

function mod:OnSync(event, arg)
	if event == "Phase2" then
		warnPhase2:Show()
		enrageTimer:Stop()
		timerHardmode:Stop()
		enrageTimer:Start(300)
	end
end



