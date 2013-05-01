local mod	= DBM:NewMod(828, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69712)
mod:SetModelID(46675)
mod:SetQuestID(32749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnCaws				= mod:NewSpellAnnounce(138923, 2)
local warnQuills			= mod:NewCountAnnounce(134380, 4)
local warnFlock				= mod:NewAnnounce("warnFlock", 3, 15746)--Some random egg icon
local warnLayEgg			= mod:NewSpellAnnounce(134367, 3)
local warnTalonRake			= mod:NewStackAnnounce(134366, 3, nil, mod:IsTank() or mod:IsHealer())
local warnDowndraft			= mod:NewSpellAnnounce(134370, 3)
local warnFeedYoung			= mod:NewSpellAnnounce(137528, 3)--No Cd because it variable based on triggering from eggs, it's cast when one of young call out and this varies too much

local specWarnQuills		= mod:NewSpecialWarningSpell(134380, nil, nil, nil, 2)
local specWarnFlock			= mod:NewSpecialWarning("specWarnFlock", false)--For those assigned in egg/bird killing group to enable on their own (and tank on heroic)
local specWarnTalonRake		= mod:NewSpecialWarningStack(134366, mod:IsTank(), 2)--Might change to 2 if blizz fixes timing issues with it
local specWarnTalonRakeOther= mod:NewSpecialWarningTarget(134366, mod:IsTank())
local specWarnDowndraft		= mod:NewSpecialWarningSpell(134370, nil, nil, nil, 2)
local specWarnFeedYoung		= mod:NewSpecialWarningSpell(137528)
local specWarnBigBird		= mod:NewSpecialWarning("specWarnBigBird", mod:IsTank())
local specWarnBigBirdSoon	= mod:NewSpecialWarning("specWarnBigBirdSoon", mod:IsTank())

--local timerCawsCD			= mod:NewCDTimer(15, 138923)--Variable beyond usefulness. anywhere from 18 second cd and 50.
local timerQuills			= mod:NewBuffActiveTimer(10, 134380)
local timerQuillsCD			= mod:NewCDCountTimer(62.5, 134380)--variable because he has two other channeled abilities with different cds, so this is cast every 62.5-67 seconds usually after channel of some other spell ends
local timerFlockCD	 		= mod:NewTimer(30, "timerFlockCD", 15746)
local timerFeedYoungCD	 	= mod:NewCDTimer(30, 137528)--30-40 seconds (always 30 unless delayed by other channeled spells)
local timerTalonRakeCD		= mod:NewCDTimer(20, 134366, mod:IsTank() or mod:IsHealer())--20-30 second variation
local timerTalonRake		= mod:NewTargetTimer(60, 134366, mod:IsTank() or mod:IsHealer())
local timerDowndraft		= mod:NewBuffActiveTimer(10, 134370)
local timerDowndraftCD		= mod:NewCDTimer(97, 134370)
local timerFlight			= mod:NewBuffFadesTimer(10, 133755)
local timerPrimalNutriment	= mod:NewBuffFadesTimer(30, 140741)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local nest = 0
local flockCount = 0
local quillsCount = 0
local flockName = EJ_GetSectionInfo(7348)

function mod:OnCombatStart(delay)
	nest = 0
	flockCount = 0
	quillsCount = 0
	if self:IsDifficulty("normal10", "heroic10", "lfr25") then
		timerQuillsCD:Start(60-delay, 1)
	else
		timerQuillsCD:Start(42.5-delay, 1)
	end
	timerDowndraftCD:Start(91-delay)
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134366 then
		local amount = args.amount or 1
		warnTalonRake:Show(args.destName, amount)
		timerTalonRake:Start(args.destName)
		timerTalonRakeCD:Start()
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnTalonRake:Show(amount)
			end
		else
			if amount >= 1 and not UnitDebuff("player", GetSpellInfo(134366)) and not UnitIsDeadOrGhost("player") then
				specWarnTalonRakeOther:Show(args.destName)
			end
		end
	elseif args.spellId == 137528 then
		warnFeedYoung:Show()
		specWarnFeedYoung:Show()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerFeedYoungCD:Start(40)
		else
			timerFeedYoungCD:Start()
		end
	elseif args.spellId == 133755 and args:IsPlayer() then
		timerFlight:Start()
	elseif args.spellId == 140741 and args:IsPlayer() then
		timerPrimalNutriment:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134366 then
		timerTalonRake:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 134380 then
		quillsCount = quillsCount + 1
		warnQuills:Show(quillsCount)
		specWarnQuills:Show()
		timerQuills:Start()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerQuillsCD:Start(81, quillsCount+1)--81 sec normal, sometimes 91s?
		else
			timerQuillsCD:Start(nil, quillsCount+1)
		end
	elseif args.spellId == 134370 then
		warnDowndraft:Show()
		specWarnDowndraft:Show()
		timerDowndraft:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDowndraftCD:Start(93)
		else
			timerDowndraftCD:Start()--Todo, confirm they didn't just change normal to 90 as well. in my normal logs this had a 110 second cd on normal
		end
	elseif args.spellId == 134380 and self:AntiSpam(2, 1) then--Maybe adjust anti spam a bit or find a different way to go about this. It is important information though.
		warnLayEgg:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:138923") then--Caws (does not show in combat log, like a lot of stuff this tier) Fortunately easy to detect this way without localizing
		warnCaws:Show()
		--timerCawsCD
	end
end

--[[LFR. I think LFR only uses 3 nest locations repeating, NE, SE, SW. but hard to confirm when boss dies within 5 nests.
Nest1: Lower NE

Nest2: Lower SE

Nest3: Lower SW

Nest4: Upper NE

Nest5: Upper SE

Nest6: Upper Middle

Nest7: Lower NE
--]]

--[[10N
       01 Nest 01      : Lower
+00:40 02 Nest 02      : Lower
+01:20 03 Nest 03      : Lower
+02:00 04 Nest 04      : Upper
+02:40 05 Nest 05      : Upper
+03:20 06 Nest 06      : Upper
+04:00 07 Nest 07      : Lower
+04:40 08 Nest 08      : Lower
+05:20 09 Nest 09 & 10 : Upper & Lower
+06:00 10 Nest 11      : Upper
+06:40 11 Nest 12      : Upper
+07:20 12 Nest 13      : Lower
+08:00 13 Nest 14      : Lower
+08:40 14 Nest 15 & 16 : Upper & Lower
--]]

--[[10H
Nest1: Lower

Nest2: Lower

Nest3: Lower

Nest4: Upper

Nest5: Upper

Nest6: Upper

Nest7: Lower

Nest8: Lower

Nest9: Lower
Nest10: Upper

Nest11: Upper

Nest12: Upper

Nest13: Lower

Nest14: Lower

Nest15: Lower
Nest16: Upper

Nest17: Upper

Nest18: Upper
--]]

local flockTable10 = {
	[1] = { loc = L.Lower }, [2] = { loc = L.Lower, add = true }, [3] = { loc = L.Lower },
	[4] = { loc = L.Upper, add = true }, [5] = { loc = L.Upper }, [6] = { loc = L.Upper },
	[7] = { loc = L.Lower }, [8] = { loc = L.Lower, add = true }, [9] = { loc = L.UpperAndLower },
	[10] = { loc = L.Upper }, [11] = { loc = L.Upper, add = true },
	[12] = { loc = L.Lower }, [13] = { loc = L.Lower, add = true }, [14] = { loc = L.UpperAndLower },
	[15] = { loc = L.Upper }, [16] = { loc = L.Upper }
}

local flockTable25N = {
	[1] = { loc = L.Lower, dir = { L.NorthEast } },
	[2] = { loc = L.Lower, dir = { L.SouthEast } },
	[3] = { loc = L.Lower, dir = { L.SouthWest } },
	[4] = { loc = L.Lower, dir = { L.West } },
	[5] = { loc = L.UpperAndLower, dir = { L.NorthWest, L.NorthEast } },
	[6] = { loc = L.Upper, dir = { L.SouthEast } },
	[7] = { loc = L.Upper, dir = { L.Middle } },
	[8] = { loc = L.UpperAndLower, dir = { L.NorthEast, L.SouthWest } },
	[9] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.NorthWest } },
	[10] = { loc = L.Lower, dir = { L.SouthEast } },
	[11] = { loc = L.Lower, dir = { L.West } },
	[12] = { loc = L.UpperAndLower, dir = { L.NorthWest, L.NorthEast } },
	[13] = { loc = L.Upper, dir = { L.SouthEast } },
	[14] = { loc = L.UpperAndLower, dir = { L.NorthEast, L.Middle } },
	[15] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.SouthWest } },
	[16] = { loc = L.UpperAndLower, dir = { L.SouthWest, L.NorthWest } },
	[17] = { loc = L.Lower, dir = { L.West } },
	[18] = { loc = L.UpperAndLower, dir = { L.NorthWest, L.NorthEast } },
	[19] = { loc = L.UpperAndLower, dir = { DBM_CORE_UNKNOWN, L.SouthEast } },
	[20] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.Middle } }
}

