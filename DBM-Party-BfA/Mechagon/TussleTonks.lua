local mod	= DBM:NewMod(2336, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144244, 145185)
mod:SetEncounterID(2257)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 285020 283422 285388",
	"SPELL_CAST_SUCCESS 285344 285152",
--	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED 282801 285388",
	"SPELL_AURA_REMOVED_DOSE 282801",
	"UNIT_DIED"
)

--TODO, Foe Flipper target?
--TODO, Maximum Thrust target?
--[[
(ability.id = 285020 or ability.id = 283422 or ability.id = 285388) and type = "begincast"
 or (ability.id = 285344 or ability.id = 285152) and type = "cast"
 --]]
local warnPlatinumPlating			= mod:NewCountAnnounce(282801, 2)
local warnLayMine					= mod:NewSpellAnnounce(285351, 2)
local warnFoeFlipper				= mod:NewSpellAnnounce(285153, 2)
local warnVentJets					= mod:NewEndAnnounce(285388, 1)
local warnMaxThrust					= mod:NewSpellAnnounce(283565, 2)

local specWarnWhirlingEdge			= mod:NewSpecialWarningDodge(285020, "Tank", nil, nil, 1, 2)
local specWarnVentJets				= mod:NewSpecialWarningDodge(285388, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerWhirlingEdgeCD			= mod:NewAITimer(13.4, 285020, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFoeFlipperCD				= mod:NewAITimer(13.4, 285153, nil, nil, nil, 3)
local timerVentJetsCD				= mod:NewAITimer(13.4, 285388, nil, nil, nil, 2)
local timerMaxThrustCD				= mod:NewAITimer(13.4, 283565, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerWhirlingEdgeCD:Start(1-delay)
	timerFoeFlipperCD:Start(1-delay)
	timerVentJetsCD:Start(1-delay)
	timerMaxThrustCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 285020 then
		specWarnWhirlingEdge:Show()
		specWarnWhirlingEdge:Play("shockwave")
		timerWhirlingEdgeCD:Start()
	elseif spellId == 283422 then
		warnMaxThrust:Show()
		timerMaxThrustCD:Start()
	elseif spellId == 285388 then
		specWarnVentJets:Show()
		specWarnVentJets:Play("watchstep")
		timerVentJetsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285344 then
		warnLayMine:Show()
	elseif spellId == 285152 then
		warnFoeFlipper:Show()
		timerFoeFlipperCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285388 then

	end
end
--]]

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282801 then
		local amount = args.amount or 1
		warnPlatinumPlating:Show(args.amount or 0)
	elseif spellId == 285388 then
		warnVentJets:Show()
		timerVentJetsCD:Stop()
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144244 then--The Platinum Pummeler
		timerWhirlingEdgeCD:Stop()
	elseif cid == 145185 then--Gnomercy 4.U.
		timerFoeFlipperCD:Stop()
		timerVentJetsCD:Stop()
		timerMaxThrustCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
