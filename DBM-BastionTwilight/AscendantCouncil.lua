local mod	= DBM:NewMod("AscendantCouncil", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43686, 43687, 43688, 43689, 43735)
mod:SetModelID(35064)
mod:SetZone()
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

--Feludius
local warnHeartIce			= mod:NewTargetAnnounce(82665, 3, nil, false)
local warnGlaciate			= mod:NewSpellAnnounce(82746, 3, nil, mod:IsMelee())
local warnWaterBomb			= mod:NewSpellAnnounce(82699, 3)
local warnFrozen			= mod:NewTargetAnnounce(82772, 3, nil, mod:IsHealer())
--Ignacious
local warnBurningBlood		= mod:NewTargetAnnounce(82660, 3, nil, false)
local warnFlameTorrent		= mod:NewSpellAnnounce(82777, 2, nil, mod:IsTank() or mod:IsHealer())--Not too useful to announce but will leave for now. CD timer useless.
local warnAegisFlame		= mod:NewSpellAnnounce(82631, 4)
--Terrastra
local warnEruption			= mod:NewSpellAnnounce(83675, 2, nil, mod:IsMelee())
local warnHardenSkin		= mod:NewSpellAnnounce(83718, 3, nil, mod:IsTank())
local warnQuakeSoon			= mod:NewPreWarnAnnounce(83565, 10, 3)
local warnQuake				= mod:NewSpellAnnounce(83565, 4)
--Arion
local warnLightningRod		= mod:NewTargetAnnounce(83099, 3)
local warnDisperse			= mod:NewSpellAnnounce(83087, 3, nil, mod:IsTank())
local warnLightningBlast	= mod:NewCastAnnounce(83070, 3, nil, nil, mod:IsTank())
local warnThundershockSoon	= mod:NewPreWarnAnnounce(83067, 10, 3)
local warnThundershock		= mod:NewSpellAnnounce(83067, 4)
--Elementium Monstrosity
local warnLavaSeed			= mod:NewSpellAnnounce(84913, 4)
local warnGravityCrush		= mod:NewTargetAnnounce(84948, 3)
--Heroic
local warnGravityCore		= mod:NewTargetAnnounce(92075, 4)--Heroic Phase 1 ablity
local warnStaticOverload	= mod:NewTargetAnnounce(92067, 4)--Heroic Phase 1 ablity
local warnFlameStrike		= mod:NewCastAnnounce(92212, 3) --Heroic Phase 2 ablity
local warnFrostBeacon		= mod:NewTargetAnnounce(92307, 4)--Heroic Phase 2 ablity

--Feludius
local specWarnHeartIce		= mod:NewSpecialWarningYou(82665, false)
local specWarnGlaciate		= mod:NewSpecialWarningRun(82746, mod:IsMelee())
local specWarnWaterLogged	= mod:NewSpecialWarningYou(82762)
local specWarnHydroLance	= mod:NewSpecialWarningInterrupt(92509)
--Ignacious
local specWarnBurningBlood	= mod:NewSpecialWarningYou(82660, false)
local specWarnAegisFlame	= mod:NewSpecialWarningSpell(82631, nil, nil, nil, true)
local specWarnRisingFlames	= mod:NewSpecialWarningInterrupt(82636)
--Terrastra
local specWarnEruption		= mod:NewSpecialWarningSpell(83675, false)
local specWarnSearingWinds	= mod:NewSpecialWarning("SpecWarnSearingWinds")
local specWarnHardenedSkin	= mod:NewSpecialWarningInterrupt(83718, false)
--Arion
local specWarnGrounded		= mod:NewSpecialWarning("SpecWarnGrounded")
local specWarnLightningBlast= mod:NewSpecialWarningInterrupt(83070, false)
local specWarnLightningRod	= mod:NewSpecialWarningYou(83099)
local yellLightningRod		= mod:NewYell(83099)
--Heroic
local specWarnGravityCore	= mod:NewSpecialWarningYou(92075)--Heroic
local yellGravityCore		= mod:NewYell(92075)
local specWarnStaticOverload= mod:NewSpecialWarningYou(92067)--Heroic
local yellStaticOverload	= mod:NewYell(92067)
local specWarnFrostBeacon	= mod:NewSpecialWarningYou(92307)--Heroic
local yellFrostbeacon		= mod:NewYell(92307)
local yellScrewed			= mod:NewYell(92307, L.blizzHatesMe, true, "yellScrewed", "YELL")--Amusing but effective.

