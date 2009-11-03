local mod = DBM:NewMod("Hodir", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32845)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnStormCloud		= mod:NewTargetAnnounce(65123)

local warnFlashFreeze		= mod:NewSpecialWarning("WarningFlashFreeze")

local enrageTimer			= mod:NewEnrageTimer(475)
local timerFlashFreeze		= mod:NewCastTimer(9, 61968)
local timerFrozenBlows		= mod:NewBuffActiveTimer(20, 63512)
local timerFlashFrCD		= mod:NewCDTimer(50, 61968)
local timerAchieve			= mod:NewAchievementTimer(179, 3182, "TimerSpeedKill")

mod:AddBoolOption("PlaySoundOnFlashFreeze", true, "announce")
mod:AddBoolOption("YellOnStormCloud", true, "announce")
mod:AddBoolOption("SetIconOnStormCloud")

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerFlashFrCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(61968) then
		timerFlashFreeze:Start()
		warnFlashFreeze:Show()
		timerFlashFrCD:Start()
		if self.Options.PlaySoundOnFlashFreeze then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62478, 63512) then
		timerFrozenBlows:Start()
	elseif args:IsSpellID(65123, 65133) then
		warnStormCloud:Show(args.destName)
		if self.Options.YellOnStormCloud and args:IsPlayer() then
			SendChatMessage(L.YellCloud, "YELL")
		end
		if self.Options.SetIconOnStormCloud then 
			mod:SetIcon(args.destName, 8, 6)
		end
	end
end


