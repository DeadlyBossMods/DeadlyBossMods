local mod	= DBM:NewMod(1426, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(94515)--94515 Siegemaster Mar'tak
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184394 181155 183391 185816 180021 186845 186883 185649 180080",
	"SPELL_CAST_SUCCESS 180874 185025",
	"SPELL_AURA_APPLIED 184369 180264 184238 184243",
	"SPELL_AURA_APPLIED_DOSE 184238 184243",
	"SPELL_AURA_REMOVED 184369",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, collect map data for hellfire cannons
--TODO, Verify a lot of shit
--TODO, Check target scanning on everything
--TODO, Check what gets boss frames and what doesn't (mostly target scanning reliability)
--TODO, Timers for abilities, timers for add/vehicle spawns
--TODO, any GTFOs, HUDs, voices once mechanics better understood.
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
local warnCrunsh					= mod:NewCastAnnounce(180021, 3)--Going with non special warning for now, since I don't know who's going to be tanking this, or if it's tanked.
--Add burn too?
----Felfire Flamebelcher
local warnFlameorb					= mod:NewCastAnnounce(186845, 3)--This has too many spellIDs, so not going to risk a special warning until i have a clearer picture of abilities cast sequence
local warnBelchFlame				= mod:NewCastAnnounce(186883, 3)--Regular announce for now, change to special warning when map coords can be gathered for cannons, so can warn only players in impact area
----Felfire Artillery
local warnArtilleryBlast			= mod:NewCastAnnounce(185649, 3)
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
--local timerHowlingAxeCD			= mod:NewCDTimer(107, 184369)
--local timerShockwaveCD			= mod:NewCDTimer(30, 184394)
--Hellfire Reinforcements
----Gorebound Berserker (tank add probably)
--local timerCowerCD				= mod:NewCDTimer(107, 184238)
--local timerSlamCD					= mod:NewCDTimer(107, 184243)
----Gorebound Felcaster
--local timerIncinerateCD			= mod:NewCDTimer(107, 181155, nil, false)
--local timerFelfireVolleyCD		= mod:NewCDTimer(107, 180417, nil, "-Healer")
----Contracted Engineer
--Bomb CD maybe?
--Felfire-Imbued Siege Vehicles

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownHowlingAxe			= mod:NewCountdownFades("Alt7", 184369)

local voiceShockwave				= mod:NewVoice(184394)--shockwave

mod:AddRangeFrameOption(8, 184369)

local function isNearHellfireCannon(self)
	--Map shit, return true.
	--Might need two functions, since some vehicles have bigger areas of impact within hellfire cannon than others
	
	return false
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
	elseif spellId == 181155 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnIncinerate:Show(args.sourceName)
	elseif (spellId == 180417 or spellId == 183452) and self:CheckInterruptFilter(args.sourceGUID) then--Two spellids because two different cast times (mob has two forms)
		specWarnFelfireVolley:Show(args.sourceName)
	elseif spellId == 185816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRepair:Show(args.sourceName)
	elseif spellId == 183391 then
		self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.02, 30, true, nil, nil, nil, true)
	elseif spellId == 180021 then
		warnCrunsh:Show()
	elseif spellId == 186845 then
		warnFlameorb:Show()
	elseif spellId == 186883 then
		--Some fancy map shit here so this can be a special warning for people standing by the Hellfire Cannon
		warnBelchFlame:Show()
	elseif spellId == 185649 or spellId == 180080 then--180080 is probably mythic version, or they both trigger during cast and this will be a spammy mess.
		warnArtilleryBlast:Show()
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE--]]

