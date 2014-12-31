local mod	= DBM:NewMod(1153, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79015)
mod:SetEncounterID(1723)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 3, 2, 1)--Don't know total number of icons needed yet

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162185 162184 161411 172747 163517 162186 172895",
	"SPELL_CAST_SUCCESS 161612",
	"SPELL_AURA_APPLIED 156803 162186 161242 163472 172895 172917",
	"SPELL_AURA_REMOVED 162186 163472 172895 156803",
	"SPELL_DAMAGE 161612 161576",
	"SPELL_ABSORBED 161612 161576",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, find number of targets of MC and add SetIconsUsed with correct icon count.
--TODO, see if MC works. I think it's every 3rd balls
local warnCausticEnergy				= mod:NewTargetAnnounce(161242, 3)
local warnNullBarrier				= mod:NewTargetAnnounce(156803, 2)
local warnVulnerability				= mod:NewTargetAnnounce(160734, 1)
local warnTrample					= mod:NewTargetCountAnnounce(163101, 3)--Technically it's supression field, then trample, but everyone is going to know it more by trample cause that's the part of it that matters
local warnExpelMagicFire			= mod:NewSpellAnnounce(162185, 3)
local warnExpelMagicShadow			= mod:NewSpellAnnounce(162184, 3, nil, mod:IsHealer())
local warnExpelMagicFrost			= mod:NewSpellAnnounce(161411, 3)
local warnExpelMagicArcane			= mod:NewTargetAnnounce(162186, 4)--Everyone, so they know to avoid him
local warnBallsSoon					= mod:NewPreWarnAnnounce(161612, 6.5, 2)
local warnBallsHit					= mod:NewCountAnnounce(161612, 2)
local warnMC						= mod:NewTargetAnnounce(163472, 4)--Mythic
local warnForfeitPower				= mod:NewCastAnnounce(163517, 4)--Mythic, Spammy?
local warnExpelMagicFel				= mod:NewTargetAnnounce(172895, 4)

local specWarnNullBarrier			= mod:NewSpecialWarningTarget(156803)--Only warn for boss
local specWarnVulnerability			= mod:NewSpecialWarningTarget(160734)--Switched to target warning since some may be assined adds, some to boss, but all need to know when this phase starts
local specWarnTrample				= mod:NewSpecialWarningYou(163101, nil, nil, nil, nil, nil, true)
local yellTrample					= mod:NewYell(163101)
local specWarnExpelMagicFire		= mod:NewSpecialWarningMoveAway(162185, nil, nil, nil, nil, nil, true)
local specWarnExpelMagicShadow		= mod:NewSpecialWarningSpell(162184, mod:IsHealer(), nil, nil, nil, nil, true)
local specWarnExpelMagicFrost		= mod:NewSpecialWarningSpell(161411, false, nil, nil, nil, nil, true)
local specWarnExpelMagicArcaneYou	= mod:NewSpecialWarningMoveAway(162186, nil, nil, nil, 3, nil, true)
local specWarnExpelMagicArcane		= mod:NewSpecialWarningTaunt(162186, nil, nil, nil, nil, nil, true)
local yellExpelMagicArcane			= mod:NewYell(162186)
local specWarnBallsSoon				= mod:NewSpecialWarningPreWarn(161612, nil, 6.5, nil, nil, nil, nil, true)
local specWarnMC					= mod:NewSpecialWarningSwitch(163472, mod:IsDps())
local specWarnForfeitPower			= mod:NewSpecialWarningInterrupt(163517)--Spammy?
local specWarnExpelMagicFel			= mod:NewSpecialWarningYou(172895)--Maybe needs "do not move" warning or at very least "try not to move" since sometimes you have to move for trample.
local specWarnExpelMagicFelFades	= mod:NewSpecialWarning("specWarnExpelMagicFelFades", nil, nil, nil, 3, nil, true)--No generic that describes this
local yellExpelMagicFel				= mod:NewYell(172895)
local specWarnExpelMagicFelMove		= mod:NewSpecialWarningMove(172917)--Under you (fire). If not enough maybe add periodic damage too?

local timerVulnerability			= mod:NewBuffActiveTimer(20, 160734)
local timerTrampleCD				= mod:NewCDTimer(16, 163101)--Also all over the place, 15-25 with first one coming very randomly (5-20 after barrier goes up)
local timerExpelMagicFire			= mod:NewBuffFadesTimer(11.5, 162185)
local timerExpelMagicFrost			= mod:NewBuffActiveTimer(20, 161411)
local timerExpelMagicArcane			= mod:NewTargetTimer(10, 162186, nil, mod:IsTank() or mod:IsHealer())
local timerBallsCD					= mod:NewNextCountTimer(30, 161612)
local timerExpelMagicFelCD			= mod:NewCDTimer(15.5, 172895)--Mythic
local timerExpelMagicFel			= mod:NewBuffFadesTimer(12, 172895)--Mythic

local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
local countdownBalls				= mod:NewCountdown("Alt30", 161612)
local countdownFel					= mod:NewCountdownFades("AltTwo11", 172895)

