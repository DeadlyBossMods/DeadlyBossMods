local mod	= DBM:NewMod(2115, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(139273)
mod:SetEncounterID(2107)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 259853",
	"SPELL_CAST_START 260669 259940",
	"SPELL_CAST_SUCCESS 259022 270042",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, why two diff duration spellIDs for Catalyst and Propellant Blast, are both used?
--TODO, get correct spellId for GTFO for flames on ground
--TODO, verify GushingCatalyst id/event and unit ID
local warnAxeriteCatalyst			= mod:NewSpellAnnounce(259022, 2)--Cast often, so general warning not special

local specWarnChemBurn				= mod:NewSpecialWarningDispel(259853, "Healer", nil, nil, 1, 2)
local specWarnPoropellantBlast		= mod:NewSpecialWarningDodge(259940, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerAxeriteCatalystCD		= mod:NewAITimer(13, 259022, nil, nil, nil, 3)
local timerChemBurnCD				= mod:NewAITimer(13, 259853, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)
local timerPropellantBlastCD		= mod:NewAITimer(13, 259940, nil, nil, nil, 3)
local timerGushingCatalystCD		= mod:NewAITimer(13, 275992, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerAxeriteCatalystCD:Start(1-delay)
	timerChemBurnCD:Start(1-delay)
	timerPropellantBlastCD:Start(1-delay)
	if not self:IsNormal() then
		timerGushingCatalystCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 259853 then
		specWarnChemBurn:CombinedShow(1, args.destName)
		specWarnChemBurn:CancelVoice()
		specWarnChemBurn:ScheduleVoice(1, "dispelnow")
		if self:AntiSpam(5, 1) then
			timerChemBurnCD:Start()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260669 or spellId == 259940 then
		specWarnPoropellantBlast:Show()
		specWarnPoropellantBlast:Play("watchstep")
		timerPropellantBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 259022 or spellId == 270042 then
		warnAxeriteCatalyst:Show()
		timerAxeriteCatalystCD:Start()
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
	if spellId == 275992 then
		warnAxeriteCatalyst:Show()
		timerGushingCatalystCD:Start()
	end
end
