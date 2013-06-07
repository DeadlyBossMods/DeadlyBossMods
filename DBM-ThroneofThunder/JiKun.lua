local mod	= DBM:NewMod(828, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69712)
mod:SetQuestID(32749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_CHANNEL_START boss1",
	"UNIT_SPELLCAST_START boss1",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnCaws				= mod:NewSpellAnnounce(138923, 2)
local warnQuills			= mod:NewCountAnnounce(134380, 4)
local warnFlock				= mod:NewAnnounce("warnFlock", 3, 15746)--Some random egg icon
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
local specWarnBigBirdSoon	= mod:NewSpecialWarning("specWarnBigBirdSoon", false)
local specWarnFeedPool		= mod:NewSpecialWarningMove(138319, false)

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

local flockCount = 0
local quillsCount = 0
local flockName = EJ_GetSectionInfo(7348)

function mod:OnCombatStart(delay)
	flockCount = 0
	quillsCount = 0
	timerTalonRakeCD:Start(24)
	if self:IsDifficulty("normal10", "heroic10", "lfr25") then
		timerQuillsCD:Start(60-delay, 1)
	else
		timerQuillsCD:Start(42.5-delay, 1)
	end
	timerDowndraftCD:Start(91-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	if self.Options.SpecWarn138319move then--specWarnFeedPool is turned on, since it's off by default, no reasont to register high CPU events unless user turns it on
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE",
			"SPELL_PERIODIC_MISSED"
		)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138319 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFeedPool:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, _, _, spellId)
	if spellId == 137528 then
		warnFeedYoung:Show()
		specWarnFeedYoung:Show()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerFeedYoungCD:Start(40)
		else
			timerFeedYoungCD:Start()
		end
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, _, _, spellId)
	if spellId == 134380 then
		quillsCount = quillsCount + 1
		warnQuills:Show(quillsCount)
		specWarnQuills:Show()
		timerQuills:Start()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerQuillsCD:Start(81, quillsCount+1)--81 sec normal, sometimes 91s?
		else
			timerQuillsCD:Start(nil, quillsCount+1)
		end
	elseif spellId == 134370 then
		warnDowndraft:Show()
		specWarnDowndraft:Show()
		timerDowndraft:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDowndraftCD:Start(93)
		else
			timerDowndraftCD:Start()--Todo, confirm they didn't just change normal to 90 as well. in my normal logs this had a 110 second cd on normal
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:138923") then--Caws (does not show in combat log, like a lot of stuff this tier) Fortunately easy to detect this way without localizing
		warnCaws:Show()
		--timerCawsCD
	end
end

--These need verification
--Also need missing nests
local nestCoords = {
	[1] = { 57.79, 30.15 },--Lower Northeast
	[2] = { 55.14, 60.95 },--Lower Northwest
	[3] = { 45.89, 55.20 },--Lower Southwest
	[4] = { 63.25, 36.04 },--Upper Northeast?
	[5] = { 57.46, 59.61 },--upper Southwest?
	[6] = { 47.00, 40.81 }--Upper Middle
}

