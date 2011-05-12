local mod	= DBM:NewMod("Occuthar", "DBM-BaradinHold")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52363)	-- guessed
mod:SetModelID(35904)		-- Guessing it looks like the trapped mob inside Baradin Hold
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE"
)

-- Timers/abilities taken from: http://www.youtube.com/watch?v=AW6kMpyskkY   (need logs to verify spell IDs)
--[[
	1.00 - Start
	1.05 - Searing Shadows (SS)
	1.23 - Eyes of Occu'thar (Eyes)	
	1.24 - SS
	1.44 - SS
	2.04 - SS -> 20secs CD timer Id say at this point :p
	2.10 - Eyes
	2.54 - Eyes
	3.30 - Eyes
	4.05 - Eyes
	4.30 - Berserk ? (210 berserk seems quite fast)
--]]

local warnSearingShadows	= mod:NewSpellAnnounce(96913, 2)
local warnFocusedFire		= mod:NewSpellAnnounce(96883, 2, nil, false) -- every 12-15secs? Spammy?
local warnEyes			= mod:NewSpellAnnounce(96920, 3)

local timerSearingShadows	= mod:NewNextTimer(20, 96913)
local timerEyes			= mod:NewCDTimer(35, 96920)

local specWarnSearingShadows	= mod:NewSpecialWarningSpell(96913, mod:IsTank())
local specWarnFocusedFire	= mod:NewSpecialWarningMove(96883)

local berserkTimer			= mod:NewBerserkTimer(210)

local eyesTimer = 45
local eyesCastCount = 0
local spamFire = 0
function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	eyesTimer:Start(23-delay)
	eyesTimer = 45
	eyesCastCount = 0
	spamFire = 0
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96920) then
		warnEyes:Show()
		eyesCastCount = eyesCastCount + 1
		if eyesCastCount == 2 then
			eyesTimer = 35
		end
		timerEyes:Start(eyesTimer)
	elseif args:IsSpellID(96913) then
		warnSearingShadows:Show()
		timerSearingShadows:Start()
		specWarnSearingShadows:Schedule(3) -- Tank switch after spell happened (could be done on SPELL_AURA_APPLIED as well, but then a spam function is needed in case more ppl get hit)
	elseif args:IsSpellID(96883) then
		warnFocusedFire:Show()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(96883) and args:IsPlayer() and GetTime() - spamFire > 5 then
		specWarnFocusedFire:Show()
		spamFire = GetTime()
	end
end