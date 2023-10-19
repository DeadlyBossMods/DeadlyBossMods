local mod	= DBM:NewMod("d285", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

if mod:IsRetail() then--10.1.7 fight rework
	mod:SetZone(1004)
	mod:SetCreatureID(207438)
	mod:SetEncounterID(2725)

	mod:RegisterCombat("combat")

	mod:RegisterEvents(
		"GOSSIP_SHOW"
	)

	mod:RegisterEventsInCombat(
		"SPELL_CAST_START 415262 423626 414844 415047",
		"SPELL_AURA_APPLIED 423623",
		"SPELL_DAMAGE 415329",
		"SPELL_MISSED 415329"
	)

	--TODO, better detection of curse activation on player and additional warnings for effects
	local warnVineMarch									= mod:NewSpellAnnounce(415047, 3)

	local specWarnHotHead								= mod:NewSpecialWarningYou(423626, nil, nil, nil, 1, 2)
	local specWarnInsidiousCackle						= mod:NewSpecialWarningMoveAway(415262, nil, nil, nil, 1, 2)
	local specWarnPumpkinBreath							= mod:NewSpecialWarningDodgeCount(414844, nil, nil, nil, 2, 2)
	local specWarnGTFO									= mod:NewSpecialWarningGTFO(415329, nil, nil, nil, 1, 8)

	local timerHotHeadCD								= mod:NewCDCountTimer(49, 423626, nil, nil, nil, 3)
	local timerInsidiousCackleCD						= mod:NewCDCountTimer(41.4, 415262, nil, nil, nil, 2)
	local timerPumpkinBreathCD							= mod:NewCDCountTimer(41.4, 414844, nil, nil, nil, 3)
	local timerVineMarchCD								= mod:NewCDCountTimer(41.4, 415047, nil, nil, nil, 1)

	mod:AddBoolOption("AGCurses", false)
	mod:AddBoolOption("AGBoss", false)

	mod.vb.cackleCount = 0
	mod.vb.breathCount = 0
	mod.vb.vineCount = 0
	mod.vb.hotCount = 0
	local allTimers = {
		--Insidious Cackle
		[415262] = {35.3, 54.6},
		--Pumpkin Breath
		[414844] = {6.1, 41.3, 54.6},
		--Vine March
		[415047] = {20.6, 54.6, 42.5},
		--Hot Head
		[423626] = {62}--Sometimes 77? might still have a checkpoint/dps check to be 62
	}

	function mod:OnCombatStart(delay)
		self.vb.cackleCount = 0
		self.vb.breathCount = 0
		self.vb.vineCount = 0
		self.vb.hotCount = 0
		timerPumpkinBreathCD:Start(6-delay, 1)
		timerVineMarchCD:Start(20-delay, 1)
		timerInsidiousCackleCD:Start(35-delay, 1)
		timerHotHeadCD:Start(62, 1)
	end

	function mod:SPELL_CAST_START(args)
		local spellId = args.spellId
		if spellId == 415262 then
			self.vb.cackleCount = self.vb.cackleCount + 1
			specWarnInsidiousCackle:Show(self.vb.cackleCount)
			specWarnInsidiousCackle:Play("scatter")
			local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.cackleCount+1)
			if timer then
				timerInsidiousCackleCD:Start(timer, self.vb.cackleCount+1)
			end
		elseif spellId == 414844 then
			self.vb.breathCount = self.vb.breathCount + 1
			specWarnPumpkinBreath:Show(self.vb.breathCount)
			specWarnPumpkinBreath:Play("breathsoon")
			local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.breathCount+1)
			if timer then
				timerPumpkinBreathCD:Start(timer, self.vb.breathCount+1)
			end
		elseif spellId == 423626 then
			self.vb.hotCount = self.vb.hotCount + 1
			local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.hotCount+1)
			if timer then
				timerHotHeadCD:Start(timer, self.vb.hotCount+1)
			end
		elseif spellId == 415047 then
			warnVineMarch:Show(self.vb.vineCount)
			local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.vineCount+1)
			if timer then
				timerVineMarchCD:Start(timer, self.vb.ignitingCount+1)
			end
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		local spellId = args.spellId
		if spellId == 423623 then
			if args:IsPlayer() then
				specWarnHotHead:Show()
				specWarnHotHead:Play("keepmove")
			end
		end
	end

	function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
		if spellId == 415329 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
			specWarnGTFO:Show(spellName)
			specWarnGTFO:Play("watchfeet")
		end
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE

	function mod:GOSSIP_SHOW()
		local gossipOptionID = self:GetGossipID()
		if gossipOptionID then
			--Embers, Delusions, Shadows, Thorns
			if self.Options.AGCurses and (gossipOptionID == 110383 or gossipOptionID == 110379 or gossipOptionID == 110372 or gossipOptionID == 110377) then
				self:SelectGossip(gossipOptionID)
			end
			if self.Options.AGBoss and gossipOptionID == 36316 then
				self:SelectGossip(gossipOptionID)
			end
		end
	end
