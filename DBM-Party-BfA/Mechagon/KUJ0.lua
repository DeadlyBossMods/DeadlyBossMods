local mod	= DBM:NewMod(2339, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144246)
mod:SetEncounterID(2258)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 291972 294929",
	"SPELL_AURA_APPLIED_DOSE 294929",
--	"SPELL_AURA_REMOVED 291972",
	"SPELL_CAST_START 291946",
	"SPELL_CAST_SUCCESS 291930 292022 294929"
)

local warnAirDrop					= mod:NewSpellAnnounce(291930, 2)
local warnExplosiveLeap				= mod:NewTargetNoFilterAnnounce(291972, 3)
local warnBlazingChomp				= mod:NewStackAnnounce(294929, 2, nil, "Tank|Healer")

local specWarnExplosiveLeap			= mod:NewSpecialWarningMoveAway(291972, nil, nil, nil, 1, 2)
local yellExplosiveLeap				= mod:NewYell(291972)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
local specWarnVentingFlames			= mod:NewSpecialWarningMoveTo(291946, nil, nil, nil, 3, 2)

local timerAurDropCD				= mod:NewAITimer(31.6, 291930, nil, nil, nil, 3)
local timerExplosiveLeapCD			= mod:NewAITimer(13.4, 291972, nil, nil, nil, 3)
local timerVentingFlamesCD			= mod:NewAITimer(13.4, 291946, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerBlazingChompCD			= mod:NewAITimer(13.4, 294929, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerAurDropCD:Start(1-delay)
	timerExplosiveLeapCD:Start(1-delay)
	timerVentingFlamesCD:Start(1-delay)
	timerBlazingChompCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 291972 then
		if args:IsPlayer() then
			specWarnExplosiveLeap:Show()
			specWarnExplosiveLeap:Play("runout")
			yellExplosiveLeap:Yell()
		else
			warnExplosiveLeap:Show(args.destName)
		end
	elseif spellId == 294929 then
		local amount = args.amount or 1
		warnBlazingChomp:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 291972 then

	end
end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 291946 then
		specWarnVentingFlames:Show(DBM_CORE_BREAK_LOS)
		specWarnVentingFlames:Play("findshelter")
		timerVentingFlamesCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 291930 then
		warnAirDrop:Show()
		timerAurDropCD:Start()
	elseif spellId == 292022 then
		timerExplosiveLeapCD:Start()
	elseif spellId == 294929 then
		timerBlazingChompCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
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
