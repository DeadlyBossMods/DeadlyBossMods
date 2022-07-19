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
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 374655"
	"SPELL_PERIODIC_DAMAGE 374854",
	"SPELL_PERIODIC_MISSED 374854",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify dragon strike target scan and spear target scan
--TODO, can fetter go on boss? Does it interrupt his lock phase (ie https://www.wowhead.com/beta/spell=374638/fetter)
local warnDragonStrike							= mod:NewTargetNoFilterAnnounce(373733, 3)
local warnGroundingSpear						= mod:NewTargetNoFilterAnnounce(373424, 3)
local warnFetter								= mod:NewTargetNoFilterAnnounce(374655, 2)--Player or boss

--local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnMagmaWave							= mod:NewSpecialWarningDodge(373742, nil, nil, nil, 2, 2)
--local yellInfusedStrikes						= mod:NewYell(361966)
local specWarnGroundingSpear					= mod:NewSpecialWarningYou(373424, nil, nil, nil, 1, 2)
local yellGroundingSpear						= mod:NewYell(373424)
--local specWarnDominationBolt					= mod:NewSpecialWarningInterrupt(363607, "HasInterrupt", nil, nil, 1, 2)
local specWarnBladeLock							= mod:NewSpecialWarningSpell(375056, nil, nil, nil, 2, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(374854, nil, nil, nil, 1, 8)

local timerDragonStrikeCD						= mod:NewAITimer(35, 373733, nil, nil, nil, 3, nil, DBM_COMMON_L.BLEED_ICON)
local timerMagmaWaveCD							= mod:NewAITimer(35, 373742, nil, nil, nil, 3)
local timerGroundingSpearCD						= mod:NewAITimer(35, 373424, nil, nil, nil, 3)
local timerFetter								= mod:NewTargetTimer(8, 374655, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerBladeLockCD							= mod:NewAITimer(35, 375056, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.DEADLY_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

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

function mod:OnCombatStart(delay)
	timerDragonStrikeCD:Start(1-delay)
	timerMagmaWaveCD:Start(1-delay)
	timerGroundingSpearCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 373733 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DragonStrikeTarget", 0.1, 8, true)
		timerDragonStrikeCD:Start(1-delay)
	elseif spellId == 373742 then
		specWarnMagmaWave:Show()
		specWarnMagmaWave:Play("watchwave")
		timerMagmaWaveCD:Start()
	elseif spellId == 373424 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "SpearTarget", 0.1, 8, true)
		timerGroundingSpearCD:Start()
	elseif spellId == 375056 then
		specWarnBladeLock:Show()
		specWarnBladeLock:Play("specialsoon")
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
		if not args:DestTypePlayer() then
			timerFetter:Start(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 374655 then
		if args:IsDestTypeHostile() then
			timerFetter:Stop(args.destName)
		end
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
