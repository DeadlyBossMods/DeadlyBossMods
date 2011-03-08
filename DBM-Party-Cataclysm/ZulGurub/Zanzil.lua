local mod	= DBM:NewMod("Zanzil", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52053)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

--local warnCauldronRed		= mod:NewSpellAnnounce(96486, 3)
--local warnCauldronGreen	= mod:NewSpellAnnounce(96487, 3)
--local warnCauldronBlue	= mod:NewSpellAnnounce(96488, 3)
local warnZanzilElixir		= mod:NewSpellAnnounce(96316, 4)
local warnZanzilFire		= mod:NewSpellAnnounce(96914, 3)
local warnZanzilGas			= mod:NewSpellAnnounce(96338, 3)
local warnGaze				= mod:NewTargetAnnounce(96342, 3)

local specWarnGaze			= mod:NewSpecialWarningYou(96342)

local timerZanzilGas		= mod:NewBuffActiveTimer(7, 96338)
local timerGaze				= mod:NewTargetTimer(17, 96342)
--local timerZanzilElixir	= mod:NewCDTimer(30, 96316) -- this spell not have cooldown, seeming ramdomly.

local soundGaze			= mod:NewSound(96342)

mod:AddBoolOption("SetIconOnGaze")

function mod:GazeTarget()
	local targetname = self:GetBossTarget(52054)
	if not targetname then return end

	warnGaze:Show(targetname)
	timerGaze:Start(targetname)
	if self.Options.SetIconOnIcon then
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
		-- no target exists.
	elseif args:IsSpellID(96338) then
		warnZanzilGas:Show()
	elseif args:IsSpellID(96342) and self:IsInCombat() then
		self:ScheduleMethod(0.15, "GazeTarget")
	end
end

--[[function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96486) then
		warnCauldronRed:Show()
	elseif args:IsSpellID(96487) then
		warnCauldronGreen:Show()
	elseif args:IsSpellID(96488) then
		warnCauldronBlue:Show()
	end
end]] -- removed. Zanzil do not use these spells while combat, only use this spell not pulled. It's just spam