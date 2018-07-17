local mod	= DBM:NewMod(2116, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(131227)
mod:SetEncounterID(2108)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED 260189",
	"SPELL_AURA_REMOVED_DOSE 260189",
	"SPELL_CAST_START 260280 260811 271456"
)

--TODO: Phase Changes and timer canceling/starting
--TODO: target scan homing Missile? what do we do with it? Give it a voice
--TODO: add big red rocket once correct spellID/event known, too many to make educated guess.
--TODO: Maybe general range 6 for Micro Missiles from BOOMBA?
local warnDrill						= mod:NewStackAnnounce(260189, 2)

--Stage One: Big Guns
local specWarnGatlingGun			= mod:NewSpecialWarningDodge(260280, nil, nil, nil, 2, 2)
local specWarnHomingMissile			= mod:NewSpecialWarningSpell(260811, nil, nil, nil, 2)
--Stage Two: Drill
local specWarnDrillSmash			= mod:NewSpecialWarningDodge(271456, nil, nil, nil, 2, 2)
--local specWarnBigRedRocket		= mod:NewSpecialWarningDodge(270282, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--local timerReapSoulCD				= mod:NewAITimer(13, 194956, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
--Stage One: Big Guns
local timerGatlingGunCD				= mod:NewAITimer(13, 260280, nil, nil, nil, 3)
local timerHomingMissileCD			= mod:NewAITimer(13, 260811, nil, nil, nil, 3)
--Stage Two: Drill
local timerDrillSmashCD				= mod:NewAITimer(13, 271456, nil, nil, nil, 3)
--local timerBigRedRocketCD			= mod:NewAITimer(13, 270282, nil, nil, nil, 3)

--mod:AddRangeFrameOption(6, 276234)

function mod:OnCombatStart(delay)
	timerGatlingGunCD:Start(1-delay)
	timerHomingMissileCD:Start(1-delay)
--	if self.Options.RangeFrame and not self:IsNormal() then
--		DBM.RangeCheck:Show(6)
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then
	
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 260189 then
		local amount = args.amount or 0
		warnDrill:Show(amount)
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_REMOVED_DOSE

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260280 then
		specWarnGatlingGun:Show()
		specWarnGatlingGun:Play("shockwave")
		timerGatlingGunCD:Start()
	elseif spellId == 260811 then
		specWarnHomingMissile:Show()
		--specWarnHomingMissile:Play("")
		timerHomingMissileCD:Start()
	elseif spellId == 271456 then
		specWarnDrillSmash:Show()
		specWarnDrillSmash:Play("watchstep")
		timerDrillSmashCD:Start()
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
