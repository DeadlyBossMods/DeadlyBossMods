local mod	= DBM:NewMod(2410, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(169769)
mod:SetEncounterID(2396)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325258 327646 326171",
	"SPELL_CAST_SUCCESS 325725 324698 326171 327426",
	"SPELL_AURA_APPLIED 325725 334970",
	"SPELL_AURA_REMOVED 325725 334970"
--	"UNIT_DIED"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, might use 324698 (Deathgate) instead of Shatter Reality for Phase 2 trigger
--TODO, do anything with https://shadowlands.wowhead.com/spell=335000/stellar-cloud ? I suspect it's just a mechanic for going too far out
--TODO, restart phase 1 timers when Phase 2 phases end
--[[
(ability.id = 325258 or ability.id = 327646 or ability.id = 326171) and type = "begincast"
 or (ability.id = 325725 or ability.id = 326171) and type = "cast"
 or ability.id = 334970 and type = "removebuff"
 or type = "death" and target.id = 168326
--]]
--Stage 1: The Master of Death
local warnCosmicArtifice			= mod:NewTargetAnnounce(325725, 3)
local warnShatterReality			= mod:NewCastAnnounce(326171, 4)
--Stage 2: Shattered Reality
--local warnAddsRemaining				= mod:NewAddsLeftAnnounce("ej22186", 2, 264049)--A nice shackle icon

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
local timerMasterofDeathCD			= mod:NewCDTimer(32.8, 325258, nil, nil, nil, 3)
local timerCosmicArtificeCD			= mod:NewCDCountTimer(19.5, 325725, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerSoulcrusherCD			= mod:NewCDCountTimer(17.8, 327646, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerShatterRealityCD			= mod:NewCDTimer(25.3, 326171, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
--Stage 2: Shattered Reality
local timerCoalescing				= mod:NewCastTimer(25, 334970, nil, nil, nil, 6)

--mod.vb.addsLeft = 3
mod.vb.cosmicCount = 0
mod.vb.soulCount = 0

function mod:OnCombatStart(delay)
	self.vb.cosmicCount = 0
	self.vb.soulCount = 0
	timerCosmicArtificeCD:Start(3.7-delay, 1)--SUCCESS
	timerSoulcrusherCD:Start(5.9-delay, 1)
	timerMasterofDeathCD:Start(9.3-delay)
	timerShatterRealityCD:Start(60)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325258 then
		specWarnMasterofDeath:Show()
		specWarnMasterofDeath:Play("watchwave")
		timerMasterofDeathCD:Start()
	elseif spellId == 327646 then
		self.vb.soulCount = self.vb.soulCount + 1
		specWarnSoulcrusher:Show()
		specWarnSoulcrusher:Play("defensive")
		if self.vb.soulCount % 2 == 0 then
			timerSoulcrusherCD:Start(10, self.vb.soulCount+1)
		else
			timerSoulcrusherCD:Start(20, self.vb.soulCount+1)
		end
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
		self.vb.cosmicCount = self.vb.cosmicCount + 1
		if self.vb.cosmicCount % 2 == 0 then
			timerCosmicArtificeCD:Start(10, self.vb.cosmicCount+1)
		else
			timerCosmicArtificeCD:Start(20, self.vb.cosmicCount+1)
		end
	elseif spellId == 324698 then--Deathgate finished
		specWarnDeathgate:Show(args.spellName)
		specWarnDeathgate:Play("findshelter")
---	elseif spellId == 326171 then--Shattered Reality ending (Phase 2 begin)
--		self.vb.cosmicCount = 0
--		timerCosmicArtificeCD:Start(2, 1)
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
			warnCosmicArtifice:CombinedShow(1, args.destName)
		end
	elseif spellId == 334970 then--Coalescing
		timerCoalescing:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 325725 then
		if args:IsPlayer() then
			yellCosmicArtificeFades:Cancel()
		end
	elseif spellId == 334970 then--Coalescing
		self.vb.cosmicCount = 0
		self.vb.soulCount = 0
		timerCoalescing:Stop()
		timerCosmicArtificeCD:Start(11.1, 1)--11-19 (maybe a case of pause/resume from previous stage?)
		timerMasterofDeathCD:Start(15.6)
		timerSoulcrusherCD:Start(21.8, 1)
		timerShatterRealityCD:Start(76.4)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 168326 then--Shattered Visage
		self.vb.addsLeft = self.vb.addsLeft - 1
		if self.vb.addsLeft >= 0 then--Apparently possible too kill more than 3?
			warnAddsRemaining:Show(self.vb.addsLeft)
		end
	end
end

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
