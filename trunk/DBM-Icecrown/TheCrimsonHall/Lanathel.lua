local mod	= DBM:NewMod("Lanathel", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37955)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_PERIODIC_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPactDarkfallen			= mod:NewTargetAnnounce(71340, 3)
local warnBloodMirror				= mod:NewTargetAnnounce(71510, 3)
local warnSwarmingShadows			= mod:NewTargetAnnounce(71266)
local warnVampricBite				= mod:NewTargetAnnounce(71727)
local warnMindControlled			= mod:NewTargetAnnounce(70923)
local warnBloodthirst				= mod:NewTargetAnnounce(71474, 2, nil, false)
local warnEssenceoftheBloodQueen	= mod:NewTargetAnnounce(71473, 2, nil, false)

local specWarnAirphase				= mod:NewSpecialWarning("AirPhaseWarning")
local specWarnPactDarkfallen		= mod:NewSpecialWarningYou(71340)
local specWarnEssenceoftheBloodQueen= mod:NewSpecialWarningYou(71473)
local specWarnBloodthirst			= mod:NewSpecialWarningYou(71474)
local specWarnSwarmingShadows		= mod:NewSpecialWarningMove(71266)
local specWarnMindConrolled			= mod:NewSpecialWarningTarget(70923, false)

local timerAirPhase					= mod:NewTimer(10, "AirPhase", 71772)--Timer is more of a guess than anything may be adjusted
local timerNextAirPhase				= mod:NewTimer(100, "NextAirphase", 71772)--Seen conflicting timers on this and conflicting logs as well so may be off.
local timerFirstBite				= mod:NewCastTimer(15, 71727)
local timerNextPactDarkfallen		= mod:NewNextTimer(30, 71340)
local timerNextSwarmingShadows		= mod:NewNextTimer(30, 71266)
local timerBloodThirst				= mod:NewBuffActiveTimer(10, 71474)
local timerEssenceoftheBloodQueen	= mod:NewBuffActiveTimer(60, 71473)

local berserkTimer					= mod:NewBerserkTimer(320)

local soundSwarmingShadows			= mod:NewSound(71266)

mod:AddBoolOption("BloodMirrorIcon", false)
mod:AddBoolOption("SwarmingShadowsIcon", true)
mod:AddBoolOption("SetIconOnDarkFallen", true)

local pactTargets = {}
local pactIcons = 6

local function warnPactTargets()
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerNextPactDarkfallen:Start(30)
	pactIcons = 6
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerFirstBite:Start(-delay)
	timerNextPactDarkfallen:Start(15-delay)
	timerNextSwarmingShadows:Start(-delay)
	timerNextAirPhase:Start(142-delay)
	table.wipe(pactTargets)
	pactIcons = 6
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71340) then		--Pact of the Darkfallen
		pactTargets[#pactTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnPactDarkfallen:Show()
		end
		if self.Options.SetIconOnDarkFallen then--Debuff doesn't actually last 30 seconds
			self:SetIcon(args.destName, pactIcons, 30)--it lasts forever, but if you still have it after 30 seconds
			pactIcons = pactIcons - 1--then it's probably a wipe anyways
		end
		self:Unschedule(warnPactTargets)
		if #pactTargets >= 3 then
			warnPactTargets()
		else
			self:Schedule(0.3, warnPactTargets)
		end
	elseif args:IsSpellID(71510, 70838) then
		warnBloodMirror:Show(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(70877, 71474) then
		warnBloodthirst:Show(args.destName)
		if args:IsPlayer() then
			specWarnBloodthirst:Show()
			if mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10") then
				timerBloodThirst:Start(15)--15 seconds on 10 man
			else
				timerBloodThirst:Start()--10 seconds on 25 man
			end
		end
	elseif args:IsSpellID(70867, 71473) then	--Essence of the Blood Queen
		warnEssenceoftheBloodQueen:Show(args.destName)
		if args:IsPlayer() then
			specWarnEssenceoftheBloodQueen:Show()
			if mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10") then
				timerEssenceoftheBloodQueen:Start(75)--70 seconds on 10 man
			else
				timerEssenceoftheBloodQueen:Start()--60 seconds on 25 man
			end
		end
	elseif args:IsSpellID(70923) then
		warnMindControlled:Show(args.destName)
		specWarnMindConrolled:Show(args.destName)
	elseif args:IsSpellID(71772) then
		specWarnAirphase:Show()
		timerAirPhase:Start()
		timerNextAirPhase:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(71340) then				--Pact of the Darkfallen
		self:SetIcon(args.destName, 0)			--Clear icon once you got to where you are supposed to be
	elseif args:IsSpellID(71510, 70838) then	--Blood Mirror
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(71726, 71727, 71728, 71729) and args:GetSrcCreatureID() == 37955 then	-- Vampric Bite (first bite only, hers)
		warnVampricBite:Show(args.destName)
	end
end

do
	local lastswarm = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsPlayer() and args:IsSpellID(71277, 72638, 72639, 72640) then		--Swarn of Shadows (spell damage, you're standing in it.)
			if GetTime() - 3 > lastswarm then
				specWarnSwarmingShadows:Show()
				lastswarm = GetTime()
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.SwarmingShadows) then
		self:SendSync("SwarmingShadows", target)
	end
end

function mod:OnSync(msg, target)
	if msg == "SwarmingShadows" then
		warnSwarmingShadows:Show(target)
		timerNextSwarmingShadows:Start()
		if target == UnitName("player") then
			specWarnSwarmingShadows:Show()
			soundSwarmingShadows:Play()
		end
		if self.Options.SwarmingShadowsIcon then
			self:SetIcon(target, 8, 6)
		end
	end
end