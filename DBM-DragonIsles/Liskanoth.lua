local mod	= DBM:NewMod(2518, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(193533)
mod:SetEncounterID(2652)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 389159 391026 388925",
	"SPELL_CAST_SUCCESS 389954",
	"SPELL_AURA_APPLIED 389960",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, tweak sounds/warning types?
local warnBindingIce					= mod:NewTargetAnnounce(389954, 2)
local warnChillingBreath				= mod:NewSpellAnnounce(388925, 3, nil, "Tank|Healer", nil, nil, nil, 2)

local specWarnGlacialStorm				= mod:NewSpecialWarningDodge(389289, nil, nil, nil, 2, 2)
local specWarnDeepFreeze				= mod:NewSpecialWarningDodge(389762, nil, nil, nil, 2, 2)
local specWarnBindingIce				= mod:NewSpecialWarningYou(389954, nil, nil, nil, 1, 2)

local timerGlacialStormCD				= mod:NewAITimer(22.1, 389289, nil, nil, nil, 3)
local timerDeepFreezeCD					= mod:NewAITimer(74.7, 389762, nil, nil, nil, 3)
local timerBindingIceCD					= mod:NewAITimer(74.7, 389954, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerChillingBreathCD				= mod:NewAITimer(9.7, 388925, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddRangeFrameOption(5, 361632)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 389159 then
		specWarnGlacialStorm:Show()
		specWarnGlacialStorm:Play("watchstep")
		timerGlacialStormCD:Start()
--	elseif spellId == 391026 then
--		specWarnDeepFreeze:Show()
--		specWarnDeepFreeze:Play("watchstep")
--		timerDeepFreezeCD:Start()
	elseif spellId == 388925 then
		warnChillingBreath:Show()
		warnChillingBreath:Play("breathsoon")
		timerChillingBreathCD:Start()
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 389954 then
		timerBindingIceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 389960 then
		warnBindingIce:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBindingIce:Show()
			specWarnBindingIce:Play("targetyou")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361632 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 361335 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:389762") then
		specWarnDeepFreeze:Show()
		specWarnDeepFreeze:Play("watchstep")
		timerDeepFreezeCD:Start()
	end
end
