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
	"SPELL_CAST_START 184394 181155 183391 185816 180417 183452 181968",
	"SPELL_AURA_APPLIED 180079 184238 184243 180927",
	"SPELL_AURA_APPLIED_DOSE 184243",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, make voices for the 4 tank types by name, similar to Blast Furnace adds.
--TODO, tank swaps for slam?
--TODO, add interrupt voice to volley of it actually is interruptable, if not, remove special warning instead.
--Siegemaster Mar'tak
local warnHowlingAxe				= mod:NewTargetAnnounce(184369, 3)
local warnFelfireMunitions			= mod:NewTargetAnnounce(180079, 1)
--Hellfire Reinforcements
local warnReinforcements			= mod:NewCountAnnounce("ej11406", 3)--Needs icon
----Gorebound Berserker (tank add probably)
local warnSlam						= mod:NewStackAnnounce(184243, 3, nil, "Tank")--How many stacks to swap? or is there a swap?
----Gorebound Terror (transformed Gorebound Felcaster)
local warnDemonicLeap				= mod:NewTargetAnnounce(183391, 3)--Totally assumes target scanning, may be useless/fail

--Felfire-Imbued Siege Vehicles
----Felfire Crusher
local warnFelfireCrusher			= mod:NewSpellAnnounce("ej11439", 2, 160240)
----Felfire Flamebelcher
local warnFelfireFlamebelcher		= mod:NewSpellAnnounce("ej11437", 2, 160240)
----Felfire Artillery
local warnFelfireArtillery			= mod:NewSpellAnnounce("ej11435", 3, 160240)
----Felfire Demolisher (Heroic, Mythic)
local warnFelfireDemolisher			= mod:NewSpellAnnounce("ej11429", 4, 160240)--Heroic & Mythic only
----Felfire Transporter (Mythic)
----Things

--Siegemaster Mar'tak
local specWarnHowlingAxe			= mod:NewSpecialWarningMoveAway(184369, nil, nil, nil, 1, 2)
local yellHowlingAxe				= mod:NewCountYell(184369)
local specWarnShockwave				= mod:NewSpecialWarningDodge(184394, nil, nil, nil, 2, 2)
--Hellfire Reinforcements
local specWarnReinforcements		= mod:NewSpecialWarningSwitch("ej11406", "Tank")
----Gorebound Berserker (tank add probably)
local specWarnCower					= mod:NewSpecialWarningTaunt(184238, "Tank")
--Some specail warnings for taunts or stacks or something here, probably.
----Gorebound Felcaster
local specWarnIncinerate			= mod:NewSpecialWarningInterrupt(181155, false)--Seems less important of two spells, maybe both need interrupting though?
local specWarnMetamorphosis			= mod:NewSpecialWarningSwitch(181968, "Dps")--Switch and get dead if they transform, they do TONS of damage transformed
local specWarnFelfireVolley			= mod:NewSpecialWarningInterrupt(180417, "-Healer")--Journal says interruptable, but it was not interruptable. what's the bug? journal or mob?
----Gorebound Terror (transformed Gorebound Felcaster)
local specWarnDemonicLeap			= mod:NewSpecialWarningYou(183391)--Mythic
local yellDemonicLeap				= mod:NewYell(183391)--Mythic
----Contracted Engineer
local specWarnRepair				= mod:NewSpecialWarningInterrupt(185816, "-Healer", nil, nil, 1, 2)
--Felfire-Imbued Siege Vehicles
local specWarnDemolisher			= mod:NewSpecialWarningSwitch("ej11429", "Dps")--Heroic & Mythic only. Does massive aoe damage, has to be killed asap

--Siegemaster Mar'tak
local timerHowlingAxeCD				= mod:NewCDTimer(8.47, 184369)
local timerShockwaveCD				= mod:NewCDTimer(8.5, 184394)
--Hellfire Reinforcements
local timerReinforcementsCD			= mod:NewCDCountTimer(40, "ej9713")--Not the real joural entry, but best and shortest name (11406 is real one, but Hellfire Reinforcements too long for timer)
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
local voiceFelfireVolley			= mod:NewVoice(180417, "-Healer")--kick
local voiceRepair					= mod:NewVoice(185816)--kickcast

