local mod	= DBM:NewMod(1154, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76809, 76806)--76809 foreman feldspar, 76806 heart of the mountain, 76809 Security Guard, 76810 Furnace Engineer, 76811 Bellows Operator, 76815 Primal Elementalist, 78463 Slag Elemental, 76821 Firecaller
mod:SetEncounterID(1690)
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(13480)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155186 156937 177756",
	"SPELL_CAST_SUCCESS 155179 174726",
	"SPELL_AURA_APPLIED 155192 174716 155196 158345 155242 155181 176121 155225 156934 155173 159558",
	"SPELL_AURA_REFRESH 155192 174716 159558",
	"SPELL_AURA_APPLIED_DOSE 155242",
	"SPELL_AURA_REMOVED 155192 174716 176121 155196 158345 159558",
	"SPELL_PERIODIC_DAMAGE 156932 155223 155743",
	"SPELL_ABSORBED 156932 155223 155743",
	"UNIT_DIED",
	"UNIT_POWER_FREQUENT boss1"
)
 
local warnRegulators			= mod:NewAnnounce("warnRegulators", 2, 156918)
local warnBlastFrequency		= mod:NewAnnounce("warnBlastFrequency", 1, 155209, "Healer")
local warnBomb					= mod:NewTargetAnnounce("OptionVersion2", 155192, 4, nil, false)
local warnDropBombs				= mod:NewSpellAnnounce("OptionVersion2", 174726, 1, nil, "-Tank")
local warnEngineer				= mod:NewCountAnnounce("ej9649", 2, 155179)
local warnRupture				= mod:NewTargetAnnounce(156932, 3)
--Phase 2
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnElementalists			= mod:NewAddsLeftAnnounce("ej9655", 2, 91751)
local warnFixate				= mod:NewTargetAnnounce(155196, 4)
local warnVolatileFire			= mod:NewTargetAnnounce("OptionVersion2", 176121, 4, nil, false)--Spam. disable by default.
local warnFireCaller			= mod:NewCountAnnounce("ej9659", 3, 156937, "Tank")
local warnSecurityGuard			= mod:NewCountAnnounce("ej9648", 2, 160379, "Tank")
--Phase 3
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warnMelt					= mod:NewTargetAnnounce(155225, 4)--Every 10 sec.
local warnHeat					= mod:NewStackAnnounce(155242, 2, nil, "Tank")

