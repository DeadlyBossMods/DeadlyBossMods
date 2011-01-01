local mod	= DBM:NewMod("DarkIronGolemCouncil", "DBM-BlackwingDescent", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42180, 42178, 42179, 42166)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

--Magmatron
local warnIncineration		= mod:NewSpellAnnounce(79023, 2)
local warnBarrier			= mod:NewSpellAnnounce(79582, 4)
--Electron
local warnUnstableShield	= mod:NewSpellAnnounce(79900, 4)
--Toxitron
local warnPoisonProtocol	= mod:NewSpellAnnounce(80053, 2)
local warnFixate			= mod:NewTargetAnnounce(80094, 3)
local warnChemicalBomb		= mod:NewSpellAnnounce(80157, 3)
local warnShell				= mod:NewSpellAnnounce(79835, 4)
--Arcanotron
local warnGenerator			= mod:NewSpellAnnounce(79624, 3)
local warnConversion		= mod:NewSpellAnnounce(79729, 4)
--All
local warnActivated			= mod:NewTargetAnnounce(78740, 3)
local warnShadowInfusion	= mod:NewTargetAnnounce(92048, 4)--Heroic Ability

--Magmatron
local timerAcquiringTarget	= mod:NewNextTimer(40, 79501)
local timerBarrier			= mod:NewBuffActiveTimer(11.5, 79582)	-- 10 + 1.5 cast time
local timerIncinerationCD   = mod:NewNextTimer(26.5, 79023)--Timer Series, 10, 27, 32 (on normal) from activate til shutdown.
--Electron
local timerConductor		= mod:NewTargetTimer(10, 79888)
local timerConductorCD		= mod:NewNextTimer(25, 79888)
local timerUnstableShield	= mod:NewBuffActiveTimer(11.5, 79900)	-- 10 + 1.5 cast time
--Toxitron
local timerChemicalBomb		= mod:NewNextTimer(30, 80157)--Timer Series, 11, 30, 36 (on normal) from activate til shutdown.
local timerShell			= mod:NewBuffActiveTimer(11.5, 79835)	-- 10 + 1.5 cast time
local timerPoisonProtocolCD	= mod:NewNextTimer(45, 80053)
local timerSoaked			= mod:NewTargetTimer(30, 80011, nil, false)
--Arcanotron
local timerGeneratorCD		= mod:NewNextTimer(30, 79624)
local timerConversion		= mod:NewBuffActiveTimer(11.5, 79729)	-- 10 + 1.5 cast time
--All
local timerNextActivate		= mod:NewNextTimer(45, 78740)--Activations are every 90 seconds but encounter staggers them in an alternating fassion so 45 seconds between add switches
local timerNefAbilityCD		= mod:NewNextTimer(35, 92048)

--Magmatron
local specWarnBarrier		= mod:NewSpecialWarningCast(79582)
--Electron
local specWarnUnstableShield= mod:NewSpecialWarningCast(79900)
local specWarnConductor		= mod:NewSpecialWarningYou(79888)
--Toxitron
local specWarnShell			= mod:NewSpecialWarningCast(79835)
local specWarnBombTarget	= mod:NewSpecialWarningRun(80094)
--Arcanotron
local specWarnConversion	= mod:NewSpecialWarningCast(79729)
local specWarnGenerator		= mod:NewSpecialWarningMove(79624, mod:IsTank())
--All
local specWarnShadowInfusion= mod:NewSpecialWarningYou(92048)

local soundBomb				= mod:NewSound(80094)
mod:AddBoolOption("SayBombTarget", false)
mod:AddBoolOption("AcquiringTargetIcon")
mod:AddBoolOption("ConductorIcon")
mod:AddBoolOption("BombTargetIcon")
mod:AddBoolOption("ShadowInfusionIcon")

local fixateIcon = 6

local bossActivate = function(boss)
	if boss == L.Magmatron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerAcquiringTarget:Start(17.5)--Submitted, needs confirmation.
			timerIncinerationCD:Start(10)--Submitted, needs confirmation.
		else
			timerAcquiringTarget:Start(20)
			timerIncinerationCD:Start(10)
		end
		DBM.BossHealth:AddBoss(42178, L.Magmatron)
	elseif boss == L.Electron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerConductorCD:Start(15)--Submitted, needs confirmation. Probably also has a variation if it's like normal.
		else
			timerConductorCD:Start(11)--11-15 variation confirmed for normal, only boss ability with an actual variation on timer. Strange.
		end
		DBM.BossHealth:AddBoss(42179, L.Electron)
	elseif boss == L.Toxitron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerChemicalBomb:Start(25)--Submitted, needs confirmation.
			timerPoisonProtocolCD:Start(12.5)--Submitted, needs confirmation.
		else
			timerChemicalBomb:Start(11)
			timerPoisonProtocolCD:Start(21)
		end
		DBM.BossHealth:AddBoss(42180, L.Toxitron)
	elseif boss == L.Arcanotron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerGeneratorCD:Start(12.5)--Submitted, needs confirmation.
		else
			timerGeneratorCD:Start(15)
		end
		DBM.BossHealth:AddBoss(42166, L.Arcanotron)
	end
