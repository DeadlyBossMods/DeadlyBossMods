local mod	= DBM:NewMod("Argaloth", "DBM-BaradinHold", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47120)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_HEALTH"
)

local warnConsuming			= mod:NewTargetAnnounce(88954, 3)
local warnMeteorSlash		= mod:NewSpellAnnounce(88942, 4)
local warnFirestorm			= mod:NewSpellAnnounce(88972, 4)
local warnFirestormSoon		= mod:NewAnnounce("WarnFirestormSoon", 3, 88972)

local specWarnMeteorSlash	= mod:NewSpecialWarningSpell(88942, mod:IsTank())
local specWarnFirestormCast	= mod:NewSpecialWarningSpell(88972)
local specWarnFirestorm		= mod:NewSpecialWarningMove(89000)

local timerConsuming		= mod:NewBuffActiveTimer(15, 88954)
local timerConsumingCD		= mod:NewCDTimer(24, 88954)
local timerMeteorSlash		= mod:NewNextTimer(16.5, 88942)
local timerMeteorSlashCast	= mod:NewCastTimer(1.25, 88942)
local timerFirestorm		= mod:NewBuffActiveTimer(15, 88972)
local timerFirestormCast	= mod:NewCastTimer(3, 88972)

local berserkTimer			= mod:NewBerserkTimer(300)
mod:AddBoolOption("SetIconOnConsuming", true)

local consumingTargets = {}
local consumingIcon = 8
local prewarnedFirestorm = false
local spamMeteor = 0
local consuming = 0
local lastFlames = 0

local function showConsumingWarning()
	warnConsuming:Show(table.concat(consumingTargets, "<, >"))
	table.wipe(consumingTargets)
	consumingIcon = 8
	lastFlames = 0
	prewarnedFirestorm = false
end

function mod:OnCombatStart(delay)
	table.wipe(consumingTargets)
	consumingIcon = 8
	berserkTimer:Start(-delay)
	spamMeteor = 0
	consuming = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(88954, 95173) then
	consuming = consuming + 1--Count raid members who got consuming
		timerConsuming:Start()
		timerConsumingCD:Start()
		consumingTargets[#consumingTargets + 1] = args.destName
		if self.Options.SetIconOnConsuming then
			self:SetIcon(args.destName, consumingIcon)
			consumingIcon = consumingIcon - 1
		end
		self:Unschedule(showConsumingWarning)
		if mod:IsDifficulty("normal10") and #consumingTargets >= 3 then
			showConsumingWarning()
		else
			self:Schedule(0.3, showConsumingWarning)
		end
	elseif args:IsSpellID(88972) then
		timerFirestorm:Start()
	elseif args:IsSpellID(88942, 95172) then--Debuff application not cast, special warning for tank taunts.
		if GetTime() - spamMeteor >= 4 then
			spamMeteor = GetTime()
			specWarnMeteorSlash:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(88954, 95173) then
		consuming = consuming - 1--Count raid members who had it dispelled
		if self.Options.SetIconOnConsuming then
			self:SetIcon(args.destName, 0)
		end
		if consuming == 0 then--End Buff active timer when no raid members have it
			timerConsuming:Cancel()
		end
	elseif args:IsSpellID(88972) then
		timerMeteorSlash:Start(13)
		timerConsumingCD:Start(9)
	end
end
	
function mod:SPELL_CAST_START(args)
	if args:IsSpellID(88942, 95172) then
		warnMeteorSlash:Show()
		timerMeteorSlashCast:Start()
		timerMeteorSlash:Start()
	elseif args:IsSpellID(88972) then
		warnFirestorm:Show()
		specWarnFirestormCast:Show()
		timerMeteorSlash:Cancel()
		timerConsumingCD:Cancel()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(89000, 95177) and GetTime() - lastFlames > 3 then -- Flames on ground from Firestorm
		specWarnFirestorm:Show()
		lastFlames = GetTime()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 75 or h > 45 and h < 55 then
			prewarnedFirestorm = false
		elseif not prewarnedFirestorm and (h > 69 and h < 72 or h > 35 and h < 38) then
			warnFirestormSoon:Show()
			prewarnedFirestorm = true
		end
	end
end