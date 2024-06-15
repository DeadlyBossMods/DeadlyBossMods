local mod	= DBM:NewMod(2611, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214502)
mod:SetEncounterID(2917)
mod:SetUsedIcons(6, 7, 8)
mod:SetHotfixNoticeRev(20240614000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444363 452237 445936 442530 451288 445016 445174",
	"SPELL_CAST_SUCCESS 443203",
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
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(444363 452237 445936 442530 451288 445016 445174) and type = "begincast"
 or ability.id = 443203 and type = "cast"
 or ability.id = 443042 and type = "applydebuff")
 or (ability.id = 444830 or ability.id = 444835) and type = "summon"
--]]
--Phase One: The Black Blood
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29061))
local warnBanefulShift							= mod:NewYouAnnounce(443612, 2)
local warnBanefulShiftFades						= mod:NewFadesAnnounce(443612, 2)
local warnCrimsonRain							= mod:NewCountAnnounce(443203, 2)
local warnGraspFromBeyondFades					= mod:NewFadesAnnounce(443042, 1, nil, nil, 367465, nil, nil, 2)

local specWarnGruesomeDisgorge					= mod:NewSpecialWarningCount(444363, nil, nil, nil, 1, 2)
local specWarnBanefulShift						= mod:NewSpecialWarningTaunt(443612, nil, nil, nil, 1, 2)
local specWarnBloodcurdle						= mod:NewSpecialWarningMoveAway(452237, nil, nil, nil, 1, 2, 4)
local yellBloodcurdle							= mod:NewShortYell(452237)
local yellBloodcurdleFades						= mod:NewShortFadesYell(452237)
local specWarnSpewingHemorrhage					= mod:NewSpecialWarningRunCount(445936, nil, nil, nil, 4, 2)
local specWarnGoresplatter						= mod:NewSpecialWarningDodgeCount(442530, nil, nil, nil, 2, 2)
local specWarnGraspFromBeyond					= mod:NewSpecialWarningMoveAway(443042, nil, 367465, nil, 1, 2)
local yellGraspFromBeyond						= mod:NewShortYell(443042, 367465)--ShortYell "Grasp"
local specWarnGTFO								= mod:NewSpecialWarningGTFO(445518, nil, nil, nil, 1, 8)