local function GetNestPositions(flockC)
	local dir = DBM_CORE_UNKNOWN --direction
	local loc = "" --location
	if mod:IsDifficulty("lfr25") then
		--LFR: L (NE), L (SE), L (SW), U (NE), U (SE), U (M) [repeating]
		local flockCm6 = flockC % 6
		if     flockCm6 == 1 then dir, loc = L.Lower, flockC.."-"..L.NorthEast	--01,07,.. loc = L.NorthEast
		elseif flockCm6 == 2 then dir, loc = L.Lower, flockC.."-"..L.SouthEast	--02,08,.. loc = L.SouthEast
		elseif flockCm6 == 3 then dir, loc = L.Lower, flockC.."-"..L.SouthWest	--03,09,.. loc = L.SouthWest
		elseif flockCm6 == 4 then dir, loc = L.Upper, flockC.."-"..L.NorthEast	--04,10,.. loc = U.NorthEast
		elseif flockCm6 == 5 then dir, loc = L.Upper, flockC.."-"..L.SouthEast	--05,11,.. loc = U.Southeast
		else                      dir, loc = L.Upper, flockC.."-"..L.Middle		--06,12,.. loc = U.Middle
		end
	elseif mod:IsDifficulty("normal10", "heroic10") then
		--TODO, verify locations. 10 man loops same loop as LFR but the double nests put a spin on it.
		if     flockC ==  1 then dir, loc = L.Lower, "1-"..L.NorthEast	--01
		elseif flockC ==  2 then dir, loc = L.Lower, "2-"..L.SouthEast	--02
		elseif flockC ==  3 then dir, loc = L.Lower, "3-"..L.SouthWest	--03
		elseif flockC ==  4 then dir, loc = L.Upper, "4-"..L.NorthEast  --04
		elseif flockC ==  5 then dir, loc = L.Upper, "5-"..L.SouthEast--05
		elseif flockC ==  6 then dir, loc = L.Upper, "6-"..L.Middle	--06
		elseif flockC ==  7 then dir, loc = L.Lower, "7-"..L.NorthEast	--07
		elseif flockC ==  8 then dir, loc = L.Lower, "8-"..L.SouthEast	--08
		elseif flockC ==  9 then dir, loc = L.UpperAndLower, "9-"..L.SouthWest..", 10-"..L.NorthEast --9-10
		elseif flockC == 10 then dir, loc = L.Upper, "11-"..L.SouthEast --11
		elseif flockC == 11 then dir, loc = L.Upper, "12-"..L.Middle	--12
		elseif flockC == 12 then dir, loc = L.Lower, "13-"..L.NorthEast	--13
		elseif flockC == 13 then dir, loc = L.Lower, "14-"..L.SouthEast	--14
		elseif flockC == 14 then dir, loc = L.UpperAndLower, "15-"..L.SouthWest..", 16-"..L.NorthEast	--15-16
		elseif flockC == 15 then dir, loc = L.Upper, "17-"..L.SouthEast	--17
		elseif flockC == 16 then dir, loc = L.Upper, "18-"..L.Middle	--18
		end
	elseif mod:IsDifficulty("normal25") then
		--Nest Data Sources:
		--http://www.youtube.com/watch?v=jo0BKuuh5xw
		--http://www.youtube.com/watch?feature=player_detailpage&v=F0bxpAwdOnk#t=471s
		--http://www.youtube.com/watch?feature=player_detailpage&v=lNWaVd5Ur1o#t=528s
		if     flockC ==  1 then dir, loc = L.Lower, "1-"..L.NorthEast										--Lower NE
		elseif flockC ==  2 then dir, loc = L.Lower, "2-"..L.SouthEast										--Lower SE
		elseif flockC ==  3 then dir, loc = L.Lower, "3-"..L.SouthWest										--Lower SW
		elseif flockC ==  4 then dir, loc = L.Lower, "4-"..L.West											--Lower W
		elseif flockC ==  5 then dir, loc = L.UpperAndLower, "5-"..L.NorthWest..", 6-"..L.NorthEast			--Lower NW, Upper NE
		elseif flockC ==  6 then dir, loc = L.Upper, "7-"..L.SouthEast										--Upper SE
		elseif flockC ==  7 then dir, loc = L.Upper, "8-"..L.Middle											--Upper Middle
		elseif flockC ==  8 then dir, loc = L.UpperAndLower, "9-"..L.NorthEast..", 10-"..L.SouthWest		--Lower NE & Upper SW
		elseif flockC ==  9 then dir, loc = L.UpperAndLower, "11-"..L.SouthEast..", 12-"..L.NorthWest		--Lower SE & Upper NW
		elseif flockC == 10 then dir, loc = L.Lower, "13-"..L.SouthWest										--Lower SW
		elseif flockC == 11 then dir, loc = L.Lower, "14-"..L.West											--Lower W
		elseif flockC == 12 then dir, loc = L.UpperAndLower, "15-"..L.NorthWest..", 16-"..L.NorthEast		--Lower NW & Upper NE
		elseif flockC == 13 then dir, loc = L.Upper, "17-"..L.SouthEast										--Upper SE
		elseif flockC == 14 then dir, loc = L.UpperAndLower, "18-"..L.NorthEast..", 19-"..L.Middle			--Lower NE & Upper Middle
		elseif flockC == 15 then dir, loc = L.UpperAndLower, "20-"..L.SouthEast..", 21-"..L.SouthWest		--Lower SE & Upper SW
		elseif flockC == 16 then dir, loc = L.UpperAndLower, "22-"..L.SouthWest..", 23-"..L.NorthWest		--Lower SW & Upper NW
		elseif flockC == 17 then dir, loc = L.Lower, "24-"..L.West											--Lower W
		elseif flockC == 18 then dir, loc = L.UpperAndLower, "25-"..L.NorthWest..", 26-"..L.NorthEast		--Lower NW & Upper NE
		elseif flockC == 19 then dir, loc = L.UpperAndLower, "27-"..DBM_CORE_UNKNOWN..", 28-"..L.SouthEast	--Lower ? & Upper SE
		elseif flockC == 20 then dir, loc = L.UpperAndLower, "29-"..L.Southeast..", 30-"..L.Middle			--Lower SE & Upper Middle?
		end
	elseif mod:IsDifficulty("heroic25") then
		--maybe rework it still so the loc itself include upper/lower in each location. i just couldn't think of a clean way of doing it at the moment without completely breaking other difficulties or making message text REALLY long
		--http://www.youtube.com/watch?feature=player_detailpage&v=nMSbQJBlKwM
		if     flockC ==  1 then dir, loc = L.Lower,          "1-"..L.NorthEast												--Lower NE
		elseif flockC ==  2 then dir, loc = L.Lower,          "2-"..L.SouthEast												--Lower SE
		elseif flockC ==  3 then dir, loc = L.Lower,          "3-"..L.SouthWest												--Lower SW
		elseif flockC ==  4 then dir, loc = L.UpperAndLower,  "4-"..L.West..", 5-"..L.NorthEast								--Lower W, Upper NE
		elseif flockC ==  5 then dir, loc = L.UpperAndLower,  "6-"..L.NorthWest..", 7-"..L.SouthEast						--Lower NW, Upper SE
		elseif flockC ==  6 then dir, loc = L.Upper,          "8-"..L.Middle												--Upper Middle
		elseif flockC ==  7 then dir, loc = L.UpperAndLower,  "9-"..L.NorthEast..", 10-"..L.SouthWest						--Lower NE, Upper SW
		elseif flockC ==  8 then dir, loc = L.UpperAndLower, "11-"..L.SouthEast..", 12-"..L.NorthWest						--Lower SE, Upper NW
		elseif flockC ==  9 then dir, loc = L.Lower,         "13-"..L.SouthWest												--Lower SW
		elseif flockC == 10 then dir, loc = L.UpperAndLower, "14-"..L.NorthEast..", 15-"..L.West							--Upper NE, Lower W
		elseif flockC == 11 then dir, loc = L.UpperAndLower, "16-"..L.SouthEast..", 17-"..L.NorthWest						--Upper SE, Lower NW
		elseif flockC == 12 then dir, loc = L.UpperAndLower, "18-"..L.NorthEast..", 19-"..L.Middle							--Lower NE, Upper Middle
		elseif flockC == 13 then dir, loc = L.UpperAndLower, "20-"..L.SouthEast..", 21-"..L.SouthWest						--Lower SE, Upper SW
		elseif flockC == 14 then dir, loc = L.TrippleU,      "22-"..L.NorthEast..", 23-"..L.SouthWest..", 24-"..L.NorthWest	--Upper NE, Lower SW, Upper NW
		elseif flockC == 15 then dir, loc = L.UpperAndLower, "25-"..L.SouthEast..", 26-"..L.West							--Upper SE, Lower W
		elseif flockC == 16 then dir, loc = L.TrippleD,      "27-"..L.NorthEast..", 28-"..L.Middle..", 29-"..L.NorthWest	--Lower NE, Upper Middle, Lower NW
		elseif flockC == 17 then dir, loc = L.UpperAndLower, "30-"..L.SouthEast..", 31-"..L.SouthWest						--Lower SE, Upper SW
		elseif flockC == 18 then dir, loc = L.TrippleU,      "32-"..L.NorthEast..", 33-"..L.SouthWest..", 34-"..L.NorthWest	--Upper NE, Lower SW, Upper NW
		elseif flockC == 19 then dir, loc = L.TrippleD,      "35-"..L.NorthWest..", 36-"..L.SouthEast..", 37-"..L.NorthEast	--Lower NW, Upper SE, Lower NE
		end
	end
	return dir, loc
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if (msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU)) and self:AntiSpam(5, 2) then
		flockCount = flockCount + 1--Now flock set number instead of nest number (for LFR it's both)
		local flockCountText = tostring(flockCount)
		local currentDirection, currentLocation = GetNestPositions(flockCount)
		local nextDirection, _ = GetNestPositions(flockCount+1)--timer code will probably always stay the same, locations in timer is too much text for a timer.
		if self:IsDifficulty("lfr25", "normal10", "heroic10") then
			timerFlockCD:Show(40, flockCount+1, nextDirection)
		else
			timerFlockCD:Show(30, flockCount+1, nextDirection)
		end
		if self:IsDifficulty("heroic10") then
			if flockCount == 1 or flockCount == 3 or flockCount == 7 or flockCount == 10 or flockCount == 12 then
				specWarnBigBirdSoon:Schedule(30, nextDirection)
			elseif flockCount == 2 or flockCount == 4 or flockCount == 8 or flockCount == 11 or flockCount == 13 then
				specWarnBigBird:Show(currentDirection)
			end
		elseif self:IsDifficulty("heroic25") then
			if     flockCount ==  1 then specWarnBigBirdSoon:Schedule(20, L.Lower.." ("..L.SouthEast..")")
			elseif flockCount ==  4 then specWarnBigBirdSoon:Schedule(20, L.Lower.." ("..L.NorthWest..")")
			elseif flockCount ==  7 then specWarnBigBirdSoon:Schedule(20, L.Upper.." ("..L.NorthWest..")")
			elseif flockCount == 10 then specWarnBigBirdSoon:Schedule(20, L.Upper.." ("..L.SouthEast..")")
			elseif flockCount == 13 then specWarnBigBirdSoon:Schedule(20, L.Lower.." ("..L.SouthWest..")")
			elseif flockCount == 16 then specWarnBigBirdSoon:Schedule(20, L.Lower.." ("..DBM_CORE_UNKNOWN..")")
			elseif flockCount == 19 then specWarnBigBirdSoon:Schedule(20, L.Upper.." ("..DBM_CORE_UNKNOWN..")")
			elseif flockCount ==  2 then specWarnBigBird:Show(L.Lower.." ("..L.SouthEast..")")
			elseif flockCount ==  5 then specWarnBigBird:Show(L.Lower.." ("..L.NorthWest..")")
			elseif flockCount ==  8 then specWarnBigBird:Show(L.Upper.." ("..L.NorthWest..")")
			elseif flockCount == 11 then specWarnBigBird:Show(L.Upper.." ("..L.SouthEast..")")
			elseif flockCount == 14 then specWarnBigBird:Show(L.Lower.." ("..L.SouthWest..")")
			--Reports of birds in next two nests but not precise locations
			elseif flockCount == 17 then specWarnBigBird:Show(L.Lower.." ("..DBM_CORE_UNKNOWN..")")
			elseif flockCount == 20 then specWarnBigBird:Show(L.Upper.." ("..DBM_CORE_UNKNOWN..")")
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
