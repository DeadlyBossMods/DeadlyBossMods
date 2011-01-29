local mod	= DBM:NewMod("ValionaTheralion", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetZone()
mod:SetUsedIcons(6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_AURA"
)

local warnTwilightMeteorite			= mod:NewCastAnnounce(86013, 2, nil, false)--Just a basic cast warning, not entirely helpful.
local warnBlackout					= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames			= mod:NewSpellAnnounce(86840, 3)
local warnEngulfingMagic			= mod:NewTargetAnnounce(86622, 3)

local timerBlackout					= mod:NewTargetTimer(15, 86788)
local timerBlackoutCD				= mod:NewCDTimer(45, 86788)
local timerDevouringFlamesCD		= mod:NewCDTimer(40, 86840)
local timerTwilightMeteorite		= mod:NewCastTimer(6, 86013)		
local timerEngulfingMagic			= mod:NewBuffActiveTimer(20, 86622)
local timerEngulfingMagicNext		= mod:NewCDTimer(35, 86622)--30-40 second variations.
local timerNextDeepBreath			= mod:NewNextTimer(105, 86059)
local timerNextDazzlingDestruction	= mod:NewNextTimer(132, 86408)

local specWarnBlackout				= mod:NewSpecialWarningYou(86788)
local specWarnEngulfingMagic		= mod:NewSpecialWarningYou(86622)
local specWarnTwilightMeteorite		= mod:NewSpecialWarningYou(88518)
local specWarnDeepBreath			= mod:NewSpecialWarningSpell(86059)
local specWarnDazzlingDestruction	= mod:NewSpecialWarningSpell(86408)
local specWarnTwilightBlast			= mod:NewSpecialWarningMove(92898)
local specWarnTwilightBlastNear		= mod:NewSpecialWarningClose(92898, false)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("YellOnEngulfing", true, "announce")
mod:AddBoolOption("YellOnMeteor", false, "announce")
mod:AddBoolOption("YellOnTwilightBlast", false, "announce")
mod:AddBoolOption("TwilightBlastArrow")
mod:AddBoolOption("BlackoutIcon")
mod:AddBoolOption("EngulfingIcon")
mod:AddBoolOption("RangeFrame")

local engulfingMagicTargets = {}
local engulfingMagicIcon = 7
local dazzlingCast = 0
local markWarned = false
local blackoutActive = false
local meteorTarget = GetSpellInfo(88518)

local function showEngulfingMagicWarning()
	warnEngulfingMagic:Show(table.concat(engulfingMagicTargets, "<, >"))
	timerEngulfingMagic:Start()
	table.wipe(engulfingMagicTargets)
	engulfingMagicIcon = 7
end

local function markRemoved()
	markWarned = false
end

local function valionaDelay()
	timerEngulfingMagicNext:Cancel()
	timerBlackoutCD:Start(10)
	timerDevouringFlamesCD:Start(25)
end

function mod:TwilightBlastTarget()
	local targetname = self:GetBossTarget(45993)
	if not targetname or blackoutActive then return end
	if targetname == UnitName("player") then
		specWarnTwilightBlast:Show()
		if self.Options.YellOnTwilightBlast then
			SendChatMessage(L.YellTwilightBlast, "SAY")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnTwilightBlastNear:Show(targetname)
				if self.Options.TwilightBlastArrow then
					DBM.Arrow:ShowRunAway(x, y, 8, 5)
				end
			end
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutCD:Start(10-delay)
	timerDevouringFlamesCD:Start(25-delay)
	timerNextDazzlingDestruction:Start(85-delay)
	dazzlingCast = 0
	markWarned = false
	blackoutActive = false
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
		timerBlackoutCD:Start()
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBlackout:Show()
		end
		blackoutActive = true
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then
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
	elseif args:IsSpellID(93051) then--heroic placeholder cause honestly i'm not quite sure i understand this mechanic yet until i see it.
	
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		timerBlackout:Cancel(args.destName)
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 0)
		end
		blackoutActive = false
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then
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
	elseif args:IsSpellID(86408) then
		dazzlingCast = dazzlingCast + 1
		if dazzlingCast == 1 then--only special warn once for first one
			specWarnDazzlingDestruction:Show()
		elseif dazzlingCast == 3 then--Cancel bars now as it's safer then doing it at beginning do to a late 3rd blackout gets cast sometimes.
			timerBlackoutCD:Cancel()
			timerDevouringFlamesCD:Cancel()
			timerEngulfingMagicNext:Start(20)--need more logs to confirm this.
			timerNextDeepBreath:Start()
			dazzlingCast = 0--reset back to 0 for next time it happens.
		end
	elseif args:IsSpellID(86369, 92898, 92899, 92900) then
		self:ScheduleMethod(0.1, "TwilightBlastTarget")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Trigger1 or msg:find(L.Trigger1) then
		specWarnDeepBreath:Show()
		timerNextDazzlingDestruction:Start()
		self:Schedule(40, valionaDelay)--We do this cause you get at least one more engulfing magic after this emote before they completely switch so we need a method to cancel bar more appropriately
	end
end

function mod:UNIT_AURA(uId)
	if uId == "player" then
		if UnitDebuff("player", meteorTarget) and not markWarned then
			specWarnTwilightMeteorite:Show()
			if self.Options.YellOnMeteor then
				SendChatMessage(L.YellMeteor, "SAY")
			end
			markWarned = true
			self:Schedule(7, markRemoved)
		end
	end
end
