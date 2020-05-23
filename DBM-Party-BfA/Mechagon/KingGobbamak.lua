local mod	= DBM:NewMod(2357, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150159)
mod:SetEncounterID(2290)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297254",
	"SPELL_CAST_SUCCESS 297465 297261",
	"SPELL_AURA_APPLIED 297257"
--	"SPELL_AURA_REMOVED",
)

--[[
ability.id = 297254 and type = "cast"
 or (ability.id = 297465 or ability.id = 297261) and type = "cast"
--]]
--TODO, add nameplate aura for https://ptr.wowhead.com/spell=297318/powered-up if it's on a unit with nameplate
local warnElectricalCharge			= mod:NewTargetAnnounce(297257, 2)
--local warnGetEm						= mod:NewSpellAnnounce(297465, 2)

local specWarnChargedSmash			= mod:NewSpecialWarningSpell(297254, nil, nil, nil, 2, 2)
--local specWarnHowlingFear			= mod:NewSpecialWarningInterrupt(257791, "HasInterrupt", nil, nil, 1, 2)
local specWarnElectricalCharge		= mod:NewSpecialWarningYou(297257, nil, nil, nil, 1, 2)
local yellElectricalCharge			= mod:NewYell(297257, nil, false)
local specWarnRumble				= mod:NewSpecialWarningSpell(297261, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--local timerHowlingFearCD			= mod:NewAITimer(13.4, 257791, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_Translations.INTERRUPT_ICON)
local timerChargedSmashCD			= mod:NewNextTimer(32.7, 297254, nil, nil, nil, 5, nil, DBM_CORE_Translations.TANK_ICON)
local timerRumbleCD					= mod:NewCDTimer(51, 297261, nil, nil, nil, 2, nil, DBM_CORE_Translations.HEALER_ICON)--51-54 (based on one pull of one log)
--local timerGetEmCD					= mod:NewAITimer(31.6, 297465, nil, nil, nil, 1)

function mod:OnCombatStart(delay)
	timerRumbleCD:Start(8.3-delay)
	timerChargedSmashCD:Start(24.7-delay)
	--timerGetEmCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297254 then
		specWarnChargedSmash:Show()
		specWarnChargedSmash:Play("helpsoak")
		timerChargedSmashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 297465 then
		--warnGetEm:Show()
		--timerGetEmCD:Start()
	elseif spellId == 297261 then
		specWarnRumble:Show()
		specWarnRumble:Play("aesoon")
		timerRumbleCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 297257 then
		if args:IsPlayer() then
			specWarnElectricalCharge:Show()
			specWarnElectricalCharge:Play("targetyou")
			yellElectricalCharge:Yell()
		else
			warnElectricalCharge:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 297257 then

	end
end
--]]
