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

local warnFaceRage				= mod:NewTargetAnnounce(99945, 4)
local warnRage					= mod:NewTargetAnnounce(100415, 3)
local warnWary					= mod:NewTargetAnnounce(100167, 2, nil, false)	-- which hound has this buff? They get it when being trapped
local warnTears					= mod:NewStackAnnounce(99937, 3, nil, mod:IsTank() or mod:IsHealer())
local warnSpear					= mod:NewSpellAnnounce(100002, 3)--warn for this instead of magmaflare until rip dies.
local warnMagmaFlare			= mod:NewSpellAnnounce(100495, 3)
local warnCrystalPrison			= mod:NewSpellAnnounce(99836, 2)
local warnCrystalPrisonTarget	= mod:NewTargetAnnounce(99837, 4)
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 3)

local timerRage				= mod:NewTargetTimer(15, 100415)
local timerWary				= mod:NewTargetTimer(25, 100167, nil, false)
local timerTears			= mod:NewTargetTimer(30, 99937, nil, mod:IsTank() or mod:IsHealer())
local timerCrystalPrisonCD	= mod:NewCDTimer(25.5, 99836)--Seems consistent timing, other trap is not.
local timerMagmaFlareCD		= mod:NewCDTimer(42, 100495)--Use this for CD since it works for both before and after rip dies, 42-47 seconds

local specWarnRage			= mod:NewSpecialWarningYou(100415)
local specWarnImmTrap		= mod:NewSpecialWarningMove(99838)
local specWarnTears			= mod:NewSpecialWarningStack(99937, 8, nil, mod:IsTank())

mod:AddBoolOption("SetIconOnFaceRage")
mod:AddBoolOption("SetIconOnRage")

local prewarnedPhase2 = false
local riplimbDead = false
local spamFaceRage = 0

function mod:OnCombatStart(delay)
	spamFaceRage = 0
	prewarnedPhase2 = false
	riplimbDead = false
--	timerCrystalPrisonCD:Start(-delay)--Don't know yet, Need to run transcriptor with combat logging turned OFF to get the timestamps right.
	timerMagmaFlareCD:Start(20-delay)--Guesswork
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
	elseif args:IsSpellID(99838, 101208, 101209, 101210) then
		if args:IsPlayer() then
			specWarnImmTrap:Show()
		end
	elseif args:IsSpellID(99837) then--Filter when the dogs get it?
		warnCrystalPrisonTarget:Show(args.destName)
	elseif args:IsSpellID(99937, 101218, 101219, 101220) then
		if args.amount or 0 % 3 == 0 then	--Warn every 3 stacks
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
		end
		timerMagmaFlareCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(99836) then
		warnCrystalPrison:Show()
		timerCrystalPrisonCD:Start()
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
	end
end