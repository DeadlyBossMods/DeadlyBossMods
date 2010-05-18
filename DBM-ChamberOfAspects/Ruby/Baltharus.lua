local mod	= DBM:NewMod("Baltharus", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39751)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_HEALTH"
)

local warningSplitSoon	= mod:NewAnnounce("WarningSplitSoon", 2)
local warningSplitNow	= mod:NewAnnounce("WarningSplitNow", 3)
--local preWarnWhirlwind   	= mod:NewSoonAnnounce(75127, 3)--Unknown

local specWarnWhirlwind		= mod:NewSpecialWarningRun(75127)

--local timerWhirlwindCD		= mod:NewCDTimer(90, 75127)--Unknown
--local timerWhirlwind			= mod:NewBuffActiveTimer(20, 75127)--Unknown

local soundWhirlwind = mod:NewSound(75127)

local warnedSplit		= false

function mod:OnCombatStart(delay)
--	preWarnWhirlwind:Schedule(-delay)
--	timerWhirlwindCD:Start(-delay)
	warnedSplit = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(75127, 75125) then
		specWarnWhirlwind:Show()
--		timerWhirlwindCD:Start()
--		preWarnWhirlwind:Schedule(85)
--		timerWhirlwind:Show()
		soundWhirlwind:Play()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedSplit and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warnedSplit = true
		warningSplitSoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SplitTrigger then
		warningSplitNow:Show()
	end
end