local mod = DBM:NewMod("ValkyrTwins", "DBM-Trial")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34497)  

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

mod:SetBossHealthInfo(
	34497, L.Fjola,
	34496, L.Eydis
)

local warnSpecial			= mod:NewAnnounce("WarnSpecialSpellSoon", 2)	
local timerSpecial			= mod:NewTimer(45, "TimerSpecialSpell")
local specWarnSpecial			= mod:NewSpecialWarning("SpecWarnSpecial")

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
end

local LightEssence = GetSpellInfo(67223)
local DarkEssence = GetSpellInfo(67176)

function mod:SPELL_CAST_START(args)
	if args.spellId == 67206 then 		-- Light Vortex
		local debuff = UnitDebuff("player", LightEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 67192 then	-- Dark Vortex
		local debuff = UnitDebuff("player", DarkEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 67303 then 	-- Dark Pact
		local debuff = true
		self:SpecialAbility(debuff)
	elseif args.spellId == 67306 then	-- Light Pact
		local debuff = true
		self:SpecialAbility(debuff)
	end
end

function mod:SpecialAbility(debuff)
	if not debuff then
		specWarnSpecial:Show()
	end
	timerSpecial:Start()
	warnSpecial:Schedule(40)
end
