local mod	= DBM:NewMod(1750, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104636)
mod:SetEncounterID(1877)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4)
mod:SetHotfixNoticeRev(15364)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212726 212630 211073 211368 214529 213162 214249",
	"SPELL_CAST_SUCCESS 214876 214529 211471 212726",
	"SPELL_AURA_APPLIED 210346 211368 211471",
	"SPELL_AURA_APPLIED_DOSE 210279",
	"SPELL_AURA_REMOVED 210346",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_AURA player"
)

--TODO, verify wisp icons. ScanForMobs may need timing adjusts or tweaks to ensure it doesn't mark friendly wisps or miss some
--TODO, Further assess thorns. it doesn't need warnings at all if adds never tanked near boss in first place
--TODO, an actual beasts of nightmare timer and not an AI timer (transcriptor log needed, i don't think these are in combat log or I would have seen by now)
--Cenarius
local warnNightmareBrambles			= mod:NewTargetAnnounce(210290, 2)
local warnBeastsOfNightmare			= mod:NewSpellAnnounce(214876, 2)--Generic for now, figure out what to do with later.
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
----Forces of Nightmare
local warnDesiccatingStomp			= mod:NewCastAnnounce(211073, 3, nil, nil, true, 2)--Basic warning for now, will change to special if needed
local warnRottenBreath				= mod:NewTargetAnnounce(211192, 2)
local warnScornedTouch				= mod:NewTargetAnnounce(211471, 3)
--Malfurion Stormrage
local warnCleansingGround			= mod:NewCastAnnounce(212630, 1)

--Cenarius
local specWarnCreepingNightmares	= mod:NewSpecialWarningStack(210279, nil, 16, nil, 1, 6)--Stack warning subject to tuning
local yellNightmareBrambles			= mod:NewYell(210290, L.BrambleYell)
local specWarnNightmareBramblesNear	= mod:NewSpecialWarningClose(210290, nil, nil, nil, 1, 2)
--local specWarnDreadThorns			= mod:NewSpecialWarningMoveAway(210346, "Tank", nil, nil, 1, 2)--Move away warning? Have to move away from other adds
local specWarnNightmareBlast		= mod:NewSpecialWarningDefensive(213162, nil, nil, nil, 1, 2)
local specWarnNightmareBlastOther	= mod:NewSpecialWarningTaunt(213162, nil, nil, nil, 1, 2)
local specWarnForcesOfNightmare		= mod:NewSpecialWarningSwitchCount(212726, nil, nil, nil, 1, 2)--Switch warning or just spell warning?
local specWarnSpearOfNightmares		= mod:NewSpecialWarningDefensive(214529, nil, nil, nil, 1, 2)
local specWarnSpearOfNightmaresOther= mod:NewSpecialWarningTaunt(214529, nil, nil, nil, 1, 2)
local specWarnEntangledNightmares	= mod:NewSpecialWarningSwitch(214505, "Dps", nil, nil, 1, 2)
----Forces of Nightmare
local yellRottenBreath				= mod:NewYell(211192)
local specWarnTouchofLife			= mod:NewSpecialWarningInterrupt(211368, "HasInterrupt")
local specWarnTouchofLifeDispel		= mod:NewSpecialWarningDispel(211368, "MagicDispeller")
local specWarnScornedTouch			= mod:NewSpecialWarningMoveAway(211471, nil, nil, nil, 3, 2)
local yellScornedTouch				= mod:NewYell(211471)

--Cenarius
local timerNightmareBramblesCD		= mod:NewCDTimer(30, 210290, nil, nil, nil, 3)--On for all, for now. Doesn't target melee but melee still have to be aware. Just not AS aware.
local timerDreadThornsCD			= mod:NewCDTimer(34, 210346, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)--Optional but off by default
local timerNightmareBlastCD			= mod:NewNextTimer(32.8, 213162, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerForcesOfNightmareCD		= mod:NewCDCountTimer(77.8, 212726, nil, nil, nil, 1)--77.8-80
local timerSpearOfNightmaresCD		= mod:NewCDTimer(18.2, 214529, nil, "Tank|Healer", 2, 5, nil, DBM_CORE_TANK_ICON)
local timerBeastsOfNightmareCD		= mod:NewAITimer(16, 214876, nil, nil, nil, 1)
local timerEntanglingNightmareCD	= mod:NewNextTimer(51, 214505, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
----Malfurion
local timerCleansingGroundCD		= mod:NewNextTimer(77, 214249, nil, nil, nil, 3)--Phase 2 version only for now. Not sure if cast more than once though?
----Forces of Nightmare
local timerScornedTouchCD			= mod:NewCDTimer(21.5, 211471, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTouchofLifeCD			= mod:NewCDTimer(15, 211368, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerRottenBreathCD			= mod:NewCDTimer(25, 211192, nil, nil, nil, 3)
local timerDisiccatingStompCD		= mod:NewCDTimer(32, 211073, nil, nil, nil, 2)

--Cenarius
local countdownForcesOfNightmare	= mod:NewCountdown(78.8, 212726)
local countdownNightmareBrambles	= mod:NewCountdown("Alt30", 210290, "Ranged")--Never once saw this target melee
local countdownNightmareBlast		= mod:NewCountdown("Alt32", 213162, "Tank")
local countdownSpearOfNightmares	= mod:NewCountdown("Alt18", 214529, "Tank")
----Forces of Nightmare

--Cenarius
local voiceCreepingNightmares		= mod:NewVoice(210279)--stackhigh
local voiceNightmareBrambles		= mod:NewVoice(210290)--runout/watchstep
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
--local voiceDreadThorns				= mod:NewVoice(210346, "Tank")--bossout
local voiceForcesOfNightmare		= mod:NewVoice(212726)--mobsoon
local voiceNightmareBlast			= mod:NewVoice(213162, "Tank")--defensive/tauntboss
local voiceSpearOfNightmares		= mod:NewVoice(214529, "Tank")--defensive/tauntboss
----Forces of Nightmare
local voiceTouchOfLife				= mod:NewVoice(211368)--kickcast/dispelnow
local voiceScornedTouch				= mod:NewVoice(211471)--runout

mod:AddRangeFrameOption(8, 211471)
mod:AddSetIconOption("SetIconOnWisps", "ej13348", false, true)
mod:AddHudMapOption("HudMapOnBreath", 211192)
mod:AddInfoFrameOption(210279)

mod.vb.phase = 1
mod.vb.addsCount = 0
mod.vb.sisterCount = 0
local scornedWarned = false
local seenMobs = {}

function mod:BreathTarget(targetname, uId)
	if not targetname then return end
	warnRottenBreath:Show(targetname)
	if targetname == UnitName("player") then
		yellRottenBreath:Yell()
	end
	if self.Options.HudMapOnBreath then
		--Static marker, breath doesn't move once a target is picked. it's aimed at static location player WAS
		DBMHudMap:RegisterStaticMarkerOnPartyMember(211192, "highlight", targetname, 5, 5.5, 1, 0, 0, 0.5, nil, 1):Pulse(0.5, 0.5)
	end
end

function mod:OnCombatStart(delay)
	scornedWarned = false
	table.wipe(seenMobs)
	self.vb.phase = 1
	self.vb.addsCount = 0
	self.vb.sisterCount = 0
	timerForcesOfNightmareCD:Start(7.2-delay, 1)--7.2-8.6
	countdownForcesOfNightmare:Start(7.2-delay)
	timerDreadThornsCD:Start(14-delay)
	timerNightmareBramblesCD:Start(27.5-delay)--Cast finish. Cast start is actually a yell and not worth using anyways since DBM doesn't warn spawn point until cast finish
	countdownNightmareBrambles:Start(27.5-delay)
	if self:IsMythic() then
		timerNightmareBlastCD:Start(30.5-delay)
		countdownNightmareBlast:Start(30.5-delay)
	end
	if not self.Options.AlertedBramble then
		DBM:AddMsg(L.BrambleMessage)
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
	)
	if self.Options.InfoFrame and not self:IsLFR() then
		DBM.InfoFrame:SetHeader(GetSpellInfo(210279))
		DBM.InfoFrame:Show(8, "playerdebuffstacks", 210279)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBreath then
		DBMHudMap:Disable()
	end
	if not self.Options.AlertedBramble then
		DBM:AddMsg(L.BrambleMessage)
		self.Options.AlertedBramble = true
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212726 then
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnForcesOfNightmare:Show(self.vb.addsCount)
		voiceForcesOfNightmare:Play("mobsoon")
		timerForcesOfNightmareCD:Start(nil, self.vb.addsCount+1)
		countdownForcesOfNightmare:Start()
	elseif spellId == 212630 or spellId == 214249 then--214249 is phase 2
		warnCleansingGround:Show()
	elseif spellId == 211073 then
		warnDesiccatingStomp:Show()
		timerDisiccatingStompCD:Start(nil, args.SourceGUID)
	elseif spellId == 211368 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnTouchofLife:Show(args.sourceName)
			voiceTouchOfLife:Play("kickcast")
		end
		if self:IsEasy() then
			timerTouchofLifeCD:Start(15, args.sourceGUID)
		else
			timerTouchofLifeCD:Start(12, args.sourceGUID)
		end
	elseif spellId == 214529 then
		timerSpearOfNightmaresCD:Start()
		countdownSpearOfNightmares:Start(18.2)
		local targetName, uId, bossuid = self:GetBossTarget(104636, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnSpearOfNightmares:Show()
			voiceSpearOfNightmares:Play("defensive")
		end
	elseif spellId == 213162 then
		timerNightmareBlastCD:Start()
		countdownNightmareBlast:Start(32.8)
		local targetName, uId, bossuid = self:GetBossTarget(104636, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnNightmareBlast:Show()
			voiceNightmareBlast:Play("defensive")
		else
			if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, targetName) then return end--You are not near current tank, you're probably 3rd tank on Adds that never taunts nightmare blast
			specWarnNightmareBlastOther:Schedule(2, targetName)
			voiceNightmareBlast:Schedule(2, "tauntboss")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 214876 then
		warnBeastsOfNightmare:Show()
		timerBeastsOfNightmareCD:Start()
	elseif spellId == 214529 and not args:IsPlayer() then
		if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, args.destName) then return end--You are not near current tank, you're probably 3rd tank on Adds that never taunts nightmare blast
		specWarnSpearOfNightmaresOther:Show(args.destName)
		voiceSpearOfNightmares:Play("tauntboss")
	elseif spellId == 211471 and self:AntiSpam(5, 1) then
		timerScornedTouchCD:Start(nil, args.sourceGUID)
	elseif spellId == 212726 then
		--Wisps don't fire IEEU so done here inste3ad
		if self.Options.SetIconOnWisps then
			self:ScanForMobs(106304, 0, 8, 5, 0.1, 20, "SetIconOnWisps", false, 106659)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 210346 then
--		specWarnDreadThorns:Show()
--		voiceDreadThorns:Play("bossout")
	elseif spellId == 211368 then
		specWarnTouchofLifeDispel:Show(args.destName)
		if self.Options.specwarn211368dispel then
			voiceTouchOfLife:Play("dispelnow")
		end
	elseif spellId == 211471 then--Original casts only. Jumps can't be warned this way as of 04-01-16 Testing
		warnScornedTouch:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 210279 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 4 == 0 then--Every 4
			if amount >= 16 then--Starting at 16
				specWarnCreepingNightmares:Show(amount)
				voiceCreepingNightmares:Play("stackhigh")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 210346 then
		timerDreadThornsCD:Start()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenMobs[GUID] and UnitIsEnemy("player", unitID) then
			seenMobs[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 105495 then--Scorned Sister
				self.vb.sisterCount = self.vb.sisterCount + 1
				timerScornedTouchCD:Start(5.5, GUID)
				timerTouchofLifeCD:Start(7, GUID)
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(8)
				end
			elseif cid == 105494 then--Rotten Drake
				timerRottenBreathCD:Start(18.1, GUID)
			elseif cid == 105468 then--Nightmare Ancient
				timerDisiccatingStompCD:Start(18.1, GUID)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105495 then--Scorned Sister
		self.vb.sisterCount = self.vb.sisterCount - 1
		timerTouchofLifeCD:Stop(args.destGUID)
		timerScornedTouchCD:Stop(args.destGUID)
		if self.Options.RangeFrame and self.vb.sisterCount == 0 and not UnitDebuff("player", GetSpellInfo(211471)) then
			DBM.RangeCheck:Hide()
		end
	elseif cid == 105494 then--Rotten Drake
		--This is safer method to cancel it but if more than 1 drake is up it may in rare cases break scan for 2nd drake
		self:BossUnitTargetScannerAbort()
		timerRottenBreathCD:Stop(args.destGUID)
	elseif cid == 105468 then--Nightmare Ancient
		timerDisiccatingStompCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 211189 then--Rotten Breath precast. Best method for fastest and most accurate target scanning
		self:BossUnitTargetScanner(uId, "BreathTarget")
		timerRottenBreathCD:Start(nil, UnitGUID(uId))
	elseif spellId == 210290 then--Bramble cast finish (only thing not hidden, probably be hidden too by live, if so will STILL find a way to warn this, even if it means scanning boss 24/7)
		if not UnitExists(uId.."target") then return end--Blizzard decided to go even further out of way to break this detection, if this happens we don't want nil errors for users.
		local targetName = DBM:GetUnitFullName(uId.."target")
		if UnitIsUnit("player", uId.."target") then
			specWarnNightmareBramblesNear:Show(YOU)
			yellNightmareBrambles:Yell()
			voiceNightmareBrambles:Play("runout")
		elseif self:CheckNearby(8, targetName) then
			specWarnNightmareBramblesNear:Show(targetName)
			voiceNightmareBrambles:Play("watchstep")
		else
			warnNightmareBrambles:Show(targetName)
		end
		timerNightmareBramblesCD:Start()
	elseif spellId == 217368 then--Overwhelming Nightmare (Phase 2)
		self.vb.phase = 2
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerForcesOfNightmareCD:Stop()
		timerNightmareBlastCD:Stop()
		countdownNightmareBlast:Cancel()
		timerDreadThornsCD:Stop()
		timerNightmareBramblesCD:Stop()
		timerCleansingGroundCD:Stop()
		countdownForcesOfNightmare:Cancel()
		timerNightmareBramblesCD:Start(13)
		timerSpearOfNightmaresCD:Start(20)
		countdownSpearOfNightmares:Start(20)
		timerCleansingGroundCD:Start(30.5)
		timerEntanglingNightmareCD:Start(35)
		if self:IsMythic() then
			timerBeastsOfNightmareCD:Start(1)
		end
	elseif spellId == 214454 then--Entangling Nightmares (this is just a lot faster than combat log)
		specWarnEntangledNightmares:Show()
		timerEntanglingNightmareCD:Start()
	end
end

do
	local debuffName = GetSpellInfo(211471)
	--Jumps didn't show in combat log during testing, only original casts. However, jumps need warnings too
	--Check at later time if jumps are in combat log
	function mod:UNIT_AURA(uId)
		local hasDebuff = UnitDebuff("player", debuffName)
		if hasDebuff and not scornedWarned then
			specWarnScornedTouch:Show()
			voiceScornedTouch:Play("runout")
			yellScornedTouch:Yell()
			scornedWarned = true
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		elseif not hasDebuff and scornedWarned then
			scornedWarned = false
			if self.Options.RangeFrame and self.vb.sisterCount == 0 then
				DBM.RangeCheck:Hide()
			end
		end
	end
end
