local mod	= DBM:NewMod(2429, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165066)
mod:SetEncounterID(2418)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210126000000)--2021, 01, 03
mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 335114 334404 334971 334797 334757 334852",
	"SPELL_CAST_SUCCESS 334945 334797",
	"SPELL_AURA_APPLIED 334971 334860 334945 334852 335111 335112 335113 334504",
	"SPELL_AURA_APPLIED_DOSE 334971 334860",
	"SPELL_AURA_REMOVED 334945 334860 334852 335111 335112 335113",
	"SPELL_AURA_REMOVED_DOSE 334860",
	"UNIT_DIED"
)

--TODO, handling of mythic Sinseeker buffs by detecting which hound buffs it currently has (by using phase probably)
--TODO, energy tracker on nameplates for https://shadowlands.wowhead.com/spell=335303/unyielding
--TODO, continue watching timers, see if lfr and heroic follow same behavior as normal, or mythic.
--[[
(ability.id = 335114 or ability.id = 334404 or ability.id = 334971 or ability.id = 334797 or ability.id = 334757 or ability.id = 334852) and type = "begincast"
 or ability.id = 334945 and type = "cast"
 or (target.id = 165067 or target.id = 169457 or target.id = 169458) and type = "death"
--]]
--Huntsman Altimor
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22309))
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnSinseeker								= mod:NewTargetNoFilterAnnounce(335114, 4)
local warnSpreadshot							= mod:NewSpellAnnounce(334404, 3)

local specWarnSinseeker							= mod:NewSpecialWarningYouPos(335114, nil, nil, nil, 3, 2)
local yellSinseeker								= mod:NewShortPosYell(335114)
local yellSinseekerFades						= mod:NewIconFadesYell(335114)

local timerSinseekerCD							= mod:NewCDCountTimer(49, 335114, nil, nil, nil, 3)
local timerSpreadshotCD							= mod:NewCDTimer(11.8, 334404, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("5/6/10")
mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})--335111 335112 335113
--Hunting Gargon
----Margore
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22312))
local warnJaggedClaws							= mod:NewStackAnnounce(334971, 2, nil, "Tank|Healer")
local warnViciousLunge							= mod:NewTargetNoFilterAnnounce(334945, 3, nil, nil, 262783)

local specWarnJaggedClaws						= mod:NewSpecialWarningStack(334971, nil, 2, nil, nil, 1, 6)
local specWarnJaggedClawsTaunt					= mod:NewSpecialWarningTaunt(334971, nil, nil, nil, 1, 2)
local specWarnViciousLunge						= mod:NewSpecialWarningYou(334945, nil, 262783, nil, 3, 2)
local yellViciousLunge							= mod:NewYell(334945, 262783, nil, nil, "YELL")
local yellViciousLungeFades						= mod:NewFadesYell(334945, 262783, nil, nil, "YELL")

local timerJaggedClawsCD						= mod:NewCDTimer(10.9, 334971, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--22.1, 23.4, 11.0
local timerViciousLungeCD						= mod:NewCDTimer(25.5, 334945, 262783, nil, nil, 3)--Shortname Lunge
----Bargast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22311))
local specWarnRipSoul							= mod:NewSpecialWarningDefensive(334797, nil, nil, nil, 1, 2)
local specWarnRipSoulHealer						= mod:NewSpecialWarningTarget(334797, "Healer", nil, nil, 1, 2)
local specWarnShadesofBargast					= mod:NewSpecialWarningSwitch(334757, false, nil, 2, 1, 2)

local timerRipSoulCD							= mod:NewCDTimer(30, 334797, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerShadesofBargastCD					= mod:NewCDTimer(60.1, 334757, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--60-63 at least

mod:AddSetIconOption("SetIconOnShades", 334757, true, true, {4, 5})
----Hecutis
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22310))
local warnCrushingStone							= mod:NewStackAnnounce(334860, 2, nil, "Tank|Healer")
local warnPetrifyingHowl						= mod:NewTargetAnnounce(334852, 3, nil, nil, 135241)--Shortname "Howl"

