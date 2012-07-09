local mod	= DBM:NewMod(725, "DBM-Pandaria", nil, 322)	-- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62346)--Salyis not dies. Only Galleon attackable and dies.
mod:SetModelID(42439)	--Galleon=42439, Salyis=42468 / main boss is Galleon
mod:SetZone(807)--Valley of the Four winds

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE"
)

local warnCannonBarrage			= mod:NewSpellAnnounce(121600, 4)
local warnStomp					= mod:NewSpellAnnounce(121787, 3)
local warnWarmonger				= mod:NewSpellAnnounce("ej6200", 2)

local specWarnCannonBarrage		= mod:NewSpecialWarningSpell(121600, mod:IsTank())
local specWarnWarmonger			= mod:NewSpecialWarningSwitch("ej6200", not mod:IsHealer())

local timerCannonBarrage		= mod:NewNextTimer(60, 121600)
local timerStomp				= mod:NewNextTimer(60, 121787)
local timerWarmonger			= mod:NewNextTimer(10.5, "ej6200")--Comes after Stomp. (Also every 60 sec.)

function mod:OnCombatStart(delay)
	timerCannonBarrage:Start(24-delay)
	timerStomp:Start(50-delay)
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find(L.CannonBarrage) then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
		timerCannonBarrage:Start()
	elseif msg:find(L.Stomp) then
		warnStomp:Show()
		warnWarmonger:Schedule(10.5)
		specWarnWarmonger:Schedule(10.5)
		timerWarmonger:Start()
		timerStomp:Start()
	end
end
