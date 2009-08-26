local mod = DBM:NewMod("Twins", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
--mod:SetCreatureID(34497, 34496)  
mod:SetMinCombatTime(30)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED"
)

mod:SetBossHealthInfo(
	34497, L.Fjola,
	34496, L.Eydis
)

mod:AddBoolOption("HealthFrame", true)

local enrageTimer			= mod:NewEnrageTimer(600)

local warnSpecial			= mod:NewAnnounce("WarnSpecialSpellSoon", 2)	
local timerSpecial			= mod:NewTimer(45, "TimerSpecialSpell")
local specWarnSpecial		= mod:NewSpecialWarning("SpecWarnSpecial")


local timerHeal						= mod:NewCastTimer(15, 65875)
local specWarnEmpoweredDarkness		= mod:NewSpecialWarning("SpecWarnEmpoweredDarkness")
local specWarnEmpoweredLight		= mod:NewSpecialWarning("SpecWarnEmpoweredLight")

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	enrageTimer:Start(-delay)
end

local LightEssence = GetSpellInfo(67223)
local DarkEssence = GetSpellInfo(67176)

function mod:SPELL_CAST_START(args)
	if args.spellId == 66046 or args.spellId == 67206 then 		-- Light Vortex
		local debuff = UnitDebuff("player", LightEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 66058 or args.spellId == 67192 then	-- Dark Vortex
		local debuff = UnitDebuff("player", DarkEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 67303 then 	-- Twin's Pact
		local debuff = true
		self:SpecialAbility(debuff)
	elseif args.spellId == 67306 then	-- Light Pact
		local debuff = true
		self:SpecialAbility(debuff)
	elseif args.spellId == 65875 or args.spellId == 65876 then		-- Heal
		timerHeal:Start()
	end
end

function mod:SpecialAbility(debuff)
	if not debuff then
		specWarnSpecial:Show()
	end
	timerSpecial:Start()
	warnSpecial:Schedule(40)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 65724 and args.destName == UnitName("player") then 		-- Empowered Darkness
		specWarnEmpowered:Show()
	elseif args.spellId == 65748 and args.destName == UnitName("player") then	-- Empowered Light
		specWarnEmpoweredLight:Show()
	end
end

