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
	"SPELL_CAST_START 369675 369754 369703 382303",
	"SPELL_CAST_SUCCESS 369605"
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
--TODO, more of timers may be sequenced/alternating, just need multiple long pulls
--[[
(ability.id = 369754 or ability.id = 369703 or ability.id = 382303) and type = "begincast"
 or ability.id = 369605 and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
 or ability.id = 369675 and type = "begincast"
--]]
local warnCalloftheDeep							= mod:NewCountAnnounce(369605, 3)
local warnBloodlust								= mod:NewSpellAnnounce(369754, 3)

local specWarnQuakingTotem						= mod:NewSpecialWarningSwitch(369700, "-Healer", nil, nil, 1, 2)
local specWarnChainLightning					= mod:NewSpecialWarningInterrupt(369675, "HasInterrupt", nil, nil, 1, 2)
local specWarnThunderingSlam					= mod:NewSpecialWarningDodgeCount(369703, nil, nil, nil, 2, 2)
--local yellThunderingSlam						= mod:NewYell(369703)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerCalloftheDeepCD						= mod:NewCDCountTimer(35, 369605, nil, nil, nil, 1)
local timerQuakingTotemCD						= mod:NewCDTimer(42.2, 369700, nil, nil, nil, 5)
local timerBloodlustCD							= mod:NewCDTimer(41.1, 369754, nil, nil, nil, 5)
local timerThunderingSlamCD						= mod:NewCDCountTimer(35, 369703, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)

mod.vb.callCount = 0
mod.vb.thunderingCount = 0
--local callTimers = {5, 28.3, 38.4}
--local thunderingTimes = {12.9, 18.2, 27.8, 18.2}


function mod:OnCombatStart(delay)
	self.vb.callCount = 0
	self.vb.thunderingCount = 0
	timerCalloftheDeepCD:Start(5-delay, 1)
	timerThunderingSlamCD:Start(12.3-delay, 1)
	timerQuakingTotemCD:Start(20.8-delay)
	timerBloodlustCD:Start(25-delay)
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
		timerBloodlustCD:Start()
	elseif spellId == 369703 then
		self.vb.thunderingCount = self.vb.thunderingCount + 1
		specWarnThunderingSlam:Show(self.vb.thunderingCount)
		specWarnThunderingSlam:Play("shockwave")
		if self.vb.thunderingCount % 2 == 0 then
			timerThunderingSlamCD:Start(27.8, self.vb.thunderingCount+1)
		else
			timerThunderingSlamCD:Start(18.2, self.vb.thunderingCount+1)
		end
	elseif spellId == 382303 then
		specWarnQuakingTotem:Show()
		specWarnQuakingTotem:Play("attacktotem")
		timerQuakingTotemCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 369605 then
		self.vb.callCount = self.vb.callCount + 1
		warnCalloftheDeep:Show(self.vb.callCount)
		if self.vb.thunderingCount % 2 == 0 then
			timerCalloftheDeepCD:Start(38.4, self.vb.callCount+1)
		else
			timerCalloftheDeepCD:Start(28.3, self.vb.callCount+1)
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
