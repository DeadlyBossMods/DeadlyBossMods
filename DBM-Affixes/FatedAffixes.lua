local mod	= DBM:NewMod("FatedAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2296, 2450, 2481)--Shadowlands Raids

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 372638",
	"SPELL_SUMMON 371254",
	"SPELL_AURA_APPLIED 369505 371447 371597 373156 372286",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 369505 372286"
--	"SPELL_DAMAGE",
--	"SPELL_MISSED"
)

--TODO, verify all spell Ids and functions of those spellIds
--TODO, if spell summon doesn't work for Emitter, https://www.wowhead.com/spell=373233/reconfiguration-emitter will probably work for detecting spawn
local warnChaoticDestruction					= mod:NewCastAnnounce(372638, 3)
local warnCreationSpark							= mod:NewTargetNoFilterAnnounce(369505, 3)
local warnProtoformBarrier						= mod:NewTargetNoFilterAnnounce(371447, 3)
local warnReconfigurationEmitter				= mod:NewSpellAnnounce(371254, 3)
local warnReplicatingEssence					= mod:NewTargetNoFilterAnnounce(372286, 3)

local specWarnCreationSpark						= mod:NewSpecialWarningYou(369505, nil, nil, nil, 1, 2)
local yellCreationSpark							= mod:NewYell(369505)
local specWarnCreationSparkSoak					= mod:NewSpecialWarningSoak(369505, nil, nil, nil, 2, 7)
local specWarnProtoformBarrier					= mod:NewSpecialWarningYou(371447, nil, nil, nil, 1, 2)
local specWarnReplicatingEssence				= mod:NewSpecialWarningYou(372286, nil, nil, nil, 1, 2)
local yellReplicatingEssence					= mod:NewYell(372286)
local yellReplicatingEssenceFades				= mod:NewShortFadesYell(372286)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 gtfo

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372638 and self:AntiSpam(3, 6) then
		warnChaoticDestruction:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 371254 and self:AntiSpam(3, 6) then
		warnReconfigurationEmitter:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 then
		warnCreationSpark:CombinedShow(0.3, args.destName)--Multiple?
		if args:IsPlayer() then
			specWarnCreationSpark:Show()
			specWarnCreationSpark:Play("targetyou")
		end
	elseif spellId == 371447 then
		warnProtoformBarrier:CombinedShow(0.3, args.destName)--Multiple?
		if args:IsPlayer() then
			specWarnProtoformBarrier:Show()
			specWarnProtoformBarrier:Play("targetyou")
		end
	elseif (spellId == 371597 or spellId == 373156) and self:AntiSpam(3, 6) then
		warnProtoformBarrier:Show(DBM_COMMON_L.ENEMIES)
	elseif spellId == 372286 then
		warnReplicatingEssence:CombinedShow(0.3, args.destName)--Multiple?
		if args:IsPlayer() then
			specWarnReplicatingEssence:Show()
			specWarnReplicatingEssence:Play("targetyou")
			yellReplicatingEssence:Yell()
			yellReplicatingEssenceFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 and self:AntiSpam(5, 2) then
		specWarnCreationSparkSoak:Show()
		specWarnCreationSparkSoak:Play("helpsoak")
	elseif spellId == 372286 then
		if args:IsPlayer() then
			yellReplicatingEssenceFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]
