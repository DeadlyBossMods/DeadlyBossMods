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
mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	15930, "Feugen",
	15929, "Stalagg"
)

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
		elseif icon == "Interface\\Icons\\Spell_ChargePositive" then
			charge = "positive"
		end
		i = i + 1
	end
	if charge and (GetTime() - lastShift) < 8 and (GetTime() - lastShift) > 5 then
		if charge == currentCharge then
			warnChargeNotChanged:Show()
			if self.Options.ArrowsEnabled and self.Options.ArrowsRightLeft then
				if self.Options.ArrowsInverse then
					self:ShowLeftArrow()
				else
					self:ShowRightArrow()
				end
			end
		else
			warnChargeChanged:Show(charge)
			if self.Options.ArrowsEnabled then
				if self.Options.ArrowsRightLeft and self.Options.ArrowsInverse then
					self:ShowRightArrow()
				elseif self.Options.ArrowsRightLeft then
					self:ShowLeftArrow()
				else
					self:ShowUpArrow()
				end
			end
		end
		currentCharge = charge
	end
end

local function arrowOnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 5 and self.elapsed < 6 then
		self:SetAlpha(self.elapsed - 5)
	elseif self.elapsed >= 6 then
		self:Hide()
	end
end

local function arrowOnShow(self)
	self.elapsed = 0
	self:SetAlpha(1)
end

local arrowLeft = CreateFrame("Frame", nil, UIParent)
local arrowLeftTexture = arrowLeft:CreateTexture("BACKGROUND")
arrowLeftTexture:SetPoint("CENTER", arrowLeft, "CENTER")
arrowLeft:SetHeight(1)
arrowLeft:SetWidth(1)
arrowLeft:SetPoint("CENTER", UIParent, "CENTER", -150, -30)
arrowLeft:SetScript("OnShow", arrowOnShow)
arrowLeft:SetScript("OnUpdate", arrowOnUpdate)

local arrowRight = CreateFrame("Frame")
local arrowRightTexture = arrowLeft:CreateTexture("BACKGROUND")
arrowRightTexture:SetPoint("CENTER", arrowRight, "CENTER")
arrowRight:SetHeight(1)
arrowRight:SetWidth(1)
arrowRight:SetPoint("CENTER", UIParent, "CENTER", -150, -30)
arrowRight:SetScript("OnShow", arrowOnShow)
arrowRight:SetScript("OnUpdate", arrowOnUpdate)

local arrowUp = CreateFrame("Frame")
local arrowUpTexture = arrowUp:CreateTexture("BACKGROUND")
arrowUpTexture:SetPoint("CENTER", arrowUp, "CENTER")
arrowUp:SetHeight(1)
arrowUp:SetWidth(1)
arrowUp:SetPoint("CENTER", UIParent, "CENTER", -150, -30)
arrowUp:SetScript("OnShow", arrowOnShow)
arrowUp:SetScript("OnUpdate", arrowOnUpdate)

function mod:ShowRightArrow()
	arrowRight:Show()
end

function mod:ShowLeftArrow()
	arrowLeft:Show()
end

function mod:ShowUpArrow()
	arrowUp:Show()
end