local flockTable25H = {
	[1] = { loc = L.Lower, dir = { L.NorthEast } },
	[2] = { loc = L.Lower, dir = { L.SouthEast }, add = { loc = L.Lower, dir = L.SouthEast } },
	[3] = { loc = L.Lower, dir = { L.SouthWest } },
	[4] = { loc = L.UpperAndLower, dir = { L.West, L.NorthEast } },
	[5] = { loc = L.UpperAndLower, dir = { L.NorthWest, L.SouthEast }, add = { loc = L.Lower, dir = L.NorthWest } },
	[6] = { loc = L.Upper, dir = { L.Middle } },
	[7] = { loc = L.UpperAndLower, dir = { L.NorthEast, L.SouthWest } },
	[8] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.NorthWest }, add = { loc = L.Upper, dir = L.NorthWest } },
	[9] = { loc = L.Lower, dir = { L.SouthWest } },
	[10] = { loc = L.UpperAndLower, dir = { L.NorthEast, L.West } },
	[11] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.NorthWest }, add = { loc = L.Upper, dir = L.SouthEast } },
	[12] = { loc = L.UpperAndLower, dir = { L.NorthEast, L.Middle } },
	[13] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.SouthWest } },
	[14] = { loc = L.TrippleU, dir = { L.NorthEast, L.SouthWest, L.NorthWest }, add = { loc = L.Lower, dir = L.SouthWest } },
	[15] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.West } },
	[16] = { loc = L.TrippleD, dir = { L.NorthEast, L.Middle, L.NorthWest } },
	[17] = { loc = L.UpperAndLower, dir = { L.SouthEast, L.SouthWest } },
	[18] = { loc = L.TrippleU, dir = { L.NorthEast, L.SouthWest, L.NorthWest } },
	[19] = { loc = L.TrippleD, dir = { L.NorthWest, L.SouthEast, L.NorthEast } }
}

