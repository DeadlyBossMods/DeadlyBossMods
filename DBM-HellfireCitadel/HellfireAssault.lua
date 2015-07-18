local mod	= DBM:NewMod(1426, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90019)--Main ID is door, door death= win. 94515 Siegemaster Mar'tak
mod:SetEncounterID(1778)
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(13937)
mod.syncThreshold = 4
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184394 181155 185816 183452 181968 180945",
	"SPELL_AURA_APPLIED 180079 184243 180927 184369 180076",
	"SPELL_AURA_APPLIED_DOSE 184243",
	"SPELL_AURA_REMOVED 184369 184243",
	"SPELL_CAST_SUCCESS 184370",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"--Have to register all unit ids to catch the boss when she casts haste
)

--ability.id = 180927 and type = "applybuff" or overkill > 0 and target.name in ("Felfire Crusher", "Felfire Artillery", "Felfire Demolisher", "Felfire Flamebelcher")
--Siegemaster Mar'tak
local warnHowlingAxe				= mod:NewTargetAnnounce(184369, 3)
local warnFelfireMunitions			= mod:NewTargetAnnounce(180079, 1)
--Hellfire Reinforcements
local warnFelCaster					= mod:NewCountAnnounce("ej11411", 3, 181155)
local warnBerserker					= mod:NewCountAnnounce("ej11425", 3, 184243)
----Gorebound Berserker (tank add probably)
local warnSlam						= mod:NewStackAnnounce("OptionVersion2", 184243, 3, nil, false)--Useful, but optional, only useful if dps is too low
----Grand Corruptor U'rogg
local warnSiphon					= mod:NewTargetAnnounce(180076, 3, nil, "Healer")--Maybe needs to be special warning, who knows

--Felfire-Imbued Siege Vehicles
----Felfire Crusher
local warnFelfireCrusher			= mod:NewCountAnnounce("ej11439", 2, 160240)
----Felfire Flamebelcher
local warnFelfireFlamebelcher		= mod:NewCountAnnounce("ej11437", 2, 160240)
----Felfire Artillery
local warnFelfireArtillery			= mod:NewCountAnnounce("ej11435", 3, 160240)
----Felfire Demolisher (Heroic, Mythic)
local warnFelfireDemolisher			= mod:NewCountAnnounce("ej11429", 4, 160240)--Heroic & Mythic only
local warnNova						= mod:NewSpellAnnounce(180945, 3)
----Felfire Transporter (Mythic)
local warnFelfireTransporter		= mod:NewCountAnnounce("ej11712", 4, 160240)--Mythic Only
----Things

--Siegemaster Mar'tak
local specWarnHowlingAxe			= mod:NewSpecialWarningMoveAway(184369, nil, nil, nil, 1, 2)
local yellHowlingAxe				= mod:NewYell(184369)
local specWarnShockwave				= mod:NewSpecialWarningDodge(184394, nil, nil, nil, 2, 2)
--Hellfire Reinforcements
local specWarnReinforcements		= mod:NewSpecialWarningSwitch("ej11406", false, nil, 2)--Generic warning for tanks to pick up new adds if they want to enable it
----Gorebound Berserker (tank add)

--Some specail warnings for taunts or stacks or something here, probably.
----Gorebound Felcaster
local specWarnIncinerate			= mod:NewSpecialWarningInterrupt(181155, false)--Seems less important of two spells
local specWarnMetamorphosis			= mod:NewSpecialWarningSwitch(181968, "Dps")--Switch and get dead if they transform, they do TONS of damage transformed
local specWarnFelfireVolley			= mod:NewSpecialWarningInterrupt(183452, "-Healer")
----Contracted Engineer
local specWarnRepair				= mod:NewSpecialWarningInterrupt(185816, "-Healer", nil, nil, 1, 2)
----Grute

--Felfire-Imbued Siege Vehicles
local specWarnDemolisher			= mod:NewSpecialWarningSwitch("ej11429", "Dps", nil, nil, 1, 5)--Heroic & Mythic only. Does massive aoe damage, has to be killed asap

--Siegemaster Mar'tak
local timerHowlingAxeCD				= mod:NewCDTimer(8.47, 184369, nil, nil, nil, 3)
local timerShockwaveCD				= mod:NewCDTimer(8.5, 184394, nil, nil, nil, 3)
--Hellfire Reinforcements
local timerFelCastersCD				= mod:NewCDCountTimer(40, "ej11411", nil, nil, nil, 1, 181155)
local timerBerserkersCD				= mod:NewCDCountTimer(40, "ej11425", nil, nil, nil, 1, 184243)
----Gorebound Berserker (tank add probably)
--local timerSlamCD					= mod:NewCDTimer(107, 184243, nil, nil, nil, 5)
----Gorebound Felcaster

