local mod	= DBM:NewMod(1426, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90019)--Main ID is door, door death= win. 94515 Siegemaster Mar'tak
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(13909)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184394 181155 185816 180417 183452 181968",
	"SPELL_AURA_APPLIED 180079 184238 184243 180927 184369 180076",
	"SPELL_AURA_APPLIED_DOSE 184243",
	"SPELL_AURA_REMOVED 184369",
	"SPELL_CAST_SUCCESS 184370",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"--Have to register all unit ids to catch the boss when she casts haste
)

--TODO, tank swaps for slam?
--TODO, add interrupt voice to volley of it actually is interruptable, if not, remove special warning instead.
--TODO, rework adds timers in absense of yells, plus see if blizzard changed way they spawn, since they seemed to be a bit more staggered in mythic
--TODO, on normal they changed vehicle spawn rates to be slower. But LFR had heroic rates, So now need to see if LFR also uses slower timers, for now, ASSUMING yes and coded it as such.
--Siegemaster Mar'tak
local warnHowlingAxe				= mod:NewTargetAnnounce(184369, 3)
local warnFelfireMunitions			= mod:NewTargetAnnounce(180079, 1)
--Hellfire Reinforcements
local warnReinforcements			= mod:NewCountAnnounce("ej11406", 3)--Needs icon
----Gorebound Berserker (tank add probably)
local warnSlam						= mod:NewStackAnnounce(184243, 3, nil, "Tank")--How many stacks to swap? or is there a swap?
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
----Felfire Transporter (Mythic)
local warnFelfireTransporter		= mod:NewCountAnnounce("ej11712", 4, 160240)--Mythic Only
----Things

--Siegemaster Mar'tak
local specWarnHowlingAxe			= mod:NewSpecialWarningMoveAway(184369, nil, nil, nil, 1, 2)
local yellHowlingAxe				= mod:NewYell(184369)
local specWarnShockwave				= mod:NewSpecialWarningDodge(184394, nil, nil, nil, 2, 2)
--Hellfire Reinforcements
local specWarnReinforcements		= mod:NewSpecialWarningSwitch("ej11406", "Tank")
----Gorebound Berserker (tank add)
local specWarnCower					= mod:NewSpecialWarningTaunt(184238, "Tank")
--Some specail warnings for taunts or stacks or something here, probably.
----Gorebound Felcaster
local specWarnIncinerate			= mod:NewSpecialWarningInterrupt(181155, false)--Seems less important of two spells, maybe both need interrupting though?
local specWarnMetamorphosis			= mod:NewSpecialWarningSwitch(181968, "Dps")--Switch and get dead if they transform, they do TONS of damage transformed
--local specWarnFelfireVolley		= mod:NewSpecialWarningInterrupt(180417, "-Healer")--Journal says interruptable, but it was not interruptable. what's the bug? journal or mob?
----Contracted Engineer
local specWarnRepair				= mod:NewSpecialWarningInterrupt(185816, "-Healer", nil, nil, 1, 2)
----Grute

--Felfire-Imbued Siege Vehicles
local specWarnDemolisher			= mod:NewSpecialWarningSwitch("ej11429", "Dps", nil, nil, 1, 5)--Heroic & Mythic only. Does massive aoe damage, has to be killed asap

--Siegemaster Mar'tak
local timerHowlingAxeCD				= mod:NewCDTimer(8.47, 184369)
local timerShockwaveCD				= mod:NewCDTimer(8.5, 184394)
--Hellfire Reinforcements
--local timerReinforcementsCD			= mod:NewCDCountTimer(40, "ej9713")--Not the real joural entry, but best and shortest name (11406 is real one, but Hellfire Reinforcements too long for timer)
----Gorebound Berserker (tank add probably)
--local timerCowerCD				= mod:NewCDTimer(107, 184238)
--local timerSlamCD					= mod:NewCDTimer(107, 184243)
----Gorebound Felcaster
--local timerFelfireVolleyCD		= mod:NewCDTimer(107, 180417, nil, "-Healer")
----Contracted Engineer

--Felfire-Imbued Siege Vehicles
local timerSiegeVehicleCD			= mod:NewTimer(60, "timerSiegeVehicleCD", 160240)--Cannot find any short text timers that will fit the bill

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownHowlingAxe			= mod:NewCountdownFades("Alt7", 184369)

local voiceHowlingAxe				= mod:NewVoice(184369)--runout
local voiceShockwave				= mod:NewVoice(184394)--shockwave
local voiceIncinerate				= mod:NewVoice(181155, false)--kick
--local voiceFelfireVolley			= mod:NewVoice(180417, "-Healer")--kick
local voiceRepair					= mod:NewVoice(185816)--kickcast
local voiceFelfireSiegeVehicles		= mod:NewVoice("ej11428")--One option for all 5, because less cluttered options better in this case I think.

mod:AddRangeFrameOption(8, 184369)
mod:AddHudMapOption("HudMapOnAxe", 184369)
--mod:AddSetIconOption("SetIconOnAdds", "ej11411", false, true)--If last wave isn't dead before new wave, this icon option will screw up. A more complex solution may be needed. Or just accept that this will only work for guilds with high dps

