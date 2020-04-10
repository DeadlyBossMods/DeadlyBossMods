local mod	= DBM:NewMod(2396, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2390)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 321368 321754 320788 323730 323198",
	"SPELL_AURA_REMOVED 321368 321754 320788 323730 323198",
	"SPELL_CAST_START 320772",
	"SPELL_CAST_SUCCESS 320788 323730 321894"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify comet of storm trigger
local warnIceboundAegis				= mod:NewTargetNoFilterAnnounce(321754, 4)
local warnFrozenBinds				= mod:NewTargetNoFilterAnnounce(323730, 3)
local warnDarkExile					= mod:NewTargetNoFilterAnnounce(321894, 3)

local specWarnCometStorm			= mod:NewSpecialWarningDodge(320772, nil, nil, nil, 2, 2)
local specWarnFrozenBinds			= mod:NewSpecialWarningYou(323730, nil, nil, nil, 1, 2)
local specWarnFrozenBindsNear		= mod:NewSpecialWarningClose(323730, nil, nil, nil, 1, 2)
local yellFrozenBinds				= mod:NewYell(323730)
local yellFrozenBindsFades			= mod:NewShortYell(323730)
local specWarnDarkExile				= mod:NewSpecialWarningYou(321894, nil, nil, nil, 1, 5)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

--local timerAvastyeCD				= mod:NewAITimer(13, 257316, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerCometStormCD				= mod:NewAITimer(15.8, 320772, nil, nil, nil, 3)
local timerIceboundAegisCD			= mod:NewAITimer(15.8, 321754, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
local timerFrozenBindsCD			= mod:NewAITimer(15.8, 323730, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerDarkExileCD				= mod:NewAITimer(15.8, 321894, nil, nil, nil, 3)
local timerDarkExile				= mod:NewTargetTimer(50, 321894, nil, nil, nil, 5)

mod:AddInfoFrameOption(321754, true)

function mod:OnCombatStart(delay)
	timerCometStormCD:Start(1-delay)
	timerIceboundAegisCD:Start(1-delay)
	timerFrozenBindsCD:Start(1-delay)
	timerDarkExileCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320772 then
		specWarnCometStorm:Show()
		specWarnCometStorm:Play("watchstep")
		timerCometStormCD:Start()
--	elseif spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320788 or spellId == 323730 then
		timerFrozenBindsCD:Start()
	elseif spellId == 321894 then
		timerDarkExileCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321368 or spellId == 321754 then
		warnIceboundAegis:Show(args.destName)
		timerIceboundAegisCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 320788 or spellId == 323730 then
		if args:IsPlayer() then
			specWarnFrozenBinds:Show()
			specWarnFrozenBinds:Play("targetyou")
			yellFrozenBinds:Yell()
			yellFrozenBindsFades:Countdown(spellId)
		elseif self:CheckNearby(16, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnFrozenBindsNear:CombinedShow(0.3, args.destName)
			specWarnFrozenBindsNear:ScheduleVoice(0.3, "runaway")
		else
			warnFrozenBinds:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 323198 then
		timerDarkExile:Start(50, args.destName)
		if args:IsPlayer() then
			specWarnDarkExile:Show()
			specWarnDarkExile:Play("teleyou")
		else
			warnDarkExile:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321368 or spellId == 321754 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 320788 or spellId == 323730 then
		if args:IsPlayer() then
			yellFrozenBindsFades:Cancel()
		end
	elseif spellId == 323198 then
		timerDarkExile:Stop(args.destName)
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
