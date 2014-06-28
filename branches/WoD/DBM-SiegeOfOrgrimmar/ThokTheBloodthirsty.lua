local mod	= DBM:NewMod(851, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71529)
mod:SetEncounterID(1599)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 143343 143428 31821",
	"SPELL_AURA_APPLIED 143411 143766 143780 143773 143767 143440 143442 143445 143791 143800 143777 145974 146589",
	"SPELL_AURA_APPLIED_DOSE 143411 143766 143780 143773 143767 143442 143800",
	"SPELL_AURA_REMOVED 143766 143780 143773 143767 146589 143440 143445",
	"SPELL_DAMAGE 143783",
	"SPELL_MISSED 143783",
	"SPELL_PERIODIC_DAMAGE 143784",
	"SPELL_PERIODIC_MISSED 143784",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnDevotionAura				= mod:NewTargetAnnounce("OptionVersion2", 31821, 1, nil, mod:IsSpellCaster(true))
--Stage 1: A Cry in the Darkness
local warnFearsomeRoar				= mod:NewStackAnnounce(143766, 2, nil, mod:IsTank())--143426
local warnAcceleration				= mod:NewStackAnnounce(143411, 3)--Staghelm 2.0
local warnTailLash					= mod:NewSpellAnnounce(143428, 3, nil, false)--Hey, someone will want this out there.
--Stage 2: Frenzy for Blood!
local warnBloodFrenzy				= mod:NewStackAnnounce(143442, 3)
local warnFixate					= mod:NewTargetAnnounce(143445, 4)
local warnEnrage					= mod:NewTargetAnnounce(145974, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())
local warnKey						= mod:NewTargetAnnounce(146589, 2)
local warnKeyOpen					= mod:NewSpellAnnounce(143917, 1)
--Infusion of Acid
local warnAcidPustules				= mod:NewSpellAnnounce(143971, 2, 143791)
local warnAcidBreath				= mod:NewStackAnnounce(143780, 2, nil, mod:IsTank())
local warnCorrosiveBlood			= mod:NewTargetAnnounce(143791, 2, nil, false)--Spammy, CD was reduced to 2 seconds
--Infusion of Frost
local warnFrostPustules				= mod:NewSpellAnnounce(143968, 3, 143777)
local warnFrostBreath				= mod:NewStackAnnounce(143773, 2, nil, mod:IsTank())
local warnFrozenSolid				= mod:NewTargetAnnounce(143777, 4)--This only thing worth announcing. the stacks of Icy Blood cast SUPER often and not useful
--Infusion of Fire
local warnFirePustules				= mod:NewSpellAnnounce(143970, 2, 143783)
local warnScorchingBreath			= mod:NewStackAnnounce(143767, 2, nil, mod:IsTank())
local warnBurningBlood				= mod:NewTargetAnnounce("OptionVersion2", 143783, 3, nil, false)

