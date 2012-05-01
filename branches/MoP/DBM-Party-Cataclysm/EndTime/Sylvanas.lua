local mod	= DBM:NewMod("EchoSylvanas", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54123)
mod:SetModelID(38655)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnShriek	= mod:NewTargetAnnounce(101412, 3, nil, false)
local warnCalling	= mod:NewSpellAnnounce(100686, 4)
local warnSacrifice	= mod:NewSpellAnnounce(101348, 2, nil, false)

local timerShriek	= mod:NewTargetTimer(30, 101412)
local timerCalling	= mod:NewNextTimer(40, 100686)	-- guessed she can do it more than once
local timerSacrifice	= mod:NewNextTimer(30, 101348)

function mod:OnCombatStart(delay)
	timerCalling:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101412) then
		warnShriek:Show(args.destName)
		timerShriek:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101412) then
		timerShriek:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(100686) then
		warnCalling:Show()
		timerSacrifice:Start()
	elseif args:IsSpellID(101348) then
		warnSacrifice:Show()
		timerCalling:Start()
	end
end