local specWarnBomb				= mod:NewSpecialWarningMoveTo(155192, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(155192), nil, 3, nil, 2)
local specWarnBellowsOperator	= mod:NewSpecialWarningSwitch("OptionVersion2", "ej9650", "-Healer", nil, nil, nil, nil, 2)
local specWarnDeafeningRoar		= mod:NewSpecialWarningDodge("OptionVersion2", 177756, "Tank", nil, nil, 3)
local specWarnRepair			= mod:NewSpecialWarningInterrupt(155179, "-Healer", nil, nil, nil, nil, 2)
local specWarnRuptureOn			= mod:NewSpecialWarningYou(156932)
local specWarnRupture			= mod:NewSpecialWarningMove(156932, nil, nil, nil, nil, nil, 2)
local yellRupture				= mod:NewYell(156932)
--Phase 2
local specWarnFixate			= mod:NewSpecialWarningYou(155196)
local specWarnMeltYou			= mod:NewSpecialWarningYou(155225)
local specWarnMeltNear			= mod:NewSpecialWarningClose(155225, false)
local specWarnMelt				= mod:NewSpecialWarningMove(155223, nil, nil, nil, nil, nil, 2)
local yellMelt					= mod:NewYell(155223)
local specWarnCauterizeWounds	= mod:NewSpecialWarningInterrupt(155186, "-Healer")
local specWarnPyroclasm			= mod:NewSpecialWarningInterrupt(156937, false)
local specVolatileFire			= mod:NewSpecialWarningMoveAway(176121)
local yellVolatileFire			= mod:NewYell(176121)
--local specWarnSlagElemental		= mod:NewSpecialWarningSwitch("ej9657", "Dps")-- is really needed in mythic? needs review (Slay Elemental, 176143)
local specWarnShieldsDown		= mod:NewSpecialWarningSwitch("ej9655", "Dps")
local specWarnEarthShield		= mod:NewSpecialWarningDispel(155173, "MagicDispeller")
local specWarnSlagPool			= mod:NewSpecialWarningMove(155743)
--Phase 3
local specWarnHeartoftheMountain= mod:NewSpecialWarningSwitch("ej10808", "Tank")
local specWarnHeat				= mod:NewSpecialWarningStack(155242, nil, 3, nil, nil, nil, nil, 2)
local specWarnHeatOther			= mod:NewSpecialWarningTaunt(155242, nil, nil, nil, nil, nil, 2)
--All
local specWarnBlast				= mod:NewSpecialWarningSoon(155209, nil, nil, nil, 2)

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerBomb					= mod:NewBuffFadesTimer(15, 155192)
local timerBlastCD				= mod:NewCDTimer(25, 155209)--25 seconds base. shorter when loading is being channeled by operators.
local timerRuptureCD			= mod:NewCDTimer(20, 156934)
local timerEngineer				= mod:NewNextCountTimer(41, "ej9649", nil, nil, nil, 155179)
local timerBellowsOperator		= mod:NewCDCountTimer(59, "ej9650", nil, nil, nil, 155181)--60-65second variation for sure
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerVolatileFire			= mod:NewBuffFadesTimer(8, 176121)
local timerShieldsDown			= mod:NewBuffActiveTimer(30, 158345, nil, "Dps")
local timerSlagElemental		= mod:NewNextCountTimer(55, "ej9657", nil, "-Tank", nil, 155196)--Definitely 55 seconds, although current detection method may make it appear 1-2 seconds if slag has to run across room before casting first fixate
local timerFireCaller			= mod:NewNextCountTimer(45, "ej9659", nil, "Tank", nil, 156937)
local timerSecurityGuard		= mod:NewNextCountTimer(40, "ej9648", nil, "Tank", nil, 160379)

local berserkTimer				= mod:NewBerserkTimer(780)

local countdownBlast			= mod:NewCountdown("OptionVersion2", 30, 155209, false)
local countdownEngineer			= mod:NewCountdown("OptionVersion2", "AltTwo41", "ej9649", "Tank")
--Phase 2 countdowns, no conflict with phase 1 countdowns
local countdownFireCaller		= mod:NewCountdown("AltTwo64", "ej9659", "Tank")
local countdownSecurityGuard	= mod:NewCountdown("Alt41", "ej9648", "Tank")
local countdownVolatileFire		= mod:NewCountdownFades(8, 176121)

local voicePhaseChange			= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRepair				= mod:NewVoice(155179, "-Healer") --int
local voiceBomb 				= mod:NewVoice(155192) --bombyou.ogg, bomb on you
local voiceBellowsOperator 		= mod:NewVoice("ej9650", "-Healer")
local voiceRupture				= mod:NewVoice(156932) --runaway
local voiceMelt					= mod:NewVoice(155223) --runaway
local voiceSlagPool				= mod:NewVoice(155743) --runaway
local voiceHeat					= mod:NewVoice(155242) --changemt
local voiceVolatileFire			= mod:NewVoice(176121) --runout
local voiceSlagElemental		= mod:NewVoice("ej9657", "-Tank")
local voiceFireCaller			= mod:NewVoice("ej9659", "Tank")
local voiceSecurityGuard		= mod:NewVoice("ej9648", "Tank")
local voiceEngineer				= mod:NewVoice("ej9649", "Tank")

mod:AddRangeFrameOption(8)
mod:AddBoolOption("InfoFrame")
mod:AddSetIconOption("SetIconOnFixate", 155196, false)
mod:AddHudMapOption("HudMapOnBomb", 155192, false)
mod:AddDropdownOption("VFYellType", {"Countdown", "Apply"}, "Countdown", "misc")

