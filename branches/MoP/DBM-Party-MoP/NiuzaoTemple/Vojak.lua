local mod	= DBM:NewMod(738, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61634)
mod:SetModelID(42169)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)
mod:SetWipeTime(30)--Unknown value to use at this time. Probalby need tweaking.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE"
)

--Phase 2 was currently bugged and he didn't use any of his phase 2 abilities (Dashing Strike & Thousand Blades, will need to be added later)
local warnCausticTar	= mod:NewSpellAnnounce("ej6278", 2)--Announce a tar is ready to be used. (may be spammy and turned off by default if it is)
--local warnWave			= mod:NewSpellAnnounce("warnWave", 2)--Not used at moment, seems redundant to do so.
local warnBombard		= mod:NewSpellAnnounce(120200, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local timerWaveCD		= mod:NewTimer(12, "timerWave")--Not wave timers in traditional sense. They are non stop, this is for when he activates certain mob types.
local timerBombard		= mod:NewBuffActiveTimer(15, 120200)
local timerBombardCD	= mod:NewCDTimer(45, 120200)

local Swarmers 		= EJ_GetSectionInfo(6280)
local Amberwing 	= EJ_GetSectionInfo(6281)
local Demolishers 	= EJ_GetSectionInfo(6282)
local Warriors	 	= EJ_GetSectionInfo(6283)
local phase2Started = false
local waveCount = 0

function mod:OnCombatStart(delay)
	phase2Started = false
	waveCount = 0
	--start them all here to avoid locals, if it is too much, will rework into triggering one at a time in RAID_BOSS_EMOTE
	timerWaveCD:Start(5-delay, Swarmers)
	timerWaveCD:Start(35-delay, Amberwing)
	timerWaveCD:Start(70-delay, Demolishers)
	timerWaveCD:Start(104-delay, Warriors)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(120758) and not phase2Started then
		phase2Started = true
		warnPhase2:Show()
		timerBombardCD:Start(11)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(120402) and not args:IsDestTypePlayer() then--an NPC stopped carrying tar (ie it's ready to be used by player)
		warnCausticTar:Show()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Bombard or msg:find(L.Bombard) then
		warnBombard:Show()
		timerBombard:Start()
		timerBombardCD:Start()
	elseif msg == L.Wave or msg:find(L.Wave) then
		waveCount = waveCount + 1
--		warnWave:Show()
		if waveCount == 1 then
			timerBombardCD:Start(46)
		elseif waveCount == 3 then
			timerBombardCD:Start(11)
		end
	end
end
