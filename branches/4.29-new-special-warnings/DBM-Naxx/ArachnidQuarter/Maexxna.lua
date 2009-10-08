local mod = DBM:NewMod("Maexxna", "DBM-Naxx", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15952)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnWebWrap		= mod:NewAnnounce("WarningWebWrap", 2, 28622)
local warnWebSpraySoon	= mod:NewAnnounce("WarningWebSpraySoon", 1, 29484)
local warnWebSprayNow	= mod:NewAnnounce("WarningWebSprayNow", 3, 29484)
local warnSpidersSoon	= mod:NewAnnounce("WarningSpidersSoon", 2, 17332)
local warnSpidersNow	= mod:NewAnnounce("WarningSpidersNow", 4, 17332)

local timerWebSpray		= mod:NewTimer(40.5, "TimerWebSpray", 29484)
local timerSpider		= mod:NewTimer(30, "TimerSpider", 17332)

function mod:OnCombatStart(delay)
	warnWebSpraySoon:Schedule(35.5 - delay)
	timerWebSpray:Start(40.5 - delay)
	warnSpidersSoon:Schedule(25 - delay)
	warnSpidersNow:Schedule(30 - delay)
	timerSpider:Start(30 - delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28622 then -- Web Wrap
		warnWebWrap:Show(args.destName)
		if args.destName == UnitName("player") then
			SendChatMessage(L.YellWebWrap, "YELL")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 29484 	  -- Web Spray (10)
	or args.spellId == 54125 then -- Web Spray (25)
		warnWebSprayNow:Show()
		warnWebSpraySoon:Schedule(35.5)
		timerWebSpray:Start()
		warnSpidersSoon:Schedule(25)
		warnSpidersNow:Schedule(30)
		timerSpider:Start()
	end
end