mod:AddRangeFrameOption(8, 184369)
mod:AddHudMapOption("HudMapOnAxe", 184369)
mod:AddSetIconOption("SetIconOnAdds", "ej11411", false, true)--If last wave isn't dead before new wave, this icon option will screw up. A more complex solution may be needed. Or just accept that this will only work for guilds with high dps

mod.vb.vehicleCount = 0
local vehicleTimers = {38, 62.7, 56.6, 60.9, 56.7, 60.9, 57.2, 40.3, 59.4}--Longest pull, 541 seconds. There is slight variation on them, 1-4 seconds
--Types: 1-Felfire Flamebelcher, 2-Felfire Crusher, 3-Felfire Artillery, 4-Felfire Demolisher, 5-Felfire Flamebelcher, 6-Felfire Artillery, 7-Felfire Demolisher, 8-Felfire Flamebelcher, 9-Felfire Crusher
local addsTimers = {25, 45, 44, 44, 43, 43, 42, 42, 41, 40, 42, 40, 40}--Very tiny variance between pulls. Adds gradually get faster over time. that 42 is a strange fluke though. probably 40 with variance, the 40 before it i think should have been a 41 so the 42 was probably auto correction
local axeDebuff = GetSpellInfo(184369)
local scanTime = 0

local function findAxe(self)
	scanTime = scanTime + 1
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, axeDebuff) then
			warnHowlingAxe:CombinedShow(1, name)
			if name == UnitName("player") then
				specWarnHowlingAxe:Show()
				yellHowlingAxe:Yell()
				countdownHowlingAxe:Start()
				voiceHowlingAxe:Play("runout")
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(8, nil, nil, nil, nil, 7)
				end
			end
			if self.Options.HudMapOnArt then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(184369, "highlight", name, 5, 7, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
			end
		end
	end
	if scanTime < 11 then--run for 1 second
		self:Schedule(0.1, findAxe, self)
	end
end

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
	timerHowlingAxeCD:Start(5-delay)
	timerShockwaveCD:Start(6-delay)
	timerReinforcementsCD:Start(25-delay, 1)
	timerSiegeVehicleCD:Start(38-delay, 1)
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
	elseif (spellId == 180417 or spellId == 183452) and self:CheckInterruptFilter(args.sourceGUID) then--Two spellids because two different cast times (mob has two forms)
		specWarnFelfireVolley:Show(args.sourceName)
		voiceFelfireVolley:Play("kickcast")
	elseif spellId == 185816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 183391 then
		self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.05, 16, true, nil, nil, nil, true)
	elseif spellId == 181968 then
		specWarnMetamorphosis:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180079 then
		warnFelfireMunitions:Show(args.destName)
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
		local nextAddsCount = self.vb.vehicleCount + 1
		if vehicleTimers[nextAddsCount] then
			timerSiegeVehicleCD:Start(vehicleTimers[nextAddsCount], nextAddsCount)
		end
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 90432 then--Felfire Flamebelcher
			warnFelfireFlamebelcher:Show()
		elseif cid == 90410 then--Felfire Crusher
			warnFelfireCrusher:Show()
		elseif cid == 90485 then--Felfire Artillery
			warnFelfireArtillery:Show()
		elseif cid == 91103 then--Felfire Demolisher
			if self.Options.SpecWarnej11429switch then
				specWarnDemolisher:Show()
			else
				warnFelfireDemolisher:Show()
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then
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
		end
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 184913 then--Haste (boss leaving)
		timerHowlingAxeCD:Cancel()
		countdownHowlingAxe:Cancel()
		timerShockwaveCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.HudMapOnAxe then
			DBMHudMap:Disable()
		end
	elseif spellId == 184350 then--Actual axe targeting. Doesn't show in combat log, doesn't have whisper.
		timerHowlingAxeCD:Start()
		scanTime = 0
		findAxe(self)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE--]]

