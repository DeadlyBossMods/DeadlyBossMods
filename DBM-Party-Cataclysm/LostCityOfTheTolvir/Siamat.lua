local mod	= DBM:NewMod("Siamat", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(44819)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",	
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnStaticShock		= mod:NewSpellAnnounce(84547, 4)	-- Summons a "Servant of Siamat"
local warnThunderCrash		= mod:NewCastAnnounce(84522, 3)
local warnDeflectingWinds	= mod:NewSpellAnnounce(84589, 3)
local warnWailingWinds		= mod:NewSpellAnnounce(83066, 3)
local warnAbsorbStorms		= mod:NewSpellAnnounce(83151, 2, false)
local warnGatheredStorms	= mod:NewSpellAnnounce(84982, 3)

local timerThunderCrash		= mod:NewCastTimer(3, 84522)
local timerWailingWinds		= mod:NewBuffActiveTimer(6, 83066)
local timerAbsorbStorms		= mod:NewCDTimer(33, 83151)
local timerGatheredStorms	= mod:NewBuffActiveTimer(25, 84982)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(84982) then
		warnGatheredStorms:Show()
		timerGatheredStorms:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(84522, 90016) then
		warnThunderCrash:Show()
		timerThunderCrash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(84589) then
		warnDeflectingWinds:Show()
	elseif args:IsSpellID(83066) then
		warnWailingWinds:Show()
		timerWailingWinds:Start()
	elseif args:IsSpellID(83151) then
		warnAbsorbStorms:Show()
		timerAbsorbStorms:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(84547, 90014) then
		warnStaticShock:Show()
	end
end