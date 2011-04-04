local mod	= DBM:NewMod("Atramedes", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41442)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_AURA"
)

local warnSonarPulse		= mod:NewSpellAnnounce(92411, 3)
local warnSonicBreath		= mod:NewSpellAnnounce(78075, 3)
local warnTracking			= mod:NewTargetAnnounce(78092, 4)
local warnAirphase			= mod:NewAnnounce("WarnAirphase", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnGroundphase		= mod:NewAnnounce("WarnGroundphase", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnShieldsLeft		= mod:NewAnnounce("WarnShieldsLeft", 2, 77611)
local warnAddSoon			= mod:NewAnnounce("warnAddSoon", 3, 92685)
local warnPhaseShift		= mod:NewSpellAnnounce(92681, 3)
local warnObnoxious			= mod:NewCastAnnounce(92702, 4, nil, false)

local specWarnSearingFlame	= mod:NewSpecialWarningSpell(77840)
local specWarnSonarPulse	= mod:NewSpecialWarningSpell(92411, false)
local specWarnTracking		= mod:NewSpecialWarningYou(78092)
local specWarnPestered		= mod:NewSpecialWarningYou(92685)
local yellPestered			= mod:NewYell(92685, L.YellPestered)
local specWarnObnoxious		= mod:NewSpecialWarningInterrupt(92702, false)
local specWarnAddTargetable	= mod:NewSpecialWarning("specWarnAddTargetable", false)

local timerSonarPulseCD		= mod:NewCDTimer(10, 92411)
local timerSonicBreath		= mod:NewCDTimer(41, 78075)
local timerSearingFlame		= mod:NewNextTimer(46.5, 77840)
local timerAirphase			= mod:NewTimer(85, "TimerAirphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")--These both need more work
local timerGroundphase		= mod:NewTimer(31.5, "TimerGroundphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")--I just never remember to log and /yell at right times since they lack most accurate triggers.

local berserkTimer			= mod:NewBerserkTimer(600)

local soundTracking			= mod:NewSound(78092)

mod:AddBoolOption("TrackingIcon")
mod:AddBoolOption("InfoFrame")

local shieldsLeft = 10
local pestered = GetSpellInfo(92685)
local pesteredWarned = false

local function groundphase()
	timerAirphase:Start()
	timerSonicBreath:Start(25)
	timerSearingFlame:Start()
end

function mod:OnCombatStart(delay)
	timerSonarPulseCD:Start(-delay)
	timerSonicBreath:Start(25-delay)
	timerSearingFlame:Start(45-delay)
	timerAirphase:Start(90-delay)
	shieldsLeft = 10
	pesteredWarned = false
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.Soundlevel)
		DBM.InfoFrame:Show(5, "playerpower", 15, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78092) then
		warnTracking:Show(args.destName)
		if args:IsPlayer() then
			specWarnTracking:Show()
			soundTracking:Play()
		end
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(78092) then
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92681) then--Phase shift removed, add targetable/killable.
		specWarnAddTargetable:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(92677, 92702) then
		warnObnoxious:Show()
		specWarnObnoxious:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(78075) then
		timerSonicBreath:Start()
		warnSonicBreath:Show()
	elseif args:IsSpellID(77840) then
		specWarnSearingFlame:Show()
	elseif args:IsSpellID(92681) then--Add is phase shifting which means a new one is spawning, or an old one is changing target cause their first target died.
		warnPhaseShift:Show()
		pesteredWarned = false--Might need more work on this.
	elseif args:IsSpellID(77672, 92411, 92412, 92413) then--Sonar Pulse (the discs)
		warnSonarPulse:Show()
		specWarnSonarPulse:Show()
		timerSonarPulseCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:IsInCombat() and args:IsNPC() and self:GetCIDFromGUID(args.destGUID) ~= 49740 then
		shieldsLeft = shieldsLeft - 1
		warnShieldsLeft:Show(shieldsLeft)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Airphase or msg:find(L.Airphase)  then
		warnAirphase:Show()
		timerSonicBreath:Cancel()
		timerSonarPulseCD:Cancel()
		timerGroundphase:Start()
		self:Schedule(31.5, groundphase)
	elseif msg == L.NefAdd or msg:find(L.NefAdd)  then
		warnAddSoon:Show()--Unfortunately it seems quite random when he does this so i cannot add a CD bar for it. i see variations as large as 20 seconds in between to a minute in between.
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" or pesteredWarned then return end
	if UnitDebuff("player", pestered) then
		pesteredWarned = true--This aura is a periodic trigger, so we don't want to spam warn for it.
		specWarnPestered:Show()
		yellPestered:Yell()
	end
end