----Contracted Engineer

--Felfire-Imbued Siege Vehicles
local timerSiegeVehicleCD			= mod:NewTimer(60, "timerSiegeVehicleCD", 160240, nil, nil, 1)--Cannot find any short text timers that will fit the bill

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownHowlingAxe			= mod:NewCountdownFades("Alt7", 184369)
local countdownSlam					= mod:NewCountdownFades("Alt11", 184243, false)

local voiceHowlingAxe				= mod:NewVoice(184369)--runout
local voiceShockwave				= mod:NewVoice(184394)--shockwave
local voiceIncinerate				= mod:NewVoice(181155, false)--kick
local voiceFelfireVolley			= mod:NewVoice(180417, "-Healer")--kick
local voiceRepair					= mod:NewVoice(185816)--kickcast
local voiceFelfireSiegeVehicles		= mod:NewVoice("ej11428")--One option for all 5, because less cluttered options better in this case I think.

mod:AddRangeFrameOption(8, 184369)
mod:AddHudMapOption("HudMapOnAxe", 184369)
--mod:AddSetIconOption("SetIconOnAdds", "ej11411", false, true)--If last wave isn't dead before new wave, this icon option will screw up. A more complex solution may be needed. Or just accept that this will only work for guilds with high dps

mod.vb.vehicleCount = 0
mod.vb.felcasterCount = 0
mod.vb.felCastersAlive = 0
mod.vb.berserkerCount = 0
mod.vb.axeActive = false
--Vehicles spawn early if killed fast enough, these are times they spawn whether ready or not (still a very large variation)
local normalVehicleTimers = {72, 59, 63, 60, 58, 55, 38, 46}
local vehicleTimers = {62.7, 56.6, 60.9, 56.7, 60.9, 57.2, 40.3, 59.4}--Longest pull, 541 seconds. There is slight variation on them, 1-4 seconds
local mythicVehicleTimers = {19.6, 23.6, 54, 54, 36.5, 35.7, 12, 12.6, 30.3, 67, 68.5, 50.5, 55.5, 33.8, 33.4, 35, 31.7, 29.5, 25}--Done in a weird way, for dual timers support. Pretend it's two tables combined into 1. First time is time between1 and 3, second time between 2 and 4, etc.
--Not all the adds yell, so timers are only for the ones that do. this is first boss and I just don't care enough to write a scheduling function
--Especially do the variation in max spawn times AND the fact they spawn early if dps is high
local berserkerTimers = {55.9, 26, 14.4, 36.7, 38.8, 49.5, 66.8, 38.7, 65.8, 47.4}--30 (first) is omitted
local mythicberserkerTimers = {54.7, 59.6, 140.7, 39.7, 46.5, 28.5, 38.9}--29.5 (first) omitted
local felcasterTimers = {8.5, 32.2, 39.5, 45.6, 50.9, 31.1, 36.7, 10, 103.8, 0.3, 27.8, 47.2}--35 (first) is omitted
local mythicfelcasterTimers = {9.5, 160, 33.8, 49.4, 41.3, 44.9, 70.6}--35 (first) is omitted.
local axeDebuff = GetSpellInfo(184369)
local axeFilter
do
	axeFilter = function(uId)
		if UnitDebuff(uId, axeDebuff) then
			return true
		end
	end
end

local function updateRangeFrame(self, show)
	if not self.Options.RangeFrame then return end
	if show then
		if UnitDebuff("player", axeDebuff) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, axeFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.vehicleCount = 0
	self.vb.felcasterCount = 0
	self.vb.berserkerCount = 0
	self.vb.felCastersAlive = 0
	timerHowlingAxeCD:Start(4.7-delay)
	timerShockwaveCD:Start(5.8-delay)
	timerBerserkersCD:Start(29.5-delay, 1)
	timerFelCastersCD:Start(35-delay, 1)
	if self:IsMythic() then
		timerSiegeVehicleCD:Start(52.5-delay, "("..DBM_CORE_LEFT..")")
		timerSiegeVehicleCD:Start(55-delay, "("..DBM_CORE_RIGHT..")")
	else
		timerSiegeVehicleCD:Start(37.8-delay, "")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnAxe then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 184394 then
		specWarnShockwave:Show()
		voiceShockwave:Play("shockwave")
		timerShockwaveCD:Start()
	elseif spellId == 181155 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnIncinerate:Show(args.sourceName)
		voiceIncinerate:Play("kickcast")
	elseif spellId == 183452 and self:CheckInterruptFilter(args.sourceGUID) then--Two spellids because two different cast times (mob has two forms)
		specWarnFelfireVolley:Show(args.sourceName)
		voiceFelfireVolley:Play("kickcast")
	elseif spellId == 185816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 181968 and self:AntiSpam(3, 1) then
		specWarnMetamorphosis:Show()
	elseif spellId == 180945 then
		warnNova:Show()
	end
