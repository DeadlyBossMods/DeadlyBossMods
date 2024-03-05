local mod	= DBM:NewMod("AberrusTrash", "DBM-Raids-Dragonflight", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 409612 406911",
--	"SPELL_CAST_SUCCESS 413785",
	"SPELL_AURA_APPLIED 411808 413785",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 411808 413785"
--	"UNIT_DIED"
)

--[[
(ability.id = 409612 or ability.id = 406911) and type = "begincast"
 or ability.id = 413785 and type = "cast"
]]--
local specWarnUmbralTorrent					= mod:NewSpecialWarningDodge(409612, nil, nil, nil, 2, 2)
local specWarnSlimeInjection				= mod:NewSpecialWarningMoveAway(411808, nil, nil, nil, 1, 2)
local yellSlimeInjection					= mod:NewYell(411808)
local yellSlimeInjectionFades				= mod:NewShortFadesYell(411808)
local specWarnDarkBindings					= mod:NewSpecialWarningMoveAway(413785, nil, nil, nil, 1, 2)
local yellDarkBindings						= mod:NewYell(413785)
local yellDarkBindingsFades					= mod:NewShortFadesYell(413785)
local specWarnBrutalCauterization			= mod:NewSpecialWarningInterrupt(406911, "HasInterrupt", nil, nil, 1, 2)

--local timerBrutalCauterizationCD			= mod:NewCDTimer(14.5, 406911, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 409612 and self:AntiSpam(5, 2) then
		specWarnUmbralTorrent:Show()
		specWarnUmbralTorrent:Play("watchorb")
	elseif spellId == 406911 then
		--local cid = self:GetCIDFromGUID(args.sourceGUID)
		--local timer = (cid == 201288) and 14.5 or 21--Sundered Champions have shorter cd than Sarek Cinderbreath
		--timerBrutalCauterizationCD:Start(timer, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBrutalCauterization:Show(args.sourceName)
			specWarnBrutalCauterization:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 411808 and args:IsPlayer() then
		specWarnSlimeInjection:Show()
		specWarnSlimeInjection:Play("scatter")
		yellSlimeInjection:Yell()
		yellSlimeInjectionFades:Countdown(spellId)
	elseif spellId == 413785 and args:IsPlayer() then
		specWarnDarkBindings:Show()
		specWarnDarkBindings:Play("scatter")
		yellDarkBindings:Yell()
		yellDarkBindingsFades:Countdown(spellId)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 411808 and args:IsPlayer() then
		yellSlimeInjectionFades:Cancel()
	elseif spellId == 413785 and args:IsPlayer() then
		yellDarkBindingsFades:Cancel()
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 201288 or cid == 205619 then--Sundered Champion & Sarek Cinderbreath
		timerBrutalCauterizationCD:Stop(args.destGUID)
	end
end
--]]
