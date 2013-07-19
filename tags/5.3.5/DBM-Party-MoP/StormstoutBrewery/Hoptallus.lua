local mod	= DBM:NewMod(669, "DBM-Party-MoP", 2, 302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56717)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)


local warnFurlwind			= mod:NewSpellAnnounce(112992, 3)
local warnCarrotBreath		= mod:NewSpellAnnounce(112944, 4)

local specWarnFurlwind		= mod:NewSpecialWarningRun(112992, mod:IsMelee())
local specWarnCarrotBreath	= mod:NewSpecialWarningSpell(112944, nil, nil, nil, true)

local timerFurlwind			= mod:NewBuffActiveTimer(9.5, 112992)
local timerFurlwindCD		= mod:NewNextTimer(25, 112992)--True CD, 43 seconds, but triggering off alternating abilities reduces timer spam.
local timerBreath			= mod:NewBuffActiveTimer(18, 112944)
local timerBreathCD			= mod:NewNextTimer(18, 112944)--true CD, 43 seconds, same as Furlwind, which is what makes their interaction with eachother predictable.

local soundFurlwind			= mod:NewSound(112992, nil, mod:IsMelee())

--Notes:
--5/2 13:55:03.578  SPELL_CAST_SUCCESS,0xF130DD8D0000748B,"Hoptallus",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,114366,"Hoptallus Keg Scene",0x1
--Not sure if ENGAGE fires on above event, or when he's attackable.
--right now combat start timers are based on when attackable.

--Adds triggers don't show in combat log or emotes, will probably require transcriptor to monitor UNIT cast events.
--Maybe add a warning to switch and dps boppers and get em down, or a hammer spawned warning after they die, or both.
function mod:OnCombatStart(delay)
	timerFurlwindCD:Start(15-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 112992 then
		warnFurlwind:Show()
		specWarnFurlwind:Show()
		soundFurlwind:Play()
		timerFurlwind:Start()
		timerBreathCD:Start()--Always 18 seconds after Furlwind
	elseif args.spellId == 112944 then
		warnCarrotBreath:Show()
		specWarnCarrotBreath:Show()
		timerBreath:Start()
		timerFurlwindCD:Start()--Always 25 seconds after Carrot Breath
	end
end
