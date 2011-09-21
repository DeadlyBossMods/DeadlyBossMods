if tonumber((select(2, GetBuildInfo()))) < 13682 then return end
local mod	= DBM:NewMod("Janalai5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23578)
mod:SetModelID(21633)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFlameCast		= mod:NewSpellAnnounce(97855, 2)
local warnAdds			= mod:NewSpellAnnounce(43962, 4)
local warnAddsSoon		= mod:NewSoonAnnounce(43962, 3)
local warnFireBomb		= mod:NewSpellAnnounce(42630, 3)
local warnHatchAll		= mod:NewSpellAnnounce(43144, 4)

local specWarnFlameBreath	= mod:NewSpecialWarningMove(97497)
local specWarnAdds			= mod:NewSpecialWarningSpell(43962)
local specWarnBomb			= mod:NewSpecialWarningSpell(42630, nil, nil, nil, true)
local specWarnHatchAll		= mod:NewSpecialWarningSpell(43144, mod:IsTank())

local timerBomb				= mod:NewCastTimer(12, 42630)
local timerBombCD			= mod:NewNextTimer(30, 42630)
local timerAdds				= mod:NewNextTimer(65, 43962)--I'm not evey sure it's timed or health based but it definitely wasn't 92 seconds in my run it was 65

local berserkTimer			= mod:NewBerserkTimer(600)

local spamFlameBreath = 0

function mod:OnCombatStart(delay)
	timerAdds:Start(12-delay)
	timerBombCD:Start(55-delay)--Needs verification of consistency.
	berserkTimer:Start(-delay)
	spamFlameBreath = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97497) and args:IsPlayer() and GetTime() - spamFlameBreath >= 3 then
		specWarnFlameBreath:Show()
		spamFlameBreath = GetTime()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(97855) then
		warnFlameCast:Show()	-- Seems he doesn't target the person :(
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAdds or msg:find(L.YellAdds) then
		warnAdds:Show()
		specWarnAdds:Show()
		warnAddsSoon:Schedule(60)
		timerAdds:Start()
	elseif msg == L.YellBomb or msg:find(L.YellBomb) then
		warnFireBomb:Show()
		specWarnBomb:Show()
		timerBomb:Start()
		timerBombCD:Start()
	elseif msg == L.YellHatchAll or msg:find(L.YellHatchAll) then
		warnHatchAll:Show()
		specWarnHatchAll:Show()
	end
end