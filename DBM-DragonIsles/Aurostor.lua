local mod	= DBM:NewMod(2562, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209574)
mod:SetEncounterID(2828)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20230516000000)
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
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"UNIT_DIED"
)


--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(403384, nil, nil, nil, 1, 8)

--local warnEnvelopingDarkness			= mod:NewTargetAnnounce(404171, 2)

--local specWarnUmbralSmash				= mod:NewSpecialWarningYou(403772, nil, nil, nil, 1, 2)

--local timerUmbralSmashCD				= mod:NewAITimer(22.1, 403772, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerBlazingPitchCD				= mod:NewAITimer(22.1, 403855, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 361632)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnRivalry then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 403772 then

	end
end
--]]

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 389954 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 407563 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 407563 then

	end
end
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 203220 then

	end
end
--]]

--Alerts if standing in stuff and you do not have opposite debuff that clears it
--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 403384 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then--Molten Pool
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
