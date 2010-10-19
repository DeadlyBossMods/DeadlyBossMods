local mod	= DBM:NewMod("ValionaTheralion", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnBlackout		= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames	= mod:NewSpellAnnounce(86840, 3)
local warnTwilightMeteorite	= mod:NewSpellAnnounce(86013, 3)	-- Also an aura on a person?
local warnDeepBreath		= mod:NewSpellAnnounce(86059, 4)
local warnEngulfingMagic	= mod:NewTargetAnnounce(86622, 3)

local timerBlackout		= mod:NewTargetTimer(15, 86788)
local timerBlackoutNext		= mod:NewNextTimer(45, 86788)		-- Cancel when in air (needs detection)
local timerTwilightMeteorite	= mod:NewCastTimer(6, 86013)
local timerEngulfingMagic	= mod:NewTargetTimer(20, 86622)
local timerEngulfingMagicNext	= mod:NewNextTimer(37, 86622)		-- Cancel when in air (needs detection)

local berserkTimer		= mod:NewBerserkTimer(600)


function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutNext:Start(10-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86788, 92876, 92878) then
		warnBlackout:Show(args.destName)
		timerBlackout:Start(args.destName)
		timerBlackoutNext:Start()
		self:SetIcon(args.destName, 8)
	elseif args:IsSpellID(86622, 86631) then
		warnEngulfingMagic:Show(args.destName)
		timerEngulfingMagic:Start(args.destName)
		timerEngulfingMaficNext:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	timerBlackout:Cancel(args.destName)
	self:SetIcon(args.destName, 0)
end	

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then
		warnDevouringFlames:Show()
	elseif args:IsSpellID(86013, 92859, 92860) then
		warnTwilightMeteorite:Show()		-- I think there is also an aura connected to it?
		timerTwilightMeteorite:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(86059) then
		warnDeepBreath:Show()
	end
end