local mod	= DBM:NewMod(1395, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91349)--91305 Fel Iron Summoner
mod:SetEncounterID(1795)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181126 181132 181557 183376 181793 181792 181738 181799 182084 185830 181948 182040 182076 182077",
	"SPELL_CAST_SUCCESS 181255 181180 181190 181597 182006",
	"SPELL_AURA_APPLIED 181099 181275 181191 181354 181597 187347 182006",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 181099 181275",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more usages for range frame?
--TODO, no cast start events for Fel Implosion or Inferno? Find earlier event for them if possible, maybe target scan for location of impacts
--TODO, figure out fel streak target scan
--TODO, verify 91349 is correct Mannoroth health/death id. It's only one listed in critiera for achievement. It's possible all ids are used and it needs to be changed every phase for boss health
--TODO, verify spellids and ranges of empowered felseekers and their ranges
--TODO, do voices later, for this fight i need a lot of clarity first.
--Adds
----Doom Lords
local warnCurseoftheLegion			= mod:NewTargetAnnounce(181275, 3)--Spawn
local warnMarkofDoom				= mod:NewTargetAnnounce(181099, 4)
----Fel Imp
local warnFelImplosion				= mod:NewSpellAnnounce(181255, 3)--Spawn
----Dread Infernals
local warnInferno					= mod:NewSpellAnnounce(181180, 3)--Spawn
local warnFelStreak					= mod:NewSpellAnnounce(181190, 3)--Change to target scan/personal/near warning if possible
--Mannoroth
local warnGaze						= mod:NewTargetAnnounce(181597, 3)
local warnFelseeker					= mod:NewCountAnnounce(181735, 3, nil, false)

--Adds
----Doom Lords
local specWarnCurseofLegion			= mod:NewSpecialWarningYou(181275)
local yellCurseofLegion				= mod:NewFadesYell(181275)--Don't need to know when it's applied, only when it's fading does it do aoe/add spawn
local specWarnMarkOfDoom			= mod:NewSpecialWarningYou(181099)
local yellMarkOfDoom				= mod:NewYell(181099)--This need to know at apply, only player needs to know when it's fading
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(181126, "-Healer")
----Fel Imps
local specWarnFelBlast				= mod:NewSpecialWarningInterrupt(181132, "-Healer")
----Dread Infernals
local specWarnFelHellfire			= mod:NewSpecialWarningRun(181191, "Melee", nil, nil, 4)
--Mannoroth
local specWarnGlaiveCombo			= mod:NewSpecialWarningSpell(181354, "Tank", nil, nil, 3)--Active mitigation or die mechanic
local specWarnMassiveBlast			= mod:NewSpecialWarningSpell(181359, "Tank")--Swap Mechanic
local specWarnFelHellStorm			= mod:NewSpecialWarningSpell(181557, nil, nil, nil, 2)
local specWarnGaze					= mod:NewSpecialWarningYou(181597)
local yellGaze						= mod:NewYell(181597)
local specWarnFelSeeker				= mod:NewSpecialWarningSpell(181735, nil, nil, nil, 2)
local specWarnShadowForce			= mod:NewSpecialWarningSpell(181799, nil, nil, nil, 2)

--Adds
----Doom Lords
local timerCurseofLegionCD			= mod:NewAITimer(107, 181275)
--local timerMarkofDoomCD			= mod:NewCDTimer(107, 181099, nil, "-Tank")
--local timerShadowBoltVolleyCD		= mod:NewCDTimer(107, 181126, nil, "-Healer")
----Fel Imps
local timerFelImplosionCD			= mod:NewAITimer(107, 181255)
--local timerFelBlastCD				= mod:NewCDTimer(107, 181126, nil, false)--Somehow I suspect this is not a priority timer
----Infernals
local timerInfernoCD				= mod:NewAITimer(107, 181180)
----local timerFelStreakCD			= mod:NewCDTimer(107, 181190)
--Mannoroth
local timerGlaiveComboCD			= mod:NewAITimer(107, 181354, nil, "Tank")
local timerFelHellstormCD			= mod:NewAITimer(107, 181557)
local timerGazeCD					= mod:NewAITimer(107, 181597, nil, "-Tank")--Maybe tank helps, but for now, try to reduce timer spam for tanks who already have 2 extras
local timerFelSeekerCD				= mod:NewAITimer(107, 181735)
local timerShadowForceCD			= mod:NewAITimer(107, 181799)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownMarkOfDoom			= mod:NewCountdownFades("Alt15", 181099)

--local voiceInfernoSlice				= mod:NewVoice(155080)

mod:AddRangeFrameOption(20, 181099)

mod.vb.DoomTargetCount = 0