local specWarnBossLow		= mod:NewSpecialWarning("specWarnBossLow")

--Feludius
local timerHeartIce			= mod:NewTargetTimer(60, 82665, nil, false)
local timerHeartIceCD		= mod:NewCDTimer(22, 82665, nil, false)--22-24 seconds
local timerGlaciate			= mod:NewCDTimer(33, 82746, nil, mod:IsMelee())--33-35 seconds
local timerWaterBomb		= mod:NewCDTimer(33, 82699)--33-35 seconds
local timerFrozen			= mod:NewBuffActiveTimer(10, 82772, nil, mod:IsHealer())
local timerHydroLanceCD		= mod:NewCDTimer(12, 92509, nil, false)--12 second cd but lowest cast priority
--Ignacious
local timerBurningBlood		= mod:NewTargetTimer(60, 82660, nil, false)
local timerBurningBloodCD	= mod:NewCDTimer(22, 82660, nil, false)--22-33 seconds, even worth having a timer?
local timerAegisFlame		= mod:NewNextTimer(60, 82631)
--Terrastra
local timerEruptionCD		= mod:NewNextTimer(15, 83675, nil, mod:IsMelee())
local timerHardenSkinCD		= mod:NewCDTimer(42, 83718, nil, mod:IsMelee())--This one is iffy, it isn't as consistent as other ability timers
local timerQuakeCD			= mod:NewNextTimer(33, 83565)
local timerQuakeCast		= mod:NewCastTimer(3, 83565)
--Arion
local timerLightningRod		= mod:NewBuffActiveTimer(15, 83099)
local timerDisperse			= mod:NewCDTimer(30, 83087)
local timerLightningBlast	= mod:NewCastTimer(4, 83070, nil, false)
local timerThundershockCD	= mod:NewNextTimer(33, 83067)
local timerThundershockCast	= mod:NewCastTimer(3, 83067)
--Elementium Monstrosity
local timerTransition		= mod:NewTimer(15, "timerTransition", 84918)
local timerLavaSeedCD		= mod:NewCDTimer(23, 84913)
local timerGravityCrush		= mod:NewBuffActiveTimer(10, 84948)
local timerGravityCrushCD	= mod:NewCDTimer(24, 84948)--24-28sec cd, decent varation
--Heroic
local timerGravityCoreCD	= mod:NewNextTimer(20, 92075)--Heroic Phase 1 ablity
local timerStaticOverloadCD	= mod:NewNextTimer(20, 92067)--Heroic Phase 1 ablity
local timerFlameStrikeCD	= mod:NewNextTimer(20, 92212)--Heroic Phase 2 ablity
local timerFrostBeaconCD	= mod:NewNextTimer(20, 92307)--Heroic Phase 2 ablity

local soundGlaciate			= mod:NewSound(82746, nil, mod:IsTank())
local soundLightingRod		= mod:NewSound(83099)
local soundBeacon			= mod:NewSound(92307)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("HeartIceIcon")
mod:AddBoolOption("BurningBloodIcon")
mod:AddBoolOption("LightningRodIcon")
mod:AddBoolOption("GravityCrushIcon")
mod:AddBoolOption("FrostBeaconIcon")
mod:AddBoolOption("StaticOverloadIcon")
mod:AddBoolOption("GravityCoreIcon")
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("InfoFrame")

local frozenTargets = {}
local lightningRodTargets = {}
local gravityCrushTargets = {}
local lightningRodIcon = 8
local gravityCrushIcon = 8
local sendedLowHP = {}
local warnedLowHP = {}
local frozenCount = 0
local lastBeacon = 0
local isBeacon = false
local isRod = false
local infoFrameUpdated = false

local function showFrozenWarning()
	warnFrozen:Show(table.concat(frozenTargets, "<, >"))
	timerFrozen:Start()
	table.wipe(frozenTargets)
end

local function showLightningRodWarning()
	warnLightningRod:Show(table.concat(lightningRodTargets, "<, >"))
	timerLightningRod:Start()
	table.wipe(lightningRodTargets)
	lightningRodIcon = 8
end

local function showGravityCrushWarning()
	warnGravityCrush:Show(table.concat(gravityCrushTargets, "<, >"))
	timerGravityCrush:Start()
	table.wipe(gravityCrushTargets)
	gravityCrushIcon = 8
