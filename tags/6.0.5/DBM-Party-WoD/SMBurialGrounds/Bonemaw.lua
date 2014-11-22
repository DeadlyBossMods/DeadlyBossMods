local mod	= DBM:NewMod(1140, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75452)
mod:SetEncounterID(1679)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154175 165578",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--Inhale and submerge timers iffy. Based on data, it's possible they share a CD and which one he uses is random of two.
--With that working theory, it's possible to add a 28-30 second timer for it maybe.
--However, being a 5 man boss. Plus not knowing for certain, not worth the time right now.
local warnBodySlam				= mod:NewTargetAnnounce(154175, 4)
local warnInhale				= mod:NewSpellAnnounce(154868, 4)
local warnCorpseBreath			= mod:NewSpellAnnounce(165578, 2)

local specWarnBodySlam			= mod:NewSpecialWarningSpell(154175, nil, nil, nil, 2)
local specWarnInhale			= mod:NewSpecialWarningRun(153804)

local timerBodySlamCD			= mod:NewCDSourceTimer(30, 154175)--32-35 Variation
local timerCorpseBreathCD		= mod:NewCDTimer(28, 165578, nil, false)--32-37 Variation, also not that important so off by default since there will already be up to 3 smash timers

local soundInhale				= mod:NewSound(153804)

function mod:OnCombatStart(delay)
	timerBodySlamCD:Start(15-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 154175 then
		warnBodySlam:Show(args.sourceName)
		if self:AntiSpam(3) then--Throttle special warning when more than 1 slam at once happens.
			specWarnBodySlam:Show()
		end
		if args:GetSrcCreatureID() == 75452 then--Source is Bonemaw, not one of his adds
			timerBodySlamCD:Start(30, args.sourceName, args.sourceGUID)
		else
			timerBodySlamCD:Start(14, args.sourceName, args.sourceGUID)--little guys use it more often.
		end
	elseif spellId == 165578 then
		warnCorpseBreath:Show()
		timerCorpseBreathCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76057 then--Carrion Centipede
		timerBodySlamCD:Cancel(args.destName, args.destGUID)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:153804") then--Slightly faster than combat log
		warnInhale:Show()
		specWarnInhale:Show()
		soundInhale:Play()
	end
end