mod.vb.machinesDead = 0
mod.vb.elementalistsRemaining = 4
mod.vb.blastWarned = false
mod.vb.shieldDown = 0
mod.vb.lastTotal = 29
mod.vb.phase = 1
mod.vb.slagCount = 0
mod.vb.fireCaller = 0
mod.vb.securityGuard = 0
mod.vb.engineer = 0
mod.vb.lastSlagIcon = 0
mod.vb.bellowsOperator = 0
mod.vb.secondSlagSpawned = false
local activeSlagGUIDS = {}
local activePrimalGUIDS = {}
local activePrimal = 0 -- health report variable. no sync
local prevHealth = 100
local yellVolatileFire2 = mod:NewFadesYell(176121, nil, true, false)
local UnitDebuff, UnitHealth, UnitHealthMax, GetTime, mceil = UnitDebuff, UnitHealth, UnitHealthMax, GetTime, math.ceil

local BombFilter, VolatileFilter
do
	local Bomb = GetSpellInfo(155192)
	local VolatileFire = GetSpellInfo(176121)
	BombFilter = function(uId)
		return UnitDebuff(uId, Bomb)
	end
	VolatileFilter = function(uId)
		return UnitDebuff(uId, VolatileFire)
	end
end

local lines = {}
local function sortInfoFrame(a, b) 
	local a = lines[a]
	local b = lines[b]
	if not tonumber(a) then a = -1 end
	if not tonumber(b) then b = -1 end
	if a > b then return true else return false end
end

local function updateInfoFrame()
	table.wipe(lines)
	local boss3bombsNeeded, boss4bombsNeeded
	if UnitExists("boss3") then
		boss3bombsNeeded = mceil(UnitHealth("boss3")/100000)
		lines[L.Regulator:format(1)] = L.bombNeeded:format(boss3bombsNeeded)
	end
	if UnitExists("boss4") then
		boss4bombsNeeded = mceil(UnitHealth("boss4")/100000)
		lines[L.Regulator:format(2)] = L.bombNeeded:format(boss4bombsNeeded)
	end
	return lines
end

--Note: only thing that's still different in each mode
local function Engineers(self)
	self.vb.engineer = self.vb.engineer + 1
	local count = self.vb.engineer
	warnEngineer:Show(count)
	voiceEngineer:Play("ej9649")
	if count < 12 then
		voiceEngineer:Schedule(1.5, nil, "Interface\\AddOns\\DBM-VP"..DBM.Options.ChosenVoicePack.."\\count\\"..count..".ogg")
	end
	if self:IsDifficulty("mythic", "normal") then
		timerEngineer:Start(35, count+1)
		self:Schedule(35, Engineers, self)
		countdownEngineer:Start(35)
	elseif self:IsHeroic() then
		timerEngineer:Start(40.5, count+1)
		self:Schedule(40.5, Engineers, self)
		countdownEngineer:Start(40.5)
	end
end

local function SecurityGuard(self)
	self.vb.securityGuard = self.vb.securityGuard + 1
	local count = self.vb.securityGuard
	warnSecurityGuard:Show(count)
	voiceSecurityGuard:Play("ej9648")
	if count < 12 then
		voiceSecurityGuard:Schedule(1.5, nil, "Interface\\AddOns\\DBM-VP"..DBM.Options.ChosenVoicePack.."\\count\\"..count..".ogg")
	end
	if self.vb.phase == 1 then
		timerSecurityGuard:Start(30.5, count+1)
		countdownSecurityGuard:Start(30.5)
		self:Schedule(30.5, SecurityGuard, self)
	else
		timerSecurityGuard:Start(40, count+1)
		countdownSecurityGuard:Start(40)
		self:Schedule(40, SecurityGuard, self)
	end
end

local function FireCaller(self)
	self.vb.fireCaller = self.vb.fireCaller + 1
	local count = self.vb.fireCaller
	warnFireCaller:Show(count)
	voiceFireCaller:Play("ej9659")
	if count < 12 then
		voiceFireCaller:Schedule(1.5, nil, "Interface\\AddOns\\DBM-VP"..DBM.Options.ChosenVoicePack.."\\count\\"..count..".ogg")
	end
	timerFireCaller:Start(45, count+1)
	self:Schedule(45, FireCaller, self)
end