--[[
Times are not exact, there are variations, timer tables will probably use lowest seen variation between two vehicles
LFR/Normal Vehicles
0:39 Felfire Flamebelcher
1:43 Felfire Crusher
2:39 Felfire Artillery
3:42 Felfire Crusher
4:38 Felfire Flamebelcher
5:42 Felfire Artillery
6:40 Felfire Crusher
7:20 Felfire Flamebelcher
8:20 Felfire Crusher

Heroic Vehicles
0:39 Felfire Flamebelcher
1:43 Felfire Crusher
2:39 Felfire Artillery
3:42 Felfire Demolisher
4:38 Felfire Flamebelcher
5:42 Felfire Artillery
6:40 Felfire Demolisher
7:20 Felfire Flamebelcher
8:20 Felfire Crusher

Mythic Vehicles
https://www.warcraftlogs.com/reports/nvaX4f3P7GkxqmNc#type=summary&hostility=1&fight=12&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+180927+and+type+%3D+%22applybuff%22
https://www.warcraftlogs.com/reports/rQWG71xhLgnbvdYq#fight=12&type=summary&hostility=1&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+180927+and+type+%3D+%22applybuff%22
1-0:52.604 Felfire Artillery (Left)
2-0:55.101 Felfire Artillery (Right)
3-1:13.435 Felfire Demolisher (Left)
4-1:21.140 Felfire Flamebelcher (Right)
5-2:07.661 Felfire Flamebelcher (Left)
6-2:15.773 Felfire Demolisher (Right)
7-2:53.171 Felfire Artillery (Left)
8-3:01.320 Felfire Flamebelcher (Right)
9-**3:05.578 Felfire Transporter (carrying Grand Corruptor U'rogg) (Center)
10-**3:17.606 Felfire Crusher (Center)
11-**3:55.651 Felfire Demolisher (carrying Grute) (Center)
12-5:02.780 Felfire Flamebelcher (Left)
13-5:04.395 Felfire Artillery (Right)
14-5:53.196 Felfire Demolisher (Left)
15-6:00.048 Felfire Transporter (Right)
16-6:28.507 Felfire Flamebelcher (Left)
17-6:35.465 Felfire Demolisher (Right)
18-7:09.281 Felfire Demolisher (Left)
19-7:14.914 Felfire Flamebelcher (Right)
20-7:38.913 Felfire Transporter (Left)
21-7:40.126 Felfire Demolisher (Right)
--]]

mod.vb.vehicleCount = 0
--mod.vb.addsCount = 0
mod.vb.axeActive = false
--Vehicles spawn early if killed fast enough, these are times they spawn whether ready or not (still 2-3 sec variation)
--ability.id = 180927 and type = "applybuff" or overkill > 0 and target.name in ("Felfire Crusher", "Felfire Artillery", "Felfire Demolisher", "Felfire Flamebelcher")
local normalVehicleTimers = {72, 59, 63, 60, 58, 55, 38, 46}
local vehicleTimers = {62.7, 56.6, 60.9, 56.7, 60.9, 57.2, 40.3, 59.4}--Longest pull, 541 seconds. There is slight variation on them, 1-4 seconds
local mythicVehicleTimers = {20, 25, 54, 54, 44, 46, 12, 15.5, 50, 67, 68.5, 50.5, 55.5, 35, 35, 40, 39.5, 29.5, 25}--Done in a weird way, for dual timers support. Pretend it's two tables combined into 1. First time is time between1 and 3, second time between 2 and 4, etc.
--local addsTimers = {25, 45, 44, 44, 43, 43, 42, 42, 41, 40, 42, 40, 40}--Very tiny variance between pulls. Adds gradually get faster over time. that 42 is a strange fluke though. probably 40 with variance, the 40 before it i think should have been a 41 so the 42 was probably auto correction
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
--	self.vb.addsCount = 0
	timerHowlingAxeCD:Start(5-delay)
	timerShockwaveCD:Start(5.8-delay)
--	timerReinforcementsCD:Start(25-delay, 1)
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
--	elseif (spellId == 180417 or spellId == 183452) and self:CheckInterruptFilter(args.sourceGUID) then--Two spellids because two different cast times (mob has two forms)
--		specWarnFelfireVolley:Show(args.sourceName)
--		voiceFelfireVolley:Play("kickcast")
	elseif spellId == 185816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 181968 and self:AntiSpam(3, 1) then
		specWarnMetamorphosis:Show()
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
	elseif spellId == 184238 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--Its on a tank
			if not args:IsPlayer() and not UnitDebuff("player", args.spellName) then--But not us
				specWarnCower:Show(args.destName)--Taunt off other tank
			end
		end
	elseif spellId == 184243 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnSlam:Show(args.destName, amount)
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
				timerSiegeVehicleCD:Start(mythicVehicleTimers[Count], "("..DBM_CORE_MIDDLE..")")
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
		if self.Options.HudMapOnArt then
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
		if self.Options.HudMapOnArt then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 93858 then--Gorebound Berserker
		
	elseif cid == 93931 then--Gorebound Felcaster
		
	elseif cid == 93881 then--Contract Engineer
		
	end
end

--Wish there was another way, but there isn't. This requires localizing
function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if msg == L.AddsSpawn1 or msg == L.AddsSpawn2 then
		self:SendSync("Adds")
	elseif msg == L.BossLeaving and self:AntiSpam(20, 2) then
		self:SendSync("BossLeaving")
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
		--No longer reliable, blizz has disabled the yell most of time. it went from every adds set, to maybe 1 in 10 having yell.
		--Adds willneed videos and scheduled loops and other stupid shit since blizz likes to make mod authoring miserable
--[[	elseif msg == "Adds" and self:AntiSpam(20, 4) then
		self.vb.addsCount = self.vb.addsCount + 1
		if self.Options.SpecWarnej11406switchcount then
			specWarnReinforcements:Show(self.vb.addsCount)
		else
			warnReinforcements:Show(self.vb.addsCount)
		end
		local nextCount = self.vb.addsCount+1
		if addsTimers[nextCount] then
			timerReinforcementsCD:Start(addsTimers[nextCount], nextCount)
		end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(93931, 0, 8, nil, 0.2, 12)
		end--]]
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 6) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE--]]

