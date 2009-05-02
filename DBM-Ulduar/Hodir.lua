local mod = DBM:NewMod("Hodir", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32845)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

mod:AddBoolOption("PlaySoundOnFlashFreeze", true, "announce")

local timerFlashFreeze	= mod:NewCastTimer(9, 61968)
local timerFrozenBlows	= mod:NewBuffActiveTimer(20, 63512)
local timerFlashFrCD	= mod:NewCDTimer(50, 61968)


local warnFlashFreeze	= mod:NewSpecialWarning("WarningFlashFreeze")
local warnBitingCold	= mod:NewSpecialWarning("WarningBitingCold")

local enrageTimer	= mod:NewEnrageTimer(480)


function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerFlashFrCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61968 then
		timerFlashFreeze:Start()
		warnFlashFreeze:Show()
		timerFlashFrCD:Start()
		if self.Options.PlaySoundOnFlashFreeze then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62478 or args.spellId == 63512 then
		timerFrozenBlows:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 62188 and args.destName == UnitName("player") then 
		-- bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then -- Biting Cold
		if args.amount >= 2 then
			warnBitingCold:Show()
		end
	end
end