end

local function checkGrounded()
	if not UnitDebuff("player", GetSpellInfo(83581)) and not UnitIsDeadOrGhost("player") then
		specWarnGrounded:Show()
	end
	if self.Options.InfoFrame and not infoFrameUpdated then
		infoFrameUpdated = true
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(GetSpellInfo(83581)))
		DBM.InfoFrame:Show(5, "playerdebuff", 83581)
	end
end

local function checkSearingWinds()
	if not UnitDebuff("player", GetSpellInfo(83500)) and not UnitIsDeadOrGhost("player") then
		specWarnSearingWinds:Show()
	end
	if self.Options.InfoFrame and not infoFrameUpdated then
		infoFrameUpdated = true
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(GetSpellInfo(83500)))
		DBM.InfoFrame:Show(5, "playerdebuff", 83500)
	end
end

local updateBossFrame = function(phase)
	DBM.BossHealth:Clear()
	if phase == 1 then
		DBM.BossHealth:AddBoss(43687, L.Feludius)
		DBM.BossHealth:AddBoss(43686, L.Ignacious)
	elseif phase == 2 then
		DBM.BossHealth:AddBoss(43688, L.Arion)
		DBM.BossHealth:AddBoss(43689, L.Terrastra)
	elseif phase == 3 then
		DBM.BossHealth:AddBoss(43735, L.Monstrosity)
	end
end

