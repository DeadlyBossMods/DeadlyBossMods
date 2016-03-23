local mod	= DBM:NewMod(1490, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91789)
mod:SetEncounterID(1811)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 193698",
	"SPELL_CAST_START 193682 193597 193611"
)

--TODO, maybe add a "get back in arena warning" if you take Crackling THunder damage
--TODO, more curse notes perhaps? Add special warning for player maybe?
--[[
1. Healer--193712+18
2. 3 dps--193716+24.5
3. healer--193712+16.5
4. Everyone--193717+30
5. 1 healer, 1 tank, 1 dps--193716+17
6. Everyone--193717+19
--]]
local warnCurseofWitch				= mod:NewTargetAnnounce(193698, 3)

local specWarnStaticNova			= mod:NewSpecialWarningMoveTo(193597, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(193597), nil, 3)
local specWarnFocusedLightning		= mod:NewSpecialWarningMoveTo(193611, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon:format(193611), nil, 1)
local specWarnAdds					= mod:NewSpecialWarningSwitch(193682, "Tank")

local timerAddsCD					= mod:NewCDTimer(47, 193682, nil, nil, nil, 1)
local timerStaticNovaCD				= mod:NewCDTimer(35, 193597, nil, nil, nil, 2)
local timerFocusedLightningCD		= mod:NewNextTimer(15.5, 193611, nil, nil, nil, 3)

--local voiceCurtainOfFlame			= mod:NewVoice(153392)

local land = GetSpellInfo(166716)
local water = RELIC_SLOT_TYPE_WATER

function mod:OnCombatStart(delay)
	timerStaticNovaCD:Start(10.5-delay)
	timerAddsCD:Start(19-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193698 then
		warnCurseofWitch:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193682 then
		specWarnAdds:Show()
		timerAddsCD:Start()
	elseif spellId == 193597 then
		specWarnStaticNova:Show(land)
		timerFocusedLightningCD:Start()
		specWarnFocusedLightning:Schedule(10, water)--5 seconds before focused lightning cast
--	elseif spellId == 193611 then--Maybe not needed at all
		
	end
end
