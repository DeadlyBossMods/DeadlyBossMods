local mod	= DBM:NewMod(1502, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96756)
mod:SetEncounterID(1822)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193211 193364 193977 193460"
)

local warnBane						= mod:NewSpellAnnounce(193460, 3)--Can't think of any reason this needs to be special

local specWarnDarkSlash				= mod:NewSpecialWarningSpell(193211, "Tank")
local specWarnScreams				= mod:NewSpecialWarningRun(193364, "Melee", nil, nil, 4, 2)
local specWarnWinds					= mod:NewSpecialWarningSpell(193977, nil, nil, nil, 2, 2)

local timerDarkSlashCD				= mod:NewCDTimer(14.6, 193211, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerScreamsCD				= mod:NewCDTimer(23, 193364, nil, "Melee", nil, 2)
local timerWindsCD					= mod:NewCDTimer(24, 193977, nil, nil, nil, 2)
local timerBaneCD					= mod:NewCDTimer(49.5, 193460, nil, false, nil, 2)--Again can't hink of any reason why this matters

local voiceDarkSlash				= mod:NewVoice(193211, "Tank")--defensive
local voiceScreams					= mod:NewVoice(193364, "Melee")--runout
local voiceWinds					= mod:NewVoice(193977)--carefly

function mod:OnCombatStart(delay)
	timerDarkSlashCD:Start(3.5-delay)
	timerScreamsCD:Start(5.9-delay)
	timerWindsCD:Start(15.5-delay)
	timerBaneCD:Start(21.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193211 then
		specWarnDarkSlash:Show()
		voiceDarkSlash:Play("defensive")
		timerDarkSlashCD:Start()
	elseif spellId == 193364 then
		specWarnScreams:Show()
		voiceScreams:Play("runout")
		timerScreamsCD:Start()
	elseif spellId == 193977 then
		specWarnWinds:Show()
		voiceWinds:Play("carefly")
		timerWindsCD:Start()
	elseif spellId == 193460 then
		warnBane:Show()
		timerBaneCD:Start()
	end
end
