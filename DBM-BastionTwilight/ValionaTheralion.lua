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
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA"
)

local warnBlackout					= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames			= mod:NewSpellAnnounce(86840, 3)
local warnEngulfingMagic			= mod:NewTargetAnnounce(86622, 3)
local warnDazzlingDestruction		= mod:NewCountAnnounce(86408, 4)
local warnDeepBreath				= mod:NewCountAnnounce(86059, 4)
local warnTwilightShift				= mod:NewStackAnnounce(93051, 2)

local timerBlackout					= mod:NewTargetTimer(15, 86788)
local timerBlackoutCD				= mod:NewCDTimer(45, 86788)
local timerDevouringFlamesCD		= mod:NewCDTimer(40, 86840)
local timerTwilightMeteorite		= mod:NewCastTimer(6, 86013)		
local timerEngulfingMagic			= mod:NewBuffActiveTimer(20, 86622)
local timerEngulfingMagicNext		= mod:NewCDTimer(35, 86622)--30-40 second variations.
local timerNextDeepBreath			= mod:NewNextTimer(103, 86059)
local timerNextDazzlingDestruction	= mod:NewNextTimer(132, 86408)
local timerTwilightShift			= mod:NewTargetTimer(100, 93051)
local timerTwilightShiftCD			= mod:NewCDTimer(20, 93051)

local specWarnBlackout				= mod:NewSpecialWarningYou(86788)
local specWarnEngulfingMagic		= mod:NewSpecialWarningYou(86622)
local specWarnTwilightMeteorite		= mod:NewSpecialWarningYou(88518)
local specWarnDevouringFlames		= mod:NewSpecialWarningSpell(86840)
local specWarnDeepBreath			= mod:NewSpecialWarningSpell(86059)
local specWarnDazzlingDestruction	= mod:NewSpecialWarningSpell(86408)
local specWarnFabulousFlames		= mod:NewSpecialWarningMove(92907)
local specWarnTwilightBlast			= mod:NewSpecialWarningMove(92898, false)
local specWarnTwilightBlastNear		= mod:NewSpecialWarningClose(92898, false)
local specWarnTwilightZone			= mod:NewSpecialWarningStack(92887, nil, 10)

local berserkTimer					= mod:NewBerserkTimer(600)

local soundEngulfingMagic			= mod:NewSound(86622)

mod:AddBoolOption("YellOnEngulfing", true, "announce")
mod:AddBoolOption("YellOnTwilightMeteor", false, "announce")
mod:AddBoolOption("YellOnTwilightBlast", false, "announce")
mod:AddBoolOption("TBwarnWhileBlackout", false, "announce")
mod:AddBoolOption("TwilightBlastArrow")
mod:AddBoolOption("BlackoutIcon")
mod:AddBoolOption("EngulfingIcon")
mod:AddBoolOption("RangeFrame")

local engulfingMagicTargets = {}
local engulfingMagicIcon = 7
local dazzlingCast = 0
local breathCast = 0
local lastflame = 0
local spamZone = 0
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
	if not targetname then return end
	if self.Options.TBwarnWhileBlackout or not blackoutActive then
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
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutCD:Start(10-delay)
	timerDevouringFlamesCD:Start(25-delay)
	timerNextDazzlingDestruction:Start(85-delay)
	dazzlingCast = 0
	breathCast = 0
	lastflame = 0
	spamZone = 0
	markWarned = false
	blackoutActive = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	DBM.BossHealth:Clear()
	DBM.BossHealth:AddBoss(45992, 45993, L.name)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		blackoutActive = true
		warnBlackout:Show(args.destName)
		timerBlackout:Start(args.destName)
		timerBlackoutCD:Start()
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBlackout:Show()
		end
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then
		engulfingMagicTargets[#engulfingMagicTargets + 1] = args.destName
		timerEngulfingMagicNext:Start()
		if args:IsPlayer() then
			specWarnEngulfingMagic:Show()
			soundEngulfingMagic:Play()
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
	elseif args:IsSpellID(93051) then
		warnTwilightShift:Show(args.destName, args.amount or 1)
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
		timerTwilightShift:Show(args.destName.." ("..tostring(args.amount or 1)..")")
		timerTwilightShiftCD:Start()
	elseif args:IsSpellID(92887) and args:IsPlayer() then
		if (args.amount or 1) >= 10 and GetTime() - spamZone > 5 then
			specWarnTwilightZone:Show(args.amount)
			spamZone = GetTime()
		end
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
	elseif args:IsSpellID(93051) then
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
	end
end	

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then--Strange to have 2 cast ids instead of either 1 or 4
		warnDevouringFlames:Show()
		timerDevouringFlamesCD:Start()
		specWarnDevouringFlames:Show()
	elseif args:IsSpellID(86408) then
		dazzlingCast = dazzlingCast + 1
		warnDazzlingDestruction:Show(dazzlingCast)
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

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(86505, 92907, 92908, 92909) and args:IsPlayer() and GetTime() - lastflame > 3 then
		specWarnFabulousFlames:Show()
		lastflame = GetTime()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Trigger1 or msg:find(L.Trigger1) then
		breathCast = breathCast + 1
		warnDeepBreath:Show(breathCast)
		if breathCast == 1 then
			timerNextDeepBreath:Cancel()
			specWarnDeepBreath:Show()
			timerNextDazzlingDestruction:Start()
			self:Schedule(40, valionaDelay)--We do this cause you get at least one more engulfing magic after this emote before they completely switch so we need a method to cancel bar more appropriately
		elseif breathCast == 3 then
			breathCast = 0
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", meteorTarget) and not markWarned then
		specWarnTwilightMeteorite:Show()
		timerTwilightMeteorite:Start()
		if self.Options.YellOnTwilightMeteor then
			SendChatMessage(L.YellMeteor, "SAY")
		end
		markWarned = true
		self:Schedule(7, markRemoved)
	end
end
