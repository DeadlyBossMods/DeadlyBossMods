local mod	= DBM:NewMod(2102, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(126832)
mod:SetEncounterID(2093)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 256016 256060",
	"SPELL_CAST_START 255952 256106 272046",
	"SPELL_CAST_SUCCESS 256005",
	"SPELL_PERIODIC_DAMAGE 256016",
	"SPELL_PERIODIC_MISSED 256016",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, target scan charge?
--TODO, imrprove PowderShot warning, I honestly don't remember what it did, tooltip says cone/shockwave?
--(ability.id = 255952 or ability.id = 256106) and type = "begincast" or (ability.id = 256056 or ability.id = 256060 or ability.id = 256005) and type = "cast"
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnVilebombardment			= mod:NewSpellAnnounce(256005, 2, nil, false)--Every 6 seconds so off by default
local warnPowderShot				= mod:NewSpellAnnounce(256106, 2)

local specWarnCharge				= mod:NewSpecialWarningDodge(255952, nil, nil, nil, 2, 2)
local specWarnDiveBomb				= mod:NewSpecialWarningDodge(272046, nil, nil, nil, 2, 2)
--local specWarnPowderShot			= mod:NewSpecialWarningSpell(256106, nil, nil, nil, 2, 2)--Dodge?
local specWarnBrew					= mod:NewSpecialWarningInterrupt(256060, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(256016, nil, nil, nil, 1, 8)

local timerChargeCD					= mod:NewCDTimer(8.4, 255952, nil, nil, nil, 3)
local timerDiveBombCD				= mod:NewCDTimer(17, 272046, nil, nil, nil, 3)
local timerPowderShotCD				= mod:NewCDTimer(10.8, 256106, nil, nil, nil, 3)
local timerVilebombardmentCD		= mod:NewCDTimer(5.9, 256005, nil, nil, nil, 3)
local timerBrewCD					= mod:NewCDTimer(20.6, 256060, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerChargeCD:Start(4.7-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 256016 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 256060 then
		specWarnBrew:Show(args.sourceName)
		specWarnBrew:Play("kickcast")
		timerBrewCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 255952 then
		specWarnCharge:Show()
		specWarnCharge:Play("chargemove")
		timerChargeCD:Start()
	elseif spellId == 256106 then
		warnPowderShot:Show()
		--specWarnPowderShot:Show()
		--specWarnPowderShot:Play("shockwave")--Review, I barely remember fight it died so fast
		timerPowderShotCD:Start()
	elseif spellId == 272046 then
		specWarnDiveBomb:Show()
		specWarnDiveBomb:Play("watchstep")
		timerDiveBombCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 256005 then
		warnVilebombardment:Show()
		timerVilebombardmentCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 256016 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 256056 then--Spawn Parrot
		timerChargeCD:Stop()
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerVilebombardmentCD:Start(6.2)
		timerPowderShotCD:Start(7.3)--5.4 (old)
		timerBrewCD:Start(20.6)--15.8 (old)
		if not self:IsNormal() then
			timerDiveBombCD:Start(17.7)
		end
	end
end
