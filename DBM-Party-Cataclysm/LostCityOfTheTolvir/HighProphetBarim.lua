local mod	= DBM:NewMod("HighProphetBarim", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(43612)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED" 
)

local warnPlagueAges		= mod:NewTargetAnnounce(82622, 3)
local warnLashings		= mod:NewTargetAnnounce(82506, 3)
local warnRepentance		= mod:NewSpellAnnounce(82320, 2)	-- kind of add phase

local timerPlagueAges		= mod:NewTargetTimer(9, 82622)
local timerLashings		= mod:NewTargetTimer(20, 82506)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82622) then
		warnPlagueAges:Show(args.destName)
		timerPlagueAges:Start(args.destName)
	elseif args:IsSpellID(82506) then
		warnLashings:Show(args.destName)
		timerLashings:Start(args.destName)
	elseif args:IsSpellID(82320) and args.destName == L.name then
		warnRepentance:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82622) then
		timerPlagueAges:Cancel(args.destName)
	elseif args:IsSpellID(82506) then
		timerLashings:Cancel(args.destName)
	end
end