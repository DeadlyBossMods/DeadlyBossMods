local mod	= DBM:NewMod(851, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71529)
--mod:SetQuestID(32744)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Stage 1: A Cry in the Darkness
local warnFearsomeRoar				= mod:NewStackAnnounce(143766, 2, nil, mod:IsTank())--143426
local warnAcceleration				= mod:NewStackAnnounce(143411, 3)--Staghelm 2.0
local warnTailLash					= mod:NewSpellAnnounce(143428, 3, nil, false)--Hey, someone will want this out there.
--Stage 2: Frenzy for Blood!
local warnBloodFrenzy				= mod:NewStackAnnounce(143442, 3)
local warnFixate					= mod:NewTargetAnnounce(143445, 4)
local warnEnrage					= mod:NewTargetAnnounce(145974, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())
--Infusion of Acid
local warnAcidPustules				= mod:NewSpellAnnounce(143971, 2)
local warnAcidBreath				= mod:NewStackAnnounce(143780, 2, nil, mod:IsTank())
local warnCorrosiveBlood			= mod:NewTargetAnnounce(143791, 2, nil, mod:IsHealer())
--Infusion of Frost
local warnFrostPustules				= mod:NewSpellAnnounce(143968, 3)
local warnFrostBreath				= mod:NewStackAnnounce(143773, 2, nil, mod:IsTank())
local warnFrozenSolid				= mod:NewTargetAnnounce(143777, 4)--This only thing worth announcing. the stacks of Icy Blood cast SUPER often and not useful
--Infusion of Fire
local warnFirePustules				= mod:NewSpellAnnounce(143970, 2)
local warnScorchingBreath			= mod:NewStackAnnounce(143767, 2, nil, mod:IsTank())
local warnBurningBloodBlood			= mod:NewTargetAnnounce(143783, 3)

