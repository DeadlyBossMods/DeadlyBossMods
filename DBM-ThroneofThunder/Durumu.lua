local mod	= DBM:NewMod(818, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68036)--Crimson Fog 69050, 
mod:SetModelID(47189)
mod:SetUsedIcons(8, 7, 6, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
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
local warnLingeringGaze				= mod:NewTargetAnnounce(138467, 3)--Seems highly variable Cd so no timer for this yet
local warnBlueBeam					= mod:NewTargetAnnounce(139202, 2)
local warnRedBeam					= mod:NewTargetAnnounce(139204, 2)
local warnYellowBeam				= mod:NewTargetAnnounce(133738, 2)--Cannot find a tracking ID for this one
local warnAddsLeft					= mod:NewAnnounce("warnAddsLeft", 2, 134123)
local warnDisintegrationBeam		= mod:NewSpellAnnounce("ej6882", 4)
local warnLifeDrain					= mod:NewTargetAnnounce(133795, 3)--Some times needs to block this even dps. So warn for everyone.
local warnDarkParasite				= mod:NewTargetAnnounce(133597, 3, nil, mod:IsHealer())--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, mod:IsTank(), 4)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTarget(133767, mod:IsTank())
local specWarnForceOfWill			= mod:NewSpecialWarningYou(136413, nil, nil, nil, 3)--VERY important, if you get hit by this you are out of fight for rest of pull.
local specWarnForceOfWillNear		= mod:NewSpecialWarningClose(136413, nil, nil, nil, 3)
local yellForceOfWill				= mod:NewYell(136413)
local specWarnLingeringGaze			= mod:NewSpecialWarningYou(134044)
local yellLingeringGaze				= mod:NewYell(134044, nil, false)
local specWarnLingeringGazeMove		= mod:NewSpecialWarningMove(134044)
local specWarnBlueBeam				= mod:NewSpecialWarningYou(139202)
local specWarnRedBeam				= mod:NewSpecialWarningYou(139204)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(133738)
local specWarnFogRevealed			= mod:NewSpecialWarning("specWarnFogRevealed", nil, nil, nil, 2)--Use another "Be Aware!" sound because Lingering Gaze comes on Spectrum phase.
local specWarnDisintegrationBeam	= mod:NewSpecialWarningSpell("ej6882", nil, nil, nil, 2)
local specWarnEyeSore				= mod:NewSpecialWarningMove(140502)
local specWarnLifeDrain				= mod:NewSpecialWarningTarget(133795, mod:IsTank())
local yellLifeDrain					= mod:NewYell(133795, nil, false)

local timerHardStareCD				= mod:NewCDTimer(12, 133765, mod:IsTank() or mod:IsHealer())--10 second cd but delayed by everything else. Example variation, 12, 15, 9, 25, 31
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(46, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewNextTimer(60, "ej6891")--Don't know when 2nd one is cast.
local timerDarkParasite				= mod:NewTargetTimer(30, 133597, mod:IsHealer())--Only healer/dispeler needs to know this.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598)--EVERYONE needs to know this, if dispeler messed up and dispelled parasite too early you're going to get a new add every 3 seconds for remaining duration of this bar.
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(65, "ej6882")
local timerDisintegrationBeamCD		= mod:NewNextTimer(127, "ej6882")
local timerLifeDrainCD				= mod:NewCDTimer(40, 133795)
local timerLifeDrain				= mod:NewBuffActiveTimer(18, 133795)
local timerIceWallCD				= mod:NewNextTimer(120, 134587)
local timerObliterateCD				= mod:NewNextTimer(80, 137747)--Heroic

local soundLingeringGaze			= mod:NewSound(134044)

local berserkTimer					= mod:NewBerserkTimer(600)

--mod:AddBoolOption("ArrowOnBeam", true)
mod:AddBoolOption("SetIconRays", true)
mod:AddBoolOption("SetIconLifeDrain", true)
mod:AddBoolOption("InfoFrame", true) -- may be need special warning or generic warning high stack player? or do not needed at all?

local totalFogs = 3
local lingeringGazeTargets = {}
local lingeringGazeCD = 46
local lastRed = nil
local lastBlue = nil
local spectrumStarted = false
local lifeDrained = false
local blueTracking = GetSpellInfo(139202)
local redTracking = GetSpellInfo(139204)

local function warnLingeringGazeTargets()
	warnLingeringGaze:Show(table.concat(lingeringGazeTargets, "<, >"))
	table.wipe(lingeringGazeTargets)
end

