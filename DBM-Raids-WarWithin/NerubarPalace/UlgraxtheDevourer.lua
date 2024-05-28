local mod	= DBM:NewMod(2607, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(200927)
mod:SetEncounterID(2902)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 434776 441451 441452",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 439419"
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, proper detection of slathering Maw. is cast ID used now for the gather part, or run out part after gather?
--TODO, announce netting targets unfiltered?
--TODO, now boss seems to be mid rework so work on this mod haulted until some stuff clarified.
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(27649))
local warnStalkerNetting						= mod:NewTargetAnnounce(439419, 3)

local specWarnSlatheringMaw						= mod:NewSpecialWarningCount(434776, nil, nil, nil, 2, 2)
local specWarnStalkersWebbing					= mod:NewSpecialWarningDodgeCount(441451, nil, nil, nil, 2, 2)
--local yellSearingAftermath					= mod:NewShortYell(422577)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerSlatheringMawCD						= mod:NewAITimer(49, 434776, nil, nil, nil, 3)
local timerStalkersWebbingCD					= mod:NewAITimer(49, 441451, nil, nil, nil, 3)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.mawCount = 0
mod.vb.webbingCount = 0

function mod:OnCombatStart(delay)
	self.vb.mawCount = 0
	self.vb.webbingCount = 0
	timerSlatheringMawCD:Start(1-delay)
	timerStalkersWebbingCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 434776 then
		self.vb.mawCount = self.vb.mawCount + 1
		specWarnSlatheringMaw:Show()
		specWarnSlatheringMaw:Play("gathershare")
		timerSlatheringMawCD:Start()
	elseif spellId == 441451 or spellId == 441452 then
		self.vb.webbingCount = self.vb.webbingCount + 1
		specWarnStalkersWebbing:Show(self.vb.webbingCount)
		specWarnStalkersWebbing:Play("watchstep")
		timerStalkersWebbingCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 439419 then
		warnStalkerNetting:CombinedShow(0.5, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
