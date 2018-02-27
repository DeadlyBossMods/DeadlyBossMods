local mod	= DBM:NewMod(2036, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122965)
mod:SetEncounterID(2085)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 250585",
	"SPELL_CAST_START 250258",
	"SPELL_CAST_SUCCESS 250368 259572",
	"UNIT_DIED"
)

--ability.id = 250258 and type = "begincast" or (ability.id = 250368 or ability.id = 259572 or ability.id = 250241) and type = "cast" or target.id = 125977 and type = "death"
--TODO, stench says it's interruptable but cannot verify this. When I determine what to do with it, improve warning
local warnPhase2					= mod:NewPhaseAnnounce(195254, 2, nil, nil, nil, nil, nil, 2)
local warnTotemsLeft				= mod:NewAddsLeftAnnounce(250190, 2, 250192)
local warnNoxiousStench				= mod:NewSpellAnnounce(250368, 3)

local specWarnLeap					= mod:NewSpecialWarningDodge(250258, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)--Use if leap target scanning possible
local specWarnGTFO					= mod:NewSpecialWarningGTFO(250585, nil, nil, nil, 1, 2)

local timerLeapCD					= mod:NewNextTimer(6, 250258, nil, nil, nil, 3)--6 uness delayed by stentch, then 8
local timerNoxiousStenchCD			= mod:NewNextTimer(13, 250368, nil, nil, nil, 3, nil, DBM_CORE_DISEASE_ICON)

mod.vb.totemRemaining = 3

function mod:OnCombatStart(delay)
	self.vb.totemRemaining = 3
	timerLeapCD:Start(2-delay)
	timerNoxiousStenchCD:Start(7-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 250585 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 195254 then
		specWarnLeap:Show()
		specWarnLeap:Play("watchstep")
		timerLeapCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 250368 then--Stage 2
		warnNoxiousStench:Show()
		timerNoxiousStenchCD:Start(18)
	elseif spellId == 259572 then--Stage 1
		warnNoxiousStench:Show()
		timerNoxiousStenchCD:Start(20)
		timerLeapCD:AddTime(2)--Consistent with early alpha, might use more complex code if this becomes inconsistent
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 125977 then--Reanimation Totem
		self.vb.totemRemaining = self.vb.totemRemaining - 1
		if self.vb.totemRemaining > 0 then
			warnTotemsLeft:Show(self.vb.totemRemaining)
		else--Stage 2
			timerNoxiousStenchCD:Stop()
			timerLeapCD:Stop()
			warnPhase2:Show()
			warnPhase2:Play("ptwo")
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
	end
end
--]]
