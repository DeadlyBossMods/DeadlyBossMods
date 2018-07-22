local mod	= DBM:NewMod(2165, "DBM-Party-BfA", 3, 1041)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135322)
mod:SetEncounterID(2139)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 265773",
	"SPELL_CAST_START 265773 265923 265781 265910",
	"SPELL_PERIODIC_DAMAGE 265914",
	"SPELL_PERIODIC_MISSED 265914"
)

local warnSpitGold					= mod:NewTargetAnnounce(265773, 2)

local specWarnTailThrash			= mod:NewSpecialWarningDefensive(265910, nil, nil, nil, 1, 2)
local specWarnSpitGold				= mod:NewSpecialWarningMoveAway(265773, nil, nil, nil, 1, 2)
local yellSpitGold					= mod:NewYell(265773)
local specWarnLucreCall				= mod:NewSpecialWarningSwitch(265923, nil, nil, nil, 1, 2)
local specWarnSerpentine			= mod:NewSpecialWarningRun(265781, nil, nil, nil, 4, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(265914, nil, nil, nil, 1, 2)

local timerTailThrashCD				= mod:NewAITimer(13, 265910, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local timerSpitGoldCD				= mod:NewAITimer(13, 265773, nil, nil, nil, 3)
local timerLucreCallCD				= mod:NewAITimer(13, 265923, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerSpitGoldCD:Start(1-delay)
	timerLucreCallCD:Start(1-delay)
	timerTailThrashCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265773 then
		warnSpitGold:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSpitGold:Show()
			specWarnSpitGold:Play("runout")
			yellSpitGold:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 265773 then
		timerSpitGoldCD:Start()
	elseif spellId == 265923 then
		specWarnLucreCall:Show()
		specWarnLucreCall:Play("killmob")
		timerLucreCallCD:Start()
	elseif spellId == 265781 then
		specWarnSerpentine:Show()
		specWarnSerpentine:Play("justrun")
	elseif spellId == 265910 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnTailThrash:Show()
			specWarnTailThrash:Play("defensive")
		end
		timerTailThrashCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 265914 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
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
