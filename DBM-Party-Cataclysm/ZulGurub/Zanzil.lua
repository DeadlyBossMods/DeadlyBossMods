local mod	= DBM:NewMod("Zanzil", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52053)
mod:SetModelID(37813)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnZanzilElixir		= mod:NewSpellAnnounce(96316, 4)
local warnZanzilFire		= mod:NewSpellAnnounce(96914, 3)
local warnZanzilGas			= mod:NewSpellAnnounce(96338, 3)
local warnGaze				= mod:NewTargetAnnounce(96342, 3)

local specWarnGaze			= mod:NewSpecialWarningYou(96342)

local timerZanzilGas		= mod:NewBuffActiveTimer(7, 96338)
local timerGaze				= mod:NewTargetTimer(17, 96342)
local timerZanzilElixir		= mod:NewCDTimer(30, 96316)

local soundGaze			= mod:NewSound(96342)

mod:AddBoolOption("SetIconOnGaze")

function mod:GazeTarget()
	local targetname = self:GetBossTarget(52054)
	if not targetname then return end
	warnGaze:Show(targetname)
	timerGaze:Start(targetname)
	if self.Options.SetIconOnGaze then
		self:SetIcon(targetname, 8, 17)
	end
	if targetname == UnitName("player") then
		specWarnGaze:Show()
		soundGaze:Play()
	end
end

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96388) then
		timerZanzilGas:Start()
	elseif args:IsSpellID(96316) then
		warnZanzilElixir:Show()
		timerZanzilElixir:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96914) then
		warnZanzilFire:Show()
	elseif args:IsSpellID(96338) then
		warnZanzilGas:Show()
	elseif args:IsSpellID(96342) and self:IsInCombat() then
		self:ScheduleMethod(0.2, "GazeTarget")
	end
end

--[[
SPELL_AURA_APPLIED:  96316 - "Zanzil's Resurrection Elixir"
19:25:47.165
19:26:17.697
19:26:48.624
--]]