local timerGruesomeDigorgeCD					= mod:NewNextCountTimer(49, 444363, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBanefulShift							= mod:NewBuffFadesTimer(40, 443612, nil, nil, nil, 5)
local timerBloodcurdleCD						= mod:NewAITimer(40, 452237, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSpewingHemorrhageCD					= mod:NewNextCountTimer(40, 445936, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGoresplatterCD						= mod:NewNextCountTimer(128, 442530, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerCrimsonRainCD						= mod:NewNextCountTimer(128, 443203, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerGraspFromBeyondCD					= mod:NewNextCountTimer(40, 443042, 367465, nil, nil, 3)--ShortYell "Grasp"
--Phase Two: The Unseeming
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29068))
local warnManifestHorror						= mod:NewCastAnnounce(445174, 4)
local warnBloodPact								= mod:NewStackAnnounce(445272, 2)

local specWarnBlackBulwark						= mod:NewSpecialWarningInterruptCount(451288, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpectralSlam						= mod:NewSpecialWarningDefensive(445016, nil, nil, nil, 1, 2)

local timerBlackBulwarkCD						= mod:NewCDNPTimer(17.1, 451288, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
local timerSpectralSlamCD						= mod:NewCDNPTimer(13.4, 445016, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Nameplate only, larger variation

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnWatchers", 444830, true, 5, {8})
mod:AddSetIconOption("SetIconOnHarb", 444835, true, 5, {4, 5, 6, 7})--Harbingers spawn with watchers in following sequence: 1 1 2 2 3 3 4 4 (not seen further than this)
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.disgorgeCount = 0
mod.vb.curdleCount = 0
mod.vb.hemorrhageCount = 0
mod.vb.goresplatterCount = 0
mod.vb.membraneCount = 0
mod.vb.graspCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
--local playerPhased = false

function mod:OnCombatStart(delay)
	self.vb.disgorgeCount = 0
	self.vb.curdleCount = 0
	self.vb.hemorrhageCount = 0
	self.vb.goresplatterCount = 0
	self.vb.membraneCount = 0
	self.vb.graspCount = 0
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	--playerPhased = false
	timerGruesomeDigorgeCD:Start(16, 1)
	timerSpewingHemorrhageCD:Start(32, 1)
	timerGoresplatterCD:Start(120, 1)
	timerCrimsonRainCD:Start(11, 1)
	timerGraspFromBeyondCD:Start(22, 1)
	if self:IsMythic() then
		timerBloodcurdleCD:Start(1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 444363 then
		--16.0, 51.0, 77.0, 51.0, 77.0, 51.0, 77.1, 51.0
		self.vb.disgorgeCount = self.vb.disgorgeCount + 1
		specWarnGruesomeDisgorge:Show(self.vb.disgorgeCount)
		specWarnGruesomeDisgorge:Play("shockwave")
		if self.vb.disgorgeCount % 2 == 0 then
			timerGruesomeDigorgeCD:Start(77, self.vb.disgorgeCount+1)
		else
			timerGruesomeDigorgeCD:Start(51, self.vb.disgorgeCount+1)
		end
	elseif spellId == 452237 then
		self.vb.curdleCount = self.vb.curdleCount + 1
		timerBloodcurdleCD:Start()
	elseif spellId == 445936 then
		--32.0, 49.0, 79.0, 49.0, 79.0, 49.0, 79.0, 49.0
		self.vb.hemorrhageCount = self.vb.hemorrhageCount + 1
		specWarnSpewingHemorrhage:Show(self.vb.hemorrhageCount)
		specWarnSpewingHemorrhage:Play("justrun")
		if self.vb.hemorrhageCount % 2 == 0 then
			timerSpewingHemorrhageCD:Start(79, self.vb.hemorrhageCount+1)
		else
			timerSpewingHemorrhageCD:Start(49, self.vb.hemorrhageCount+1)
		end
	elseif spellId == 442530 then
		self.vb.goresplatterCount = self.vb.goresplatterCount + 1
		specWarnGoresplatter:Show(self.vb.goresplatterCount)
		specWarnGoresplatter:Play("watchstep")
		timerGoresplatterCD:Start(nil, self.vb.goresplatterCount+1)
	elseif spellId == 451288 then
		--Backup, in case SPELL_SUMMON not exposed
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnWatchers then
				self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnWatchers", nil, nil, true)
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
		timerSpectralSlamCD:Start(nil, args.sourceGUID)
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
		--"Crimson Rain-443203-npc:214502-00006B455A = pull:11.0, 128.0, 128.0, 128.0"
		self.vb.membraneCount = self.vb.membraneCount +1
		warnCrimsonRain:Show(self.vb.membraneCount)
		timerCrimsonRainCD:Start(nil, self.vb.membraneCount+1)
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
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnWatchers", nil, nil, true)
			end
		end
	elseif spellId == 444835 then--Forgotten Harbinger
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnHarb then
				for i = 7, 3, -1 do--7-4 confirmed, 3 is just in case
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
			--22.0, 28.0, 28.0, 28.0, 44.0, 28.0, 28.0, 28.0, 44.0, 28.0, 28.0, 28.0, 44.1, 28.0, 28.0, 28.0
			self.vb.graspCount = self.vb.graspCount + 1
			if self.vb.graspCount % 4 == 0 then
				timerGraspFromBeyondCD:Start(44, self.vb.graspCount+1)
			else
				timerGraspFromBeyondCD:Start(28, self.vb.graspCount+1)
			end
		end
		if args:IsPlayer() then
			specWarnGraspFromBeyond:Show()
			specWarnGraspFromBeyond:Play("runout")
			specWarnGraspFromBeyond:ScheduleVoice(2, "keepmove")
			yellGraspFromBeyond:Yell()
		end
	elseif spellId == 445272 then
		warnBloodPact:Show(args.destName, args.amount or 1)
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
		for i = 7, 3, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	elseif cid == 221945 then--forgotten-harbinger
		for i = 7, 3, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	end
end
