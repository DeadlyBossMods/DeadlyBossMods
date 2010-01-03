local mod	= DBM:NewMod("Ionar", "DBM-Party-WotLK", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

local warningDisperseSoon	= mod:NewSoonAnnounce(52770, 2)
local warningDisperse		= mod:NewSpellAnnounce(52770, 3)
local warningOverload		= mod:NewTargetAnnounce(52658, 2)
local timerOverload			= mod:NewTargetTimer(10, 52658)

mod:AddBoolOption("SetIconOnOverloadTarget", true)

local warnedDisperse		= false

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

function mod:OnCombatStart()
	warnedDisperse = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52658, 59795) then
		warningOverload:Show(args.destName)
		timerOverload:Start(args.destName)
		if self.Options.SetIconOnOverloadTarget then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(52770) then
		warningDisperse:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedDisperse and self:GetUnitCreatureId(uId) == 28546 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warnedDisperse = true
		warningDisperseSoon:Show()
	end
end