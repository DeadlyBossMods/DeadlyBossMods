if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(339, "DBM-BaradinHold", nil, 74)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)
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

local specWarnBladeDance		= mod:NewSpecialWarningSpell(104995, nil, nil, nil, true)
local specWarnSkewer			= mod:NewSpecialWarningSpell(104936, mod:IsTank() or mod:IsHealer())

local timerBladeDance			= mod:NewBuffActiveTimer(15, 104995)
local timerBladeDanceCD			= mod:NewNextTimer(60, 104995)
local timerSkewer				= mod:NewTargetTimer(8, 104936)
local timerSkewerCD				= mod:NewCDTimer(50, 104936)
local timerSeethingHate			= mod:NewTargetTimer(9, 105067)
local timerSeethingHateCD		= mod:NewCDTimer(20, 105067)

--local berserkTimer			= mod:NewBerserkTimer(300)

local soundBladeDance			= mod:NewSound(104995)

local skewer50 = true

function mod:OnCombatStart(delay)
	skewer50 = true
	timerSeethingHateCD:Start(6-delay)
	timerSkewerCD:Start(15-delay)
	timerBladeDanceCD:Start(35-delay)
--	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105738) then--10m confirmed, 25 probalby uses same scripted spellid though.
		warnBladeDance:Show()
		specWarnBladeDance:Show()
		soundBladeDance:Play()
		timerBladeDance:Start()
		timerBladeDanceCD:Start()
	elseif args:IsSpellID(104936) then--10m ID confirmed. Tank debuff, nasty stuff. Based on early logs, it seems to alternate between 50sec and 20 sec cd. 50, 20, 50, 20, etc
		if skewer50 then
			timerSkewerCD:Start()
			skewer50 = false
		else
			timerSkewerCD:Start(20)
			skewer50 = true
		end
		warnSkewer:Show(args.destName)
		timerSkewer:Start(args.destName)
		specWarnSkewer:Show()
	elseif args:IsSpellID(105067) then--10m ID confirmed
		warnSeethingHate:Show(args.destName)
		timerSeethingHate:Start(args.destName)
		timerSeethingHateCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(105738) then--Primarily for trash that dies, but you never know boss could too.
		timerBladeDance:Cancel()
	elseif args:IsSpellID(104936) then
		timerSkewer:Cancel(args.destName)
	end
end