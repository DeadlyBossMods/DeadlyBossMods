local mod	= DBM:NewMod("DSTrash", "DBM-DragonSoul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(39378)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBoulder			= mod:NewTargetAnnounce(107597, 3)--This is morchok entryway trash that throws rocks at random poeple.

local specWarnBoulder		= mod:NewSpecialWarningMove(107597)
local specWarnBoulderNear	= mod:NewSpecialWarningClose(107597)
local yellBoulder			= mod:NewYell(107597)
local specWarnFlames		= mod:NewSpecialWarningMove(105579)

local timerDrakes			= mod:NewTimer(253, "TimerDrakes", 61248)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local antiSpam = 0

function mod:BoulderTarget(sGUID)
	local targetname, realm = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname, realm = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	if realm then targetname = targetname.."-"..realm end
	warnBoulder:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBoulder:Show()
		yellBoulder:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 6 then--Guessed, unknown, spelltip isn't informative.
				specWarnBoulderNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107597) then
		self:ScheduleMethod(0.2, "BoulderTarget", args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(105579) and args:IsPlayer() and GetTime() - antiSpam >= 3 then
		specWarnFlames:Show()
		antiSpam = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--	"<18.7> CHAT_MSG_MONSTER_YELL#It is good to see you again, Alexstrasza. I have been busy in my absence.#Deathwing###Notarget##0#0##0#3731##0#false", -- [1]
--	"<271.9> [UNIT_SPELLCAST_SUCCEEDED] Twilight Assaulter:Possible Target<nil>:target:Twilight Escape::0:109904", -- [11926]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.UltraxionTrash or msg:find(L.UltraxionTrash) then
		timerDrakes:Start(253, GetSpellInfo(109904))
	end
end
