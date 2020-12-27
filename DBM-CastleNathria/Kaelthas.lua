local mod	= DBM:NewMod(2422, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165759)
mod:SetEncounterID(2402)
mod:DisableIEEUCombatDetection()
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod.onlyHighest = true--Instructs DBM health tracking to literally only store highest value seen during fight, even if it drops below that
mod.noBossDeathKill = true--Instructs mod to ignore 165759 deaths, since goal is to heal kael, not kill him
mod:SetHotfixNoticeRev(20201226000000)--2020, 12, 26
mod:SetMinSyncRevision(20201226000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325877 329509 329518 328885 325440 325506 333002 326455 337865",
	"SPELL_CAST_SUCCESS 326583 325665 181113",
	"SPELL_SUMMON 329565 326075",
	"SPELL_AURA_APPLIED 326456 328659 341254 328731 325442 333145 326078 332871 326583 328479 323402 337859 335581 343026 341473",
	"SPELL_AURA_APPLIED_DOSE 326456 325442 326078",
	"SPELL_AURA_REMOVED 328731 326078 328479 323402 337859 343026",
	"SPELL_PERIODIC_DAMAGE 328579",
	"SPELL_PERIODIC_MISSED 328579",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Switch Ember Blast to UnitTargetScanner for max scan speed/efficiency, if shade has boss unit ID and isn't already targetting victim when cast starts
--TODO, adjust ember blast warning to reduce number told to soak it if it's not conventional to just tell everyone but the tanks to do it
--TODO, essence tracking of energy for Cultists?
--TODO, dispel warnings for Vulgar brand (333002) based on difficulty (magic non mythic, curse mythic)?
--TODO, improved infoframe with https://shadowlands.wowhead.com/spell=339251/drained-soul tracking
--TODO, auto mark essence spawns?
--TODO, Keep an eye on add spawns, if blizzard leaves 3 of the add types missing from combat log on mythic, scheduling will have to be added
--TODO, add nameplate aura for assassins fixate/attack?
--[[
(ability.id = 325877 or ability.id = 329509 or ability.id = 329518 or ability.id = 328885) and type = "begincast"
 or ability.id = 181113 or ability.id = 323402 or target.id = 168973 and type = "death" or (ability.id = 343026 or ability.id = 337859) and (type = "applydebuff" or type = "removedebuff" or type = "applybuff" or type = "removebuff")
 or ability.id = 325665 and type = "cast"
 or ability.id = 328885 and type = "begincast"
 or ability.id = 181113
 or ability.id = 335581 and type = "applybuff"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
 or (abililty.id = 326455 or ability.id = 326455 or ability.id = 325506) and type = "begincast"

 ability.id = 328659 or ability.id == 341254 or ability.id = 328731 and (type = "applybuff" or type = "removebuff")
--]]
--Shade of Kael'thas
local warnFeiryStrike							= mod:NewCastAnnounce(326455, 2, nil, nil, "Melee")
local warnBurningRemnants						= mod:NewStackAnnounce(326456, 2, nil, "Tank")
local warnEmberBlast							= mod:NewTargetNoFilterAnnounce(325877, 4)
--local warnBlazingSurge							= mod:NewSpellAnnounce(329509, 3)--Use if target scanning ever works for this
--Adds
----Rockbound Vanquisher
local warnVanquisher							= mod:NewCountAnnounce("ej21954", 2, 325440)
local warnVanquished							= mod:NewStackAnnounce(325442, 2, nil, "Tank")
local warnConcussiveSmash						= mod:NewCountAnnounce(325506, 3)
----Assassin
local warnAssassin								= mod:NewCountAnnounce("ej21993", 2, 326583)
local warnReturnToStone							= mod:NewTargetNoFilterAnnounce(333145, 4, nil, "-Healer")
local warnCrimsonFury							= mod:NewTargetAnnounce(341473, 3)
--Vile Occultist
local warnVileOccultists						= mod:NewCountAnnounce("ej21952", 2, 329565)
local warnSummonEssenceFont						= mod:NewSpellAnnounce(329565, 2, nil, "Healer")
--Soul Infusor
local warnSoulInfusion							= mod:NewSpellAnnounce(325665, 4)
local warnInfusersOrb							= mod:NewCountAnnounce(326075, 1, nil, "Healer")
--Phoenix
local warnRebornPhoenix							= mod:NewSpellAnnounce("ej22090", 2, 328659)
local warnEyeOnTarget							= mod:NewTargetAnnounce(328479, 2)

--Shade of Kael'thas
local specWarnShadeSpawned						= mod:NewSpecialWarningSwitch("ej21966", nil, nil, nil, 1, 2)
local specWarnFeiryStrike						= mod:NewSpecialWarningSpell(326455, false, nil, nil, 1, 2)
local specWarnBurningRemnants					= mod:NewSpecialWarningStack(326456, nil, 3, nil, nil, 1, 6)
local specWarnBurningRemnantsTaunt				= mod:NewSpecialWarningTaunt(326456, nil, nil, nil, 1, 2)
local specWarnEmberBlast						= mod:NewSpecialWarningMoveTo(325877, false, nil, nil, 1, 2)--Opt in as needed
local yellEmberBlast							= mod:NewYell(325877, nil, nil, nil, "YELL")
local yellEmberBlastFades						= mod:NewFadesYell(325877, nil, nil, nil, "YELL")
local specWarnBlazingSurge						= mod:NewSpecialWarningDodge(329509, nil, nil, nil, 2, 2)
--local yellBlazingSurge							= mod:NewYell(329509)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(328579, nil, nil, nil, 1, 8)
----Kael
local specWarnUnleashedPyroclasm				= mod:NewSpecialWarningInterrupt(337865, nil, nil, nil, 1, 2)
--High Torturor Darithos
local specWarnGreaterCastigation				= mod:NewSpecialWarningMoveAway(328885, nil, nil, nil, 1, 2)
--Adds
----Rockbound Vanquisher
local specWarnVanquished						= mod:NewSpecialWarningStack(325442, nil, 3, nil, nil, 1, 6)
local specWarnVanquishedTaunt					= mod:NewSpecialWarningTaunt(325442, nil, nil, nil, 1, 2)
--Assassin
local specWarnCrimsonFury						= mod:NewSpecialWarningMoveAway(341473, nil, nil, nil, 1, 2)
local yellCrimsonFury							= mod:NewYell(341473)
--Vile Occultist
local specWarnVulgarBrand						= mod:NewSpecialWarningInterrupt(333002, "HasInterrupt", nil, nil, 1, 2)
--Phoenix
local specWarnEyeOnTarget						= mod:NewSpecialWarningYou(328479, nil, nil, nil, 1, 2)
local yellEyeOnTarget							= mod:NewYell(328479, nil, false)

--Shade of Kael'thas
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21966))
local timerFieryStrikeCD						= mod:NewCDTimer(8.5, 326455, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerEmberBlastCD							= mod:NewCDTimer(20.6, 325877, nil, nil, nil, 3)--20 again? or is it just 24 on mythic and 20 on heroic
local timerBlazingSurgeCD						= mod:NewCDTimer(19.4, 329509, nil, nil, nil, 3)
local timerCloakofFlamesCD						= mod:NewNextCountTimer(30, 337859, nil, nil, nil, 5, nil, DBM_CORE_L.MYTHIC_ICON)
--local timerRebornPhoenixCD					= mod:NewCDTimer(44.3, "ej22090", nil, nil, nil, 1, 328659, DBM_CORE_L.DAMAGE_ICON)--Cast only once whole fight and not timer based
--High Torturor Darithos
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22089))
local timerGreaterCastigationCD					= mod:NewNextTimer(15.8, 328885, nil, nil, nil, 3)
--Adds
----Rockbound Vanquisher
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21954))
local timerVanquisherCD							= mod:NewCDCountTimer(80, "ej21954", nil, nil, nil, 1, 325440, DBM_CORE_L.DAMAGE_ICON)
local timerVanquishingStrikeCD					= mod:NewCDTimer(6.1, 325440, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerConcussiveSmashCD					= mod:NewCDCountTimer(19.5, 325506, nil, nil, nil, 5)--Next in between casts, but initial cast can be delayed by a lot
----Bleakwing Assassin
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21993))
local timerBleakwingAssassinCD					= mod:NewCDCountTimer(80, "ej21993", nil, nil, nil, 1, 326583, DBM_CORE_L.DAMAGE_ICON)
--local timerCrimsonFuryCD						= mod:NewCDTimer(44.3, 341473, nil, false, nil, 3, nil, DBM_CORE_L.BLEED_ICON)--Too many to track via normal bars, this needs nameplate bars/icon
----Vile Occultist
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21952))
local timerVileOccultistCD						= mod:NewCDCountTimer(10, "ej21952", nil, nil, nil, 1, 329565, DBM_CORE_L.DAMAGE_ICON)
--local timerVulgarBrandCD						= mod:NewCDTimer(44.3, 333002, nil, nil, nil, 3)--TODO, give it a relative icon based on difficulty (Magic/Curse)
----Soul Infuser
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21953))
local timerSoulInfuserCD						= mod:NewCDCountTimer(10, "ej21953", nil, nil, nil, 1, 325665, DBM_CORE_L.DAMAGE_ICON)
----Pestering Fiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22082))
local timerPesteringFiendCD						= mod:NewCDCountTimer(70, "ej22082", nil, nil, nil, 1, 328254, DBM_CORE_L.DAMAGE_ICON)
----Reborn Phoenix
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22090))
local timerPhoenixRespawn						= mod:NewCastTimer(20, 328731, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 328885)
mod:AddInfoFrameOption(326078, true)--343026
mod:AddSetIconOption("SetIconOnEmberBlast", 325877, true, false, {1})
mod:AddSetIconOption("SetIconOnBirdo", 328731, true, true, {2, 3, 4, 5})
--mod:AddNamePlateOption("NPAuraOnPhoenixEmbers", 328731)
mod:AddNamePlateOption("NPAuraOnPhoenixFixate", 328479)

