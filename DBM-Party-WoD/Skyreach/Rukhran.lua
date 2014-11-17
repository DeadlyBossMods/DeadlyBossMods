local mod	= DBM:NewMod(967, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76143)
mod:SetEncounterID(1700)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153810 153794 159382"
)

local warnSolarFlare			= mod:NewSpellAnnounce(153810, 3)
local warnPierceArmor			= mod:NewSpellAnnounce(153794, 3, nil, mod:IsTank())
local warnQuills				= mod:NewSpellAnnounce(159382, 4)

local specWarnSolarFlare		= mod:NewSpecialWarningSwitch(153810, false)--Not everyone needs to, really just requires 1 person, unless it's harder on heroic/challenge mode and needs more, then i'll default all damage dealers
local specWarnPierceArmor		= mod:NewSpecialWarningSpell(153794, mod:IsTank())
local specWarnQuills			= mod:NewSpecialWarningSpell(159382, nil, nil, nil, 2)

local timerSolarFlareCD			= mod:NewCDTimer(18, 153810)
local timerQuillsCD				= mod:NewCDTimer(64, 159382)--Needs review

function mod:OnCombatStart(delay)
	timerSolarFlareCD:Start(11-delay)
	if self:IsHeroic() then
		timerQuillsCD:Start(33-delay)--Needs review
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153810 then
		warnSolarFlare:Show()
		specWarnSolarFlare:Show()
		timerSolarFlareCD:Start()
	elseif spellId == 153794 then
		warnPierceArmor:Show()
		specWarnPierceArmor:Show()
	elseif spellId == 159382 then
		warnQuills:Show()
		specWarnQuills:Show()
		timerQuillsCD:Start()
	end
end
