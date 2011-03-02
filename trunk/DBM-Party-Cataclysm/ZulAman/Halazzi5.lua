if tonumber((select(2, GetBuildInfo()))) < 13682 then return end
local mod	= DBM:NewMod("Halazzi5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23577)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL"
)

local warnTotem		= mod:NewSpellAnnounce(43302, 3)
local warnShock		= mod:NewTargetAnnounce(43303, 3)
local warnEnrage	= mod:NewSpellAnnounce(43139, 3)
local warnFrenzy	= mod:NewSpellAnnounce(43290, 3)
local warnSpirit	= mod:NewAnnounce("WarnSpirit", 4, 39414)
local warnNormal	= mod:NewAnnounce("WarnNormal", 4, 39414)

local specWarnTotem	= mod:NewSpecialWarningSpell(43302)

local timerShock	= mod:NewTargetTimer(12, 43303)

local berserkTimer	= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43303) then
		warnShock:Show(args.destName)
		timerShock:Show(args.destName)
	elseif args:IsSpellID(43139) then
		warnEnrage:Show()
	elseif args:IsSpellID(43290) then
		warnFrenzy:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(43303) then
		timerShock:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(43302) then
		warnTotem:Show()
		specWarnTotem:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSpirit or msg:find(L.YellBear) then
		warnSpirit:Show()
	elseif msg == L.YellNormal or msg:find(L.YellNormal) then
		warnNormal:Show()
	end
end