local function BeamEnded()
--[[	if mod.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end--]]
	timerLingeringGazeCD:Start(16)
	timerForceOfWillCD:Start(18)
	timerLightSpectrumCD:Start(32)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerIceWallCD:Start(24)
	end
	timerDisintegrationBeamCD:Start()
	--Life Drain comes after beamended 1~3 sec.
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
	spectrumStarted = false
	lifeDrained = false
	table.wipe(lingeringGazeTargets)
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(33.5-delay)
	timerLightSpectrumCD:Start(41-delay)
--[[
"<4.6 20:00:50> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Durumu the Forgotten
"<128.6 20:02:54> [CLEU] UNIT_DIED#true##nil#-2147483648#-2147483648#0xF1310DBA00006166#Crimson Fog#8776#0", -- [9268]
"<130.8 20:02:56> [CLEU] SPELL_CAST_START#false#0xF131090E00006089#Blue Eye#2632#0##nil#-2147483648#-2147483648#134587#Ice Wall#1", -- [9313] +125.5 (+2.2 after 3rd fog)

"<3.1 19:52:21> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Durumu the Forgotten
"<109.0 19:54:07> [CLEU] UNIT_DIED#true##nil#-2147483648#-2147483648#0xF1310DBA00005EB8#Crimson Fog#8776#0", -- [8989]
"<111.2 19:54:10> [CLEU] SPELL_CAST_START#false#0xF131090E00005DE8#Blue Eye#2632#0##nil#-2147483648#-2147483648#134587#Ice Wall#1", -- [9104] +108 (+2.2 after 3rd fog)
--]]
	if self:IsDifficulty("heroic10", "heroic25") then
		timerIceWallCD:Start(127-delay)
	end
	timerDisintegrationBeamCD:Start(135-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
--[[	if self.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end--]]
	if self.Options.SetIconRays and lastRed then
		self:SetIcon(lastRed, 0)
		self:SetIcon(lastBlue, 0)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133765 then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif args.spellId == 138467 then
		timerLingeringGazeCD:Start(lingeringGazeCD)
	elseif args.spellId == 134587 and self:AntiSpam(3, 3) then
		warnIceWall:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 4 then
				specWarnSeriousWound:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(133767)) and not UnitIsDeadOrGhost("player") then
				specWarnSeriousWoundOther:Show(args.destName)
			end
		end
	elseif args.spellId == 133597 then--Dark Parasite
		warnDarkParasite:Show(args.destName)
		local _, _, _, _, _, duration, expires = UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration)
	elseif args.spellId == 133598 then--Dark Plague
		local _, _, _, _, _, duration, expires = UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration)
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Cancel(args.destName)
	elseif args.spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target.
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

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
	if msg:find("spell:136932") then--Force of Will
		local target = DBM:GetFullNameByShortName(target)
		warnForceOfWill:Show(target)
		if timerLightSpectrumCD:GetTime() > 22 or timerDisintegrationBeamCD:GetTime() > 108 then--Don't start timer if either beam or spectrum will come first (cause both disable force ability)
			timerForceOfWillCD:Start()
		end
		if target == UnitName("player") then
			specWarnForceOfWill:Show()
			yellForceOfWill:Yell()
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 16 then--Range hard to get perfect, a player 30 yards away might still be in it. I say 15 is probably good middle ground to catch most of the "near"
					specWarnForceOfWillNear:Show(target)
				end
			end
		end
	elseif msg:find("spell:134122") then--Blue Rays
		local target = DBM:GetFullNameByShortName(target)
		lingeringGazeCD = not spectrumStarted and 25 or 40 -- First spectrum Lingering Gaze CD = 25, second = 40
		spectrumStarted = true
		warnBlueBeam:Show(target)
		if target == UnitName("player") then
			specWarnBlueBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(target, 6)--Square
			lastBlue = target
		end
	elseif msg:find("spell:134123") then--Infrared Light (red)
		local target = DBM:GetFullNameByShortName(target)
		warnRedBeam:Show(target)
		if target == UnitName("player") then
			specWarnRedBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(target, 7)--Cross
			lastRed = target
		end
	elseif msg:find("spell:134124") then--useful only on heroic and LFR since there are only amber adds in them. Normal 10 and normal 25 do not have amber adds (why LFR does is beyond me)
		local target = DBM:GetFullNameByShortName(target)
		totalFogs = 3
		timerForceOfWillCD:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerObliterateCD:Start()
			if lifeDrained then -- Check 1st Beam ended.
				timerIceWallCD:Start(87)--NO, Ice wall always comes before 8s do phase change(only igroned first spectrum). So it is not duplicate timer. Ice wall has nothing to do with 3rd red.
			end
		end
		if self:IsDifficulty("heroic10", "heroic25", "lfr25") then
			warnYellowBeam:Show(target)
			if target == UnitName("player") then
				specWarnYellowBeam:Show()
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(target, 1, 10)--Star (auto remove after 10 seconds because this beam untethers one initial person positions it.
		end
	--"<55.5 20:06:45> [CHAT_MSG_MONSTER_EMOTE] CHAT_MSG_MONSTER_EMOTE#The Infrared Light reveals a Crimson Fog!#Crimson Fog###Red Eye##0#0##0#218#nil#0#false#false", -- [10446]
	--"<72.0 20:04:19> [CHAT_MSG_MONSTER_EMOTE] CHAT_MSG_MONSTER_EMOTE#The Bright  Light reveals an Amber Fog!#Amber Fog###Yellow Eye##0#0##0#309#nil#0#false#false", -- [13413]
	--"<102.2 20:07:32> [CHAT_MSG_MONSTER_EMOTE] CHAT_MSG_MONSTER_EMOTE#The Blue Rays reveal an Azure Fog!#Azure Fog###Blue Eye##0#0##0#225#nil#0#false#false", -- [20262]
	--Seems the easiest way to localize this is to just scan for npc with "eye" in it and npc for mobname in the announce. Better than localizing 3 msg variations (one of which has a typo that may get fixed)
	elseif target:find(L.Eye) then--Untested, but should work if I don't have args backwards. Looks like Fog name is npc and target is revealing eye
		specWarnFogRevealed:Show(npc)
	elseif msg:find("spell:133795") then
		local target = DBM:GetFullNameByShortName(target)
		warnLifeDrain:Show(target)
		specWarnLifeDrain:Show(target)
		timerLifeDrain:Start()
		timerLifeDrainCD:Start(not lifeDrained and 50 or nil)--first is 50, 2nd and later is 40 
		lifeDrained = true
		if target == UnitName("player") then
			yellLifeDrain:Yell()
		end
		if self.Options.SetIconLifeDrain then
			self:SetIcon(target, 8) -- Skull
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(133795))
			DBM.InfoFrame:Show(5, "playerdebuffstacks", 133798)
		end
		self:Schedule(18, HideInfoFrame)
	elseif msg:find("spell:134169") then
		lingeringGazeCD = 46 -- Return to Original CD.
		timerLingeringGazeCD:Cancel()
		timerLifeDrainCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show()
		timerDisintegrationBeam:Start()
		self:Unschedule(HideInfoFrame)
		self:Schedule(65, BeamEnded)--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

