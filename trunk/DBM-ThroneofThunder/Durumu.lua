local mod	= DBM:NewMod(818, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68036)--Crimson Fog 69050, 
mod:SetQuestID(32750)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISS",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED",
	"UNIT_AURA",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnHardStare					= mod:NewSpellAnnounce(133765, 3, nil, mod:IsTank() or mod:IsHealer())--Announce CAST not debuff, cause it misses a lot, plus we have 1 sec to hit an active mitigation
local warnForceOfWill				= mod:NewTargetAnnounce(136413, 4)
local warnLingeringGaze				= mod:NewTargetAnnounce(138467, 3)
mod:AddBoolOption("warnBeam", nil, "announce")
local warnBeamNormal				= mod:NewAnnounce("warnBeamNormal", 4, 139204, true, false)
local warnBeamHeroic				= mod:NewAnnounce("warnBeamHeroic", 4, 139204, true, false)
local warnAddsLeft					= mod:NewAnnounce("warnAddsLeft", 2, 134123)
local warnDisintegrationBeam		= mod:NewSpellAnnounce("ej6882", 4)
local warnLifeDrain					= mod:NewTargetAnnounce(133795, 3)--Some times needs to block this even dps. So warn for everyone.
local warnDarkParasite				= mod:NewTargetAnnounce(133597, 3, nil, mod:IsHealer())--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3, 111231)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, mod:IsTank(), 5)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTarget(133767, mod:IsTank())
local specWarnForceOfWill			= mod:NewSpecialWarningYou(136413, nil, nil, nil, 3)--VERY important, if you get hit by this you are out of fight for rest of pull.
local specWarnForceOfWillNear		= mod:NewSpecialWarningClose(136413, nil, nil, nil, 3)
local yellForceOfWill				= mod:NewYell(136413)
local specWarnLingeringGaze			= mod:NewSpecialWarningYou(134044)
local yellLingeringGaze				= mod:NewYell(134044, nil, false)
local specWarnLingeringGazeMove		= mod:NewSpecialWarningMove(134044)
local specWarnBlueBeam				= mod:NewSpecialWarning("specWarnBlueBeam", nil, nil, nil, 3)
local specWarnBlueBeamLFR			= mod:NewSpecialWarningYou(139202, true, false)
local specWarnRedBeam				= mod:NewSpecialWarningYou(139204, nil, nil, nil, 3)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(133738, nil, nil, nil, 3)
local specWarnFogRevealed			= mod:NewSpecialWarning("specWarnFogRevealed", nil, nil, nil, 2)--Use another "Be Aware!" sound because Lingering Gaze comes on Spectrum phase.
local specWarnDisintegrationBeam	= mod:NewSpecialWarningSpell("ej6882", nil, nil, nil, 2)
local specWarnEyeSore				= mod:NewSpecialWarningMove(140502)
local specWarnLifeDrain				= mod:NewSpecialWarningTarget(133795, mod:IsTank())
local yellLifeDrain					= mod:NewYell(133795, L.LifeYell)

