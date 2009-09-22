local mod = DBM:NewMod("Twins", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34497, 34496)  
mod:SetMinCombatTime(30)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
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
local specWarnSwitch		= mod:NewSpecialWarning("SpecWarnSwitchTarget")
local specWarnKickNow 		= mod:NewSpecialWarning("SpecWarnKickNow")


local timerHeal						= mod:NewCastTimer(15, 65875)
local specWarnEmpoweredDarkness		= mod:NewSpecialWarning("SpecWarnEmpoweredDarkness")
local specWarnEmpoweredLight		= mod:NewSpecialWarning("SpecWarnEmpoweredLight")
local timerLightTouch				= mod:NewTargetTimer(20, 67298)
local timerDarkTouch				= mod:NewTargetTimer(20, 67283)
local warnTouchDebuff				= mod:NewAnnounce("WarningTouchDebuff", 2, 66823)
local timerAchieve					= mod:NewAchievementTimer(180, 3815, "TimerSpeedKill")

mod:AddBoolOption("SetIconOnDebuffTarget", true, "announce")
mod:AddBoolOption("SpecialWarnOnDebuff", true, "announce")


local debuffTargets = {}
local debuffIcon = 8

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	timerAchieve:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		enrageTimer:Start(360-delay)
	else
		enrageTimer:Start(480-delay)
	end
	debuffIcon = 8
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
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34497 then	-- if lightbane, then switch to darkbane
			specWarnSwitch:Show()	
		end
	elseif args:IsSpellID(65876, 67306, 67307, 67308) then		-- Light Pact
		timerHeal:Start()
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34496 then	-- if darkbane, then switch to lightbane
			specWarnSwitch:Show()
		end
	end
end

function mod:SpecialAbility(debuff)
	if not debuff then
		specWarnSpecial:Show()
	end
	timerSpecial:Start()
	warnSpecial:Schedule(40)
end


function mod:warnDebuff()
	warnTouchDebuff:Show(table.concat(debuffTargets, "<, >"))
	table.wipe(debuffTargets)
	debuffIcon = 8
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(65724, 67213, 67214, 67215) and args:IsPlayer() then 		-- Empowered Darkness
		specWarnEmpoweredDarkness:Show()
	elseif args:IsSpellID(65748, 67216, 67217, 67218) and args:IsPlayer() then	-- Empowered Light
		specWarnEmpoweredLight:Show()
	elseif args:IsSpellID(65950, 67296, 67297, 67298) then	-- Touch of Light
		if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
			specWarnSpecial:Show()
		end
		timerLightTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, debuffIcon, 15)
			debuffIcon = debuffIcon - 1
		end
		debuffTargets[#debuffTargets + 1] = args.destName
		self:UnscheduleMethod("warnDebuff")
		self:ScheduleMethod(0.2, "warnDebuff")		
	elseif args:IsSpellID(66001, 67281, 67282, 67283) then	-- Touch of Darkness
		if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
			specWarnSpecial:Show()
		end
		timerDarkTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, debuffIcon)
			debuffIcon = debuffIcon - 1
		end
		debuffTargets[#debuffTargets + 1] = args.destName
		self:UnscheduleMethod("warnDebuff")
		self:ScheduleMethod(0.2, "warnDebuff")		
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(65874, 67256, 67257, 67258) and (UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34496) then			-- Shield of Darkness
		specWarnKickNow:Show()
	elseif args:IsSpellID(65858, 67259, 67260, 67261) and (UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34497) then		-- Shield of Lights
		specWarnKickNow:Show()
	elseif args:IsSpellID(65950, 67296, 67297, 67298) then	-- Touch of Light
		timerLightTouch:Stop(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(66001, 67281, 67282, 67283) then	-- Touch of Darkness
		timerDarkTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end




