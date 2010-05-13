local mod	= DBM:NewMod("Sindragosa", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36853)
mod:RegisterCombat("combat")
mod:SetMinSyncRevision(3712)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnAirphase				= mod:NewAnnounce("WarnAirphase", 2, 43810)
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2, 43810)
local warnPhase2soon			= mod:NewAnnounce("warnPhase2soon", 1)
local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnInstability			= mod:NewAnnounce("warnInstability", 2, 69766, false)
local warnChilledtotheBone		= mod:NewAnnounce("warnChilledtotheBone", 2, 70106, false)
local warnMysticBuffet			= mod:NewAnnounce("warnMysticBuffet", 2, 70128, false)
local warnFrostBeacon			= mod:NewTargetAnnounce(70126, 4)
local warnBlisteringCold		= mod:NewSpellAnnounce(70123, 3)
local warnFrostBreath			= mod:NewSpellAnnounce(71056, 2, nil, mod:IsTank() or mod:IsHealer())
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762, 2, nil, not mod:IsMelee())

local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123)
local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762)
local specWarnFrostBeacon		= mod:NewSpecialWarningYou(70126)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, 4)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, 4)
local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 5)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase", 43810)
local timerNextGroundphase		= mod:NewTimer(45, "TimerNextGroundphase", 43810)
local timerNextFrostBreath		= mod:NewNextTimer(22, 71056, nil, mod:IsTank() or mod:IsHealer())
local timerNextBlisteringCold	= mod:NewCDTimer(67, 70123)
local timerNextBeacon			= mod:NewNextTimer(16, 70126)
local timerBlisteringCold		= mod:NewCastTimer(6, 70123)
local timerUnchainedMagic		= mod:NewBuffActiveTimer(30, 69762)
local timerInstability			= mod:NewBuffActiveTimer(5, 69766)
local timerChilledtotheBone		= mod:NewBuffActiveTimer(8, 70106)
local timerMysticBuffet			= mod:NewBuffActiveTimer(8, 70128)
local timerNextMysticBuffet		= mod:NewNextTimer(6, 70128)
local timerMysticAchieve		= mod:NewAchievementTimer(30, 4620, "achievementMystic")

local berserkTimer				= mod:NewBerserkTimer(600)

local soundBlisteringCold = mod:NewSound(70123)
mod:AddBoolOption("SetIconOnFrostBeacon", true)
mod:AddBoolOption("SetIconOnUnchainedMagic", true)
mod:AddBoolOption("ClearIconsOnAirphase", true)
mod:AddBoolOption("AnnounceFrostBeaconIcons", false)
mod:AddBoolOption("RangeFrame")

local beaconTargets		= {}
local beaconIconTargets	= {}
local unchainedTargets	= {}
local warned_P2 = false
local phase = 0
local unchainedIcons = 7
local activeBeacons	= false

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetBeaconIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(beaconIconTargets, sort_by_group)
			local beaconIcons = 8
			for i, v in ipairs(beaconIconTargets) do
				if self.Options.AnnounceFrostBeaconIcons then
					SendChatMessage(L.BeaconIconSet:format(beaconIcons, UnitName(v)), "RAID")
				end
				mod:SetIcon(UnitName(v), beaconIcons, 8)
				beaconIcons = beaconIcons - 1
			end
			table.wipe(beaconIconTargets)
		end
	end
end

local function warnBeaconTargets()
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
end

local function warnUnchainedTargets()
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	timerUnchainedMagic:Start()
	table.wipe(unchainedTargets)
	unchainedIcons = 7
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerNextAirphase:Start(50-delay)
	timerNextBlisteringCold:Start(33-delay)
	warned_P2 = false
	table.wipe(beaconTargets)
	table.wipe(beaconIconTargets)
	table.wipe(unchainedTargets)
	unchainedIcons = 7
	phase = 1
	activeBeacons = false
	if self.Options.RangeFrame then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			DBM.RangeCheck:Show(20, GetRaidTargetIndex)
		else
			DBM.RangeCheck:Show(10, GetRaidTargetIndex)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69649, 71056, 71057, 71058) or args:IsSpellID(73061, 73062, 73063, 73064) then--Frost Breath
		warnFrostBreath:Show()
		timerNextFrostBreath:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70126) then
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnFrostBeacon:Show()
		end
		if phase == 1 and self.Options.SetIconOnFrostBeacon then
			table.insert(beaconIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetBeaconIcons")
			self:ScheduleMethod(0.1, "SetBeaconIcons")
		end
		if phase == 2 then
			timerNextBeacon:Start()
			if self.Options.SetIconOnFrostBeacon then
				self:SetIcon(args.destName, 8)
				if self.Options.AnnounceFrostBeaconIcons then
					SendChatMessage(L.BeaconIconSet:format(8, args.destName), "RAID")
				end
			end
		end
		self:Unschedule(warnBeaconTargets)
		if phase == 2 or (mod:IsDifficulty("normal25") and #beaconTargets >= 5) or (mod:IsDifficulty("heroic25") and #beaconTargets >= 6) or ((mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10")) and #beaconTargets >= 2) then
			warnBeaconTargets()
		else
			self:Schedule(0.3, warnBeaconTargets)
		end
	elseif args:IsSpellID(69762) then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnUnchainedMagic:Show()
		end
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, unchainedIcons)
			unchainedIcons = unchainedIcons - 1
		end
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 6 then
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
			timerNextMysticBuffet:Start()
			if (args.amount or 1) >= 5 then
				specWarnMysticBuffet:Show(args.amount)
			end
			if (args.amount or 1) < 2 then
				timerMysticAchieve:Start()
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70117) then--Icy Grip Cast, not blistering cold, but adds an extra 1sec to the warning
		warnBlisteringCold:Show()
		specWarnBlisteringCold:Show()
		timerBlisteringCold:Start()
		timerNextBlisteringCold:Start()
		soundBlisteringCold:Play()
	end
end	

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69762) then
		if self.Options.SetIconOnUnchainedMagic and not activeBeacons then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70126) then
		activeBeacons = false
	elseif args:IsSpellID(70106) then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Cancel()
		end
	elseif args:IsSpellID(69766) then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Cancel()
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then
		if args:IsPlayer() then
			timerMysticAchieve:Cancel()
			timerMysticBuffet:Cancel()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_P2 and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_P2 = true
		warnPhase2soon:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.YellAirphase) then
		if self.Options.ClearIconsOnAirphase then
			self:ClearIcons()
		end
		warnAirphase:Show()
		timerNextFrostBreath:Cancel()
		timerUnchainedMagic:Start(55)
		timerNextBlisteringCold:Start(80)--Not exact anywhere from 80-110seconds after airphase begin
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(40)
		activeBeacons = true
	elseif msg:find(L.YellPhase2) then
		phase = phase + 1
		warnPhase2:Show()
		timerNextBeacon:Start(7)
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
		timerNextBlisteringCold:Start(35)
	end
end