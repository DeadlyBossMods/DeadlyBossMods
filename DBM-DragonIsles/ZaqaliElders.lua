if DBM:GetTOC() < 101000 then return end
local mod	= DBM:NewMod(2531, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(203220, 203219)--Vakan, Gholna
mod:SetEncounterID(2696)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--local warnBindingIce					= mod:NewTargetAnnounce(389954, 2)
--
--local specWarnGlacialStorm				= mod:NewSpecialWarningDodge(389289, nil, nil, nil, 2, 2)
--
--local timerGlacialStormCD				= mod:NewAITimer(22.1, 389289, nil, nil, nil, 3)

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

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 389159 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 389954 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 389960 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:389762") then

	end
end
--]]
