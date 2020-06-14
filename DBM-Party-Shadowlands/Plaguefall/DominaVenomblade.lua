local mod	= DBM:NewMod(2423, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164266)
mod:SetEncounterID(2385)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 325552 333353",
	"SPELL_CAST_START 325552 332313",
	"SPELL_CAST_SUCCESS 325245"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, pre warn ambush target?
--Track https://shadowlands.wowhead.com/spell=325545/shadowsilk-bulwark or warn dispel?
--[[
(ability.id = 325457 or ability.id = 325552 or ability.id = 332313) and type = "begincast"
 or (ability.id = 325245) and type = "cast"
--]]
--TODO, shadowclone removed and replaced with adds?
--TODO, obviously better timer data, plus make sure stuff even is time based and not health
local warnAmbush					= mod:NewTargetNoFilterAnnounce(325245, 4)

--local specWarnShadowclone			= mod:NewSpecialWarningSpell(325457, nil, nil, nil, 2, 2)
local specWarnCytotoxicSlash		= mod:NewSpecialWarningDispel(325552, "RemovePoison", nil, nil, 1, 2)
local specWarnCytotoxicSlashTank	= mod:NewSpecialWarningDefensive(325552, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

--local timerShadowcloneCD			= mod:NewAITimer(13, 325457, nil, nil, nil, 6)
local timerBroodAssassinsCD			= mod:NewCDTimer(36.4, 332313, nil, nil, nil, 1)
local timerAmbushCD					= mod:NewCDTimer(20.6, 325245, nil, nil, nil, 3)--20-23
local timerCytotoxicSlashCD			= mod:NewCDTimer(20.6, 325552, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--20-23

mod:AddRangeFrameOption(5, 325245)

function mod:OnCombatStart(delay)
	timerAmbushCD:Start(11-delay)
	timerBroodAssassinsCD:Start(17.1-delay)
	timerCytotoxicSlashCD:Start(5-delay)--START
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325552 then
		timerCytotoxicSlashCD:Start()
	elseif spellId == 332313 then
		timerBroodAssassinsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325245 then
		timerAmbushCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325552 then
		if self.Options.SpecWarn325552dispel and self:CheckDispelFilter() then
			specWarnCytotoxicSlash:Show(args.destName)
			specWarnCytotoxicSlash:Play("helpdispel")
		elseif args:IsPlayer() then
			specWarnCytotoxicSlashTank:Show()
			specWarnCytotoxicSlashTank:Play("defensive")
		end
	elseif spellId == 333353 then
		warnAmbush:CombinedShow(0.3, args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
