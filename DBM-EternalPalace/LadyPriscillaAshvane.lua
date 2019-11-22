local mod	= DBM:NewMod(2354, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152236)
mod:SetEncounterID(2304)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 6, 7)
mod:SetHotfixNoticeRev(20190724000000)--2019, 7, 24
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297398",
	"SPELL_CAST_SUCCESS 296569 296662 296725 298056",
	"SPELL_AURA_APPLIED 296650 296725 296943 296940 296942 296939 296941 296938 297397 302989",
	"SPELL_AURA_REMOVED 296650 296943 296940 296942 296939 296941 296938 297397 302989",
	"SPELL_PERIODIC_DAMAGE 296752",
	"SPELL_PERIODIC_MISSED 296752"
)

--[[
(ability.id = 297402 or ability.id = 297398 or ability.id = 297324) and type = "begincast"
 or (ability.id = 296569 or ability.id = 296944 or ability.id = 296725 or ability.id = 296662 or ability.id = 298056) and type = "cast"
 or ability.id = 296650 and (type = "applybuff" or type = "removebuff")
 or ability.id = 296943 or ability.id = 296940 or ability.id = 296942 or ability.id = 296939 or ability.id = 296941 or ability.id = 296938
--]]
--TODO, there still exists a bug where despite being coded correctly, mod doesn't cancel shit it's supposed to. Something is probably broken in DBM-Core when calling :Stop() on a count timer
local warnShield						= mod:NewTargetNoFilterAnnounce(296650, 2, nil, nil, nil, nil, nil, 2)
local warnShieldOver					= mod:NewEndAnnounce(296650, 2, nil, nil, nil, nil, nil, 2)
--local warnCoral						= mod:NewCountAnnounce(296555, 2)
local warnBrinyBubble					= mod:NewTargetNoFilterAnnounce(297324, 4)
local warnUpsurge						= mod:NewSpellAnnounce(298055, 3)

