local mod	= DBM:NewMod(2131, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(131817)
mod:SetEncounterID(2118)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260416 260333",
	"SPELL_AURA_REMOVED 260416",
	"SPELL_CAST_START 260793 260292",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, confirm timers, for tantrum
--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnIndigestion			= mod:NewSpecialWarningSpell(260793, "Tank", nil, nil, 1, 2)
local specWarnCharge				= mod:NewSpecialWarningDodge(260292, nil, nil, nil, 3, 2)
local specWarnTantrum				= mod:NewSpecialWarningSpell(260333, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerIndigestionCD			= mod:NewCDTimer(70, 260793, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChargeCD					= mod:NewCDTimer(23.1, 260292, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTantrumCD				= mod:NewCDTimer(13, 260333, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

--mod:AddRangeFrameOption(5, 194966)
mod:AddNamePlateOption("NPAuraMetamorphosis", 260416)

function mod:OnCombatStart(delay)
	if self.Options.NPAuraMetamorphosis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	timerIndigestionCD:Start(8.3-delay)
	timerChargeCD:Start(20.5-delay)
	--if not self:IsNormal() then
		--timerTantrumCD:Start(1-delay)
	--end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraMetamorphosis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 260416 then
		if self.Options.NPAuraMetamorphosis then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 8)
		end
	elseif spellId == 260333 then
		specWarnTantrum:Show()
		specWarnTantrum:Play("aesoon")
		--timerTantrumCD:Start()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 260416 then
		if self.Options.NPAuraMetamorphosis then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260793 then
		specWarnIndigestion:Show()
		specWarnIndigestion:Play("breathsoon")
		timerIndigestionCD:Start()
	elseif spellId == 260292 then
		specWarnCharge:Show()
		specWarnCharge:Play("chargemove")
		timerChargeCD:Start()
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 271775 then--Tantrum Energy Bar
		timerTantrumCD:Start(15)
	end
end