end

local bossInactive = function(boss)
	if boss == L.Magmatron then
		timerAcquiringTarget:Cancel()
		timerIncinerationCD:Cancel()
		DBM.BossHealth:RemoveBoss(42178)
	elseif boss == L.Electron then
		timerConductorCD:Cancel()
		DBM.BossHealth:RemoveBoss(42179)
	elseif boss == L.Toxitron then
		timerChemicalBomb:Cancel()
		timerPoisonProtocolCD:Cancel()
		DBM.BossHealth:RemoveBoss(42180)
	elseif boss == L.Arcanotron then
		timerGeneratorCD:Cancel()
		DBM.BossHealth:RemoveBoss(42166)
	end
end

function mod:OnCombatStart(delay)
	fixateIcon = 6
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerNextActivate:Start(25-delay)--Submitted, needs confirmation.
	else
		timerNextActivate:Start(-delay)
	end
end

--Most of spelids for 25 man, and heroics are drycoded in this mod.
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78740, 95016, 95017, 95018) then
		warnActivated:Show(args.destName)
		bossActivate(args.destName)
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerNextActivate:Start(25)--Submitted, needs confirmation.
		else
			timerNextActivate:Start()
		end
	elseif args:IsSpellID(78726) then
		bossInactive(args.destName)
	elseif args:IsSpellID(79501, 92035, 92036, 92037) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerAcquiringTarget:Start(22.5)--Submitted, needs confirmation.
		else
			timerAcquiringTarget:Start()
		end
		if self.Options.AcquiringTargetIcon then
			self:SetIcon(args.destName, 8, 6)
		end
	elseif args:IsSpellID(79888, 91431, 91432, 91433) then
		if args:IsPlayer() then
			specWarnConductor:Show()
		end
		if self.Options.ConductorIcon then
			self:SetIcon(args.destName, 7)
		end
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerConductor:Start(15, args.destName)--Drycoded, 15 seconds on heroic?
			timerConductorCD:Start(20)--Submitted, needs confirmation.
		else
			timerConductor:Start(args.destName)
			timerConductorCD:Start()
		end
	elseif args:IsSpellID(80094) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnBombTarget:Show()
			soundBomb:Play()
			if self.Options.SayBombTarget then
				SendChatMessage(L.SayBomb, "SAY")
			end
		end
		if self.Options.BombTargetIcon then
			if fixateIcon < 1 then
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
		timerNefAbilityCD:Start()
		if args:IsPlayer() then
			specWarnShadowInfusion:Show()
		end
		if self.Options.ShadowInfusionIcon then
			self:SetIcon(args.destName, 8)
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
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerIncinerationCD:Start(22.5)--Submitted, needs confirmation.
		else
			timerIncinerationCD:Start()
		end
	elseif args:IsSpellID(79582, 91516, 91517, 91518) then
		warnBarrier:Show()
		timerBarrier:Start()
		if self:GetUnitCreatureId("target") == 42178 then
			specWarnBarrier:Show()
		end
	elseif args:IsSpellID(79900, 91447, 91448, 91449) then
		warnUnstableShield:Show()
		timerUnstableShield:Start()
		if self:GetUnitCreatureId("target") == 42179 then
			specWarnUnstableShield:Show()
		end
	elseif args:IsSpellID(79835, 91501, 91502, 91503) then
		warnShell:Show()
		timerShell:Start()
		if self:GetUnitCreatureId("target") == 42180 then
			specWarnShell:Show()
		end
	elseif args:IsSpellID(79729, 91543, 91544, 91545) then
		warnConversion:Show()
		timerConversion:Start()
		if self:GetUnitCreatureId("target") == 42166 then
			specWarnConversion:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(80157) then
		warnChemicalBomb:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerChemicalBomb:Start(30)--Submitted, needs confirmation.
		else
			timerChemicalBomb:Start()
		end
	elseif args:IsSpellID(80053, 91513, 91514, 91515) then
		warnPoisonProtocol:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerPoisonProtocolCD:Start(25)--Submitted, needs confirmation.
		else
			timerPoisonProtocolCD:Start()
		end
	elseif args:IsSpellID(79624) then
		warnGenerator:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerGeneratorCD:Start(17.5)--Submitted, needs confirmation.
		else
			timerGeneratorCD:Start()
		end
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
   if msg == L.NefCloud or msg == L.NefOvercharged then
        timerNefAbilityCD:Start()
   end
end--]]