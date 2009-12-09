local mod	= DBM:NewMod("Rotface", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36627)
mod:SetUsedIcons(6, 7)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local InfectionIcon	-- alternating between 2 icons (2 debuffs can be up at the same time in 25man at least)

local warnSlimeSpray			= mod:NewSpellAnnounce(69508)
local warnMutatedInfection		= mod:NewTargetAnnounce(71224)
local warnRadiatingOoze			= mod:NewSpellAnnounce(69760, false)--Some strats purposely run to this so option is defaulted to off
local warnOozeSpawn				= mod:NewAnnounce("WarnOozeSpawn")
local nextStickyOoze			= mod:NewNextTimer(16, 69774)
local warnStickyOoze			= mod:NewSpellAnnounce(69774)

local specWarnMutatedInfection	= mod:NewSpecialWarning("SpecWarnMutatedInfection")
local specWarnStickyOoze		= mod:NewSpecialWarning("SpecWarnStickyOoze")
local specWarnRadiatingOoze		= mod:NewSpecialWarning("SpecWarnRadiatingOoze", false)--Some strats purposely run to this so option is defaulted to off

local nextWallSlime				= mod:NewTimer(20, "NextPoisonSlimePipes")
local nextSlimeSpray			= mod:NewNextTimer(21, 69508)
local timerMutatedInfection		= mod:NewTargetTimer(12, 71224)

local soundStickyOoze			= mod:NewSound(71208)
mod:AddBoolOption("InfectionIcon")

function mod:OnCombatStart(delay)
	nextWallSlime:Start(25-delay)
	self:ScheduleMethod(25-delay, "WallSlime")
	InfectionIcon = 7
end

function mod:WallSlime()
	if self:IsInCombat() then
		nextWallSlime:Start()
		self:UnscheduleMethod("WallSlime")
		self:ScheduleMethod(20, "WallSlime")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69508) then
		nextSlimeSpray:Start()
		warnSlimeSpray:Show()
	elseif args:IsSpellID(69774) then
		nextStickyOoze:Start()
		warnStickyOoze:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args:IsSpellID(71208) then
		specWarnStickyOoze:Show()
		soundStickyOoze:Play()
	elseif args:IsSpellID(69760) then
		warnRadiatingOoze:Show()
	elseif args:IsSpellID(69674, 71224) then
		warnMutatedInfection:Show(args.destName)
		timerMutatedInfection:Start(args.destName)
		if args:IsPlayer() then
			specWarnMutatedInfection:Show()
		end
		if self.Options.InfectionIcon then
			mod:SetIcon(args.destName, InfectionIcon, 12)
			if InfectionIcon == 7 then	-- After ~3mins there is a chance 2 ppl will have the debuff, so we are alternating between 2 icons
				InfectionIcon = 6
			else
				InfectionIcon = 7
			end
		end	
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69674, 71224) then
		timerMutatedInfection:Cancel(args.destName)
		warnOozeSpawn:Show()
		if self.Options.InfectionIcon then
			mod:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(69761, 71212) and args:IsPlayer() then
		specWarnRadiatingOoze:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSlimePipes or msg:find(L.YellSlimePipes) then
		self:SendSync("PoisonSlimePipes")
	end
end

function mod:OnSync(msg, arg)
	if msg == "PoisonSlimePipes" then
		self:WallSlime()
	end
end