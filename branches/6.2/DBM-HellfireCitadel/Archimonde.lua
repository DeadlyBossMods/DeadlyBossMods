local mod	= DBM:NewMod(1438, "DBM-BlackrockFoundry", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(76877)
mod:SetEncounterID(1799)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS,
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnCrumblingRoar				= mod:NewSpellAnnounce(155730, 3, nil, false)

local specWarnRampage				= mod:NewSpecialWarningSpell(155539, nil, nil, nil, 2)

local timerRampageCD				= mod:NewCDTimer(107, 155539)

--local berserkTimer					= mod:NewBerserkTimer(360)

--local countdownInfernoSlice			= mod:NewCountdown(12, 155080, "Tank")

--local voiceInfernoSlice				= mod:NewVoice(155080)

--mod:AddRangeFrameOption(8, 155530)
--mod:AddHudMapOption("HudMapOnShatter", 155530, false)


local debuffFilter
do
	local debuffName = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnShatter then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155080 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155323 then
		if args:IsPlayer() then

			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.HudMapOnShatter then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "timer", args.destName, 8, 10, 0, 1, 0, 0.6):Appear():RegisterForAlerts():Rotate(360, 9.5)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.HudMapOnShatter then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
