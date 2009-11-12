local mod = DBM:NewMod("Murmur", "DBM-Party-BC", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(18708)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBoom          = mod:NewCastAnnounce(33923)
local warnTouch         = mod:NewTargetAnnounce(33711)
local timerBoomCast     = mod:NewCastTimer(5, 33923)
local timerTouch        = mod:NewTargetTimer(14, 33711)
local specWarnTouch		= mod:NewSpecialWarning("specWarnTouch")

mod:AddBoolOption("PlaySoundOnBoom", true)

function mod:SPELL_CAST_START(args)
	if args.spellId == 33923 or args.spellId == 38796 then
		warnBoom:Show()
		timerBoomCast:Start()
		if self.Options.PlaySoundOnBoom then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33711 then
		warnTouch:Show(args.destName)
		timerTouch:Start(args.destName)
		if args:IsPlayer() then
            specWarnTouch:Show()
        end
	end
end