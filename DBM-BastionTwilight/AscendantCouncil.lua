local mod	= DBM:NewMod("AscendantCouncil", "DBM-BastionTwilight", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43686, 43687, 43688, 43689, 43735)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

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
local warnGlaciate			= mod:NewSpellAnnounce(82746, 3)
local warnHeartIce			= mod:NewTargetAnnounce(82665, 3)
local warnWaterBomb			= mod:NewSpellAnnounce(82699, 3)
local warnFrozen			= mod:NewTargetAnnounce(82772, 3)
local warnFrostBeacon		= mod:NewTargetAnnounce(92307, 4)--Heroic
--Ignacious
local warnFlameTorrent		= mod:NewSpellAnnounce(82777, 2, nil, mod:IsTank() or mod:IsHealer())--Not too useful to announce but will leave for now. CD timer useless.
local warnBurningBlood		= mod:NewTargetAnnounce(82660, 3)
local warnAegisFlame		= mod:NewSpellAnnounce(82631, 4)
local warnRisingFlames		= mod:NewSpellAnnounce(82636, 4)
--Terrastra
local warnEruption			= mod:NewSpellAnnounce(83675, 2, nil, mod:IsMelee())
local warnHardenSkin		= mod:NewSpellAnnounce(83718, 3)
local warnQuakeSoon			= mod:NewPreWarnAnnounce(83565, 10, 3)
local warnQuake				= mod:NewSpellAnnounce(83565, 4)
local warnGravityCore		= mod:NewTargetAnnounce(92075, 4)--Heroic
--Arion
local warnLightningRod		= mod:NewTargetAnnounce(83099, 3)
local warnDisperse			= mod:NewSpellAnnounce(83087, 3)
local warnChainLightning	= mod:NewSpellAnnounce(83300, 2)
local warnLightningBlast	= mod:NewCastAnnounce(83070, 3)
local warnThundershockSoon	= mod:NewPreWarnAnnounce(83067, 10, 3)
local warnThundershock		= mod:NewSpellAnnounce(83067, 4)
local warnStaticOverload	= mod:NewTargetAnnounce(92067, 4)--Heroic
--Elementium Monstrosity
local warnLavaSeed			= mod:NewSpellAnnounce(84913, 4)
local warnGravityCrush		= mod:NewTargetAnnounce(84948, 3)

--Feludius
local timerGlaciate			= mod:NewCDTimer(33, 82746)--33-35 seconds
local timerHeartIce			= mod:NewTargetTimer(60, 82665)
local timerHeartIceCD		= mod:NewCDTimer(22, 82665)--22-24 seconds
local timerWaterBomb		= mod:NewCDTimer(33, 82699)--33-35 seconds
local timerFrozen			= mod:NewTargetTimer(10, 82772)
--Ignacious
local timerBurningBlood		= mod:NewTargetTimer(60, 82660)
local timerBurningBloodCD	= mod:NewCDTimer(22, 82660)--22-33 seconds, even worth having a timer?
local timerRisingFlames		= mod:NewCDTimer(62, 82636)
--Terrastra
local timerHardenSkinCD		= mod:NewCDTimer(42, 83718)--This one is iffy, it isn't as consistent as other ability timers
local timerEruptionCD		= mod:NewNextTimer(15, 83675, nil, mod:IsMelee())
local timerQuakeCD			= mod:NewNextTimer(70, 83565)
local timerQuakeCast		= mod:NewCastTimer(3, 83565)
--Arion
local timerLightningRod		= mod:NewBuffActiveTimer(15, 83099)
local timerDisperse			= mod:NewCDTimer(30, 83087)
local timerLightningBlast	= mod:NewCastTimer(4, 83070)
local timerThundershockCD	= mod:NewNextTimer(70, 83067)
local timerThundershockCast	= mod:NewCastTimer(3, 83067)
--Elementium Monstrosity
local timerTransition		= mod:NewTimer(15, "timerTransition", 84918)
local timerLavaSeedCD		= mod:NewCDTimer(23, 84913)
local timerGravityCrush		= mod:NewBuffActiveTimer(10, 84948)
local timerGravityCrushCD	= mod:NewCDTimer(24, 84948)--24-28sec cd, decent varation

