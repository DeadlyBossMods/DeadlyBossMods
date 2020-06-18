local mod	= DBM:NewMod(2398, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164450)
mod:SetEncounterID(2400)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320230",
	"SPELL_CAST_SUCCESS 319619 320326"
--	"SPELL_AURA_APPLIED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, update Blastwave to a special warning?
local warnDisplacementTrap			= mod:NewSpellAnnounce(319619, 2)
local warnDisplacedBlastwave		= mod:NewSpellAnnounce(320326, 2)

local specWarnExplosiveContrivance	= mod:NewSpecialWarningMoveTo(320230, nil, nil, nil, 3, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDisplacementTrapCD		= mod:NewAITimer(13, 319619, nil, nil, nil, 3)
local timerDisplacedBlastwaveCD		= mod:NewAITimer(13, 320326, nil, nil, nil, 3)
local timerExplosiveContrivanceCD	= mod:NewAITimer(15.8, 320230, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)

local trapName = DBM:GetSpellInfo(319619)

function mod:OnCombatStart(delay)
	timerDisplacementTrapCD:Start(1-delay)
	timerDisplacedBlastwaveCD:Start(1-delay)
	timerExplosiveContrivanceCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320230 then
		specWarnExplosiveContrivance:Show(trapName)
		specWarnExplosiveContrivance:Play("findshelter")
		timerExplosiveContrivanceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 319619 then
		warnDisplacementTrap:Show()
		timerDisplacementTrapCD:Start()
	elseif spellId == 319619 then
		warnDisplacedBlastwave:Show()
		timerDisplacedBlastwaveCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

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
