local mod	= DBM:NewMod("ValkTwins", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34497, 34496)  
mod:SetMinCombatTime(30)
mod:SetUsedIcons(5, 6, 7, 8)

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

local warnSpecial					= mod:NewAnnounce("WarnSpecialSpellSoon", 2)
local warnTouchDebuff				= mod:NewAnnounce("WarningTouchDebuff", 2, 66823)
local warnPoweroftheTwins			= mod:NewAnnounce("WarningPoweroftheTwins", 4)		
local specWarnSpecial				= mod:NewSpecialWarning("SpecWarnSpecial")
local specWarnSwitch				= mod:NewSpecialWarning("SpecWarnSwitchTarget")
local specWarnKickNow 				= mod:NewSpecialWarning("SpecWarnKickNow")
local specWarnPoweroftheTwins		= mod:NewSpecialWarning("SpecWarnPoweroftheTwins")
local specWarnEmpoweredDarkness		= mod:NewSpecialWarningYou(67215)
local specWarnEmpoweredLight		= mod:NewSpecialWarningYou(67218)

local enrageTimer					= mod:NewBerserkTimer(360)
local timerSpecial					= mod:NewTimer(45, "TimerSpecialSpell")
local timerHeal						= mod:NewCastTimer(15, 65875)
local timerLightTouch				= mod:NewTargetTimer(20, 67298)
local timerDarkTouch				= mod:NewTargetTimer(20, 67283)
local timerAchieve					= mod:NewAchievementTimer(180, 3815, "TimerSpeedKill")

mod:AddBoolOption("SpecialWarnOnDebuff", false, "announce")
mod:AddBoolOption("SetIconOnDebuffTarget", true)


local debuffTargets					= {}
local debuffIcon					= 8

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

local lightEssence = GetSpellInfo(67223)
local darkEssence = GetSpellInfo(67176)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66046, 67206, 67207, 67208) then 			-- Light Vortex
		local debuff = UnitDebuff("player", lightEssence)
		self:SpecialAbility(debuff)
	elseif args:IsSpellID(66058, 67182, 67183, 67184) then		-- Dark Vortex
		local debuff = UnitDebuff("player", darkEssence)
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

function mod:resetDebuff()
	debuffIcon = 8
end

function mod:warnDebuff()
	warnTouchDebuff:Show(table.concat(debuffTargets, "<, >"))
	table.wipe(debuffTargets)
	self:UnscheduleMethod("resetDebuff")
	self:ScheduleMethod(5, "resetDebuff")
end

local function showPowerWarning(self, cid)
	local target = self:GetBossTarget(cid)
	warnPoweroftheTwins:Show(target)
	if target == UnitName("player") then
		specWarnPoweroftheTwins:Show()
	end
end

local shieldValues = {
	[65874] = 175000,
	[65858] = 175000,
	[67257] = 300000,
	[67260] = 300000,
	[67256] = 700000,
	[67259] = 700000,
	[67261] = 1200000,
	[67258] = 1200000,
}
local showShieldHealthBar, hideShieldHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local shieldedMob
	local absorbRemaining = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(absorbRemaining / maxAbsorb * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if shieldedMob == destGUID then
			local absorbed
			if subEvent == "SWING_MISSED" then 
				absorbed = select( 2, ... ) 
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then 
				absorbed = select( 5, ... )
			end
			if absorbed then
				absorbRemaining = absorbRemaining - absorbed
			end
		end
	end)
	
	function showShieldHealthBar(self, mob, shieldName, absorb)
		shieldedMob = mob
		absorbRemaining = absorb
		maxAbsorb = absorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
		self:Schedule(15, hideShieldHealthBar)
	end
	
	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args:IsSpellID(65724, 67213, 67214, 67215) then 		-- Empowered Darkness
		specWarnEmpoweredDarkness:Show()
	elseif args:IsPlayer() and args:IsSpellID(65748, 67216, 67217, 67218) then	-- Empowered Light
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
		self:ScheduleMethod(0.75, "warnDebuff")
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
		self:ScheduleMethod(0.75, "warnDebuff")
	elseif args:IsSpellID(67246, 65879, 65916, 67244) or args:IsSpellID(67245, 67248, 67249, 67250) then	-- Power of the Twins 
		self:Schedule(0.1, showPowerWarning, self, args:GetDestCreatureID())
	elseif args:IsSpellID(65874, 67256, 67257, 67258) or args:IsSpellID(65858, 67259, 67260, 67261) then  -- Shield of Darkness/Lights
		showShieldHealthBar(self, args.destGUID, args.spellName, shieldValues[args.spellId] or 0)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(65874, 67256, 67257, 67258) then			-- Shield of Darkness
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34496 then
			specWarnKickNow:Show()
		end
		hideShieldHealthBar()
	elseif args:IsSpellID(65858, 67259, 67260, 67261) then		-- Shield of Lights
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34497 then
			specWarnKickNow:Show()
		end
		hideShieldHealthBar()
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