local specWarnDevotionAura			= mod:NewSpecialWarningFades("OptionVersion3", 31821, mod:IsSpellCaster(true))
--Stage 1: A Cry in the Darkness
local specWarnFearsomeRoar			= mod:NewSpecialWarningStack(143766, mod:IsTank(), 2)
local specWarnFearsomeRoarOther		= mod:NewSpecialWarningTaunt(143766, mod:IsTank())
local specWarnDeafeningScreech		= mod:NewSpecialWarningCast("OptionVersion3", 143343, mod:IsSpellCaster(), nil, nil, 2)
--Stage 2: Frenzy for Blood!
local specWarnBloodFrenzy			= mod:NewSpecialWarningSpell(143440, nil, nil, nil, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(143445, nil, nil, nil, 3)
local yellFixate					= mod:NewYell(143445)
local specWarnEnrage				= mod:NewSpecialWarningTarget(145974, mod:IsTank() or mod:CanRemoveEnrage())
local specWarnBloodFrenzyOver		= mod:NewSpecialWarningEnd(143440)
--Infusion of Acid
local specWarnAcidBreath			= mod:NewSpecialWarningStack(143780, mod:IsTank(), 3)
local specWarnAcidBreathOther		= mod:NewSpecialWarningTaunt(143780, mod:IsTank())
--Infusion of Frost
local specWarnFrostBreath			= mod:NewSpecialWarningStack(143773, mod:IsTank(), 3)
local specWarnFrostBreathOther		= mod:NewSpecialWarningTaunt(143773, mod:IsTank())
local specWarnIcyBlood				= mod:NewSpecialWarningStack(143800, nil, 3)
local specWarnFrozenSolid			= mod:NewSpecialWarningTarget(143777, mod:IsDps())
--Infusion of Fire
local specWarnScorchingBreath		= mod:NewSpecialWarningStack(143767, mod:IsTank(), 3)
local specWarnScorchingBreathOther	= mod:NewSpecialWarningTaunt(143767, mod:IsTank())
local specWarnBurningBloodMove		= mod:NewSpecialWarningMove(143784)
local yellBurningBlood				= mod:NewYell(143783, nil, false)

local timerDevotionAura				= mod:NewBuffActiveTimer("OptionVersion2", 6, 31821, nil, mod:IsSpellCaster(true))
--Stage 1: A Cry in the Darkness
local timerFearsomeRoar				= mod:NewTargetTimer(30, 143766, nil, mod:IsTank() or mod:IsHealer())
local timerFearsomeRoarCD			= mod:NewCDTimer(11, 143766, nil, mod:IsTank())
local timerDeafeningScreechCD		= mod:NewNextCountTimer(13, 143343)-- (143345 base power regen, 4 every half second)
local timerTailLashCD				= mod:NewCDTimer(10, 143428, nil, false)
--Stage 2: Frenzy for Blood!
local timerBloodFrenzyCD			= mod:NewNextTimer(5, 143442)
local timerBloodFrenzyEnd			= mod:NewBuffActiveTimer(13.5, 143442)
local timerFixate					= mod:NewTargetTimer(12, 143445)
local timerKey						= mod:NewTargetTimer(60, 146589) 
--Infusion of Acid
local timerAcidBreath				= mod:NewTargetTimer(30, 143780, nil, mod:IsTank() or mod:IsHealer())
local timerAcidBreathCD				= mod:NewCDTimer(11, 143780, nil, mod:IsTank())--Often 12, but sometimes 11
local timerCorrosiveBloodCD			= mod:NewCDTimer(3.5, 143791, nil, false)--Cast often, so off by default
--Infusion of Frost
local timerFrostBreath				= mod:NewTargetTimer(30, 143773, nil, mod:IsTank() or mod:IsHealer())
local timerFrostBreathCD			= mod:NewCDTimer(9.5, 143773, nil, mod:IsTank())
--Infusion of Fire
local timerScorchingBreath			= mod:NewTargetTimer(30, 143767, nil, mod:IsTank() or mod:IsHealer())
local timerScorchingBreathCD		= mod:NewCDTimer(11, 143767, nil, mod:IsTank())--Often 12, but sometimes 11
local timerBurningBloodCD			= mod:NewCDTimer(3.5, 143783, nil, false)--cast often, but someone might want to show it

local berserkTimer					= mod:NewBerserkTimer(600)

local soundBloodFrenzy				= mod:NewSound(144067)
local soundFixate					= mod:NewSound(143445)

mod:AddBoolOption("RangeFrame")
mod:AddSetIconOption("FixateIcon", 143445)

--Upvales, don't need variables
local UnitGUID = UnitGUID
--Tables, can't recover
local bloodTargets = {}
--Important, needs recover
mod.vb.screechCount = 0

--this boss works similar to staghelm
local screechTimers = {
	[0] = 13.5,
	[1] = 11,
	[2] = 7.2,
	[3] = 5,
	[4] = 3.5,--These 3.5s tend to variate a little. May be 3.8 or 3.9 even.
	[5] = 3.5,
	[6] = 3.5,
	--Anything beyond this is 2.4 or lower, useless
}

local function clearBloodTargets()
	table.wipe(bloodTargets)
end

function mod:OnCombatStart(delay)
	self.vb.screechCount = 0
	table.wipe(bloodTargets)
	timerFearsomeRoarCD:Start(-delay)
	if self:IsDifficulty("lfr25") then
		timerDeafeningScreechCD:Start(19-delay, 1)
		specWarnDeafeningScreech:Schedule(17.5)
	else
		timerDeafeningScreechCD:Start(-delay, 1)
		specWarnDeafeningScreech:Schedule(12)
	end
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		if self:IsDifficulty("normal10", "heroic10", "flex") then
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
	local spellId = args.spellId
	if spellId == 143343 then--Assumed, 2 second channel but "Instant" cast flagged, this generally means SPELL_AURA_APPLIED
		timerDeafeningScreechCD:Cancel()
		if self:IsDifficulty("lfr25") then
			timerDeafeningScreechCD:Start(18, self.vb.screechCount+1)
			specWarnDeafeningScreech:Schedule(16.5)
		else
			if self.vb.screechCount < 7 then--Don't spam special warning once cd is lower than 4.8 seconds.
				timerDeafeningScreechCD:Start(screechTimers[self.vb.screechCount], self.vb.screechCount+1)
				specWarnDeafeningScreech:Schedule(screechTimers[self.vb.screechCount]-1.5)
			end
		end
	elseif spellId == 143428 then
		warnTailLash:Show()
		timerTailLashCD:Start()
	elseif spellId == 31821 and not self:IsDifficulty("lfr25") then
		warnDevotionAura:Show(args.sourceName)
		specWarnDevotionAura:Cancel()
		specWarnDevotionAura:Schedule(6)--Use scheduling but cancel it if a recast happens, that way we don't falsely warn it's gone since REMOVED fires while buff still up from another person
		timerDevotionAura:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 143411 then
		self.vb.screechCount = args.amount or 1
		warnAcceleration:Show(args.destName, self.vb.screechCount)
	elseif spellId == 143766 then
		timerFearsomeRoarCD:Start()
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnFearsomeRoar:Show(args.destName, amount)
			timerFearsomeRoar:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnFearsomeRoar:Show(args.amount)
				else
					specWarnFearsomeRoarOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 143780 then
		timerAcidBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnAcidBreath:Show(args.destName, amount)
			timerAcidBreath:Start(args.destName)
			timerAcidBreathCD:Start()
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnAcidBreath:Show(args.amount)
				else
					specWarnAcidBreathOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 143773 then
		timerFrostBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnFrostBreath:Show(args.destName, amount)
			timerFrostBreath:Start(args.destName)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnFrostBreath:Show(args.amount)
				else
					specWarnFrostBreathOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 143767 then
		timerScorchingBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnScorchingBreath:Show(args.destName, amount)
			timerScorchingBreath:Start(args.destName)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnScorchingBreath:Show(args.amount)
				else
					specWarnScorchingBreathOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 143440 then
		timerBloodFrenzyCD:Start()
	elseif spellId == 143442 then
		local amount = args.amount or 1
		timerBloodFrenzyCD:Start()
		if amount % 2 == 0 then
			warnBloodFrenzy:Show(args.destName, amount)
		end
	elseif spellId == 143445 then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
			soundFixate:Play()
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif spellId == 143791 then
		warnCorrosiveBlood:CombinedShow(0.5, args.destName)
		timerCorrosiveBloodCD:DelayedStart(0.5)
	elseif spellId == 143800 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 3 then
			specWarnIcyBlood:Show(amount)
		end
	elseif spellId == 143777 then
		warnFrozenSolid:CombinedShow(1, args.destName)--On 25 man, many targets get frozen and often at/near the same time. try to batch em up a bit
		if self:AntiSpam(3, 1) then
			specWarnFrozenSolid:Show(args.destName)
		end
	elseif spellId == 145974 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
	elseif spellId == 146589 then
		warnKey:Show(args.destName)
		timerKey:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 143766 then
		timerFearsomeRoar:Cancel(args.destName)
	elseif spellId == 143780 then
		timerAcidBreath:Cancel(args.destName)
	elseif spellId == 143773 then
		timerFrostBreath:Cancel(args.destName)
	elseif spellId == 143767 then
		timerScorchingBreath:Cancel(args.destName)
	elseif spellId == 146589 then
		timerKey:Cancel(args.destName)
		warnKeyOpen:Show()
		timerBloodFrenzyEnd:Start()
	elseif spellId == 143440 then
		timerBloodFrenzyCD:Cancel()
		self.vb.screechCount = 0
		if self:IsDifficulty("lfr25") then
			timerDeafeningScreechCD:Start(19, 1)
			specWarnDeafeningScreech:Schedule(17.5)
		else
			timerDeafeningScreechCD:Start(nil, 1)
			specWarnDeafeningScreech:Schedule(11.5)
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			if self:IsDifficulty("normal10", "heroic10", "flex") then
				DBM.RangeCheck:Show(10, nil, nil, 4)
			else
				DBM.RangeCheck:Show(10, nil, nil, 14)	
			end
		end
	elseif spellId == 143445 then
		timerFixate:Cancel(args.destName)
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

--High performance detection of burningBlood targets
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 143783 and not bloodTargets[destGUID] then--The actual target of the fire, has no cast event, just initial damage using THIS ID
		bloodTargets[destGUID] = true
		warnBurningBlood:CombinedShow(0.5, destName)
		timerBurningBloodCD:DelayedStart(0.5)
		self:Unschedule(clearBloodTargets)
		self:Schedule(3, clearBloodTargets)
		if destGUID == UnitGUID("player") then
			yellBurningBlood:Yell()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143784 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 2) then--Different from abobe ID, this is ID that fires for standing in fire on ground (even if you weren't target the fire spawned under)
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
		timerDeafeningScreechCD:Cancel()
		specWarnDeafeningScreech:Cancel()
		timerTailLashCD:Cancel()
		specWarnBloodFrenzy:Show()
		soundBloodFrenzy:Play()
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Hide()
		end
	--He retains/casts "blood" abilities through Blood frenzy, and only stops them when he changes to different Pustles
	--This is why we cancel Blood cds above
	elseif spellId == 143971 then
		timerBurningBloodCD:Cancel()
		warnAcidPustules:Show()
		timerCorrosiveBloodCD:Start(6)
		timerAcidBreathCD:Start()
		specWarnBloodFrenzyOver:Show()
	elseif spellId == 143968 then
		timerBurningBloodCD:Cancel()
		timerCorrosiveBloodCD:Cancel()
		warnFrostPustules:Show()
		timerFrostBreathCD:Start(6)
		specWarnBloodFrenzyOver:Show()
	elseif spellId == 143970 then
		timerCorrosiveBloodCD:Cancel()
		warnFirePustules:Show()
		timerBurningBloodCD:Start(8)
		timerScorchingBreathCD:Start()
		specWarnBloodFrenzyOver:Show()
	end
end
