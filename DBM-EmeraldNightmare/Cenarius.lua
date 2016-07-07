local mod	= DBM:NewMod(1750, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 14741 $"):sub(12, -3))
mod:SetCreatureID(104636)
mod:SetEncounterID(1877)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212726 212630 211073 211368 214529 213162",
	"SPELL_CAST_SUCCESS 214505 214876",
	"SPELL_AURA_APPLIED 210346 211368 211471",
	"SPELL_AURA_APPLIED_DOSE 210279",
	"SPELL_AURA_REMOVED 210346",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_AURA player"
)

--TODO, see if destructive Nightmares has a fixate of sorts to warn one being chased by bad whisps
--TODO, evaluate stomp and need of timer/etc
--TODO, Further assess thorns. it doesn't need warnings at all if adds never tanked near boss in first place
--TODO, figure out good voice for specWarnCreepingNightmares. "clear stacks"?
--TODO, all sub 30% stuff
--Cenarius
local warnNightmareBrambles			= mod:NewTargetAnnounce(210290, 2)
local warnBeastsOfNightmare			= mod:NewSpellAnnounce(214876, 2)--Generic for now, figure out what to do with later.
----Forces of Nightmare
local warnDesiccatingStomp			= mod:NewCastAnnounce(211073, 3, nil, nil, "Melee")--Basic warning for now, will change to special if needed
local warnRottenBreath				= mod:NewTargetAnnounce(211192, 2)
local warnScornedTouch				= mod:NewTargetAnnounce(211471, 3)
--Malfurion Stormrage
local warnCleansingGround			= mod:NewCastAnnounce(212630, 1)

--Cenarius
local specWarnCreepingNightmares	= mod:NewSpecialWarningStack(210279, nil, 15, nil, 1)--Stack warning subject to tuning
local specWarnNightmareBrambles		= mod:NewSpecialWarningRun(210290, nil, nil, nil, 1, 2)
local yellNightmareBrambles			= mod:NewYell(210290)
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
local timerDreadThornsCD			= mod:NewCDTimer(34, 210346, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNightmareBlastCD			= mod:NewNextTimer(32.8, 213162, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerForcesOfNightmareCD		= mod:NewCDCountTimer(77.8, 212726, nil, nil, nil, 1)
local timerSpearOfNightmaresCD		= mod:NewAITimer(16, 214529, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBeastsOfNightmareCD		= mod:NewAITimer(16, 214876, nil, nil, nil, 1)
----Forces of Nightmare
local timerTouchofLifeCD			= mod:NewCDTimer(12, 211368, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Cenarius
local countdownForcesOfNightmare	= mod:NewCountdown(78.8, 212726)
local countdownNightmareBrambles	= mod:NewCountdown("Alt30", 210290, "Ranged")--Never once saw this target melee
----Forces of Nightmare

--Cenarius
local voiceNightmareBrambles		= mod:NewVoice(210290)--runout/watchstep
--local voiceDreadThorns				= mod:NewVoice(210346, "Tank")--bossout
local voiceForcesOfNightmare		= mod:NewVoice(212726)--mobsoon
local voiceNightmareBlast			= mod:NewVoice(213162, "Tank")--defensive/tauntboss
local voiceSpearOfNightmares		= mod:NewVoice(214529, "Tank")--defensive/tauntboss
----Forces of Nightmare
local voiceTouchOfLife				= mod:NewVoice(211368)--kickcast/dispelnow
local voiceScornedTouch				= mod:NewVoice(211471)--runout

mod:AddRangeFrameOption(8, 211471)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnBreath", 211192)

mod.vb.phase = 1
mod.vb.addsCount = 0
local scornedWarned = false

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
	self.vb.phase = 1
	self.vb.addsCount = 0
	timerForcesOfNightmareCD:Start(7.2-delay, 1)
	countdownForcesOfNightmare:Start(7.2-delay)
	timerDreadThornsCD:Start(14-delay)
	timerNightmareBramblesCD:Start(25.5-delay)
	countdownNightmareBrambles:Start(25.5-delay)
	timerNightmareBlastCD:Start(31.2-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBreath then
		DBMHudMap:Disable()
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
	elseif spellId == 212630 then
		warnCleansingGround:Show()
	elseif spellId == 211073 then
		warnDesiccatingStomp:Show()
	elseif spellId == 211368 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnTouchofLife:Show(args.sourceName)
		voiceTouchOfLife:Play("kickcast")
		timerTouchofLifeCD:Start(12, args.sourceGUID)
	elseif spellId == 214529 then
		timerSpearOfNightmaresCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104636, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnSpearOfNightmares:Show()
			voiceSpearOfNightmares:Play("defensive")
		else
			if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, targetName) then return end--You are not near current tank, you're probably 3rd tank on Doom Guards that never taunts massive blast
			specWarnSpearOfNightmaresOther:Schedule(2.5, targetName)
			voiceSpearOfNightmares:Schedule(2.5, "tauntboss")
		end
	elseif spellId == 213162 then
		timerNightmareBlastCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104636, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnNightmareBlast:Show()
			voiceNightmareBlast:Play("defensive")
		else
			if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, targetName) then return end--You are not near current tank, you're probably 3rd tank on Doom Guards that never taunts massive blast
			specWarnNightmareBlastOther:Schedule(2, targetName)
			voiceNightmareBlast:Schedule(2, "tauntboss")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 214505 then
		specWarnEntangledNightmares:Show()
	elseif spellId == 214876 then
		warnBeastsOfNightmare:Show()
		timerBeastsOfNightmareCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 210346 then
--		specWarnDreadThorns:Show()
--		voiceDreadThorns:Play("bossout")
	elseif spellId == 211368 then
		specWarnTouchofLifeDispel:Show(args.destName)
		voiceTouchOfLife:Play("dispelnow")
	elseif spellId == 211471 then--Original casts only. Jumps can't be warned this way as of 04-01-16 Testing
		warnScornedTouch:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 210279 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 5 == 0 then--Every 5
			if amount >= 15 then--Starting at 15
				specWarnCreepingNightmares:Show(amount)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105495 then--Scorned Sister
		timerTouchofLifeCD:Cancel(args.destGUID)
	elseif cid == 105494 then--Rotten Drake
		--This is safer method to cancel it but if more than 1 drake is up it may in rare cases break scan for 2nd drake
		self:BossUnitTargetScannerAbort()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 211189 then--Rotten Breath precast. Best method for fastest and most accurate target scanning
		self:BossUnitTargetScanner(uId, "BreathTarget")
	elseif spellId == 210290 then--Bramble cast finish (only thing not hidden, probably be hidden too by live, if so will STILL find a way to warn this, even if it means scanning boss 24/7)
		if not UnitExists(uId.."target") then return end--Blizzard decided to go even further out of way to break this detection, if this happens we don't want nil errors for users.
		local targetName = DBM:GetUnitFullName(uId)
		if UnitIsUnit("player", uId.."target") then
			specWarnNightmareBrambles:Show()
			yellNightmareBrambles:Yell()
			voiceNightmareBrambles:Play("runout")
		elseif self:CheckNearby(8, targetName) then
			specWarnNightmareBramblesNear:Show(targetName)
			voiceNightmareBrambles:Play("watchstep")
		else
			warnNightmareBrambles:Show(targetName)
		end
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
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end
