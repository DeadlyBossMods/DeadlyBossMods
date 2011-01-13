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
	"SPELL_CAST_SUCCESS"
)

--Magmatron
local warnIncineration			= mod:NewSpellAnnounce(79023, 2)
local warnBarrier				= mod:NewSpellAnnounce(79582, 4)
local warnEncasingShadows		= mod:NewTargetAnnounce(92023, 4)--Heroic Ability
--Electron
local warnUnstableShield		= mod:NewSpellAnnounce(79900, 4)
local warnShadowConductorCast	= mod:NewPreWarnAnnounce(92053, 5, 4)--Heroic Ability
--Toxitron
local warnPoisonProtocol		= mod:NewSpellAnnounce(80053, 2)
local warnFixate				= mod:NewTargetAnnounce(80094, 3, nil, false)--Spammy, off by default. Raid leader can turn it on if they wanna yell at these people.
local warnChemicalBomb			= mod:NewSpellAnnounce(80157, 3)
local warnShell					= mod:NewSpellAnnounce(79835, 4)
local warnGrip					= mod:NewCastAnnounce(91849, 4)--Heroic Ability
--Arcanotron
local warnGenerator				= mod:NewSpellAnnounce(79624, 3)
local warnConversion			= mod:NewSpellAnnounce(79729, 4)
local warnOverchargedGenerator	= mod:NewSpellAnnounce(91857, 4)--Heroic Ability
--All
local warnActivated				= mod:NewTargetAnnounce(78740, 3)

--Magmatron
local specWarnBarrier			= mod:NewSpecialWarningCast(79582)
local specWarnEncasingShadows	= mod:NewSpecialWarningTarget(92023, false)--Heroic Ability
--Electron
local specWarnUnstableShield	= mod:NewSpecialWarningCast(79900)
local specWarnConductor			= mod:NewSpecialWarningYou(79888)
local specWarnShadowConductor	= mod:NewSpecialWarningTarget(92053)--Heroic Ability
--Toxitron
local specWarnShell				= mod:NewSpecialWarningCast(79835)
local specWarnBombTarget		= mod:NewSpecialWarningRun(80094)
local specWarnGrip				= mod:NewSpecialWarningSpell(91849)--Heroic Ability
--Arcanotron
local specWarnConversion		= mod:NewSpecialWarningCast(79729)
local specWarnGenerator			= mod:NewSpecialWarningMove(79624, mod:IsTank())
local specWarnOvercharged		= mod:NewSpecialWarningSpell(91857, false)--Heroic Ability

--Magmatron
local timerAcquiringTarget		= mod:NewNextTimer(40, 79501)
local timerBarrier				= mod:NewBuffActiveTimer(11.5, 79582)	-- 10 + 1.5 cast time
local timerIncinerationCD   	= mod:NewNextTimer(26.5, 79023)--Timer Series, 10, 27, 32 (on normal) from activate til shutdown.
--Electron
local timerLightningConductor	= mod:NewTargetTimer(10, 79888)
local timerLightningConductorCD	= mod:NewNextTimer(25, 79888)
local timerUnstableShield		= mod:NewBuffActiveTimer(11.5, 79900)	-- 10 + 1.5 cast time
local timerShadowConductor		= mod:NewTargetTimer(10, 92053)--Heroic Ability
local timerShadowConductorCast	= mod:NewTimer(5, "timerShadowConductorCast", 92053)--Heroic Ability
--Toxitron
local timerChemicalBomb			= mod:NewNextTimer(30, 80157)--Timer Series, 11, 30, 36 (on normal) from activate til shutdown.
local timerShell				= mod:NewBuffActiveTimer(11.5, 79835)	-- 10 + 1.5 cast time
local timerPoisonProtocolCD		= mod:NewNextTimer(45, 80053)
local timerSoaked				= mod:NewTargetTimer(30, 80011, nil, false)
--Arcanotron
local timerGeneratorCD			= mod:NewNextTimer(30, 79624)
local timerConversion			= mod:NewBuffActiveTimer(11.5, 79729)	-- 10 + 1.5 cast time
local timerArcaneBlowback		= mod:NewTimer(8, "timerArcaneBlowbackCast", 91879)-- what happens after the overcharged power generator explodes. 8 seconds after overcharge cast.
--All
local timerNextActivate			= mod:NewNextTimer(45, 78740)--Activations are every 90 (60sec heroic) seconds but encounter staggers them in an alternating fassion so 45 (30 heroic) seconds between add switches
local timerNefAbilityCD			= mod:NewNextTimer(30, 92048)--Huge variation on this, but shortest CD i've observed is 30.

