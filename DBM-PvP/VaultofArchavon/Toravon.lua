local mod	= DBM:NewMod("Toravon", "DBM-PvP", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2521 $"):sub(12, -3))
mod:SetCreatureID(38433)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnFreezingGround	= mod:NewSpellAnnounce(72104)
local warnWhiteout			= mod:NewSpellAnnounce(72096)
local warnOrb				= mod:NewSpellAnnounce(72095)
local WarnFrostbite			= mod:NewAnnounce("Frostbite", 3)

--local timerNextFrostbite	= mod:NewNextTimer(20, 72098) Unknown value at this time
local timerWhiteout			= mod:NewCDTimer(45, 72096)--Best guess from watching a video.
local timerNextOrb			= mod:NewNextTimer(30, 72095)--Best guess from watching a video.

--local timerToravonEnrage	= mod:NewTimer(300, "ToravonEnrage", 26662)

function mod:OnCombatStart(delay)
	timerNextOrb:Start(15-delay)--More best guess but seems about right
	timerWhiteout:Start(30-delay)--More best guess but seems about right
--	timerToravonEnrage:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72096, 72034) then
		warnWhiteout:Show()
		timerWhiteout:Start()
	elseif args:IsSpellID(72095, 72091) then	--Maybe right spellids?
		warnOrb:Show()
		timerNextOrb:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
  if args:IsSpellID(72104, 72090) then			-- Freezing Ground (no idea?)
    warnFreezingGround:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72098, 72004) then		-- Frostbite (tanks only debuff)
		WarnFrostbite:Show(args.destName, args.amount)
--		timerNextFrostbite:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(72098, 72004) then		-- Frostbite (tanks only debuff)
		WarnFrostbite:Show(args.destName, args.amount)
--		timerNextFrostbite:Start()
	end
end