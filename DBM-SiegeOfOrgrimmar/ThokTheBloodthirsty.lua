local mod	= DBM:NewMod(851, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71529)
--mod:SetQuestID(32744)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

--Stage 1: A Cry in the Darkness
local warnFearsomeRoar			= mod:NewStackAnnounce(143766, 2, nil, mod:IsTank())--143426
local warnDeafeningScreech		= mod:NewCountAnnounce(143343, 4)--Applies 143411. Staghelm 2.0
local warnTailLash				= mod:NewSpellAnnounce(143428, 3, nil, false)--Meaningful? or case of being in wrong place?
local warnShockBlast			= mod:NewSpellAnnounce(143707, 2)
--Stage 2: Frenzy for Blood!
local warnBloodFrenzy			= mod:NewStackAnnounce(143442, 3)
local warnFixate				= mod:NewTargetAnnounce(143445, 4)
--Infusion of Acid
local warnAcidBreath			= mod:NewStackAnnounce(143780, 2, nil, mod:IsTank())
local warnCorrosiveBlood		= mod:NewTargetAnnounce(143791, 2, nil, mod:IsHealer())
--Infusion of Frost
local warnFrostBreath			= mod:NewStackAnnounce(143773, 2, nil, mod:IsTank())
local warnIcyBlood				= mod:NewTargetAnnounce(143800, 2)
--Infusion of Fire
local warnScorchingBreath		= mod:NewStackAnnounce(143767, 2, nil, mod:IsTank())
local warnBurningBloodBlood		= mod:NewTargetAnnounce(143783, 2)

--Stage 1: A Cry in the Darkness
local specWarnFearsomeRoar		= mod:NewSpecialWarningStack(143766, mod:IsTank(), 2)
local specWarnFearsomeRoarOther	= mod:NewSpecialWarningTarget(143766, mod:IsTank())
local specWarnDeafeningScreech	= mod:NewSpecialWarningCast(143343, nil, nil, nil, 2)
--Stage 2: Frenzy for Blood!
local specWarnBloodFrenzy		= mod:NewSpecialWarningTarget(143440, nil, nil, nil, 2)
local specWarnFixate			= mod:NewSpecialWarningRun(143445, nil, nil, nil, 3)
local yellFixate				= mod:NewYell(143445)
--Infusion of Frost
local specWarnIcyBlood			= mod:NewSpecialWarningYou(143800)--Useful?
--Infusion of Fire
local specWarnBurningBlood		= mod:NewSpecialWarningYou(143783)
local specWarnBurningBloodMove	= mod:NewSpecialWarningMove(143784)
local yellBurningBlood			= mod:NewYell(143783)

--Stage 1: A Cry in the Darkness
local timerFearsomeRoar			= mod:NewTargetTimer(30, 143766, mod:IsTank() or mod:IsHealer())
--local timerFearsomeRoarCD		= mod:NewCDTimer(10, 143766, mod:IsTank())
--local timerDeafeningScreechCD	= mod:NewNextCountTimer(25, 143343)-- (143345 base power regen, 4 per second)
--Stage 2: Frenzy for Blood!
local timerBloodFrenzyCD		= mod:NewNextTimer(5, 143442)
local timerFixate				= mod:NewTargetTimer(12, 143445)

mod:AddBoolOption("FixateIcon", true)

local screechCount = 0
local corrosiveBloodTargets = {}
local icyBloodTargets = {}
local burningBloodTargets = {}

--[[Copy paste from staghelm, this boss works same way, once we figure out his timings that is. base time should be about 25
local screechTimers = {
	[0] = 25,
	[1] = 14.4,
	[2] = 12,
	[3] = 10.9,
	[4] = 9.6,
	[5] = 8.4,
	[6] = 8.4,
	[7] = 7.2,
	[8] = 7.2,
	[9] = 6.0,
	[10]= 6.0,
}
--]]

local function warnCorrosiveBloodTargets()
	warnCorrosiveBlood:Show(table.concat(corrosiveBloodTargets, "<, >"))
	table.wipe(corrosiveBloodTargets)
end

local function warnIcyBloodTargets()
	warnIcyBlood:Show(table.concat(icyBloodTargets, "<, >"))
	table.wipe(icyBloodTargets)
end

local function warnBurningBloodTargets()
	warnBurningBloodBlood:Show(table.concat(burningBloodTargets, "<, >"))
	table.wipe(burningBloodTargets)
end

function mod:OnCombatStart(delay)
	screechCount = 0
	table.wipe(corrosiveBloodTargets)
	table.wipe(icyBloodTargets)
	table.wipe(burningBloodTargets)
end

function mod:OnCombatEnd()

end

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 137399 then
		self:BossTargetScanner(69465, "FocusedLightningTarget", 0.025, 12)
		timerFocusedLightningCD:Start()
	end
end--]]

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143428 then
		warnTailLash:Show()
	elseif args.spellId == 143707 then
		warnShockBlast:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143766 then
		local amount = args.amount or 1
		warnFearsomeRoar:Show(args.destName, amount)
		timerFearsomeRoar:Start(args.destName)
--		timerFearsomeRoarCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnFearsomeRoar:Show(args.amount)
			else
				specWarnFearsomeRoarOther:Show(args.destName)
			end
		end
	elseif args.spellId == 143780 then
		local amount = args.amount or 1
		warnAcidBreath:Show(args.destName, amount)
	elseif args.spellId == 143773 then
		local amount = args.amount or 1
		warnFrostBreath:Show(args.destName, amount)
	elseif args.spellId == 143767 then
		local amount = args.amount or 1
		warnScorchingBreath:Show(args.destName, amount)
	elseif args.spellId == 143343 then--Assumed, 2 second channel but "Instant" cast flagged, this generally means SPELL_AURA_APPLIED
		screechCount = screechCount + 1
		warnDeafeningScreech:Show(screechCount)
		specWarnDeafeningScreech:Show()
--		timerDeafeningScreechCD:Start(screechTimers[screechCount], screechCount+1)
	elseif args.spellId == 143343 then
		specWarnBloodFrenzy:Show(args.destName)
		timerBloodFrenzyCD:Start()
	elseif args.spellId == 143442 then
		local amount = args.amount or 1
		warnBloodFrenzy:Show(args.destName, amount)
		timerBloodFrenzyCD:Start()
	elseif args.spellId == 143445 then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 143791 then
		corrosiveBloodTargets[#corrosiveBloodTargets + 1] = args.destName
		self:Unschedule(warnCorrosiveBloodTargets)
		self:Schedule(0.5, warnCorrosiveBloodTargets)
	elseif args.spellId == 143800 then
		local amount = args.amount or 1
		if amount == 1 then--Ignore the SPELL_AURA_APPLIED_DOSE of this
			icyBloodTargets[#icyBloodTargets + 1] = args.destName
			self:Unschedule(warnIcyBloodTargets)
			self:Schedule(0.5, warnIcyBloodTargets)
		end
		if args:IsPlayer() then
			specWarnIcyBlood:Show()
		end
	elseif args.spellId == 143783 then
		burningBloodTargets[#burningBloodTargets + 1] = args.destName
		self:Unschedule(warnBurningBloodTargets)
		self:Schedule(0.5, warnBurningBloodTargets)
		if args:IsPlayer() then
			specWarnBurningBlood:Show()
			yellBurningBlood:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143766  then
		timerFearsomeRoar:Cancel(args.destName)
	elseif args.spellId == 143343  then
		timerBloodFrenzyCD:Cancel()
	elseif args.spellId == 143445 then
		timerFixate:Cancel(args.destName)
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143784 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBurningBloodMove:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
