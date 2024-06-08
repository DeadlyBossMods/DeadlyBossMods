local mod	= DBM:NewMod(2611, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214502)
mod:SetEncounterID(2917)
mod:SetUsedIcons(6, 7, 8)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444363 452237 445936 442530 451288 445016 445174",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 444830 444835",
	"SPELL_AURA_APPLIED 443612 452245 443305 443042 445272",
	"SPELL_AURA_APPLIED_DOSE 445272",
	"SPELL_AURA_REMOVED 443612 452245 443042",
	"SPELL_PERIODIC_DAMAGE 445518",
	"SPELL_PERIODIC_MISSED 445518",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe further warn when the aoe damage from Goresplatter starts for healers?
--TODO, a decent way to detect the 30 second loop of Residual membrane besides debuffs going out
--TODO, possibly infoframe for Membrane healoffs?
--TODO, proper cast event for Grasp timer start
--TODO, repeating yell for grasp? it spams bad stuff on ground for entire 12 seconds that affects other players
--TODO, fade boss timers and squelch boss alerts if player is in Baneful shift, if they are unaffected by boss abilities while shifted
--TODO, also announce add spawns if they aren't automatically spawn with another boss ability (like disgorge)
--TODO, refine add auto marking when known spawn frequency and count is known
--TODO, can blood horrors be killed? should they be auto marked with https://www.wowhead.com/beta/spell=445197/manifest-horror ?
--TODO, Manifest Horror nameplate timer? i kinda assume it's just sort of spam cast til dead
--Phase One: The Black Blood
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29061))
local warnBanefulShift							= mod:NewYouAnnounce(443612, 2)
local warnBanefulShiftFades						= mod:NewFadesAnnounce(443612, 2)
local warnResidualMembrane						= mod:NewCountAnnounce(443305, 2)
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

local timerGruesomeDigorgeCD					= mod:NewAITimer(49, 444363, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBanefulShift							= mod:NewBuffFadesTimer(40, 443612, nil, nil, nil, 5)
local timerBloodcurdleCD						= mod:NewAITimer(40, 452237, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSpewingHemorrhageCD					= mod:NewAITimer(40, 445936, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGoresplatterCD						= mod:NewAITimer(40, 442530, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerResidualMembraneCD					= mod:NewAITimer(40, 443305, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerGraspFromBeyondCD					= mod:NewAITimer(40, 443042, 367465, nil, nil, 3)--ShortYell "Grasp"
--Phase Two: The Unseeming
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29068))
local warnManifestHorror						= mod:NewCastAnnounce(445174, 4)
local warnBloodPact								= mod:NewStackAnnounce(445272, 2)

local specWarnBlackBulwark						= mod:NewSpecialWarningInterruptCount(451288, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpectralSlam						= mod:NewSpecialWarningDefensive(445016, nil, nil, nil, 1, 2)

--local timerBlackBulwarkCD						= mod:NewCDNPTimer(11.8, 451288, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
--local timerSpectralSlamCD						= mod:NewCDNPTimer(11.8, 445016, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnWatchers", 444830, true, 5, {6, 7, 8})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.disgorgeCount = 0
mod.vb.curdleCount = 0
mod.vb.hemorrhageCount = 0
mod.vb.goresplatterCount = 0
mod.vb.membraneCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
--local playerPhased = false

function mod:OnCombatStart(delay)
	self.vb.disgorgeCount = 0
	self.vb.curdleCount = 0
	self.vb.hemorrhageCount = 0
	self.vb.goresplatterCount = 0
	self.vb.membraneCount = 0
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	--playerPhased = false
	timerGruesomeDigorgeCD:Start(1)
	timerSpewingHemorrhageCD:Start(1)
	timerGoresplatterCD:Start(1)
	timerResidualMembraneCD:Start(1)
	timerGraspFromBeyondCD:Start(1)
	if self:IsMythic() then
		timerBloodcurdleCD:Start(1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 444363 then
		self.vb.disgorgeCount = self.vb.disgorgeCount + 1
		specWarnGruesomeDisgorge:Show(self.vb.disgorgeCount)
		specWarnGruesomeDisgorge:Play("shockwave")
		timerGruesomeDigorgeCD:Start()
	elseif spellId == 452237 then
		self.vb.curdleCount = self.vb.curdleCount + 1
		timerBloodcurdleCD:Start()
	elseif spellId == 445936 then
		self.vb.hemorrhageCount = self.vb.hemorrhageCount + 1
		specWarnSpewingHemorrhage:Show(self.vb.hemorrhageCount)
		specWarnSpewingHemorrhage:Play("justrun")
		timerSpewingHemorrhageCD:Start()
	elseif spellId == 442530 then
		self.vb.goresplatterCount = self.vb.goresplatterCount + 1
		specWarnGoresplatter:Show(self.vb.goresplatterCount)
		specWarnGoresplatter:Play("watchstep")
		timerGoresplatterCD:Start()
	elseif spellId == 451288 then
		--Backup, in case SPELL_SUMMON not exposed
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnWatchers then
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.sourceGUID
						self:ScanForMobs(args.sourceGUID, 2, i, 1, nil, 12, "SetIconOnWatchers")
						break
					end
				end
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
		--timerBlackBulwarkCD:Start(nil, args.sourceGUID)
	elseif spellId == 445016 then
		--timerSpectralSlamCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSpectralSlam:Show()
			specWarnSpectralSlam:Play("defensive")
		end
	elseif spellId == 445174 then
		warnManifestHorror:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 444363 then

	end
end
--]]

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 444830 then--Lost Watcher
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			--timerBlackBulwarkCD:Start(nil, args.destGUID)
			--timerSpectralSlamCD:Start(nil, args.destGUID)
			if self.Options.SetIconOnWatchers then
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.destGUID
						self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnWatchers")
						break
					end
				end
			end
		end
	elseif spellId == 444835 then--Forgotten Harbinger
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnWatchers then
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.destGUID
						self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnWatchers")
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
	elseif spellId == 443305 then
		if self:AntiSpam(5, 1) then
			self.vb.membraneCount = self.vb.membraneCount +1
			warnResidualMembrane:Show()
			timerResidualMembraneCD:Start()
		end
	elseif spellId == 443042 then
		if self:AntiSpam(5, 2) then
			timerGraspFromBeyondCD:Start()
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
		--timerBlackBulwarkCD:Stop(args.destGUID)
		--timerSpectralSlamCD:Stop(args.destGUID)
		for i = 8, 5, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	elseif cid == 221945 then--forgotten-harbinger
		for i = 8, 5, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
