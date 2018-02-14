local mod	= DBM:NewMod(2082, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(128956)
mod:SetEncounterID(2084)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 255577",
	"SPELL_CAST_SUCCESS 255579 255591",
	"SPELL_AURA_REMOVED 255579"
)

--ability.id = 255577 and type = "begincast" or ability.id = 255579 and type = "cast" or ability.id = 255591
local warnTransfusion				= mod:NewSpellAnnounce(255577, 1)
local warnMoltenGold				= mod:NewSpellAnnounce(255591, 3)

local specWarnTransfusion			= mod:NewSpecialWarningMoveTo(255577, nil, nil, nil, 3, 2)
local specWarnClaws					= mod:NewSpecialWarningDefensive(255579, "Tank", nil, nil, 1, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerTransfusionCD			= mod:NewNextTimer(34, 255577, nil, nil, nil, 5)
local timerGildedClawsCD			= mod:NewNextTimer(20, 255579, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerMoltenGoldCD				= mod:NewNextTimer(34, 255591, nil, nil, nil, 3)

local taintedBlood = DBM:GetSpellInfo(255558)

function mod:OnCombatStart(delay)
	taintedBlood = DBM:GetSpellInfo(255558)
	timerGildedClawsCD:Start(10.5-delay)
	timerMoltenGoldCD:Start(16.5-delay)
	timerTransfusionCD:Start(25-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 255577 then
		timerTransfusionCD:Start()
		local _, _, _, _, _, _, expireTime = UnitDebuff("player", taintedBlood)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		--Not dead, and do not have tainted blood or do have it but it'll expire for transfusion does.
		if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9) then
			specWarnTransfusion:Show(taintedBlood)
			specWarnTransfusion:Play("takedamage")
		else--Already good to go, just a positive warning
			warnTransfusion:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 255579 then
		specWarnClaws:Show()
		specWarnClaws:Play("defensive")
	elseif spellId == 255591 then
		warnMoltenGold:Show()
		timerMoltenGoldCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 255579 then
		timerGildedClawsCD:Start()
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then

	end
end
--]]