local AddsSeen = {}
local debuffFilter
local debuffName = GetSpellInfo(181099)
local UnitDebuff = UnitDebuff
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.DoomTargetCount > 0 then
		if UnitDebuff("Player", debuffName) then
			DBM.RangeCheck:Show(20)
		else
			DBM.RangeCheck:Show(20, debuffFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(AddsSeen)
	self.vb.DoomTargetCount = 0
	timerCurseofLegionCD:Start(1-delay)
	timerFelImplosionCD:Start(1-delay)
	timerInfernoCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181557 or spellId == 181948 then
		specWarnFelHellStorm:Show()
		timerFelHellstormCD:Start()
	elseif spellId == 181126 then
		--timerShadowBoltVolleyCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnShadowBoltVolley:Show(args.sourceName)
		end
	elseif spellId == 181132 then
		--timerFelBlastCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnFelBlast:Show(args.sourceName)
		end
	elseif spellId == 183376 or spellId == 185830 then
		specWarnMassiveBlast:Show()
	elseif spellId == 181793 or spellId == 182077 then--Melee (10)
		warnFelseeker:Show(10)
		--Maybe spec warn melee when it's this one
	elseif spellId == 181792 or spellId == 182076 then--Ranged (20)
		warnFelseeker:Show(20)
	elseif spellId == 181738 or spellId == 182040 then--Ranged (35)
		warnFelseeker:Show(35)
	elseif spellId == 181799 or spellId == 182084 then
		specWarnShadowForce:Show()
		timerShadowForceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181255 then--Imps
		warnFelImplosion:Show()
		timerFelImplosionCD:Start()
	elseif spellId == 181180 then--Infernals
		warnInferno:Show()
		timerInfernoCD:Start()
	elseif spellId == 181190 then
		warnFelStreak:Show()
		--timerFelStreakCD:Start(args.sourceGUID)
	elseif spellId == 181597 or spellId == 182006 then
		timerGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181275 then
		timerCurseofLegionCD:Start()
		if args:IsPlayer() then
			specWarnCurseofLegion:Show()
			local _, _, _, _, _, _, expires = UnitDebuff("Player", args.spellName)
			local debuffTime = expires - GetTime()
			yellCurseofLegion:Schedule(debuffTime - 1, 1)
			yellCurseofLegion:Schedule(debuffTime - 2, 2)
			yellCurseofLegion:Schedule(debuffTime - 3, 3)
			yellCurseofLegion:Schedule(debuffTime - 2, 4)
			yellCurseofLegion:Schedule(debuffTime - 5, 5)
		else
			warnCurseoftheLegion:Show(args.destName)
		end
	elseif spellId == 181099 then
		--timerMarkofDoomCD:Start(args.sourceGUID)
		self.vb.DoomTargetCount = self.vb.DoomTargetCount + 1
		if args:IsPlayer() then
			specWarnMarkOfDoom:Show()
			countdownMarkOfDoom:Start()
			yellMarkOfDoom:Yell()
		end
		updateRangeFrame(self)
	elseif spellId == 181191 and self:CheckInterruptFilter(args.sourceGUID, true) then--No sense in duplicating code, just use CheckInterruptFilter with arg to skip the filter setting check
		specWarnFelHellfire:Show()--warn melee who are targetting infernal to run out if it's exploding
	elseif spellId == 181354 or spellId == 187347 then
		specWarnGlaiveCombo:Show()
		timerGlaiveComboCD:Start()
	elseif spellId == 181597 or spellId == 182006 then
		warnGaze:CombinedShow(0.3, args.destName)--Assume multi for now, change to single if it's not
		if args:IsPlayer() then
			specWarnGaze:Show()
			yellGaze:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181099 then
		self.vb.DoomTargetCount = self.vb.DoomTargetCount - 1
		if args:IsPlayer() then
			countdownMarkOfDoom:Cancel()
		end
		updateRangeFrame(self)
	end
end

--Switch to SPELL_SUMMON events if they exist with their associated summon spells. Has to be an event that has GUID, for the timers
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 91241 then--Doom Lord
				--timerShadowBoltVolleyCD:Start(nil, unitGUID)
				--timerMarkofDoomCD:Start(nil, unitGUID)
			elseif cid == 91259 then--Fel Imp
				--timerFelBlastCD:Start(nil, unitGUID)
			elseif cid == 91270 then--Dread Infernal
				--timerFelStreakCD:Start(nil, unitGUID)
			elseif cid == 91409 or cid == 91369 or cid == 91349 or cid == 94362 then--Mannoroth, possibly all of them are used?
				DBM:Debug("Mannoroth is "..cid)
				timerGlaiveComboCD:Start(1)
				timerFelHellstormCD:Start(1)
				timerGazeCD:Start(1)
				timerFelSeekerCD:Start(1)
				--timerShadowForceCD:Start(1)--Doesn't gain ability first time he fires IEEU, only 2nd and 3rd. As such, until i know what CID is what phase, i cannot enable timer
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 91305 then--Fel Iron Summoner
		
	elseif cid == 91241 then--Doom Lord
		--timerMarkofDoomCD:Cancel(args.destGUID)
		--timerShadowBoltVolleyCD:Cancel(args.destGUID)
	elseif cid == 91259 then--Fel Imp
		--timerFelBlastCD:Cancel(args.destGUID)
	elseif cid == 91270 then--Dread Infernal
		--timerFelStreakCD:Cancel(args.destGUID)
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 181736 then--Felseeker. I suspect this is the first trigger, summoning a stalker npc to control the other casts
		specWarnFelSeeker:Show()
		timerFelSeekerCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
