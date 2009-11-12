local mod	= DBM:NewMod("Ironhand", "DBM-Party-BC", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(19710)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local isMelee = select(2, UnitClass("player")) == "ROGUE"
             or select(2, UnitClass("player")) == "WARRIOR"
             or select(2, UnitClass("player")) == "DEATHKNIGHT"

local warnShadowpower       = mod:NewSpellAnnounce(35322)
local timerShadowpower      = mod:NewBuffActiveTimer(15, 35322)
local timerJackhammer       = mod:NewBuffActiveTimer(8, 39194)
local WarnJackHammer		= mod:NewAnnounce("WarnJackHammer")
local specWarnShadowpower   = mod:NewSpecialWarning("specWarnShadowpower", isDispeller)

mod:AddBoolOption("PlaySoundOnJackHammer", isMelee)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then     --Shadow Power
		warnShadowpower:Show(args.destName)
		timerShadowpower:Start(args.destName)
		specWarnShadowpower:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then     --Shadow Power
		timerShadowpower:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(39194, 35327) then     --Jackhammer
		timerJackhammer:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.JackHammer then
		WarnJackHammer:Show()
		if self.Options.PlaySoundOnJackHammer then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end