local function checkSecondSlag(self)
	if not self.vb.secondSlagSpawned then
		timerSlagElemental:Start(15, self.vb.slagCount+1)
	end
end

function mod:CustomHealthUpdate()
	local health
	local total = 0
	local maxh = 0
	if self.vb.phase == 1 then
		for i = 1, 5 do
			local uid = "boss"..i
			local cid = self:GetUnitCreatureId(uid)
			if cid == 76808 then
				total = total + UnitHealth(uid)
				maxh = UnitHealthMax(uid)
			end
		end
		if maxh > 0 then
			health = (total / (maxh * 2) * 100)
			prevHealth = health
		else
			health = prevHealth
		end
		return ("%d%%"):format(health)
	elseif self.vb.phase == 2 then
		for i = 1, 5 do
			local uid = "boss"..i
			local cid = self:GetUnitCreatureId(uid)
			if cid == 76815 then
				total = total + UnitHealth(uid)
				maxh = UnitHealthMax(uid)
			end
		end
		if activePrimal > 0 and maxh > 0 then
			health = (total / (maxh * activePrimal) * 100)
			prevHealth = health
		else
			health = prevHealth
		end
		return ("%d%%"):format(health)
	elseif self.vb.phase == 3 then
		if UnitHealthMax("boss1") > 0 then
			health = (UnitHealth("boss1") / UnitHealthMax("boss1") * 100)
			prevHealth = health
		else
			health = prevHealth
		end
		return ("%d%%"):format(health)
	end
	return DBM_CORE_UNKNOWN
end

