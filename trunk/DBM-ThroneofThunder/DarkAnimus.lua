local mod	= DBM:NewMod(824, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69427)
mod:SetModelID(47527)

mod:RegisterCombat("emote", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_WHISPER"
)

local warnCrimsonWake				= mod:NewTargetAnnounce(138480, 3)--Maybe target scannning will work faster, if not, i'll just sync the RAID_BOSS_WHISPER for highest accuracy (target scanning on multiple mobs with same creatureid and no bossX unit ID sucks)
local warnMatterSwap				= mod:NewTargetAnnounce(138609, 3)--Debuff.
local warnMatterSwapped				= mod:NewAnnounce("warnMatterSwapped", 3, 138618)--Actual swap(caused by dispel)
local warnExplosiveSlam				= mod:NewStackAnnounce(138569, 2, nil, mod:IsTank() or mod:IsHealer())
--Boss
local warnAnimaRing					= mod:NewTargetAnnounce(136954, 3)
local warnInterruptingJolt			= mod:NewSpellAnnounce(138763, 4)
local warnEmpowerGolem				= mod:NewTargetAnnounce(138780, 3)

local specWarnCrimsonWakeYou		= mod:NewSpecialWarningRun(138480)--Kiter
local specWarnCrimsonWake			= mod:NewSpecialWarningMove(138485)--Standing in stuff left behind by kiter
local yellCrimsonWake				= mod:NewYell(138480)
local specWarnMatterSwap			= mod:NewSpecialWarningYou(138609)
local specWarnExplosiveSlam			= mod:NewSpecialWarningStack(138569, mod:IsTank(), 4)--Assumed value drycode, won't know until cd is observed
local specWarnExplosiveSlamOther	= mod:NewSpecialWarningTarget(138569, mod:IsTank())
--Boss
local specWarnAnimaRing				= mod:NewSpecialWarningYou(136954)
local specWarnAnimaRingOther		= mod:NewSpecialWarningTarget(136954, false)
local yellAnimaRing					= mod:NewYell(136954)
local specWarnInterruptingJolt		= mod:NewSpecialWarningCast(138763, nil, nil, nil, 2)

local timerMatterSwap				= mod:NewTargetTimer(12, 138609)--If not dispelled, it ends after 12 seconds regardless
local timerExplosiveSlam			= mod:NewTargetTimer(25, 138569, nil, mod:IsTank() or mod:IsHealer())
--Boss
--Dark Animus will now use its abilities at more consistent intervals. (March 19 hotfix)
--As such, all of these timers need re-verification and updating.
local timerSiphonAnimaCD			= mod:NewNextTimer(30, 138644)
local timerAnimaRingCD				= mod:NewCDTimer(22, 136954)
local timerEmpowerGolemCD			= mod:NewCDTimer(16, 138780)--TODO, this wasn't cast as often on normal. Find out if they actually have different CDs or if it was buffed since normal was tested.

local soundCrimsonWake				= mod:NewSound(138480)

local scansDone = 0
local crimsonWake = GetSpellInfo(138485)--Debuff ID I believe, not cast one. Same spell name though

function mod:TargetScanner(Force)
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(69427)
	if UnitExists(targetname) then
		if self:IsTanking(uId, "boss1") and not Force then--This will USUALLY target tank but sometimes it does target a DPS like a mage on pull so we still do a tank check to be certain
			if scansDone < 12 then
				self:ScheduleMethod(0.02, "TargetScanner")
			else
				self:TargetScanner(true)
			end
		else
			warnAnimaRing:Show(targetname)
			if targetname == UnitName("player") then
				specWarnAnimaRing:Show()
				yellAnimaRing:Yell()
			else
				specWarnAnimaRingOther:Show(targetname)
			end
		end
	else
		if scansDone < 12 then
			self:ScheduleMethod(0.02, "TargetScanner")
		end
	end
end

