local mod	= DBM:NewMod(2172, "DBM-Party-BfA", 3, 1041)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(136160)
mod:SetEncounterID(2143)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 268403 268932 268586"
)

--TODO, work on quaking leap target scanning code more
local warnGaleSlash					= mod:NewSpellAnnounce(268403, 2)
local warnQuakingLeap				= mod:NewTargetAnnounce(268932, 2)

local specWarnQuakingLeap			= mod:NewSpecialWarningYou(268932, nil, nil, nil, 1, 2)
local yellQuakingLeap				= mod:NewYell(268932)
local specWarnQuakingLeapNear		= mod:NewSpecialWarningClose(268932, nil, nil, nil, 1, 2)
local specWarnBladeCombo			= mod:NewSpecialWarningDefensive(268586, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerGaleSlashCD				= mod:NewAITimer(13, 268403, nil, nil, nil, 3)
local timerQuakingLeapCD			= mod:NewAITimer(13, 268932, nil, nil, nil, 3)
local timerBladeComboCD				= mod:NewAITimer(13, 268586, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:LeapTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnQuakingLeap:Show()
		specWarnQuakingLeap:Play("targetyou")
		yellQuakingLeap:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnQuakingLeapNear:Show(targetname)
		specWarnQuakingLeapNear:Play("runaway")
	else
		warnQuakingLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerGaleSlashCD:Start(1-delay)
	timerQuakingLeapCD:Start(1-delay)
	timerBladeComboCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then
	
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 268403 then
		warnGaleSlash:Show()
		timerGaleSlashCD:Start()
	elseif spellId == 268932 then
		timerQuakingLeapCD:Start()
		self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.05, 12, true)
	elseif spellId == 268586 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBladeCombo:Show()
			specWarnBladeCombo:Play("defensive")
		end
		timerBladeComboCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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
