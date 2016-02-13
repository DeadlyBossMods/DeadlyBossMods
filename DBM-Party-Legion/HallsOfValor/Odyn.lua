local mod	= DBM:NewMod(1489, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95676)
mod:SetEncounterID(1809)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197963 197964 197965 197966 197967",
	"SPELL_AURA_REMOVED 197963 197964 197965 197966 197967",
	"SPELL_CAST_START 198072 198263 198077",
	"SPELL_CAST_SUCCESS 197961"
)

--TODO, add HUD option/arrows when I have map data collected for rune locations
--TODO, longer sequences
--[[
["198072-Spear of Light"] = "pull:8.0, 8.1, 19.9, 28.0, 20.0, 8.0, 28.0, 8.0",
["198263-Radiant Tempest"] = "pull:24.1, 47.9",
--]]
local warnSpear						= mod:NewSpellAnnounce(198072, 2)--Target not available so no target warning.

local specWarnTempest				= mod:NewSpecialWarningRun(198263, nil, nil, nil, 4, 2)
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(198077, nil, nil, nil, 2, 2)
local specWarnRunicBrand			= mod:NewSpecialWarningMoveTo(197961, nil, nil, nil, 2, 6)

local timerSpearCD					= mod:NewCDTimer(8, 198077, nil, nil, nil, 3)--More data needed
local timerTempestCD				= mod:NewCDTimer(48, 198263, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--More data needed
local timerShatterSpearsCD			= mod:NewCDTimer(56, 198077, nil, nil, nil, 2)
local timerRunicBrandCD				= mod:NewCDTimer(56, 197961, nil, nil, nil, 3)

local voiceTempest					= mod:NewVoice(198263)--runout
local voiceShatterSpears			= mod:NewVoice(198077)--watchorb
local voiceRunicBrand				= mod:NewVoice(197961)--locations.

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)
	timerSpearCD:Start(-delay)
	timerTempestCD:Start(24-delay)
	timerShatterSpearsCD:Start(40-delay)
	timerRunicBrandCD:Start(46-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197963 then--Purple K (NE)
		specWarnRunicBrand:Show("NE")
		voiceRunicBrand:Play("frontright")
	elseif spellId == 197964 then--Red N (SE)
		specWarnRunicBrand:Show("SE")
		voiceRunicBrand:Play("backright")
	elseif spellId == 197965 then--Yellow H (SW)
		specWarnRunicBrand:Show("SW")
		voiceRunicBrand:Play("backleft")
	elseif spellId == 197966 then--Blue fishies (NW)
		specWarnRunicBrand:Show("NW")
		voiceRunicBrand:Play("frontleft")
	elseif spellId == 197967 then--Green box (N)
		specWarnRunicBrand:Show("N")
		voiceRunicBrand:Play("frontcenter")--Does not exist yet
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197963 then--Purple K (NE)
	
	elseif spellId == 197964 then--Red N (SE)
	
	elseif spellId == 197965 then--Yellow H (SW)
	
	elseif spellId == 197966 then--Blue fishies (NW)
	
	elseif spellId == 197967 then--Green box (N)

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198072 then
		warnSpear:Show()
	elseif spellId == 198263 then
		specWarnTempest:Show()
		voiceTempest:Play("runout")
		timerSpearCD:Start(12)
		timerTempestCD:Start()
	elseif spellId == 198077 then
		specWarnShatterSpears:Show()
		voiceShatterSpears:Play("watchorb")
		timerShatterSpearsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197961 then
		timerSpearCD:Start(18)
		timerRunicBrandCD:Start()
	end
end