local specWarnPetrifyingHowl					= mod:NewSpecialWarningMoveAway(334852, nil, nil, nil, 1, 2)
local yellPetrifyingHowl						= mod:NewYell(334852, 135241)--Shortname "Howl"
local yellPetrifyingHowlFades					= mod:NewFadesYell(334852, 135241)--Shortname "Howl"

local timerPetrifyingHowlCD						= mod:NewCDTimer(20.6, 334852, 135241, nil, nil, 3)--20-26 Shortname "Howl"

mod.vb.sinSeekerCount = 0
mod.vb.activeSeekers = 0
--NYI, more data needed to substanciate
local spreadShotTimers = {
	[1] = {6.5, 30.3, 18.2},
	[2] = {11.7, 32.7, 12.2, 12.1},
	[3] = {12.4, 23.1, 43.6},
}
local playerSinSeeker = false
local transitionwindow = 0--0 false, 1 true, 2 sinseeker activated while it was 1
local updateRangeFrame
do
	local function debuffFilter(uId)
		if DBM:UnitDebuff(uId, 335111, 335112, 335113) then
			return true
		end
	end
	updateRangeFrame = function(self, force)
		if not self.Options.RangeFrame then return end
		if DBM:UnitDebuff("player", 334852) then--Petrifying Howl
			DBM.RangeCheck:Show(10)
		elseif DBM:UnitDebuff("player", 334945) then--Vicious Lunge
			DBM.RangeCheck:Show(6)
		elseif force or (self:IsMythic() and self.vb.phase == 3 and self.vb.activeSeekers > 0) then--Mythic Sinseeker spread mechanic
			if playerSinSeeker then
				DBM.RangeCheck:Show(5)--Show everyone
			else
				DBM.RangeCheck:Show(5, debuffFilter)--Only show players affected with sinseeker
			end
		else
			DBM.RangeCheck:Hide()
		end
	end
end

local function updateAllTimers(self)
	DBM:Debug("updateAllTimers running", 3)
	--All phase abilities
	if timerSpreadshotCD:GetRemaining() < 8.6 then
		local elapsed, total = timerSpreadshotCD:GetTime()
		local extend = 8.6 - (total-elapsed)
		DBM:Debug("timerSpreadshotCD extended by: "..extend, 2)
		timerSpreadshotCD:Stop()
		timerSpreadshotCD:Update(elapsed, total+extend)
	end
	local phase = self.vb.phase
	if phase == 1 then
		if timerJaggedClawsCD:GetRemaining() < 9.7 then
			local elapsed, total = timerJaggedClawsCD:GetTime()
			local extend = 9.7 - (total-elapsed)
			DBM:Debug("timerJaggedClawsCD extended by: "..extend, 2)
			timerJaggedClawsCD:Stop()
			timerJaggedClawsCD:Update(elapsed, total+extend)
		end
	elseif phase == 2 then
		if timerRipSoulCD:GetRemaining() < 8.5 then
			local elapsed, total = timerRipSoulCD:GetTime()
			local extend = 8.5 - (total-elapsed)
			DBM:Debug("timerRipSoulCD extended by: "..extend, 2)
			timerRipSoulCD:Stop()
			timerRipSoulCD:Update(elapsed, total+extend)
		end
	elseif phase == 3 then
		if timerPetrifyingHowlCD:GetRemaining() < 9.7 then
			local elapsed, total = timerPetrifyingHowlCD:GetTime()
			local extend = 9.7 - (total-elapsed)
			DBM:Debug("timerPetrifyingHowlCD extended by: "..extend, 2)
			timerPetrifyingHowlCD:Stop()
			timerPetrifyingHowlCD:Update(elapsed, total+extend)
		end
	end
end

