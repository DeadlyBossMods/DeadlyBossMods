local mod	= DBM:NewMod("Hodir", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32845)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnStormCloud		= mod:NewTargetAnnounce(65123)
local warnFlashFreeze		= mod:NewSpecialWarningSpell(61968)

local specWarnStormCloud	= mod:NewSpecialWarningYou(65123)
local specWarnBitingCold	= mod:NewSpecialWarningMove(62188, false)

local enrageTimer			= mod:NewBerserkTimer(475)
local timerFlashFreeze		= mod:NewCastTimer(9, 61968)
local timerFrozenBlows		= mod:NewBuffActiveTimer(20, 63512)
local timerFlashFrCD		= mod:NewCDTimer(50, 61968)
local timerAchieve			= mod:NewAchievementTimer(179, 3182, "TimerSpeedKill")

mod:AddBoolOption("SetIconOnStormCloud")
mod:AddBoolOption("PlaySoundOnFlashFreeze", true, "announce")
mod:AddBoolOption("YellOnStormCloud", true, "announce")

local stormCloudIcon

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerFlashFrCD:Start(-delay)
	stormCloudIcon = 8
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
		if args:IsPlayer() then
			specWarnStormCloud:Show()
			if self.Options.YellOnStormCloud then
				SendChatMessage(L.YellCloud, "SAY")
			end
		end
		if self.Options.SetIconOnStormCloud then
			self:SetIcon(args.destName, stormCloudIcon)
			if stormCloudIcon == 8 then	-- There is a chance 2 ppl will have the buff on 25 player, so we are alternating between 2 icons
				stormCloudIcon = 7
			else
				stormCloudIcon = 8
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	elseif args:IsSpellID(65123, 65133) then
		if self.Options.SetIconOnStormCloud then
			self:SetIcon(args.destName, 0)
		end
	end
end

do 
	local lastbitingcold = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(62038, 62188) and args:IsPlayer() and time() - lastbitingcold > 4 then		-- Biting Cold
			specWarnBitingCold:Show()
			lastbitingcold = time()
		end
	end
end