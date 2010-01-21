local mod	= DBM:NewMod("Lanathel", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37955)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPactDarkfallen		= mod:NewTargetAnnounce(71340, 3)
local warnBloodMirror			= mod:NewTargetAnnounce(71510, 3)
local warnBloodthirst			= mod:NewTargetAnnounce(71474)
local warnSwarmingShadows		= mod:NewTargetAnnounce(71266)
local warnVampricBite			= mod:NewTargetAnnounce(71727)

local specWarnPactDarkfallen	= mod:NewSpecialWarningYou(71340)
local specWarnBloodthirst		= mod:NewSpecialWarningYou(71474)
local specWarnSwarmingShadows	= mod:NewSpecialWarningYou(71266)
local specWarnBloodMirror		= mod:NewSpecialWarningTarget(71510, false)

local timerNextPactDarkfallen	= mod:NewNextTimer(30, 71340)
local timerNextSwarmingShadows	= mod:NewNextTimer(30, 71266)
local timerBloodMirror			= mod:NewTargetTimer(30, 71510)
local timerBloodThirst			= mod:NewBuffActiveTimer(10, 71474)

local berserkTimer				= mod:NewBerserkTimer(320)

mod:AddBoolOption("SwarmingShadowsIcon", true)
mod:AddBoolOption("SetIconOnDarkFallen", true)

local pactTargets = {}
local pactIcons = 7

local function warnPactTargets()
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerNextPactDarkfallen:Start(30)
	pactIcons = 7
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerNextPactDarkfallen:Start(15-delay)
	timerNextSwarmingShadows:Start(-delay)
	table.wipe(pactTargets)
	pactIcons = 7
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
	elseif args:IsSpellID(71510, 70838, 70451) then--Spellids drycoded from wowhead will verify on release
		warnBloodMirror:Show(args.destName)
		timerBloodMirror:Start(args.destName)
		specWarnBloodMirror:Show(args.destName)
	elseif args:IsSpellID(70877, 71474) then--Spellids drycoded from wowhead will verify on release
		warnBloodthirst:Show(args.destName)
		if args:IsPlayer() then
			specWarnBloodthirst:Show()
			if mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10") then
				timerBloodThirst:Start(15)--15 seconds on 10 man
			else
				timerBloodThirst:Start()--10 seconds on 25 man
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(71340) then		-- Pact of the Darkfallen
		self:SetIcon(args.destName, 0)--Clear icon once you got to where you are supposed to be
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(71726, 71727, 71728, 71729) and args:GetSrcCreatureID() == 37955 then	-- Vampric Bite (first bite only, hers)
		warnVampricBite:Show(args.destName)
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
		end
		if self.Options.SwarmingShadowsIcon then
			self:SetIcon(target, 8, 6)
		end
	end
end