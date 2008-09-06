local mod = DBM:NewMod("Razuvious 10", "DBM-Naxx-10", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 84 $"):sub(12, -3))
mod:SetCreatureID(16061)
mod:SetZone(GetAddOnMetadata("DBM-Naxx-10", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

--[[
9/7 00:14:08.953  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:14:24.453  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:14:40.562  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:14:56.578  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:15:12.375  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:15:28.687  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:15:44.484  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1 16
9/7 00:16:00.406  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:16:16.734  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:16:32.687  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:16:48.593  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:17:04.828  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
9/7 00:17:19.953  SPELL_CAST_SUCCESS,0xF130003EBD000185,"Instructor Razuvious",0xa48,0x0000000000000000,nil,0x80000000,55543,"Disrupting Shout",0x1
]]--

local warnShoutNow	= mod:NewAnnounce("WarningShoutNow", 1, 55543)
local warnShoutSoon	= mod:NewAnnounce("WarningShoutSoon", 3, 55543)

local timerShout	= mod:NewTimer(16, "TimerShout", 55543)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 55543 then
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	end
end