function mod:OnCombatStart(delay)
	transitionwindow = 0
	self:SetStage(1)
	self.vb.sinSeekerCount = 0
	self.vb.activeSeekers = 0
	playerSinSeeker = false
	timerSpreadshotCD:Start(6-delay)
	timerSinseekerCD:Start(28.8-delay, 1)
	--Margore on pull on heroic testing, but can this change?
	timerJaggedClawsCD:Start(10.1-delay)
	timerViciousLungeCD:Start(18.1-delay)--SUCCESS of debuff, not Command Margore-335119
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 335114 then
		self.vb.sinSeekerCount = self.vb.sinSeekerCount + 1
		--Mythic, Dog1: 49, Dog2: 60, Dog3: 50, dogs dead: 39.9
		--Normal, Dog1: 50-51, Dog2: 60-61, Dog3: 50-51, dogs dead: 24.3
		local timer = self:IsMythic() and (self.vb.phase == 4 and 25 or 60.2) or (self.vb.phase == 4 and 24.3 or 49.1)--self.vb.phase == 2 and 61.1 or
		timerSinseekerCD:Start(timer, self.vb.sinSeekerCount+1)
		if self.vb.phase == 3 and self:IsMythic() then
			updateRangeFrame(self, true)--Force show during cast so it's up a little early
		end
		if transitionwindow == 1 then
			transitionwindow = 2
		end
		updateAllTimers(self)
	elseif spellId == 334404 and self.vb.phase < 4 then--It's no longer every 6 seconds in P4, it's every 3.7, that's too much spam for any warning
		warnSpreadshot:Show()
		timerSpreadshotCD:Start(11.8)--More work required to determin causes of longer ones
	elseif spellId == 334971 then
		timerJaggedClawsCD:Start()
	elseif spellId == 334797 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnRipSoul:Show()
			specWarnRipSoul:Play("defensive")
		end
		timerRipSoulCD:Start()
	elseif spellId == 334757 then
		specWarnShadesofBargast:Show()
		specWarnShadesofBargast:Play("targetchange")
		timerShadesofBargastCD:Start()
		if self.Options.SetIconOnShades then
			self:ScanForMobs(171557, 1, 4, 2, nil, 15, "SetIconOnShades")--Start at 4 ascending up
		end
		timerSpreadshotCD:Stop()--At very least halts timer, not sure what restart time is since sinseeker restart will automatically alter it anyways
	elseif spellId == 334852 then
		timerPetrifyingHowlCD:Start(self:IsMythic() and 30 or 20.6)
		timerSpreadshotCD:Stop()
		timerSpreadshotCD:Start(14.3)--Resets spreadshot to 14.3
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then--Vicious Lunge, First event with target information, it's where we sync timers to
		timerViciousLungeCD:Start()
		timerSpreadshotCD:Stop()
		timerSpreadshotCD:Start(11.8)--Resets bosses spreadshot timer
	elseif spellId == 334797 then
		specWarnRipSoulHealer:Show(args.destName)
		specWarnRipSoulHealer:Play("healfull")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 334971 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnJaggedClaws:Show(amount)
					specWarnJaggedClaws:Play("stackhigh")
				else
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if (not remaining or remaining and remaining < 10.9) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
						specWarnJaggedClawsTaunt:Show(args.destName)
						specWarnJaggedClawsTaunt:Play("tauntboss")
					else
						warnJaggedClaws:Show(args.destName, amount)
					end
				end
			else
				warnJaggedClaws:Show(args.destName, amount)
			end
		end
	elseif spellId == 334860 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnCrushingStone:Show(args.destName, amount)
		end
	elseif spellId == 334945 then
		if args:IsPlayer() then
			specWarnViciousLunge:Show()
			specWarnViciousLunge:Play("gathershare")
			yellViciousLunge:Yell()
			yellViciousLungeFades:Countdown(spellId)
			updateRangeFrame(self)
		else
			warnViciousLunge:Show(args.destName)
		end
	elseif spellId == 334852 then
		warnPetrifyingHowl:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPetrifyingHowl:Show()
			specWarnPetrifyingHowl:Play("scatter")
			yellPetrifyingHowl:Yell()
			yellPetrifyingHowlFades:Countdown(spellId)
			updateRangeFrame(self)
		end
	elseif spellId == 335111 or spellId == 335112 or spellId == 335113 then
		self.vb.activeSeekers = self.vb.activeSeekers + 1
		local icon = spellId == 335111 and 1 or spellId == 335112 and 2 or spellId == 335113 and 3
		if self.Options.SetIconOnSinSeeker then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			playerSinSeeker = true
			specWarnSinseeker:Show(self:IconNumToTexture(icon))
			specWarnSinseeker:Play("mm"..icon)
			yellSinseeker:Yell(icon, icon)
			yellSinseekerFades:Countdown(spellId, nil, icon)
		end
		warnSinseeker:CombinedShow(spellId == 335113 and 0.1 or 2.5, args.destName)
	elseif spellId == 334504 then
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 169457 then--Bargast
			self:SetStage(2)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			--Start Next Dog
			--timerSpreadshotCD:Start()--Used instantly
			timerSinseekerCD:Stop()
			timerRipSoulCD:Start(10)
			timerShadesofBargastCD:Start(17.5)
			timerSinseekerCD:Start(31.8, self.vb.sinSeekerCount+1)
			transitionwindow = 0
		elseif cid == 169457 then--Bargast
			self:SetStage(3)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--Start Next Dog
			timerSpreadshotCD:Start(6.3)
			timerPetrifyingHowlCD:Start(13.9)
			timerSinseekerCD:Stop()
			if transitionwindow == 2 then--Cast within transition window
				--It was cast going into phase change, which causes it to incurr it's full 50 second cd on this event
				timerSinseekerCD:Start(50, self.vb.sinSeekerCount+1)
			else
				timerSinseekerCD:Start(28.3, self.vb.sinSeekerCount+1)--Need fresh transcriptor log to verify this
			end
			transitionwindow = 0
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 334945 then
		if args:IsPlayer() then
			yellViciousLungeFades:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 334860 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnCrushingStone:Show(args.destName, amount)
		end
	elseif spellId == 334852 then
		if args:IsPlayer() then
			yellPetrifyingHowlFades:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 335111 or spellId == 335112 or spellId == 335113 then
		self.vb.activeSeekers = self.vb.activeSeekers - 1
		if args:IsPlayer() then
			playerSinSeeker = false
			yellSinseekerFades:Cancel()
		end
		if self.Options.SetIconOnSinSeeker then
			self:SetIcon(args.destName, 0)
		end
		if self.vb.activeSeekers == 0 and self.vb.phase == 3 and self:IsMythic() then
			updateRangeFrame(self)
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--https://ptr.wowhead.com/npc=173112/pierced-soul
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then--margore
		transitionwindow = 1
		timerSpreadshotCD:Stop()--Boss stops using this rest of fight? Might be a bug
		timerJaggedClawsCD:Stop()
		timerViciousLungeCD:Stop()
	elseif cid == 169457 then--bargast
		transitionwindow = 1
		timerRipSoulCD:Stop()
		timerShadesofBargastCD:Stop()
		timerSpreadshotCD:Stop()
	elseif cid == 169458 then--hecutis
		timerPetrifyingHowlCD:Stop()
		timerSpreadshotCD:Stop()
		--Start Phase 4 stuff because no hunters bond here, still has a small chance to clip sinseeker timer that got off at end of phase 3
		self:SetStage(4)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(4))
		warnPhase:Play("pfour")
		--New timer starts, except when it doesn't and it just casts 60 seconds after phase 3 version
		timerSinseekerCD:Stop()
		timerSinseekerCD:Start(6.2, self.vb.sinSeekerCount+1)
	end
end
