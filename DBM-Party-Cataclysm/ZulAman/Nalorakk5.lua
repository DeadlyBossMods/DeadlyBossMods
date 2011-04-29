if tonumber((select(2, GetBuildInfo()))) < 13682 then return end
local mod	= DBM:NewMod("Nalorakk5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23576)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBear			= mod:NewAnnounce("WarnBear", 4, 39414)
local warnBearSoon		= mod:NewAnnounce("WarnBearSoon", 3, 39414)
local warnNormal		= mod:NewAnnounce("WarnNormal", 4, 39414)
local warnNormalSoon	= mod:NewAnnounce("WarnNormalSoon", 3, 39414)
local warnSilence		= mod:NewSpellAnnounce(42398, 3)
local warnSurge			= mod:NewTargetAnnounce(42402)

local timerBear			= mod:NewTimer(45, "TimerBear", 39414)
local timerNormal		= mod:NewTimer(30, "TimerNormal", 39414)

local berserkTimer		= mod:NewBerserkTimer(600)

local silenceSpam = 0

function mod:OnCombatStart(delay)
	silenceSpam = 0
	timerBear:Start()
	warnBearSoon:Schedule(40)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42398) and GetTime() - silenceSpam > 4 then
		warnSilence:Show()
		silenceSpam = GetTime()
	elseif args:IsSpellID(42402) then
		warnSurge:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellBear or msg:find(L.YellBear) then
		timerBear:Cancel()
		warnBearSoon:Cancel()
		warnBear:Show()
		timerNormal:Start()
		warnNormalSoon:Schedule(25)
	elseif msg == L.YellNormal or msg:find(L.YellNormal) then
		timerNormal:Cancel()
		warnNormalSoon:Cancel()
		warnNormal:Show()
		timerBear:Start()
		warnBearSoon:Schedule(40)
	end
end