-- copyied from twins.lua
local shieldValues = {
	[82631] = 500000,
	[92512] = 1500000,
	[92513] = 700000,
	[92514] = 2000000,
	[83718] = 500000,
	[92541] = 1650000,
	[92542] = 650000,
	[92543] = 2100000,
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
	local function handler(self, event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
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
	end
	-- TODO: this is the same workaround as in the DBM-Core handler for the same event, so this should be changed as soon as 4.2 is live
	if tonumber((select(4, GetBuildInfo()))) >= 40200 then
		frame:SetScript("OnEvent", function(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, mysteryArgument, destGUID, destName, destFlags, anotherMysteryArgument, ...)
			return handler(self, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		end)
	else
		frame:SetScript("OnEvent", handler)
	end
	
	function showShieldHealthBar(self, mob, shieldName, absorb)
		shieldedMob = mob
		absorbRemaining = absorb
		maxAbsorb = absorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
	end
	
	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

function mod:OnCombatStart(delay)
	updateBossFrame(1)
	table.wipe(frozenTargets)
	table.wipe(lightningRodTargets)
	table.wipe(gravityCrushTargets)
	table.wipe(sendedLowHP)
	table.wipe(warnedLowHP)
	lightningRodIcon = 8
	gravityCrushIcon = 8
	frozenCount = 0
	lastBeacon = 0
	isBeacon = false
	isRod = false
	infoFrameUpdated = false
	timerGlaciate:Start(30-delay)
	timerWaterBomb:Start(15-delay)
	timerHeartIceCD:Start(18-delay)--could be just as flakey as it is in combat though.
	timerBurningBloodCD:Start(28-delay)--could be just as flakey as it is in combat though.
	timerAegisFlame:Start(31-delay)
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerGravityCoreCD:Start(25-delay)
		timerStaticOverloadCD:Start(20-delay)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82772, 92503, 92504, 92505) then--Some spellids drycoded
		frozenCount = frozenCount + 1
		frozenTargets[#frozenTargets + 1] = args.destName
		self:Unschedule(showFrozenWarning)
		self:Schedule(0.3, showFrozenWarning)
	elseif args:IsSpellID(82665) then
		warnHeartIce:Show(args.destName)
		timerHeartIce:Start(args.destName)
		if args:IsPlayer() then
			specWarnHeartIce:Show()
		end
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 6)
		end
	elseif args:IsSpellID(82660) then
		warnBurningBlood:Show(args.destName)
		timerBurningBlood:Start(args.destName)
		if args:IsPlayer() then
			specWarnBurningBlood:Show()
		end
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(83099) then
		lightningRodTargets[#lightningRodTargets + 1] = args.destName
		if args:IsPlayer() then
			isRod = true
			specWarnLightningRod:Show()
			soundLightingRod:Play()
			if isBeacon then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have rod so do normal yell
				yellLightningRod:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, lightningRodIcon)
			lightningRodIcon = lightningRodIcon - 1
		end
		self:Unschedule(showLightningRodWarning)
		if (mod:IsDifficulty("normal25", "heroic25") and #lightningRodTargets >= 3) or (mod:IsDifficulty("normal10", "heroic10") and #lightningRodTargets >= 1) then
			showLightningRodWarning()
		else
			self:Schedule(0.3, showLightningRodWarning)
		end
	elseif args:IsSpellID(82777) then
		if self:GetUnitCreatureId("target") == 43686 or self:GetBossTarget(43686) == UnitName("target") then--Warn if the boss casting it is your target, OR your target is the person its being cast on.
			warnFlameTorrent:Show()
		end
	elseif args:IsSpellID(82631, 92512, 92513, 92514) then--Aegis of Flame
		local shieldname = GetSpellInfo(82631)
		warnAegisFlame:Show()
		specWarnAegisFlame:Show()
		showShieldHealthBar(self, args.destGUID, shieldname, shieldValues[args.spellId] or 0)
		self:Schedule(20, hideShieldHealthBar)
--[[	elseif args:IsSpellID(83718, 92541, 92542, 92543) then--Harden Skin (doesn't work, dumb thing doesn't use absorb events it tracks as damage done to boss, even though the boss isn't taking damage, shield is.
		local shieldname = GetSpellInfo(92543)
		showShieldHealthBar(self, args.destGUID, shieldname, shieldValues[args.spellId] or 0)
		self:Schedule(30, hideShieldHealthBar)--]]
	elseif args:IsSpellID(82762) and args:IsPlayer() then
		specWarnWaterLogged:Show()
	elseif args:IsSpellID(84948, 92486, 92487, 92488) then
		gravityCrushTargets[#gravityCrushTargets + 1] = args.destName
		timerGravityCrushCD:Start()
		if self.Options.GravityCrushIcon then
			self:SetIcon(args.destName, gravityCrushIcon)
			gravityCrushIcon = gravityCrushIcon - 1
		end
		self:Unschedule(showGravityCrushWarning)
		if (mod:IsDifficulty("normal25", "heroic25") and #gravityCrushTargets >= 3) or (mod:IsDifficulty("normal10", "heroic10") and #gravityCrushTargets >= 1) then
			showGravityCrushWarning()
		else
			self:Schedule(0.3, showGravityCrushWarning)
		end
	elseif args:IsSpellID(92307) then
		warnFrostBeacon:Show(args.destName)
		if args:IsPlayer() then
			isBeacon = true
			specWarnFrostBeacon:Show()
			soundBeacon:Play()
			if isRod then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have beacon so do normal yell
				yellFrostbeacon:Yell()
			end
		end
		if self.Options.FrostBeaconIcon then
			self:SetIcon(args.destName, 3)
		end
		if GetTime() - lastBeacon >= 18 then -- sometimes Frost Beacon change targets, show only new Frost orbs.
			timerFrostBeaconCD:Start()
			lastBeacon = GetTime()
		end
	elseif args:IsSpellID(92067) then--All other spell IDs are jump spellids, do not add them in or we'll have to scan source target and filter them.
		warnStaticOverload:Show(args.destName)
		timerStaticOverloadCD:Start()
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 4)
		end
		if args:IsPlayer() then
			specWarnStaticOverload:Show()
			yellStaticOverload:Yell()
		end
	elseif args:IsSpellID(92075) then
		warnGravityCore:Show(args.destName)
		timerGravityCoreCD:Start()
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 5)
		end
		if args:IsPlayer() then
			specWarnGravityCore:Show()
			yellGravityCore:Yell()
		end
	end
end

function mod:SPELL_AURA_REFRESH(args)--We do not combine refresh with applied cause it causes issues with burning blood/heart of ice.
	if args:IsSpellID(82772, 92503, 92504, 92505) then--Some spellids drycoded
		frozenCount = frozenCount + 1
		frozenTargets[#frozenTargets + 1] = args.destName
		self:Unschedule(showFrozenWarning)
		self:Schedule(0.3, showFrozenWarning)
	elseif args:IsSpellID(83099) then
		lightningRodTargets[#lightningRodTargets + 1] = args.destName
		if args:IsPlayer() then
			isRod = true
			specWarnLightningRod:Show()
			soundLightingRod:Play()
			if isBeacon then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have rod so do normal yell
				yellLightningRod:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, lightningRodIcon)
			lightningRodIcon = lightningRodIcon - 1
		end
		self:Unschedule(showLightningRodWarning)
		if (mod:IsDifficulty("normal25", "heroic25") and #lightningRodTargets >= 3) or (mod:IsDifficulty("normal10", "heroic10") and #lightningRodTargets >= 1) then
			showLightningRodWarning()
		else
			self:Schedule(0.3, showLightningRodWarning)
		end
	elseif args:IsSpellID(82762) and args:IsPlayer() then
		specWarnWaterLogged:Show()
	elseif args:IsSpellID(84948, 92486, 92487, 92488) then
		gravityCrushTargets[#gravityCrushTargets + 1] = args.destName
		timerGravityCrushCD:Start()
		if self.Options.GravityCrushIcon then
			self:SetIcon(args.destName, gravityCrushIcon)
			gravityCrushIcon = gravityCrushIcon - 1
		end
		self:Unschedule(showGravityCrushWarning)
		if (mod:IsDifficulty("normal25", "heroic25") and #gravityCrushTargets >= 3) or (mod:IsDifficulty("normal10", "heroic10") and #gravityCrushTargets >= 1) then
			showGravityCrushWarning()
		else
			self:Schedule(0.3, showGravityCrushWarning)
		end
	elseif args:IsSpellID(92307) then
		warnFrostBeacon:Show(args.destName)
		if args:IsPlayer() then
			isBeacon = true
			specWarnFrostBeacon:Show()
			soundBeacon:Play()
			if isRod then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have beacon so do normal yell
				yellFrostbeacon:Yell()
			end
		end
		if self.Options.FrostBeaconIcon then
			self:SetIcon(args.destName, 3)
		end
	elseif args:IsSpellID(92067) then--All other spell IDs are jump spellids, do not add them in or we'll have to scan source target and filter them.
		warnStaticOverload:Show(args.destName)
		timerStaticOverloadCD:Start()
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 4)
		end
		if args:IsPlayer() then
			specWarnStaticOverload:Show()
			yellStaticOverload:Yell()
		end
	elseif args:IsSpellID(92075) then
		warnGravityCore:Show(args.destName)
		timerGravityCoreCD:Start()
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 5)
		end
		if args:IsPlayer() then
			specWarnGravityCore:Show()
			yellGravityCore:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82665) then
		timerHeartIce:Cancel(args.destName)
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(82660) then
		timerBurningBlood:Cancel(args.destName)
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(82772, 92503, 92504, 92505) then
		frozenCount = frozenCount - 1
		if frozenCount == 0 then
			timerFrozen:Cancel()
		end
	elseif args:IsSpellID(83099) then
		timerLightningRod:Cancel(args.destName)
		if args:IsPlayer() then
			isRod = false
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(84948, 92486, 92487, 92488) then
		timerGravityCrush:Cancel(args.destName)
		if self.Options.GravityCrushIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92307) then
		if args:IsPlayer() then
			isBeacon = false
		end
		if self.Options.FrostBeacondIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92067) then
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92075) then
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(82631, 92512, 92513, 92514) then	-- Shield Removed
		self:Unschedule(hideShieldHealthBar)
		hideShieldHealthBar()
		if self:GetUnitCreatureId("target") == 43686 or self:GetUnitCreatureId("focus") == 43686 then
			specWarnRisingFlames:Show()
		end
--[[	elseif args:IsSpellID(83718, 92541, 92542, 92543) then--Harden Skin Removed
		self:Unschedule(hideShieldHealthBar)
		hideShieldHealthBar()-]]
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82746, 92506, 92507, 92508) then
		timerGlaciate:Start()
		if self:GetUnitCreatureId("target") == 43687 then--Only warn if targeting/tanking this boss.
			warnGlaciate:Show()
			specWarnGlaciate:Show()
			soundGlaciate:Play()
		end
	elseif args:IsSpellID(82752, 92509, 92510, 92511) then
		if self:GetUnitCreatureId("target") == 43687 or self:GetUnitCreatureId("focus") == 43687 then
			specWarnHydroLance:Show()
		end
		timerHydroLanceCD:Show()
	elseif args:IsSpellID(82699) then
		warnWaterBomb:Show()
		timerWaterBomb:Start()
	elseif args:IsSpellID(83675) then
		warnEruption:Show()
		specWarnEruption:Show()
		timerEruptionCD:Start()
	elseif args:IsSpellID(83718, 92541, 92542, 92543) then
		warnHardenSkin:Show()
		timerHardenSkinCD:Start()
		specWarnHardenedSkin:Show()
	elseif args:IsSpellID(83565, 92544, 92545, 92546) then
		infoFrameUpdated = false
		warnQuake:Show()
		timerQuakeCD:Cancel()
		timerQuakeCast:Start()
		timerThundershockCD:Start()
		self:Schedule(5, checkGrounded)
	elseif args:IsSpellID(83087) then
		warnDisperse:Show()
		timerDisperse:Start()
	elseif args:IsSpellID(83070, 92454, 92455, 92456) then
		warnLightningBlast:Show()
		timerLightningBlast:Start()
		specWarnLightningBlast:Show()
	elseif args:IsSpellID(83067, 92469, 92470, 92471) then
		infoFrameUpdated = false
		warnThundershock:Show()
		timerThundershockCD:Cancel()
		timerThundershockCast:Start()
		timerQuakeCD:Start()
		self:Schedule(5, checkSearingWinds)
	elseif args:IsSpellID(84913) then
		warnLavaSeed:Show()
		timerLavaSeedCD:Start()
	elseif args:IsSpellID(92212) then
		warnFlameStrike:Show()
		timerFlameStrikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82636) then
		timerAegisFlame:Start()
	elseif args:IsSpellID(82665) then
		timerHeartIceCD:Start()
	elseif args:IsSpellID(82660) then
		timerBurningBloodCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Switch or msg:find(L.Switch) then
		updateBossFrame(2)
		timerWaterBomb:Cancel()
		timerGlaciate:Cancel()
		timerAegisFlame:Cancel()
		timerBurningBloodCD:Cancel()
		timerHeartIceCD:Cancel()
		timerGravityCoreCD:Cancel()
		timerStaticOverloadCD:Cancel()
		timerHydroLanceCD:Cancel()
		if mod:IsDifficulty("heroic10", "heroic25") then
			timerFrostBeaconCD:Start(27)
			timerFlameStrikeCD:Start(30)
		end
		timerQuakeCD:Start()
		self:Schedule(5, checkSearingWinds)
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		updateBossFrame(3)
		timerQuakeCD:Cancel()
		timerThundershockCD:Cancel()
		timerHardenSkinCD:Cancel()
		timerEruptionCD:Cancel()
		timerDisperse:Cancel()
		timerTransition:Start()
		if mod:IsDifficulty("heroic10", "heroic25") then
			timerFlameStrikeCD:Cancel()
			self:Schedule(14, function() timerFrostBeaconCD:Cancel() end) -- Frost Beacon appears during phase transition, but not works. Anyway, to prevent spam, actually cancel timers when phase 3 starts.
		end
		timerLavaSeedCD:Start(30)
		timerGravityCrushCD:Start(43)
		self:Unschedule(checkSearingWinds)
		self:Unschedule(checkGrounded)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Quake or msg:find(L.Quake) then
		timerQuakeCD:Update(23, 33)
		warnQuakeSoon:Show()
		checkSearingWinds()
		if mod:IsDifficulty("heroic10", "heroic25") then
			self:Schedule(3.3, checkSearingWinds)
			self:Schedule(6.6, checkSearingWinds)
		end
	elseif msg == L.Thundershock or msg:find(L.Thundershock) then
		timerThundershockCD:Update(23, 33)
		warnThundershockSoon:Show()
		checkGrounded()
		if mod:IsDifficulty("heroic10", "heroic25") then
			self:Schedule(3.3, checkGrounded)
			self:Schedule(6.6, checkGrounded)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if (uId == "boss1" or uId == "boss2" or uId == "boss3" or uId == "boss4") and self:IsInCombat() then
		if UnitHealth(uId)/UnitHealthMax(uId) <= 0.30 then
			local cid = self:GetUnitCreatureId(uId)
			if (cid == 43686 or cid == 43687 or cid == 43688 or cid == 43689) and not sendedLowHP[cid] then
				sendedLowHP[cid] = true
				self:SendSync("lowhealth", UnitName(uId))
			end
		end
	end
end

function mod:OnSync(msg, boss)
	if msg == "lowhealth" and boss and not warnedLowHP[boss] then
		warnedLowHP[boss] = true
		specWarnBossLow:Show(boss)
	end
end
