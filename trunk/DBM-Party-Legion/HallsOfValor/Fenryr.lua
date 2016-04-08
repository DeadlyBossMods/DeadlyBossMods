local mod	= DBM:NewMod(1487, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95674)
mod:SetEncounterID(1807)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197556 196838",
	"SPELL_AURA_REMOVED 196838",
	"SPELL_CAST_START 196838 196543",
	"SPELL_CAST_SUCCESS 196567 196512 207707"
)

--TODO, his timers could be all wrong.Hard to say with a single pull that was short.
local warnLeap							= mod:NewTargetAnnounce(197556, 2)
local warnPhase2						= mod:NewPhaseAnnounce(2, 2)
local warnFixate						= mod:NewTargetAnnounce(196838, 3)
local warnClawFrenzy					= mod:NewSpellAnnounce(196512, 2, nil, "Tank")

local specWarnLeap						= mod:NewSpecialWarningMoveAway(197556, nil, nil, nil, 1, 2)
local yellLeap							= mod:NewYell(197556)
local specWarnHowl						= mod:NewSpecialWarningCast(196543, "SpellCaster", nil, nil, 1, 2)
local specWarnFixate					= mod:NewSpecialWarningRun(196838, nil, nil, nil, 4, 2)
local specWarnFixateOver				= mod:NewSpecialWarningEnd(196838, nil, nil, nil, 1)
local specWarnWolves					= mod:NewSpecialWarningSwitch("ej12600", "Tank")

local timerLeapCD						= mod:NewCDTimer(31, 197556, nil, nil, nil, 3)--31-36
--local timerClawFrenzyCD					= mod:NewCDTimer(10, 196512, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--All over the place
local timerHowlCD						= mod:NewCDTimer(31.5, 196543, nil, "SpellCaster", nil, 2)--Poor data
local timerFixateCD						= mod:NewCDTimer(36, 196838, nil, nil, nil, 3)--Poor data
local timerWolvesCD						= mod:NewCDTimer(35, "ej12600", nil, nil, nil, 1, 199184)

local voiceLeap							= mod:NewVoice(197556)--runout
local voiceHowl							= mod:NewVoice(196543, "SpellCaster")--stopcast
local voicePhaseChange					= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceFixate						= mod:NewVoice(196838)--runaway/keepmove

mod:AddRangeFrameOption(10, 197556)

function mod:FixateTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(5, targetname) then
		if targetname == UnitName("player") then
			specWarnFixate:Show()
			voiceFixate:Play("runaway")
			voiceFixate:Schedule(1, "keepmove")
		else
			warnFixate:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetWipeTime(5)
--	timerClawFrenzyCD:Start(19-delay)
	timerHowlCD:Start(8-delay)--Verify changes
	timerLeapCD:Start(12-delay)--Verify changes
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197556 then
		warnLeap:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLeap:Show()
			voiceLeap:Play("runout")
			yellLeap:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 196838 then
		--Backup if target scan failed
		if self:AntiSpam(5, args.destName) then
			if args:IsPlayer() then
				specWarnFixate:Show()
				voiceFixate:Play("runaway")
				voiceFixate:Schedule(1, "keepmove")
			else
				warnFixate:Show(args.destName)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197556 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 196838 and args:IsPlayer() then
		specWarnFixateOver:Show()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196838 then
		timerFixateCD:Start()
		self:BossTargetScanner(95674, "FixateTarget", 0.2, 12, true, nil, nil, nil, true)--Target scanning used to grab target 2-3 seconds faster. Doesn't seem to anymore?
	elseif spellId == 196543 then
		specWarnHowl:Show()
		voiceHowl:Play("stopcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 196567 then--Stealth (boss retreat)
		--Stop all timers but not combat
		for i, v in ipairs(self.timers) do
			v:Stop()
		end
		--Artificially set no wipe to 10 minutes
		self:SetWipeTime(600)
		--Scan for Boss to be re-enraged
		self:RegisterShortTermEvents(
			"ENCOUNTER_START",
			"ZONE_CHANGED_NEW_AREA"
		)
	elseif spellId == 196512 then
		warnClawFrenzy:Show()
	elseif spellId == 207707 and self:AntiSpam(2, 1) then--Wolves spawning out of stealth
		specWarnWolves:Show()
		timerWolvesCD:Start()
	end
end

function mod:ENCOUNTER_START(encounterID)
	--Re-engaged, kill scans and long wipe time
	if encounterID == 1807 then
--		self:SetWipeTime(5)
--		self:UnregisterShortTermEvents()
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerWolvesCD:Start(5)
--		timerHowlCD:Start(5)--2-6, useless timer
--		timerFixateCD:Start(9.8)--7-20, useless timer
--		timerClawFrenzyCD:Start(27)
--		timerLeapCD:Start(30)--10-30, useless timer
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	--Left zone
	--Normal wipes respawn you sindie
	self:SetWipeTime(5)
	self:UnregisterShortTermEvents()
end
