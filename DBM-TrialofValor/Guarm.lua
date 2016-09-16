local mod	= DBM:NewMod(1830, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114344)
mod:SetEncounterID(1962)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227514",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 228818 228810 228818",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, licks timers and announces?
--TODO, smarter breath warnings based on debuffs and such. Maybe infoframe
--TODO, More Volatile Foam stuff
--TODO, add appropriate voices when strategy is more understood
local warnFangs						= mod:NewSpellAnnounce(227514, 2, nil, "Tank")

local specWarnBreath				= mod:NewSpecialWarningCount(228187, nil, nil, nil, 1, 2)
local specWarnFlamingFoam			= mod:NewSpecialWarningYou(228744, nil, nil, nil, 1, 2)
local specWarnBrineyFoam			= mod:NewSpecialWarningYou(228810, nil, nil, nil, 1, 2)
local specWarnShadowyFoam			= mod:NewSpecialWarningYou(228818, nil, nil, nil, 1, 2)
--local yellFocusedGaze				= mod:NewYell(198006)
local specWarnLeap					= mod:NewSpecialWarningDodge(227883, nil, nil, nil, 2, 2)
local specWarnCharge				= mod:NewSpecialWarningDodge(227816, nil, nil, nil, 2, 2)

local timerFangsCD					= mod:NewAITimer(40, 228187, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBreathCD					= mod:NewAITimer(40, 228187, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerLeapCD					= mod:NewAITimer(40, 227883, nil, nil, nil, 3)
local timerChargeCD					= mod:NewAITimer(40, 227816, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

--local voiceFocusedGaze				= mod:NewVoice(198006, "-Tank")--targetyou/share

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
--mod:AddInfoFrameOption(198108, true)
mod:AddRangeFrameOption(5, "ej14463")

mod.vb.breathCount = 0

function mod:OnCombatStart(delay)
	self.vb.breathCount = 0
	timerFangsCD:Start(1-delay)
	timerBreathCD:Start(1-delay)
	timerLeapCD:Start(1-delay)
	timerChargeCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227514 then
		warnFangs:Show()
		timerFangsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197943 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228744 then
		if args:IsPlayer() then
			specWarnFlamingFoam:Show()
		end
	elseif spellId == 228810 then
		if args:IsPlayer() then
			specWarnBrineyFoam:Show()
		end
	elseif spellId == 228818 then
		if args:IsPlayer() then
			specWarnShadowyFoam:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198006 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then

	end
end
--]]

--Better to just assume things aren't in cobmat log anymore, then switch if they actually are.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227573 then--Guardian's Breath
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnBreath:Show(self.vb.breathCount)
		timerBreathCD:Start()
	elseif spellId == 227883 then--Roaring Leap
		specWarnLeap:Show()
		timerLeapCD:Start()
	elseif spellId == 227816 then--Headlong Charge
		specWarnCharge:Show()
		timerChargeCD:Start()
	end
end
