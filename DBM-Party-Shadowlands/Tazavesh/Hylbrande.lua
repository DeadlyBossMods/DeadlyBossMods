local mod	= DBM:NewMod(2448, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175663)
mod:SetEncounterID(2426)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20220404000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 347094 346957 346766 358131 353312",
	"SPELL_CAST_SUCCESS 346116 181113",
	"SPELL_AURA_APPLIED 358131 346427",
	"SPELL_AURA_REMOVED 347958 353312 346766",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Are swings dogeable by tank?
local warnPurgedbyFire				= mod:NewSpellAnnounce(346959, 2)
local warnKeepersprotection			= mod:NewEndAnnounce(347958, 1)
local warnLightningNova				= mod:NewTargetNoFilterAnnounce(358131, 3)
local warnVaultPurifierSoon			= mod:NewSoonAnnounce("ej23004", 2, "136116", false)
local warnVaultPurifier				= mod:NewSpellAnnounce("ej23004", 2, "136116")
local warnPurifyingBurst			= mod:NewCountAnnounce(353312, 2)
local warnTitanicInsight			= mod:NewTargetNoFilterAnnounce(346427, 2)

local specWarnShearingSwings		= mod:NewSpecialWarningDefensive(346116, nil, nil, nil, 1, 2)
local specWarnTitanicCrash			= mod:NewSpecialWarningDodge(347094, nil, nil, nil, 2, 2)
local specWarnSanitizingCycle		= mod:NewSpecialWarningCount(346766, nil, nil, nil, 2, 2)
local specWarnLigtningNova			= mod:NewSpecialWarningInterrupt(358131, "HasInterrupt", nil, nil, 1, 2)--Hard Mode
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

local timerShearingSwingsCD			= mod:NewCDTimer(10.9, 346116, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerTitanicCrashCD			= mod:NewCDTimer(23.1, 347094, nil, nil, nil, 3)
local timerPurgedbyFireCD			= mod:NewCDTimer(17, 346959, nil, nil, nil, 3)
local timerSanitizingCycleCD		= mod:NewCDTimer(11, 346766, nil, nil, nil, 6)
local timerVaultPurifierCD			= mod:NewCDTimer(29.1, "ej23004", nil, nil, nil, 1, "136116", DBM_COMMON_L.DAMAGE_ICON)
local timerPurifyingBurstCD			= mod:NewCDTimer(23.1, 353312, nil, nil, nil, 2)
local timerTitanicInsight			= mod:NewTargetTimer(15, 346427, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnAdds", "ej23004", true, true, {1, 2})

mod.vb.cycleCount = 0
mod.vb.burstCount = 0
mod.vb.addIcon = 1

function mod:OnCombatStart(delay)
	self.vb.cycleCount = 0
	self.vb.burstCount = 0
	--TODO, hard mode check shit for purifying Burst (is it cast more often? or just more targets?)
	timerPurifyingBurstCD:Start(6-delay)
	timerShearingSwingsCD:Start(8.5-delay)
	timerPurgedbyFireCD:Start(12.1-delay)
	timerTitanicCrashCD:Start(15.8-delay)
	timerVaultPurifierCD:Start(22.3-delay)
	timerSanitizingCycleCD:Start(37.8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 347094 then
		specWarnTitanicCrash:Show()
		specWarnTitanicCrash:Play("shockwave")
		if timerSanitizingCycleCD:GetRemaining() >= 23.1 then
			timerTitanicCrashCD:Start()
		end
	elseif spellId == 346957 then
		warnPurgedbyFire:Show()
		if timerSanitizingCycleCD:GetRemaining() >= 17 then
			timerPurgedbyFireCD:Start()
		end
	elseif spellId == 346766 and self:AntiSpam(3, 1) then
		self.vb.cycleCount = self.vb.cycleCount + 1
		specWarnSanitizingCycle:Show(self.vb.cycleCount)
		specWarnSanitizingCycle:Play("specialsoon")
		timerShearingSwingsCD:Stop()
		timerTitanicCrashCD:Stop()
		timerPurgedbyFireCD:Stop()
		timerSanitizingCycleCD:Stop()
		timerVaultPurifierCD:Stop()
		timerPurifyingBurstCD:Stop()
	elseif spellId == 358131 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLigtningNova:Show(args.sourceName)
			specWarnLigtningNova:Play("kickcast")
		end
	elseif spellId == 353312 then
		self.vb.burstCount = self.vb.burstCount + 1
		warnPurifyingBurst:Show(self.vb.burstCount)
		if timerSanitizingCycleCD:GetRemaining() >= 23.1 then
			timerPurifyingBurstCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 346116 then
		if self:IsTanking("player", "boss1") then
			specWarnShearingSwings:Show()
			specWarnShearingSwings:Play("defensive")
		end
		if timerSanitizingCycleCD:GetRemaining() >= 10.9 then
			timerShearingSwingsCD:Start()
		end
	elseif spellId == 181113 then
		if self:AntiSpam(3, 2) then
			warnVaultPurifier:Show()
			if timerSanitizingCycleCD:GetRemaining() >= 29.1 then
				timerVaultPurifierCD:Start()
			end
		end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnAdds")
		end
		self.vb.addIcon = self.vb.addIcon + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 358131 then
		warnLightningNova:Show(args.destname)
	elseif spellId == 346427 then
		warnTitanicInsight:Show(args.destName)
		timerTitanicInsight:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 347958 then
		warnKeepersprotection:Show()
	elseif spellId == 346427 then
		timerTitanicInsight:Stop(args.destName)
	elseif spellId == 346766 and self:AntiSpam(3, 3) then
		self.vb.cycleCount = self.vb.cycleCount + 1
		--TODO, hard mode check shit for purifying Burst
		timerPurifyingBurstCD:Start(13.2)
		timerShearingSwingsCD:Start(15.6)
		timerPurgedbyFireCD:Start(19.3)
		timerTitanicCrashCD:Start(22.9)
		timerVaultPurifierCD:Start(23.4)
		timerSanitizingCycleCD:Start(68.1)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 176551 then--vault-purifier

	elseif cid == 180640 then--stormbound-breaker

	end
end
--]]

--"<18.17 01:11:30> [UNIT_SPELLCAST_SUCCEEDED] Hylbrande(??) -[DNT] Summon Vault Defender- [[boss1:Cast-3-4234-2441-16984-346971-002B48CA12:346971]]", -- [147]
--"<22.32 01:11:34> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4234-2441-16984-176551-000048CA12#Vault Purifier##nil#181113#Encounter Spawn#nil#nil", -- [188]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 346971 then--Summon Vault Defender
		self.vb.addIcon = 1
		warnVaultPurifierSoon:Show()
	end
end