--Feludius
local specWarnWaterLogged	= mod:NewSpecialWarningYou(82762)
local specWarnHeartIce		= mod:NewSpecialWarningYou(82665)
local specWarnGlaciate		= mod:NewSpecialWarningRun(82746, mod:IsTank())
local specWarnHydroLance	= mod:NewSpecialWarningInterrupt(92509)
local specWarnRisingFlames	= mod:NewSpecialWarningInterrupt(82636)
local specWarnFrostBeacon	= mod:NewSpecialWarningYou(92307)--Heroic
--Ignacious
local specWarnBurningBlood	= mod:NewSpecialWarningYou(82660)
local specWarnAegisFlame	= mod:NewSpecialWarningSpell(82631)
--Terrastra
local specWarnSearingWinds	= mod:NewSpecialWarning("SpecWarnSearingWinds")
local specWarnGravityCore	= mod:NewSpecialWarningYou(92075)--Heroic
--Arion
local specWarnGrounded		= mod:NewSpecialWarning("SpecWarnGrounded")
local specWarnLightningRod	= mod:NewSpecialWarningYou(83099)
local specWarnStaticOverload= mod:NewSpecialWarningYou(92067)--Heroic
--All
local specWarnBossLow		= mod:NewSpecialWarning("specWarnBossLow")


local soundGlaciate			= mod:NewSound(82746, nil, mod:IsTank())

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("HeartIceIcon")
mod:AddBoolOption("BurningBloodIcon")
mod:AddBoolOption("LightningRodIcon")
mod:AddBoolOption("GravityCrushIcon")
mod:AddBoolOption("FrostBeaconIcon")
mod:AddBoolOption("StaticOverloadIcon")
mod:AddBoolOption("GravityCoreIcon")
mod:AddBoolOption("RangeFrame")

local frozenTargets = {}
local lightningRodTargets = {}
local gravityCrushTargets = {}
local lightningRodIcon = 8
local gravityCrushIcon = 8
local warnedLowHP = {}

local function showFrozenWarning()
	warnFrozen:Show(table.concat(frozenTargets, "<, >"))
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
end

local function checkSearingWinds()
	if not UnitDebuff("player", GetSpellInfo(83500)) and not UnitIsDeadOrGhost("player") then
		specWarnSearingWinds:Show()
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