local soundExpelMagicArcane			= mod:NewSound(162186)

local voiceExpelMagicFire			= mod:NewVoice(162185)
local voiceExpelMagicShadow			= mod:NewVoice(162184, mod:IsHealer())
local voiceExpelMagicFrost			= mod:NewVoice(161411)
local voiceExpelMagicArcane			= mod:NewVoice(162186)
local voiceMC						= mod:NewVoice(163472, mod:IsDps())
local voiceTrample					= mod:NewVoice(163101)
local voiceBalls					= mod:NewVoice(161612)
local voiceExpelMagicArcaneFel		= mod:NewVoice(172895)

mod:AddRangeFrameOption("5")
mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddSetIconOption("SetIconOnFel", 172895, false)
mod:AddArrowOption("FelArrow", 172895, true, 3)

mod.vb.supressionCount = 0
mod.vb.ballsCount = 0
mod.vb.shieldCharging = false
local lastX, LastY = nil, nil--Not in VB table because it player personal position

local function closeRange(self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function ballsWarning()
	warnBallsSoon:Show()
	DBM:Debug("Balls should be falling in 6.5 second")
	if UnitPower("player", 10) > 0 then--Player is soaker
		specWarnBallsSoon:Show()
		voiceBalls:Play("161612")
	end
end

local function checkBossForgot(self)
	DBM:Debug("checkBossForgot ran, which means expected balls 5 seconds late, starting 25 second timer for next balls")
	--self.vb.ballsCount = self.vb.ballsCount + 1--if boss forgot balls, should it be incrimented? need to see log where he forgets his balls to see if it offsets mind contorls from evens to odds, if so, then do NOT incriment. if it does offset mcs that means we need to uncommont this
	timerBallsCD:Start(20, self.vb.ballsCount+1)
	countdownBalls:Start(20)
	self:Schedule(13.5, ballsWarning)
end

local function returnPosition(self)
	specWarnExpelMagicFelFades:Show()
	voiceExpelMagicArcaneFel:Play("172895")
	if self.Options.FelArrow and lastX and LastY then
		DBM.Arrow:ShowRunTo(lastX, LastY, 3, 3, 5)
	end
end

function mod:OnCombatStart(delay)
	self.vb.supressionCount = 0
	self.vb.ballsCount = 0
	self.vb.shieldCharging = false
	--timerExpelMagicFireCD:Start(6-delay)
	timerBallsCD:Start(36-delay, 1)
	countdownBalls:Start(36-delay)
	self:Schedule(29.5-delay, ballsWarning)
	if self:IsMythic() then
		timerExpelMagicFelCD:Start(5-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.FelArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162185 then
		warnExpelMagicFire:Show()
		specWarnExpelMagicFire:Schedule(5)--Give you about 4 seconds to spread out
		--Even if you AMS or resist debuff, need to avoid others that didn't, so rangecheck now here
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		timerExpelMagicFire:Start()
		countdownMagicFire:Start()
		voiceExpelMagicFire:Play("scattersoon")
		voiceExpelMagicFire:Schedule(5, "scatter")
		self:Schedule(11.5, closeRange, self)
	elseif spellId == 162184 then
		warnExpelMagicShadow:Show()
		specWarnExpelMagicShadow:Show()
		voiceExpelMagicShadow:Play("healall")
	elseif args:IsSpellID(161411, 172747) then
		warnExpelMagicFrost:Show()
		specWarnExpelMagicFrost:Show()
		if not self:IsLFR() then
			timerExpelMagicFrost:Start()
		else
			timerExpelMagicFrost:Start(21.5)
		end
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
		timerExpelMagicFelCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 161612 and self:AntiSpam(5, 4) then--This won't show balls that hit, only ones caught. Balls that hit require high cpu spell_damage event
		self:SendSync("Ball")
	end
end

function mod:SPELL_DAMAGE() -- captures spellid 161612, 161576
	if self:AntiSpam(5, 4) then
		self:SendSync("Ball")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156803 then
		self.vb.shieldCharging = false
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
	elseif spellId == 161242 and self:AntiSpam(5, args.destName) and not self:IsLFR() then--Players may wabble in and out of it and we don't want to spam add them to table.
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
			timerExpelMagicFel:Start()
			countdownFel:Start()
			yellExpelMagicFel:Yell()
			lastX, LastY = UnitPosition("player")
			self:Schedule(7, returnPosition, self)
		end
		if self.Options.SetIconOnFel then
			self:SetSortedIcon(1, args.destName, 1, 3)
		end
	elseif spellId == 172917 and args:IsPlayer() then
		specWarnExpelMagicFelMove:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162186 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 163472 and self.Options.SetIconOnMC then
		self:SetIcon(args.destName, 0)
	elseif spellId == 172895 then
		if args:IsPlayer() then
			lastX, LastY = nil, nil
			if self.Options.FelArrow then
				DBM.Arrow:Hide()
			end
		end
		if self.Options.SetIconOnFel then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 156803 then--Null barrier fall off boss
		DBM:Debug("Koragh Lost his shield")
		self.vb.shieldCharging = true
		warnVulnerability:Show(args.destName)
		specWarnVulnerability:Show(args.destName)
		timerVulnerability:Start()
		timerTrampleCD:Cancel()
		timerExpelMagicFelCD:Cancel()
		local elapsed, total = timerBallsCD:GetTime()
		if (elapsed == 0) and (total == 0) then--There was no timer?
			DBM:Debug("Koragh lost his balls?")--Should not happen, but just in case, i want to see when it does clearly
			return
		end
		local remaining = total - elapsed
		--http://worldoflogs.com/reports/umazvvirdsanfg8a/xe/?s=11657&e=12290&x=spell+%3D+%22Overflowing+Energy%22+or+spellid+%3D+156803&page=1
		if remaining > 4 then--If 4 seconds or less on timer, balls are already falling and will not be delayed. If remaining >5 it'll be delayed by 20 seconds (entirety of charge phase)
			timerBallsCD:Cancel()
			timerBallsCD:Start(remaining+22.5, self.vb.ballsCount+1)
			countdownBalls:Cancel()
			specWarnBallsSoon:Cancel()
			countdownBalls:Start(remaining+22.5)
			self:Unschedule(ballsWarning)
			self:Unschedule(checkBossForgot)--Cancel check boss forgot
			self:Schedule(remaining+16, ballsWarning)
			self:Schedule(remaining+32.5, checkBossForgot, self)--Fire checkbossForgot 5 seconds after raid should have soaked or taken damage
			DBM:Debug("timerBallsCD is extending by 22.5 seconds due to shield phase")
		end	
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

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" and targetname then
		timerTrampleCD:Start()
		local target = DBM:GetUnitFullName(targetname)
		if target and self:AntiSpam(3, target) then--Syncs sending from same realm don't send realm name, while other realms do, so it bypasses sync spam code since two diff args. So filter here after GetUnitFullName
			--Investigating someone theory that frost orbs are after every 4 self.vb.supressionCount, except for first, which is after 2. They wanted a counter added
			self.vb.supressionCount = self.vb.supressionCount + 1
			warnTrample:Show(self.vb.supressionCount, target)
			if target == UnitName("player") then
				specWarnTrample:Show()
				yellTrample:Yell()
				voiceTrample:Play("runaway")
			end
		end
	--There no Overflowing Energy for 81 second, this should never happen. What happened? CLEU range? (I think range issue is impossible. No player is out of range during playing rest druid. And the room is not enough large to occur CLEU issue.)
	--12/26 22:11:41.504  SPELL_DAMAGE,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0x10a48,0x0,Player-2110-056C48C0,"__",0x514,0x0,161576,"Overflowing Energy",0x40,0000000000000000,0,0,0,0,0,0,0,0,0.00,0.00,0,16512,-1,64,0,0,7914,nil,nil,nil,nil <-- Soak failure
	--12/26 22:12:03.793  SPELL_AURA_REMOVED,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,156803,"Nullification Barrier",0x1,BUFF,0,0 <---- Shield Phase Start
	--12/26 22:12:34.340  SPELL_CAST_SUCCESS,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,Player-2110-057062D7,"___",0x512,0x0,161612,"Overflowing Energy",0x40,0000000000000000,0,0,0,0,0,0,0,0,0.00,0.00,0 <-- Soak happens (30 + 22.5 sec. correct)
	--12/26 22:13:04.340  -- Expected to fall ball, but nothing.
	--12/26 22:13:11.402  SPELL_AURA_REMOVED,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,156803,"Nullification Barrier",0x1,BUFF,0,0 <---- Shield Phase Start
	--12/26 22:13:55.372  SPELL_CAST_SUCCESS,Vehicle-0-3152-1228-6882-79015-00001D58EE,"Koragh",0xa48,0x0,Player-2110-057062D7,"___",0x512,0x0,161612,"Overflowing Energy",0x40,0000000000000000,0,0,0,0,0,0,0,0,0.00,0.00,0 <-- Soak happens (51 sec after failure occurs)
	elseif msg == "Ball" then
		self.vb.ballsCount = self.vb.ballsCount + 1
		self:Unschedule(ballsWarning)
		self:Unschedule(checkBossForgot)
		local timer
		if self.vb.shieldCharging then
			timer = 52.5--Maybe 51-52.5 variable
			DBM:Debug("timerBallsCD started during shield charging, 52.5 second timer started")
		else
			timer = 30
			DBM:Debug("timerBallsCD started in regular phase, 30 second timer started")
		end
		warnBallsHit:Show(self.vb.ballsCount)
		timerBallsCD:Start(timer, self.vb.ballsCount+1)
		countdownBalls:Start(timer)
		self:Schedule(timer-6.5, ballsWarning)
		self:Schedule(timer+10, checkBossForgot, self)--Fire checkbossForgot 10 seconds after raid should have soaked or taken damage
	end
end
