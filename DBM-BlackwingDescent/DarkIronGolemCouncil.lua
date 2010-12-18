local mod	= DBM:NewMod("DarkIronGolemCouncil", "DBM-BlackwingDescent", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42180, 42178, 42179, 42166)
mod:SetZone()
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnActivated			= mod:NewTargetAnnounce(78740, 3)
local warnIncineration		= mod:NewSpellAnnounce(79023, 2)
local warnBarrier			= mod:NewSpellAnnounce(79582, 4)
local warnUnstableShield	= mod:NewSpellAnnounce(79900, 4)
local warnPoisonProtocol	= mod:NewSpellAnnounce(80053, 2)
local warnFixate			= mod:NewTargetAnnounce(80094, 3)
local warnChemicalBomb		= mod:NewSpellAnnounce(80157, 3)
local warnShell				= mod:NewSpellAnnounce(79835, 4)
local warnGenerator			= mod:NewSpellAnnounce(79624, 3)
local warnConversion		= mod:NewSpellAnnounce(79729, 4)
local warnShadowInfusion	= mod:NewTargetAnnounce(92048, 4)--Heroic Ability

local timerAcquiringTarget	= mod:NewNextTimer(40, 79501)
local timerBarrier			= mod:NewBuffActiveTimer(11.5, 79582)	-- 10 + 1.5 cast time
local timerBarrierCD		= mod:NewNextTimer(50, 79582)
local timerConductor		= mod:NewTargetTimer(10, 79888)
local timerNextActivate		= mod:NewNextTimer(45, 78740)--Activations are every 90 seconds but encounter staggers them in an alternating fassion so 45 seconds between add switches
local timerConductorCD		= mod:NewNextTimer(25, 79888)
local timerUnstableShield	= mod:NewBuffActiveTimer(11.5, 79900)	-- 10 + 1.5 cast time
local timerUnstableShieldCD	= mod:NewNextTimer(50, 79900)
local timerChemicalBomb		= mod:NewNextTimer(30, 80157)
local timerShell			= mod:NewBuffActiveTimer(11.5, 79835)	-- 10 + 1.5 cast time
local timerShellCD			= mod:NewNextTimer(50, 79835)
local timerSoaked			= mod:NewTargetTimer(30, 80011, nil, false)
local timerGeneratorCD		= mod:NewNextTimer(30, 79624)
local timerConversion		= mod:NewBuffActiveTimer(11.5, 79729)	-- 10 + 1.5 cast time
local timerConversionCD		= mod:NewNextTimer(50, 79729)
local timerPoisonProtocolCD	= mod:NewNextTimer(45, 80053)
local timerShadowInfusionCD	= mod:NewNextTimer(35, 92048)

local specWarnBarrier		= mod:NewSpecialWarningCast(79582)
local specWarnConductor		= mod:NewSpecialWarningYou(79888)
local specWarnUnstableShield= mod:NewSpecialWarningCast(79900)
local specWarnGenerator		= mod:NewSpecialWarningMove(79624, mod:IsTank())
local specWarnShell			= mod:NewSpecialWarningCast(79835)
local specWarnConversion	= mod:NewSpecialWarningCast(79729)
local specWarnShadowInfusion= mod:NewSpecialWarningYou(92048)

mod:AddBoolOption("SayBombTarget", false)
mod:AddBoolOption("AcquiringTargetIcon")
mod:AddBoolOption("ConductorIcon")
mod:AddBoolOption("BombTargetIcon")
mod:AddBoolOption("ShadowInfusionIcon")

local fixateIcon = 6

local bossActivate = function(boss)
	if boss == L.Magmatron then
		timerAcquiringTarget:Start(20)
		timerBarrierCD:Start()
		DBM.BossHealth:AddBoss(42178, L.Magmatron)
	elseif boss == L.Electron then
		timerConductorCD:Start(11)
		timerUnstableShieldCD:Start()
		DBM.BossHealth:AddBoss(42179, L.Electron)
	elseif boss == L.Toxitron then
		timerChemicalBomb:Start(10)
		timerShellCD:Start()
		DBM.BossHealth:AddBoss(42180, L.Toxitron)
	elseif boss == L.Arcanotron then
		timerGeneratorCD:Start(11)
		timerConversionCD:Start(50)
		DBM.BossHealth:AddBoss(42166, L.Arcanotron)
	end
end

