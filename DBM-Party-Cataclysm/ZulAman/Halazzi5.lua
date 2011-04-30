local mod	= DBM:NewMod("Halazzi5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23577)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnTotemWater	= mod:NewSpellAnnounce(97500, 3)
local warnTotemLighting	= mod:NewSpellAnnounce(97492, 3)
local warnShock			= mod:NewTargetAnnounce(97490, 3)
local warnEnrage		= mod:NewTargetAnnounce(43139, 3)
local warnSpirit		= mod:NewAnnounce("WarnSpirit", 4, 39414)
local warnNormal		= mod:NewAnnounce("WarnNormal", 4, 39414)

local specWarnTotem		= mod:NewSpecialWarningSpell(97492)
local specWarnTotemWater= mod:NewSpecialWarningMove(97500, mod:IsTank())
local specWarnEnrage	= mod:NewSpecialWarningDispel(43139, mod:CanRemoveEnrage())

local timerShock		= mod:NewTargetTimer(12, 97490)

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97490) then
		warnShock:Show(args.destName)
		timerShock:Show(args.destName)
	elseif args:IsSpellID(43139) then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(43303) then
		timerShock:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(97492) then
		warnTotemLighting:Show()
		specWarnTotem:Show()
	elseif args:IsSpellID(97500) then
		warnTotemWater:Show()
		specWarnTotemWater:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSpirit or msg:find(L.YellSpirit) then
		warnSpirit:Show()
	elseif msg == L.YellNormal or msg:find(L.YellNormal) then
		warnNormal:Show()
	end
end