local berserkTimer				= mod:NewBerserkTimer(600)

local soundBomb					= mod:NewSound(80094)

mod:AddBoolOption("AcquiringTargetIcon")
mod:AddBoolOption("ConductorIcon")
mod:AddBoolOption("BombTargetIcon")
mod:AddBoolOption("ShadowConductorIcon")

local fixateIcon = 6

local bossActivate = function(boss)
	if boss == L.Magmatron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerAcquiringTarget:Start(20)--These appear same on heroic and non heroic but will leave like this for now to await 25 man heroic confirmation.
			timerIncinerationCD:Start(10)
		else
			timerAcquiringTarget:Start(20)
			timerIncinerationCD:Start(10)
		end
		DBM.BossHealth:AddBoss(42178, L.Magmatron)
	elseif boss == L.Electron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerLightningConductorCD:Start(15)--Probably also has a variation if it's like normal. Needs more logs to verify.
		else
			timerLightningConductorCD:Start(11)--11-15 variation confirmed for normal, only boss ability with an actual variation on timer. Strange.
		end
		DBM.BossHealth:AddBoss(42179, L.Electron)
	elseif boss == L.Toxitron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerChemicalBomb:Start(25)
			timerPoisonProtocolCD:Start(15)
		else
			timerChemicalBomb:Start(11)
			timerPoisonProtocolCD:Start(21)
		end
		DBM.BossHealth:AddBoss(42180, L.Toxitron)
	elseif boss == L.Arcanotron then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerGeneratorCD:Start(15)--These appear same on heroic and non heroic but will leave like this for now to await 25 man heroic confirmation.
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
		timerLightningConductorCD:Cancel()
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
		timerNextActivate:Start(30-delay)
		berserkTimer:Start(-delay)
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
			timerNextActivate:Start(30)
		else
			timerNextActivate:Start()
		end
	elseif args:IsSpellID(78726) then
		bossInactive(args.destName)
	elseif args:IsSpellID(79501, 92035, 92036, 92037) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerAcquiringTarget:Start(27)
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
			timerLightningConductor:Start(15, args.destName)
			timerLightningConductorCD:Start(20)
		else
			timerLightningConductor:Start(args.destName)
			timerLightningConductorCD:Start()
		end
	elseif args:IsSpellID(80094) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnBombTarget:Show()
			soundBomb:Play()
		end
		if self.Options.BombTargetIcon then
			if fixateIcon < 1 then
				fixateIcon = 6--lets make sure all get unique icons, then reset for next time.
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
	elseif args:IsSpellID(92048) then--Shadow Infusion, debuff 5 seconds before shadow conductor.
		warnShadowConductorCast:Show()
		timerShadowConductorCast:Start()
		timerNefAbilityCD:Start()
	elseif args:IsSpellID(92023) then
		warnEncasingShadows:Show(args.destName)
		specWarnEncasingShadows:Show(args.destName)
		timerNefAbilityCD:Start()
	elseif args:IsSpellID(92053) then
		specWarnShadowConductor:Show(args.destName)
		timerShadowConductor:Show(args.destName)
		if self.Options.ShadowConductorIcon then
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
	elseif args:IsSpellID(92053) then
		timerShadowConductor:Cancel(args.destName)
		if self.Options.ShadowConductorIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(79023, 91519, 91520, 91521) then
		warnIncineration:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerIncinerationCD:Start()--appears same on heroic
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
	elseif args:IsSpellID(91849) then--Grip
		warnGrip:Show()
		specWarnGrip:Show()
		timerNefAbilityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(80157) then
		warnChemicalBomb:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerChemicalBomb:Start()--Appears same on heroic
		else
			timerChemicalBomb:Start()
		end
	elseif args:IsSpellID(80053, 91513, 91514, 91515) then
		warnPoisonProtocol:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerPoisonProtocolCD:Start(25)
		else
			timerPoisonProtocolCD:Start()
		end
	elseif args:IsSpellID(79624) then
		warnGenerator:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerGeneratorCD:Start(20)
		else
			timerGeneratorCD:Start()
		end
	elseif args:IsSpellID(91857) then
		warnOverchargedGenerator:Show()
		specWarnOvercharged:Show()
		timerArcaneBlowback:Start()
		timerNefAbilityCD:Start()
	end
end
