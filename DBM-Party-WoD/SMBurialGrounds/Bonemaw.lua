local mod	= DBM:NewMod(1140, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75452)
mod:SetEncounterID(1679)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154175 165578",
	"SPELL_AURA_APPLIED 153804",
	"SPELL_AURA_REMOVED 153804",
	"SPELL_PERIODIC_DAMAGE 153692",
	"SPELL_ABSORBED 153692",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--Inhale and submerge timers iffy. Based on data, it's possible they share a CD and which one he uses is random of two.
--With that working theory, it's possible to add a 28-30 second timer for it maybe.
--However, being a 5 man boss. Plus not knowing for certain, not worth the time right now.
local warnBodySlam				= mod:NewTargetAnnounce(154175, 4)
local warnInhale				= mod:NewSpellAnnounce(153804, 4)
local warnCorpseBreath			= mod:NewSpellAnnounce(165578, 2)
local warnSubmerge				= mod:NewSpellAnnounce(177694, 1)

local specWarnBodySlam			= mod:NewSpecialWarningSpell(154175, nil, nil, nil, 2)
local specWarnInhale			= mod:NewSpecialWarningSpell(153804)
local specWarnInhaleEnd			= mod:NewSpecialWarningEnd(153804)
local specWarnNecroticPitch		= mod:NewSpecialWarningMove(153692)

local timerBodySlamCD			= mod:NewCDSourceTimer(30, 154175)
local timerInhaleCD				= mod:NewCDTimer(35, 153804)
local timerInhale				= mod:NewBuffActiveTimer(9, 153804)
local timerCorpseBreathCD		= mod:NewCDTimer(28, 165578, nil, false)--32-37 Variation, also not that important so off by default since there will already be up to 3 smash timers
local timerSubmergeCD			= mod:NewCDTimer(80, 177694)

local soundInhale				= mod:NewSound(153804)
local voiceBodySlam				= mod:NewVoice(154175)
local voiceInhale				= mod:NewVoice(153804)

mod.vb.inhaleActive = false

function mod:OnCombatStart(delay)
	self.vb.inhaleActive = false
	timerBodySlamCD:Start(15-delay, UnitName("boss1"), UnitGUID("boss1"))
	timerInhaleCD:Start(29-delay)
	timerSubmergeCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 154175 then
		warnBodySlam:Show(args.sourceName)
		if self:AntiSpam(3) then--Throttle special warning when more than 1 slam at once happens.
			specWarnBodySlam:Show()
			voiceBodySlam:Play("watchstep")
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

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 153804 then
		timerInhale:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 153804 then
		self.vb.inhaleActive = false
		specWarnInhaleEnd:Show()
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
		self.vb.inhaleActive = true
		warnInhale:Show()
		specWarnInhale:Show()
		soundInhale:Play()
		timerInhaleCD:Start()
		voiceInhale:Play("153804") 
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 177694 then
		warnSubmerge:Show()
		timerInhaleCD:Start()
		timerSubmergeCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 153692 and not self.vb.inhaleActive and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNecroticPitch:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
