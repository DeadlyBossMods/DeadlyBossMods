local mod	= DBM:NewMod(195, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53691)
mod:SetModelID(38448)
mod:SetZone()
mod:SetUsedIcons(6, 8) -- cross(7) is hard to see in redish environment?
mod:SetModelSound("Sound\\Creature\\SHANNOX\\VO_FL_SHANNOX_SPAWN.wav", "Sound\\Creature\\SHANNOX\\VO_FL_SHANNOX_KILL_04.wav")
--Long: Yes, I smell them too, Riplimb. Outsiders encroach on the Firelord's private grounds. Find their trail. Find them for me, that I may dispense punishment!
--Short: Dog food!

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

mod:SetBossHealthInfo(
	53691,	L.name,
	53694,	L.Riplimb,
	53695,	L.Rageface
)

local warnFaceRage				= mod:NewTargetAnnounce(99945, 4)
local warnRage					= mod:NewTargetAnnounce(100415, 3)
local warnWary					= mod:NewTargetAnnounce(100167, 2, nil, false)
local warnTears					= mod:NewStackAnnounce(99937, 3, nil, mod:IsTank() or mod:IsHealer())
local warnSpear					= mod:NewSpellAnnounce(100002, 3)--warn for this instead of magmaflare until/if rip dies.
local warnMagmaRupture			= mod:NewSpellAnnounce(99840, 3)
local warnCrystalPrison			= mod:NewTargetAnnounce(99836, 2)--On by default, not as often, and useful for tanks or kiters
local warnImmoTrap				= mod:NewTargetAnnounce(99839, 2, nil, false)--Spammy, off by default for those who want it.
local warnCrystalPrisonTrapped	= mod:NewTargetAnnounce(99837, 4)--Player is in prison.
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 3)

local specWarnSpear				= mod:NewSpecialWarningSpell(100002, false)
local specWarnRage				= mod:NewSpecialWarningYou(100415)
local specWarnFaceRage			= mod:NewSpecialWarningTarget(99945, false)
local specWarnImmTrap			= mod:NewSpecialWarningMove(99839)
local specWarnImmTrapNear		= mod:NewSpecialWarningClose(99839)
local yellImmoTrap				= mod:NewYell(99839, nil, false)
local specWarnCrystalTrap		= mod:NewSpecialWarningMove(99836)
local specWarnCrystalTrapNear	= mod:NewSpecialWarningClose(99836)
local yellCrystalTrap			= mod:NewYell(99836)
local specWarnTears				= mod:NewSpecialWarningStack(99937, mod:IsTank(), 8)

local timerRage					= mod:NewTargetTimer(15, 100415)
local timerWary					= mod:NewTargetTimer(25, 100167, nil, false)
local timerTears				= mod:NewTargetTimer(26, 99937, nil, mod:IsTank() or mod:IsHealer())
local timerCrystalPrison		= mod:NewTargetTimer(10, 99837)--Dogs Only
local timerCrystalPrisonCD		= mod:NewCDTimer(25.5, 99836)--Seems consistent timing, other trap is not.
local timerSpearCD				= mod:NewCDTimer(42, 100002)--Before riplimb dies
local timerMagmaRuptureCD		= mod:NewCDTimer(15, 99840)--After riplimb dies
local timerFaceRageCD			= mod:NewCDTimer(27, 99945, nil, false)--Has a 27-30 sec cd but off by default as it's subject to wild variation do to traps.

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnFaceRage")
mod:AddBoolOption("SetIconOnRage")

local prewarnedPhase2 = false
local trapScansDone = 0

function mod:ImmoTrapTarget(targetname)
	warnImmoTrap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnImmTrap:Show()
		yellImmoTrap:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnImmTrapNear:Show(targetname)
			end
		end
	end
end

function mod:CrystalTrapTarget(targetname)
	warnCrystalPrison:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCrystalTrap:Show()
		yellCrystalTrap:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnCrystalTrapNear:Show(targetname)
			end
		end
	end
