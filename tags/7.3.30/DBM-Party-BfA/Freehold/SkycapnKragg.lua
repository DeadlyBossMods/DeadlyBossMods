local mod	= DBM:NewMod(2102, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(126832)
mod:SetEncounterID(2093)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 256016 256060",
	"SPELL_CAST_START 255952 256106",
	"SPELL_CAST_SUCCESS 256056 256005",
	"SPELL_PERIODIC_DAMAGE 256016",
	"SPELL_PERIODIC_MISSED 256016"
)

--TODO, target scan charge?
--TODO, imrprove powershot warning, I honestly don't remember what it did, tooltip says cone/shockwave?
--(ability.id = 255952 or ability.id = 256106) and type = "begincast" or (ability.id = 256056 or ability.id = 256060 or ability.id = 256005) and type = "cast"
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnVilebombardment			= mod:NewSpellAnnounce(256005, 2, nil, false)--Every 6 seconds so off by default

local specWarnCharge				= mod:NewSpecialWarningDodge(255952, nil, nil, nil, 2, 2)
local specWarnPowderShot			= mod:NewSpecialWarningSpell(256106, nil, nil, nil, 2, 2)--Dodge?
--local yellSwirlingScythe			= mod:NewYell(195254)
local specWarnBrew					= mod:NewSpecialWarningInterrupt(256016, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(256016, nil, nil, nil, 1, 2)

local timerChargeCD					= mod:NewCDTimer(8.4, 255952, nil, nil, nil, 3)
local timerPowerShotCD				= mod:NewCDTimer(13.2, 256106, nil, nil, nil, 3)
local timerVilebombardmentCD		= mod:NewCDTimer(6, 256005, nil, nil, nil, 3)
local timerBrewCD					= mod:NewCDTimer(29, 256016, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerChargeCD:Start(4.7-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 256016 and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
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
	elseif spellId == 255952 then
		specWarnPowderShot:Show()
		specWarnPowderShot:Play("shockwave")--Review, I barely remember fight it died so fast
		timerPowerShotCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 256056 then--Spawn Parrot
		timerChargeCD:Stop()
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerPowerShotCD:Start(5.4)
		timerVilebombardmentCD:Start(6.5)
		timerBrewCD:Start(21)
	elseif spellId == 256005 then
		warnVilebombardment:Show()
		timerVilebombardmentCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 256016 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