else--OG fight, for classic (when world events are reunified that is
	mod:SetZone(189)
	mod:SetCreatureID(23682, 23775)
	--mod:SetModelID(22351)--Model doesn't work/render for some reason.

	mod:SetReCombatTime(10)
	mod:RegisterCombat("combat")

	--mod:RegisterEvents(
	--	"CHAT_MSG_SAY"
	--)

	mod:RegisterEventsInCombat(
		"SPELL_AURA_APPLIED 42380 42514",
		"UNIT_SPELLCAST_SUCCEEDED target focus",
		"CHAT_MSG_MONSTER_SAY",
		"UNIT_DIED"
	)

	local warnConflag				= mod:NewTargetAnnounce(42380, 3)
	local warnSquashSoul			= mod:NewTargetAnnounce(42514, 2, nil, false, 2)
	local warnPhase					= mod:NewAnnounce("WarnPhase", 2, "136116")
	local warnHorsemanSoldiers		= mod:NewAnnounce("warnHorsemanSoldiers", 2, 97133)
	local warnHorsemanHead			= mod:NewAnnounce("warnHorsemanHead", 3)

	--local timerCombatStart			= mod:NewCombatTimer(17)--rollplay for first pull
	local timerConflag				= mod:NewTargetTimer(4, 42380, nil, "Healer", nil, 3)
	local timerSquashSoul			= mod:NewTargetTimer(15, 42514, nil, false, 2, 3)

	function mod:SPELL_AURA_APPLIED(args)
		local spellId = args.spellId
		if spellId == 42380 then					-- Conflagration
			warnConflag:Show(args.destName)
			timerConflag:Start(args.destName)
		elseif spellId == 42514 then				-- Squash Soul
			warnSquashSoul:Show(args.destName)
			timerSquashSoul:Start(args.destName)
		end
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	--	"<48.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax - Command, Head Repositions::0:42410", -- [35]
		if spellId == 42410 then
			self:SendSync("HeadRepositions")
	--	"<23.0> Headless Horseman:Possible Target<nil>:target:Headless Horseman Climax, Body Stage 1::0:42547", -- [1]
		elseif spellId == 42547 then
			self:SendSync("BodyStage1")
	--	"<49.0> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 2::0:42548", -- [7]
		elseif spellId == 42548 then
			self:SendSync("BodyStage2")
	--	"<70.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 3::0:42549", -- [13]
		elseif spellId == 42549 then
			self:SendSync("BodyStage3")
		end
	end

	--Use syncing since these unit events require "target" or "focus" to detect.
	--At least someone in group should be targeting this stuff and sync it to those that aren't (like a healer)
	function mod:OnSync(event)
		if not self:IsInCombat() then return end
		if event == "HeadRepositions" then
			warnHorsemanHead:Show()
		elseif event == "BodyStage1" then
			warnPhase:Show(1)
		elseif event == "BodyStage2" then
			warnPhase:Show(2)
		elseif event == "BodyStage3" then
			warnPhase:Show(3)
		end
	end

	function mod:CHAT_MSG_MONSTER_SAY(msg)
		if msg == L.HorsemanSoldiers and self:AntiSpam(5, 1) then	-- Warning for adds spawning. No CLEU or UNIT event for it.
			warnHorsemanSoldiers:Show()
		end
	end

	--[[
	function mod:CHAT_MSG_SAY(msg)
		if msg == L.HorsemanSummon and self:AntiSpam(5) then		-- Summoned
			timerCombatStart:Start()
		end
	end--]]

	function mod:UNIT_DIED(args)
		if self:GetCIDFromGUID(args.destGUID) == 23775 then
			DBM:EndCombat(self)
		end
	end
end
