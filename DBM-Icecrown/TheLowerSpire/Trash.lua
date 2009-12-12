local mod	= DBM:NewMod("LowerSpireTrash", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local warnDarkReckoning			= mod:NewTargetAnnounce(69483, 3)

local specWarnDisruptingShout		= mod:NewSpecialWarning("SpecWarnDisruptingShout")
local specWarnDarkReckoning		= mod:NewSpecialWarning("SpecWarnDarkReckoning")

local timerDisruptingShout		= mod:NewCastTimer(3, 71022)
local timerDarkReckoning		= mod:NewTargetTimer(15, 69483)

mod:AddBoolOption("PlaySoundOnDarkReckoning", true)


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69483) then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
			if self.Options.PlaySoundOnDarkReckoning then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71022) then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	end
end



