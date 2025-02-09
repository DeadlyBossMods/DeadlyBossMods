---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

local DBMScheduler = private:GetModule("DBMScheduler")
local stringUtils = private:GetPrototype("StringUtils")
local tableUtils = private:GetPrototype("TableUtils")

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class Announce
local announcePrototype = private:GetPrototype("Announce")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local test = private:GetPrototype("DBMTest")

local pformat = stringUtils.pformat
local removeEntry = tableUtils.removeEntry

---@class Timer
local timerPrototype = private:GetPrototype("Timer")
local mt = {__index = timerPrototype}
local countvoice1, countvoice2, countvoice3, countvoice4
local countvoice1max, countvoice2max, countvoice3max, countvoice4max = 5, 5, 5, 5
local countpath1, countpath2, countpath3, countpath4

--Merged countdown object for timers with build-in countdown
function DBM:BuildVoiceCountdownCache()
	countvoice1 = self.Options.CountdownVoice
	countvoice2 = self.Options.CountdownVoice2
	countvoice3 = self.Options.CountdownVoice3
	countvoice4 = self.Options.PullVoice
	for _, count in pairs(DBM:GetCountSounds()) do
		if count.value == countvoice1 then
			countpath1 = count.path
			countvoice1max = count.max
		end
		if count.value == countvoice2 then
			countpath2 = count.path
			countvoice2max = count.max
		end
		if count.value == countvoice3 then
			countpath3 = count.path
			countvoice3max = count.max
		end
		if count.value == countvoice4 then
			countpath4 = count.path
			countvoice4max = count.max
		end
	end
end

local function playCountSound(_, path, requiresCombat) -- timerId, path
	if requiresCombat and not (InCombatLockdown() or UnitAffectingCombat("player")) then return end
	DBM:PlaySoundFile(path)
end

local function playCountdown(timerId, timer, voice, count, requiresCombat)
	if DBM.Options.DontPlayCountdowns then return end
	timer = timer or 10
	count = count or 4
	voice = voice or 1
	if timer <= count then count = math.floor(timer) end
	if not countpath1 or not countpath2 or not countpath3 then
		DBM:Debug("Voice cache not built at time of playCountdown. On fly caching.", 3)
		DBM:BuildVoiceCountdownCache()
	end
	local maxCount, path
	if type(voice) == "string" then
		maxCount = 5--Safe to assume if it's not one of the built ins, it's likely heroes/OW, which has a max of 5
		path = voice
	elseif voice == 2 then
		maxCount = countvoice2max or 10
		path = countpath2 or "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\"
	elseif voice == 3 then
		maxCount = countvoice3max or 5
		path = countpath3 or "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\"
	elseif voice == 4 then
		maxCount = countvoice4max or 10
		path = countpath4 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
	else
		maxCount = countvoice1max or 10
		path = countpath1 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
	end
	if not path then--Should not happen but apparently it does somehow
		DBM:Debug("Voice path failed in countdownProtoType:Start.")
		return
	end
	if count == 0 then--If a count of 0 is passed,then it's a "Countout" timer, not "Countdown"
		for i = 1, timer do
			if i < maxCount then
				DBM:Schedule(i, playCountSound, timerId, path .. i .. ".ogg", requiresCombat)
			end
		end
	else
		for i = count, 1, -1 do
			if i <= maxCount then
				DBM:Schedule(timer - i, playCountSound, timerId, path .. i .. ".ogg", requiresCombat)
			end
		end
	end
end

--"break" and "pull" timers have custom classifications that are straight forward and not in this table
local timerTypeSimplification = {
	--All cooldown times, be they approx cd or next exact, or even AI timers, map to "CD"
	["cdcount"] = "cd",
	["cdsource"] = "cd",
	["cdspecial"] = "cd",
	["nextcount"] = "cd",
	["nextsource"] = "cd",
	["nextspecial"] = "cd",
	["var"] = "cd",
	["varcount"] = "cd",
	["varsource"] = "cd",
	["varspecial"] = "cd",
	["ai"] = "cd",
	["adds"] = "cd",
	["addscustom"] = "cd",

	--All nameplate only timers, be they approx or exact or ai cooldowns, or nameplate only cast timers
	--CDs all map to cdnp but cast maps to castnp
	["cdnp"] = "cdnp",
	["cdpnp"] = "cdnp",
	["nextnp"] = "cdnp",
	["nextpnp"] = "cdnp",
	["castpnp"] = "castnp",

	--RPs all map to "warmup"
	["roleplay"] = "warmup",
	["combat"] = "warmup",

	--all stage types will map to "stage"
	["achievement"] = "stage",
	["stagecount"] = "stage",
	["stagecountcycle"] = "stage",
	["stagecontext"] = "stage",
	["stagecontextcount"] = "stage",
	["intermission"] = "stage",
	["intermissioncount"] = "stage",

	--Target Bars such as buff/debuff on another player, on self, or on the boss, RPs all map to "target"
	["targetcount"] = "target",
	["fades"] = "target",--Fades is usually used as a personal target timer. So like debuff on other player is "debuff (targetname)" but on self it's just "debuff fades"

	--All cast bar types map to "cast"
	["active"] = "cast",--Active bars are usually things like Whirlwind is active on the boss, or a channeled cast is being done. so effectively it's for channeled casts, as upposed to regular casts
	["castsource"] = "cast",
	["castcount"] = "cast",
}

--Very similar to above but more specific to key replacement and not type replacement, to match BW behavior for unification of WAs
local waKeyOverrides = {
	["combat"] = "warmup",
	["roleplay"] = "warmup",
	["achievement"] = "stages",
	["stagecount"] = "stages",
	["stagecountcycle"] = "stages",
	["stagecontext"] = "stages",
	["stagecontextcount"] = "stages",
	["intermission"] = "stages",
	["intermissioncount"] = "stages",
}

local function isNegativeZero(x)
	return x == 0 and 1/x < 0  -- Only true for -0
end

