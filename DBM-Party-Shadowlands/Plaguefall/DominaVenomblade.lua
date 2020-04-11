local mod	= DBM:NewMod(2423, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2385)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 325552",
	"SPELL_CAST_START 325457 325552",
	"SPELL_CAST_SUCCESS 325196"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, pre warn ambush target?
--Track https://shadowlands.wowhead.com/spell=325545/shadowsilk-bulwark or warn dispel?
local warnAmbush					= mod:NewSpellAnnounce(325196, 4)

local specWarnShadowclone			= mod:NewSpecialWarningSpell(325457, nil, nil, nil, 2, 2)
--local yellBlackPowder				= mod:NewYell(257314)
local specWarnVenomlance			= mod:NewSpecialWarningDispel(325552, "RemovePoison", nil, nil, 1, 2)
local specWarnVenomlanceTank		= mod:NewSpecialWarningDefensive(325552, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerShadowcloneCD			= mod:NewAITimer(13, 325457, nil, nil, nil, 6)
local timerAmbushCD					= mod:NewAITimer(15.8, 325196, nil, nil, nil, 3)
local timerVenomlanceCD				= mod:NewAITimer(13, 325552, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

mod:AddRangeFrameOption(5, 325196)

function mod:OnCombatStart(delay)
	timerAmbushCD:Start(1-delay)
	timerShadowcloneCD:Start(1-delay)
	timerVenomlanceCD:Start(1-delay)--START
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
	if spellId == 325457 then
		specWarnShadowclone:Show()
		specWarnShadowclone:Play("specialsoon")
		timerShadowcloneCD:Start()
	elseif spellId == 325552 then
		timerVenomlanceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325196 then
		warnAmbush:Show()
		timerAmbushCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325552 then
		if self.Options.SpecWarn325552dispel and self:CheckDispelFilter() then
			specWarnVenomlance:Show(args.destName)
			specWarnVenomlance:Play("helpdispel")
		elseif args:IsPlayer() then
			specWarnVenomlanceTank:Show()
			specWarnVenomlanceTank:Play("defensive")
		end
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
