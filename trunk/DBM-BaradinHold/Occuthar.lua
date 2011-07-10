local mod	= DBM:NewMod(140, "DBM-BaradinHold", nil, 74)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52363)
mod:SetModelID(37876)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnSearingShadows		= mod:NewSpellAnnounce(96913, 2)
local warnEyes					= mod:NewSpellAnnounce(96920, 3)

local timerSearingShadows		= mod:NewCDTimer(24, 96913)
local timerEyes					= mod:NewCDTimer(60, 96920)
local timerFocusedFire			= mod:NewCDTimer(16, 96884) -- 24 16 16, repeating pattern. Can vary by a couple seconds, ie be 26 18 18, but the pattern is same regardless.

local specWarnSearingShadows	= mod:NewSpecialWarningSpell(96913, mod:IsTank())
local specWarnFocusedFire		= mod:NewSpecialWarningMove(97212)

local berserkTimer				= mod:NewBerserkTimer(300)

local spamFire = 0
local focusedFire = 0

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSearingShadows:Start(11-delay)
	timerEyes:Start(30-delay)
--	timerFocusedFire:Start()--Need transcriptor to see what first one always is.
	spamFire = 0
	focusedFire = 0
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96920, 101006) then
		warnEyes:Show()
		timerEyes:Start()
	elseif args:IsSpellID(96913, 101007) then
		warnSearingShadows:Show()
		timerSearingShadows:Start()
		specWarnSearingShadows:Schedule(2.5) -- Tank switch after spell happened (could be done on SPELL_AURA_APPLIED as well, but then a spam function is needed in case more ppl get hit)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96884) then
		if focusedFire % 3 or focusedFire == 0 then--We start with 0 to make the math easier to do since it starts on first cast
			timerFocusedFire:Start(24)--Every 3rd cast (starting with first) is longer cd after.
		else
			timerFocusedFire:Start()--16 second cd for rest
		end
		focusedFire = focusedFire + 1
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(97212) and args:IsPlayer() and GetTime() - spamFire > 4 then--Is this even right one? 96883, 101004 are ones that do a lot of damage?
		specWarnFocusedFire:Show()
		spamFire = GetTime()
	end
end