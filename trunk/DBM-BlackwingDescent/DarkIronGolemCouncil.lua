local mod	= DBM:NewMod("DarkIronGolemCouncil", "DBM-BlackwingDescent", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42180, 42178, 42179, 42166)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnActivated		= mod:NewTargetAnnounce(78740, 3)
local warnIncineration		= mod:NewSpellAnnounce(79023, 2)
local warnAcquiringTarget	= mod:NewTargetAnnounce(79501, 3)
local warnBarrier		= mod:NewSpellAnnounce(79582, 4)
local warnConductor		= mod:NewTargetAnnounce(79888, 3)
local warnUnstableShield	= mod:NewSpellAnnounce(79900, 4)
local warnPoisonProtocol	= mod:NewSpellAnnounce(80053, 2)
local warnChemicalBomb		= mod:NewSpellAnnounce(80157, 3)
local warnShell			= mod:NewSpellAnnounce(79835, 4)
local warnGenerator		= mod:NewSpellAnnounce(79624, 3)
local warnConversion		= mod:NewSpellAnnounce(79729, 4)

local timerAcquiringTarget	= mod:NewNextTimer(40, 79501)
local timerBarrier		= mod:NewBuffActiveTimer(11.5, 79582)	-- 10 + 1.5 cast time
local timerBarrierCD		= mod:NewNextTimer(50, 79582)
local timerConductor		= mod:NewTargetTimer(10, 79888)
local timerConductorCD		= mod:NewNextTimer(25, 79888)
local timerUnstableShield	= mod:NewBuffActiveTimer(11.5, 79900)	-- 10 + 1.5 cast time
local timerUnstableShieldCD	= mod:NewNextTimer(50, 79900)
local timerChemicalBomb		= mod:NewNextTimer(30, 80157)
local timerShell		= mod:NewBuffActiveTimer(11.5, 79835)	-- 10 + 1.5 cast time
local timerShellCD		= mod:NewNextTimer(50, 79835)
local timerSoaked		= mod:NewTargetTimer(30, 80011, nil, false)
local timerGenerator		= mod:NewNextTimer(30, 79624)
local timerConversion		= mod:NewBuffActiveTimer(11.5, 79729)	-- 10 + 1.5 cast time
local timerConversionCD		= mod:NewNextTimer(50, 79729)

local specWarnBarrier		= mod:NewSpecialWarningCast(79582)
local specWarnConductor		= mod:NewSpecialWarningYou(79888)
local specWarnUnstableShield	= mod:NewSpecialWarningCast(79900)
local specWarnShell		= mod:NewSpecialWarningCast(79835)
local specWarnConversion	= mod:NewSpecialWarningCast(79729)

mod:AddBoolOption("SayBombTarget", true)

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
		timerGenerator:Start(11)
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
		DBM.BossHealth:RemoveBoss(42180)
	elseif boss == L.Arcanotron then
		timerGenerator:Cancel()
		timerConversionCD:Cancel()
		DBM.BossHealth:RemoveBoss(42166)
	end
end

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78740) then
		warnActivated:Show(args.destName)
		bossActivate(args.destName)
	elseif args:IsSpellID(78726) then
		bossInactive(args.destName)
	elseif args:IsSpellID(79501) then
		warnAcquiringTarget:Show(args.destName)
		timerAcquiringTarget:Start()
		self:SetIcon(args.destName, 8, 6)
	elseif args:IsSpellID(79888) then
		warnConductor:Show(args.destName)
		timerConductor:Start(args.destName)
		timerConductorCD:Start()
		self:SetIcon(args.destName, 7, 10)
		if args:IsPlayer() then
			specWarnConductor:Show()
		end
	elseif args:IsSpellID(80094) then
		if args:IsPlayer() and mod.options.SayBombTarget then
			SendChatMessage(L.SayBomb, "SAY")
		end
		self:SetIcon(args.destName, 6, 6)
	elseif args:IsSpellID(80011) then
		timerSoaked:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(80011) then
		timerSoaked:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(79023) then
		warnIncineration:Show()
	elseif args:IsSpellID(79582) then
		warnBarrier:Show()
		timerBarrier:Start()
		timerBarrierCD:Start()
		if self:GetUnitCreatureId("target") == 42178 then
			specWarnBarrier:Show()
		end
	elseif args:IsSpellID(79900) then
		warnUnstableShield:Show()
		timerUnstableShield:Start()
		timerUnstableShieldCD:Start()
		if self:GetUnitCreatureId("target") == 42179 then
			specWarnUnstableShield:Show()
		end
	elseif args:IsSpellID(79835) then
		warnShell:Show()
		timerShell:Start()
		timerShellCD:Start()
		if self:GetUnitCreatureId("target") == 42180 then
			specWarnShell:Show()
		end
	elseif args:IsSpellID(79729) then
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
	elseif args:IsSpellID(80053) then
		warnPoisonProtocol:Show()
	elseif args:IsSpellID(79624) then
		warnGenerator:Show()
		timerGenerator:Start()
	end
end