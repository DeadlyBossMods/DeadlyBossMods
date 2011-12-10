local mod	= DBM:NewMod(339, "DBM-BaradinHold", nil, 74)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55869)
mod:SetModelID(21252)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBladeDance			= mod:NewSpellAnnounce(104995, 4)
local warnSkewer				= mod:NewTargetAnnounce(104936, 4, nil, mod:IsTank() or mod:IsHealer())
local warnSeethingHate			= mod:NewTargetAnnounce(105067, 3)

local specWarnBladeDance		= mod:NewSpecialWarningRun(104995, nil, nil, true)--No sound, so it doesn't take from the glory of soundBladeDance
local specWarnSkewer			= mod:NewSpecialWarningSpell(104936, mod:IsTank() or mod:IsHealer())

local timerBladeDance			= mod:NewBuffActiveTimer(15, 104995)
local timerBladeDanceCD			= mod:NewNextTimer(60, 104995)
local timerFirstSpecial			= mod:NewTimer(8, "TimerFirstSpecial", "Interface\\Icons\\Spell_Nature_WispSplode")--Whether she casts skewer or seething after a blade dance is random. This generic timer just gives you a timer for whichever she'll do.
local timerSkewer				= mod:NewTargetTimer(8, 104936)
local timerSkewerCD				= mod:NewNextTimer(20.5, 104936)
local timerSeethingHate			= mod:NewTargetTimer(9, 105067)
local timerSeethingHateCD		= mod:NewNextTimer(20.5, 105067)

--local berserkTimer			= mod:NewBerserkTimer(300)

local soundBladeDance			= mod:NewSound(104995)

local firstspecial = false
local firstskewer = true
local firstseething = true
local bladeCasts = 0

function mod:OnCombatStart(delay)
	firstspecial = false
	firstskewer = true
	firstseething = true
	bladeCasts = 0
	timerFirstSpecial:Start(8-delay)
--	timerSeethingHateCD:Start(6-delay)
--	timerSkewerCD:Start(15-delay)
	timerBladeDanceCD:Start(30-delay)
--	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104936) then
		if not firstspecial then--First special ability used after a blade dance, so the OTHER special is going to be cast in 8 seconds.
			timerSeethingHateCD:Start(8)
			firstspecial = true
		end
		if not firstskewer then--First cast after blade dance, so there will be a 2nd cast in 20 seconds.
			timerSkewerCD:Start()
			firstskewer = true
		end
		warnSkewer:Show(args.destName)
		timerSkewer:Start(args.destName)
		specWarnSkewer:Show()
	elseif args:IsSpellID(105067) then--10m ID confirmed
		if not firstspecial then--First special ability used after a blade dance, so the OTHER special is going to be cast in 8 seconds.
			timerSkewerCD:Start(8)
			firstspecial = true
		end
		if not firstseething then--First cast after blade dance, so there will be a 2nd cast in 20 seconds.
			timerSeethingHateCD:Start()
			firstseething = true
		end
		warnSeethingHate:Show(args.destName)
		timerSeethingHate:Start(args.destName)
	elseif args:IsSpellID(105784) then--It seems the cast ID was disabled on live, so now gotta do this the dumb way.
		bladeCasts = bladeCasts + 1
		if bladeCasts > 1 then return end
		warnBladeDance:Show()
		specWarnBladeDance:Show()
		timerBladeDance:Start()
		if self:IsInCombat() then--Only start this on actual boss, not trash
			timerBladeDanceCD:Start()
			soundBladeDance:Play("Sound\\Creature\\LordMarrowgar\\IC_Marrowgar_WW01.wav")--I amuse myself on this
		else
			soundBladeDance:Play()--Play normal sound for the trash mobs tho
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106248) then
		if bladeCasts < 3 then return end
		firstspecial = false
		firstskewer = false
		firstseething = false
		bladeCasts = 0
		timerBladeDance:Cancel()
		timerFirstSpecial:Start()
	elseif args:IsSpellID(104936) then
		timerSkewer:Cancel(args.destName)
	elseif args:IsSpellID(105067) then
		timerSeethingHate:Cancel(args.destName)
	end
end