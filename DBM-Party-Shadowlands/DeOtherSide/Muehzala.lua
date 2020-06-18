local mod	= DBM:NewMod(2410, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(169769)
mod:SetEncounterID(2396)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325258 327646 326171",
	"SPELL_CAST_SUCCESS 325725 324698 326171 327426",
	"SPELL_AURA_APPLIED 325725",
	"SPELL_AURA_REMOVED 325725",
	"UNIT_DIED"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, might use 324698 (Deathgate) instead of Shatter Reality for Phase 2 trigger
--TODO, do anything with https://shadowlands.wowhead.com/spell=335000/stellar-cloud ? I suspect it's just a mechanic for going too far out
--TODO, restart phase 1 timers when Phase 2 phases end
--Stage 1: The Master of Death
local warnCosmicArtifice			= mod:NewTargetAnnounce(325725, 3)
local warnShatterReality			= mod:NewCastAnnounce(326171, 4)
--Stage 2: Shattered Reality
local warnAddsRemaining				= mod:NewAddsLeftAnnounce("ej22186", 2, 264049)--A nice shackle icon

--Stage 1: The Master of Death
local specWarnMasterofDeath			= mod:NewSpecialWarningDodge(325258, nil, nil, nil, 2, 2)
local specWarnCosmicArtifice		= mod:NewSpecialWarningMoveAway(325725, nil, nil, nil, 1, 2)
local yellCosmicArtifice			= mod:NewYell(325725)
local yellCosmicArtificeFades		= mod:NewShortFadesYell(325725)
local specWarnSoulcrusher			= mod:NewSpecialWarningDefensive(327646, "Tank", nil, nil, 2, 2)
local specWarnDeathgate				= mod:NewSpecialWarningMoveTo(324698, nil, nil, nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Stage 2: Shattered Reality

--Stage 1: The Master of Death
local timerMasterofDeathCD			= mod:NewAITimer(15.8, 325258, nil, nil, nil, 3)
local timerCosmicArtificeCD			= mod:NewAITimer(13, 325725, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerSoulcrusherCD			= mod:NewAITimer(13, 327646, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Stage 2: Shattered Reality

mod.vb.addsLeft = 3

function mod:OnCombatStart(delay)
	timerMasterofDeathCD:Start(1-delay)
	timerCosmicArtificeCD:Start(1-delay)
	timerSoulcrusherCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325258 then
		specWarnMasterofDeath:Show()
		specWarnMasterofDeath:Play("watchwave")
		timerMasterofDeathCD:Start()
	elseif spellId == 327646 then
		specWarnSoulcrusher:Show()
		specWarnSoulcrusher:Play("defensive")
		timerSoulcrusherCD:Start()
	elseif spellId == 326171 then--Phase 1 End and big aoe
		timerMasterofDeathCD:Stop()
		timerCosmicArtificeCD:Stop()
		timerSoulcrusherCD:Stop()
		warnShatterReality:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325725 then
		timerCosmicArtificeCD:Start()
	elseif spellId == 324698 then--Deathgate finished
		specWarnDeathgate:Show(args.spellName)
	elseif spellId == 326171 then--Shattered Reality ending (Phase 2 begin)
		timerCosmicArtificeCD:Start(2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325725 then
		if args:IsPlayer() then
			specWarnCosmicArtifice:Show()
			specWarnCosmicArtifice:Play("runout")
			yellCosmicArtifice:Yell()
			yellCosmicArtificeFades:Countdown(spellId)
		else
			warnCosmicArtifice:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 325725 then
		if args:IsPlayer() then
			yellCosmicArtificeFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 168326 then--Shattered Visage
		self.vb.addsLeft = self.vb.addsLeft - 1
		warnAddsRemaining:Show(self.vb.addsLeft)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
