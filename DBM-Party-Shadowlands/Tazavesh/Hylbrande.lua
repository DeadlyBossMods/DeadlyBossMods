local mod	= DBM:NewMod(2448, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175663)
mod:SetEncounterID(2426)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 347094 346957 346766 358131 353312",
	"SPELL_CAST_SUCCESS 346116",
	"SPELL_AURA_APPLIED 358131 346427",
	"SPELL_AURA_REMOVED 347958 353312"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Are swings dogeable by tank?
--TODO, Titanic Crash is equally vague? does it always face tank or random player? can tank dodge it, again?
--TODO, Purged by Fire debuff or target scan?
--TODO, what else do? hard to know what to do with this zone since i've never seen it
local warnPurgedbyFire				= mod:NewSpellAnnounce(346959, 2)--Swap to target warning alter and add special warnings/yell
local warnKeepersprotection			= mod:NewEndAnnounce(347958, 1)
local warnLightningNova				= mod:NewTargetNoFilterAnnounce(358131, 3)
local warnPurifyingBurst			= mod:NewCountAnnounce(353312, 2)
local warnTitanicInsight			= mod:NewTargetNoFilterAnnounce(353312, 2)

local specWarnShearingSwings		= mod:NewSpecialWarningDefensive(346116, nil, nil, nil, 1, 2)
local specWarnTitanicCrash			= mod:NewSpecialWarningDodge(347094, nil, nil, nil, 2, 2)
--local yellEmbalmingIchor			= mod:NewYell(327664)
local specWarnSanitizingCycle		= mod:NewSpecialWarningCount(346766, nil, nil, nil, 2, 2)
local specWarnLigtningNova			= mod:NewSpecialWarningInterrupt(358131, "HasInterrupt", nil, nil, 1, 2)--Hard Mode
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

local timerShearingSwingsCD			= mod:NewAITimer(15.8, 346116, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerTitanicCrashCD			= mod:NewAITimer(11, 347094, nil, nil, nil, 3)
local timerPurgedbyFireCD			= mod:NewAITimer(11, 346959, nil, nil, nil, 3)
local timerSanitizingCycleCD		= mod:NewAITimer(11, 346766, nil, nil, nil, 6)
local timerPurifyingBurstCD			= mod:NewAITimer(11, 353312, nil, nil, nil, 2)
local timerTitanicInsight			= mod:NewTargetTimer(15, 353312, nil, nil, nil, 5)

mod.vb.cycleCount = 0
mod.vb.burstCount = 0

function mod:OnCombatStart(delay)
	self.vb.cycleCount = 0
	self.vb.burstCount = 0
	timerShearingSwingsCD:Start(1-delay)
	timerTitanicCrashCD:Start(1-delay)
	timerPurgedbyFireCD:Start(1-delay)
	timerSanitizingCycleCD:Start(1-delay)
	--TODO, hard mode check shit for purifying Burst
	timerPurifyingBurstCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 347094 then
		specWarnTitanicCrash:Show()
		specWarnTitanicCrash:Play("shockwave")
		timerTitanicCrashCD:Start()
	elseif spellId == 346957 then
		warnPurgedbyFire:Show()
		timerPurgedbyFireCD:Start()
	elseif spellId == 346766 then
		self.vb.cycleCount = self.vb.cycleCount + 1
		specWarnSanitizingCycle:Show(self.vb.cycleCount)
		specWarnSanitizingCycle:Play("specialsoon")
		timerSanitizingCycleCD:Start()
	elseif spellId == 358131 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLigtningNova:Show(args.sourceName)
			specWarnLigtningNova:Play("kickcast")
		end
	elseif spellId == 353312 then
		self.vb.burstCount = self.vb.burstCount + 1
		warnPurifyingBurst:Show(self.vb.burstCount)
		timerPurifyingBurstCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 346116 then
		if self:IsTanking("player", "boss1") then
			specWarnShearingSwings:Show()
			specWarnShearingSwings:Play("defensive")
		end
		timerShearingSwingsCD:Start()
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
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
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


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
