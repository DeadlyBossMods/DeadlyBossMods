local mod	= DBM:NewMod("Sindragosa", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36853)
mod:RegisterCombat("YELL", L.YellPull)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFirstAirphase			= mod:NewAnnounce("warnFirstAirphase")
local warnAirphase				= mod:NewAnnounce("WarnAirphase")
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnInstability			= mod:NewAnnounce("warnInstability", 2, nil, false)
local warnChilledtotheBone		= mod:NewAnnounce("warnChilledtotheBone", 2, nil, false)
local warnMysticBuffet			= mod:NewAnnounce("warnMysticBuffet", 2, nil, false)
local warnFrostBeacon			= mod:NewTargetAnnounce(70126)
local warnBlisteringCold		= mod:NewCastAnnounce(70123, 3)
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762)

local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123)
local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762)
local specWarnFrostBeacon		= mod:NewSpecialWarningYou(70126)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, 4)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, 4)
local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 4)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase")
local timerNextGroundphase		= mod:NewTimer(45, "TimerNextGroundphase")
local timerBlisteringCold		= mod:NewCastTimer(5, 70123)
local timerInstability			= mod:NewBuffActiveTimer(8, 69766)
local timerChilledtotheBone		= mod:NewBuffActiveTimer(8, 70106)
local timerMysticBuffet			= mod:NewBuffActiveTimer(8, 70128)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnFrostBeacon", true)

local beaconTargets		= {}
local unchainedTargets	= {}
local beaconIcons = 8
local warned_air = false

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	beaconIcons = 8
	warned_air = false
end

local function warnBeaconTargets()
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
	beaconIcons = 8
end

local function warnUnchainedTargets()
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	table.wipe(unchainedTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70126) then
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnFrostBeacon:Show()
		end
		if self.Options.SetIconOnFrostBeacon then
			self:SetIcon(args.destName, beaconIcons, 7)
			beaconIcons = beaconIcons - 1
		end
		self:Unschedule(warnBeaconTargets)
		if #beaconTargets >= 5 then
			warnBeaconTargets()
		else
			self:Schedule(0.3, warnBeaconTargets)
		end
	elseif args:IsSpellID(69762) then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnUnchainedMagic:Show()
		end
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 5 then
			warnUnchainedTargets()
		else
			self:Schedule(0.3, warnUnchainedTargets)
		end
	elseif args:IsSpellID(70106) then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			warnChilledtotheBone:Show(args.amount or 1)
			timerChilledtotheBone:Start()
			if (args.amount or 1) >= 4 then
				specWarnChilledtotheBone:Show(args.amount)
			end
		end
	elseif args:IsSpellID(69766) then	--Instability (casters)
		if args:IsPlayer() then
			warnInstability:Show(args.amount or 1)
			timerInstability:Start()
			if (args.amount or 1) >= 4 then
				specWarnInstability:Show(args.amount)
			end
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then	--Mystic Buffet (phase 3 - everyone)
		if args:IsPlayer() then
			warnMysticBuffet:Show(args.amount or 1)
			timerMysticBuffet:Start()
			if (args.amount or 1) >= 4 then
				specWarnMysticBuffet:Show(args.amount)
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70117) then
		warnBlisteringCold:Show()
		specWarnBlisteringCold:Show()
		timerBlisteringCold:Start()
	end
end	

function mod:UNIT_HEALTH(uId)
	if not warned_air and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.88 then
		warned_air = true
		warnFirstAirphase:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAirphase or msg:find(L.YellAirphase) then
		self:SendSync("Airphase")
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		self:SendSync("Phase2")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Airphase" then
		warnAirphase:Show()
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(40)
	elseif msg == "Phase2" then
		warnPhase2:Show()
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
	end
end