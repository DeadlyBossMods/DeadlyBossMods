local mod	= DBM:NewMod("Vanessa", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(49541)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnDeflection	= mod:NewSpellAnnounce(92614, 3)
local warnDeadlyBlades	= mod:NewSpellAnnounce(92622, 3)
local warnVengeance	= mod:NewSpellAnnounce(95542, 4)

local timerDeflection	= mod:NewBuffActiveTimer(10, 92614)
local timerDeadlyBlades	= mod:NewBuffActiveTimer(5, 92622)

local timerGauntlet		= mod:NewAchievementTimer(297, 5371, "achievementGauntlet")--timer minus 3 since i'm starting it with an event 3 second after emote.

function mod:OnCombatStart(delay)
	timerGauntlet:Cancel()--it actually cancels a few seconds before engage but this doesn't require localisation and extra yell checks.
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(92614) then
		warnDeflection:Show()
		timerDeflection:Start()
	elseif args:IsSpellID(92622) then
		warnDeadlyBlades:Show()
		timerDeadlyBlades:Start()
	elseif args:IsSpellID(95542) then
		warnVengeance:Show()
	end
end

--"<34.1> [MONSTER_SAY] CHAT_MSG_MONSTER_SAY:I was never very good at hand-to-hand combat, you know.  Not like my father.:Vanessa VanCleef:::Blacklist::0:0::0:491::0:false:false:", -- [12]
--"<37.7> [MONSTER_SAY] CHAT_MSG_MONSTER_SAY:But I always excelled at poisons.:Vanessa VanCleef:::Blacklist::0:0::0:492::0:false:false:", -- [13]
--"<40.3> [CLEU] SPELL_CAST_SUCCESS:0xF130C1150003F0F9:Vanessa VanCleef:2632:0x0000000000000000:nil:-2147483648:92100:Noxious Concoction:8:", -- [14]
--"<42.6> [MONSTER_SAY] CHAT_MSG_MONSTER_SAY:Especially venoms that affect the mind.:Vanessa VanCleef:::Blacklist::0:0::0:494::0:false:false:", -- [20]
--"<47.4> [RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE:Vanessa injects you with the Nightmare Elixir!:Vanessa VanCleef:::Blacklist::0:0::0:495::0:false:false:", -- [25]
--"<50.3> [CLEU] SPELL_AURA_REMOVED:0xF130C1150003F0F9:Vanessa VanCleef:2632:0x04000000035FAB24:Omegal:1297:92100:Noxious Concoction:8:DEBUFF:", -- [27]
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(92100) then
		timerGauntlet:Start()
	end
end