local mod = DBM:NewMod("Twins", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34497, 34496)  
mod:SetMinCombatTime(30)

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

local enrageTimer			= mod:NewEnrageTimer(360)

local warnSpecial			= mod:NewAnnounce("WarnSpecialSpellSoon", 2)	
local timerSpecial			= mod:NewTimer(45, "TimerSpecialSpell")
local specWarnSpecial		= mod:NewSpecialWarning("SpecWarnSpecial")


local timerHeal						= mod:NewCastTimer(15, 65875)
local specWarnEmpoweredDarkness		= mod:NewSpecialWarning("SpecWarnEmpoweredDarkness")
local specWarnEmpoweredLight		= mod:NewSpecialWarning("SpecWarnEmpoweredLight")
local timerAchieve					= mod:NewAchievementTimer(180, 3815, "TimerSpeedKill")

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start(-delay)
end

local LightEssence = GetSpellInfo(67223)
local DarkEssence = GetSpellInfo(67176)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66046, 67206, 67207, 67208) then 			-- Light Vortex
		local debuff = UnitDebuff("player", LightEssence)
		self:SpecialAbility(debuff)
	elseif args:IsSpellID(66058, 67182, 67183, 67184) then		-- Dark Vortex
		local debuff = UnitDebuff("player", DarkEssence)
		self:SpecialAbility(debuff)
	elseif args:IsSpellID(65875, 67303, 67304, 67305) then 		-- Twin's Pact
		timerHeal:Start()
		local debuff = true
		self:SpecialAbility(debuff)
	elseif args:IsSpellID(65876, 67306, 67307, 67308) then		-- Light Pact
		timerHeal:Start()
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

function mod:SPELL_AURA_APPLIED(args)	-- don't think this is really needed
	if args:IsSpellID(65724, 67213, 67214, 67215) and args:IsPlayer() then 		-- Empowered Darkness
		specWarnEmpoweredDarkness:Show()
	elseif args:IsSpellID(65748, 67216, 67217, 67218) and args:IsPlayer() then	-- Empowered Light
		specWarnEmpoweredLight:Show()
	end
end

