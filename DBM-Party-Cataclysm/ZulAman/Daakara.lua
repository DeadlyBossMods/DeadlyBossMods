local mod	= DBM:NewMod("Daakara", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23863)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnThrow				= mod:NewTargetAnnounce(97639, 3)
local warnWhirlwind			= mod:NewSpellAnnounce(17207, 3)
local warnBear				= mod:NewSpellAnnounce(42594, 3)
local warnEagle				= mod:NewSpellAnnounce(42606, 3)
local warnLynx				= mod:NewSpellAnnounce(42607, 3)
local warnDragonhawk		= mod:NewSpellAnnounce(42608, 3)
local warnParalysis			= mod:NewSpellAnnounce(43095, 4)--Bear Form
local warnSurge				= mod:NewTargetAnnounce(42402, 3)--Bear Form
local warnClawRage			= mod:NewTargetAnnounce(97672, 3)--Lynx Form
local warnLightningTotem	= mod:NewSpellAnnounce(97930, 4)--Eagle Form

local timerNextForm			= mod:NewTimer(45, "timerNextForm")--His forms are random (only 2 of 4 will be used).
--local timerThrow			= mod:NewNextTimer(15, 97639)--I haven't seen him cast this more than once per fight.
local timerParalysisCD		= mod:NewNextTimer(30, 43095)--Bear Form Ability, same mechanic as bear boss, cannot soak more than 1 before debuff fades or you will die.
local timerSurgeCD			= mod:NewNextTimer(8, 42402)--Bear Form Ability, same mechanic as bear boss, cannot soak more than 1 before debuff fades or you will die.
local timerLightningTotemCD	= mod:NewNextTimer(16.9, 42402)--Eagle Form Ability.

local Form = 0

mod:AddBoolOption("ThrowIcon", true)
mod:AddBoolOption("ClawRageIcon", true)

function mod:OnCombatStart(delay)
	timerNextForm:Start(28-delay)--Need a better log to make this more precise.
	Form = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97639) then
		warnThrow:Show(args.destName)
--		timerThrow:Start()
		if self.Options.ThrowIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(17207) then
		warnWhirlwind:Show()
	elseif args:IsSpellID(97672) then
		warnClawRage:Show(args.destName)
		if self.Options.ClawRageIcon then
			self:SetIcon(args.destName, 8, 5)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(97639) and mod.Options.ThrowIcon then
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(42594) then--Bear
		timerSurgeCD:Cancel()
		timerParalysisCD:Cancel()
	elseif args:IsSpellID(42606) then--Eagle
		timerLightningTotemCD:Cancel()
	elseif args:IsSpellID(42607) then--Lynx

	elseif args:IsSpellID(42608) then--Dragonhawk

	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42594) then
		Form = Form + 1
		warnBear:Show()
		timerParalysisCD:Start(2.5)
		timerSurgeCD:Start()
		if Form < 2 then
			timerNextForm:Start()
		end
	elseif args:IsSpellID(42606) then
		Form = Form + 1
		warnEagle:Show()
		timerLightningTotemCD:Start(10)
		if Form < 2 then
			timerNextForm:Start()
		end
	elseif args:IsSpellID(42607) then
		Form = Form + 1
		warnLynx:Show()
		if Form < 2 then
			timerNextForm:Start()
		end
	elseif args:IsSpellID(42608) then
		Form = Form + 1
		warnDragonhawk:Show()
		if Form < 2 then
			timerNextForm:Start()
		end
	elseif args:IsSpellID(97930) then
		warnLightningTotem:Show()
		timerLightningTotemCD()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(43095) then
		warnParalysis:Show()
		timerParalysisCD:Start()
	end
end