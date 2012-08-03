local mod	= DBM:NewMod(134, "DBM-Party-Cataclysm", 3, 71)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40484)
mod:SetModelID(33428)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnBinding		= mod:NewTargetAnnounce(75861, 3)
local warnFeeble		= mod:NewTargetAnnounce(75792, 3)
local warnGale			= mod:NewSpellAnnounce(75664, 4)
local warnUmbralMending	= mod:NewSpellAnnounce(91026, 4)

local timerBinding		= mod:NewBuffFadesTimer(6, 75861)
local timerFeeble		= mod:NewTargetTimer(3, 75792)
local timerGale			= mod:NewCastTimer(5, 75664)
local timerGaleCD		= mod:NewCDTimer(55, 75664)

local bindingTargets = {}
local bindingCount = 0

local function showBindingWarning()
	warnBinding:Show(table.concat(bindingTargets, "<, >"))
	table.wipe(bindingTargets)
	timerBinding:Start()
end

function mod:OnCombatStart(delay)
	table.wipe(bindingTargets)
	bindingCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75861, 91079) then
		bindingCount = bindingCount + 1
		bindingTargets[#bindingTargets + 1] = args.destName
		self:Unschedule(showBindingWarning)
		self:Schedule(0.3, showBindingWarning)
	elseif args:IsSpellID(75792, 91092) then
		warnFeeble:Show(args.destName)
		if mod:IsDifficulty("heroic5") then
			timerFeeble:Start(5, args.destName)
		else
			timerFeeble:Start(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(75861, 91079) then
		bindingCount = bindingCount - 1
		if bindingCount == 0 then
			timerBinding:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75664, 91086) then
		warnGale:Show()
		timerGale:Start()
		timerGaleCD:Start()
	elseif args:IsSpellID(91026) then
		warnUmbralMending:Show()
	end
end