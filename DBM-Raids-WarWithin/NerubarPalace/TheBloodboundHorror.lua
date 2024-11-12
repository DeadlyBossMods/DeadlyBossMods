local mod	= DBM:NewMod(2611, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214502)
mod:SetEncounterID(2917)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20240628000000)
--mod:SetMinSyncRevision(20230929000000)
mod:SetZone(2657)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444363 452237 445936 442530 451288 445016 445174",
	"SPELL_CAST_SUCCESS 443203 445016",
	"SPELL_SUMMON 444830 444835",
	"SPELL_AURA_APPLIED 443612 452245 443042 445272",
	"SPELL_AURA_APPLIED_DOSE 445272",
	"SPELL_AURA_REMOVED 443612 452245 443042",
	"SPELL_PERIODIC_DAMAGE 445518",
	"SPELL_PERIODIC_MISSED 445518",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe further warn when the aoe damage from Goresplatter starts for healers?
--TODO, possibly infoframe for Membrane healoffs?
--TODO, repeating yell for grasp? it spams bad stuff on ground for entire 12 seconds that affects other players
--TODO, fade boss timers and squelch boss alerts if player is in Baneful shift, if they are unaffected by boss abilities while shifted
--TODO, also announce add spawns if they aren't automatically spawn with another boss ability (like disgorge)
--TODO, can blood horrors be killed? should they be auto marked with https://www.wowhead.com/beta/spell=445197/manifest-horror ?
--TODO, Manifest Horror nameplate timer? i kinda assume it's just sort of spam cast til dead
--TODO, possibly rework timers to restart on Goresplatter so they can be more accurate and not rely in hacky fixes
--TODO, add spawn nameplate timer
--TODO, track personal https://www.wowhead.com/beta/spell=445570/unseeming-blight ?
--[[
(ability.id = 444363 or ability.id = 452237 or ability.id = 445936 or ability.id = 442530) and type = "begincast"
 or ability.id = 443203 and type = "cast"
 or ability.id = 443042 and type = "applydebuff"
 or (ability.id = 444830 or ability.id = 444835) and type = "summon"
 or (ability.id = 445174 or ability.id = 451288 or ability.id = 445016) and type = "begincast"
--]]
local warnBanefulShift							= mod:NewYouAnnounce(443612, 2)
local warnBanefulShiftFades						= mod:NewFadesAnnounce(443612, 2)
local warnCrimsonRain							= mod:NewCountAnnounce(443203, 2)
local warnGraspFromBeyondFades					= mod:NewFadesAnnounce(443042, 1, nil, nil, 367465, nil, nil, 2)

local specWarnGruesomeDisgorge					= mod:NewSpecialWarningCount(444363, nil, nil, DBM_COMMON_L.FRONTAL, 1, 15)
local specWarnBanefulShift						= mod:NewSpecialWarningTaunt(443612, nil, nil, nil, 1, 2)
local specWarnBloodcurdle						= mod:NewSpecialWarningMoveAway(452237, nil, nil, DBM_COMMON_L.SPREADS, 1, 2, 4)
local yellBloodcurdle							= mod:NewShortYell(452237)
local yellBloodcurdleFades						= mod:NewShortFadesYell(452237)
local specWarnSpewingHemorrhage					= mod:NewSpecialWarningDodgeCount(445936, nil, 207544, nil, 4, 2)
local specWarnGoresplatter						= mod:NewSpecialWarningRunCount(442530, nil, 301902, nil, 4, 2)
local specWarnGraspFromBeyond					= mod:NewSpecialWarningMoveAway(443042, nil, 367465, nil, 1, 2)
local yellGraspFromBeyond						= mod:NewShortYell(443042, 285205)--ShortYell "Tentacle"
local specWarnGTFO								= mod:NewSpecialWarningGTFO(445518, nil, nil, nil, 1, 8)

