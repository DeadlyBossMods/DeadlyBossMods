local mod	= DBM:NewMod(2199, "DBM-Azeroth-BfA", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(136385)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274839 274829 274832"
)

--TODO, see if can detect gale force teleport target
--local warnMothersEmbrace			= mod:NewTargetAnnounce(219045, 3)

local specWarnAzurethosFury			= mod:NewSpecialWarningRun(274839, nil, nil, nil, 4, 2)
local specWarnGaleForce				= mod:NewSpecialWarningDodge(274829, nil, nil, nil, 2, 2)
local specWarnWingBuffet			= mod:NewSpecialWarningDodge(274832, nil, nil, nil, 1, 2)

local timerAzurethosFuryCD			= mod:NewAITimer(16, 274839, nil, nil, nil, 2)
local timerGaleForceCD				= mod:NewAITimer(16, 274829, nil, nil, nil, 3)
local timerWingBuffetCD				= mod:NewAITimer(16, 274832, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--mod:AddRangeFrameOption(5, 194966)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerAzurethosFuryCD:Start(1-delay)
		--timerGaleForceCD:Start(1-delay)
		--timerWingBuffetCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 274839 then
		specWarnAzurethosFury:Show()
		specWarnAzurethosFury:Play("justrun")
		timerAzurethosFuryCD:Start()
	elseif spellId == 274829 then
		specWarnGaleForce:Show()
		specWarnGaleForce:Play("shockwave")
		timerGaleForceCD:Start()
	elseif spellId == 274832 then
		specWarnWingBuffet:Show()
		specWarnWingBuffet:Play("shockwave")
		timerWingBuffetCD:Start()
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
