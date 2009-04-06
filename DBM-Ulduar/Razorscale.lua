local mod = DBM:NewMod("Razorscale", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

-- freely created by provided informations from
-- http://www.mmo-champion.com/index.php?page=840
-- this mod issn't fully working and finished - please provide combatlogs

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local specWarnDevouringFlame		= mod:NewSpecialWarning("SpecWarnDevouringFlame")
local timerDeepBreathCooldown		= mod:NewTimer(21, "timerDeepBreathCooldown", 64021)
local timerDeepBreathCast		= mod:NewTimer(2.5, "timerDeepBreathCast", 64021)

mod:AddBoolOption("PlaySoundOnDevouringFlame", true, "announce")


function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63816 and args.destName == UnitName("player") then		-- you stay in the Devouring Flame (some shit on the ground ^^)
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnDevouringFlame then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64021 then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	end
end