--Because blizz sucks and these do NOT show in combat log AND the emote only fires for initial application, but not for when a player dies and beam jumps.
function mod:UNIT_AURA(uId)
	local name = DBM:GetUnitFullName(uId)
	if UnitDebuff(uId, blueTracking) and lastBlue ~= name then
		lastBlue = name
		warnBlueBeam:Show(name)
		if name == UnitName("player") then
			specWarnBlueBeam:Show()
		end
		if self.Options.SetIconRays then
			self:SetIcon(name, 6)--Square
		end
	elseif UnitDebuff(uId, redTracking) and lastRed ~= name then
		lastRed = name
		warnRedBeam:Show(name)
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
			timerForceOfWillCD:Start()
			if self.Options.SetIconRays and lastRed then
				self:SetIcon(lastRed, 0)
				self:SetIcon(lastBlue, 0)
				lastRed = nil
				lastBlue = nil
			end
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
				timerForceOfWillCD:Start()
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
					self:SetIcon(lastBlue, 0)
					lastRed = nil
					lastBlue = nil
				end
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
				timerForceOfWillCD:Start()
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
					self:SetIcon(lastBlue, 0)
					lastRed = nil
					lastBlue = nil
				end
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
		self:Schedule(65, BeamEnded)--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger--]]
		print("DBM Debug: Clockwise beam spellid re-enabled by blizzard.")
	elseif spellId == 133775 and self:AntiSpam(2, 2) then--Disintegration Beam (counter-clockwise)
--[[		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_RIGHT)
		timerDisintegrationBeam:Start()
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(270)
		end
		self:Schedule(65, BeamEnded)--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger--]]
		print("DBM Debug: Counter-Clockwise beam spellid re-enabled by blizzard.")
	end
end
