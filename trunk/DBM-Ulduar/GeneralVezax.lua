local mod = DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 679 $"):sub(12, -3))
mod:SetCreatureID(33271)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

--mod:NewAnnounce("WarningSpark", 1, 59381)
--mod:NewTimer(30, "TimerSpark", 59381)
--mod:NewSpecialWarning("WarningSurgeYou")
--mod:NewEnrageTimer(615)

--local warnSearingFlames		= mod:NewSpecialWarning("WarningSearingFlames")
local timerSearingFlamesCast	= mod:NewTimer(2, "timerSearingFlamesCast", 62661)
local timerSurgeofDarkness	= mod:NewTimer(10, "timerSurgeofDarkness", 62662)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62661 then	-- Searing Flames
		--warnSearingFlames:Show()
		timerSearingFlamesCast:Start()

	end
end


do
	local function setsymbol()
		mod:SetIcon(mod:GetBossTarget(), 8, 5)
		print(mod:GetBossTarget())
	end

--	self:ScheduleMethod(0.2, function() print(mod:GetBossTarget()) end)

	function mod:SPELL_CAST_SUCCESS(args)
		if args.spellId == 62660 then
			self:ScheduleMethod(0.1, setsymbol)
		
		elseif args.spellId == 63276 then	-- Mark of the Faceless
			mod:SetIcon(args.destName, 7, 10)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then	
		timerSurgeofDarkness:Stop()
	end
end