end
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 184370 then--Axe over
		updateRangeFrame(self)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180079 then
		warnFelfireMunitions:CombinedShow(2, args.destName)
	elseif spellId == 184243 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnSlam:Show(args.destName, amount)
		end
		if args:IsPlayer() then
			countdownSlam:Cancel()
			countdownSlam:Start()
		end
	elseif spellId == 180927 then--Vehicle Spawns
		self.vb.vehicleCount = self.vb.vehicleCount + 1
		local Count = self.vb.vehicleCount
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 90432 then--Felfire Flamebelcher
			warnFelfireFlamebelcher:Show(Count)
			voiceFelfireSiegeVehicles:Play("ej11437")
		elseif cid == 90410 then--Felfire Crusher
			warnFelfireCrusher:Show(Count)
			voiceFelfireSiegeVehicles:Play("ej11439")
		elseif cid == 90485 then--Felfire Artillery
			warnFelfireArtillery:Show(Count)
			voiceFelfireSiegeVehicles:Play("ej11435")
		elseif cid == 91103 then--Felfire Demolisher
			if self.Options.SpecWarnej11429switch then
				specWarnDemolisher:Show()
			else
				warnFelfireDemolisher:Show(Count)
			end
			voiceFelfireSiegeVehicles:Play("ej11429")
		elseif cid == 93435 then--Felfire Transporter
			warnFelfireTransporter:Show(Count)
			voiceFelfireSiegeVehicles:Play("ej11712")
		end
		if self:IsMythic() then
			--Confusing way to do it but it's best way to do it for dual timer support
			--Code will create left and right and center timers and will almost always show 2 timers at once for the split format of fight
			--Center timers are only exception
			if Count == 1 or Count == 3 or Count == 5 or Count == 12 or Count == 14 or Count == 16 or Count == 18 then--Left
				timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "("..DBM_CORE_LEFT..")")
				DBM:Debug("Starting a left vehicle timer")
				voiceFelfireSiegeVehicles:Schedule(1, "left")--Schedule voice here because it's a left vehicle starting a timer for another left vehicle
			elseif Count == 2 or Count == 4 or Count == 6 or Count == 13 or Count == 15 or Count == 17 or Count == 19 then--Right
				timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "("..DBM_CORE_RIGHT..")")
				DBM:Debug("Starting a right vehicle timer")
				voiceFelfireSiegeVehicles:Schedule(1, "right")--Schedule voice here because it's a right vehicle starting a timer for another right vehicle
			elseif Count == 11 then--Last center, start both next left and right timers
				timerSiegeVehicleCD:Start(mythicVehicleTimers[Count-1], "("..DBM_CORE_LEFT..")")--Time for this one stored in 10 slot in table
				timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "("..DBM_CORE_RIGHT..")")
				DBM:Debug("Starting a left and a right vehicle timer after center phase")
				voiceFelfireSiegeVehicles:Schedule(1, "center")
			elseif Count == 7 or Count == 8 or Count == 9 then--Center
				if Count == 8 then--Hack to allow timer not to overwrite another center timer
					timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "( "..DBM_CORE_MIDDLE.." )")
				else
					timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "("..DBM_CORE_MIDDLE..")")
				end
				DBM:Debug("Starting a Center timer")
				if Count == 7 then--Need a left voice
					voiceFelfireSiegeVehicles:Schedule(1, "left")
				elseif Count == 8 then--Now right voice
					voiceFelfireSiegeVehicles:Schedule(1, "right")
				else--Finally, center voice
					voiceFelfireSiegeVehicles:Schedule(1, "center")
				end
			elseif Count == 10 then--No timer started at 10
				DBM:Debug("Doing no timer for vehicle 10")
				voiceFelfireSiegeVehicles:Schedule(1, "center")
				return
			else
				DBM:AddMsg("No Vehicle timer information beyond this point. If you have log or video of this pull, please share it")
			end
		else
			timerSiegeVehicleCD:Cancel()--Cancel timer to prevent debug error, if all adds killed fast enough, next vehicle spawns early!
			if self:IsHeroic() then
				if vehicleTimers[Count] then
					timerSiegeVehicleCD:Start(vehicleTimers[Count], "")
				else
					DBM:AddMsg("No Vehicle timer information beyond this point. If you have log or video of this pull, please share it")
				end
			else
				if normalVehicleTimers[Count] then
					timerSiegeVehicleCD:Start(normalVehicleTimers[Count], "")
				else
					DBM:AddMsg("No Vehicle timer information beyond this point. If you have log or video of this pull, please share it")
				end
			end
		end
	elseif spellId == 184369 then
		warnHowlingAxe:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnHowlingAxe:Show()
			yellHowlingAxe:Yell()
			countdownHowlingAxe:Start()
			voiceHowlingAxe:Play("runout")
			updateRangeFrame(self, true)
		end
		if self.Options.HudMapOnAxe then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(184369, "highlight", args.destName, 5, 7, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	elseif spellId == 180076 then
		warnSiphon:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 184369 then
		if self.Options.HudMapOnAxe then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 184243 and args:IsPlayer() then
		countdownSlam:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 93858 then--Gorebound Berserker
		
	elseif cid == 93931 then--Gorebound Felcaster
		self.vb.felCastersAlive = self.vb.felCastersAlive - 1
	elseif cid == 93881 then--Contract Engineer
		
	end
end

local felCaster = EJ_GetSectionInfo(11411)
local berserker = EJ_GetSectionInfo(11425)
--local dragoon = EJ_GetSectionInfo(11407)--Unused, add has no yell at this time
--local SiegemasterMartak = EJ_GetSectionInfo(11484)--Unused, maybe used as a filter if needed
--Massive TODO. Get sides for mythic and only warn for side you are on if possible (iffy at best)
function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if msg == L.BossLeaving and self:AntiSpam(20, 2) then
		self:SendSync("BossLeaving")
	elseif npc == felCaster or npc == berserker then
		if self:AntiSpam(5, 6) then
			specWarnReinforcements:Show()
		end
		if npc == felCaster and self:LatencyCheck() then
			self:SendSync("Felcaster")
		elseif npc == berserker and self:LatencyCheck() then
			self:SendSync("Berserker")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 184913 and self:AntiSpam(20, 2) then--Haste (boss leaving)
		self:SendSync("BossLeaving")
	elseif spellId == 184350 and self:AntiSpam(3, 3) then--Actual axe cast.
		timerHowlingAxeCD:Start()
		updateRangeFrame(self, true)
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "BossLeaving" and self:AntiSpam(20, 5) then
		timerHowlingAxeCD:Cancel()
		countdownHowlingAxe:Cancel()
		timerShockwaveCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.HudMapOnAxe then
			DBMHudMap:Disable()
		end
	elseif msg == "Felcaster" then
		self.vb.felcasterCount = self.vb.felcasterCount + 1
		warnFelCaster:Show(self.vb.felcasterCount)
		--if self.Options.SetIconOnAdds then
			--Set icons starting at 6, not using skull and x, those will probably be used to auto mark terrors in a later feature
		--	self:ScanForMobs(93931, 0, 6-self.vb.felCastersAlive, nil, 0.2, 15)
		--end
		if self:IsMythic() then
			if mythicfelcasterTimers[self.vb.felcasterCount] then
				timerFelCastersCD:Start(mythicfelcasterTimers[self.vb.felcasterCount], self.vb.felcasterCount+1)
			end
		else
			if felcasterTimers[self.vb.felcasterCount] then
				timerFelCastersCD:Start(felcasterTimers[self.vb.felcasterCount], self.vb.felcasterCount+1)
			end
		end
		self.vb.felCastersAlive = self.vb.felCastersAlive + 1
	elseif msg == "Berserker" then
		self.vb.berserkerCount = self.vb.berserkerCount + 1
		warnBerserker:Show(self.vb.berserkerCount)
--		if self.Options.SetIconOnAdds then
--			self:ScanForMobs(93858, 0, 8, nil, 0.2, 12)
--		end
		if self:IsMythic() then
			if mythicberserkerTimers[self.vb.berserkerCount] then
				timerBerserkersCD:Start(mythicberserkerTimers[self.vb.berserkerCount], self.vb.berserkerCount+1)
			end
		else
			if berserkerTimers[self.vb.berserkerCount] then
				timerBerserkersCD:Start(berserkerTimers[self.vb.berserkerCount], self.vb.berserkerCount+1)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 6) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE--]]

