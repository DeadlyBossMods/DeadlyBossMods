local mod	= DBM:NewMod(1153, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79015)
mod:SetEncounterID(1723)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 3, 2, 1)--Don't know total number of icons needed yet

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162185 162184 161411 163517 162186 172895",
	"SPELL_CAST_SUCCESS 161612",
	"SPELL_AURA_APPLIED 156803 162186 161242 163472 172895",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 162186 163472 172895",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, find number of targets of MC and add SetIconsUsed with correct icon count.
--TODO, see if MC has consistent CD (unlike rest of bosses stuff)
--TODO, very 55, 30 30, 55, 30 30, 55, etc pattern for balls
local warnCausticEnergy				= mod:NewTargetAnnounce(161242, 3)
local warnNullBarrier				= mod:NewTargetAnnounce(156803, 2)
local warnVulnerability				= mod:NewTargetAnnounce(160734, 1)
local warnTrample					= mod:NewTargetCountAnnounce(163101, 3)--Technically it's supression field, then trample, but everyone is going to know it more by trample cause that's the part of it that matters
--local warnOverflowingEnergy		= mod:NewSpellAnnounce(161576, 4)--need to find an alternate way to detect this. or just remove :\
local warnExpelMagicFire			= mod:NewSpellAnnounce(162185, 3)
local warnExpelMagicShadow			= mod:NewSpellAnnounce(162184, 3, nil, mod:IsHealer())
local warnExpelMagicFrost			= mod:NewSpellAnnounce(161411, 3)
local warnExpelMagicArcane			= mod:NewTargetAnnounce(162186, 4)--Everyone, so they know to avoid him
local warnBallsSoon					= mod:NewPreWarnAnnounce(161612, 6.5, 2)
local warnMC						= mod:NewTargetAnnounce(163472, 4)--Mythic
local warnForfeitPower				= mod:NewCastAnnounce(163517, 4)--Mythic, Spammy?
local warnExpelMagicFel				= mod:NewTargetAnnounce(172895, 4)

local specWarnNullBarrier			= mod:NewSpecialWarningTarget(156803)--Only warn for boss
local specWarnVulnerability			= mod:NewSpecialWarningTarget(160734)--Switched to target warning since some may be assined adds, some to boss, but all need to know when this phase starts
local specWarnTrample				= mod:NewSpecialWarningYou(163101)
local yellTrample					= mod:NewYell(163101)
--local specWarnOverflowingEnergy	= mod:NewSpecialWarningSpell(161576)--Warn the person with Null barrier.
local specWarnExpelMagicFire		= mod:NewSpecialWarningMoveAway(162185)
local specWarnExpelMagicShadow		= mod:NewSpecialWarningSpell(162184, mod:IsHealer())
local specWarnExpelMagicFrost		= mod:NewSpecialWarningSpell(161411, false)
local specWarnExpelMagicArcaneYou	= mod:NewSpecialWarningMoveAway(162186, nil, nil, nil, 3)
local specWarnExpelMagicArcane		= mod:NewSpecialWarningTaunt(162186)
local yellExpelMagicArcane			= mod:NewYell(162186)
local specWarnBallsSoon				= mod:NewSpecialWarningPreWarn(161612, nil, 6.5)
local specWarnMC					= mod:NewSpecialWarningSwitch(163472, mod:IsDps())
local specWarnForfeitPower			= mod:NewSpecialWarningInterrupt(163517)--Spammy?
local specWarnExpelMagicFel			= mod:NewSpecialWarningYou(172895)--Maybe needs "do not move" warning or at very least "try not to move" since sometimes you have to move for trample.

local timerVulnerability			= mod:NewBuffActiveTimer(20, 160734)
local timerTrampleCD				= mod:NewCDTimer(16, 163101)--Also all over the place, 15-25 with first one coming very randomly (5-20 after barrier goes up)
local timerExpelMagicArcane			= mod:NewTargetTimer(10, 162186, nil, mod:IsTank() or mod:IsHealer())
local timerBallsCD					= mod:NewNextTimer(30, 161612)
--local timerExpelMagicFelCD		= mod:NewCDTimer(30, 172895)--Mythic

