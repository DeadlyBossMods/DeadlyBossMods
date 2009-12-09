local mod	= DBM:NewMod("Grobbulus", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15931)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnInjection		= mod:NewTargetAnnounce(28169, 2)
local warnCloud			= mod:NewSpellAnnounce(28240, 2)

local specWarnInjection	= mod:NewSpecialWarning("SpecialWarningInjection")

local timerInjection	= mod:NewTargetTimer(10, 28169)
local timerCloud		= mod:NewNextTimer(15, 28240)
local enrageTimer		= mod:NewEnrageTimer(720)

mod:AddBoolOption("SetIconOnInjectionTarget", true)

local mutateIcons = {}

function mod:OnCombatStart(delay)
	table.wipe(mutateIcons)
	enrageTimer:Start(-delay)
end

function mod:OnCombatEnd()
    for i,j in ipairs(mutateIcons) do
       self:SetIcon(j, 0)
    end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(28169) then
		warnInjection:Show(args.destName)
		timerInjection:Start(args.destName)
		if args:IsPlayer() then
			specWarnInjection:Show()
		end
		if mod.Options.SetIconOnInjectionTarget then
			table.insert(mutateIcons, args.destName)
			addIcon()
		end
	end	
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(28169) then
		timerInjection:Cancel(args.destName)--Cancel timer if someone is dumb and dispels it.
		if mod.Options.SetIconOnInjectionTarget then
			removeIcon(args.destName)
		end
	end
end

function mod:addIcon()
	for i,j in ipairs(mutateIcons) do
		local icon = 9 - i
		self:SetIcon(j, icon)
	end
end

function mod:removeIcon(target)
	for i,j in ipairs(mutateIcons) do
		if j == target then
			table.remove(mutateIcons, i)
			self:SetIcon(target, 0)
		end
	end
	addIcon()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28240) then
		warnCloud:Show()
		timerCloud:Start()
	end	
end