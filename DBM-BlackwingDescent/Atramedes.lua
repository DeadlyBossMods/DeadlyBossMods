local mod	= DBM:NewMod("Atramedes", "DBM-BlackwingDescent", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41442)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSonicBreath		= mod:NewSpellAnnounce(78075, 3)
local warnTracking			= mod:NewTargetAnnounce(78092, 3)
local warnAirphase			= mod:NewAnnounce("WarnAirphase", 3)
local warnGroundphase		= mod:NewAnnounce("WarnGroundphase", 3)
local warnShieldsLeft		= mod:NewAnnounce("WarnShieldsLeft", 3, 77611)

local specWarnSearingFlame	= mod:NewSpecialWarningSpell(77840)
local specWarnTracking		= mod:NewSpecialWarningYou(78092)

local timerSonicBreath		= mod:NewCDTimer(41, 78075)
local timerSearingFlame		= mod:NewNextTimer(46.5, 77840)
local timerAirphase			= mod:NewTimer(90, "TimerAirphase")
local timerGroundphase		= mod:NewTimer(35, "TimerGroundphase")

local berserkTimer			= mod:NewBerserkTimer(600)

local soundTracking			= mod:NewSound(78092)

mod:AddBoolOption("TrackingIcon")
--mod:AddBoolOption("InfoFrame")

local shieldsLeft = 10

local HardCodedAtramedesSoundFrame = false  	-- set to true for testing purposes ;)

local function groundphase()
	timerAirphase:Start()
	timerSonicBreath:Start(25)
	timerSearingFlame:Start()
end

function mod:OnCombatStart(delay)
	timerSonicBreath:Start(25-delay)
	timerSearingFlame:Start(45-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
	end
	shieldsLeft = 10
	--if self.Options.InfoFrame then
	if HardCodedAtramedesSoundFrame then
		DBM.InfoFrame:SetHeader(L.Soundlevel)
		DBM.InfoFrame:Show(5, "UNIT_POWER", 40, "ALTERNATE", ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if HardCodedAtramedesSoundFrame then
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(78075) then
		timerSonicBreath:Start()
		warnSonicBreath:Show()
	elseif args:IsSpellID(77840) then
		specWarnSearingFlame:Show()
--		timerSearingFlame:Start()
	elseif args:IsSpellID(77611) and not args:IsSrcTypePlayer() then
		shieldsLeft = shieldsLeft - 1
		warnShieldsLeft:Show(shieldsLeft)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Airphase or msg:find(L.Airphase)  then
		warnAirphase:Show()
		timerSonicBreath:Cancel()
		timerSearingFlame:Cancel()
		timerGroundphase:Start()
		self:Schedule(32.5, groundphase)
	end
end