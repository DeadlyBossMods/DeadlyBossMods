local mod	= DBM:NewMod("Erudax", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(40484)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBinding	= mod:NewTargetAnnounce(75861, 3)
local warnFeeble	= mod:NewTargetAnnounce(75792, 3)
local warnGale		= mod:NewSpellAnnounce(75664)

local timerBinding	= mod:NewTargetTimer(6, 75861)
local timerFeeble	= mod:NewTargetTimer(3, 75792)
local timerGale		= mod:NewCastTimer(5, 75664)
local timerGaleCD	= mod:NewCDTimer(55, 75664)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75861) then
		warnBinding:Show(args.destName)
		timerBinding:Start(args.destName)
	elseif args:IsSpellID(75792) then
		warnFeeble:Show(args.destName)
		timerFeeble:Start(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75664) then
		warnGale:Show()
		timerGale:Start()
		timerGaleCD:Start()
	end
end