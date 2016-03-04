local mod	= DBM:NewMod(1725, "DBM-Suramar", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(102672, 103160)--104731 (Depleted Time Particle). 104676 (Waning Time Particle). 104491 (Accelerated Time particle). 104492 (Slow Time Particle)
mod:SetEncounterID(1865)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown Count
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 211927",
	"SPELL_CAST_SUCCESS 206618 206610",
	"SPELL_AURA_APPLIED 206617 206609 207052 207051 206607",
	"SPELL_AURA_APPLIED_DOSE 206607",
	"SPELL_AURA_REMOVED 206617 206609 207052 207051",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, figure out how often tanks need to swap, adjust warnings accordingly
--TODO, Figure out what spawns adds and get add spawn warnings/timers.
--TODO, warn tank to go deal with rift and get charge he needs to interrupt Power overwhelming when timings and what nots are known
local warnPowerOverwhelming			= mod:NewCastAnnounce(211927, 4)
local warnTimeBomb					= mod:NewTargetAnnounce(206617, 3)
local warnTimeRelease				= mod:NewTargetAnnounce(206610, 3, nil, "Healer")
local warnChronometricPart			= mod:NewStackAnnounce(206607, 3, nil, "Tank")

local specWarnPowerOverwhelming		= mod:NewSpecialWarningInterrupt(211927, "Tank", nil, nil, 3)
local specWarnTimeBomb				= mod:NewSpecialWarningMoveAway(206617)--When close to expiring, not right away
local yellTimeBomb					= mod:NewFadesYell(206617)

local timerPowerOverwhelmingCD		= mod:NewAITimer(30, 211927, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--tank Only?
local timerTimeBomb					= mod:NewBuffFadesTimer(30, 206617, nil, nil, nil, 5)
local timerTimeBombCD				= mod:NewAITimer(30, 206617, nil, nil, nil, 3)
local timerTimeReleaseCD			= mod:NewAITimer(30, 206610, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerChronoPartCD				= mod:NewAITimer(30, 206607, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local countdownTimeBomb				= mod:NewCountdownFades("AltTwo30", 206617)

local voiceTimeBomb					= mod:NewVoice(206617)

mod:AddRangeFrameOption(10, 206617)
mod:AddSetIconOption("SetIconOnTimeRelease", 206610, true)
--mod:AddHudMapOption("HudMapOnMC", 163472)

function mod:OnCombatStart(delay)
	timerTimeBombCD:Start(1-delay)
	timerTimeReleaseCD:Start(1-delay)
	timerPowerOverwhelmingCD:Start(1-delay)
	timerChronoPartCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 211927 then
		timerPowerOverwhelmingCD:Start()
		if self.Options.SpecWarn211927interrupt then
			specWarnPowerOverwhelming:Show(args.sourceName)
		else
			warnPowerOverwhelming:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206618 then
		timerTimeBombCD:Start()
	elseif spellId == 206610 then
		timerTimeReleaseCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		warnTimeBomb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local debuffTime = expires - GetTime()
				specWarnTimeBomb:Schedule(debuffTime - 5)	-- Show "move away" warning 5secs before explode
				timerTimeBomb:Start(debuffTime)
				countdownTimeBomb:Start(debuffTime)
				yellTimeBomb:Schedule(debuffTime-1, 1)
				yellTimeBomb:Schedule(debuffTime-2, 2)
				yellTimeBomb:Schedule(debuffTime-3, 3)
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(10)
				end
			end
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then
		warnTimeRelease:CombinedShow(0.5, args.destName)
		if self.Options.SetIconOnTimeRelease then
			self:SetSortedIcon(0.5, args.destName, 1)--Add expected max count when known?
		end
	elseif spellId == 206607 then
		local amount = args.amount or 1
		warnChronometricPart:Show(args.destName, amount)
		timerChronoPartCD:Start()--Move timer to success if this can be avoided
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		if args:IsPlayer() then
			specWarnTimeBomb:Cancel()
			timerTimeBomb:Cancel()
			countdownTimeBomb:Cancel()
			yellTimeBomb:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then
		if self.Options.SetIconOnTimeRelease then
			self:SetIcon(args.destName, 0)
		end
	end
end
--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
