local mod	= DBM:NewMod(2487, "DBM-Party-Dragonflight", 2, 1197)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184018)
mod:SetEncounterID(2556)
mod:SetUsedIcons(8)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 369675 369754 369703",
	"SPELL_CAST_SUCCESS 369605",
	"SPELL_SUMMON 369618"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, warn trogg Ambush casts?
--TODO, target scan thundering slam to notify direction of attack?
--TODO, rangecheck for chain lighting? it doesn't tell what range of "nearby enemy" means
local warnCalloftheDeep							= mod:NewSpellAnnounce(369605, 3)
local warnBloodlust								= mod:NewSpellAnnounce(369754, 3)

local specWarnQuakingTotem						= mod:NewSpecialWarningSwitch(369700, "-Healer", nil, nil, 1, 2)
local specWarnChainLightning					= mod:NewSpecialWarningInterrupt(369675, "HasInterrupt", nil, nil, 1, 2)
local specWarnThunderingSlam					= mod:NewSpecialWarningDodge(369703, nil, nil, nil, 2, 2)
--local yellThunderingSlam						= mod:NewYell(369703)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerCalloftheDeepCD						= mod:NewAITimer(35, 369605, nil, nil, nil, 1)
local timerQuakingTotemCD						= mod:NewAITimer(35, 369700, nil, nil, nil, 5)
local timerThunderingSlamCD						= mod:NewAITimer(35, 369703, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnTotem", 369618, true, 5, {8})

function mod:OnCombatStart(delay)
	timerCalloftheDeepCD:Start(1-delay)
	timerQuakingTotemCD:Start(1-delay)
	timerThunderingSlamCD:Start(1-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 369675 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChainLightning:Show(args.sourceName)
		specWarnChainLightning:Play("kickcast")
	elseif spellId == 369754 then
		warnBloodlust:Show()
	elseif spellId == 369703 then
		specWarnThunderingSlam:Show()
		specWarnThunderingSlam:Play("shockwave")
		timerThunderingSlamCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 369605 then
		warnCalloftheDeep:Show()
		timerCalloftheDeepCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 369618 then
		specWarnQuakingTotem:Show()
		specWarnQuakingTotem:Play("attacktotem")
		timerQuakingTotemCD:Start()
		if self.Options.SetIconOnTotem then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnTotem")
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
