local mod	= DBM:NewMod(2485, "DBM-Party-Dragonflight", 7, 1202)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189232)
mod:SetEncounterID(2609)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 372107 372863 373017 373087",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 372858",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
	"SPELL_PERIODIC_DAMAGE 372820",
	"SPELL_PERIODIC_MISSED 372820"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, track https://www.wowhead.com/beta/spell=372860/searing-wounds stacks? there isn't a tank swap so it feels like something that naturally falls off somehow
--TODO, verify Molten Boulder target scan
local warnBurnout								= mod:NewCastAnnounce(373087, 4)

local specWarnSearingBlows						= mod:NewSpecialWarningDefensive(372858, nil, nil, nil, 1, 2)
local specWarnMoltenBoulder						= mod:NewSpecialWarningDodge(372107, nil, nil, nil, 1, 2)
local yellMoltenBoulder							= mod:NewYell(372107)
local specWarnRitualofBlazebinding				= mod:NewSpecialWarningSwitch(372863, nil, nil, nil, 1, 2)
local specWarnRoaringBlaze						= mod:NewSpecialWarningInterrupt(373017, "HasInterrupt", nil, nil, 1, 2)
local specWarnBurnout							= mod:NewSpecialWarningRun(373087, "Melee", nil, nil, 4, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(372820, nil, nil, nil, 1, 8)

local timerSearingBlowsCD						= mod:NewAITimer(35, 372858, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerMoltenBoulderCD						= mod:NewAITimer(35, 372107, nil, nil, nil, 3)
local timerRitualofBlazebindingCD				= mod:NewAITimer(35, 372863, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:BoulderTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellMoltenBoulder:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerMoltenBoulderCD:Start(1-delay)
	timerRitualofBlazebindingCD:Start(1-delay)
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
	if spellId == 372107 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "BoulderTarget", 0.1, 8, true)
		specWarnMoltenBoulder:Show()
		specWarnMoltenBoulder:Play("shockwave")
		timerMoltenBoulderCD:Start()
	elseif spellId == 372863 then
		specWarnRitualofBlazebinding:Show()
		specWarnRitualofBlazebinding:Play("killmob")
		timerRitualofBlazebindingCD:Start()
	elseif spellId == 373017 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRoaringBlaze:Show(args.sourceName)
		specWarnRoaringBlaze:Play("kickcast")
	elseif spellId == 373087 then
		if self.Options.SpecWarn373087run then
			specWarnBurnout:Show()
			specWarnBurnout:Play("justrun")
		else
			warnBurnout:Show()
		end
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
	if spellId == 372858 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSearingBlows:Show()
			specWarnSearingBlows:Play("defensive")
		end
		timerSearingBlowsCD:Start()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 372820 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
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
