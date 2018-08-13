local mod	= DBM:NewMod(2198, "DBM-Azeroth-BfA", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(140163)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274842 274932"
)

--TODO, Reality Tear cast Id/event
--local warnMothersEmbrace			= mod:NewTargetAnnounce(219045, 3)

local specWarnVoidNova				= mod:NewSpecialWarningSpell(274842, nil, nil, nil, 2, 2)
--local specWarnRealityTear			= mod:NewSpecialWarningDodge(274842, nil, nil, nil, 2, 2)
local specWarnEndlessAbyss			= mod:NewSpecialWarningRun(274932, nil, nil, nil, 4, 2)

local timerVoidNovaCD				= mod:NewAITimer(16, 274842, nil, nil, nil, 2)
--local timerRealityTearCD			= mod:NewAITimer(16, 274904, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerEndlessAbyssCD			= mod:NewAITimer(16, 274932, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--mod:AddRangeFrameOption(5, 194966)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerVoidNovaCD:Start(1-delay)
		--timerEndlessAbyssCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 274842 then
		specWarnVoidNova:Show()
		specWarnVoidNova:Play("aesoon")
		timerVoidNovaCD:Start()
	elseif spellId == 274932 then
		specWarnEndlessAbyss:Show()
		specWarnEndlessAbyss:Play("justrun")
		timerEndlessAbyssCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
