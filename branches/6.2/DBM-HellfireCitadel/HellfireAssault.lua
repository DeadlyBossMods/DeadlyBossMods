local mod	= DBM:NewMod(1426, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90019)--Main ID is door, door death= win. 94515 Siegemaster Mar'tak
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184394 181155 183391 185816 184370",
	"SPELL_CAST_SUCCESS 180874 185025",
	"SPELL_AURA_APPLIED 184369 180264 184238 184243 180927",
	"SPELL_AURA_APPLIED_DOSE 184238 184243",
	"SPELL_AURA_REMOVED 184369",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Check target scanning on everything
--TODO, Timers for abilities, timers for add/vehicle spawns
--TODO, any GTFOs, HUDs, voices once mechanics better understood.
--TODO, make voices for the 4 tank types by name, similar to Blast Furnace adds.
--Siegemaster Mar'tak
local warnHowlingAxe				= mod:NewTargetAnnounce(184369, 3)
local warnFelfireMunitions			= mod:NewTargetAnnounce(180264, 1)--Total guesswork on spellid, might work, seems most logical spellid. Hoping this can be used to detect vehicles entering fight
--Hellfire Reinforcements
----Gorebound Berserker (tank add probably)
local warnCower						= mod:NewStackAnnounce(184238, 3, nil, "Tank")
local warnSlam						= mod:NewStackAnnounce(184243, 3, nil, "Tank")
----Gorebound Terror (transformed Gorebound Felcaster)
local warnDemonicLeap				= mod:NewTargetAnnounce(183391, 3)--Totally assumes target scanning, may be useless/fail
----Contracted Engineer
--Bomb announce maybe?
--Felfire-Imbued Siege Vehicles
----Felfire Crusher

--Add burn too?
----Felfire Flamebelcher

----Felfire Artillery
----Felfire Demolisher (Heroic, Mythic)
local warnFrontLineTransport		= mod:NewSpellAnnounce(180874, 3)
----Felfire Transporter (Mythic)
local warnCalltoArms				= mod:NewSpellAnnounce(185025, 3)

--Siegemaster Mar'tak
local specWarnHowlingAxe			= mod:NewSpecialWarningYou(184369)
local yellHowlingAxe				= mod:NewCountYell(184369)
local specWarnShockwave				= mod:NewSpecialWarningDodge(184394, nil, nil, nil, 2, nil, 2)--Hopefully not a spammy garrosh type situation
--Hellfire Reinforcements
----Gorebound Berserker (tank add probably)
--Some specail warnings for taunts or stacks or something here, probably.
----Gorebound Felcaster
local specWarnIncinerate			= mod:NewSpecialWarningInterrupt(181155, false)--Seems less important of two spells, maybe both need interrupting though?
local specWarnFelfireVolley			= mod:NewSpecialWarningInterrupt(180417, "-Healer")--On by default, cause it has a target filter after all and seems really important.
----Gorebound Terror (transformed Gorebound Felcaster)
local specWarnDemonicLeap			= mod:NewSpecialWarningYou(183391)
local yellDemonicLeap				= mod:NewCountYell(183391)
----Contracted Engineer
local specWarnRepair				= mod:NewSpecialWarningInterrupt(185816, "-Healer")
--Felfire-Imbued Siege Vehicles

--Siegemaster Mar'tak
local timerHowlingAxeCD				= mod:NewAITimer(107, 184369)
local timerShockwaveCD				= mod:NewAITimer(30, 184394)
--Hellfire Reinforcements
local timerReinforcementsCD			= mod:NewTimer(40, "timerReinforcementsCD")
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

local voiceShockwave				= mod:NewVoice(184394)--shockwave

mod:AddRangeFrameOption(8, 184369)
--mod:AddSetIconOption("SetIconOnAdds", "ej11411", false, true)

mod.vb.vehicleCount = 0
local vehicleTimers = {38, 62.7, 56.6, 60.9, 56.7, 60.9, 57.2, 43.3, 59.4}--Longest pull, 541 seconds. There is slight variation on them, 1-2 seconds
--Types: 1-Felfire Flamebelcher, 2-Felfire Crusher, 3-Felfire Artillery, 4-Felfire Demolisher, 5-Felfire Flamebelcher, 6-Felfire Artillery, 7-Felfire Demolisher, 8-Felfire Flamebelcher, 9-Felfire Crusher
local addsTimers = {25, 45, 44, 44, 43, 43, 42, 42, 41, 40, 42, 40, 40}--Very tiny variance between pulls. Adds gradually get faster over time. that 42 is a strange fluke though. probably 40 with variance, the 40 before it i think should have been a 41 so the 42 was probably auto correction

function mod:LeapTarget(targetname, uId)
	if not targetname then
		warnDemonicLeap:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		yellDemonicLeap:Yell()
		specWarnDemonicLeap:Show()
--	elseif self:CheckNearby(5, targetname) then--Lets see if it works first, i'll review nearby warning after
--		specWarnDemonicLeapNear:Show(targetname)
	else
		warnDemonicLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.vehicleCount = 0
	timerHowlingAxeCD:Start(1-delay)
	timerShockwaveCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
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
	elseif (spellId == 180417 or spellId == 183452) and self:CheckInterruptFilter(args.sourceGUID) then--Two spellids because two different cast times (mob has two forms)
		specWarnFelfireVolley:Show(args.sourceName)
	elseif spellId == 185816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRepair:Show(args.sourceName)
	elseif spellId == 183391 then
		self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.02, 30, true, nil, nil, nil, true)
	elseif spellId == 184370 then
		timerHowlingAxeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180874 then
		warnFrontLineTransport:Show()
	elseif spellId == 185025 then
		warnCalltoArms:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 184369 then
		warnHowlingAxe:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnHowlingAxe:Show()
			countdownHowlingAxe:Start()
			yellHowlingAxe:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 180264 then
		warnFelfireMunitions:Show(args.destName)
	elseif spellId == 184238 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnCower:Show(args.destName, amount)
		end
	elseif spellId == 184243 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnSlam:Show(args.destName, amount)
		end
	elseif spellId == 180927 then--Vehicle Spawns
		self.vb.vehicleCount = self.vb.vehicleCount + 1
		if vehicleTimers[self.vb.vehicleCount] then
			timerSiegeVehicleCD:Start(vehicleTimers[self.vb.vehicleCount])
		end
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 90432 then--Felfire Flamebelcher
			
		elseif cid == 90410 then--Felfire Crusher
			
		elseif cid == 90485 then--Felfire Artillery
			
		elseif cid == 91103 then--Felfire Demolisher
			
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 184369 then
		if args:IsPlayer() then
			countdownHowlingAxe:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 93858 then--Gorebound Berserker
		
	elseif cid == 93931 then--Gorebound Felcaster
		
	elseif cid == 93881 then--Contract Engineer
		
	--Vehicles too?
	end
end

--Wish there was another way, but there isn't. This requires localizing
function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if msg == L.AddsSpawn1 or msg == L.AddsSpawn2 then
		self:SendSync("Adds")
	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then
		self.vb.addsCount = self.vb.addsCount + 1
		if addsTimers[self.vb.addsCount] then
			timerReinforcementsCD:Start(addsTimers[self.vb.addsCount])
		end
		--if self.Options.SetIconOnAdds then
		--	self:ScanForMobs(93931, 0, 8, nil, 0.2, 12)
		--end
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 184913 then--Haste (boss leaving)
		timerHowlingAxeCD:Cancel()
		timerShockwaveCD:Cancel()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE--]]

