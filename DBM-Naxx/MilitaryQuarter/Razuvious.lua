local mod = DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16803)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnShoutNow	= mod:NewAnnounce("WarningShoutNow", 1, 55543)
local warnShoutSoon	= mod:NewAnnounce("WarningShoutSoon", 3, 55543)

local timerShout	= mod:NewTimer(16, "TimerShout", 55543)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

--[[
9/8 21:58:26.781  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 21:58:42.296  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1 
9/8 21:58:58.062  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 21:59:13.281  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 21:59:29.000  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 21:59:44.218  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 21:59:59.421  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
9/8 22:00:15.062  SPELL_CAST_SUCCESS,0xF130003EBD005EE5,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,29107,"Disrupting Shout",0x1
]]--
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 55543       -- Disrupting Shout (10)
	or args.spellId == 29107 then  -- Disrupting Shout (25)
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	end
end
