local mod	= DBM:NewMod("LowerSpireTrash", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)


mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local warnDarkReckoning			= mod:NewTargetAnnounce(69483, 3)
local warnDeathPlague			= mod:NewTargetAnnounce(72865, 3)

local specWarnDisruptingShout	= mod:NewSpecialWarningCast(71022)
local specWarnDarkReckoning		= mod:NewSpecialWarningMove(69483)
local specWarnDeathPlague		= mod:NewSpecialWarningYou(72865)
local specWarnTrap				= mod:NewSpecialWarning("specWarnTrap")

local timerDisruptingShout		= mod:NewCastTimer(3, 71022)
local timerDarkReckoning		= mod:NewTargetTimer(8, 69483)
local timerDeathPlague			= mod:NewTargetTimer(15, 72865)

local soundDarkReckoning = mod:NewSound(69483)
mod:AddBoolOption("SetIconOnDarkReckoning", true)
mod:AddBoolOption("SetIconOnDeathPlague", true)
mod:RemoveOption("HealthFrame")

local DeathPlagueTargets = {}
local DeathPlagueIcons = 8

local function warnPlagueTargetsTargets()
	warnDeathPlague:Show(table.concat(DeathPlagueTargets, "<, >"))
	table.wipe(DeathPlagueTargets)
	DeathPlagueIcons = 8
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69483) then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
			soundDarkReckoning:Play()
		end
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(72865) then
		DeathPlagueTargets[#DeathPlagueTargets + 1] = args.destName
		timerDeathPlague:Start(args.destName)
		if args:IsPlayer() then
			specWarnDeathPlague:Show()
		end
		if self.Options.SetIconOnDeathPlague then
			self:SetIcon(args.destName, DeathPlagueIcons, 15)
			DeathPlagueIcons = DeathPlagueIcons - 1
		end
		self:Unschedule(warnPlagueTargetsTargets)
		self:Schedule(0.3, warnPlagueTargetsTargets)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71022) then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.WarderTrap1 or msg == L.WarderTrap2 or msg == L.WarderTrap3 then
		self:SendSync("WarderTrap")
	end
end

function mod:OnSync(msg, arg)
	if msg == "WarderTrap" then
		specWarnTrap:Show()
	end
end