function mod:OnCombatStart(delay)
	updateBossFrame(1)
	table.wipe(frozenTargets)
	table.wipe(lightningRodTargets)
	table.wipe(gravityCrushTargets)
	table.wipe(warnedLowHP)
	lightningRodIcon = 8
	gravityCrushIcon = 8
	timerGlaciate:Start(30-delay)
	timerWaterBomb:Start(15-delay)
	timerHeartIceCD:Start(18-delay)--could be just as flakey as it is in combat though.
	timerBurningBloodCD:Start(28-delay)--could be just as flakey as it is in combat though.
	timerRisingFlames:Start(33-delay)--33-35 seconds after pull
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82772, 92503, 92504, 92505) then--Some spellids drycoded
		timerFrozen:Start(args.destName)
		frozenTargets[#frozenTargets + 1] = args.destName
		self:Unschedule(showFrozenWarning)
		self:Schedule(0.3, showFrozenWarning)
	elseif args:IsSpellID(82665) then
		warnHeartIce:Show(args.destName)
		timerHeartIce:Start(args.destName)
		timerHeartIceCD:Start()
		if args:IsPlayer() then
			specWarnHeartIce:Show()
		end
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 6)
		end
	elseif args:IsSpellID(82660) then
		warnBurningBlood:Show(args.destName)
		timerBurningBlood:Start(args.destName)
		timerBurningBloodCD:Start()
		if args:IsPlayer() then
			specWarnBurningBlood:Show()
		end
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(83099) then
		lightningRodTargets[#lightningRodTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnLightningRod:Show()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, lightningRodIcon)
			lightningRodIcon = lightningRodIcon - 1
		end
		self:Unschedule(showLightningRodWarning)
		if (mod:IsDifficulty("normal25") and #lightningRodTargets >= 3) or (mod:IsDifficulty("normal10") and #lightningRodTargets >= 1) then
			showLightningRodWarning()
		else
			self:Schedule(0.3, showLightningRodWarning)
		end
	elseif args:IsSpellID(82777) then
		warnFlameTorrent:Show()
	elseif args:IsSpellID(82631, 92512, 92513, 92514) then--drycode
		warnAegisFlame:Show()
		specWarnAegisFlame:Show()
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
		if (mod:IsDifficulty("normal25") and #gravityCrushTargets >= 3) or (mod:IsDifficulty("normal10") and #gravityCrushTargets >= 1) then
			showGravityCrushWarning()
		else
			self:Schedule(0.3, showGravityCrushWarning)
		end
	elseif args:IsSpellID(92307) then
		warnFrostBeacon:Show(args.destName)
		if args:IsPlayer() then
			specWarnFrostBeacon:Show()
		end
		if self.Options.FrostBeaconIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(92067) then
		warnStaticOverload:Show(args.destName)
		if args:IsPlayer() then
			specWarnStaticOverload:Show()
		end
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 4)
		end
	elseif args:IsSpellID(92075) then
		warnGravityCore:Show(args.destName)
		if args:IsPlayer() then
			specWarnGravityCore:Show()
		end
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 5)
		end
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82772, 92503, 92504, 92505) then
		timerFrozen:Cancel(args.destName)
	elseif args:IsSpellID(82665) then
		timerHeartIce:Cancel(args.destName)
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(82660) then
		timerBurningBlood:Cancel(args.destName)
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(83099) then
		timerLightningRod:Cancel(args.destName)
		if args:IsPlayer() then
			if self.Options.RangeFrame and not (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
				DBM.RangeCheck:Hide()
			end
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
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 43686 then
			specWarnRisingFlames:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82746, 92506, 92507, 92508) then
		warnGlaciate:Show()
		timerGlaciate:Start()
		if self:GetUnitCreatureId("target") == 43687 then--Only warn tank targeting/tanking this boss.
			specWarnGlaciate:Show()
			soundGlaciate:Play()
		end
	elseif args:IsSpellID(82752, 92509, 92510, 92511) then
		if self:GetUnitCreatureId("target") == 43687 then--Only warn people on that boss to interrupt it, whole raid doesn't need to know.
			specWarnHydroLance:Show()
		end
	elseif args:IsSpellID(82699) then
		warnWaterBomb:Show()
		timerWaterBomb:Start()
	elseif args:IsSpellID(83675) then
		warnEruption:Show()
		timerEruptionCD:Start()
	elseif args:IsSpellID(83718, 92541, 92542, 92543) then
		warnHardenSkin:Show()
		timerHardenSkinCD:Start()
	elseif args:IsSpellID(83565, 92544, 92545, 92546) then
		warnQuake:Show()
		timerQuakeCD:Start()
		timerQuakeCast:Show()
	elseif args:IsSpellID(83087) then
		warnDisperse:Show()
		timerDisperse:Start()
	elseif args:IsSpellID(83070, 92454, 92455, 92456) then
		warnLightningBlast:Show()
		timerLightningBlast:Start()
	elseif args:IsSpellID(83067, 92469, 92470, 92470) then
		warnThundershock:Show()
		timerThundershockCast:Show()
		timerThundershockCD:Start()
	elseif args:IsSpellID(84913) then
		warnLavaSeed:Show()
		timerLavaSeedCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82636) then
		warnRisingFlames:Show()
		timerRisingFlames:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Switch or msg:find(L.Switch) then
		updateBossFrame(2)
		timerWaterBomb:Cancel()
		timerGlaciate:Cancel()
		timerRisingFlames:Cancel()
		timerBurningBloodCD:Cancel()
		timerHeartIceCD:Cancel()
		timerQuakeCD:Start(33)
		timerThundershockCD:Start()
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		updateBossFrame(3)
		timerQuakeCD:Cancel()
		timerThundershockCD:Cancel()
		timerHardenSkinCD:Cancel()
		timerEruptionCD:Cancel()
		timerDisperse:Cancel()
		timerTransition:Start()
		timerLavaSeedCD:Start(30)
		timerGravityCrushCD:Start(43)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Quake or msg:find(L.Quake) then
		checkSearingWinds()
		warnQuakeSoon:Show()
	elseif msg == L.Thundershock or msg:find(L.Thundershock) then
		checkGrounded()
		warnThundershockSoon:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	if (cid == 43686 or cid == 43687 or cid == 43688 or cid == 43689) and not warnedLowHP[cid] and UnitHealth(uId)/UnitHealthMax(uId) <= 0.30 then
		warnedLowHP[cid] = true
		specWarnBossLow:Show(UnitName(uId))
	end
end