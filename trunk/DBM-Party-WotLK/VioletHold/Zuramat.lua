local mod = DBM:NewMod("Zuramat", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29314)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningVoidShift		= mod:NewAnnounce("WarningVoidShift", 2, 59743)
local warningVoidShifted	= mod:NewAnnounce("WarningVoidShifted", 3, 59743)
local warningShroudOfDarkness	= mod:NewAnnounce("WarningShroudOfDarkness", 4, 59745)
local specWarnVoidShifted	= mod:NewSpecialWarning("SpecialWarningVoidShifted", true, false, false)
local specShroudOfDarkness	= mod:NewSpecialWarning("SpecialShroudofDarkness", true, false, false)
local timerVoidShift		= mod:NewTimer(5, "TimerVoidShift", 59743)
local timerVoidShifted		= mod:NewTimer(15, "TimerVoidShifted", 54343)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59743 or args.spellId == 54361 then			-- Void Shift            59743 (HC)  54361 (nonHC)
		local spellName = GetSpellInfo(args.spellId)
		warningVoidShift:Show(tostring(spellName))
		timerVoidShift:Start(args.destName)

	elseif args.spellId == 54343 then
		if args.destName == UnitName("player") then
			specWarnVoidShifted:Show()
		end
		timerVoidShifted:Start(args.destName)

	elseif args.spellId == 59745 or args.spellId == 54524 then		-- Shroud of Darkness    59745 (HC)   54524 (nonHC)
		warningShroudOfDarkness:Show()
		specShroudOfDarkness:Show(args.spellName)
	end
end




-- Shroud of Darkness    59745 (HC)   54524 (nonHC)
-- don't attack Zuramat!

-- Summon Void Sentry    54369 

-- Void Shift            59743 (HC)  54361 (nonHC)
-- Void Shifted	         54343
-- attack void units!


--[[
11/18 00:30:50.849  SPELL_AURA_APPLIED,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,DEBUFF
11/18 00:30:51.834  SPELL_PERIODIC_DAMAGE,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,1120,0,32,0,0,480,nil,nil,nil
11/18 00:30:52.987  SPELL_PERIODIC_DAMAGE,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,1120,0,32,0,0,480,nil,nil,nil
11/18 00:30:53.826  SPELL_PERIODIC_DAMAGE,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,1120,0,32,0,0,480,nil,nil,nil
11/18 00:30:54.802  SPELL_PERIODIC_DAMAGE,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,1120,0,32,0,0,480,nil,nil,nil
11/18 00:30:55.889  SPELL_PERIODIC_DAMAGE,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,1120,0,32,0,0,480,nil,nil,nil
11/18 00:30:55.889  SPELL_AURA_REMOVED,0xF130007282000CAB,"Zuramat the Obliterator",0x10a48,0x000000000134D35E,"Noe",0x512,59743,"Void Shift",0x20,DEBUFF
11/18 00:30:55.889  SPELL_AURA_APPLIED,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,DEBUFF
11/18 00:30:56.814  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,210,0,32,0,0,90,nil,nil,nil
11/18 00:30:57.889  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,210,0,32,0,0,90,nil,nil,nil
11/18 00:30:58.978  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,210,0,32,0,0,90,nil,nil,nil
11/18 00:30:59.854  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,210,0,32,0,0,90,nil,nil,nil
11/18 00:31:00.815  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,210,0,32,0,0,90,nil,nil,nil
11/18 00:31:01.926  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:02.778  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:03.815  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:04.829  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:05.935  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:10.929  SPELL_PERIODIC_DAMAGE,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,300,0,32,0,0,0,nil,nil,nil
11/18 00:31:10.929  SPELL_AURA_REMOVED,0x0000000000000000,nil,0x80000000,0x000000000134D35E,"Noe",0x512,54343,"Void Shifted",0x20,DEBUFF
--]]