mod.vb.addMode = 0--No adds spawning, 1-Adds Spawning from Darithos Tables, 2-Adds spawning from Shade table
mod.vb.addCount = 0
mod.vb.healerOrbCount = 0
mod.vb.shadeActive = false
mod.vb.cloakActive = false
mod.vb.cloakCount = 0
mod.vb.assassinCount = 0
mod.vb.occultistCount = 0
mod.vb.infuserCount = 0
mod.vb.fiendCount = 0
mod.vb.vanquisherCount = 0
local infusersBoon = DBM:GetSpellInfo(326078)
local seenAdds = {}
local castsPerGUID = {}
local infuserTargets = {}
local birdoTracker = {}
--Perfect timers, executed from Darithos dying
local difficultyName = "None"
local addTimers = {
	[0] = {
		["easy"] = {
			--Bleakwing Assassin
			[167566] = {70, 70, 70, 78},
			--Vile Occultist
			[165763] = {105, 35, 100},
			--Soul Infuser
			[165762] = {175, 55},
			--Pestering Fiend
			[168700] = {70, 70, 70, 78},
			--Rockbound Vanquisher
			[165764] = {50, 70, 70, 78},
		},
		["heroic"] = {--Heroic Timers from Dec 14th purposely keeping darithos alive
			--Bleakwing Assassin
			[167566] = {70, 90},
			--Vile Occultist
			[165763] = {70, 90},
			--Soul Infuser
			[165762] = {130, 30},
			--Pestering Fiend (TODO, something off about this one)
			[168700] = {100, 30},
			--Rockbound Vanquisher
			[165764] = {50, 65},
		},
		["mythic"] = {--Mythic testing timers Sept 25th
			--Bleakwing Assassin
			[167566] = {110, 30, 30, 95, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating after
			--Vile Occultist
			[165763] = {110, 60, 64.2, 30, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating fter
			--Soul Infuser
			[165762] = {75, 120},
			--Pestering Fiend (TODO, something off about this one)
			[168700] = {100, 35},
			--Rockbound Vanquisher
			[165764] = {50, 60, 60},
		},
	},
	[1] = {--Initial add sets started when Darithos dies
		["easy"] = {--Normal timers from Dec 9th
			--Bleakwing Assassin
			[167566] = {28, 70, 70, 78},
			--Vile Occultist
			[165763] = {63, 35, 100},
			--Soul Infuser
			[165762] = {133, 55},--133 is iffy, didn't show spawn event
			--Pestering Fiend
			[168700] = {28, 70, 70, 78},
			--Rockbound Vanquisher
			[165764] = {8, 70, 70, 78},
		},
		["heroic"] = {--Heroic Timers from Dec 9th
			--Bleakwing Assassin
			[167566] = {28, 90, 30, 30},
			--Vile Occultist
			[165763] = {28, 90, 90},
			--Soul Infuser
			[165762] = {88, 30},
			--Pestering Fiend
			[168700] = {58, 30, 120},
			--Rockbound Vanquisher
			[165764] = {8, 65},
		},
		["mythic"] = {--Mythic testing timers Sept 25th
			--Bleakwing Assassin
			[167566] = {68, 30, 30, 95, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating after
			--Vile Occultist
			[165763] = {68, 60, 64.2, 30, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating fter
			--Soul Infuser
			[165762] = {32, 120},
			--Pestering Fiend (TODO, something off about this one)
			[168700] = {58, 35},--Only one spawn in entire fight has spawn event, so rest of timers after 58 very iffy
			--Rockbound Vanquisher
			[165764] = {8, 60, 60},
		},
	},
	[2] = {--Post Shade Departure Adds
		["easy"] = {--Normal timers from Dec 9th
			--Bleakwing Assassin
			[167566] = {58.7, 70, 65, 75, 70},
			--Vile Occultist
			[165763] = {94.2, 70, 140},
			--Soul Infuser
			[165762] = {24.2, 140, 70},
			--Pestering Fiend
			[168700] = {58.7, 70, 65, 75, 70},
			--Rockbound Vanquisher
			[165764] = {3.5, 70, 60, 70},
		},
		["heroic"] = {
			--Bleakwing Assassin
			[167566] = {23.4, 60, 30, 40, 50, 30},
			--Vile Occultist
			[165763] = {113.5, 70},
			--Soul Infuser
			[165762] = {60, 50},--Iff, no spawn event, just first seen event
			--Pestering Fiend
			[168700] = {23.5, 30, 30, 30, 70, 30, 30},--They still spawn sometimes with no spawn event, the two 30s were picked up by damage
			--Rockbound Vanquisher
			[165764] = {3.5, 65, 65, 65, 15},
		},
		["mythic"] = {--Mythic testing timers Sept 25th
			--Bleakwing Assassin
			[167566] = {23.3, 120, 70, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating after 70
			--Vile Occultist
			[165763] = {23.3, 120, 35, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},--5 repeating after 35
			--Soul Infuser
			[165762] = {90, 100, 35},--5 repeating after 35 (iffy, so not enabled yet)
			--Pestering Fiend
			[168700] = {},--None?
			--Rockbound Vanquisher
			[165764] = {3.5, 70, 70, 70},
		},
	},
}

function mod:EmberBlastTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	local debuffTimer = self:IsLFR() and 5 or 3
	if targetname == UnitName("player") then
		specWarnEmberBlast:Show(DBM_CORE_L.ALLIES)
		specWarnEmberBlast:Play("gathershare")
		yellEmberBlast:Yell()
		yellEmberBlastFades:Countdown(debuffTimer-scanningTime)
	elseif self.Options.SpecWarn325877moveto then
		specWarnEmberBlast:Show(targetname)
		specWarnEmberBlast:Play("gathershare")
	else
		warnEmberBlast:Show(targetname)
	end
	if self.Options.SetIconOnEmberBlast then
		self:SetIcon(targetname, 1, debuffTimer-scanningTime+1)--So icon clears 1-3 second after blast
	end
end

--[[
function mod:BlazingSurgeTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBlazingSurge:Show()
		specWarnBlazingSurge:Play("runout")
		yellBlazingSurge:Yell()
	else
		warnBlazingSurge:Show(targetname)
	end
end
--]]

local updateInfoFrame
do
	local floor = math.floor
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Infuser's Boon targets
		if #infuserTargets > 0 then
--			addLine("---"..infusersBoon.."---")
			for i=1, #infuserTargets do
				local name = infuserTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, infuserCount, _, _, infuserExpireTime = DBM:UnitDebuff(uId, 326078)
					if infuserExpireTime then--Has count, show count and infuser remaining
						local infuserRemaining = infuserExpireTime-GetTime()
						local count = infuserCount or 1
						addLine(i.."*"..name, count.."-"..floor(infuserRemaining))
					end
				end
			end
		else--Nothing left to track, auto hide
			DBM.InfoFrame:Hide()
		end
		return lines, sortedLines
	end
end

local function setForcedAddSpawns(self)
	self.vb.addMode = 1
end

local function expectedInfuser(self)
	self.vb.infuserCount = self.vb.infuserCount + 1
	local timer = addTimers[self.vb.addMode][difficultyName][165762][self.vb.infuserCount+1]
	if timer then
		timerSoulInfuserCD:Start(timer-10, self.vb.infuserCount+1)
		self:Unschedule(expectedInfuser)
		self:Schedule(timer, expectedInfuser, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.addMode = 0
	self.vb.addCount = 0
	self.vb.healerOrbCount = 0
	self.vb.assassinCount = 0
	self.vb.occultistCount = 0
	self.vb.infuserCount = 0
	self.vb.fiendCount = 0
	self.vb.vanquisherCount = 0
	self.vb.shadeActive = false
	self.vb.cloakActive = false
	self.vb.cloakCount = 0
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(infuserTargets)
	table.wipe(birdoTracker)
	timerGreaterCastigationCD:Start(5.8)
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
	if self.Options.NPAuraOnPhoenixFixate then--self.Options.NPAuraOnPhoenixEmbers
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	self:Schedule(42, setForcedAddSpawns, self)
	if self:IsMythic() then
		difficultyName = "mythic"
		timerVanquisherCD:Start(50, 1)
		timerSoulInfuserCD:Start(75, 1)
		self:Unschedule(expectedInfuser)
		self:Schedule(85, expectedInfuser, self)
--		timerPesteringFiendCD:Start(100, 1)
		timerBleakwingAssassinCD:Start(110, 1)
		timerVileOccultistCD:Start(110, 1)
		timerCloakofFlamesCD:Start(80, 1)--IFFY
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerVanquisherCD:Start(50, 1)
		timerBleakwingAssassinCD:Start(70, 1)
		timerVileOccultistCD:Start(70, 1)
		timerPesteringFiendCD:Start(100, 1)
		timerSoulInfuserCD:Start(130, 1)
		self:Unschedule(expectedInfuser)
		self:Schedule(140, expectedInfuser, self)
	elseif self:IsNormal() then
		difficultyName = "easy"
		timerVanquisherCD:Start(50, 1)
		timerBleakwingAssassinCD:Start(70, 1)
		timerPesteringFiendCD:Start(70, 1)
		timerVileOccultistCD:Start(105, 1)
		timerSoulInfuserCD:Start(185, 1)
		self:Unschedule(expectedInfuser)
		self:Schedule(195, expectedInfuser, self)
	else
		difficultyName = "easy"
	end
end

function mod:OnCombatEnd(wipe, isSecondRun)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(infuserTargets)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnPhoenixFixate then--self.Options.NPAuraOnPhoenixEmbers or
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if not isSecondRun then
		DBM:AddMsg("Add timer accuracy may stil suffer greatly until blizzard fixes bugs with adds inconsistently firing events when spawning, especially soul infusers")
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	elseif self:IsNormal() then
		difficultyName = "easy"
	else
		difficultyName = "easy"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325877 then
		timerEmberBlastCD:Start(self:IsMythic() and 24.4 or 20.6)--Verify mythic still 24
		self:BossTargetScanner(args.sourceGUID, "EmberBlastTarget", 0.2, 13)--Scans for 2.6 of 5.0 second cast, will adjust later
	elseif spellId == 329509 or spellId == 329518 then
		specWarnBlazingSurge:Show()
		specWarnBlazingSurge:Play("shockwave")
		timerBlazingSurgeCD:Start()
		--self:BossTargetScanner(args.sourceGUID, "BlazingSurgeTarget", 0.1, 12)
	elseif spellId == 328885 then
		timerGreaterCastigationCD:Start()
	elseif spellId == 325440 then
		--Announce the cast? seems only stacks worth announcing
		timerVanquishingStrikeCD:Start(6.1, args.sourceGUID)
	elseif spellId == 325506 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			self.vb.addCount = self.vb.addCount + 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local addnumber, count = self.vb.addCount, castsPerGUID[args.sourceGUID]
		warnConcussiveSmash:Show(addnumber.."-"..count)
		timerConcussiveSmashCD:Start(19.5, count+1, args.sourceGUID)
	elseif spellId == 333002 then
--		timerVulgarBrandCD:Start(15, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVulgarBrand:Show(args.sourceName)
			specWarnVulgarBrand:Play("kickcast")
		end
	elseif spellId == 326455 then
		if self.Options.SpecWarn326455spell then
			specWarnFeiryStrike:Show()
			specWarnFeiryStrike:Play("shockwave")
		else
			warnFeiryStrike:Show()
		end
		timerFieryStrikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 326583 then
--		timerCrimsonFuryCD:Start(15, args.sourceGUID)
	elseif spellId == 325665 and self:AntiSpam(3, 3) then
		warnSoulInfusion:Show()
	elseif spellId == 181113 then--Encounter Spawn
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		self:SendSync("Spawn", cid)--Until blizzard works out what's going wrong with CLEU range for this event, DBM is now going to spam comms for accuracy
		if self:AntiSpam(8, cid) then
			if cid == 165764 then--Rockbound Vanquisher
				if self.vb.addMode == 0 then
					self.vb.addMode = 1
				end
				self.vb.vanquisherCount = self.vb.vanquisherCount + 1
				warnVanquisher:Show(self.vb.vanquisherCount)
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.vanquisherCount+1]
				if timer and timer > 5 then
					timerVanquisherCD:Start(timer, self.vb.vanquisherCount+1)
				end
				timerVanquishingStrikeCD:Start(19.2, args.sourceGUID)
				timerConcussiveSmashCD:Start(24.1, 1, args.sourceGUID)--24-44?
			elseif cid == 167566 then--bleakwing-assassin
				self.vb.assassinCount = self.vb.assassinCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.assassinCount+1]
				if timer and timer > 5 then
					timerBleakwingAssassinCD:Start(timer, self.vb.assassinCount+1)
				end
			elseif cid == 165763 then--vile-occultist
				self.vb.occultistCount = self.vb.occultistCount + 1
				warnVileOccultists:Show(self.vb.occultistCount)
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.occultistCount+1]
				if timer and timer > 5 then
					timerVileOccultistCD:Start(timer, self.vb.occultistCount+1)
				end
			elseif cid == 165762 then
				self.vb.infuserCount = self.vb.infuserCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.infuserCount+1]
				if timer then
					timerSoulInfuserCD:Start(timer, self.vb.infuserCount+1)
					self:Unschedule(expectedInfuser)
					self:Schedule(timer+10, expectedInfuser, self)
				end
			elseif cid == 168700 then
				self.vb.fiendCount = self.vb.fiendCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.fiendCount+1]
				if timer and timer > 5 then
					timerPesteringFiendCD:Start(timer, self.vb.fiendCount+1)
				end
--			elseif cid == 168962 then--Reborn Phoenix

			end
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 329565 and self:AntiSpam(3, 5) then
		--Doesn't really need to announce all of them, just that one is up within 5 seconds
		warnSummonEssenceFont:Show()
	elseif spellId == 326075 then--Not throttled, since healers will need to know how many drop and what count
		self.vb.healerOrbCount = self.vb.healerOrbCount + 1
		warnInfusersOrb:Show(self.vb.healerOrbCount)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 326456 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnBurningRemnants:Show(amount)
					specWarnBurningRemnants:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
						specWarnBurningRemnantsTaunt:Show(args.destName)
						specWarnBurningRemnantsTaunt:Play("tauntboss")
					else
						warnBurningRemnants:Show(args.destName, amount)
					end
				end
			else
				warnBurningRemnants:Show(args.destName, amount)
			end
		end
	elseif spellId == 325442 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnVanquished:Show(amount)
				specWarnVanquished:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnVanquishedTaunt:Show(args.destName)
					specWarnVanquishedTaunt:Play("tauntboss")
				else
					warnVanquished:Show(args.destName, amount)
				end
			end
		else
			warnVanquished:Show(args.destName, amount)
		end
	elseif (spellId == 328659 or spellId == 341254) then
		if self:AntiSpam(10, 1) then--In case more than one spawn at once
			warnRebornPhoenix:Show()
		end
		--Table store guids for birdo as they spawn so we can strictly assign raid icons to them by GUID
		if not tContains(birdoTracker, args.destGUID) then
			birdoTracker[#birdoTracker+1] = args.destGUID
		end
		--Scan runs even if we don't store it as a new bird, because the icon needs to be restored when bird rezes
		if self.Options.SetIconOnBirdo then
			for i = 1, #birdoTracker do
				if i == 9 then return end--More birds than we have icons
				if birdoTracker[i] == args.destGUID then
					self:ScanForMobs(args.destGUID, 2, i+1, 1, 0.2, 10, "SetIconOnBirdo")
					break
				end
			end
		end
	elseif spellId == 328731 then
--		if self.Options.NPAuraOnPhoenixEmbers then
--			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 20)
--		end
		timerPhoenixRespawn:Start(20, args.destGUID)
	elseif spellId == 333145 and self:AntiSpam(5, args.destName) then
		warnReturnToStone:Show(args.destName)
	elseif spellId == 326078 then
		if not tContains(infuserTargets, args.destName) then
			table.insert(infuserTargets, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() and not self.vb.cloakActive then
			DBM.InfoFrame:SetHeader(infusersBoon)
			DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
		end
	elseif spellId == 332871 and args:IsPlayer() then
		specWarnGreaterCastigation:Show()
		specWarnGreaterCastigation:Play("scatter")
	elseif spellId == 326583 or spellId == 341473 then
		warnCrimsonFury:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 8) then
			specWarnCrimsonFury:Show()
			specWarnCrimsonFury:Play("runout")
			yellCrimsonFury:Yell()
		end
	elseif spellId == 328479 then
		warnEyeOnTarget:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 4) then
				specWarnEyeOnTarget:Show()
				specWarnEyeOnTarget:Play("targetyou")
				yellEyeOnTarget:Yell()
			end
			if self.Options.NPAuraOnPhoenixFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
			end
		end
	elseif spellId == 323402 and self:AntiSpam(3, 7) then--Reflection of Guilt (Shade Coming out)
		self.vb.shadeActive = true
		self.vb.cloakCount = 0
		timerSoulInfuserCD:Stop()
		self:Unschedule(expectedInfuser)
		timerPesteringFiendCD:Stop()
		timerBleakwingAssassinCD:Stop()
		timerVileOccultistCD:Stop()
		timerVanquisherCD:Stop()
		specWarnShadeSpawned:Show()
		specWarnShadeSpawned:Play("bigmob")
		timerFieryStrikeCD:Start(14)
		timerEmberBlastCD:Start(20.1)
		timerBlazingSurgeCD:Start(28.8)
		if self:IsMythic() then
			timerCloakofFlamesCD:Start(39, 1)
		end
	elseif spellId == 337859 or spellId == 343026 then
		self.vb.cloakCount = self.vb.cloakCount + 1
		timerCloakofFlamesCD:Start(spellId == 337859 and 60 or 30, self.vb.cloakCount+1)
		self.vb.cloakActive = true
		if self.Options.InfoFrame then--Show dps one over the healing one
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 335581 then--Carrying Essence Font
		if self:AntiSpam(8, 165763) then--Backup Vile Occultist spawn detection since blizzard disabled their Encounter Spawn
			self.vb.occultistCount = self.vb.occultistCount + 1
			warnVileOccultists:Show(self.vb.occultistCount)
			local timer = addTimers[self.vb.addMode][difficultyName][165763][self.vb.occultistCount+1]
			if timer and timer > 5 then
				timerVileOccultistCD:Start(timer, self.vb.occultistCount+1)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328731 then
--		if self.Options.NPAuraOnPhoenixEmbers then
--			DBM.Nameplate:Hide(true, args.destGUID, spellId)
--		end
		timerPhoenixRespawn:Stop(args.destGUID)
	elseif spellId == 326078 then
		infuserTargets[args.destName] = nil
	elseif spellId == 328479 then
		if self.Options.NPAuraOnPhoenixFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 323402 then--Reflection of Guilt (Shade Leaving)
		self.vb.shadeActive = false
		self.vb.addMode = 2
		self.vb.assassinCount = 0
		self.vb.occultistCount = 0
		self.vb.infuserCount = 0
		self.vb.fiendCount = 0
		self.vb.vanquisherCount = 0
		self.vb.cloakCount = 0
		timerEmberBlastCD:Stop()
		timerBlazingSurgeCD:Stop()
		timerFieryStrikeCD:Stop()
		if self:IsMythic() then
			timerVanquisherCD:Start(3.5, 1)
			timerBleakwingAssassinCD:Start(23.3, 1)
			timerVileOccultistCD:Start(23.3, 1)
			timerSoulInfuserCD:Start(90, 1)
			self:Unschedule(expectedInfuser)
			self:Schedule(100, expectedInfuser, self)
			--timerPesteringFiendCD:Start(4, 1)--None seem to spawn anymore after shades?
			if self:IsMythic() then
				timerCloakofFlamesCD:Start(34.1, 1)
			end
		elseif self:IsHeroic() then
			timerVanquisherCD:Start(3.5, 1)
			timerBleakwingAssassinCD:Start(23.5, 1)
			timerPesteringFiendCD:Start(23.5, 1)
			timerSoulInfuserCD:Start(60, 1)
			self:Unschedule(expectedInfuser)
			self:Schedule(70, expectedInfuser, self)
			timerVileOccultistCD:Start(133.5, 1)
		else--Normal and LFR combined for now until verify they are different
			timerVanquisherCD:Start(3.5, 1)
			timerSoulInfuserCD:Start(24.2, 1)
			self:Unschedule(expectedInfuser)
			self:Schedule(34.2, expectedInfuser, self)
			timerBleakwingAssassinCD:Start(58.7, 1)
			timerPesteringFiendCD:Start(58.7, 1)
			timerVileOccultistCD:Start(94.2, 1)
		end
	elseif spellId == 337859 or spellId == 343026 then
		self.vb.cloakActive = false
		if spellId == 343026 then
			specWarnUnleashedPyroclasm:Show(args.destName)
			specWarnUnleashedPyroclasm:Play("kickcast")
		end
		if self.Options.InfoFrame and spellId == 343026 then
			if #infuserTargets > 0 then
				DBM.InfoFrame:SetHeader(infusersBoon)
				DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
			else
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 168973 then--High Torturer Darithos
		timerGreaterCastigationCD:Stop()
		--Adds haven't spawned automatically yet, so this death is triggering add spawns script
		if self.vb.addMode == 0 then
			self.vb.addMode = 1
			timerVanquisherCD:Stop()
			timerSoulInfuserCD:Stop()
			self:Unschedule(expectedInfuser)
			timerPesteringFiendCD:Stop()
			timerBleakwingAssassinCD:Stop()
			timerVileOccultistCD:Stop()
			timerCloakofFlamesCD:Stop()
			if self:IsMythic() then
				timerVanquisherCD:Start(8, 1)
				timerSoulInfuserCD:Start(35, 1)
				self:Schedule(45, expectedInfuser, self)
				--timerPesteringFiendCD:Start(58, 1)
				timerBleakwingAssassinCD:Start(60, 1)
				timerVileOccultistCD:Start(68, 1)
				timerCloakofFlamesCD:Start(38, 1)--Mythic Only
			elseif self:IsHeroic() then
				timerVanquisherCD:Start(30, 1)
				timerBleakwingAssassinCD:Start(50, 1)--Come earlier on easy
				timerVileOccultistCD:Start(50, 1)
				timerPesteringFiendCD:Start(80, 1)
				timerSoulInfuserCD:Start(110, 1)
				self:Schedule(120, expectedInfuser, self)
			else--TODO, verify normal and LFR share timers
				timerVanquisherCD:Start(50, 1)
				timerBleakwingAssassinCD:Start(70, 1)--Come earlier on easy
				timerPesteringFiendCD:Start(70, 1)
				timerVileOccultistCD:Start(105, 1)
				timerSoulInfuserCD:Start(185, 1)
				self:Schedule(195, expectedInfuser, self)
			end
		end
	elseif cid == 165764 then--Rockbound Vanquisher
		timerVanquishingStrikeCD:Stop(args.destGUID)
		timerConcussiveSmashCD:Stop(castsPerGUID[args.destGUID]+1, args.destGUID)
--	elseif cid == 167566 then--bleakwing-assassin
--		timerCrimsonFuryCD:Stop(args.destGUID)
--	elseif cid == 165763 then--vile-occultist
--		timerVulgarBrandCD:Stop(args.destGUID)
--	elseif cid == 168962 then--Reborn Phoenix
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 328579 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:OnSync(msg, guid)
	if not self:IsInCombat() then return end
	if msg == "Spawn" and guid then
		local cid = self:GetCIDFromGUID(guid)
		if self:AntiSpam(8, cid) then
			if cid == 165764 then--Rockbound Vanquisher
				if self.vb.addMode == 0 then
					self.vb.addMode = 1
				end
				self.vb.vanquisherCount = self.vb.vanquisherCount + 1
				warnVanquisher:Show(self.vb.vanquisherCount)
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.vanquisherCount+1]
				if timer and timer > 5 then
					timerVanquisherCD:Start(timer, self.vb.vanquisherCount+1)
				end
				timerVanquishingStrikeCD:Start(19.2, guid)
				timerConcussiveSmashCD:Start(24.1, 1, guid)--24-44
			elseif cid == 167566 then--bleakwing-assassin
				self.vb.assassinCount = self.vb.assassinCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.assassinCount+1]
				if timer and timer > 5 then
					timerBleakwingAssassinCD:Start(timer, self.vb.assassinCount+1)
				end
			elseif cid == 165763 then--vile-occultist
				self.vb.occultistCount = self.vb.occultistCount + 1
				warnVileOccultists:Show(self.vb.occultistCount)
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.occultistCount+1]
				if timer and timer > 5 then
					timerVileOccultistCD:Start(timer, self.vb.occultistCount+1)
				end
			elseif cid == 165762 then
				self.vb.infuserCount = self.vb.infuserCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.infuserCount+1]
				if timer and timer > 5 then
					timerSoulInfuserCD:Start(timer, self.vb.infuserCount+1)
					self:Unschedule(expectedInfuser)
					self:Schedule(timer+10, expectedInfuser, self)
				end
			elseif cid == 168700 then
				self.vb.fiendCount = self.vb.fiendCount + 1
				local timer = addTimers[self.vb.addMode][difficultyName][cid][self.vb.fiendCount+1]
				if timer and timer > 5 then
					timerPesteringFiendCD:Start(timer, self.vb.fiendCount+1)
				end
--			elseif cid == 168962 then--Reborn Phoenix

			end
		end
	end
end

--[[
--https://shadowlands.wowhead.com/spell=336658/reborn-phoenix-exit
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 336658 then

	end
end
--]]
