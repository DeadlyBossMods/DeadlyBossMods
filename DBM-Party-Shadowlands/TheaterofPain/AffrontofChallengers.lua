local mod	= DBM:NewMod(2397, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164451, 164463, 164461)--Dessia, Paceran, Sathel
mod:SetEncounterID(2391)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320063",
	"SPELL_CAST_SUCCESS 320069 320272 320248 333231 333222 320063 333540",
	"SPELL_AURA_APPLIED 320069 324085 320272 320293 333231 333540 333222",
	"SPELL_PERIODIC_DAMAGE 320180",
	"SPELL_PERIODIC_MISSED 320180",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--[[
ability.id = 320063 and type = "begincast"
 or (ability.id = 320069 or ability.id = 320272 or ability.id = 333222 or ability.id = 320248 or ability.id = 333231 or ability.id = 333540) and type = "cast"
 or (ability.id = 324085 or ability.id = 320293) and (type = "applybuff" or type = "applydebuff")
 or (target.id = 164451 or target.id = 164463 or target.id = 164461) and type = "death"
--]]
--Dessia the Decapitator
local warnSlam							= mod:NewSpellAnnounce(320063, 3, nil, "Tank")
local warnMortalStrike					= mod:NewTargetNoFilterAnnounce(320069, 3, nil, "Tank|Healer")
local warnEnrage						= mod:NewTargetNoFilterAnnounce(324085, 3)
--Paceran the Virulent
local warnGeneticAlteration				= mod:NewSpellAnnounce(320248, 2)--Goes on everyone
--Sathel the Accursed
local warnSearingDeath					= mod:NewTargetAnnounce(333231, 3)
local warnOnewithDeath					= mod:NewTargetNoFilterAnnounce(320293, 3)
--Xira the Underhanded
local warnOpportunityStrikes			= mod:NewTargetNoFilterAnnounce(333540, 4)

--Dessia the Decapitator
local specWarnSlam						= mod:NewSpecialWarningDefensive(320063, false, nil, 2, 1, 2)--Cast very often, let this be an opt in
local specWarnEnrage					= mod:NewSpecialWarningDispel(324085, "RemoveEnrage", nil, nil, 1, 2)
--Paceran the Virulent
local specWarnGTFO						= mod:NewSpecialWarningGTFO(320180, nil, nil, nil, 1, 8)
--Sathel the Accursed
local specWarnSearingDeath				= mod:NewSpecialWarningMoveAway(333231, nil, nil, nil, 1, 2)
local yellSearingDeath					= mod:NewYell(333231)
local specWarnSpectralTransference		= mod:NewSpecialWarningDispel(320272, "MagicDispeller", nil, nil, 1, 2)

--Dessia the Decapitator
local timerMortalStrikeCD				= mod:NewCDTimer(21.8, 320069, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--21.8-32.7
local timerSlamCD						= mod:NewCDTimer(7.4, 320063, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--7.4-10.9
--Paceran the Virulent
local timerNoxiousSporeCD				= mod:NewCDTimer(16.1, 320180, nil, nil, nil, 3)
--Sathel the Accursed
local timerSearingDeathCD				= mod:NewCDTimer(11.7, 333231, nil, nil, nil, 3)--11.7-24
local timerSpectralTransferenceCD		= mod:NewCDTimer(14.8, 320272, nil, nil, nil, 5, nil, DBM_CORE_L.MAGIC_ICON)--15-24
--Xira the Underhanded
--local timerOpportunityStrikesCD			= mod:NewCDTimer(60, 333540, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)

function mod:OnCombatStart(delay)
	--Dessia
	timerSlamCD:Start(9.4-delay)
	timerMortalStrikeCD:Start(22.6-delay)--SUCCESS (Health based?), 22-26 from some data but 2nd cast gets worse 21-32 variance in logs
	--Paceran
	timerNoxiousSporeCD:Start(17.7-delay)
	--Sathel
	timerSearingDeathCD:Start(10.2-delay)--SUCCESS
	timerSpectralTransferenceCD:Start(10.5-delay)--SUCCESS
--	if self:IsDifficulty("challenge5") then
--		timerOpportunityStrikesCD:Start(61.4-delay)--SUCCESS
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320063 and self:AntiSpam(4, 1) then--Boss can stutter cast this (self interrupt and start cast over)
		if self.Options.SpecWarn320063defensive2 then
			specWarnSlam:Show()
			specWarnSlam:Play("defensive")
		else
			warnSlam:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320069 then
--		timerMortalStrikeCD:Start()
	elseif spellId == 320272 or spellId == 333222 then--Seems to have two spellIds in older logs but may be fixed in newer ones
		timerSpectralTransferenceCD:Start()
	elseif spellId == 320248 then
		warnGeneticAlteration:Show()
	elseif spellId == 333231 then
		timerSearingDeathCD:Start()
	elseif spellId == 320063 then
		timerSlamCD:Start(6.4)--Started in success do to stutter casting, cast time removed from CD
--	elseif spellId == 333540 then
--		timerOpportunityStrikesCD:Start()--Not seen more than once during a pull, rarely even see it once
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320069 then
		warnMortalStrike:Show(args.destName)
	elseif spellId == 324085 then
		if self.Options.SpecWarn324085dispel then
			specWarnEnrage:Show(args.destName)
		else
			warnEnrage:Show(args.destName)
		end
	elseif spellId == 320272 or spellId == 333222 then--Seems to have two spellIds in older logs but may be fixed in newer ones
		specWarnSpectralTransference:Show(args.destName)--Combined because of Mass Transference
		specWarnSpectralTransference:Play("dispelboss")
	elseif spellId == 320293 then
		warnOnewithDeath:Show(args.destName)
	elseif spellId == 333231 then
		if args:IsPlayer() then
			specWarnSearingDeath:Show()
			specWarnSearingDeath:Play("runout")
			yellSearingDeath:Yell()
		else
			warnSearingDeath:Show(args.destName)
		end
	elseif spellId == 333540 then
		warnOpportunityStrikes:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320180 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164451 then--Dessia the Decapitator
		timerMortalStrikeCD:Stop()
		timerSlamCD:Stop()
	elseif cid == 164463 then--Paceran the Virulent
		timerNoxiousSporeCD:Stop()
	elseif cid == 164461 then--Sathel the Accursed
		timerSpectralTransferenceCD:Stop()
		timerSearingDeathCD:Stop()
	end
end

--"<48.53 02:10:59> [UNIT_SPELLCAST_SUCCEEDED] Paceran the Virulent(??) -Noxious Spore- [[boss3:Cast-3-2084-2293-25939-324118-000024A504:324118]]
--"<52.18 02:11:03> [CLEU] SPELL_AURA_APPLIED#Creature-0-2084-2293-25939-164463-000024A49F#Paceran the Virulent#Player-970-004E060B#Viterratwo-TheMaw#320180#Noxious Spore#DEBUFF#nil", -- [579]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 324118  then--Noxious Spore (spawn event)
		timerNoxiousSporeCD:Start()
	end
end