function mod:OnCombatStart(delay)
	table.wipe(activeSlagGUIDS)
	table.wipe(activePrimalGUIDS)
	prevHealth = 100
	self.vb.machinesDead = 0
	self.vb.elementalistsRemaining = 4
	self.vb.blastWarned = false
	self.vb.shieldDown = 0
	self.vb.phase = 1
	self.vb.slagCount = 0
	self.vb.fireCaller = 0
	self.vb.securityGuard = 1--First one on pull
	self.vb.engineer = 1--First one on pull
	self.vb.lastSlagIcon = 0
	self.vb.bellowsOperator = 1--First one on pull
	local firstTimer = self:IsMythic() and 40 or self:IsHeroic() and 55.5 or 60
	if self:AntiSpam(10, 0) then--Need to ignore loading on the pull
		timerBellowsOperator:Start(firstTimer, 2)
	end
	local blastTimer = self:IsMythic() and 24 or 29
	self.vb.lastTotal = blastTimer
	timerBlastCD:Start(blastTimer)
	countdownBlast:Start(blastTimer)
	if not self:IsLFR() then
		self:Schedule(firstTimer, SecurityGuard, self)
		self:Schedule(firstTimer, Engineers, self)
		timerSecurityGuard:Start(firstTimer, 2)
		countdownSecurityGuard:Start(firstTimer)
		timerEngineer:Start(firstTimer, 2)
		countdownEngineer:Start(firstTimer)
		berserkTimer:Start(-delay)
	end
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		self:Schedule(1, function()
			for i = 1, 5 do
				local uid = "boss"..i
				local guid = UnitGUID(uid)
				local cid = self:GetCIDFromGUID(guid)
				if cid == 76808 then
					DBM.BossHealth:AddBoss(guid)
				end
			end
		end)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(2, "function", updateInfoFrame, sortInfoFrame)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBomb then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155186 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnCauterizeWounds:Show(args.sourceName)
	elseif spellId == 156937 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnPyroclasm:Show(args.sourceName)
	elseif spellId == 177756 and self:CheckTankDistance(args.sourceGUID, 40) and self:AntiSpam(3.5, 7) then
		specWarnDeafeningRoar:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155179 and self:CheckTankDistance(args.sourceGUID, 40) then--Blizz seems to updated encounter code so they now run to nearest regulator instead of lowest health one.
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 174726 and self:CheckTankDistance(args.sourceGUID, 40) and self:AntiSpam(2, 4) and self.vb.phase == 1 then
		warnDropBombs:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(155192, 174716, 159558) then
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires = UnitDebuff(uId, args.spellName)
		local debuffTime = expires - GetTime()
		if self:CheckTankDistance(args.sourceGUID, 40) and self.vb.phase == 1 then--Filter Works very poorly, probably because mob not a BOSS id. usually see ALL warnings and all HUDs :\
			warnBomb:CombinedShow(1, args.destName)
			if self.Options.HudMapOnBomb then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(155192, "highlight", args.destName, 5, debuffTime+0.5, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
			end
		end
		if args:IsPlayer() then
			timerBomb:Start(debuffTime)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8, nil, nil, nil, nil, debuffTime + 0.5)
			end
			if self:AntiSpam(2, 6) then
				specWarnBomb:Show(L.heatRegulator)
				voiceBomb:Play("bombrun")
			end
		end
		if self.Options.RangeFrame and not UnitDebuff("player", args.spellName) then
			DBM.RangeCheck:Show(8, BombFilter, nil, nil, nil, debuffTime + 0.5)
		end
	elseif spellId == 155196 then
		if not activeSlagGUIDS[args.sourceGUID] then
			activeSlagGUIDS[args.sourceGUID] = true
			self.vb.slagCount = self.vb.slagCount + 1
			--6.1 Heroic https://www.warcraftlogs.com/reports/XgB24JpF8VQmGLA3#fight=8&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+155196 (2nd is 55)
			--6.1 Normal https://www.warcraftlogs.com/reports/1ftLca9GDm6qXnA2#fight=3&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+155196 (2nd is 55)
			--6.1 Mythic https://www.warcraftlogs.com/reports/HnwFRXyG9rb4CtNm#fight=1&type=summary&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+155196 (2nd is 55)
			--6.1 Mythic https://www.warcraftlogs.com/reports/h74Rp2TxCkb1AjW6#fight=10&type=summary&view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+155196 (2nd is 35)
			--All logs i reviewed, 2nd elemental is mostly 55-60 after first regardless of difficulty
			--But sometimes, for reason cannot find, it's 35 instead
			--So in all modes, start 35 second timer
			--Schedule 40 second check, if no 2nd slag by 40 seconds, start 15 second timer for remainder because 2nd will be 55
			local count = self.vb.slagCount
			if count == 1 then
				timerSlagElemental:Start(35, count+1)
				self:Schedule(40, checkSecondSlag, self)
			elseif count == 2 then
				self.vb.secondSlagSpawned = true
				timerSlagElemental:Start(nil, count+1)
			else
				timerSlagElemental:Start(nil, count+1)
			end
			voiceSlagElemental:Play("ej9657")
			if count < 12 then
				voiceSlagElemental:Schedule(1.5, nil, "Interface\\AddOns\\DBM-VP"..DBM.Options.ChosenVoicePack.."\\count\\"..count..".ogg")
			end
		end
		if self.vb.phase == 2 then
			warnFixate:CombinedShow(0.5, args.destName)
			if args:IsPlayer() then
				specWarnFixate:Show()
			end
			--Update icon number even if option not enabled, so recoveryable in case person with option DCs
			if self.vb.lastSlagIcon == 6 then--1-6 should be more than enough before reset. Do not want to use skull or x since probably set on kill targets
				self.vb.lastSlagIcon = 0
			end
			self.vb.lastSlagIcon = self.vb.lastSlagIcon + 1
			if self.Options.SetIconOnFixate then
				self:SetIcon(args.destName, self.vb.lastSlagIcon)
			end
			if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 155196)
			end
		end
	elseif spellId == 158345 and self:AntiSpam(10, 3) then--Might be SPELL_CAST_SUCCESS instead.
		self.vb.shieldDown = self.vb.shieldDown + 1
		specWarnShieldsDown:Show()
		if self:IsDifficulty("normal") then--40 seconds on normal
			timerShieldsDown:Start(40, args.destGUID)
		elseif self:IsHeroic() then
			timerShieldsDown:Start(nil, args.destGUID)--30 in heroic
		else
			timerShieldsDown:Start(20, args.destGUID)
		end
	elseif spellId == 155242 then
		local amount = args.amount or 1
		warnHeat:Show(args.destName, amount)
		if amount >= 3 then
			voiceHeat:Play("changemt")
			if args:IsPlayer() then
				specWarnHeat:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155242)) and not UnitIsDeadOrGhost("player") then
					specWarnHeatOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155181 and self:AntiSpam(10, 0) then--Loading (The two that come can be upwards of 5 seconds apart so at least 10 second antispam)
		self.vb.bellowsOperator = self.vb.bellowsOperator + 1
		specWarnBellowsOperator:Show()
		timerBellowsOperator:Start(nil, self.vb.bellowsOperator+1)
		voiceBellowsOperator:Play("killmob")
	elseif spellId == 176121 then
		warnVolatileFire:CombinedShow(1, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)
		if expires then
			local debuffTime = expires - GetTime()
			if args:IsPlayer() then
				timerVolatileFire:Start(debuffTime)
				specVolatileFire:Show()
				if not self:IsLFR() and self.Options.Yell176121 then
					if self:IsMythic() and self.Options.VFYellType == "Countdown" then
						yellVolatileFire2:Schedule(debuffTime - 1, 1)
						yellVolatileFire2:Schedule(debuffTime - 2, 2)
						yellVolatileFire2:Schedule(debuffTime - 3, 3)
						yellVolatileFire2:Schedule(debuffTime - 5, 5)
					else
						yellVolatileFire:Yell()
					end
				end
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(8, nil, nil, nil, nil, debuffTime + 0.5)
				end
				countdownVolatileFire:Start(debuffTime)
				voiceVolatileFire:Schedule(debuffTime - 4, "runout")
			end
			if self.Options.RangeFrame and not UnitDebuff("player", args.spellName) then
				DBM.RangeCheck:Show(8, VolatileFilter, nil, nil, nil, debuffTime + 0.5)
			end
		end
	elseif spellId == 155225 then
		warnMelt:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMeltYou:Show()
			yellMelt:Schedule(5)--yell after 5 sec to warn nearby player (aoe actually after 6 sec). like expel magic: fel
			voiceMelt:Play("runout")
		elseif self:CheckNearby(8, args.destName) then
			specWarnMeltNear:Show()
		end
	elseif spellId == 156934 then
		--Increase to 50 should fix any rare issues not get timer if on same area as boss.
		if self:CheckTankDistance(args.sourceGUID, 50) then
			warnRupture:CombinedShow(0.5, args.destName)
			timerRuptureCD:Start()
		end
		--Always warn player, always.
		if args:IsPlayer() then
			specWarnRuptureOn:Show()
			yellRupture:Schedule(4)--yell after 4 sec to warn nearby player (aoe actually after 5 sec).  like expel magic: fel
			voiceRupture:Play("runout")
		end
	elseif spellId == 155173 and args:IsDestTypeHostile() and self.vb.shieldDown > 0 then
		specWarnEarthShield:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(155192, 174716, 159558) then
		if self.Options.HudMapOnBomb then
			DBMHudMap:FreeEncounterMarkerByTarget(155192, args.destName)
		end
		if args:IsPlayer() then
			timerBomb:Cancel()
		end
	elseif spellId == 176121 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 155196 and self.Options.SetIconOnFixate then
		self:SetIcon(args.destName, 0)
	elseif spellId == 158345 then
		self.vb.shieldDown = self.vb.shieldDown - 1
		timerShieldsDown:Cancel(args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 156932 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnRupture:Show()
		voiceRupture:Play("runaway")
	elseif spellId == 155223 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnMelt:Show()
		voiceMelt:Play("runaway")
	elseif spellId == 155743 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnSlagPool:Show()
		voiceSlagPool:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76815 then--Elementalist
		self.vb.elementalistsRemaining = self.vb.elementalistsRemaining - 1
		if self.vb.elementalistsRemaining > 0 then
			warnElementalists:Show(self.vb.elementalistsRemaining)
		else
			timerFireCaller:Cancel()
			timerSecurityGuard:Cancel()
			countdownSecurityGuard:Cancel()
			timerSlagElemental:Cancel()
			self:Unschedule(SecurityGuard)
			self:Unschedule(FireCaller)
			self.vb.phase = 3
			prevHealth = 100
			self:UnregisterShortTermEvents()
			warnPhase3:Show()
			specWarnHeartoftheMountain:Show()
			voicePhaseChange:Play("pthree")
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:Clear()
				DBM.BossHealth:AddBoss(76806)
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
		end
	elseif cid == 76808 then--Regulators
		self.vb.machinesDead = self.vb.machinesDead + 1
		if self.vb.machinesDead == 2 then
			self.vb.phase = 2
			self.vb.secondSlagSpawned = false
			activePrimal = 0
			self.vb.securityGuard = 0
			prevHealth = 100
			warnPhase2:Show()
			self:Unschedule(Engineers)
			timerEngineer:Cancel()
			countdownEngineer:Cancel()
			timerBellowsOperator:Cancel()
			timerSecurityGuard:Cancel()
			countdownSecurityGuard:Cancel()
			self:Unschedule(SecurityGuard)
			voicePhaseChange:Play("ptwo")
			--Start adds timers. Seem same in all modes.
			if not self:IsLFR() then-- LFR do not have Slag Elemental.
				timerSlagElemental:Start(13, 1)
				self:Schedule(72, SecurityGuard, self)
				timerSecurityGuard:Start(72, 1)
				countdownSecurityGuard:Start(72)
				self:Schedule(76.5, FireCaller, self)
				timerFireCaller:Start(76.5, 1)
			end
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:Clear()
			end
			self:RegisterShortTermEvents(
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
			)
			if self.Options.HudMapOnBomb then
				DBMHudMap:Disable()
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
		else--Only announce 1 remaining. 0 remaining not needed, because have phase2 warn. double warn no good
			warnRegulators:Show(2 - self.vb.machinesDead)
		end
	elseif cid == 76809 then
		timerRuptureCD:Cancel()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if not DBM.BossHealth:IsShown() then return end
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		local cid = self:GetCIDFromGUID(unitGUID)
		if self.vb.phase == 2 and cid == 76815 and UnitExists(unitID) and not activePrimalGUIDS[unitGUID] then
			activePrimal = activePrimal + 1
			activePrimalGUIDS[unitGUID] = true
			DBM.BossHealth:AddBoss(unitGUID)
		end
	end
end

do
	local totalTime = mod:IsMythic() and 24 or 29
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId, type)
		if type == "ALTERNATE" then
			totalTime = self:IsMythic() and 24 or 29
			local altPower = UnitPower(uId, 10)
			--Each time boss breaks energy increments of 25. CD is reduced
			if altPower == 100 then
				totalTime = self:IsMythic() and 5 or 5.5--5-6
			elseif altPower > 74 then
				totalTime = self:IsMythic() and 8 or 9--9-10
			elseif altPower > 49 then
				totalTime = self:IsMythic() and 12.5 or 15--15-16
			elseif altPower > 24 then
				totalTime = self:IsMythic() and 18.3 or 19.5
			end
			local powerRate = 100 / totalTime
			if self.vb.lastTotal ~= totalTime then--CD changed
				if self:AntiSpam(5, 8) and totalTime < self.vb.lastTotal then
					warnBlastFrequency:Show(totalTime)
				end
				self.vb.lastTotal = totalTime
				local bossPower = UnitPower("boss1") --Get Boss Power
				local elapsed = bossPower / powerRate
				timerBlastCD:Update(elapsed, totalTime)
				countdownBlast:Cancel()
				countdownBlast:Start(totalTime-elapsed)
			end
		else
			local bossPower = UnitPower("boss1") --Get Boss Power
			if bossPower >= 85 and not self.vb.blastWarned then
				self.vb.blastWarned = true
				if totalTime > 10 then
					specWarnBlast:Show()
				end
			elseif bossPower < 5 and self.vb.blastWarned then--Should catch 0, if not, at least 1-4 will fire it but then timer may be a second or so off
				self.vb.blastWarned = false
				timerBlastCD:Start(totalTime)
				countdownBlast:Start(totalTime)
			end
		end
	end
end