local specWarnRipplingWave				= mod:NewSpecialWarningCount(296688, false, nil, 2, 2, 2)
local specWarnBarnacleBash				= mod:NewSpecialWarningTaunt(296725, nil, nil, nil, 1, 2)
local specWarnBubbleTaunt				= mod:NewSpecialWarningTaunt(297324, nil, nil, nil, 1, 2)
local specWarnBrinyBubble				= mod:NewSpecialWarningMoveAway(297324, nil, nil, nil, 1, 2)
local yellBrinyBubble					= mod:NewYell(297324)
local yellBrinyBubbleFades				= mod:NewShortFadesYell(297324)
local specWarnBrinyBubbleNear			= mod:NewSpecialWarningClose(297324, false, nil, 2, 1, 2)
local specWarnArcingAzerite				= mod:NewSpecialWarningYouPos(296944, nil, nil, nil, 3, 9)
local yellArcingAzerite					= mod:NewPosYell(296944, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local yellArcingAzeriteFades			= mod:NewIconFadesYell(296944)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(296752, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--local timerCoralGrowthCD				= mod:NewCDCountTimer(30, 296555, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerRipplingwaveCD				= mod:NewCDCountTimer(35, 296688, nil, nil, nil, 3, nil, nil, nil, 3, 4)
local timerBarnacleBashCD				= mod:NewCDCountTimer(15, 296725, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON, nil, mod:IsTank() and 2, 4)
local timerBrinyBubbleCD				= mod:NewCDCountTimer(15, 297324, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON, nil, 2, 4)
local timerUpsurgeCD					= mod:NewCDCountTimer(15.3, 298055, nil, nil, nil, 3)
--Stage 2
local timerArcingAzeriteCD				= mod:NewCDCountTimer(35, 296944, nil, nil, nil, 3, nil, nil, nil, 3, 4)
local timerShieldCD						= mod:NewCDTimer(70.5, 296650, nil, nil, nil, 6, nil, nil, nil, 1, 4)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("4/12")
mod:AddInfoFrameOption(296650, true)
mod:AddSetIconOption("SetIconOnArcingAzerite", 296944, false, false, {1, 2, 3, 4, 6, 7})

mod.vb.coralGrowth = 0
mod.vb.ripplingWave = 0
mod.vb.spellPicker = 0
mod.vb.arcingCast = 0
mod.vb.upsurgeCast = 0
mod.vb.shieldCount = 0
mod.vb.shieldDown = false
mod.vb.blueone, mod.vb.bluetwo = nil, nil
mod.vb.redone, mod.vb.redtwo = nil, nil
mod.vb.greenone, mod.vb.greentwo = nil, nil
local easyUpSurgeTimers = {0, 16, 37.9, 16.5, 16, 24}

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		if mod.vb.blueone and mod.vb.bluetwo then
			addLine("|TInterface\\Icons\\Ability_Bossashvane_Icon03.blp:12:12|t*"..mod.vb.blueone, mod.vb.bluetwo)
		end
		if mod.vb.redone and mod.vb.redtwo then
			addLine("|TInterface\\Icons\\Ability_Bossashvane_Icon02.blp:12:12|t*"..mod.vb.redone, mod.vb.redtwo)
		end
		if mod.vb.greenone and mod.vb.greentwo then
			addLine("|TInterface\\Icons\\Ability_Bossashvane_Icon01.blp:12:12|t*"..mod.vb.greenone, mod.vb.greentwo)
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.coralGrowth = 0
	self.vb.ripplingWave = 0
	self.vb.spellPicker = 0
	self.vb.arcingCast = 0
	self.vb.upsurgeCast = 0
	self.vb.shieldCount = 0
	self.vb.shieldDown = false
	self.vb.blueone, self.vb.bluetwo = nil, nil
	self.vb.redone, self.vb.redtwo = nil, nil
	self.vb.greenone, self.vb.greentwo = nil, nil
	berserkTimer:Start(self:IsMythic() and 505 or self:IsHeroic() and 559-delay)--Not seen normal mode berserk yet
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297398 then--Briny Bubble. 297398 verified, other two unknown (or spellId == 297402 or spellId == 297324)
		self.vb.spellPicker = 0
		--Always 15.9 seconds after in all difficulties when shield is up, but when shield is down, it's 24 seconds after on easy but still 15.9 on hard
		timerBarnacleBashCD:Start(not self.vb.shieldDown and self:IsEasy() and 23.9 or 15.9, 1)--start to success
		DBM:Debug("Ashvane timer debuging. New timer started for bash", 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 296569 then
		self.vb.coralGrowth = self.vb.coralGrowth + 1
		--warnCoral:Show(self.vb.coralGrowth)
		--timerCoralGrowthCD:Start(30, self.vb.coralGrowth+1)
	--elseif spellId == 296944 then
	--	timerArcingAzeriteCD:Start()
	elseif spellId == 296725 then--Barnacle Bash
		self.vb.spellPicker = self.vb.spellPicker + 1
		if self.vb.spellPicker == 2 then--Two bash been cast, Briny is next
			timerBrinyBubbleCD:Start(self.vb.shieldDown and 9.9 or self:IsLFR() and 15 or 13.9, self.vb.spellPicker+1)--Success to start
			DBM:Debug("Ashvane timer debuging. New timer started for bubble", 2)
		else
			timerBarnacleBashCD:Start(14.9, self.vb.spellPicker+1)--success to success
			DBM:Debug("Ashvane timer debuging. New timer started for bash", 2)
		end
	elseif spellId == 296662 then
		self.vb.ripplingWave = self.vb.ripplingWave + 1
		specWarnRipplingWave:Show(self.vb.ripplingWave)
		specWarnRipplingWave:Play("watchwave")
		timerRipplingwaveCD:Start(self:IsEasy() and 70.5 or 30, self.vb.ripplingWave+1)
	elseif spellId == 298056 then--Upsurge
		self.vb.upsurgeCast = self.vb.upsurgeCast + 1
		warnUpsurge:Show(self.vb.upsurgeCast)
		if self.vb.shieldDown and self.vb.upsurgeCast == 1 then
			timerUpsurgeCD:Start(43.9, 2)
		else
			if self:IsHard() then--Simple Alternation
				--Hard: n, 14.9, 30, 15, 29.9, 15, 30.4
				if self.vb.upsurgeCast % 2 == 0 then
					timerUpsurgeCD:Start(29.9, self.vb.upsurgeCast+1)
				else
					timerUpsurgeCD:Start(14.9, self.vb.upsurgeCast+1)
				end
			else
				--Easy: n, 16, 37.9, 16.5, 16, 24
				local timer = easyUpSurgeTimers[self.vb.upsurgeCast+1]
				if timer then
					timerUpsurgeCD:Start(timer, self.vb.upsurgeCast+1)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296650 then
		self.vb.shieldCount = self.vb.shieldCount + 1
		self.vb.shieldDown = false
		warnShield:Show(args.destName)
		warnShield:Play("phasechange")
		self.vb.coralGrowth = 0
		self.vb.ripplingWave = 0
		self.vb.spellPicker = 0
		self.vb.upsurgeCast = 0
		timerUpsurgeCD:Stop()
		timerBarnacleBashCD:Stop()
		timerBarnacleBashCD:Stop(1)
		timerBarnacleBashCD:Stop(2)
		timerBrinyBubbleCD:Stop()
		timerBrinyBubbleCD:Stop(3)
		timerArcingAzeriteCD:Stop()
		timerShieldCD:Stop()
		DBM:Debug("Ashvane timer debuging. Timers should be stopped for good this time", 2)
		local easy = self:IsEasy() or false
		if self.vb.shieldCount == 1 then
			timerBarnacleBashCD:Start(easy and 10 or 8, 1)--SUCCESS
			DBM:Debug("Ashvane timer debuging. New timer started for bash", 2)
			timerUpsurgeCD:Start(easy and 12 or 9, 1)
			timerRipplingwaveCD:Start(easy and 17 or 15, 1)
			--timerCoralGrowthCD:Start(30.5, 1)
		else
			timerUpsurgeCD:Start(easy and 15.5 or 12, 1)
			timerBarnacleBashCD:Start(easy and 13.8 or 11.5, 1)--SUCCESS
			DBM:Debug("Ashvane timer debuging. New timer started for bash", 2)
			timerRipplingwaveCD:Start(20.5, 1)
			--timerCoralGrowthCD:Start(30.5, 1)
		end
		if self.Options.RangeFrame then
			if self:IsRanged() then
				DBM.RangeCheck:Show(12)
			else
				DBM.RangeCheck:Show(4)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 296725 then
		if not args:IsPlayer() and self.vb.spellPicker < 2 then
			--Only show for first bash, there is no reason to taunt after 2nd bash, at least not until bubble, which has it's own taunt warning
			specWarnBarnacleBash:Show(args.destName)
			specWarnBarnacleBash:Play("tauntboss")
		end
	elseif spellId == 296943 or spellId == 296940 or spellId == 296942 or spellId == 296939 or spellId == 296941 or spellId == 296938 then--Arcing Azerite
		--Not in combat log, blizzard hates combat log
		if self:AntiSpam(5, 1) then
			self.vb.arcingCast = self.vb.arcingCast + 1
			if self.vb.arcingCast == 1 then
				timerArcingAzeriteCD:Start(34.9, 2)
			end
		end
		if (spellId == 296941 or spellId == 296938) then--Green
			if args:IsPlayer() then
				specWarnArcingAzerite:Show("|TInterface\\Icons\\Ability_Bossashvane_Icon01.blp:12:12|tGreen|TInterface\\Icons\\Ability_Bossashvane_Icon01.blp:12:12|t|")
				specWarnArcingAzerite:Play("breakcoral")
				yellArcingAzerite:Yell(4, "")
				yellArcingAzeriteFades:Countdown(spellId, nil, 4)
			end
			if spellId == 296941 then
				self.vb.greenone = args.destName
			else
				self.vb.greentwo = args.destName
			end
			--star(1) and triangle(4)
			if self.Options.SetIconOnArcingAzerite then
				self:SetSortedIcon(1, args.destName, {1, 4}, 2, nil, nil, 1)--TODO, return function announce maybe?
			end
		elseif (spellId == 296942 or spellId == 296939) then--Red (orange BW)
			if args:IsPlayer() then
				specWarnArcingAzerite:Show("|TInterface\\Icons\\Ability_Bossashvane_Icon02.blp:12:12|tRed|TInterface\\Icons\\Ability_Bossashvane_Icon02.blp:12:12|t")
				specWarnArcingAzerite:Play("breakcoral")
				yellArcingAzerite:Yell(7, "")
				yellArcingAzeriteFades:Countdown(spellId, nil, 7)
			end
			if spellId == 296942 then
				self.vb.redone = args.destName
			else
				self.vb.redtwo = args.destName
			end
			--circle(2) and cross(7)
			if self.Options.SetIconOnArcingAzerite then
				self:SetSortedIcon(1, args.destName, {2, 7}, 2, nil, nil, 2)--TODO, return function announce maybe?
			end
		elseif (spellId == 296943 or spellId == 296940) then--Blue (Purple BW)
			if args:IsPlayer() then
				specWarnArcingAzerite:Show("|TInterface\\Icons\\Ability_Bossashvane_Icon03.blp:12:12|tBlue|TInterface\\Icons\\Ability_Bossashvane_Icon03.blp:12:12|t")
				specWarnArcingAzerite:Play("breakcoral")
				yellArcingAzerite:Yell(6, "")
				yellArcingAzeriteFades:Countdown(spellId, nil, 6)
			end
			if spellId == 296943 then
				self.vb.blueone = args.destName
			else
				self.vb.bluetwo = args.destName
			end
			--diamond(3) and moon(6)
			if self.Options.SetIconOnArcingAzerite then
				self:SetSortedIcon(1, args.destName, {3, 6}, 2, nil, nil, 3)--TODO, return function announce maybe?
			end
		end
		if self.Options.InfoFrame then
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false, true)
			else
				DBM.InfoFrame:Update()
			end
		end
	elseif spellId == 297397 or spellId == 302989 then--Briny targetting spell
		warnBrinyBubble:CombinedShow(0.3, args.destname)
		if args:IsPlayer() then
			specWarnBrinyBubbleNear:Cancel()
			specWarnBrinyBubbleNear:CancelVoice()
			specWarnBrinyBubble:Show()
			specWarnBrinyBubble:Play("runout")
			yellBrinyBubble:Yell()
			yellBrinyBubbleFades:Countdown(spellId)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBubbleTaunt:Show(args.destName)
				specWarnBubbleTaunt:Play("tauntboss")
			end
			if self:CheckNearby(12, args.destName) and not DBM:UnitDebuff("player", spellId) then
				specWarnBrinyBubbleNear:CombinedShow(0.3, args.destName)
				specWarnBrinyBubbleNear:ScheduleVoice(0.3, "runaway")
			end
		end
	--[[elseif spellId == 297333 or spellId == 302992 then--Briny in bubble spell
		if args:IsPlayer() then
			--Yell again, but no further special warnings
			yellBrinyBubble:Yell()
		end--]]
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296650 then
		self.vb.shieldDown = true
		self.vb.spellPicker = 0
		self.vb.upsurgeCast = 0
		self.vb.arcingCast = 0
		warnShieldOver:Show()
		warnShieldOver:Play("phasechange")
		--timerCoralGrowthCD:Stop()
		timerRipplingwaveCD:Stop()
		timerBrinyBubbleCD:Stop()
		timerBrinyBubbleCD:Stop(3)--Because calling without arg apparently doesn't work since core is broken
		timerUpsurgeCD:Stop()
		timerBarnacleBashCD:Stop()
		timerBarnacleBashCD:Stop(1)--Because calling without arg apparently doesn't work since core is broken
		timerBarnacleBashCD:Stop(2)--Because calling without arg apparently doesn't work since core is broken
		DBM:Debug("Ashvane timer debuging. Timers should be stopped for good this time", 2)
		timerBarnacleBashCD:Start(13, 1)--SUCCESS
		DBM:Debug("Ashvane timer debuging. New timer started for bash", 2)
		timerUpsurgeCD:Start(17.5, 1)
		timerArcingAzeriteCD:Start(20.5, 1)
		timerShieldCD:Start(70.5)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif spellId == 296943 or spellId == 296940 or spellId == 296942 or spellId == 296939 or spellId == 296941 or spellId == 296938 then--Arcing Azerite
		if args:IsPlayer() then
			yellArcingAzeriteFades:Cancel()
		end
		if (spellId == 296943 or spellId == 296940) then--Blue
			if spellId == 296943 then
				self.vb.blueone = nil
			else
				self.vb.bluetwo = nil
			end
		elseif (spellId == 296942 or spellId == 296939) then--Red
			if spellId == 296942 then
				self.vb.redone = nil
			else
				self.vb.redtwo = nil
			end
		elseif (spellId == 296941 or spellId == 296938) then--Green/Yellow
			if spellId == 296941 then
				self.vb.greenone = nil
			else
				self.vb.greentwo = nil
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
		if self.Options.SetIconOnArcingAzerite then
			self:SetIcon(args.destName, 0)
		end
	elseif (spellId == 297397 or spellId == 302989) and args:IsPlayer() then--Briny targetting spell
		yellBrinyBubbleFades:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 296752 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