local function FormatNestLoc(dirs)
	local ret, num = "", #dirs
	for i, v in pairs(dirs) do
		nest = nest + 1
		ret = ret .. format("%d-%s", nest, v)
		if i ~= num then
			ret = ret .. ", "
		end
	end
	return ret
end

local function GetNestPositions(flockC)
	local dir = DBM_CORE_UNKNOWN --direction
	local loc = "" --location
	local add = nil
	if mod:IsDifficulty("lfr25") then
		--LFR: L, L, L, U, U, U (Repeating)
		if ((flockC-1) % 6) < 3 then dir = L.Lower -- 1,2,3,7,8,9,...
		else                         dir = L.Upper -- 6,7,8,10,11,12,...
		end
	elseif mod:IsDifficulty("normal10", "heroic10") then
		--TODO, find out locations for these to improve the warnings.
		dir, add = flockTable10[flockC].loc, flockTable10[flockC].add
	elseif mod:IsDifficulty("normal25") then
		--Nest Data Sources:
		--http://www.youtube.com/watch?v=jo0BKuuh5xw
		--http://www.youtube.com/watch?feature=player_detailpage&v=F0bxpAwdOnk#t=471s
		--http://www.youtube.com/watch?feature=player_detailpage&v=lNWaVd5Ur1o#t=528s
		dir, loc = flockTable25N[flockC].loc or DBM_CORE_UNKNOWN, FormatNestLoc(flockTable25N[flockC].dir) or ""
	elseif mod:IsDifficulty("heroic25") then
		--maybe rework it still so the loc itself include upper/lower in each location. i just couldn't think of a clean way of doing it at the moment without completely breaking other difficulties or making message text REALLY long
		--http://www.youtube.com/watch?feature=player_detailpage&v=nMSbQJBlKwM
		dir, loc, add = flockTable25H[flockC].loc or DBM_CORE_UNKNOWN, FormatNestLoc(flockTable25H[flockC].dir) or "", flockTable25H[flockC].add
	end
	return dir, loc, add
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if (msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU)) and self:AntiSpam(5, 2) then
		flockCount = flockCount + 1--Now flock set number instead of nest number (for LFR it's both)
		local flockCountText = tostring(flockCount)
		local currentDirection, currentLocation, currentAdd = GetNestPositions(flockCount)
		local nextDirection, _, nextAdd = GetNestPositions(flockCount+1)--timer code will probably always stay the same, locations in timer is too much text for a timer.
		if self:IsDifficulty("lfr25", "normal10", "heroic10") then
			timerFlockCD:Show(40, flockCount+1, nextDirection)
		else
			timerFlockCD:Show(30, flockCount+1, nextDirection)
		end
		if self:IsDifficulty("heroic10") then
			if currentAdd then
				specWarnBigBird:Show(currentDirection)
			end
			-- pre-warning 10 sec before Nest Guardian spawn
			if nextAdd then
				specWarnBigBirdSoon:Schedule(30, nextDirection)
			end
		elseif self:IsDifficulty("heroic25") then
			if currentAdd then
				specWarnBigBird:Show(currentAdd.loc.." ("..currentAdd.dir..")")
			end
			-- pre-warning 10 sec before Nest Guardian spawn
			if nextAdd then
				specWarnBigBirdSoon:Schedule(20, nextAdd.loc.." ("..nextAdd.dir..")")
			end
		end
		if currentLocation ~= "" then
			warnFlock:Show(currentDirection, flockName, flockCountText.." ("..currentLocation..")")
			specWarnFlock:Show(currentDirection, flockName, flockCountText.." ("..currentLocation..")")
		else
			warnFlock:Show(currentDirection, flockName, "("..flockCountText..")")
			specWarnFlock:Show(currentDirection, flockName, "("..flockCountText..")")
		end
	end
end