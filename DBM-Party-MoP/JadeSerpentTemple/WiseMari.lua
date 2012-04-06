local mod	= DBM:NewMod("WiseMari", "DBM-Party-MoP", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56448)
--mod:SetModelID(41125)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)


--local warnHydroLance			= mod:NewSpellAnnounce(106055, 2)--not sure?
local warnBubbleBurst			= mod:NewCastAnnounce(120900, 3, nil)

--local specWarnLivingWater		= mod:NewSpecialWarningSwitch("ej5870", not mod:IsHealer())--Commented out until i know right section ID
local specwarnCorruptingWaters	= mod:NewSpecialWarningMove(120907)

--local timerHydroLanceCD			= mod:NewCDTimer(6, 106055)
local timerLivingWater			= mod:NewCastTimer(5.5, 106526)
local timerWashAway				= mod:NewNextTimer(8, 106331)

local addsRemaining = 4

function mod:OnCombatStart(delay)
	addsRemaining = 4
	timerLivingWaterCD:Start(13-delay)
	--specWarnLivingWater:Schedule(13)
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(106055) then
		warnHydroLance:Show()
		timerHydroLanceCD:Start()
	end
end--]]

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106526) then--Call Water
		addsRemaining = addsRemaining - 1
		timerLivingWater:Start()
		--specWarnLivingWater:Schedule(5.5)
	elseif args:IsSpellID(106612, 120900) then--Bubble Burst
		warnBubbleBurst:Show()
		timerWashAway:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 115167 or spellId == 120907) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specwarnCorruptingWaters:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
