local mod	= DBM:NewMod("ValionaTheralion", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetZone()
mod:SetUsedIcons(6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnTwilightMeteorite		= mod:NewSpellAnnounce(86013, 3)
local warnBlackout				= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames		= mod:NewSpellAnnounce(86840, 3)
local warnDeepBreath			= mod:NewSpellAnnounce(86059, 4)
local warnEngulfingMagic		= mod:NewTargetAnnounce(86622, 3)

local timerBlackout				= mod:NewTargetTimer(15, 86788)
local timerBlackoutNext			= mod:NewNextTimer(45, 86788)		-- Cancel when in air (needs detection)
local timerDevouringFlamesCD	= mod:NewCDTimer(40, 86840)
local timerTwilightMeteorite	= mod:NewCastTimer(6, 86013)		
local timerEngulfingMagic		= mod:NewBuffActiveTimer(20, 86622)
local timerEngulfingMagicNext	= mod:NewNextTimer(37, 86622)		-- Cancel when in air (needs detection)

local specWarnBlackout			= mod:NewSpecialWarningYou(86788)
local specWarnEngulfingMagic	= mod:NewSpecialWarningYou(86622)
local specWarnDeepBreath		= mod:NewSpecialWarningSpell(86059)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("YellOnEngulfing", true, "announce")
mod:AddBoolOption("BlackoutIcon")
mod:AddBoolOption("EngulfingIcon")
mod:AddBoolOption("RangeFrame")

-- 88518 doesn't show in combat log -> SpellID for Meteorite Target, do we need to do scanning ? :(
local engulfingMagicTargets = {}
local engulfingMagicIcon = 7

local function showEngulfingMagicWarning()
	warnEngulfingMagic:Show(table.concat(engulfingMagicTargets, "<, >"))
	timerEngulfingMagic:Start()
	table.wipe(engulfingMagicTargets)
	engulfingMagicIcon = 7
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutNext:Start(10-delay)
	timerDevouringFlamesCD:Start(25-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
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
		engulfingMagicTargets[#engulfingMagicTargets + 1] = args.destName
		timerEngulfingMagicNext:Start()
		if args:IsPlayer() then
			specWarnEngulfingMagic:Show()
			if self.Options.YellOnEngulfing then
				SendChatMessage(L.YellEngulfing, "SAY")
			end
		end
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, engulfingMagicIcon)
			engulfingMagicIcon = engulfingMagicIcon - 1
		end
		self:Unschedule(showEngulfingMagicWarning)
		if (mod:IsDifficulty("normal25") and #engulfingMagicTargets >= 2) or (mod:IsDifficulty("normal10") and #engulfingMagicTargets >= 1) then
			showEngulfingMagicWarning()
		else
			self:Schedule(0.3, showEngulfingMagicWarning)
		end
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		timerBlackout:Cancel(args.destName)
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then--86631 dummy script to use instead of other 4?
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end	

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then--Strange to have 2 cast ids instead of either 1 or 4
		warnDevouringFlames:Show()
		timerDevouringFlamesCD:Start()
	elseif args:IsSpellID(86013, 92859, 92860, 92861) then
		warnTwilightMeteorite:Show()
		timerTwilightMeteorite:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(86059) then
		warnDeepBreath:Show()
		specWarnDeepBreath:Show()
	end
end

--Not in use at moment, too tired/lazy to do this right now. this encounter is a complete disaster with phase detections.
--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Trigger1 or msg:find(L.Trigger1) then

	end
end--]]