local timerGruesomeDigorgeCD					= mod:NewNextCountTimer(49, 444363, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBanefulShift							= mod:NewBuffFadesTimer(40, 443612, nil, nil, nil, 5)
local timerBloodcurdleCD						= mod:NewNextCountTimer(40, 452237, DBM_COMMON_L.SPREADS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSpewingHemorrhageCD					= mod:NewNextCountTimer(40, 445936, 207544, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Beams"
local timerGoresplatterCD						= mod:NewNextCountTimer(128, 442530, 301902, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.DEADLY_ICON)--Shortname "Run Away!"
local timerCrimsonRainCD						= mod:NewNextCountTimer(128, 443203, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerGraspFromBeyondCD					= mod:NewNextCountTimer(40, 443042, 367465, nil, nil, 3)--ShortYell "Tentacles"
--The Unseeming
mod:AddTimerLine(DBM:GetSpellName(462306))
local warnManifestHorror						= mod:NewCastAnnounce(445174, 4, nil, nil, false, 2)--Spammy, opt in
local warnBloodPact								= mod:NewStackAnnounce(445272, 2)

local specWarnBlackBulwark						= mod:NewSpecialWarningInterruptCount(451288, "HasInterrupt", 151702, nil, 1, 2)
local specWarnSpectralSlam						= mod:NewSpecialWarningDefensive(445016, nil, 182557, nil, 1, 2)

--These timers have large variations, especially when tanks outrange them or when they live through multiple groups phasing in
local timerBlackBulwarkCD						= mod:NewCDNPTimer(15.5, 451288, 151702, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer Shortname "Shield"
local timerSpectralSlamCD						= mod:NewCDNPTimer(13.4, 445016, 182557, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Nameplate only, larger variation. Shortname "Slam"

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnWatchers", 444830, true, 5, {4})
mod:AddSetIconOption("SetIconOnHarb", 444835, true, 5, {8, 7, 6, 5})--Support up to 2 sets of adds
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.disgorgeCount = 0
mod.vb.curdleCount = 0
mod.vb.hemorrhageCount = 0
mod.vb.goresplatterCount = 0
mod.vb.crimsonCount = 0
mod.vb.graspCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
--local playerPhased = false

---@param self DBMMod
local function missingCLEURain(self)
	self.vb.crimsonCount = self.vb.crimsonCount + 1
	warnCrimsonRain:Show(self.vb.crimsonCount)
	if self.vb.crimsonCount < 4 then
		timerCrimsonRainCD:Start(30, self.vb.crimsonCount+1)
	end
end

function mod:OnCombatStart(delay)
	self.vb.disgorgeCount = 0
	self.vb.curdleCount = 0
	self.vb.hemorrhageCount = 0
	self.vb.goresplatterCount = 0
	self.vb.crimsonCount = 0
	self.vb.graspCount = 0
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	--playerPhased = false
	timerCrimsonRainCD:Start(11, 1)
	timerGruesomeDigorgeCD:Start(self:IsMythic() and 14 or 16, 1)
	timerGraspFromBeyondCD:Start(self:IsMythic() and 19.1 or 22, 1)
	if self:IsHard() then
		timerSpewingHemorrhageCD:Start(32, 1)
	end
	if self:IsMythic() then
		timerBloodcurdleCD:Start(9, 1)
	end
	timerGoresplatterCD:Start(120, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 444363 then
		--16.0, 51.0, 77.0, 51.0, 77.0, 51.0, 77.1, 51.0 (heroic and normal)
		--14.0, 59.0, 69.1, 59.0, 69.1, 58.9, 69.0 (mythic)
		self.vb.disgorgeCount = self.vb.disgorgeCount + 1
		specWarnGruesomeDisgorge:Show(self.vb.disgorgeCount)
		specWarnGruesomeDisgorge:Play("frontal")
		if self.vb.disgorgeCount % 2 == 0 then
			timerGruesomeDigorgeCD:Start(self:IsMythic() and 69.1 or 77, self.vb.disgorgeCount+1)
		else
			timerGruesomeDigorgeCD:Start(self:IsMythic() and 59 or 51, self.vb.disgorgeCount+1)
		end
	elseif spellId == 452237 then
		--9.0, 32.0, 27.0, 32.0, 37.0, 32.0, 27.0, 32.0, 37.0, 32.0, 27.0, 32.0, 37.0, 32.0
		--(37.0, 32.0, 27.0, 32.0 repeating)
		self.vb.curdleCount = self.vb.curdleCount + 1
		if self.vb.curdleCount % 4 == 2 then
			timerBloodcurdleCD:Start(27, self.vb.curdleCount+1)
		elseif self.vb.curdleCount % 4 == 4 then
			timerBloodcurdleCD:Start(37, self.vb.curdleCount+1)
		else--1 and 3
			timerBloodcurdleCD:Start(32, self.vb.curdleCount+1)
		end
	elseif spellId == 445936 then
		--32.0, 49.0, 79.0, 49.0, 79.0, 49.0, 79.0, 49.0 (heroic)
		--32.0, 59.0, 69.1, 59.0, 69.0, 59.0, 69.0 (Mythic)
		self.vb.hemorrhageCount = self.vb.hemorrhageCount + 1
		specWarnSpewingHemorrhage:Show(self.vb.hemorrhageCount)
		specWarnSpewingHemorrhage:Play("farfromline")
		--32.3, 49.0, 78.9, 49.1, 79.0, 49.1, 79.0, 49.0
		--34.7, 46.4, 79.1, 49.0, 79.0, 49.0, 79.0, 49.0", (broken example if no tank in range)
		if self.vb.hemorrhageCount % 2 == 0 then
			timerSpewingHemorrhageCD:Start(self:IsMythic() and 69.1 or 78.9, self.vb.hemorrhageCount+1)
		else
			timerSpewingHemorrhageCD:Start(self:IsMythic() and 59 or 49, self.vb.hemorrhageCount+1)
		end
	elseif spellId == 442530 then
		self.vb.goresplatterCount = self.vb.goresplatterCount + 1
		specWarnGoresplatter:Show(self.vb.goresplatterCount)
		specWarnGoresplatter:Play("justrun")
		timerGoresplatterCD:Start(nil, self.vb.goresplatterCount+1)
		if self:IsEasy() then
			--Dirty fix just for normal for now. It's likely all timers should be restarted here in stead of sequenced though
			timerGraspFromBeyondCD:Stop()
			timerGraspFromBeyondCD:Start(30, self.vb.graspCount+1)
		end
		--Restart rain timer
		timerCrimsonRainCD:Start(19, self.vb.crimsonCount+1)
	elseif spellId == 451288 then
		--Backup, in case SPELL_SUMMON not exposed
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnWatchers then
				self:ScanForMobs(args.sourceGUID, 2, 4, 1, nil, 12, "SetIconOnWatchers", nil, nil, true)
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnBlackBulwark:Show(args.sourceName, count)
			if count < 6 then
				specWarnBlackBulwark:Play("kick"..count.."r")
			else
				specWarnBlackBulwark:Play("kickcast")
			end
		end
		timerBlackBulwarkCD:Start(nil, args.sourceGUID)
	elseif spellId == 445016 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSpectralSlam:Show()
			specWarnSpectralSlam:Play("defensive")
		end
	elseif spellId == 445174 and self:AntiSpam(3, 1) then
		warnManifestHorror:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 443203 then
		--"Crimson Rain-443203-npc:214502-00006B455A = pull:11.0, 128.0, 128.0, 128.0" (heroic) (mythic is same)
		self.vb.crimsonCount = self.vb.crimsonCount +1
		warnCrimsonRain:Show(self.vb.crimsonCount)
		timerCrimsonRainCD:Start(30, self.vb.crimsonCount+1)--128 to next activation
		self:Schedule(30, missingCLEURain, self)
		self:Schedule(60, missingCLEURain, self)
		self:Schedule(90, missingCLEURain, self)
	elseif spellId == 445016 then
		timerSpectralSlamCD:Start(10.4, args.sourceGUID)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 444830 then--Lost Watcher
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			--timerBlackBulwarkCD:Start(nil, args.destGUID)
			--timerSpectralSlamCD:Start(nil, args.destGUID)
			if self.Options.SetIconOnWatchers then
				self:ScanForMobs(args.destGUID, 2, 4, 1, nil, 12, "SetIconOnWatchers", nil, nil, true)
			end
		end
	elseif spellId == 444835 then--Forgotten Harbinger
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnHarb then
				--Boss always spawns 3 adds on normal and 4 on mythic (heroic unknown, it worked diff during that test)
				--We reserve skull for watcher, and 7 6 5 for harbingers. We also allow 2 extra in case there is a left over add or two on a bad pull
				--We do not touch icon 1 or 2 because some strats were marking tanks so we're leaving 1 and 2 free
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.destGUID
						self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnHarb", nil, nil, true)
						break
					end
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 443612 then
		if args:IsPlayer() then
			--playerPhased = true
			warnBanefulShift:Show()
			timerBanefulShift:Start()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBanefulShift:Show(args.destName)
				specWarnBanefulShift:Play("tauntboss")
			end
		end
	elseif spellId == 452245 then
		if args:IsPlayer() then
			specWarnBloodcurdle:Show()
			specWarnBloodcurdle:Play("scatter")
			yellBloodcurdle:Yell()
			yellBloodcurdleFades:Countdown(spellId, 3)
		end
	elseif spellId == 443042 then
		if self:AntiSpam(5, 2) then
			--22, 15, 15, 21, 15, 15, 47, 15, 15, 15, 15 (normal)
			--22.0, 28.0, 28.0, 28.0, 44.0, 28.0, 28.0, 28.0, 44.0, 28.0, 28.0, 28.0, 44.1, 28.0, 28.0, 28.0 (heroic)
			--19.1, 27.9, 31.2, 27.8, 41.1, 27.9, 31.1, 27.9, 41.2, 27.8, 31.1, 27.9, 41.1 (mythic)
			self.vb.graspCount = self.vb.graspCount + 1
			if self:IsMythic() then
				--41.1, 27.9, 31.1, 27.9 repeating
				if self.vb.graspCount % 4 == 0 then
					timerGraspFromBeyondCD:Start(41.1, self.vb.graspCount+1)
				elseif self.vb.graspCount % 4 == 2 then
					timerGraspFromBeyondCD:Start(31.1, self.vb.graspCount+1)
				else--1 and 3
					timerGraspFromBeyondCD:Start(27.8, self.vb.graspCount+1)
				end
			elseif self:IsHeroic() then
				if self.vb.graspCount % 4 == 0 then
					timerGraspFromBeyondCD:Start(44, self.vb.graspCount+1)
				else
					timerGraspFromBeyondCD:Start(28, self.vb.graspCount+1)
				end
			else--Normal confirmed, LFR also confirmed
				--Just start 15 here and we'll fix timer on goresplatter cast
				if timerGruesomeDigorgeCD:GetRemaining(self.vb.disgorgeCount+1) > 15 then
					timerGraspFromBeyondCD:Start(15, self.vb.graspCount+1)
				else
					timerGraspFromBeyondCD:Start(17.3, self.vb.graspCount+1)
				end
			end
		end
		if args:IsPlayer() then
			specWarnGraspFromBeyond:Show()
			specWarnGraspFromBeyond:Play("runout")
			specWarnGraspFromBeyond:ScheduleVoice(2, "keepmove")
			yellGraspFromBeyond:Yell()
		end
	elseif spellId == 445272 then
		warnBloodPact:Cancel()
		warnBloodPact:Schedule(2, args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 443612 then
		if args:IsPlayer() then
--			playerPhased = false
			warnBanefulShiftFades:Show()
			timerBanefulShift:Stop()
		end
	elseif spellId == 452245 then
		if args:IsPlayer() then
			yellBloodcurdleFades:Cancel()
		end
	elseif spellId == 443042 and args:IsPlayer() then
		warnGraspFromBeyondFades:Show()
		warnGraspFromBeyondFades:Play("safenow")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 445518 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 221667 then--lost-watcher
		timerBlackBulwarkCD:Stop(args.destGUID)
		timerSpectralSlamCD:Stop(args.destGUID)
	elseif cid == 221945 then--forgotten-harbinger
		for i = 8, 5, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	end
end
