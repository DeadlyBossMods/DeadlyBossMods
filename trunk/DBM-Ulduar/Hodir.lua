local mod = DBM:NewMod("Hodir", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(0) -- Mob ID Required!
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

mod:AddBoolOption("PlaySoundOnFlashFreeze", true, "announce")

local timerFlashFreeze	= mod:NewTimer(9, "TimerFlashFreeze", 0)  -- spell id required!

local warnFlashFreeze	= mod:NewSpecialWarning("WarningrFlashFreeze")
local warnBitingCold	= mod:NewSpecialWarning("WarningrBitingCold")

local enrageTimer	= mod:NewEnrageTimer(300)


function mod:OnCombatStart(delay)
	--enrageTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 0 then  -- spell id (FlashFreeze) required
		timerFlashFreeze:Start()
		warnFlashFreeze:Show()

		if self.Options.PlaySoundOnFlashFreeze then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end	
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 0 and args.destName == UnitName("player") then -- Biting Cold
		warnBitingCold:Show()
		if args.amount >= 4 then -- don't know it
			warnBitingCold:Show()
		end
	end
end


