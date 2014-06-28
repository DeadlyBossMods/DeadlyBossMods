local mod	= DBM:NewMod(818, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68036)--Crimson Fog 69050
mod:SetEncounterID(1572)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 133765 138467 136154 134587",
	"SPELL_CAST_SUCCESS 136932 134122 134123 134124 139202 139204",
	"SPELL_AURA_APPLIED 133767 133597 133598 134626 137727 133798",
	"SPELL_AURA_APPLIED_DOSE 133767 133798",
	"SPELL_AURA_REMOVED 133767 137727 133597",
	"SPELL_DAMAGE 134044",
	"SPELL_MISSED 134044",
	"SPELL_PERIODIC_DAMAGE 134755",
	"SPELL_PERIODIC_MISS 134755",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
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

local timerHardStareCD				= mod:NewCDTimer(12, 133765, nil, mod:IsTank() or mod:IsHealer())
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, nil, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(46, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewNextTimer(60, "ej6891")
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(55, "ej6882")
local timerDisintegrationBeamCD		= mod:NewNextTimer(136, "ej6882")
local timerLifeDrainCD				= mod:NewCDTimer(40, 133795)
local timerLifeDrain				= mod:NewBuffActiveTimer(18, 133795)
local timerIceWallCD				= mod:NewNextTimer(120, 134587, nil, nil, nil, 111231)
local timerDarkParasiteCD			= mod:NewCDTimer(60.5, 133597, nil, mod:IsHealer())--Heroic 60-62. (the timer is tricky and looks far more variable but it really isn't, it just doesn't get to utilize it's true cd timer more than twice per fight)
local timerDarkParasite				= mod:NewTargetTimer("OptionVersion2", 30, 133597, nil, false)--Spammy bar in 25 man not useful.
local timerDarkPlague				= mod:NewTargetTimer("OptionVersion2", 30, 133598, nil, false)--Spammy bar in 25 man not useful.
local timerObliterateCD				= mod:NewNextTimer(80, 137747)--Heroic

local soundLingeringGaze			= mod:NewSound(134044)
local countdownLightSpectrum		= mod:NewCountdown(60, "ej6891")
local countdownDisintegrationbeam	= mod:NewCountdownFades(55, "ej6882")

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconRays", true)
mod:AddBoolOption("SetIconLifeDrain", true)
mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("SetIconOnParasite", false)
mod:AddBoolOption("SetParticle", true)

local totalFogs = 3
local lingeringGazeCD = 46
local lastRed = nil
local lastBlue = nil
local lastYellow = nil
local spectrumStarted = false
local lifeDrained = false
local lfrCrimsonFogRevealed = false
local lfrAmberFogRevealed = false
local lfrAzureFogRevealed = false
local lfrEngaged = false
local crimsonFog = EJ_GetSectionInfo(6892)
local amberFog = EJ_GetSectionInfo(6895)
local azureFog = EJ_GetSectionInfo(6898)
local playerName = UnitName("player")
local firstIcewall = false
local CVAR = nil
local yellowRevealed = 0
local scanTime = 0

local function warnBeam()
	if mod:IsDifficulty("heroic10", "heroic25", "lfr25") then
		warnBeamHeroic:Show(lastRed, lastBlue, lastYellow)
	else
		warnBeamNormal:Show(lastRed, lastBlue)
	end
end

local function HideInfoFrame()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

local function BeamEnded()
	timerLingeringGazeCD:Start(17)
	timerForceOfWillCD:Start(19)
	if mod:IsHeroic() then
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

local function findBeamJump(spellName, spellId)
	scanTime = scanTime + 1
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if spellId == 139202 and UnitDebuff(uId, spellName) and lastBlue ~= name then
			lastBlue = name
			if name == UnitName("player") then
				if mod:IsDifficulty("lfr25") and mod.Options.specWarnBlueBeam then
					specWarnBlueBeamLFR:Show()
				else
					specWarnBlueBeam:Show()
				end
			end
			if mod.Options.SetIconRays then
				SetRaidTarget(uId, 6)--Square
			end
			return
		elseif spellId == 139204 and UnitDebuff(uId, spellName) and lastRed ~= name then
			lastRed = name
			if name == UnitName("player") then
				specWarnRedBeam:Show()
			end
			if mod.Options.SetIconRays then
				SetRaidTarget(uId, 7)--Cross
			end
			return
		end
	end
	if scanTime < 30 then--Scan for 3 sec but not forever.
		mod:Schedule(0.1, findBeamJump, spellName, spellId)--Check again if we didn't return from either debuff (We checked too soon)
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
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(33.5-delay)
	timerLightSpectrumCD:Start(40-delay)
	countdownLightSpectrum:Start(40-delay)
	if self:IsHeroic() then
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
	if CVAR then--CVAR was set on pull which means we changed it, change it back
		SetCVar("particleDensity", CVAR)
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 133765 then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif spellId == 138467 then
		timerLingeringGazeCD:Start(lingeringGazeCD)
	elseif spellId == 136154 and self:IsDifficulty("lfr25") and not lfrCrimsonFogRevealed then--Only use in lfr.
		lfrCrimsonFogRevealed = true
		specWarnFogRevealed:Show(crimsonFog)
	elseif spellId == 134587 and self:AntiSpam(3, 3) then
		warnIceWall:Show()
		if firstIcewall then--if it's first icewall of a two icewall phase, it alters CD of dark parasite to be 50 seconds after this cast (thus preventing it from ever being a 60 second cd between casts for rest of fight do to beam and ice altering it)
			firstIcewall = false
			timerDarkParasiteCD:Start(50)--50-52.5
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 136932 then--Force of Will Precast
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
	elseif spellId == 134122 then--Blue Beam Precas
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
		if self:IsDifficulty("lfr25") then
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE"
			)
		end
		self:Schedule(0.5, warnBeam)
	elseif spellId == 134123 then--Red Beam Precast
		lastRed = args.destName
		if args:IsPlayer() then
			specWarnRedBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 7)--Cross
		end
	elseif spellId == 134124 then--Yellow Beam Precast
		lastYellow = args.destName
		totalFogs = 3
		yellowRevealed = 0
		lfrCrimsonFogRevealed = false
		lfrAmberFogRevealed = false
		lfrAzureFogRevealed = false
		timerForceOfWillCD:Cancel()
		if self:IsHeroic() then
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
	elseif args:IsSpellID(139202, 139204) then
		--The SPELL_CAST_SUCCESS event works, it's the SPELL_AURA_APPLIED/REMOVED events that are busted/
		--SUCCESS has no target. Still have to find target with UnitDebuff checks
		scanTime = 0
		self:Schedule(0.1, findBeamJump, args.spellName, spellId)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 133767 then
		local amount = args.amount or 1
		timerSeriousWound:Start(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnSeriousWound:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(133767)) and not UnitIsDeadOrGhost("player") then
					specWarnSeriousWoundOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 133597 and not args:IsDestTypeHostile() then--Dark Parasite (filtering the wierd casts they put on themselves periodicly using same spellid that don't interest us and would mess up cooldowns)
		warnDarkParasite:CombinedShow(0.5, args.destName)
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration, args.destName)
		if not lifeDrained then--Only time spell ever gets to use it's true 60 second cd without one of the two failsafes altering it. very first phase
			timerDarkParasiteCD:DelayedStart(0.5)
		end
		if self.Options.SetIconOnParasite and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			self:SetSortedIcon(0.5, args.destName, 5, 3, true)
		end
	elseif spellId == 133598 then--Dark Plague
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration, args.destName)
	elseif spellId == 134626 then
		warnLingeringGaze:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnLingeringGaze:Show()
			yellLingeringGaze:Yell()
			soundLingeringGaze:Play()
		end
	elseif spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target. If target warning needed, insert into this block. (maybe very spammy)
		self:SetIcon(args.destName, 8)--Skull
	elseif spellId == 133798 and self.Options.InfoFrame and not self:IsDifficulty("lfr25") then -- Force update
		DBM.InfoFrame:Update()
		if args:IsPlayer() then
			yellLifeDrain:Yell(playerName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 133767 then
		timerSeriousWound:Cancel(args.destName)
	elseif spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target.
		self:SetIcon(args.destName, 0)
	elseif spellId == 133597 then--Dark Parasite
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
		self:UnregisterShortTermEvents()
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

--Blizz doesn't like combat log anymore for some spells
function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc, _, _, target)
	if (npc == crimsonFog or npc == amberFog or npc == azureFog) and self:AntiSpam(1, npc) then
		if npc == azureFog and not lfrAzureFogRevealed then
			lfrAzureFogRevealed = true--Only one in ALL modes, so might as well use this to work around the multi emote blizz bug
			specWarnFogRevealed:Show(npc)
		elseif npc == amberFog and not self:IsDifficulty("lfr25") then
			yellowRevealed = yellowRevealed + 1
			if yellowRevealed > 2 and self:AntiSpam(10, npc) or yellowRevealed < 3 then--Fix for invisible amber blizz bug (when this happens it spams emote like 20 times)
				specWarnFogRevealed:Show(npc)
			end
		elseif npc == crimsonFog and not self:IsDifficulty("lfr25") then
			specWarnFogRevealed:Show(npc)
		end
	elseif msg:find("spell:133795") then--Does show in combat log, but emote gives targetname 3 seconds earlier.
		local target = DBM:GetUnitFullName(target)
		warnLifeDrain:Show(target)
		specWarnLifeDrain:Show(target)
		timerLifeDrain:Start()
		timerLifeDrainCD:Start(not lifeDrained and 50 or nil)--first is 50, 2nd and later is 40 
		lifeDrained = true
		if self.Options.SetIconLifeDrain then
			self:SetIcon(target, 8)--Skull
		end
		if self.Options.InfoFrame and not self:IsDifficulty("lfr25") then
			DBM.InfoFrame:SetHeader(GetSpellInfo(133795))
			DBM.InfoFrame:Show(5, "playerdebuffstacks", 133798)
			self:Schedule(21, HideInfoFrame)
		end
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
		countdownDisintegrationbeam:Start()
		self:Schedule(55, BeamEnded)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69050 then--Crimson Fog
		totalFogs = totalFogs - 1
		if totalFogs >= 1 then
			warnAddsLeft:Show(totalFogs)
		else--No adds left, force ability is re-enabled
			self:Unschedule(findBeamJump)
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
