local mod	= DBM:NewMod(725, "DBM-Pandaria", nil, 322, 1) -- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62346)--Salyis not die. Only Galleon attackable and dies.
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(10466)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE"
)

local warnCannonBarrage			= mod:NewSpellAnnounce(121600, 3)
local warnStomp					= mod:NewCastAnnounce(121787, 3, 3)
local warnWarmonger				= mod:NewSpellAnnounce("ej6200", 2, 121747)

local specWarnCannonBarrage		= mod:NewSpecialWarningSpell(121600, mod:IsTank())
local specWarnStomp				= mod:NewSpecialWarningSpell(121787, nil, nil, nil, 2)
local specWarnWarmonger			= mod:NewSpecialWarningSwitch("ej6200", not mod:IsHealer())

local timerCannonBarrageCD		= mod:NewNextTimer(60, 121600)
local timerStompCD				= mod:NewNextTimer(60, 121787)
local timerStomp				= mod:NewCastTimer(3, 121787)
local timerWarmongerCD			= mod:NewNextTimer(10, "ej6200", nil, nil, nil, 121747)--Comes after Stomp. (Also every 60 sec.)

mod:AddReadyCheckOption(32098, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerCannonBarrageCD:Start(24-delay)
		timerStompCD:Start(50-delay)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:121600") then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
		timerCannonBarrageCD:Start()
	elseif msg:find("spell:121787") then
		warnStomp:Show()
		specWarnStomp:Show()
		warnWarmonger:Schedule(10)
		specWarnWarmonger:Schedule(10)
		timerStomp:Start()
		timerWarmongerCD:Start()
		timerStompCD:Start()
	end
end
