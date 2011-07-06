local mod	= DBM:NewMod(195, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53691)
mod:SetModelID(38448)
mod:SetZone()
mod:SetUsedIcons(6, 8) -- cross(7) is hard to see in redish environment?

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
local warnWary					= mod:NewTargetAnnounce(100167, 2, nil, false)	-- which hound has this buff? They get it when being trapped
local warnTears					= mod:NewStackAnnounce(99937, 3, nil, mod:IsTank() or mod:IsHealer())
local warnSpear					= mod:NewSpellAnnounce(100002, 3)--warn for this instead of magmaflare until rip dies.
local warnMagmaFlare			= mod:NewSpellAnnounce(100495, 3)
local warnCrystalPrison			= mod:NewTargetAnnounce(99836, 2)--On by default, not as often, and useful for tanks or kiters
local warnImmoTrap				= mod:NewTargetAnnounce(99839, 2, nil, false)--Spammy, off by default for those who want it.
local warnCrystalPrisonTrapped	= mod:NewTargetAnnounce(99837, 4)--Player is in prison.
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 3)

local specWarnRage				= mod:NewSpecialWarningYou(100415)
local specWarnImmTrap			= mod:NewSpecialWarningMove(99839)
local specWarnImmTrapNear		= mod:NewSpecialWarningClose(99839)
local yellImmoTrap				= mod:NewYell(99839, nil, false)
local specWarnCrystalTrap		= mod:NewSpecialWarningMove(99836)
local specWarnCrystalTrapNear	= mod:NewSpecialWarningClose(99836)
local yellCrystalTrap			= mod:NewYell(99836)
local specWarnTears				= mod:NewSpecialWarningStack(99937, mod:IsTank(), 8)

local timerRage					= mod:NewTargetTimer(15, 100415)
local timerWary					= mod:NewTargetTimer(25, 100167, nil, false)
local timerTears				= mod:NewTargetTimer(30, 99937, nil, mod:IsTank() or mod:IsHealer())
local timerCrystalPrison		= mod:NewTargetTimer(10, 99837)--Dogs Only
local timerCrystalPrisonCD		= mod:NewCDTimer(25.5, 99836)--Seems consistent timing, other trap is not.
local timerSpearCD				= mod:NewCDTimer(42, 100002)--Use this for CD before rip dies
local timerMagmaFlareCD			= mod:NewCDTimer(42, 100495)--Use this for CD after rip dies

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnFaceRage")
mod:AddBoolOption("SetIconOnRage")

local prewarnedPhase2 = false
local riplimbDead = false
local spamFaceRage = 0
local trapScanStarted = false

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

--Can you tell i really suck at LUA? Ths function sucks ass
function mod:TrapHandler(SpellID, isTank)
	local targetname = self:GetBossTarget(53691)
	if not targetname then return end
	if UnitDetailedThreatSituation(targetname, "boss1") and not isTank then--He's targeting his highest threat target, the tank. If isTank we force it to else rule even though he's targeting tank
		if not trapScanStarted then--Only start this scan once we don't need an infinite loop
			self:ScheduleMethod(0.05, "TrapHandler", SpellID)--Check again
			self:ScheduleMethod(0.1, "TrapHandler", SpellID)--Check again
			self:ScheduleMethod(0.15, "TrapHandler", SpellID)--Check again
			self:ScheduleMethod(0.2, "TrapHandler", SpellID)--Check again
			self:ScheduleMethod(0.25, "TrapHandler", SpellID)--Check again
			self:ScheduleMethod(0.3, "TrapHandler", SpellID, true)--Check one last time, this time we set isTank since at this point if it's still targeting only the tank, the tank must be the target.
		end
		trapScanStarted = true
	else--He's not targeting tank so for sure we got right trap target.
		self:UnscheduleMethod("TrapHandler")--Unschedule all checks, we are done.
		if SpellID == 99836 then
			self:CrystalTrapTarget(targetname)
		else
			self:ImmoTrapTarget(targetname)
		end
		trapScanStarted = false--We fired a warning, so reset the scan started check
	end
end

function mod:OnCombatStart(delay)
	spamFaceRage = 0
	prewarnedPhase2 = false
	riplimbDead = false
	trapScanStarted = false
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
		timerSpearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99945, 99947) and GetTime() - spamFaceRage > 3 then--is 99945 even used?, cause my 10 man logs only had 99947 for Spell cast success.
		warnFaceRage:Show(args.destName)
		spamFaceRage = GetTime()
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(100495) then	--This is cast 2 seconds after spear, although when rip dies he stops casting spear and only casts this.
		if riplimbDead then--If Riplimb is dead, then he no longer casts spear first, so we need to warn for this instead.
			warnMagmaFlare:Show()
			timerMagmaFlareCD:Start()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(99836) then
		timerCrystalPrisonCD:Start()
		self:ScheduleMethod(0.05, "TrapHandler", 99836)
	elseif args:IsSpellID(99839) then
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
		riplimbDead = true
--		timerSpearCD:Cancel()--Cancel it and replace it with other timer somehow? figure out time diff or if cd resets when rip dies? i need more logs for this.
	end
end
