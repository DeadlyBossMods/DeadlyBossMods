local mod	= DBM:NewMod(828, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69712)
mod:SetModelID(46675)

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

local flockC = 0
local quillsCount = 0
local trippleNest = false
local flockName = EJ_GetSectionInfo(7348)

function mod:OnCombatStart(delay)
	flockC = 0
	quillsCount = 0
	trippleNest = false
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
		warnTalonRake:Show(args.destName, args.amount or 1)
		timerTalonRake:Start(args.destName)
		timerTalonRakeCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnTalonRake:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(134366)) and not UnitIsDeadOrGhost("player") then
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

--[[10H (are 10N and LFR the same?), Locations were wrong so removed.
--10man/LFR just won't have locations feature as i don't run those formats and can never verify them
--Not that there is much to get confused about on 10 man anyways, only one nest at a time
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
Nest19: Lower
Nest20: Lower
Nest21: Lower
Nest22: Upper
Nest23: Upper
Nest24: Upper
Nest25: Lower
Nest26: Lower
Nest27: Lower
Nest28: Upper
--]]
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if (msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU)) and self:AntiSpam(5, 2) then
		flockC = flockC + 1--Now flock set number instead of nest number (at least for 25, for 10man/LFR it's both)
		local messageText = msg:find(L.eggsHatchL) and L.Lower or L.Upper--For 10man/LFR
		local locationText = ""--Set to "" so if location is nil we don't alter mods older message functionality
		local flockText = tostring(flockC)
		--10N/10H/LFR: L, L, L, U, U, U (Repeating)
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			--Timer code will probably always stay the same, locations in timer is too much text for a timer.
			if flockC == 1 or flockC == 2 or flockC == 6 or flockC == 7 or flockC == 8 or flockC == 12 or flockC == 13 or flockC == 14 or flockC == 18 or flockC == 19 or flockC == 20 or flockC == 24 or flockC == 25 or flockC == 26 or flockC == 30 or flockC == 31 or flockC == 32 then--Lower is next
				timerFlockCD:Show(40, flockC+1, L.Lower)
			elseif flockC == 3 or flockC == 4 or flockC == 5 or flockC == 9 or flockC == 10 or flockC == 11 or flockC == 15 or flockC == 16 or flockC == 17 or flockC == 21 or flockC == 22 or flockC == 23 or flockC == 27 or flockC == 28 or flockC == 29 or flockC == 33 or flockC == 34 or flockC == 35 then--Upper is next
				timerFlockCD:Show(40, flockC+1, L.Upper)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(40, flockC+1, DBM_CORE_UNKNOWN)
			end
			--TODO, find out locations for these to improve the warnings.
			if self:IsDifficulty("heroic10") then
				if flockC == 2 then
					--locationText = L.SouthEast
					specWarnBigBird:Show(messageText)
				elseif flockC == 4 then
					--locationText = L.West
					specWarnBigBird:Show(messageText)
				elseif flockC == 8 then
					--locationText = L.SouthWest
					specWarnBigBird:Show(messageText)
				elseif flockC == 12 then
					--locationText = L.NorthWest
					specWarnBigBird:Show(messageText)
				elseif flockC == 14 then
					--locationText = L.West
					specWarnBigBird:Show(messageText)
				end
			end
		elseif self:IsDifficulty("normal25") then
			--Nest Data Sources:
			--http://www.youtube.com/watch?v=jo0BKuuh5xw
			--http://www.youtube.com/watch?feature=player_detailpage&v=F0bxpAwdOnk#t=471s
			--http://www.youtube.com/watch?feature=player_detailpage&v=lNWaVd5Ur1o#t=528s
			if flockC == 1 then--1
				messageText, locationText = L.Lower, "1-"..L.NorthEast--Lower NE
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 2 then--2
				messageText, locationText = L.Lower, "2-"..L.SouthEast--Lower SE
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 3 then--3
				messageText, locationText = L.Lower, "3-"..L.SouthWest--Lower SW
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 4 then--4
				messageText, locationText = L.Lower, "4-"..L.West--Lower W
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 5 then--5-6
				messageText, locationText = L.UpperAndLower, "5-"..L.NorthWest..", 6-"..L.NorthEast--Lower NW, Upper NE
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 6 then--7
				messageText, locationText = L.Upper, "7-"..L.SouthEast--Upper SE
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 7 then--8
				messageText, locationText = L.Upper, "8-"..L.Middle--Upper Middle
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 8 then--9-10
				messageText, locationText = L.UpperAndLower, "9-"..L.NorthEast..", 10-"..L.SouthWest--Lower NE & Upper SW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 9 then--11-12
				messageText, locationText = L.UpperAndLower, "11-"..L.SouthEast..", 12-"..L.NorthWest--Lower SE & Upper NW
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 10 then--13
				messageText, locationText = L.Lower, "13-"..L.SouthWest--Lower SW
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 11 then--14
				messageText, locationText = L.Lower, "14-"..L.West--Lower W
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 12 then--15-16
				messageText, locationText = L.UpperAndLower, "15-"..L.NorthWest..", 16-"..L.NorthEast--Lower NW & Upper NE
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 13 then--17
				messageText, locationText = L.Upper, "17-"..L.SouthEast--Upper SE
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 14 then--18-19
				messageText, locationText = L.UpperAndLower, "18-"..L.NorthEast..", 19-"..L.Middle--Lower NE & Upper Middle
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 15 then--20-21
				messageText, locationText = L.UpperAndLower, "20-"..L.SouthEast..", 21-"..L.SouthWest--Lower SE & Upper SW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 16 then--22-23
				messageText, locationText = L.UpperAndLower, "22-"..L.SouthWest..", 23-"..L.NorthWest--Lower SW & Upper NW
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 17 then--24
				messageText, locationText = L.Lower, "24-"..L.West--Lower W
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 18 then--25-26
				messageText, locationText = L.UpperAndLower, "25-"..L.NorthWest..", 26-"..L.NorthEast--Lower NW & Upper NE
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 19 then--27-28
				messageText, locationText = L.UpperAndLower, "27-"..DBM_CORE_UNKNOWN..", 28-"..L.SouthEast--Lower ? & Upper SE
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 20 then--29-30
				messageText, locationText = L.UpperAndLower, "29-"..L.Southeast..", 30-"..L.Middle--Lower ? & Upper SE
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			else
				messageText, locationText = DBM_CORE_UNKNOWN, ""
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			end
		elseif self:IsDifficulty("heroic25") then
			--maybe rework it still so the locationText itself include upper/lower in each location. i just couldn't think of a clean way of doing it at the moment without completely breaking other difficulties or making message text REALLY long
			--http://www.youtube.com/watch?feature=player_detailpage&v=nMSbQJBlKwM
			if flockC == 1 then--1
				messageText, locationText = L.Lower, "1-"..L.NorthEast--Lower NE
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 2 then--2
				messageText, locationText = L.Lower, "2-"..L.SouthEast--Lower SE
				specWarnBigBird:Show(messageText.." ("..locationText..")")
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 3 then--3
				messageText, locationText = L.Lower, "3-"..L.SouthWest--Lower SW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 4 then--4-5
				messageText, locationText = L.UpperAndLower, "4-"..L.West..", 5-"..L.NorthEast--Lower W, Upper NE
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 5 then--6-7
				messageText, locationText = L.UpperAndLower, "6-"..L.NorthWest..", 7-"..L.SouthEast--Lower NW, Upper SE
				specWarnBigBird:Show(L.Lower.." ("..L.NorthWest..")")
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 6 then--8
				messageText, locationText = L.Upper, "8-"..L.Middle--Upper Middle
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 7 then--9-10
				messageText, locationText = L.UpperAndLower, "9-"..L.NorthEast..", 10-"..L.SouthWest--Lower NE, Upper SW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 8 then--11-12
				messageText, locationText = L.UpperAndLower, "11-"..L.SouthEast..", 12-"..L.NorthWest--Lower SE, Upper NW
				specWarnBigBird:Show(L.Upper.." ("..L.NorthWest..")")
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 9 then--13
				messageText, locationText = L.Lower, "13-"..L.SouthWest--Lower SW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 10 then--14-15
				messageText, locationText = L.UpperAndLower, "14-"..L.NorthEast..", 15-"..L.West--Upper NE, Lower W
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 11 then--16-17
				messageText, locationText = L.UpperAndLower, "16-"..L.SouthEast..", 17-"..L.NorthWest--Upper SE, Lower NW
				specWarnBigBird:Show(L.Upper.." ("..L.SouthEast..")")
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 12 then--18-19
				messageText, locationText = L.UpperAndLower, "18-"..L.NorthEast..", 19-"..L.Middle--Lower NE, Upper Middle
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 13 then--20-21
				messageText, locationText = L.UpperAndLower, "20-"..L.SouthEast..", 21-"..L.SouthWest--Lower SE, Upper SW
				timerFlockCD:Show(30, flockC+1, L.TrippleU)
			elseif flockC == 14 then--22-24
				messageText, locationText = L.TrippleU, "22-"..L.NorthEast..", 23-"..L.SouthWest..", 24-"..L.NorthWest--Upper NE, Lower SW, Upper NW
				specWarnBigBird:Show(L.Lower.." ("..L.SouthWest..")")
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 15 then--25-26
				messageText, locationText = L.UpperAndLower, "25-"..L.SouthEast..", 26-"..L.West--Upper SE, Lower W
				timerFlockCD:Show(30, flockC+1, L.TrippleD)
			elseif flockC == 16 then--27-29
				messageText, locationText = L.TrippleD, "27-"..L.NorthEast..", 28-"..L.Middle..", 29-"..L.NorthWest--Lower NE, Upper Middle, Lower NW
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			elseif flockC == 17 then--30-31
				messageText, locationText = L.UpperAndLower, "30-"..L.SouthEast..", 31-"..L.SouthWest--Lower SE, Upper SW
				timerFlockCD:Show(30, flockC+1, L.TrippleU)
			elseif flockC == 18 then--32-34
				messageText, locationText = L.TrippleU, "32-"..L.NorthEast..", 33-"..L.SouthWest..", 34-"..L.NorthWest--Upper NE, Lower SW, Upper NW
				timerFlockCD:Show(30, flockC+1, L.TrippleD)
			elseif flockC == 19 then--35-37
				messageText, locationText = L.TrippleD, "35-"..L.NorthWest..", 36-"..L.SouthEast..", 37-"..L.NorthEast--Lower NW, Upper SE, Lower NE
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			else
				messageText, locationText = DBM_CORE_UNKNOWN, ""
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			end
		else--Shouldn't be an else, but just failsafe code
			timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
		end
		if locationText ~= "" then
			warnFlock:Show(messageText, flockName, flockText.." ("..locationText..")")
			specWarnFlock:Show(messageText, flockName, flockText.." ("..locationText..")")
		else
			warnFlock:Show(messageText, flockName, "("..flockText..")")
			specWarnFlock:Show(messageText, flockName, "("..flockText..")")
		end
	end
end