local bossInactive = function(boss)
	if boss == L.Magmatron then
		timerAcquiringTarget:Cancel()
		timerBarrierCD:Cancel()
		DBM.BossHealth:RemoveBoss(42178)
	elseif boss == L.Electron then
		timerConductorCD:Cancel()
		timerUnstableShieldCD:Cancel()
		DBM.BossHealth:RemoveBoss(42179)
	elseif boss == L.Toxitron then
		timerChemicalBomb:Cancel()
		timerShellCD:Cancel()
		timerPoisonProtocolCD:Cancel()
		DBM.BossHealth:RemoveBoss(42180)
	elseif boss == L.Arcanotron then
		timerGeneratorCD:Cancel()
		timerConversionCD:Cancel()
		DBM.BossHealth:RemoveBoss(42166)
	end
end

function mod:OnCombatStart(delay)
	fixateIcon = 6
	timerNextActivate:Start(-delay)
end

--Most of spelids for 25 man, and heroics are drycoded in this mod.
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78740, 95016, 95017, 95018) then
		warnActivated:Show(args.destName)
		timerNextActivate:Start()
		bossActivate(args.destName)
	elseif args:IsSpellID(78726) then
		bossInactive(args.destName)
	elseif args:IsSpellID(79501, 92035, 92036, 92037) then
		timerAcquiringTarget:Start()
		if self.Options.AcquiringTargetIcon then
			self:SetIcon(args.destName, 8, 6)
		end
	elseif args:IsSpellID(79888, 91431, 91432, 91433) then
		timerConductorCD:Start()
		if self.Options.ConductorIcon then
			self:SetIcon(args.destName, 7)
		end
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerConductor:Start(15, args.destName)--15 seconds on heroic?
		else
			timerConductor:Start(args.destName)
		end
		if args:IsPlayer() then
			specWarnConductor:Show()
		end
	elseif args:IsSpellID(80094) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() and self.Options.SayBombTarget then
			SendChatMessage(L.SayBomb, "SAY")
		end
		if self.Options.BombTargetIcon then
			if fixateIcon < 4 then--3 oozes spawn within 2-3 seconds of eachother
				fixateIcon = 6--lets make sure all 3 get unique icons, then reset for next time.
			end
			self:SetIcon(args.destName, fixateIcon, 6)
			fixateIcon = fixateIcon - 1
		end
	elseif args:IsSpellID(80011, 91504, 91505, 91506) then
		timerSoaked:Start(args.destName)
	elseif args:IsSpellID(79629, 91555, 91556, 91557) and args:GetDestCreatureID() == 42166 then--Check if Generator buff is gained by Arcanotron
		if self:GetUnitCreatureId("target") == 42166 then--Make sure to only warn person tanking it. (other tank would be targeting a different golem)
			specWarnGenerator:Show()--Show special warning to move him out of it.
		end
	elseif args:IsSpellID(92048) then
		warnShadowInfusion:Show(args.destName)
		timerShadowInfusionCD:Start()
		if args:IsPlayer() then
			specWarnShadowInfusion:Show()
		end
		if self.Options.ShadowInfusionIcon then
			self:SetIcon(args.destName, 3)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(80011, 91504, 91505, 91506) then
		timerSoaked:Cancel(args.destName)
	elseif args:IsSpellID(79888, 91431, 91432, 91433) then
		if self.Options.ConductorIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92048) then
		if self.Options.ShadowInfusionIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(79023, 91519, 91520, 91521) then
		warnIncineration:Show()
	elseif args:IsSpellID(79582, 91516, 91517, 91518) then
		warnBarrier:Show()
		timerBarrier:Start()
		timerBarrierCD:Start()
		if self:GetUnitCreatureId("target") == 42178 then
			specWarnBarrier:Show()
		end
	elseif args:IsSpellID(79900, 91447, 91448, 91449) then
		warnUnstableShield:Show()
		timerUnstableShield:Start()
		timerUnstableShieldCD:Start()
		if self:GetUnitCreatureId("target") == 42179 then
			specWarnUnstableShield:Show()
		end
	elseif args:IsSpellID(79835, 91501, 91502, 91503) then
		warnShell:Show()
		timerShell:Start()
		timerShellCD:Start()
		if self:GetUnitCreatureId("target") == 42180 then
			specWarnShell:Show()
		end
	elseif args:IsSpellID(79729, 91543, 91544, 91545) then
		warnConversion:Show()
		timerConversion:Start()
		timerConversionCD:Start()
		if self:GetUnitCreatureId("target") == 42166 then
			specWarnConversion:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(80157) then
		warnChemicalBomb:Show()
		timerChemicalBomb:Start()
	elseif args:IsSpellID(80053, 91513, 91514, 91515) then
		warnPoisonProtocol:Show()
		timerPoisonProtocolCD:Start()
	elseif args:IsSpellID(79624) then--Need more logs to determin if this is only actual cast id
		warnGenerator:Show()
		timerGeneratorCD:Start()
	end
end