if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
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

local specWarnQuills		= mod:NewSpecialWarningSpell(134380, nil, nil, nil, true)
local specWarnFlock			= mod:NewSpecialWarning("specWarnFlock", false)--For those assigned in egg/bird killing group to enable on their own (and tank on heroic)
local specWarnTalonRake		= mod:NewSpecialWarningStack(134366, mod:IsTank(), 3)--Might change to 2 if blizz fixes timing issues with it
local specWarnTalonRakeOther= mod:NewSpecialWarningTarget(134366, mod:IsTank())
local specWarnDowndraft		= mod:NewSpecialWarningSpell(134370, nil, nil, nil, true)
local specWarnFeedYoung		= mod:NewSpecialWarningSpell(137528)

--local timerCawsCD			= mod:NewCDTimer(15, 138923)--Variable beyond usefulness. anywhere from 18 second cd and 50.
local timerQuillsCD			= mod:NewCDTimer(60, 134380)--variable because he has two other channeled abilities with different cds, so this is cast every 60-67 seconds usually after channel of some other spell ends
local timerFlockCD	 		= mod:NewNextCountTimer(30, "ej7348", nil, nil, nil, 15746)
--local timerTalonRakeCD	= mod:NewCDTimer(10, 134366, mod:IsTank() or mod:IsHealer())--10 second cd but delayed by everything else. Example variation, 12, 15, 9, 25, 31
local timerTalonRake		= mod:NewTargetTimer(60, 134366, mod:IsTank() or mod:IsHealer())
local timerDowndraftCD		= mod:NewCDTimer(110, 134370)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local flockCount = 0
local lastFlock = 0
local flockName = EJ_GetSectionInfo(7348)

function mod:OnCombatStart(delay)
	flockCount = 0
	timerQuillsCD:Start(50-delay)
	timerDowndraftCD:Start(-delay)
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
		if args:IsPlayer() then
			if (args.amount or 1) >= 3 then
				specWarnTalonRake:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 2 and not UnitDebuff("player", GetSpellInfo(134366)) and not UnitIsDeadOrGhost("player") then
				specWarnTalonRakeOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(137528) then
		warnFeedYoung:Show()
		specWarnFeedYoung:Show()
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

--10 man does 3 down 3 up
--25 man is a clusterfuck of random L, L, L, L, Both(5 and 6), U, U, Both (9 and 10), Both (11 & 12), L, ... (more data and higher counts needed)
--[[
"<7.8 19:02:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#500#nil#0#false#false", -- [1]
"<37.7 19:02:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#502#nil#0#false#false", -- [2]
"<67.6 19:03:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#504#nil#0#false#false", -- [3]
"<97.8 19:03:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#505#nil#0#false#false", -- [4]
"<127.6 19:04:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#509#nil#0#false#false", -- [5]
"<127.6 19:04:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the upper nests begin to hatch!#Incubater###Incubater##0#0##0#510#nil#0#false#false", -- [6]
"<157.8 19:04:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the upper nests begin to hatch!#Incubater###Incubater##0#0##0#512#nil#0#false#false", -- [7]
"<187.6 19:05:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the upper nests begin to hatch!#Incubater###Incubater##0#0##0#514#nil#0#false#false", -- [8]
"<217.8 19:05:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#524#nil#0#false#false", -- [9]
"<217.8 19:05:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the upper nests begin to hatch!#Incubater###Incubater##0#0##0#525#nil#0#false#false", -- [10]
"<247.7 19:06:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#529#nil#0#false#false", -- [11]
"<247.7 19:06:09> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the upper nests begin to hatch!#Incubater###Incubater##0#0##0#530#nil#0#false#false", -- [12]
"<277.8 19:06:39> CHAT_MSG_MONSTER_EMOTE#The eggs in one of the lower nests begin to hatch!#Incubater###Incubater##0#0##0#536#nil#0#false#false", -- [13]
--]]
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU) then
		flockCount = flockCount + 1
		local messageText = msg:find(L.eggsHatchL) and L.Lower or L.Upper
		if GetTime() - lastFlock < 5 then--On 25 man, you get two at same time sometimes, we detect that here and revise message
			messageText = L.UpperAndLower
		end
		warnFlock:Cancel()
		specWarnFlock:Cancel()
		timerFlockCD:Cancel()
		warnFlock:Schedule(0.5, messageText, flockName, flockCount)
		specWarnFlock:Schedule(0.5, messageText, flockName, flockCount)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFlockCD:Show(40, flockCount+1)--TODO: confirm this isn't just a 10 man change. it was 40sec on heroic 10 man, 30  on 10 normal and 25 normal. but they coulda changed 10 normal after testing it.
		else
			timerFlockCD:Show(30, flockCount+1)
		end
		lastFlock = GetTime()
	end
end
