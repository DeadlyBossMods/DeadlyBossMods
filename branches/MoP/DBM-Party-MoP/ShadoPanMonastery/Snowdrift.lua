local mod	= DBM:NewMod(657, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56541)
mod:SetModelID(39887)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)
mod:RegisterKill("yell", L.Defeat)
mod:SetWipeTime(50)--Yes, the phase transition is THIS LONG, will improve it with transcriptor later to get real combat regen times.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

--Notes: Currently, his phase 2 chi blast abiliteis are not detectable via traditional combat log. maybe with transcriptor.
local warnFistsOfFury		= mod:NewSpellAnnounce(106853, 3)
local warnTornadoKick		= mod:NewSpellAnnounce(106434, 3)
local warnChaseDown			= mod:NewTargetAnnounce(118961, 3)--Targeting spell for Tornado Slam (106352)

local specwarnChaseDown		= mod:NewSpecialWarningYou(118961)

local timerTransition		= mod:NewTimer(53.5, "TimerTransition", 2457)
local timerFistsOfFuryCD	= mod:NewCDTimer(23, 106853)--Not enough data to really verify this
local timerTornadoKickCD	= mod:NewCDTimer(32, 106434)--Or this
--local timerChaseDownCD		= mod:NewCDTimer(22, 118961)--Unknown
local timerChaseDown		= mod:NewTargetTimer(22, 118961)

function mod:OnCombatStart(delay)
	timerTransition:Start(12-delay)--May need minor tweaking
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(118961) then
		warnChaseDown:Show(args.destName)
		timerChaseDown:Start(args.destName)
--		timerChaseDownCD:Start()
		if args:IsPlayer() then
			specwarnChaseDown:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118961) then
		timerChaseDown:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106853) then
		warnFistsOfFury:Show()
		timerFistsOfFuryCD:Start()
	elseif args:IsSpellID(106434) then
		warnTornadoKick:Show()
		timerTornadoKickCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Adds1Ended or msg:find(L.Adds1Ended) then
		timerTransition:Start(25)--Might need minor tweaking
	elseif msg == L.Adds2Ended or msg:find(L.Adds2Ended) then
		timerTransition:Start(43)--Might need minor tweaking
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Phase1Ended or msg:find(L.Phase1Ended) then
		timerFistsOfFuryCD:Cancel()
		timerTornadoKickCD:Cancel()
	end
end
