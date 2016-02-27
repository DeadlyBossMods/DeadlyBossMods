local mod	= DBM:NewMod(1479, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91808)
mod:SetEncounterID(1813)
mod:SetZone(1456)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_SPELLCAST_SUCCEEDED"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 191855",
	"SPELL_CAST_START 192003 192005",
	"SPELL_CAST_SUCCESS 191855",
	"SPELL_DAMAGE 191858",
	"SPELL_MISSED 191858"
)

--TODO, verify heroic+ Arcane Blast
--If complicated enough, setup interrupt rotation helper
local warnToxicWound				= mod:NewTargetAnnounce(191855, 2)
local warnWinds						= mod:NewSpellAnnounce(191798, 2)

local specWarnToxicWound			= mod:NewSpecialWarningRun(191855, nil, nil, nil, 1, 2)
local specWarnSubmerge				= mod:NewSpecialWarningSpell(191873, nil, nil, nil, 2)
local specWarnToxicPool				= mod:NewSpecialWarningMove(191858, nil, nil, nil, 1, 2)
local specWarnBlazingNova			= mod:NewSpecialWarningInterrupt(192003, "HasInterrupt", nil, nil, 1, 2)
local specWarnArcaneBlast			= mod:NewSpecialWarningInterrupt(192005, "HasInterrupt", nil, nil, 1, 2)

--Next timers always, unless rampage is not interrupted (Boss will not cast anything else during rampages)
local timerToxicWoundCD				= mod:NewNextTimer(25, 191855, nil, nil, nil, 3)
local timerWindsCD					= mod:NewNextTimer(30, 191798, nil, nil, nil, 2)

local voiceToxicWound				= mod:NewVoice(191855)--justrun/keepmove
local voiceToxicPuddle				= mod:NewVoice(191855)--runaway
local voiceBlazingNova				= mod:NewVoice(192003, "HasInterrupt")--kickcast
local voiceArcaneBlast				= mod:NewVoice(192005, "HasInterrupt")--kickcast

local wrathMod = DBM:GetModByName(1492)

function mod:UpdateWinds()
	timerWindsCD:Cancel()
end

function mod:OnCombatStart(delay)
	timerToxicWoundCD:Start(6-delay)
	timerWindsCD:Start(33-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 191855 then
		warnToxicWound:Show(args.destName)
		if args:IsPlayer() then
			specWarnToxicWound:Show()
			voiceToxicWound:Play("justrun")
			voiceToxicWound:Schedule(1.5, "keepmove")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192003 and self:CheckInterruptFilter(args.sourceGUID) then--Blazing Nova
		specWarnBlazingNova:Show(args.sourceName)
		voiceBlazingNova:Play("kickcast")
	elseif spellId == 192005 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnArcaneBlast:Show(args.sourceName)
		voiceArcaneBlast:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 191855 then
		timerToxicWoundCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 191858 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnToxicPool:Show()
		voiceToxicPuddle:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 191798 and self:AntiSpam(3, 2) then--Violent Winds
		if wrathMod.vb.phase == 2 then return end--Phase 2 against Wrath of Azshara, which means this is happening every 10 seconds
		warnWinds:Show()
		if self:IsInCombat() then--Boss engaged it's 30
			timerWindsCD:Start()
		else--Zone wide after boss died, it's every 90 seconds
			timerWindsCD:Start(90)
		end
	elseif spellId == 191873 then--Submerge
		specWarnSubmerge:Show()
	end
end
