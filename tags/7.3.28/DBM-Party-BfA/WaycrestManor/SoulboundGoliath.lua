local mod	= DBM:NewMod(2126, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(260551)
mod:SetEncounterID(2114)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267907",
	"SPELL_CAST_START 260508",
	"SPELL_CAST_SUCCESS 267907"
)

--TODO, wildfire/burning bush stuff for heroic+
--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnCrush					= mod:NewSpecialWarningDefensive(260508, "Tank", nil, nil, 1, 2)
local specWarnThorns				= mod:NewSpecialWarningSwitch(267907, "Dps", nil, nil, 1, 2)
local yellThorns					= mod:NewYell(267907)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCrushCD					= mod:NewCDTimer(21.9, 260508, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerThornsCD					= mod:NewNextTimer(21.9, 267907, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)

--mod:AddRangeFrameOption(5, 194966)

mod.vb.crushCount = 0

function mod:OnCombatStart(delay)
	self.vb.crushCount = 0
	timerCrushCD:Start(5.7-delay)
	timerThornsCD:Start(8.1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267907 then
		if args:IsPlayer() then
			yellThorns:Yell()
		else
			specWarnThorns:Show()
			specWarnThorns:Play("targetchange")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260508 then
		self.vb.crushCount = self.vb.crushCount + 1
		specWarnCrush:Show()
		specWarnCrush:Play("defensive")
		--More data needed to verify this
		--5.7, 17.0, 18.2, 17.0, 18.3
		if self.vb.crushCount % 2 == 0 then
			timerCrushCD:Start(18.2)
		else
			timerCrushCD:Start(17)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267907 then
		timerThornsCD:Start()
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
