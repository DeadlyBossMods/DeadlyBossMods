local mod	= DBM:NewMod(2738, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(244761)
mod:SetEncounterID(3181)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--TODO, actually break down abilities by stage for easier UI navigation. Right now they're just in encounter event order
--TODO, i suspect voidstalker sting is more or less spammed and you just clear it with other mechanics before it's unmangable, adjust warnings if i'm wrong
--TODO, remove stuff that doesn't have timers or warnings
--TODO, announce https://www.wowhead.com/spell=1232467/grasp-of-emptiness cast or do PAs cover it
--TODO, figure out https://www.wowhead.com/spell=1239582/cosmic-overload for mythic only (169)
--TODO, fine other mythic only spells, likely tucked away in undocumented encounterID space
--TODO, add https://www.wowhead.com/beta/spell=1227557/devouring-cosmos private aura if it's NOT berserk
--This fight is was not tested. we don't have context for some stuff so there is a bit of guesswork with audio.
local warnRiftSimulacrum				= mod:NewSpellAnnounce(1261016, 2)--P2 Starting

local specWarnVoidExpulsion				= mod:NewSpecialWarningCount(1283236, nil, nil, nil, 2, 2)--P1+
--local specWarnSilverstrikeBarrage		= mod:NewSpecialWarningCount(1234564, nil, nil, nil, 2, 2)--Intermission 1
local specWarnSingularityEruption		= mod:NewSpecialWarningDodgeCount(1235622, nil, nil, nil, 2, 2)--Intermission 1
--local specWarnVoidstalkerSting		= mod:NewSpecialWarningCount(1237035, false, nil, nil, 2, 2)--Stage 2 non mythic
local specWarnCalloftheVoid				= mod:NewSpecialWarningSwitchCount(1237837, nil, nil, nil, 2, 2)--P2
local specWarnCosmicBarrier				= mod:NewSpecialWarningSwitchCount(1246918, "Dps", nil, nil, 2, 2)--P2
local specWarnDevouringCosmos			= mod:NewSpecialWarningSpell(1238843, nil, nil, nil, 3, 2)--P3
local specWarnDarkHand					= mod:NewSpecialWarningDefensive(1238844, nil, nil, nil, 1, 2)--P1 Tank Add
local specWarnRavenousAbyss				= mod:NewSpecialWarningRun(1243753, nil, nil, nil, 4, 2)--P1 Add
local specWarnInterruptingTremor		= mod:NewSpecialWarningCast(1243743, "SpellCaster", nil, nil, 1, 2)--P1 Add
local specWarnCosmicPortal				= mod:NewSpecialWarningCount(1261339, nil, nil, nil, 2, 2)--Mythic only mechanic of unknown nature
local specWarnRiftSlash					= mod:NewSpecialWarningDefensive(1246461, nil, nil, nil, 1, 2)--P2 Rift Simulacrum slash attack

local timerNullCoronaCD					= mod:NewCDCountTimer(20.5, 1233865, nil, nil, nil, 3)--P1+
local timerVoidExpulsionCD				= mod:NewCDCountTimer(20.5, 1283236, nil, nil, nil, 3)--P1+
local timerSilverstrikeArrowCD			= mod:NewCDCountTimer(20.5, 1233602, nil, nil, nil, 3)--P1/P3
local timerSilverstrikeBarrageCD		= mod:NewCDCountTimer(20.5, 1234564, nil, nil, nil, 3)--Intermission 1
local timerSingularityEruptionCD		= mod:NewCDCountTimer(20.5, 1235622, nil, nil, nil, 3)--Intermission 1
local timerVoidstalkerStingCD			= mod:NewCDCountTimer(20.5, 1237035, nil, nil, nil, 2)--Stage 2 non mythic
local timerCalloftheVoidCD				= mod:NewCDCountTimer(20.5, 1237837, nil, nil, nil, 1)--P2
local timerRangerCaptainsMarkCD			= mod:NewCDCountTimer(20.5, 1237614, nil, nil, nil, 3)--P3
local timerCosmicBarrierCD				= mod:NewCDCountTimer(20.5, 1246918, nil, nil, nil, 5)--P2
local timerAspectoftheEndCD				= mod:NewCDCountTimer(20.5, 1239111, nil, nil, nil, 3)--Intermission 2
local timerGraspofEmptynessCD			= mod:NewCDCountTimer(20.5, 1232470, nil, nil, nil, 3)--P1
local timerDevouringCosmosCD			= mod:NewCDCountTimer(20.5, 1238843, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)--P3
local timerDarkHandCD					= mod:NewCDCountTimer(20.5, 1238844, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P1 Tank Add
local timerRavenousAbyssCD				= mod:NewCDCountTimer(20.5, 1243753, nil, nil, nil, 2)--P1 Add
local timerInterruptingTremorCD			= mod:NewCDCountTimer(20.5, 1243743, "SpellCaster", nil, nil, 2)--P1 Add
local timerRiftSimulacrumCD				= mod:NewCDCountTimer(20.5, 1261016, nil, nil, nil, 6)--P2 Starting
local timerCosmicPortalCD				= mod:NewCDCountTimer(20.5, 1261339, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic only mechanic of unknown nature
local timerRiftSlashCD					= mod:NewCDCountTimer(20.5, 1246461, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P2 Rift Simulacrum slash attack
local timerStage2CD						= mod:NewCDTimer(20.5, 1272966, nil, nil, nil, 6)

mod:AddPrivateAuraSoundOption(1233865, true, 1233865, 1, 1)--Null Corona
mod:AddPrivateAuraSoundOption(1283236, true, 1283236, 1, 1)--Void Expulsion
mod:AddPrivateAuraSoundOption(1242553, true, 1283236, 1, 2)--Void Remnants (GTFO left by Void Expulsion)
mod:AddPrivateAuraSoundOption(1233602, true, 1233602, 1, 1)--Silverstrike Arrow
mod:AddPrivateAuraSoundOption(1243981, true, 1234564, 1, 3)--Silverstrike Barrage
--mod:AddPrivateAuraSoundOption(1234570, false, 1234570, 1, 1)--Stellar Emission (stacking debuff during Intermission 1)
mod:AddPrivateAuraSoundOption(1238206, true, 1238206, 1, 2)--Volatile Fissure
mod:AddPrivateAuraSoundOption(1237623, true, 1237614, 1, 1)--Ranger Captain's Mark
mod:AddPrivateAuraSoundOption(1239111, true, 1239111, 1, 1)--Aspect of the End
mod:AddPrivateAuraSoundOption(1255453, false, 1239111, 1, 3)--Gravity Collapse (Aspect of the End debuff)
mod:AddPrivateAuraSoundOption(1232470, true, 1232470, 1, 1)--Grasp of Emptiness
mod:AddPrivateAuraSoundOption(1243753, true, 1243753, 1, 3)--Failing to get out of Ravenous Abyss
mod:AddPrivateAuraSoundOption(1238708, true, 1238708, 1, 1)--Dark Rush

mod.vb.coronaCount = 0
mod.vb.expulsionCount = 0
mod.vb.voidExpulsionCount = 0
mod.vb.silverstrikeArrowCount = 0
mod.vb.silverstrikeBarrageCount = 0
mod.vb.singularityEruptionCount = 0
mod.vb.voidstalkerStingCount = 0
mod.vb.calloftheVoidCount = 0
mod.vb.rangerMarkCount = 0
mod.vb.cosmicBarrierCount = 0
mod.vb.aspectoftheEndCount = 0
mod.vb.graspofEmptynessCount = 0

function mod:OnLimitedCombatStart()
	self.vb.coronaCount = 0
	self.vb.expulsionCount = 0
	self.vb.voidExpulsionCount = 0
	self.vb.silverstrikeArrowCount = 0
	self.vb.silverstrikeBarrageCount = 0
	self.vb.singularityEruptionCount = 0
	self.vb.voidstalkerStingCount = 0
	self.vb.calloftheVoidCount = 0
	self.vb.rangerMarkCount = 0
	self.vb.cosmicBarrierCount = 0
	self.vb.aspectoftheEndCount = 0
	self.vb.graspofEmptynessCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	timerNullCoronaCD:SetTimeline(4)
	specWarnVoidExpulsion:SetAlert(5, "aesoon", 2, 2, 0)
	timerVoidExpulsionCD:SetTimeline(5)
	timerSilverstrikeArrowCD:SetTimeline(6)
--	specWarnSilverstrikeBarrage:SetAlert(7, "specialsoon", 2, 2)
	timerSilverstrikeBarrageCD:SetTimeline(7)
	specWarnSingularityEruption:SetAlert(8, "watchstep", 2, 2)
	timerSingularityEruptionCD:SetTimeline(8)
	timerVoidstalkerStingCD:SetTimeline(9)
	specWarnCalloftheVoid:SetAlert(10, "mobsoon", 2, 2)
	timerCalloftheVoidCD:SetTimeline(10)
	timerRangerCaptainsMarkCD:SetTimeline({11, 131})--Regular, Mythic?
	specWarnCosmicBarrier:SetAlert(12, "attackshield", 2, 2, 0)
	timerCosmicBarrierCD:SetTimeline(12)
	timerAspectoftheEndCD:SetTimeline(13)
	timerGraspofEmptynessCD:SetTimeline({14, 132})--Regular, Mythic?
	specWarnDevouringCosmos:SetAlert(15, "changeplatform", 19, 4)
	timerDevouringCosmosCD:SetTimeline(15)
	if self:IsTank() then
		specWarnDarkHand:SetAlert(64, "defensive", 2, 2)
	end
	timerDarkHandCD:SetTimeline(64)
	specWarnRavenousAbyss:SetAlert(65, "watchstep", 2, 2)
	timerRavenousAbyssCD:SetTimeline(65)
	specWarnInterruptingTremor:SetAlert(66, "stopcast", 2, 2, 0)
	timerInterruptingTremorCD:SetTimeline(66)
	warnRiftSimulacrum:SetAlert(135, "ptwo", 2, 2, 0)--Verify
	timerRiftSimulacrumCD:SetTimeline(135)
	specWarnCosmicPortal:SetAlert(136, "bigmobsoon", 2, 2)
	timerCosmicPortalCD:SetTimeline(136)
	if self:IsTank() then
		specWarnRiftSlash:SetAlert(137, "defensive", 2, 2)
	end
	timerRiftSlashCD:SetTimeline(137)
	timerStage2CD:SetTimeline(351)

	self:EnablePrivateAuraSound({1233865,1233887}, "absorbyou", 19)
	self:EnablePrivateAuraSound(1283236, "orbrun", 2)
	self:EnablePrivateAuraSound(1233602, "arrowyou", 19)
	self:EnablePrivateAuraSound(1243981, "debuffyou", 17)
	self:EnablePrivateAuraSound({1237623,1259861}, "markyou", 19)
	self:EnablePrivateAuraSound(1239111, "lineapart", 2)
	self:EnablePrivateAuraSound({1232470,1260027}, "graspyou", 19)
	self:EnablePrivateAuraSound(1255453, "debuffyou", 2)
	self:EnablePrivateAuraSound(1242553, "watchfeet", 8)
	self:EnablePrivateAuraSound(1243753, "debuffyou", 17)
--	self:EnablePrivateAuraSound(1234570, "debuffyou", 17)--Phase soft enrage, probably not worth annoucning, it kinda just persistently stacks
	self:EnablePrivateAuraSound(1238206, "watchfeet", 8)
	self:EnablePrivateAuraSound(1238708, "speedyou", 19)
end

--[[
--Note, bar stage changing and canceling is handled by core
function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
	if eventInfo.source ~= 0 then return end
	local eventID = eventInfo.id
--	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local timer = math.floor(eventInfo.duration + 0.5)
end
--]]
