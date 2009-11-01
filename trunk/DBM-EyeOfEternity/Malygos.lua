local mod = DBM:NewMod("Malygos", "DBM-EyeOfEternity")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28859)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED"
)

local warnSpark			= mod:NewAnnounce("WarningSpark", 1, 59381)
local warnVortex		= mod:NewAnnounce("WarningVortex", 3, 56105)
local warnBreathInc		= mod:NewAnnounce("WarningBreathSoon", 3, 60071)
local warnBreath		= mod:NewAnnounce("WarningBreath", 4, 60071)
local warnSurge			= mod:NewAnnounce("WarningSurge", 2, 60936)
local warnVortexSoon	= mod:NewAnnounce("WarningVortexSoon", 4, 56105)

local timerSpark	= mod:NewTimer(30, "TimerSpark", 59381)
local timerVortex	= mod:NewTimer(11, "TimerVortex", 56105)
local timerBreath	= mod:NewTimer(59, "TimerBreath", 60071)
local timerVortexCD	= mod:NewTimer(60, "TimerVortexCD", 56105)

local specWarnSurge = mod:NewSpecialWarning("WarningSurgeYou")

local enrageTimer	= mod:NewEnrageTimer(615)

local guids = {}
local surgeTargets = {}

local function buildGuidTable()
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	table.wipe(guids)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpark or msg:find(L.EmoteSpark) then
		self:SendSync("Spark")
	elseif msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
		self:SendSync("Breath")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(56105) then
		timerVortexCD:Start()
		warnVortexSoon:Schedule(54)
		warnVortex:Show()
		timerVortex:Start()
		if timerSpark:GetTime() < 11 and timerSpark:IsStarted() then
			timerSpark:Update(18, 30)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:sub(0, L.YellPhase2:len()) == L.YellPhase2 then
		self:SendSync("Phase2")
	elseif msg == L.YellBreath then
		self:SendSync("BreathSoon")
	elseif msg:sub(0, L.YellPhase3:len()) == L.YellPhase3 then
		self:SendSync("Phase3")
	end
end

local function announceTargets(self)
	warnSurge:Show(table.concat(surgeTargets, "<, >"))
	table.wipe(surgeTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(60936, 57407) then
		local target = guids[args.destGUID or 0]
		if target then
			surgeTargets[#surgeTargets + 1] = target
			self:Unschedule(announceTargets)
			if #surgeTargets >= 3 then
				announceTargets()
			else
				self:Schedule(0.5, announceTargets, self)
			end
			if target == UnitName("player") then
				specWarnSurge:Show()
			end
		end
	end
end

function mod:OnSync(event, arg)
	if event == "Spark" then
		warnSpark:Show()
		timerSpark:Start()
	elseif event == "Phase2" then
		timerSpark:Stop()
		timerVortexCD:Stop()
		timerBreath:Start(92)
	elseif event == "Breath" then
		timerBreath:Schedule(1)
		warnBreath:Schedule(1)
	elseif event == "BreathSoon" then
		warnBreathInc:Show()
	elseif event == "Phase3" then
		self:Schedule(6, buildGuidTable)
		timerBreath:Stop()
	end
end
