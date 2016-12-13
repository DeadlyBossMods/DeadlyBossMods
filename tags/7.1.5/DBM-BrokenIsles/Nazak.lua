local mod	= DBM:NewMod(1783, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(110321)
mod:SetEncounterID(1950)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 219349",
	"SPELL_CAST_SUCCESS 219861",
	"SPELL_AURA_APPLIED 219591 219865"
)

local warnCorrodingSpray		= mod:NewCastAnnounce(219349, 2, nil, nil, "Tank")
local warnWebWrap				= mod:NewTargetAnnounce(219865, 2)

local specWarnFoundation		= mod:NewSpecialWarningSpell(219591)
local specWarnWebWrap			= mod:NewSpecialWarningSwitch(219865, "Dps")--Overkill? maybe just melee or just ranged or off by default

local timerCorrodingSprayCD		= mod:NewCDTimer(23.2, 219349, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFoundatoinCD			= mod:NewAITimer(90, 219591, nil, nil, nil, 6)
local timerWebWrapCD			= mod:NewCDTimer(36.9, 219865, nil, nil, nil, 3)

--local voiceFoundation			= mod:NewVoice(219591)--no voice ideas at all. Maybe needs new one
--local voiceWebWrap				= mod:NewVoice(219865, "Dps")--Maybe time for a "freeallies" or "freeplayers" voice?


--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 219349 then
		warnCorrodingSpray:Show()
		timerCorrodingSprayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 219861 then
		specWarnWebWrap:Show()
		timerWebWrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 219591 then
		specWarnFoundation:Show()
--		voiceFoundation:Play("")
		timerFoundatoinCD:start()
	elseif spellId == 219865 then
		warnWebWrap:CombinedShow(0.3, args.destName)
	end
end
