local mod	= DBM:NewMod(2398, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164450)
mod:SetEncounterID(2400)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320230",
	"SPELL_CAST_SUCCESS 324090",
	"SPELL_AURA_APPLIED 321948 323687",
	"SPELL_AURA_REMOVED 321948",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, update Blastwave to a special warning?
--TODO, longer logs, and M/M+ logs
--TODO, arcing lightning timer/frequency, and if it needs special warning
--Who needs the combat log anyways, certainly not blizzard.
--[[
(ability.id = 320230) and type = "begincast"
 or (ability.id = 324090 or ability.id = 323687) and type = "cast"
 or ability.id = 321948 and type = "applydebuff"
--]]
local warnDisplacementTrap			= mod:NewSpellAnnounce(319619, 2)
local warnDisplacedBlastwave		= mod:NewSpellAnnounce(320326, 2)
local warnLocalizedExplosive		= mod:NewTargetNoFilterAnnounce(321948, 4)
local warnArcaneLightning			= mod:NewTargetNoFilterAnnounce(323687, 2)

local specWarnExplosiveContrivance	= mod:NewSpecialWarningMoveTo(320230, nil, 201291, nil, 3, 2)--"Explosion" shortname
local specWarnLocalizedExplosive	= mod:NewSpecialWarningMoveTo(321948, nil, 188104, nil, 3, 2)--"Localized Explosion" shortname
local yellLocalizedExplosive		= mod:NewYell(321948)
local yellLocalizedExplosiveFades	= mod:NewShortFadesYell(321948)
local yellArcaneLightning			= mod:NewYell(323687)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDisplacementTrapCD		= mod:NewNextTimer(10.9, 319619, nil, nil, nil, 3)
local timerDisplacedBlastwaveCD		= mod:NewCDTimer(10.1, 320326, nil, nil, nil, 3)--10-15
local timerExplosiveContrivanceCD	= mod:NewCDTimer(35.1, 320230, 201291, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--"Explosion" shortname
local timerLocalizedExplosiveCD		= mod:NewCDTimer(35.1, 321948, 188104, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--"Localized Explosion" shortname
local timerArcaneLightningCD		= mod:NewCDTimer(7.2, 323687, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)--Only cast once

local trapName = DBM:GetSpellInfo(319619)

function mod:OnCombatStart(delay)
	timerDisplacementTrapCD:Start(6.1-delay)
	timerLocalizedExplosiveCD:Start(9.6-delay)
	timerDisplacedBlastwaveCD:Start(11.1-delay)
	timerExplosiveContrivanceCD:Start(31.6-delay)
	if self:IsDifficulty("challenge5") then
		timerArcaneLightningCD:Start(7.2)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320230 then
		specWarnExplosiveContrivance:Show(trapName)
		specWarnExplosiveContrivance:Play("findshelter")
		--timerExplosiveContrivanceCD:Start()--Unknown
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 324090 then
		warnDisplacedBlastwave:Show()
		timerDisplacedBlastwaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321948 then
		if args:IsPlayer() then
			specWarnLocalizedExplosive:Show(trapName)
			specWarnLocalizedExplosive:Play("targetyou")
			yellLocalizedExplosive:Yell()
			yellLocalizedExplosiveFades:Countdown(spellId)
		else
			warnLocalizedExplosive:Show(args.destName)
		end
	elseif spellId == 323687 then
		warnArcaneLightning:Show(args.destName)
		if args:IsPlayer() then
			yellArcaneLightning:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321948 then
		if args:IsPlayer() then
			yellLocalizedExplosiveFades:Cancel()
		end
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 321948 then--Localized Explosive Contrivance (No CLEU except debuff, which can be prevented)
		timerLocalizedExplosiveCD:Start()
	elseif spellId == 319619 then--Displacement Trap (No CLEU)
		warnDisplacementTrap:Show()
		timerDisplacementTrapCD:Start()
	end
end
