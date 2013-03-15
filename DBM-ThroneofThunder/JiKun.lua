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
local warnQuills			= mod:NewSpellAnnounce(134380, 4)
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
local specWarnBigBird		= mod:NewSpecialWarningSwitch("ej7827", mod:IsTank())

--local timerCawsCD			= mod:NewCDTimer(15, 138923)--Variable beyond usefulness. anywhere from 18 second cd and 50.
local timerQuillsCD			= mod:NewCDTimer(60, 134380)--variable because he has two other channeled abilities with different cds, so this is cast every 60-67 seconds usually after channel of some other spell ends
local timerFlockCD	 		= mod:NewTimer(30, "timerFlockCD", 15746)
local timerTalonRakeCD		= mod:NewCDTimer(20, 134366, mod:IsTank() or mod:IsHealer())--20-30 second variation
local timerTalonRake		= mod:NewTargetTimer(60, 134366, mod:IsTank() or mod:IsHealer())
local timerDowndraftCD		= mod:NewCDTimer(97, 134370)
local timerFlight			= mod:NewBuffFadesTimer(10, 133755)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local flockC = 0
local lastFlock = 0
local flockName = EJ_GetSectionInfo(7348)

function mod:OnCombatStart(delay)
	flockC = 0
	timerQuillsCD:Start(42.5-delay)
	timerDowndraftCD:Start(91-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(134366) then
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
	elseif args:IsSpellID(137528) then
		warnFeedYoung:Show()
		specWarnFeedYoung:Show()
	elseif args:IsSpellID(133755) and args:IsPlayer() then
		timerFlight:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(134366) then
		timerTalonRake:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(134380) then
		warnQuills:Show()
		specWarnQuills:Show()
		timerQuillsCD:Start()
	elseif args:IsSpellID(134370) then
		warnDowndraft:Show()
		specWarnDowndraft:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDowndraftCD:Start(93)
		else
			timerDowndraftCD:Start()--Todo, confirm they didn't just change normal to 90 as well. in my normal logs this had a 110 second cd on normal
		end
	elseif args:IsSpellID(134380) and self:AntiSpam(2, 1) then--Maybe adjust anti spam a bit or find a different way to go about this. It is important information though.
		warnLayEgg:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:138923") then--Caws (does not show in combat log, like a lot of stuff this tier) Fortunately easy to detect this way without localizing
		warnCaws:Show()
		--timerCawsCD
	end
end

--10N/H: L, L, L, U, U, U (Repeating)
--25N: Lower (1), Lower (2), Lower (3), Lower (4), Lower & Upper (5+6), Upper (7), Upper (8), Lower & Upper (9+10), Lower & Upper (11+12), Lower (13), Lower (14), Lower & Upper (15+16), Upper (17), Lower & Upper (18+19), Lower & Upper (20+21), Lower & Upper (22+23), Lower (24), Lower & Upper (25+26), Lower & Upper (27+28)
--25H: L (1), L (2), L (3), L & U (4+5), L & U (6+7), U (8), L & U (9+10), L & U (11+12), L (13), U & L (14+15), U & L (16+17) -- 25 H (credits to caleb for some of 25 man nest)
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU) then
		flockC = flockC + 1
		local messageText = msg:find(L.eggsHatchL) and L.Lower or L.Upper
		local flockText = tostring(flockC)
		if GetTime() - lastFlock < 5 then--On 25 man, you get two at same time sometimes, we detect that here and revise message
			messageText = L.UpperAndLower
			flockText = tostring(flockC - 1)..", "..tostring(flockC)
		end
		warnFlock:Cancel()
		specWarnFlock:Cancel()
		timerFlockCD:Cancel()--So we don't get two timers on the double nests on 25 man
		warnFlock:Schedule(0.5, messageText, flockName, flockText)
		specWarnFlock:Schedule(0.5, messageText, flockName, flockText)
		--TODO, once verifying nest orders are same on live, and that 25H isn't new 25N numbers, add what next nest is.
		if self:IsDifficulty("normal10") then
			if flockC == 1 or flockC == 2 or flockC == 6 or flockC == 7 or flockC == 8 or flockC == 12 or flockC == 13 or flockC == 14 or flockC == 18 or flockC == 19 or flockC == 20 or flockC == 24 or flockC == 25 or flockC == 26 or flockC == 30 or flockC == 31 or flockC == 32 then--Lower is next
				timerFlockCD:Show(40, flockC+1, L.Lower)
			elseif flockC == 3 or flockC == 4 or flockC == 5 or flockC == 9 or flockC == 10 or flockC == 11 or flockC == 15 or flockC == 16 or flockC == 17 or flockC == 21 or flockC == 22 or flockC == 23 or flockC == 27 or flockC == 28 or flockC == 29 or flockC == 33 or flockC == 34 or flockC == 35 then--Upper is next
				timerFlockCD:Show(40, flockC+1, L.Upper)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(40, flockC+1, DBM_CORE_UNKNOWN)
			end
		elseif self:IsDifficulty("heroic10") then--TODO, see if heroic 10 is still 40 seconds in between for some reason (also, see if LFR is same pattern)
			if flockC == 1 or flockC == 2 or flockC == 6 or flockC == 7 or flockC == 8 or flockC == 12 or flockC == 13 or flockC == 14 or flockC == 18 or flockC == 19 or flockC == 20 or flockC == 24 or flockC == 25 or flockC == 26 or flockC == 30 or flockC == 31 or flockC == 32 then--Lower is next
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 3 or flockC == 4 or flockC == 5 or flockC == 9 or flockC == 10 or flockC == 11 or flockC == 15 or flockC == 16 or flockC == 17 or flockC == 21 or flockC == 22 or flockC == 23 or flockC == 27 or flockC == 28 or flockC == 29 or flockC == 33 or flockC == 34 or flockC == 35 then--Upper is next
				timerFlockCD:Show(30, flockC+1, L.Upper)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			end
		elseif self:IsDifficulty("normal25") then
			if flockC == 1 or flockC == 2 or flockC == 3 or flockC == 12 or flockC == 13 or flockC == 23 then--Lower is next
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 6 or flockC == 7 or flockC == 16 then--Upper is next
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 4 or flockC == 8 or flockC == 10 or flockC == 14 or flockC == 17 or flockC == 19 or flockC == 21 or flockC == 24 or flockC == 26 then--Both are next
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			end
		elseif self:IsDifficulty("heroic25") then
			if flockC == 1 or flockC == 2 or flockC == 12 then--Lower is next
				timerFlockCD:Show(30, flockC+1, L.Lower)
			elseif flockC == 7 then--Upper is next
				timerFlockCD:Show(30, flockC+1, L.Upper)
			elseif flockC == 3 or flockC == 5 or flockC == 8 or flockC == 10 or flockC == 13 or flockC == 15 then--Both are next
				timerFlockCD:Show(30, flockC+1, L.UpperAndLower)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(30, flockC+1, DBM_CORE_UNKNOWN)
			end
		else--LFR, which we have no data for yet.
			timerFlockCD:Show(30, flockC+1)
		end
		lastFlock = GetTime()
		if self:IsDifficulty("heroic10") and flockC % 2 == 0 or self:IsDifficulty("heroic25") and (flockC == 2 or flockC == 6 or flockC == 12) then--TODO, find a pattern to this, or if no pattern, find out what's after 12(+2 +4 +6 +8?)
			specWarnBigBird:Show()
		end
	end
end
