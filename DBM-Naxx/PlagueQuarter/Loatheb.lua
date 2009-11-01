local mod = DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16011)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnSporeNow	= mod:NewAnnounce("WarningSporeNow", 2, 32329)
local warnSporeSoon	= mod:NewAnnounce("WarningSporeSoon", 1, 32329)
local warnDoomNow	= mod:NewAnnounce("WarningDoomNow", 3, 29204)
local warnHealSoon	= mod:NewAnnounce("WarningHealSoon", 4, 48071)
local warnHealNow	= mod:NewAnnounce("WarningHealNow", 1, 48071, false)


local timerSpore	= mod:NewTimer(36, "TimerSpore", 32329)
local timerDoom		= mod:NewTimer(180, "TimerDoom", 29204)
local timerAura		= mod:NewTimer(17, "TimerAura", 55593)

local doomCounter = 0
local sporeTimer = 36

function mod:OnCombatStart(delay)
	doomCounter = 0
	if mod:IsDifficulty("heroic25") then
		sporeTimer = 18
	else
		sporeTimer = 36
	end
	timerSpore:Start(sporeTimer - delay)
	warnSporeSoon:Schedule(sporeTimer - 5 - delay)
	timerDoom:Start(120 - delay, doomCounter + 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29234) then
		timerSpore:Start(sporeTimer)
		warnSporeNow:Show()
		warnSporeSoon:Schedule(sporeTimer - 5)
	elseif args:IsSpellID(29204, 55052) then  -- Inevitable Doom
		doomCounter = doomCounter + 1
		local timer = 30
		if doomCounter >= 7 then
			if doomCounter % 2 == 0 then timer = 17
			else timer = 12 end
		end
		warnDoomNow:Show(doomCounter)
		timerDoom:Start(timer, doomCounter + 1)
	elseif args:IsSpellID(55593) then
		timerAura:Start()
		warnHealSoon:Schedule(14)
		warnHealNow:Schedule(17)
	end
end