end

function mod:TrapHandler(SpellID, isTank)
	trapScansDone = trapScansDone + 1
	if UnitExists("boss1target") then--Better way to check if target exists and prevent nil errors at same time, without stopping scans from starting still. so even if target is nil, we stil do more checks instead of just blowing off a trap warning.
		local targetname = UnitName("boss1target")
		if UnitDetailedThreatSituation("boss1target", "boss1") and not isTank then--He's targeting his highest threat target.
			if trapScansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "TrapHandler", SpellID)--Check multiple times to be sure it's not on something other then tank.
			else
				self:ScheduleMethod(0.05, "TrapHandler", SpellID, true)--It's still on tank, force true isTank and activate else rule and warn trap is on tank.
			end
		else--He's not targeting highest threat target (or isTank was set to true after 12 scans) so this has to be right target.
			self:UnscheduleMethod("TrapHandler")--Unschedule all checks just to be sure none are running, we are done.
			if SpellID == 99836 then
				self:CrystalTrapTarget(targetname)
			else
				self:ImmoTrapTarget(targetname)
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if trapScansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "TrapHandler", SpellID)
		end
	end
end

function mod:OnCombatStart(delay)
	prewarnedPhase2 = false
	trapScansDone = 0
--	timerCrystalPrisonCD:Start(-delay)--Don't know yet, Need to run transcriptor with combat logging turned OFF to get the timestamps right.
	timerSpearCD:Start(20-delay)--High variation, just a CD?
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(100415) then
		warnRage:Show(args.destName)
		timerRage:Start(args.destName)
		if args:IsPlayer() then
			specWarnRage:Show()
		end
		if self.Options.SetIconOnRage then
			self:SetIcon(args.destName, 6, 15)
		end
	elseif args:IsSpellID(100167, 101215, 101216, 101217) then
		warnWary:Show(args.destName)
		timerWary:Start(args.destName)
	elseif args:IsSpellID(99837) then--Filter when the dogs get it?
		if args:IsDestTypePlayer() then
			warnCrystalPrisonTrapped:Show(args.destName)
		else--It's a trapped dog
			timerCrystalPrison:Start(args.destName)--make a 10 second timer for how long dog is trapped.
		end
	elseif args:IsSpellID(99937, 101218, 101219, 101220) then
		if (args.amount or 1) % 3 == 0 then	--Warn every 3 stacks
			warnTears:Show(args.destName, args.amount or 1)
		end
		if args:IsPlayer() and (args.amount or 1) >= 8 then		-- tank switch @ 8?
			specWarnTears:Show(args.amount)
		end
		timerTears:Start(args.destName)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99945) then
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(100002, 100031) then	--100002 confirmed .. all/right ids?
		warnSpear:Show()--Only valid until rip dies
		specWarnSpear:Show()
		timerSpearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99945, 99947) then--is 99945 even used?, cause my 10 man logs only had 99947 for Spell cast success.
		warnFaceRage:Show(args.destName)
		specWarnFaceRage:Show(args.destName)
		timerFaceRageCD:Start()
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(99840) then	--This is cast after Riplimb dies.
		warnMagmaRupture:Show()
		timerMagmaRuptureCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(99836) then
		timerCrystalPrisonCD:Start()
		trapScansDone = 0
		self:ScheduleMethod(0.05, "TrapHandler", 99836)
	elseif args:IsSpellID(99839) then
		trapScansDone = 0
		self:ScheduleMethod(0.05, "TrapHandler", 99839)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 53691 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 50 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 33 and h < 36 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 53694 then
		timerSpearCD:Cancel()--Cancel it and replace it with other timer
		timerMagmaRuptureCD:Start(10)
	elseif self:GetCIDFromGUID(args.destGUID) == 53695 then
		timerFaceRageCD:Cancel()
	end
end
