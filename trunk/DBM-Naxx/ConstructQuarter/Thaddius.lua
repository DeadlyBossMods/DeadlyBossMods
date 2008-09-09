local mod = DBM:NewMod("Thaddius", "DBM-Naxx", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15928)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("yell", L.Yell)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"PLAYER_AURAS_CHANGED"
)

local warnShiftCasting		= mod:NewAnnounce("WarningShiftCasting", 3, 28089)
local warnChargeChanged		= mod:NewSpecialWarning("WarningChargeChanged")
local warnChargeNotChanged	= mod:NewSpecialWarning("WarningChargeNotChanged", false)

local enrageTimer		= mod:NewEnrageTimer(300) -- todo: phase2 trigger
local timerNextShift	= mod:NewTimer(29, "TimerNextShift", 28089)
local timerShiftCast	= mod:NewTimer(5, "TimerShiftCast", 28089)


local currentCharge

function mod:OnCombatStart()
	currentCharge = nil
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 28089 then
		timerNextShift:Start()
		timerShiftCast:Start()
		warnShiftCasting:Show()		
	end
end

local lastShift = 0
function mod:PLAYER_AURAS_CHANGED()
	local charge
	local i = 1
	while UnitDebuff("player", i) do
		local _, _, icon = UnitDebuff("player", i)
		if icon == "Interface\\Icons\\Spell_ChargeNegative" then
			charge = "negative"
		elseif texture == "Interface\\Icons\\Spell_ChargePositive" then
			charge = "positive"
		end
		i = i + 1
	end
	if charge and (GetTime() - lastShift) > 26 then
		if charge == currentCharge then
			warnChargeNotChanged:Show()
		else
			warnChargeChanged:Show(charge)
		end
		currentCharge = charge
		lastShift = GetTime()
	end
end
