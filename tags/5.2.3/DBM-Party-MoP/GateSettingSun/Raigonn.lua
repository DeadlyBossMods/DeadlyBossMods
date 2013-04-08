local mod	= DBM:NewMod(649, "DBM-Party-MoP", 4, 303)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56877)
mod:SetModelID(39519)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnHeadbutt				= mod:NewSpellAnnounce(111668, 2)
local warnScreechingSwarm		= mod:NewTargetAnnounce(111600, 4, nil, false)--Can be spam if adds not die.
local warnBrokenCarapace		= mod:NewSpellAnnounce(107146, 2)--Phase 2
local warnFixate				= mod:NewTargetAnnounce(111723, 4)
local warnStomp					= mod:NewCountAnnounce(111728, 3)

local specWarnScreechingSwarm	= mod:NewSpecialWarningDispel(111600, false)--Can be spam if adds not die.
local specWarnBrokenCarapace	= mod:NewSpecialWarningSpell(107146, mod:IsDps())

local timerHeadbuttCD			= mod:NewNextTimer(33, 111668)
local timerScreechingSwarm		= mod:NewTargetTimer(10, 111600)
local timerFixate				= mod:NewTargetTimer(15, 111723)
local timerFixateCD				= mod:NewNextTimer(20.5, 111723)
local timerStompCD				= mod:NewNextCountTimer(20.5, 111728)

local stompCount = 0

function mod:OnCombatStart(delay)
	stompCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 107146 then
		warnBrokenCarapace:Show()
		specWarnBrokenCarapace:Show()
		timerHeadbuttCD:Cancel()
		timerFixateCD:Start(5.5)--Timing for target pick, not cast start.
		timerStompCD:Start(20.5, 1)
	elseif args.spellId == 111723 then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		timerFixateCD:Start()
	elseif args.spellId == 111600 then
		warnScreechingSwarm:Show(args.destName)
		specWarnScreechingSwarm:Show(args.destName)
		timerScreechingSwarm:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 111723 then
		timerFixate:Cancel(args.destName)
	elseif args.spellId == 111600 then
		timerScreechingSwarm:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 111668 then
		warnHeadbutt:Show()
		timerHeadbuttCD:Start()
	elseif args.spellId == 111728 then
		stompCount = stompCount + 1
		warnStomp:Show(stompCount)
		timerStompCD:Start(20.5, stompCount+1)
	end
end
