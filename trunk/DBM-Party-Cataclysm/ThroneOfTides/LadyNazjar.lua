local mod	= DBM:NewMod("LadyNazjar", "DBM-Party-Cataclysm", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40586)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnWaterspout		= mod:NewSpellAnnounce(75863, 3)
local warnWaterspoutSoon	= mod:NewSoonAnnounce(75863, 2)
local warnShockBlast		= mod:NewSpellAnnounce(76008, 1, nil, false)
local warnGeyser		= mod:NewSpellAnnounce(75722, 3)
local warnFungalSpores		= mod:NewTargetAnnounce(80564, 3)

local timerWaterspout		= mod:NewBuffActiveTimer(60, 75863)
local timerShockBlast		= mod:NewCastTimer(3, 76008)
local timerShockBlastCD		= mod:NewCDTimer(13, 76008)
local timerGeyser		= mod:NewCastTimer(5, 75722)
local timerFungalSpores		= mod:NewTargetTimer(15, 80564)

local specWarnShockBlast	= mod:NewSpecialWarningInterrupt(76008)

local preWarnedWaterspout = false
function mod:OnCombatStart()
	preWarnedWaterspout = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(80564, 91470) then
		warnFungalSpores:Show(args.destName)
		timerFungalSpores:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(75690) then
		timerWaterspout:Cancel()
		timerShockBlastCD:Start(13)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75863) then
		warnWaterspout:Show()
		timerWaterspout:Start()
		timerShockBlastCD:Cancel()
	elseif args:IsSpellID(76008, 91477) then
		warnShockBlast:Show()
		specWarnShockBlast:Show()
		if mod:IsDifficulty("heroic5") then
			timerShockBlast:Start(2)
			timerShockBlastCD:Start()	-- Seems like the CD on heroic is same as on normal, need confirmation tho
		else
			timerShockBlast:Start()
			timerShockBlastCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(75700, 75722) then
		warnGeyser:Show()
		timerGeyser:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if (h > 80) or (h > 45 and h < 60) then
			preWarnedWaterspout = false
		elseif (h < 75 and h > 72 or h < 41 and h > 38) and not preWarnedWaterspout then
			preWarnedWaterspout = true
			warnWaterspoutSoon:Show()
		end
	end
end