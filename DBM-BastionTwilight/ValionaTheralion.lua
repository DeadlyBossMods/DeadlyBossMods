local mod	= DBM:NewMod("ValionaTheralion", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnBlackout		= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames	= mod:NewSpellAnnounce(86840, 3)
local warnDeepBreath		= mod:NewSpellAnnounce(86059, 4)
local warnEngulfingMagic	= mod:NewTargetAnnounce(86622, 3)

local timerBlackout		= mod:NewTargetTimer(15, 86788)
local timerBlackoutNext		= mod:NewNextTimer(45, 86788)		-- Cancel when in air (needs detection)
local timerTwilightMeteorite	= mod:NewCastTimer(6, 86013)		
local timerEngulfingMagic	= mod:NewTargetTimer(20, 86622)
local timerEngulfingMagicNext	= mod:NewNextTimer(37, 86622)		-- Cancel when in air (needs detection)

local specWarnBlackout		= mod:NewSpecialWarningYou(86788)
local specWarnEngulfingMagic	= mod:NewSpecialWarningYou(86622)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("BlackoutIcon")

-- 88518 -> SpellID for Meteorite Target, SPELL_AURA_APPLIED?  or do we need to do scanning ? :(

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutNext:Start(10-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		warnBlackout:Show(args.destName)
		timerBlackout:Start(args.destName)
		timerBlackoutNext:Start()
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBlackout:Show()
		end
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then--86631 dummy script to use instead of other 4?
		warnEngulfingMagic:Show(args.destName)
		timerEngulfingMagic:Start(args.destName)
		timerEngulfingMaficNext:Start()
		if args:IsPlayer() then
			specWarnEngulfingMagic:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		timerBlackout:Cancel(args.destName)
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end	

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then--Strange to have 2 cast ids instead of either 1 or 4
		warnDevouringFlames:Show()
	elseif args:IsSpellID(86013, 92859, 92860, 92861) then
		warnTwilightMeteorite:Show()
		timerTwilightMeteorite:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(86059) then
		warnDeepBreath:Show()
	end
end