local mod = DBM:NewMod("Thaddius", "DBM-Naxx", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15928)
mod:SetZone()

mod:RegisterCombat("yell", L.Yell)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_AURA"
)

local warnShiftCasting		= mod:NewAnnounce("WarningShiftCasting", 3, 28089)
local warnChargeChanged		= mod:NewSpecialWarning("WarningChargeChanged")
local warnChargeNotChanged	= mod:NewSpecialWarning("WarningChargeNotChanged", false)

local enrageTimer		= mod:NewEnrageTimer(300) -- todo: phase2 trigger
local timerNextShift	= mod:NewTimer(29, "TimerNextShift", 28089)
local timerShiftCast	= mod:NewTimer(5, "TimerShiftCast", 28089)

mod:AddBoolOption("ArrowsEnabled", true, "Arrows")
mod:AddBoolOption("ArrowsRightLeft", false, "Arrows")
mod:AddBoolOption("ArrowsInverse", false, "Arrows")


local currentCharge

function mod:OnCombatStart()
	currentCharge = nil
end

local lastShift = 0
function mod:SPELL_CAST_START(args)
	if args.spellId == 28089 then
		timerNextShift:Start()
		timerShiftCast:Start()
		warnShiftCasting:Show()
		lastShift = GetTime()
	end
end


function mod:UNIT_AURA(unit)
	if unit ~= "player" then return end
	local charge
	local i = 1
	while UnitDebuff("player", i) do
		local _, _, icon = UnitDebuff("player", i)
		if icon == "Interface\\Icons\\Spell_ChargeNegative" then
			charge = "negative"
--		elseif icon == "Interface\\Icons\\Spell_Holy_AshesToAshes" then
		elseif icon == "Interface\\Icons\\Spell_ChargePositive" then
			charge = "positive"
		end
		i = i + 1
	end
	if charge and (GetTime() - lastShift) < 8 and (GetTime() - lastShift) > 5 then
		if charge == currentCharge then
			warnChargeNotChanged:Show()
		else
			warnChargeChanged:Show(charge)
		end
		currentCharge = charge
	end
end
