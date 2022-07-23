local mod	= DBM:NewMod(2490, "DBM-Party-Dragonflight", 4, 1199)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189340)
mod:SetEncounterID(2613)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 373733 373742 373424 375056",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 374655",
	"SPELL_AURA_REFRESH 374655",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 374655",
	"SPELL_PERIODIC_DAMAGE 374854",
	"SPELL_PERIODIC_MISSED 374854"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify dragon strike target scan and spear target scan
--TODO, Need a LOT more data to properly update timers around Fetter, right now sample size is literally 2 pulls
--TODO, same for uninterrupted Blade Lock
--TODO, boss has two diff sets of timers. One hwere he does magma at 15 seconds but dragon is 21 second cd, and one where he skips first magma but dragon is now 12sec cd
--[[
(ability.id = 373733 or ability.id = 373742 or ability.id = 373424 or ability.id = 375056) and type = "begincast"
 or ability.id = 374655 or ability.id = 375055 and (type = "applybuff" or type = "removebuff")
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnDragonStrike							= mod:NewTargetNoFilterAnnounce(373733, 3)
local warnGroundingSpear						= mod:NewTargetNoFilterAnnounce(373424, 3)
local warnFetter								= mod:NewTargetNoFilterAnnounce(374655, 1)--Boss Only

--local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnMagmaWave							= mod:NewSpecialWarningDodge(373742, nil, nil, nil, 2, 2)
--local yellInfusedStrikes						= mod:NewYell(361966)
local specWarnGroundingSpear					= mod:NewSpecialWarningYou(373424, nil, nil, nil, 1, 2)
local yellGroundingSpear						= mod:NewYell(373424)
local specWarnBladeLock							= mod:NewSpecialWarningInterrupt(375056, nil, nil, nil, 1, 13)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(374854, nil, nil, nil, 1, 8)

local timerDragonStrikeCD						= mod:NewCDTimer(12.1, 373733, nil, nil, nil, 3, nil, DBM_COMMON_L.BLEED_ICON)--12 but lowest spell queue priority, it's often delayed by several more seconds
local timerMagmaWaveCD							= mod:NewCDTimer(32.7, 373742, nil, nil, nil, 3)--Actual CD still not known, since you'd never fully see it unhindered by blade lock or reset by fetter
local timerGroundingSpearCD						= mod:NewCDTimer(8.9, 373424, nil, nil, nil, 3)
local timerFetter								= mod:NewTargetTimer(8, 374655, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerBladeLockCD							= mod:NewAITimer(35, 375056, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.DEADLY_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

mod.vb.magmawaveCount = 0

function mod:DragonStrikeTarget(targetname)
	if not targetname then return end
	warnDragonStrike:Show(targetname)
end

function mod:SpearTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnGroundingSpear:Show()
		specWarnGroundingSpear:Play("targetyou")
		yellGroundingSpear:Yell()
	else
		warnGroundingSpear:Show(targetname)
	end
end

--Notes:
--Boss has spell queung problems on top of varying timers, which can cause abilities to come in different orders and timings
--First magmawave is usually 15 sec into boss, but also soemtimes 26 and sometimes not cast at all before first blade lock
--And first blade lock can be anywhere between 30 seconds in and 44 seconds in despite fact it's based on bosses supposed to be consistent energy rate
--Yet he can't cast blade lock if he's casting something else so even his ultimate gets queued
--Then you have fetter, which can stun boss at at any time, which resets CDs on most abilities but not all of them
--For example if magmawave was cast recently before fetter stun then CD is set to about 12 seconds after stun ends, but if it was not cast recently before fetter the it's set to 3.5 after
--Dragon strike has a Cd of 12 but is almost always 20+ due to spell queue if boss cast Magma wave 15 seconds into fight
--But if boss didn't cast magma wave 15 seconds into fight then ability orders change and causes dragon strike to actually see it's cast every 12 seconds instead of every 20+
--TL/DR, timers on this boss, despite best efforts, are extremely hit or miss without excessive manual on the fly corrections (and that's pretty unreasonable to do for a lot of bosses)
function mod:OnCombatStart(delay)
	self.vb.magmawaveCount = 0
	timerDragonStrikeCD:Start(3.3-delay)
	timerGroundingSpearCD:Start(10.5-delay)
	timerMagmaWaveCD:Start(15-delay)--usually 15 but in rare cases boss flips ability order and this gets queued as far out as 32 which can cause it not to be ast at all before bladelock/fetter (which resets cd on magma)
	timerBladeLockCD:Start(29.2-delay)--29.2-44 variance even without fetter stuns done before first lock cast
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
	if spellId == 373733 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DragonStrikeTarget", 0.1, 8, true)
		timerDragonStrikeCD:Start()
	elseif spellId == 373742 then
		self.vb.magmawaveCount = self.vb.magmawaveCount + 1
		specWarnMagmaWave:Show()
		specWarnMagmaWave:Play("watchwave")
		timerMagmaWaveCD:Start()
	elseif spellId == 373424 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "SpearTarget", 0.1, 8, true)
		timerGroundingSpearCD:Start()
	elseif spellId == 375056 then
		specWarnBladeLock:Show()
		specWarnBladeLock:Play("chainboss")
		timerBladeLockCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 374655 then
		warnFetter:Show(args.destName)
		timerFetter:Stop(args.destName)
		timerFetter:Start(args.destName)
		timerGroundingSpearCD:Stop()
		timerMagmaWaveCD:Stop()
		timerDragonStrikeCD:Stop()
		timerBladeLockCD:Stop()
	end
end
mod.SPELL_AURA_REFRESHED = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 374655 then
		timerFetter:Stop(args.destName)
		timerDragonStrikeCD:Start(3.5)
		timerMagmaWaveCD:Start(self.vb.magmawaveCount == 0 and 3.5 or 12.8)--Seems to depend whether or not boss got to cast it at least one before first fetter
		timerGroundingSpearCD:Start(7.2)
--		timerBladeLockCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 374854 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