--Stage 1: A Cry in the Darkness
local specWarnFearsomeRoar			= mod:NewSpecialWarningStack(143766, mod:IsTank(), 2)
local specWarnFearsomeRoarOther		= mod:NewSpecialWarningTarget(143766, mod:IsTank())
local specWarnDeafeningScreech		= mod:NewSpecialWarningCast(143343, nil, nil, nil, 2)
--Stage 2: Frenzy for Blood!
local specWarnBloodFrenzy			= mod:NewSpecialWarningSpell(143440, nil, nil, nil, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(143445, nil, nil, nil, 3)
local yellFixate					= mod:NewYell(143445)
local specWarnEnrage				= mod:NewSpecialWarningTarget(145974, mod:IsTank() or mod:CanRemoveEnrage())
--Infusion of Acid
local specWarnAcidBreath			= mod:NewSpecialWarningStack(143780, mod:IsTank(), 2)
local specWarnAcidBreathOther		= mod:NewSpecialWarningTarget(143780, mod:IsTank())
--Infusion of Frost
local specWarnFrostBreath			= mod:NewSpecialWarningStack(143773, mod:IsTank(), 3)
local specWarnFrostBreathOther		= mod:NewSpecialWarningTarget(143773, mod:IsTank())
local specWarnIcyBlood				= mod:NewSpecialWarningStack(143800, nil, 3)
local specWarnFrozenSolid			= mod:NewSpecialWarningTarget(143777, mod:IsDps())
--Infusion of Fire
local specWarnScorchingBreath		= mod:NewSpecialWarningStack(143767, mod:IsTank(), 3)
local specWarnScorchingBreathOther	= mod:NewSpecialWarningTarget(143767, mod:IsTank())
local specWarnBurningBlood			= mod:NewSpecialWarningYou(143783)
local specWarnBurningBloodMove		= mod:NewSpecialWarningMove(143784)
local yellBurningBlood				= mod:NewYell(143783, nil, false)

--Stage 1: A Cry in the Darkness
local timerFearsomeRoar			= mod:NewTargetTimer(30, 143766, nil, mod:IsTank() or mod:IsHealer())
local timerFearsomeRoarCD		= mod:NewCDTimer(11, 143766, nil, mod:IsTank())
local timerDeafeningScreechCD	= mod:NewNextCountTimer(25, 143343)-- (143345 base power regen, 4 per second)
local timerTailLashCD			= mod:NewCDTimer(10, 143428, nil, false)
--Stage 2: Frenzy for Blood!
local timerBloodFrenzyCD		= mod:NewNextTimer(5, 143442)
local timerFixate				= mod:NewTargetTimer(12, 143445)
--Infusion of Acid
local timerAcidBreath			= mod:NewTargetTimer(30, 143780, nil, mod:IsTank() or mod:IsHealer())
local timerAcidBreathCD			= mod:NewCDTimer(11, 143780, nil, mod:IsTank())
local timerCorrosiveBloodCD		= mod:NewCDTimer(6, 143791, nil, false)--Cast often, so off by default
--Infusion of Frost
local timerFrostBreath			= mod:NewTargetTimer(30, 143773, nil, mod:IsTank() or mod:IsHealer())
local timerFrostBreathCD		= mod:NewCDTimer(9.5, 143773, nil, mod:IsTank())
--Infusion of Fire
local timerScorchingBreath		= mod:NewTargetTimer(30, 143767, nil, mod:IsTank() or mod:IsHealer())
local timerScorchingBreathCD	= mod:NewCDTimer(11, 143767, nil, mod:IsTank())
local timerBurningBloodCD		= mod:NewCDTimer(5, 143783)--cast often, but actually work showing. Fire bad

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("FixateIcon", true)

local screechCount = 0
local corrosiveBloodTargets = {}
local burningBloodTargets = {}
local UnitGUID = UnitGUID

--this boss works similar to staghelm
local screechTimers = {
	[0] = 25,
	[1] = 13.2,
	[2] = 8.5,
	[3] = 7.2,
	[4] = 4.8,
	[5] = 4.8,--in rare flukes this is 6.1
	[6] = 4.8,
	[7] = 3.6,--In rare cases you get a 4th 4.8
	[8] = 3.6,--If you get 4 4.8s then second 3.6 becomes a 2.5
	[9] = 3.6,
	[10]= 2.4,
	[11]= 2.4,
	[12]= 2.4,
	[13]= 2.4,
	[14]= 2.4,
	[15]= 2.4,
	[16]= 2.4,
	[17]= 2.4,
	[18]= 1.2,--Anything 18 and beyond is 1.2 with rare 2.4 fluke at 19 sometimes
}


local function warnCorrosiveBloodTargets()
	warnCorrosiveBlood:Show(table.concat(corrosiveBloodTargets, "<, >"))
	timerCorrosiveBloodCD:Start()
	table.wipe(corrosiveBloodTargets)
end

local function warnBurningBloodTargets()
	warnBurningBloodBlood:Show(table.concat(burningBloodTargets, "<, >"))
	timerBurningBloodCD:Start()
	table.wipe(burningBloodTargets)
end

function mod:OnCombatStart(delay)
	screechCount = 0
	table.wipe(corrosiveBloodTargets)
	table.wipe(burningBloodTargets)
	timerFearsomeRoarCD:Start(-delay)
	timerDeafeningScreechCD:Start(-delay)
	if self.Options.RangeFrame then
		if self:IsDifficulty("normal10", "heroic10") then
			DBM.RangeCheck:Show(10, nil, nil, 4)
		else
			DBM.RangeCheck:Show(10, nil, nil, 14)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143343 then--Assumed, 2 second channel but "Instant" cast flagged, this generally means SPELL_AURA_APPLIED
		specWarnDeafeningScreech:Show()
		timerDeafeningScreechCD:Start(screechTimers[screechCount] or 1.2, screechCount+1)
	elseif args.spellId == 143428 then
		warnTailLash:Show()
		timerTailLashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143411 then
		screechCount = args.amount or 1
		warnAcceleration:Show(screechCount)
	elseif args.spellId == 143766 then
		local amount = args.amount or 1
		warnFearsomeRoar:Show(args.destName, amount)
		timerFearsomeRoar:Start(args.destName)
		timerFearsomeRoarCD:Start()
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
		timerAcidBreath:Start(args.destName)
		timerAcidBreathCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnAcidBreath:Show(args.amount)
			else
				specWarnAcidBreathOther:Show(args.destName)
			end
		end
	elseif args.spellId == 143773 then
		local amount = args.amount or 1
		warnFrostBreath:Show(args.destName, amount)
		timerFrostBreath:Start(args.destName)
		timerFrostBreathCD:Start()
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnFrostBreath:Show(args.amount)
			else
				specWarnFrostBreathOther:Show(args.destName)
			end
		end
	elseif args.spellId == 143767 then
		local amount = args.amount or 1
		warnScorchingBreath:Show(args.destName, amount)
		timerScorchingBreath:Start(args.destName)
		timerScorchingBreathCD:Start()
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnScorchingBreath:Show(args.amount)
			else
				specWarnScorchingBreathOther:Show(args.destName)
			end
		end
	elseif args.spellId == 143440 then
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
	elseif args.spellId == 143800 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 3 then
			specWarnIcyBlood:Show(amount)
		end
	elseif args.spellId == 143777 then
		warnFrozenSolid:Show(args.destName)
		specWarnFrozenSolid:Show(args.destName)
	elseif args.spellId == 145974 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143766 then
		timerFearsomeRoar:Cancel(args.destName)
	elseif args.spellId == 143780 then
		timerAcidBreath:Cancel(args.destName)
	elseif args.spellId == 143773 then
		timerFrostBreath:Cancel(args.destName)
	elseif args.spellId == 143767 then
		timerScorchingBreath:Cancel(args.destName)
	elseif args.spellId == 143440  then
		timerBloodFrenzyCD:Cancel()
	elseif args.spellId == 143445 then
		timerFixate:Cancel(args.destName)
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 143411 then
		screechCount = 0
		timerDeafeningScreechCD:Start()
		if self.Options.RangeFrame then
			if self:IsDifficulty("normal10", "heroic10") then
				DBM.RangeCheck:Show(10, nil, nil, 4)
			else
				DBM.RangeCheck:Show(10, nil, nil, 14)
			end
		end
	end
end

--High performance detection of burningBlood targets
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 143783 then--The actual target of the fire, has no cast event, just initial damage using THIS ID
		burningBloodTargets[#burningBloodTargets + 1] = destName
		self:Unschedule(warnBurningBloodTargets)
		self:Schedule(0.5, warnBurningBloodTargets)
		if destGUID == UnitGUID("player") then
			specWarnBurningBlood:Show()
			yellBurningBlood:Yell()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143784 and destGUID == UnitGUID("player") and self:AntiSpam() then--Different from abobe ID, this is ID that fires for standing in fire on ground not for being target of cast
		specWarnBurningBloodMove:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	--"<80.5 19:14:22> [UNIT_SPELLCAST_SUCCEEDED] Thok the Bloodthirsty [[boss1:Blood Frenzy::0:144067]]", -- [6548]
	--"<80.7 19:14:22> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#%s detects a cluster of injured enemies and goes into a  |cFFFF0404|Hspell:143440|h[Blood Frenzy]|h|r!#Thok the Bloodthirsty
	--"<84.2 19:14:26> [CLEU] SPELL_AURA_APPLIED#false#0xF151176900000D94#Thok the Bloodthirsty#68168#0#0xF151176900000D94#Thok the Bloodthirsty#68168#0#143440#Blood Frenzy#1#BUFF", -- [6851]
	if spellId == 144067 then--Faster than combatlog ^^
		--Unlike bloods, breaths do cancel in frenzy phase
		timerFearsomeRoarCD:Cancel()
		timerAcidBreathCD:Cancel()
		timerFrostBreathCD:Cancel()
		timerScorchingBreathCD:Cancel()
		timerTailLashCD:Cancel()
		specWarnBloodFrenzy:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	--He retains/casts "blood" abilities through Blood frenzy, and only stops them when he changes to different Pustles
	--This is why we cancel Blood cds here
	elseif spellId == 143971 then
		timerBurningBloodCD:Cancel()
		warnAcidPustules:Show()
		timerCorrosiveBloodCD:Start(14)
		timerAcidBreathCD:Start()
	elseif spellId == 143968 then
		timerBurningBloodCD:Cancel()
		timerCorrosiveBloodCD:Cancel()
		warnFrostPustules:Show()
		timerFrostBreathCD:Start(6)
	elseif spellId == 143970 then
		timerCorrosiveBloodCD:Cancel()
		warnFirePustules:Show()
		timerBurningBloodCD:Start(10)
		timerScorchingBreathCD:Start()
	end
end
