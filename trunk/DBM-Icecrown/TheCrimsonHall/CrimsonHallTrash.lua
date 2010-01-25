local mod	= DBM:NewMod("CrimsonHallTrash", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3185 $"):sub(12, -3))
mod:SetUsedIcons(7, 8)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBloodMirror		= mod:NewTargetAnnounce(70451)
local warnBloodSap			= mod:NewTargetAnnounce(70432)

local specWarnBloodMirror	= mod:NewSpecialWarningYou(70451)

local timerBloodMirror		= mod:NewTargetTimer(30, 70451)
local timerBloodSap			= mod:NewTargetTimer(8, 70432)

local BloodMirrorIcons = 8	-- alternating between 2 icons (2 debuffs can be up at the same time on one pull)

mod:AddBoolOption("BloodMirrorIcon", true)
mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70451) then
		warnBloodMirror:Show(args.destName)
		timerBloodMirror:Start(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, BloodMirrorIcons, 30)
			if BloodMirrorIcons == 8 then
				BloodMirrorIcons = 7
			else
				BloodMirrorIcons = 8
			end
		end
		if args:IsPlayer() then
			specWarnBloodMirror:Show()
		end
	elseif args:IsSpellID(70432) then
		warnBloodSap:Show(args.destName)
		timerBloodSap:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70451) then
		timerBloodMirror:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	end
end