-- Parse variance from timer string (v30.5-40" or "dv30.5-40"), into minimum and maximum timer, and calculated variance duration
---@param timer string
---@return number maxTimer, number minTimer, number varianceDuration
	local function parseVarianceFromTimer(timer)
	-- ^(d?v) matches starting character d (optional) or v
	-- (%d+%.?%d*) matches any number of digits with optional decimal
	-- %- matches literal character "-"
	-- (%d+%.?%d*)$ matches any number of digits with optional decimal, at the end of the string
	local minTimer, maxTimer = timer:match("v(%d+%.?%d*)%-(%d+%.?%d*)")
	minTimer, maxTimer = tonumber(minTimer), tonumber(maxTimer)
	if type(minTimer) ~= "number" or type(maxTimer) ~= "number" then
		DBM:Debug("|cffff0000No timers found in the string passed to parseVarianceFromTimer function: "..timer..". Returning zero.|r")
		return 0, 0, 0
		end
	local varianceDuration = maxTimer - minTimer

	return maxTimer, minTimer, varianceDuration  -- maximum possible timer from the variance window, minimum..., variance duration
end

local function correctWithVarianceDuration(numberToCorrect, timerBar)
	if not numberToCorrect then
		DBM:Debug("|cffff0000No number passed to correctWithVarianceDuration function.|r")
		return
	end

	if not timerBar then
		DBM:Debug("|cffff0000No timerBar passed to correctWithVarianceDuration function.|r")
		return numberToCorrect
	end

	return timerBar.hasVariance and (numberToCorrect + timerBar.varianceDuration) or numberToCorrect
end

function timerPrototype:Start(timer, ...)
	if not self.mod.isDummyMod then--Don't apply following rulesets to pull timers and such
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
	end
	local isDelayed = type(timer) == "number" and (isNegativeZero(timer) or timer < 0)
	local hasVariance = type(timer) == "number" and timer > 0 and false or not timer and self.hasVariance -- account for metavariant timers that were fired with a fixed timer start, like timer:Start(10). Does not account for timer:Start(-delay), which is parsed below after variance started timers
	local timerStringWithVariance, maxTimer, minTimer
	if type(timer) == "string" and timer:match("^v%d+%.?%d*-%d+%.?%d*$") then -- catch "timer variance" pattern, expressed like v10.5-20.5
		hasVariance = true
		timerStringWithVariance = timer -- cache timer string
		maxTimer, minTimer = parseVarianceFromTimer(timer) -- use highest possible value as the actual End timer
		timer = DBT.Options.VarianceEnabled and maxTimer or minTimer
	end
	if isDelayed then -- catch metavariant timers with delay, expressed like timer:Start(-delay)
		if self.hasVariance then
			hasVariance = self.hasVariance
			maxTimer, minTimer = parseVarianceFromTimer(self.timerStringWithVariance) -- use highest possible value as the actual End timer
			timerStringWithVariance = ("v%s-%s"):format(minTimer + timer, maxTimer + timer) -- rebuild timer string with delay applied
			timer = (DBT.Options.VarianceEnabled and maxTimer or minTimer) + timer
		end
	end
	if DBM.Options.DebugMode and self.mod.id ~= "TestMod" then
		self.keep = hasVariance -- keep variance timers for debug purposes
	end
	if timer and type(timer) ~= "number" then
		return self:Start(nil, timer, ...) -- first argument is optional!
	end
	if not self.option or self.mod.Options[self.option] then
		local isCountTimer = false
		if self.type and (self.type == "cdcount" or self.type == "nextcount" or self.type == "stagecount" or self.type == "stagecontextcount" or self.type == "stagecountcycle" or self.type == "intermissioncount" or self.type == "varcount") then
			isCountTimer = true
		end
		local guid, timerCount
		if select("#", ...) > 0 then--If timer has args
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
					guid = v--If found, guid will be passed in DBM_TimerStart callback
				end
				--Not most efficient way to do it, but since it's already being done for guid, it's best not to repeat the work
				if isCountTimer and type(v) == "number" then
					timerCount = v
				end
			end
		end
		timer = timer and ((timer >= 0 and timer) or self.timer + timer) or self.timer
		if isCountTimer and not self.allowdouble then--remove previous timer.
			for i = #self.startedTimers, 1, -1 do
				if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
					local bar = DBT:GetBar(self.startedTimers[i])
					if bar then
						if abs(bar.timer) > 0.2 then -- Positive and Negative ("keep") timers.
							local remaining = ("%.1f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
							ttext = ttext .. "(" .. self.id .. "-" .. (timer or 0) .. ")"
							local deltaFromVarianceMinTimer = ("%.2f"):format(bar.hasVariance and bar.timer - bar.varianceDuration or bar.timer)
							local phaseText = self.mod.vb.phase and " (" .. SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
							if bar.hasVariance then
								if DBM.Options.BadTimerAlert and bar.timer > correctWithVarianceDuration(1, bar) then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired, outside known variance window. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. "). Please report this bug", nil, nil, nil, true)
									DBM:FireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired, outside known variance window. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. "). Please report this bug", 2)
								elseif bar.timer < -0.2 then -- Would be useful to implement a variance detector, and report outside the known variance, however this would need to happen on a timer after it was refreshed. For the moment, only "keep" arg can achieve this.
									DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed after zero, outside known variance window. Remaining time is : " .. remaining, 2)
								elseif bar.timer > correctWithVarianceDuration(0.2, bar) then
									DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. ")", 2)
								end
							else -- duplicated code, should be refactored
								if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", nil, nil, nil, true)
									DBM:FireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", 2)
								elseif bar.timer > 0.2 then
									DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining, 2, true)
								end
							end
							-- Trace early refreshes for tests
							if bar.timer > correctWithVarianceDuration(0.1, bar) then
								test:Trace(self.mod, "EarlyTimerRefresh", self, bar.timer, bar.totalTime, bar.varianceDuration)
							end
						end
					end
				end
				DBT:CancelBar(self.startedTimers[i])
				DBM:Unschedule(playCountSound, self.startedTimers[i])
				DBM:FireEvent("DBM_TimerStop", self.startedTimers[i])
				if guid then
					DBM:FireEvent("DBM_NameplateStop", self.startedTimers[i])
				end
				tremove(self.startedTimers, i)
			end
		end
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		--AI timer api:
		--Starting ai timer with (1) indicates it's a first timer after pull
		--Starting timer with (2) or (3) indicates it's a stage 2 or stage 3 first timer
		--Starting AI timer with anything above 3 indicarets it's a regular timer and to use shortest time in between two regular casts
		if self.type == "ai" then--A learning timer
			if timer > 5 then--Normal behavior.
				local newPhase = false
				for i = 1, 5 do
					--Check for any phase timers that are strings, if a string it means last cast of this ability was first case of a given stage
					if self["phase" .. i .. "CastTimer"] and type(self["phase" .. i .. "CastTimer"]) == "string" then--This is first cast of spell, we need to generate self.firstPullTimer
						self["phase" .. i .. "CastTimer"] = tonumber(self["phase" .. i .. "CastTimer"])
						self["phase" .. i .. "CastTimer"] = GetTime() - self["phase" .. i .. "CastTimer"]--We have generated a self.phase1CastTimer! Next pull, DBM should know timer for first cast next pull. FANCY!
						DBM:Debug("AI timer learned a first timer for current phase of " .. self["phase" .. i .. "CastTimer"], 2)
						newPhase = true
					end
				end
				if self.lastCast and not newPhase then--We have a GetTime() on last cast and it's not affected by a phase change
					local timeLastCast = GetTime() - self.lastCast--Get time between current cast and last cast
					if timeLastCast > 5 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
						if not self.lowestSeenCast or (self.lowestSeenCast and self.lowestSeenCast > timeLastCast) then--Always use lowest seen cast for a timer
							self.lowestSeenCast = timeLastCast
							DBM:Debug("AI timer learned a new lowest timer of " .. self.lowestSeenCast, 2)
						end
					end
				end
				self.lastCast = GetTime()
				if self.lowestSeenCast then--Always use lowest seen cast for timer
					timer = self.lowestSeenCast
				else
					return--Don't start the bogus timer shoved into timer field in the mod
				end
			else--AI timer passed with 5 or less is indicating phase change, with timer as phase number
				if not private.isRetail then
					timer = math.floor(timer)--Floor inprecise timers in classic because combat is mostly caused by PLAYER_REGEN in dungeons
				else
					timer = math.ceil(timer)--Ceil timer in retail to fix combat startt timers being 0.9999 instead of 1 (due to change in how delay works)
				end
				if self["phase" .. timer .. "CastTimer"] and type(self["phase" .. timer .. "CastTimer"]) == "number" then
					--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
					local bar = DBT:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						if bar.timer > 0.2 then
							self["phase" .. timer .. "CastTimer"] = self["phase" .. timer .. "CastTimer"] - remaining
							DBM:Debug("AI timer learned a lower first timer for current phase of " .. self["phase" .. timer .. "CastTimer"], 2)
						end
					end
					timer = self["phase" .. timer .. "CastTimer"]
				else--No first pull timer generated yet, set it to GetTime, as a string
					self["phase" .. timer .. "CastTimer"] = tostring(GetTime())
					return--Don't start the x second timer
				end
			end
		end
		if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
			if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") and not self.allowdouble then
				local bar = DBT:GetBar(id)
				if bar then
					local remaining = ("%.1f"):format(bar.timer)
					local deltaFromVarianceMinTimer = ("%.2f"):format(bar.hasVariance and bar.timer - bar.varianceDuration or bar.timer)
					local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
					ttext = ttext .. "(" .. self.id .. "-" .. (timer or 0) .. ")"
					if abs(bar.timer) > 0.2 then -- Positive and Negative ("keep") timers.
						local phaseText = self.mod.vb.phase and " (" .. SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
						if bar.hasVariance then
							if DBM.Options.BadTimerAlert and bar.timer > correctWithVarianceDuration(1, bar) then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired, outside known variance window. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. "). Please report this bug", nil, nil, nil, true)
								DBM:FireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired, outside known variance window. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. "). Please report this bug", 2)
							elseif bar.timer < -0.2 then -- Would be useful to implement a variance detector, and report outside the known variance, however this would need to happen on a timer after it was refreshed. For the moment, only "keep" arg can achieve this.
								DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed after zero, outside known variance window. Remaining time is : " .. remaining, 2)
							elseif bar.timer > correctWithVarianceDuration(0.2, bar) then
								DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. " (until variance minimum timer: " .. deltaFromVarianceMinTimer .. ")", 2)
							end
						else -- duplicated code, should be refactored
							if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", nil, nil, nil, true)
								DBM:FireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", 2)
							elseif bar.timer > 0.2 then
								DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining, 2, true)
							end
						end
					end
					if bar.timer > correctWithVarianceDuration(0.1, bar) then
						test:Trace(self.mod, "EarlyTimerRefresh", self, bar.timer, bar.totalTime, bar.varianceDuration)
					end
				end
			end
		end
		local colorId
		if self.option then
			colorId = self.mod.Options[self.option .. "TColor"]
		elseif self.colorType and type(self.colorType) == "string" then--No option for specific timer, but another bool option given that tells us where to look for TColor (for mods such as trio boss for valentines day in events mods)
			colorId = self.mod.Options[self.colorType .. "TColor"]
		else--No option, or secondary option, set colorId to hardcoded color type
			colorId = self.colorType or 0
		end
		local countVoice, countVoiceMax = 0, self.countdownMax or 4
		if self.option then
			countVoice = self.mod.Options[self.option .. "CVoice"]
			if not self.fade and (type(countVoice) == "string" or countVoice > 0) then--Started without faded and has count voice assigned
				-- minTimer checks for the minimum possible timer in the variance timer string sent from Start method, self.minTimer is from newTimer constructor. Else, use timer value
				playCountdown(id, minTimer or (hasVariance and self.minTimer) or timer, countVoice, countVoiceMax, self.requiresCombat)--timerId, timer, voice, count
			end
		end
		-- timerStringWithVariance checks for timer string sent from Start method, self.timerStringWithVariance is from newTimer constructor. Else, use timer value
		local bar = DBT:CreateBar(timerStringWithVariance or (hasVariance and self.timerStringWithVariance) or timer, id, self.icon, self.startLarge, nil, nil, nil, colorId, nil, self.keep, self.fade, countVoice, countVoiceMax, self.simpType == "cd" or self.simpType == "cdnp")
		if not bar then
			return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
		end
		local msg
		if self.type and not self.text then
			msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), ...)
		else
			if type(self.text) == "number" then--spellId passed in timer text, it's a timer with short text
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.text, self.name), ...)
			else
				msg = pformat(self.text, ...)
			end
		end
		if test.testRunning and self.type == "target"  then
			-- Target timers may use the real player's name as arg
			-- We just update the text, not the timer id because if we would change the id we would need to do this everywhere which is a mess
			local targetArg = ...
			if targetArg == UnitName("player") or targetArg and targetArg:match(">.-<") and stringUtils.stripServerName(targetArg) == UnitName("player") then
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), "PlayerName", ...)
			end
		end
		msg = msg:gsub(">.-<", stringUtils.stripServerName)
		bar:SetText(msg, self.inlineIcon)
		-- FIXME: i would prefer to trace this directly in DBT, but since I want to rewrite DBT... meh.
		test:Trace(self.mod, "StartTimer", self, timer, msg)
		--ID (string) Internal DBM timer ID
		--msg (string) Timer Text (Do not use msg has an event trigger, it varies language to language or based on user timer options. Use this to DISPLAY only (such as timer replacement UI). use spellId field 99% of time
		--timer (number) Raw timer value. Will return lowest number in variance timers (like DBM has always done, earliest an ability comes off CD is expected behavior for weak auras)
		--Icon (string or number): Texture Path for Icon
		--simpleType (string): Timer type, which is one of only 7 possible types: "cd" for coolodwns, "target" for target bars such as debuff on a player, "stage" for any kind of stage timer (stage ends, next stage, or even just a warmup timer like "fight begins"), and then "cast" timer which is used for both a regular cast and a channeled cast (ie boss is casting frostbolt, or boss is channeling whirlwind). Lastly, break, pull, and berserk timers are "breaK", "pull", and "berserk" respectively
		--spellId (string or number): Raw spellid if available (most timers will have spellId or EJ ID unless it's a specific timer not tied to ability such as pull or combat start or rez timers. EJ id will be in format ej%d
		--colorID (number): Type classification (1-Add, 2-Aoe, 3-targeted ability, 4-Interrupt, 5-Role, 6-Stage, 7-User(custom))
		--Mod ID (string or number): Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
		--Keep (true or nil), whether or not to keep bar on screen when it expires (if true, timer should be retained until an actual TimerStop occurs or a new TimerStart with same barId happens (in which case you replace bar with new one)
		--fade (true or nil), whether or not to fade a bar (set alpha to usersetting/2)
		--spellName (string) Sent so users can use a spell name instead of spellId, if they choose. Mostly to be more classic wow friendly, spellID is still preferred method (even for classic)
		--MobGUID (string) if it could be parsed out of args
		--timerCount (number) if current timer is a count timer. Returns number (count value) needed to have weak auras that trigger off a specific timer count without using localized message text
		--isPriority: If true, this ability has been flagged as extra important. Can be used for weak auras or nameplate addons to add extra emphasis onto specific timer like a glow
		--fullType (the true type of timer, for those who really want to filter timers by DBM classifications such as "adds" or "interrupt")
		--hasVariance (true or nil) if timer has variance.
		--variancePeaktimer (number) if timer has variance, this is the peak timer in the variance window, otherwise nil
		--NOTE, nameplate variant has same args as timer variant, but is sent to a different event (DBM_NameplateStart)

		--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
		--This check is performed secondary to args scan so that no adds guids are overwritten
		if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then--Variance excluded for now while NP timers don't support yet
			guid = UnitGUID("boss1")
		end
		if self.simpType and (self.simpType == "cdnp" or self.simpType == "castnp") then--Only send nampelate callback
			DBM:FireEvent("DBM_NameplateStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, (self.simpType == "cdnp" and DBM.Options.AlwaysKeepNPs) and true or self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer)
		else--Send both callbacks
			DBM:FireEvent("DBM_TimerStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer)
			if guid then--But nameplate is only sent if actual GUID
				DBM:FireEvent("DBM_NameplateStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer)
			end
		end
		--Bssically tops bar from starting if it's being put on a plater nameplate, to give plater users option to have nameplate CDs without actually using the bars
		--This filter will only apply to trash mods though, boss timers will always be shown due to need to have them exist for Pause, Resume, Update, and GetTime/GetRemaining methods
		if guid and (self.type == "cdnp" or self.type == "nextnp" or self.type == "cdpnp" or self.type == "nextpnp" or self.type == "castpnp") and not (DBM.Options.DebugMode and DBM.Options.DebugLevel > 1) then
			DBT:CancelBar(id)--Cancel bar without stop callback
			return false, "disabled"
		end
		if not tContains(self.startedTimers, id) then--Make sure timer doesn't exist already before adding it
			tinsert(self.startedTimers, id)
		end
		if not self.keep then--Don't ever remove startedTimers on a schedule, if it's a keep timer
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
		end
		return bar
	else
		return false, "disabled"
	end
end
timerPrototype.Show = timerPrototype.Start

--A way to set the fade to yes or no, overriding hardcoded value in NewTimer object with temporary one
--If this method is used, it WILL persist until reload or changing it back
function timerPrototype:SetFade(fadeOn, ...)
	--Done this way so SetFade can be used with :Start without needless performance cost (ie, ApplyStyle won't run unless it needs to)
	if fadeOn and not self.fade then
		self.fade = true--set timer object metatable, which will make sure next bar started uses fade
		--Find and Update an existing bar that's already started
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar and not bar.fade then
			DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
			bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "Fade", true)
			DBM:Unschedule(playCountSound, id)--Don't even need to check option, it's faster cpu wise to just unschedule countdown either way
		end
	elseif not fadeOn and self.fade then
		self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
		--Find and Update an existing bar that's already started
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar and bar.fade then
			DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
			bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "Fade", false)
			if self.option then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: " .. id .. " after a SetFade disable call")
				end
			end
		end
	end
end

--This version does NOT set timer object meta, only started bar meta
--Use this if you only want to alter an already STARTED temporarily
--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
function timerPrototype:SetSTFade(fadeOn, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		if fadeOn and not bar.fade then
			DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
			bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "STFade", true)
			DBM:Unschedule(playCountSound, id)
		elseif not fadeOn and bar.fade then
			DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)
			bar.fade = false
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "STFade", false)
			if self.option then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: " .. id .. " after a SetSTFade disable call")
				end
			end
		end
	end
end

function timerPrototype:SetSTKeep(keepOn, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		if keepOn and not bar.keep then
			bar.keep = true--Set bar object metatable, which is copied from timer metatable at bar start only
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "STKeep", true)
		elseif not keepOn and bar.keep then
			DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
			bar.keep = false
			bar:ApplyStyle()
			test:Trace(self.mod, "SetTimerProperty", self, id, "STKeep", false)
		end
	end
end

local function testFixupScheduleMethodName(self, ...)
	if not test.testRunning or self.type ~= "target" then
		return ...
	end
	local targetArg = ...
	if targetArg == UnitName("player") or targetArg and targetArg:match(">.-<") and stringUtils.stripServerName(targetArg) == UnitName("player") then
		return "PlayerName", select(2, ...)
	else
		return ...
	end
end

function timerPrototype:DelayedStart(delay, ...)
	DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
	local id = DBMScheduler:Schedule(delay or 0.5, self.Start, self.mod, self, ...)
	test:Trace(self.mod, "SchedulerHideFromTraceIfUnscheduled", id)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "DelayedStart", testFixupScheduleMethodName(self, ...))
end
timerPrototype.DelayedShow = timerPrototype.DelayedStart

function timerPrototype:Schedule(t, ...)
	local id = DBMScheduler:Schedule(t, self.Start, self.mod, self, ...)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "Schedule", testFixupScheduleMethodName(self, ...))
end

function timerPrototype:Unschedule(...)
	return DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
end

--TODO, figure out why this function doesn't properly stop count timers when calling stop without count on count timers
function timerPrototype:Stop(...)
	if select("#", ...) == 0 then
		for i = #self.startedTimers, 1, -1 do
			if self.simpType and (self.simpType == "cdnp" or self.simpType == "castnp") then
				--Technically i don't think this should happen, because a nameplate timer would never have 0 args, but just in case
				DBM:FireEvent("DBM_NameplateStop", self.startedTimers[i])
			else
				DBM:FireEvent("DBM_TimerStop", self.startedTimers[i])
			end
			test:Trace(self.mod, "StopTimer", self, self.startedTimers[i])
			DBT:CancelBar(self.startedTimers[i])
			DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
			tremove(self.startedTimers, i)
		end
	else
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		for i = #self.startedTimers, 1, -1 do
			if self.startedTimers[i] == id then
				local guid
				for j = 1, select("#", ...) do
					local v = select(j, ...)
					if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
						guid = v--If found, guid will be passed in DBM_TimerStart callback
					end
				end
				--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
				--This check is performed secondary to args scan so that no adds guids are overwritten
				if not guid and self.mod.sendMainBossGUID and DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then
					guid = UnitGUID("boss1")
				end
				if guid then--if guid, there is also a nameplate timer, so stop that too
					DBM:FireEvent("DBM_NameplateStop", id, guid)
				end
				DBM:FireEvent("DBM_TimerStop", id, guid)
				test:Trace(self.mod, "StopTimer", self, id)
				DBT:CancelBar(id)
				DBM:Unschedule(playCountSound, id)--Unschedule countdown by timerId
				tremove(self.startedTimers, i)
			end
		end
	end
	if self.type == "ai" then--A learning timer
		self.lastCast = nil
		for i = 1, 4 do
			--Check for any phase timers that are strings and never got a chance to become AI timers, then wipe them
			if self["phase" .. i .. "CastTimer"] and type(self["phase" .. i .. "CastTimer"]) == "string" then
				self["phase" .. i .. "CastTimer"] = nil
				DBM:Debug("Wiping incomplete new timer of stage " .. i, 2)
			end
		end
	end
end

--HardStop is a method used when you want to force stop all varients of a timer by ID, period, but still pass a GUID for callbacks
--This is especially useful for count timers where guid is 2nd arg and count is 1st
--where Stop(guid) would mismatch object and not stop a bar and calling stop on every possible count is silly and stop without args wouldn't send GUID
function timerPrototype:HardStop(guid)
	--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
	--This check is performed secondary to args scan so that no adds guids are overwritten
	if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then
		guid = UnitGUID("boss1")
	end
	for i = #self.startedTimers, 1, -1 do
		DBM:FireEvent("DBM_TimerStop", self.startedTimers[i], guid)
		DBM:FireEvent("DBM_NameplateStop", self.startedTimers[i], guid)
		test:Trace(self.mod, "StopTimer", self, self.startedTimers[i])
		DBT:CancelBar(self.startedTimers[i])
		DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
		tremove(self.startedTimers, i)
	end
end

function timerPrototype:Cancel(...)
	self:Stop(...)
	self:Unschedule(...)--Also unschedules not yet started timers that used timer:Schedule()
end

function timerPrototype:GetTime(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
end

function timerPrototype:GetRemaining(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	return bar and bar.timer or 0
end

function timerPrototype:IsStarted(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	return bar and true
end

function timerPrototype:SetTimer(timer)
	self.timer = timer
end

function timerPrototype:Update(elapsed, totalTime, ...)
	if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
	if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	---@type DBTBar|boolean|nil
	local bar = DBT:GetBar(id)
	if not bar then
		bar = self:Start(totalTime, ...)
	end
	if bar then -- still need to check as :Start() can return nil instead of actually starting the timer
		local guid
		if select("#", ...) > 0 then--If timer has args
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
					guid = v--If found, guid will be passed in callback
				end
			end
		end
		if guid then
			DBM:FireEvent("DBM_NameplateUpdate", id, elapsed, totalTime)
		end
		DBM:FireEvent("DBM_TimerUpdate", id, elapsed, totalTime)
		local newRemaining = totalTime - elapsed
		if not bar.keep and newRemaining > 0 then
			--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
		end
		if self.option then
			local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
			if (type(countVoice) == "string" or countVoice > 0) then
				if not bar.fade then--Don't start countdown voice if it's faded bar
					if newRemaining > 2 then
						--Can't be called early beacuse then it won't unschedule countdown triggered by :Start if it was called
						--Also doesn't need to be called early like it does in AddTime and RemoveTime since those early return
						DBM:Unschedule(playCountSound, id)
						playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Updating a countdown after a timer Update call for timer ID:" .. id)
					end
				end
			end
		end
		local updated = DBT:UpdateBar(id, elapsed, totalTime)
		test:Trace(self.mod, "UpdateTimer", self, id, elapsed, totalTime)
		return updated
	end
end

function timerPrototype:AddTime(extendAmount, ...)
	if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
	if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	DBM:Unschedule(playCountSound, id)--Needs to be unscheduled early in case Start is called instead of Update
	local bar = DBT:GetBar(id)
	if not bar then
		return self:Start(extendAmount, ...)
	else
		local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
		if elapsed and total then
			local newRemaining = (total + extendAmount) - elapsed
			if not bar.keep then
				--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
				self.mod:Unschedule(removeEntry, self.startedTimers, id)
				self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
			end
			if self.option then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then
					if not bar.fade then--Don't start countdown voice if it's faded bar
						playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Updating a countdown after a timer AddTime call for timer ID:" .. id)
					end
				end
			end
			local guid
			if select("#", ...) > 0 then--If timer has args
				for i = 1, select("#", ...) do
					local v = select(i, ...)
					if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
						guid = v--If found, guid will be passed in callback
					end
				end
			end
			if guid then
				DBM:FireEvent("DBM_NameplateUpdate", id, elapsed, total + extendAmount)
			end
			DBM:FireEvent("DBM_TimerUpdate", id, elapsed, total + extendAmount)
			local updated = DBT:UpdateBar(id, elapsed, total + extendAmount)
			test:Trace(self.mod, "UpdateTimer", self, id, elapsed, total + extendAmount)
			return updated
		end
	end
end

function timerPrototype:RemoveTime(reduceAmount, ...)
	if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
	if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	DBM:Unschedule(playCountSound, id)--Needs to be unscheduled here, or countdown might not be canceled if removing time made it cease to have a > 0 value
	local bar = DBT:GetBar(id)
	if not bar then
		return--Do nothing
	else
		if not bar.keep then
			self.mod:Unschedule(removeEntry, self.startedTimers, id)--Needs to be unscheduled here, or the entry might just get left in table until original expire time, if new expire time is less than 0
		end
		local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
		if elapsed and total then
			local newRemaining = (total - reduceAmount) - elapsed
			local guid
			if select("#", ...) > 0 then--If timer has args
				for i = 1, select("#", ...) do
					local v = select(i, ...)
					if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
						guid = v--If found, guid will be passed in callback
					end
				end
			end
			if newRemaining > 0 then
				--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
				if not bar.keep then
					self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
				end
				if self.option and newRemaining > 2 then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then
						if not bar.fade then--Don't start countdown voice if it's faded bar
							if newRemaining > 2 then
								playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
								DBM:Debug("Updating a countdown after a timer RemoveTime call for timer ID:" .. id)
							end
						end
					end
				end
				if guid then
					DBM:FireEvent("DBM_NameplateUpdate", id, elapsed, total - reduceAmount)
				end
				DBM:FireEvent("DBM_TimerUpdate", id, elapsed, total - reduceAmount)
				local updated = DBT:UpdateBar(id, elapsed, total - reduceAmount)
				test:Trace(self.mod, "UpdateTimer", self, id, elapsed, total - reduceAmount)
				return updated
			else--New remaining less than 0
				DBM:FireEvent("DBM_TimerStop", id)
				if guid then
					DBM:FireEvent("DBM_NameplateStop", id)
				end
				removeEntry(self.startedTimers, id)
				test:Trace(self.mod, "StopTimer", self, id)
				return DBT:CancelBar(id)
			end
		end
	end
end

function timerPrototype:Pause(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	DBM:Unschedule(playCountSound, id)--Kill countdown on pause
	if bar then
		if not bar.keep then
			self.mod:Unschedule(removeEntry, self.startedTimers, id)--Prevent removal from startedTimers table while bar is paused
		end
		local guid
		if select("#", ...) > 0 then--If timer has args
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
					guid = v--If found, guid will be passed in callback
				end
			end
		end
		DBM:FireEvent("DBM_TimerPause", id)
		if guid then
			DBM:FireEvent("DBM_NameplatePause", id)
		end
		bar:Pause()
		test:Trace(self.mod, "PauseTimer", self, id)
	end
end

function timerPrototype:Resume(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
		if elapsed and total then
			local remaining = total - elapsed
			if not bar.keep then
				self.mod:Schedule(remaining, removeEntry, self.startedTimers, id)--Re-schedule the auto remove entry stuff
			end
			--Have to check if paused bar had a countdown on resume so we can restore it
			if self.option and not bar.fade then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then
					playCountdown(id, remaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
					DBM:Debug("Updating a countdown after a timer Resume call for timer ID:" .. id)
				end
			end
		end
		local guid
		if select("#", ...) > 0 then--If timer has args
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
					guid = v--If found, guid will be passed in callback
				end
			end
		end
		DBM:FireEvent("DBM_TimerResume", id)
		if guid then
			DBM:FireEvent("DBM_NameplateResume", id)
		end
		bar:Resume()
		test:Trace(self.mod, "ResumeTimer", self, id)
	end
end

function timerPrototype:UpdateIcon(icon, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		icon = DBM:ParseSpellIcon(icon)
		DBM:FireEvent("DBM_TimerUpdateIcon", id, icon)
		bar:SetIcon(icon)
		test:Trace(self.mod, "SetTimerProperty", self, id, "Icon", icon)
	end
end

--This function changes the spellname and callback key (but not option key) of timer object
--This is needed for faction bosses where we need to swap out a spell key/name on fly after a boss is engaged
function timerPrototype:UpdateKey(altSpellId, ...)
	--Check if existing bar first,
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	self.spellId = altSpellId
	self.icon = DBM:ParseSpellIcon(altSpellId, self.type, self.icon)
	self.name = nil--By wiping name, it becomes uncached and can get replaced by GetLocalizedTimerText in :Start
	if bar then
		--If a bar exists while updating key we"
		--Get remainig, kill old timer, start new one with ID/name replacement applied
		local remaining = bar.timer
		self:Stop(...)
		self:Unschedule(...)
		DBM:Unschedule(playCountSound, id)
		self:Start(remaining, ...)--Restart it
	end
end

function timerPrototype:UpdateInline(newInline, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
		bar:SetText(ttext, newInline or self.inlineIcon)
		test:Trace(self.mod, "SetTimerProperty", self, id, "InlineIcon", newInline or self.inlineIcon)
	end
end

function timerPrototype:UpdateName(name, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		bar:SetText(name, self.inlineIcon)
		test:Trace(self.mod, "SetTimerProperty", self, id, "Name", name)
	end
end

function timerPrototype:SetColor(c, ...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		bar:SetColor(c)
		test:Trace(self.mod, "SetTimerProperty", self, id, "Color", c.r, c.g, c.b)
	end
end

function timerPrototype:DisableEnlarge(...)
	local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
	local bar = DBT:GetBar(id)
	if bar then
		bar.small = true
	end
end

---@param optionDefault SpecFlags|boolean?
function timerPrototype:AddOption(optionDefault, optionName, colorType, countdown, spellId, optionType, waCustomName)
	if optionName ~= false then
		self.option = optionName or self.id
		self.mod:AddBoolOption(self.option, optionDefault, "timer", nil, colorType, countdown, spellId, optionType, waCustomName)
	end
end

---If a new countdown default is added to a NewTimer object, change optionName of timer to reset a new default
---@param timer number|string
---@param name string
---@param icon number|string? Use number for spellId, -number for journalID, number as string for textureID
---@param optionDefault SpecFlags|boolean?
---@param optionName string|boolean? String for custom option name. Using false hides option completely
---@param colorType number|string? number for colortype. String for supporting checking an entirely different optionkey for color type
---@param keep boolean? Use to keep timer on screen when it expires
---@param countdown number?
---@param countdownMax number?
---@param r number? Override bar red value
---@param g number? Override bar green value
---@param b number? Override bar blue value
---@param spellId string|number? Used to define a spellID used for GroupSpells and WeakAura key
---@param requiresCombat boolean? Disables audio countdowns when not in combat
---@param waCustomName any? Used to show custom name/text for Spell header (usually used when a made up SpellID is used)
---@param customType string? Used to define alternate timer type for WeakAura callbacks via the timerTypeSimplification table
---@param isPriority boolean? Used to flag a timer as extra important. Can be used for weak auras or nameplate addons to add extra emphasis onto specific timer like a glow
function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType, isPriority)
	if r and type(r) == "string" then
		DBM:Debug("|cffff0000r probably has inline icon in it and needs to be fixed for |r" .. name .. r)
		r = nil--Fix it for users
	end
	if inlineIcon and type(inlineIcon) == "number" then
		DBM:Debug("|cffff0000spellID texture path or colorType is in inlineIcon field and needs to be fixed for |r" .. name .. inlineIcon)
		inlineIcon = nil--Fix it for users
	end
	local hasVariance, timerStringWithVariance, minTimer, varianceDuration
	if type(timer) == "string" then
		if timer:match("^v%d+%.?%d*%-%d+%.?%d*$") then -- parse variance, e.g. "v20.5-25.5"
			hasVariance = true
			timerStringWithVariance = timer
			timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
		end
	end
	icon = DBM:ParseSpellIcon(icon)
	local waSpecialKey, simpType
	if customType then
		simpType = timerTypeSimplification[customType] or customType
		waSpecialKey = waKeyOverrides[customType]
	end
	---@class Timer
	local obj = setmetatable(
		{
			objClass = "Timer",
			text = self.localization.timers[name],
			type = customType or "cd",--Auto assign
			simpType = simpType or "cd",
			waSpecialKey = waSpecialKey,
			spellId = spellId,--Allows Localized timer text to still have a spellId arg weak auras can latch onto
			timer = timer,
			id = name,
			icon = icon,
			colorType = colorType or 0,
			inlineIcon = inlineIcon,
			keep = keep,
			countdown = countdown,
			countdownMax = countdownMax,
			r = r,
			g = g,
			b = b,
			requiresCombat = requiresCombat,
			hasVariance = hasVariance,
			minTimer = minTimer,
			timerStringWithVariance = timerStringWithVariance,
			varianceDuration = varianceDuration,
			startedTimers = {},
			mod = self,
			startLarge = nil,
			isPriority = isPriority,
		},
		mt
	)
	test:Trace(self, "NewTimer", obj, obj.type)
	obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, nil, waCustomName)
	tinsert(self.timers, obj)
	return obj
end

-- new constructor for the new auto-localized timer types
-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
-- If a new countdown is added to an existing timer that didn't have one before, use optionName (number) to force timer to reset defaults by assigning it a new variable
---@param timerType string
local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat, isPriority)
	if type(timer) == "string" and timer:match("OptionVersion") then
		error("OptionVersion hack deprecated, remove it from: " .. spellId)
	end
	if type(colorType) == "number" and colorType > 8 then
		DBM:AddMsg("|cffff0000texture is in the colorType arg for: |r" .. spellId)
	end
	--Use option optionName for optionVersion as well, no reason to split.
	--This ensures that remaining arg positions match for auto generated and regular NewTimer
	local optionVersion
	if type(optionName) == "number" then
		optionVersion = optionName
		optionName = nil
	end
	local allowdouble, hasVariance, timerStringWithVariance, minTimer, varianceDuration
	if type(timer) == "string" then
		if timer:match("d%d+") then -- parse doubling timers, e.g. "d20"
			allowdouble = true
			timer = tonumber(string.sub(timer, 2))
		elseif timer:match("^v%d+%.?%d*%-%d+%.?%d*$") then -- parse variance, e.g. "v20.5-25.5"
			hasVariance = true
			timerStringWithVariance = timer
			timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
		elseif timer:match("dv%d+%.?%d*%-%d+%.?%d*$") then -- parse doubling and variance, e.g. "dv20.5-25.5"
			allowdouble = true
			hasVariance = true
			timerStringWithVariance = timer
			timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
		end
	end
	local spellName, icon
	spellName = DBM:ParseSpellName(spellId, timerType)
	local unparsedId = spellId
	if timerType == "achievement" then
		icon = DBM:ParseSpellIcon(texture or spellId, timerType)
	elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
		icon = DBM:ParseSpellIcon(texture or spellId, timerType)
		if timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
			colorType = 6
		end
	elseif timerType == "roleplay" then
		icon = DBM:ParseSpellIcon(texture or spellId, timerType, private.isRetail and 237538 or 136106)
		colorType = 6
	elseif timerType == "adds" or timerType == "addscustom" then
		icon = DBM:ParseSpellIcon(texture or spellId, timerType, 136116)
		colorType = 1
	else
		icon = DBM:ParseSpellIcon(texture or spellId, timerType)
		colorType = colorType or 0
	end
	local timerTextValue
	if timerText then
		--First check if it's shorttext
		if DBM.Options.ShortTimerText then
			--If timertext is a number, accept it as a secondary auto translate spellid
			if type(timerText) == "number" then
				timerTextValue = timerText
				spellName = DBM:GetSpellName(timerText or 0)--Override Cached spell Name
				--Automatically register alternate spellnames when detecting their use here
				if spellId and spellName and type(spellName) == "string" then
					DBM:RegisterAltSpellName(spellId, spellName)
				end
			--Interpret it literal with no restrictions, first checking mod local table, then just taking timerText directly
			else
				timerTextValue = self.localization.timers[timerText]--Check timers table first, otherwise accept it as literal timer text
				--Automatically register alternate spellnames when detecting their use here
				if spellId and not rawget(self.localization.timers, timerText) and type(timerText) == "string" then
					--if timerText exists in self.localization.timers table, it's not custom shorttext spell name
					--It's also not short text if it's hacky paul stuff, but that should be filtered by the spellID check in RegisterAltSpellName which ignores when he uses spellid of 0
					local trimmedText = timerText:gsub("%s*%(%%s%)", "")
					DBM:RegisterAltSpellName(spellId, trimmedText)
				end
			end
		else--Short text is off, we want to be more aggressive in NOT setting short text if we can help it
			--Short text is off, and spellId does exist, only accept timerText if it's in mods localization tables, cause then it's not short text, it's hard localization
			if spellId and type(spellId) == "number" then
				--Only use timerText if it's full localized, cause that's not shorttext
				timerTextValue = rawget(self.localization.timers, timerText)
			else--If no spellID, then we allow hard setting timerText because it's only translation timer object has
				timerTextValue = self.localization.timers[timerText]
			end
		end
	end
	local id = "Timer" .. (spellId or 0) .. timerType .. (optionVersion or "")
	local simpType = timerTypeSimplification[timerType] or timerType
	local waSpecialKey = waKeyOverrides[timerType]
	---@class Timer
	local obj = setmetatable(
		{
			objClass = "Timer",
			text = timerTextValue,
			type = timerType,
			simpType = simpType,
			waSpecialKey = waSpecialKey,--Not same as simpType, this overrides option key
			spellId = spellId,
			name = spellName,--If name gets stored as nil, it'll be corrected later in Timer start, if spell name returns in a later attempt
			timer = timer,
			id = id,
			icon = icon,
			colorType = colorType,
			inlineIcon = inlineIcon,
			keep = keep,
			countdown = countdown,
			countdownMax = countdownMax,
			r = r,
			g = g,
			b = b,
			requiresCombat = requiresCombat,
			isPriority = isPriority or false,
			allowdouble = allowdouble,
			hasVariance = hasVariance,
			minTimer = minTimer,
			timerStringWithVariance = timerStringWithVariance,
			varianceDuration = varianceDuration,
			startedTimers = {},
			mod = self,
		},
		mt
	)
	test:Trace(self, "NewTimer", obj, obj.type)
	obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, timerType)
	tinsert(self.timers, obj)
	-- todo: move the string creation to the GUI with SetFormattedString...
	if not self.localization.options[id] or self.localization.options[id] == id then
		if timerType == "achievement" then
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format((GetAchievementLink(spellId) or ""):gsub("%[(.+)%]", "%1"))
		elseif timerType == "cdspecial" or timerType == "cdcombo" or timerType == "nextspecial" or timerType == "nextcombo" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "intermission" or timerType == "intermissioncount" or timerType == "adds" or timerType == "addscustom" or timerType == "roleplay" or timerType == "combat" then--Timers without spellid, generic (do not add stagecontext here, it has spellname parsing)
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
		end
	end
	return obj
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewTargetTimer(...)
	return newTimer(self, "target", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewTargetCountTimer(...)
	return newTimer(self, "targetcount", ...)
end

--Buff/Debuff/event on boss
---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewBuffActiveTimer(...)
	return newTimer(self, "active", ...)
end

----Buff/Debuff on players
---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewBuffFadesTimer(...)
	return newTimer(self, "fades", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCastTimer(timer, ...)
	if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
		local spellId = timer
		timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
		local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
		timer = timer / spellHaste -- calculate the real cast time of the spell...
		return self:NewCastTimer(timer / 1000, spellId, ...)
	end
	return newTimer(self, "cast", timer, ...)
end

---Duplicate of NewCastTimer, but sets "high priority" without a million nils needed and is nameplate only
---@param timer number|string
---@param spellId number|string?
---@param timerText number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param colorType number?
---@param texture number|string?
---@param inlineIcon string?
---@param keep boolean?
---@param countdown number?
---@param countdownMax number?
---@param r number?
---@param g number?
---@param b number?
---@param requiresCombat boolean?
function bossModPrototype:NewCastNPTimer(timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat)
	--This verion doesn't auto cast time, because that'd be ugly
	return newTimer(self, "castpnp", timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat, true)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCastCountTimer(timer, ...)
	if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
		local spellId = timer
		timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
		local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
		timer = timer / spellHaste -- calculate the real cast time of the spell...
		return self:NewCastTimer(timer / 1000, spellId, ...)
	end
	return newTimer(self, "castcount", timer, ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCastSourceTimer(timer, ...)
	if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
		local spellId = timer
		timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
		local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
		timer = timer / spellHaste -- calculate the real cast time of the spell...
		return self:NewCastSourceTimer(timer / 1000, spellId, ...)
	end
	return newTimer(self, "castsource", timer, ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDTimer(...)
	return newTimer(self, "cd", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDCountTimer(...)
	return newTimer(self, "cdcount", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDSourceTimer(...)
	return newTimer(self, "cdsource", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDSpecialTimer(...)
	return newTimer(self, "cdspecial", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDComboTimer(...)
	return newTimer(self, "cdcombo", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextTimer(...)
	return newTimer(self, "next", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextCountTimer(...)
	return newTimer(self, "nextcount", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextSourceTimer(...)
	return newTimer(self, "nextsource", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextSpecialTimer(...)
	return newTimer(self, "nextspecial", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextComboTimer(...)
	return newTimer(self, "nextcombo", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewVarTimer(...)
	return newTimer(self, "var", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewVarCountTimer(...)
	return newTimer(self, "varcount", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewVarSourceTimer(...)
	return newTimer(self, "varsource", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewVarSpecialTimer(...)
	return newTimer(self, "varspecial", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewVarComboTimer(...)
	return newTimer(self, "varcombo", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewAchievementTimer(...)
	return newTimer(self, "achievement", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewStageTimer(...)
	return newTimer(self, "stage", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewStageCountTimer(...)
	return newTimer(self, "stagecount", ...)
end

---Used mainly for compat with BW/LW timers where they use "stages" but then use the spell/journal descriptor instead of "stage d"
---<br>Basically, it's a generic spellName timer for "stages" callback
---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewStageContextTimer(...)
	return newTimer(self, "stagecontext", ...)
end

---Same as NewStageContextTimer, with count
---<br>Basically, it's a generic spellName timer for "stages" callback
---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewStageContextCountTimer(...)
	return newTimer(self, "stagecontextcount", ...)
end

---For a fight that alternates stage 1 and stage 2, but also tracks total cycles. Example: Stage 2 (3)
---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewStageCountCycleTimer(...)
	return newTimer(self, "stagecountcycle", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewIntermissionTimer(...)
	return newTimer(self, "intermission", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewIntermissionCountTimer(...)
	return newTimer(self, "intermissioncount", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewRPTimer(...)
	return newTimer(self, "roleplay", ...)
end

function bossModPrototype:NewCombatTimer(timer)
	return newTimer(self, "combat", timer, nil, nil, nil, nil, 0, "132349", nil, nil, 1, 5)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewAddsTimer(...)
	return newTimer(self, "adds", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewAddsCustomTimer(...)
	return newTimer(self, "addscustom", ...)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewCDNPTimer(...)
	return newTimer(self, "cdnp", ...)
end

---Duplicate of NewCDNPTimer, but sets "high priority" without a million nils needed
---@param timer number|string
---@param spellId number|string?
---@param timerText number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param colorType number?
---@param texture number|string?
---@param inlineIcon string?
---@param keep boolean?
---@param countdown number?
---@param countdownMax number?
---@param r number?
---@param g number?
---@param b number?
---@param requiresCombat boolean?
function bossModPrototype:NewCDPNPTimer(timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat)
	return newTimer(self, "cdpnp", timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat, true)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewNextNPTimer(...)
	return newTimer(self, "nextnp", ...)
end

---Duplicate of NewNextNPTimer, but sends "high priority" without a million nils needed
---@param timer number|string
---@param spellId number|string?
---@param timerText number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param colorType number?
---@param texture number|string?
---@param inlineIcon string?
---@param keep boolean?
---@param countdown number?
---@param countdownMax number?
---@param r number?
---@param g number?
---@param b number?
---@param requiresCombat boolean?
function bossModPrototype:NewNextPNPTimer(timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat)
	return newTimer(self, "nextpnp", timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat, true)
end

---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
function bossModPrototype:NewAITimer(...)
	return newTimer(self, "ai", ...)
end

function bossModPrototype:GetLocalizedTimerText(timerType, spellId, Name)
	local spellName
	if Name then
		spellName = Name--Pull from name stored in object
	elseif spellId then
		DBM:Debug("|cffff0000GetLocalizedTimerText fallback, this should not happen and is a bug. this fallback should be deleted if this message is never seen after async code is live|r")
		spellName = DBM:ParseSpellName(spellId, timerType)
		--Name wasn't provided, but we succeeded in getting a name, generate one into object now for caching purposes
		--This would really only happen if GetSpellName failed to return spell name on first attempt (which now happens in 9.0)
		if spellName then
			self.name = spellName
		end
	end
	return pformat(L.AUTO_TIMER_TEXTS[timerType], spellName)
end
