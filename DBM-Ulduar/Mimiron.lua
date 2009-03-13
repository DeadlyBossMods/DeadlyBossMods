local mod = DBM:NewMod("Mimiron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 694 $"):sub(12, -3))
mod:SetCreatureID(33350) -- Mob ID Required!
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

mod:AddBoolOption("PlaySoundOnShockBlast", true, "announce")

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast")
local warnPlasmaBlast		= mod:NewAnnounce("WarningPlasmaBlast", 4, 64529)
local timerProximityMines	= mod:NewTimer(40, "ProximityMines")

local timerDarkGlare		= mod:NewTimer(30, "DarkGlare")

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 63631 then
		warnShockBlast:Show()

		if self.Options.PlaySoundOnShockBlast then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end	

	elseif args.spellId == 64529 then
		warnPlasmaBlast:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63027 then	-- mines
		timerProximityMines:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63274 then
		timerDarkGlare:Start()
	end
end