local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
local countdownBalls				= mod:NewCountdown("Alt30", 161612)

local soundExpelMagicArcane			= mod:NewSound(162186)

local voiceExpelMagicFire			= mod:NewVoice(162185)
local voiceExpelMagicShadow			= mod:NewVoice(162184, mod:IsHealer())
local voiceExpelMagicFrost			= mod:NewVoice(161411)
local voiceExpelMagicArcane			= mod:NewVoice(162186)
local voiceMC						= mod:NewVoice(163472, mod:IsDps())
local voiceTrample					= mod:NewVoice(163101)
local voiceBalls					= mod:NewVoice(161612)

mod:AddRangeFrameOption("7/5")
mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddSetIconOption("SetIconOnFel", 172895, false)

mod.vb.supressionCount = 0

function mod:OnCombatStart(delay)
	self.vb.supressionCount = 0
	--timerExpelMagicFireCD:Start(6-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function closeRange()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function ballsWarning()
	warnBallsSoon:Show()
	DBM:Debug("Balls should be falling in 1 second")
	if UnitPower("player", 10) > 0 then--Player is soaker
		specWarnBallsSoon:Show()
		voiceBalls:Play("161612")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162185 then
		warnExpelMagicFire:Show()
		specWarnExpelMagicFire:Schedule(5)--Give you about 4 seconds to spread out
		--Even if you AMS or resist debuff, need to avoid others that didn't, so rangecheck now here
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(7)
		end
		countdownMagicFire:Start()
		voiceExpelMagicFire:Play("scattersoon")
		voiceExpelMagicFire:Schedule(5, "scatter")
		self:Schedule(11.5, closeRange)
	elseif spellId == 162184 then
		warnExpelMagicShadow:Show()
		specWarnExpelMagicShadow:Show()
		voiceExpelMagicShadow:Play("healall")
	elseif spellId == 161411 then
		warnExpelMagicFrost:Show()
		specWarnExpelMagicFrost:Show()
		voiceExpelMagicFrost:Play("161411")
	elseif spellId == 163517 then
		warnForfeitPower:Show()
		specWarnForfeitPower:Show(args.sourceName)
	elseif spellId == 162186 then
		local targetName, uId = self:GetBossTarget(79015)
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then--Player is current target
			specWarnExpelMagicArcaneYou:Show()--So show tank warning
			voiceExpelMagicArcane:Play("runout")
			soundExpelMagicArcane:Play()
		else
			if self:AntiSpam(2, targetName) then--Set anti spam with target name
				specWarnExpelMagicArcane:Show(targetName)--Sometimes targetname is nil, and then it warns for unknown, but with the new status == 3 check, it'll still warn correct tank, so useful anyways
				voiceExpelMagicArcane:Play("changemt")
			end
		end
	elseif spellId == 172895 then
		--timerExpelMagicFelCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 161612 and self:AntiSpam(5, 4) then--This won't show balls that hit, only ones caught. Balls that hit require high cpu spell_damage event
		timerBallsCD:Start()
		countdownBalls:Start()
		self:Schedule(23.5, ballsWarning)
		DBM:Debug("timerBallsCD started because a successful soak happened")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156803 then
		warnNullBarrier:Show(args.destName)
		specWarnNullBarrier:Show(args.destName)
--		timerTrampleCD:Start()--5-20
--		timerExpelMagicFelCD:Start()
		--Variation that wild, i'm confident, shield % based not timer based.
	elseif spellId == 162186 then
		warnExpelMagicArcane:Show(args.destName)
		timerExpelMagicArcane:Start(args.destName)
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			yellExpelMagicArcane:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		else
			if self:AntiSpam(2, args.destName) then--if antispam matches cast start warning, it won't warn again, if name is different, it'll trigger new warning
				specWarnExpelMagicArcane:Show(args.destName)
				voiceExpelMagicArcane:Play("changemt")
			end
		end
	elseif spellId == 161242 and self:AntiSpam(3, args.destName) and not self:IsLFR() then--Players may wabble in and out of it and we don't want to spam add them to table.
		warnCausticEnergy:CombinedShow(1, args.destName)--Two targets on mythic, which is why combinedshow. (10 on LFR. too much spam and not important, so disabled in LFR)
	elseif spellId == 163472 then
		warnMC:CombinedShow(0.5, args.destName)
		if self:AntiSpam(3, 1) then
			specWarnMC:Show()
			voiceMC:Play("killmob")
		end
		if self.Options.SetIconOnMC then
			self:SetSortedIcon(1, args.destName, 8, nil, true)--TODO, find out number of targets and add
		end
	elseif spellId == 172895 then
		warnExpelMagicFel:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnExpelMagicFel:Show()
		end
		if self.Options.SetIconOnFel then
			self:SetSortedIcon(1, args.destName, 1, 3)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162186 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 163472 and self.Options.SetIconOnMC then
		self:SetIcon(args.destName, 0)
	elseif spellId == 172895 and self.Options.SetIconOnFel then
		self:SetIcon(args.destName, 0)
	end
end

--"<16.8 14:52:14> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I will crush you!#Ko'ragh###Serrinne##0#0##0#565#nil#0#false#false", -- [5422]
--"<57.9 14:52:55> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Silence!#Ko'ragh###Hesptwo-BetaLevelingRealm02##0#0##0#568#nil#0#false#false", -- [18204]
--"<106.1 14:53:43> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Quiet!#Ko'ragh###Kevo-Level100PvP##0#0##0#572#nil#0#false#false", -- [30685]
--"<77.9 14:43:24> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I will tear you in half!#Ko'ragh###Turkeyburger##0#0##0#510#nil#0#false#false", -- [23203]
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) or msg:find(L.supressionTarget2) or msg:find(L.supressionTarget3) or msg:find(L.supressionTarget4) then
		self:SendSync("ChargeTo", target)--Sync since we have poor language support for many languages.
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 160734 then
		local bossName = UnitName(uId)
		warnVulnerability:Show(bossName)
		specWarnVulnerability:Show(bossName)
		timerVulnerability:Start()
		timerTrampleCD:Cancel()
		local elapsed, total = timerBallsCD:GetTime()
		local remaining = total - elapsed
		--http://worldoflogs.com/reports/umazvvirdsanfg8a/xe/?s=11657&e=12290&x=spell+%3D+%22Overflowing+Energy%22+or+spellid+%3D+156803&page=1
		if remaining > 5 then--If 5 seconds or less on timer, balls are already falling and will not be delayed. If remaining >5 it'll be delayed by 20 seconds (entirety of charge phase)
			timerBallsCD:Start(remaining+20)
			countdownBalls:Cancel()
			specWarnBallsSoon:Cancel()
			countdownBalls:Start(remaining+20)--But for scheduling purposes, remaining+20
			self:Unschedule(ballsWarning)
			self:Schedule(remaining+13.5, ballsWarning)
			DBM:Debug("timerBallsCD is extending by 20 seconds do to shield phase")
		end
--		timerExpelMagicFelCD:Cancel()
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" and targetname then
		timerTrampleCD:Start()
		local target = DBM:GetUnitFullName(targetname)
		if target and self:AntiSpam(3, target) then--Syncs sending from same realm don't send realm name, while other realms do, so it bypasses syncspam code since two diff args. So filter here after GetUnitFullName
			--Investigating someone theory that frost orbs are after every 4 self.vb.supressionCount, except for first, which is after 2. They wanted a counter added
			self.vb.supressionCount = self.vb.supressionCount + 1
			warnTrample:Show(self.vb.supressionCount, target)
			if target == UnitName("player") then
				specWarnTrample:Show()
				yellTrample:Yell()
				voiceTrample:Play("runaway")
			end
		end
	end
end