function mod:OnCombatStart(delay)
	scansDone = 0
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 136954 then
		scansDone = 0
		self:TargetScanner()
		timerAnimaRingCD:Start()
	elseif args:IsSpellID(138763, 139867) then--Normal version is 2.2 sec cast. Heroic is 1.4 second cast (thus why it has different spellid)
		warnInterruptingJolt:Show()
		specWarnInterruptingJolt:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138569 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then--Only want sprays that are on tanks, not bads standing on tanks.
			warnExplosiveSlam:Show(args.destName, args.amount or 1)
			timerExplosiveSlam:Start(args.destName)
			if args:IsPlayer() then
				if (args.amount or 1) >= 4 then
					specWarnExplosiveSlam:Show(args.amount)
				end
			else
				if (args.amount or 1) >= 2 and not UnitDebuff("player", GetSpellInfo(138569)) and not UnitIsDeadOrGhost("player") then
					specWarnExplosiveSlamOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 138609 then
		warnMatterSwap:Show(args.destName)
		timerMatterSwap:Start(args.destName)
		if args:IsPlayer() then
			specWarnMatterSwap:Show()
		end
	elseif args.spellId == 138780 then
		warnEmpowerGolem:Show(args.destName)
		timerEmpowerGolemCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138609 then
		timerMatterSwap:Cancel(args.destName)
	elseif args.spellId == 138569 then
		timerExplosiveSlam:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 138485 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnCrimsonWake:Show()
--"<84.3 22:50:19> [CLEU] SPELL_DAMAGE#false#0x040000000587A80F#Crones#1300#0#0x040000000587A80F#Crones#1300#0#138618#Matter Swap#64#187086#-1#64#nil#nil#51355#nil#nil#nil#nil", -- [9602]
--"<84.3 22:50:19> [CLEU] SPELL_DAMAGE#false#0x040000000587A80F#Crones#1300#0#0x04000000060845B3#Rvst#1300#0#138618#Matter Swap#64#52388#-1#64#nil#nil#162209#nil#nil#nil#nil", -- [9604]
	elseif spellId == 138618 then
		if sourceGUID == destGUID then return end--Filter first event then grab both targets from second event, as seen from log example above
		warnMatterSwapped:Show(spellName, DBM:GetFullPlayerNameByGUID(sourceGUID), DBM:GetFullPlayerNameByGUID(destGUID))
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--"<83.8 14:59:54> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#%s is pursuing you!#Crimson Wake#1#false", -- [5382]
--Seems to have no debuff event on combat log. Could possibly use UNIT_AURA, but this should be less cpu and since we can do it without localizing, no harm in doing it this way.
--Now, if target scanning doesn't work, may switch to unit aura to detect it on players other than self without requiring syncing.
function mod:RAID_BOSS_WHISPER(msg, npc)
	if npc == crimsonWake then--In case target scanning fails, personal warnings still always go off. Target scanning is just so everyone else in raid knows who it's on (since only target sees this emote)
		if self:AntiSpam(3, 1) then--This actually doesn't spam, but we ues same antispam here so that the MOVE warning doesn't fire at same time unless you fail to move for 2 seconds
			specWarnCrimsonWakeYou:Show()
		end
		yellCrimsonWake:Yell()
		soundCrimsonWake:Play()
		self:SendSync("WakeTarget", UnitGUID("player"))
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if UnitExists("boss1") and tonumber(UnitGUID("boss1"):sub(6, 10), 16) == 69427 then
		self:UnregisterShortTermEvents()--Once boss is out, unregister event, since we need it no longer.
		if self:IsDifficulty("heroic10", "heroic25") then
			--Maybe do some stuff here later.
		else
			timerSiphonAnimaCD:Start()--Seems only 30 seconds after engage on normal. On heroic he works differently
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "WakeTarget" and guid then
		warnCrimsonWake:Show(DBM:GetFullPlayerNameByGUID(guid))
	end
end

