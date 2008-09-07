local mod = DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16011)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

--[[
9/6 21:49:24.875  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1
9/6 21:50:00.671  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:50:36.781  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:51:12.218  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:51:48.296  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36

]]--

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warningSporeNow	= mod:NewAnnounce("WarningSporeNow", 3, 29234)
local warningSporeSoon	= mod:NewAnnounce("WarningSporeSoon", 3, 29234)

local timerSpore		= mod:NewTimer(36, "TimerSpore", 29234)

function mod:OnCombatStart(delay)
	timerSpore:Start(36 - delay)
	warningSporeSoon:Schedule(31 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 29234 then
		timerSpore:Start()
		warningSporeNow:Show()
		warningSporeSoon:Schedule(31)		
	end
end