local timerHardStareCD				= mod:NewCDTimer(12, 133765, mod:IsTank() or mod:IsHealer())
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(46, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewNextTimer(60, "ej6891")
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(55, "ej6882")
local timerDisintegrationBeamCD		= mod:NewNextTimer(136, "ej6882")
local timerLifeDrainCD				= mod:NewCDTimer(40, 133795)
local timerLifeDrain				= mod:NewBuffActiveTimer(18, 133795)
local timerIceWallCD				= mod:NewNextTimer(120, 134587, nil, nil, nil, 111231)
local timerDarkParasiteCD			= mod:NewCDTimer(60.5, 133597, mod:IsHealer())--Heroic 60-62. (the timer is tricky and looks far more variable but it really isn't, it just doesn't get to utilize it's true cd timer more than twice per fight)
local timerDarkParasite				= mod:NewTargetTimer(30, 133597, mod:IsHealer())--Only healer/dispeler needs to know this.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598)--EVERYONE needs to know this, if dispeler messed up and dispelled parasite too early you're going to get a new add every 3 seconds for remaining duration of this bar.
local timerObliterateCD				= mod:NewNextTimer(80, 137747)--Heroic

local soundLingeringGaze			= mod:NewSound(134044)
local countdownLightSpectrum		= mod:NewCountdown(60, "ej6891")

local berserkTimer					= mod:NewBerserkTimer(600)

--mod:AddBoolOption("ArrowOnBeam", true)
mod:AddBoolOption("SetIconRays", true)
mod:AddBoolOption("SetIconLifeDrain", true)
mod:AddBoolOption("InfoFrame", true) -- may be need special warning or generic warning high stack player? or do not needed at all?
mod:AddBoolOption("SetIconOnParasite", false)
mod:AddBoolOption("SetParticle", true)

local totalFogs = 3
local lingeringGazeTargets = {}
local lingeringGazeCD = 46
local darkParasiteTargets = {}
local darkParasiteTargetsIcons = {}
local lastRed = nil
local lastBlue = nil
local lastYellow = nil
local spectrumStarted = false
local lifeDrained = false
local lfrCrimsonFogRevealed = false
local lfrAmberFogRevealed = false
local lfrAzureFogRevealed = false
local lfrEngaged = false
local blueTracking = GetSpellInfo(139202)
local redTracking = GetSpellInfo(139204)
local crimsonFog = EJ_GetSectionInfo(6892)
local amberFog = EJ_GetSectionInfo(6895)
local azureFog = EJ_GetSectionInfo(6898)
local playerName = UnitName("player")
local firstIcewall = false
local CVAR = nil

local function warnLingeringGazeTargets()
	warnLingeringGaze:Show(table.concat(lingeringGazeTargets, "<, >"))
	table.wipe(lingeringGazeTargets)
end

local function warnDarkParasiteTargets()
	warnDarkParasite:Show(table.concat(darkParasiteTargets, "<, >"))
	if not lifeDrained then--Only time spell ever gets to use it's true 60 second cd without one of the two failsafes altering it. very first phase
		timerDarkParasiteCD:Start()
	end
	table.wipe(darkParasiteTargets)
end

local function warnBeam()
	if mod:IsDifficulty("heroic10", "heroic25", "lfr25") then
		warnBeamHeroic:Show(lastRed, lastBlue, lastYellow)
	else
		warnBeamNormal:Show(lastRed, lastBlue)
	end
end

local function BeamEnded()
--[[	if mod.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end--]]
	timerLingeringGazeCD:Start(17)
	timerForceOfWillCD:Start(19)
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerDarkParasiteCD:Start(10)
		timerIceWallCD:Start(32)
		firstIcewall = true
	end
	if mod:IsDifficulty("lfr25") then
		timerLightSpectrumCD:Start(66)
		countdownLightSpectrum:Start(66)
		timerDisintegrationBeamCD:Start(186)
	else
		timerLightSpectrumCD:Start(39)
		countdownLightSpectrum:Start(39)
		timerDisintegrationBeamCD:Start()
	end
end

local function HideInfoFrame()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnCombatStart(delay)
	lingeringGazeCD = 46
	lastRed = nil
	lastBlue = nil
	lastYellow = nil
	spectrumStarted = false
	lifeDrained = false
	lfrCrimsonFogRevealed = false
	lfrAmberFogRevealed = false
	lfrAzureFogRevealed = false
	CVAR = nil
	table.wipe(lingeringGazeTargets)
	table.wipe(darkParasiteTargets)
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(33.5-delay)
	timerLightSpectrumCD:Start(40-delay)
	countdownLightSpectrum:Start(40-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDarkParasiteCD:Start(-delay)
		timerIceWallCD:Start(127-delay)
		firstIcewall = false--On pull, we only get one icewall and the CD behavior of parasite unaltered so we make sure to treat first icewall like a 2nd
	end
	if self:IsDifficulty("lfr25") then
		lfrEngaged = true
		timerLifeDrainCD:Start(151)
		timerDisintegrationBeamCD:Start(161-delay)
	else
		timerDisintegrationBeamCD:Start(135-delay)
	end
	berserkTimer:Start(-delay)
	if self.Options.SetParticle and GetCVar("particleDensity") then
		CVAR = GetCVar("particleDensity")--Cvar was true on pull so we remember that.
		SetCVar("particleDensity", 10)
	end
end

function mod:OnCombatEnd()
--[[	if self.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end--]]
	lfrEngaged = false
	if self.Options.SetIconRays and lastRed then
		self:SetIcon(lastRed, 0)
	end
	if self.Options.SetIconRays and lastBlue then
		self:SetIcon(lastBlue, 0)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if CVAR then--CVAR was set on pull which means we changed it, cahnge it back
		SetCVar("particleDensity", CVAR)
	end
end

local function ClearParasiteTargets()
	table.wipe(darkParasiteTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetParasiteIcons()
		table.sort(darkParasiteTargetsIcons, sort_by_group)
		local parasiteIcon = 5
		for i, v in ipairs(darkParasiteTargetsIcons) do
			-- DBM:SetIcon() is used because of follow reasons
			--1. It checks to make sure you're on latest dbm version, if you are not, it disables icon setting so you don't screw up icons (ie example, a newer version of mod does icons differently)
			--2. It checks global dbm option "DontSetIcons"
			self:SetIcon(v, parasiteIcon)
			parasiteIcon = parasiteIcon - 1
		end
		self:Schedule(1.5, ClearParasiteTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133765 then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif args.spellId == 138467 then
		timerLingeringGazeCD:Start(lingeringGazeCD)
	elseif args.spellId == 136154 and self:IsDifficulty("lfr25") and not lfrCrimsonFogRevealed then--Only use in lfr.
		lfrCrimsonFogRevealed = true
		specWarnFogRevealed:Show(crimsonFog)
	elseif args.spellId == 134587 and self:AntiSpam(3, 3) then
		warnIceWall:Show()
		if firstIcewall then--if it's first icewall of a two icewall phase, it alters CD of dark parasite to be 50 seconds after this cast (thus preventing it from ever being a 60 second cd between casts for rest of fight do to beam and ice altering it)
			firstIcewall = false
			timerDarkParasiteCD:Start(50)--50-52.5
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 136932 then--Force of Will Precast
		warnForceOfWill:Show(args.destName)
		if timerLightSpectrumCD:GetTime() > 22 or timerDisintegrationBeamCD:GetTime() > 110 then--Don't start timer if either beam or spectrum will come first (cause both disable force ability)
			timerForceOfWillCD:Start()
		end
		if args:IsPlayer() then
			specWarnForceOfWill:Show()
			yellForceOfWill:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 21 then--Range hard to get perfect, a player 30 yards away might still be in it. I say 15 is probably good middle ground to catch most of the "near"
					specWarnForceOfWillNear:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 134122 then--Blue Beam Precas
		lingeringGazeCD = not spectrumStarted and 25 or 40 -- First spectrum Lingering Gaze CD = 25, second = 40
		spectrumStarted = true
		lastBlue = args.destName
		if args:IsPlayer() then
			if self:IsDifficulty("lfr25") and self.Options.specWarnBlueBeam then
				specWarnBlueBeamLFR:Show()
			else
				specWarnBlueBeam:Show()
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 6)--Square
		end
		self:Schedule(0.5, warnBeam)
	elseif args.spellId == 134123 then--Red Beam Precast
		lastRed = args.destName
		if args:IsPlayer() then
			specWarnRedBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 7)--Cross
		end
	elseif args.spellId == 134124 then--Yellow Beam Precast
		lastYellow = args.destName
		totalFogs = 3
		lfrCrimsonFogRevealed = false
		lfrAmberFogRevealed = false
		lfrAzureFogRevealed = false
		timerForceOfWillCD:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerObliterateCD:Start()
			if lifeDrained then -- Check 1st Beam ended.
				timerIceWallCD:Start(88.5)
			end
		end
		if self:IsDifficulty("heroic10", "heroic25", "lfr25") then
			if args:IsPlayer() then
				specWarnYellowBeam:Show()
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 1, 10)--Star (auto remove after 10 seconds because this beam untethers one initial person positions it.
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Start(args.destName)
		if (args.amount or 1) >= 5 then
			if args:IsPlayer() then
				specWarnSeriousWound:Show(args.amount)
			else
				if not UnitDebuff("player", GetSpellInfo(133767)) and not UnitIsDeadOrGhost("player") then
					specWarnSeriousWoundOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 133597 and not args:IsDestTypeHostile() then--Dark Parasite (filtering the wierd casts they put on themselves periodicly using same spellid that don't interest us and would mess up cooldowns)
		darkParasiteTargets[#darkParasiteTargets + 1] = args.destName
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration, args.destName)
		self:Unschedule(warnDarkParasiteTargets)
		if #darkParasiteTargets >= 3 and self:IsDifficulty("heroic25") or self:IsDifficulty("heroic10") then
			warnDarkParasiteTargets()
		else
			self:Schedule(0.5, warnDarkParasiteTargets)
		end
		if self.Options.SetIconOnParasite and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(darkParasiteTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetParasiteIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				if #darkParasiteTargetsIcons >= 3 and self:IsDifficulty("heroic25") or self:IsDifficulty("heroic10") then
					self:SetParasiteIcons()
				else
					self:ScheduleMethod(0.5, "SetParasiteIcons")
				end
			end
		end
	elseif args.spellId == 133598 then--Dark Plague
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration, args.destName)
	elseif args.spellId == 134626 then
		lingeringGazeTargets[#lingeringGazeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnLingeringGaze:Show()
			yellLingeringGaze:Yell()
			soundLingeringGaze:Play()
		end
		self:Unschedule(warnLingeringGazeTargets)
		if #lingeringGazeTargets >= 5 and self:IsDifficulty("normal25", "heroic25") or #lingeringGazeTargets >= 2 and self:IsDifficulty("normal10", "heroic10") then--TODO, add LFR number of targets
			warnLingeringGazeTargets()
		else
			self:Schedule(0.5, warnLingeringGazeTargets)
		end
	elseif args.spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target. If target warning needed, insert into this block. (maybe very spammy)
		self:SetIcon(args.destName, 8)--Skull
	elseif args.spellId == 133798 and self.Options.InfoFrame then -- Force update
		DBM.InfoFrame:Update("playerdebuffstacks")
		if args:IsPlayer() and not self:IsDifficulty("lfr25") then
			yellLifeDrain:Yell(playerName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Cancel(args.destName)
	elseif args.spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target.
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 133597 then--Dark Parasite
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
	end
	if not lfrEngaged or lfrAmberFogRevealed then return end -- To reduce cpu usage normal and heroic.
	if destName == amberFog and not lfrAmberFogRevealed then -- Lfr Amger fog do not have CLEU, no unit events and no emote.
		lfrAmberFogRevealed = true
		specWarnFogRevealed:Show(amberFog)
	end
end

function mod:SPELL_MISSED(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 134755 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnEyeSore:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Blizz doesn't like combat log anymore
--Currently very bugged too so warnings aren't working right (since fight isn't working right)
--Beams wildly jump targets and don't give new target a warning at all nor does it even show in damn combat log.
function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc, _, _, target)
	if npc == crimsonFog or npc == amberFog or npc == azureFog then
		if self:IsDifficulty("lfr25") and npc == azureFog and not lfrAzureFogRevealed then
			lfrAzureFogRevealed = true
			specWarnFogRevealed:Show(npc)
		elseif not lfrAzureFogRevealed or not self:IsDifficulty("lfr25") then
			specWarnFogRevealed:Show(npc)
		end
	elseif msg:find("spell:133795") then
		local target = DBM:GetFullNameByShortName(target)
		warnLifeDrain:Show(target)
		specWarnLifeDrain:Show(target)
		timerLifeDrain:Start()
		timerLifeDrainCD:Start(not lifeDrained and 50 or nil)--first is 50, 2nd and later is 40 
		lifeDrained = true
--[[		if target == UnitName("player") then
			yellLifeDrain:Yell(target, 0)--This is pre cast, so player isn't technically at 1 stack for another 3 seconds. we want them to get at least one stack before taking beam
		end--]]
		if self.Options.SetIconLifeDrain then
			self:SetIcon(target, 8)--Skull
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(133795))
			DBM.InfoFrame:Show(5, "playerdebuffstacks", 133798)
		end
		self:Schedule(21, HideInfoFrame)
	elseif msg:find("spell:134169") then
		lingeringGazeCD = 46 -- Return to Original CD.
		timerForceOfWillCD:Cancel()
		timerLingeringGazeCD:Cancel()
		timerLifeDrainCD:Cancel()
		timerDarkParasiteCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show()
		--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger
		timerDisintegrationBeam:Start()
		self:Schedule(55, BeamEnded)
	end
end

--Because blizz sucks and these do NOT show in combat log AND the emote only fires for initial application, but not for when a player dies and beam jumps.
--Reports are this is majorly fucked up in LFR, because the antispam in name doesn't work with server names (wtf? maybe only happens if server name strip is turned on?)
--I will not be able to debug for several hours but commenting in case someone else runs LFR before I do in 5 hours
function mod:UNIT_AURA(uId)
	local name = DBM:GetUnitFullName(uId)
	if UnitDebuff(uId, blueTracking) and lastBlue ~= name then
--		print("DBM Debug - UnitName(): "..UnitName(uId))
--		print("DBM Debug - DBM:GetUnitFullName: "..DBM:GetUnitFullName(uId))
--		print("DBM Debug - lastBlue: "..lastBlue)
		lastBlue = name
		if name == UnitName("player") then
			if self:IsDifficulty("lfr25") and self.Options.specWarnBlueBeam then
				specWarnBlueBeamLFR:Show()
			else
				specWarnBlueBeam:Show()
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(name, 6)--Square
		end
	elseif UnitDebuff(uId, redTracking) and lastRed ~= name then
		lastRed = name
		if name == UnitName("player") then
			specWarnRedBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(name, 7)--Cross
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69050 then--Crimson Fog
		totalFogs = totalFogs - 1
		if totalFogs >= 1 then
			warnAddsLeft:Show(totalFogs)
		else--No adds left, force ability is re-enabled
			timerObliterateCD:Cancel()
			timerForceOfWillCD:Start(15)
			if self.Options.SetIconRays and lastRed then
				self:SetIcon(lastRed, 0)
			end
			if self.Options.SetIconRays and lastBlue then
				self:SetIcon(lastBlue, 0)
			end
			lastRed = nil
			lastBlue = nil
			lastYellow = nil
		end
	elseif cid == 69051 then--Amber Fog
		--Maybe do something for heroic here too, if timers for the crap this thing does gets added.
		if self:IsDifficulty("lfr25") then
			totalFogs = totalFogs - 1
			if totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
				end
				if self.Options.SetIconRays and lastBlue then
					self:SetIcon(lastBlue, 0)
				end
				lastRed = nil
				lastBlue = nil
				lastYellow = nil
			end
		end
	elseif cid == 69052 then--Azure Fog (endlessly respawn in all but LFR, so we ignore them dying anywhere else)
		--Maybe do something for heroic here too, if timers for the crap this thing does gets added.
		if self:IsDifficulty("lfr25") then
			totalFogs = totalFogs - 1
			if totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
				end
				if self.Options.SetIconRays and lastBlue then
					self:SetIcon(lastBlue, 0)
				end
				lastRed = nil
				lastBlue = nil
				lastYellow = nil
			end
		end
	end
end

--As of live, they removed ability to detect this thus ability to detect beam direction also gone.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 136316 and self:AntiSpam(2, 2) then--Disintegration Beam (clockwise)
--[[		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_LEFT)
		timerDisintegrationBeam:Start()
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(90)
		end
		self:Schedule(64, BeamEnded)--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger--]]
		print("DBM Debug: Clockwise beam spellid re-enabled by blizzard.")
	elseif spellId == 133775 and self:AntiSpam(2, 2) then--Disintegration Beam (counter-clockwise)
--[[		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_RIGHT)
		timerDisintegrationBeam:Start()
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(270)
		end
		self:Schedule(64, BeamEnded)--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger--]]
		print("DBM Debug: Counter-Clockwise beam spellid re-enabled by blizzard.")
	end
end
