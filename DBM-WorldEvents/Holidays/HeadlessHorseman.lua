local mod	= DBM:NewMod("d285", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

if mod:IsRetail() then--10.1.7 fight rework
	mod:SetCreatureID(207438)
	mod:SetEncounterID(2725)

--	mod:SetReCombatTime(10)
	mod:RegisterCombat("combat")

	mod:RegisterEventsInCombat(
		"SPELL_CAST_START 415262 423626 207438 415047",--423626
		"SPELL_AURA_APPLIED 423623",
		"SPELL_DAMAGE 415329",
		"SPELL_MISSED 415329"
	)

	local warnVineMarch									= mod:NewSpellAnnounce(415047, 3)

	local specWarnHotHead								= mod:NewSpecialWarningYou(423626, nil, nil, nil, 1, 2)
	local specWarnInsidiousCackle						= mod:NewSpecialWarningMoveAway(415262, nil, nil, nil, 1, 2)
	local specWarnPumpkinBreath							= mod:NewSpecialWarningDodge(414844, nil, nil, nil, 2, 2)
	local specWarnGTFO									= mod:NewSpecialWarningGTFO(415329, nil, nil, nil, 1, 8)

	--local timerHotHeadCD								= mod:NewCDTimer(49, 423626, nil, nil, nil, 3)
	local timerInsidiousCackleCD						= mod:NewCDTimer(41.4, 415262, nil, nil, nil, 2)
	local timerPumpkinBreathCD							= mod:NewCDTimer(41.4, 414844, nil, nil, nil, 3)
	local timerVineMarchCD								= mod:NewCDTimer(41.4, 415047, nil, nil, nil, 1)

	function mod:OnCombatStart(delay)
		timerPumpkinBreathCD:Start(6-delay)--6.1, 41.4, 54.6
		timerVineMarchCD:Start(20-delay)--20.8, 54.5, 42.5
		timerInsidiousCackleCD:Start(35-delay)--35.3, 54.6
		--timerHotHeadCD:Start(62.1)--Might be health based
	end

	function mod:SPELL_CAST_START(args)
		local spellId = args.spellId
		if spellId == 415262 then
			specWarnInsidiousCackle:Show()
			specWarnInsidiousCackle:Play("scatter")
			--timerInsidiousCackleCD:Start()
		elseif spellId == 414844 then
			specWarnPumpkinBreath:Show()
			specWarnPumpkinBreath:Play("breathsoon")
			--timerPumpkinBreathCD:Start()--More data needed
		elseif spellId == 423626 then
			--timerHotHeadCD:Start()
		elseif spellId == 415047 then
			warnVineMarch:Show()
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
else--OG fight, for classic (when world events are reunified that is
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
