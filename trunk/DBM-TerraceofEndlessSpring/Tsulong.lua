local mod	= DBM:NewMod(742, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62442)--62919 Unstable Sha, 62969 Embodied Terror
mod:SetModelID(42532)
mod:SetReCombatTime(60)--fix lfr combat re-starts after killed.

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnNight							= mod:NewSpellAnnounce("ej6310", 2, 108558)
local warnSunbeam						= mod:NewSpellAnnounce(122789, 3)
local warnShadowBreath					= mod:NewSpellAnnounce(122752, 3)
local warnNightmares					= mod:NewTargetAnnounce(122770, 4)--Target scanning will only work on 1 target on 25 man (only is 1 target on 10 man so they luck out)
local warnDarkOfNight					= mod:NewCountAnnounce("ej6550", 4, 130013)--Heroic
local warnDay							= mod:NewSpellAnnounce("ej6315", 2, 122789)
local warnSummonUnstableSha				= mod:NewSpellAnnounce("ej6320", 3, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local warnSummonEmbodiedTerror			= mod:NewCountAnnounce("ej6316", 4, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local warnTerrorize						= mod:NewTargetAnnounce(123012, 4, nil, mod:IsHealer())
local warnSunBreath						= mod:NewCountAnnounce(122855, 3)
local warnLightOfDay					= mod:NewStackAnnounce(123716, 1, nil, mod:IsHealer(), "warnLightOfDay")

local specWarnShadowBreath				= mod:NewSpecialWarningSpell(122752, mod:IsTank())
local specWarnDreadShadows				= mod:NewSpecialWarningStack(122768, nil, 9)--For heroic, 10 is unhealable, and it stacks pretty fast so adaquate warning to get over there would be abou 5-6
local specWarnNightmares				= mod:NewSpecialWarningSpell(122770, nil, nil, nil, 2)
local specWarnNightmaresYou				= mod:NewSpecialWarningYou(122770)
local specWarnNightmaresNear			= mod:NewSpecialWarningClose(122770)
local yellNightmares					= mod:NewYell(122770)
local specWarnDarkOfNight				= mod:NewSpecialWarningSwitch("ej6550", mod:IsDps())
local specWarnTerrorize					= mod:NewSpecialWarningDispel(123012, mod:IsHealer())

local timerNightCD						= mod:NewNextTimer(121, "ej6310", nil, nil, nil, 130013)
local timerSunbeamCD					= mod:NewCDTimer(41, 122789)
local timerShadowBreathCD				= mod:NewCDTimer(26, 122752, nil, mod:IsTank() or mod:IsHealer())
local timerNightmaresCD					= mod:NewNextTimer(15.5, 122770)
local timerDarkOfNightCD				= mod:NewCDTimer(30.5, "ej6550", nil, nil, nil, 130013)
local timerDayCD						= mod:NewNextTimer(121, "ej6315", nil, nil, nil, 122789)
local timerSummonUnstableShaCD			= mod:NewNextTimer(18, "ej6320", nil, nil,nil, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local timerSummonEmbodiedTerrorCD		= mod:NewNextCountTimer(41, "ej6316", nil, nil, nil, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local timerTerrorizeCD					= mod:NewCDTimer(13.5, 123012)--Besides being cast 14 seconds after they spawn, i don't know if they recast it if they live too long, their health was too undertuned to find out.
local timerSunBreathCD					= mod:NewNextCountTimer(29, 122855)
local timerBathedinLight				= mod:NewBuffFadesTimer(6, 122858, nil, mod:IsHealer())
local timerLightOfDay					= mod:NewTargetTimer(6, 123716, nil, mod:IsHealer())

local countdownNightmares				= mod:NewCountdown(15.5, 122770, false)
local countdownSunBreath				= mod:NewCountdown(29, 122855, mod:IsHealer())

local berserkTimer						= mod:NewBerserkTimer(490)--a little over 8 min, basically 3rd dark phase is auto berserk.

local terrorName = EJ_GetSectionInfo(6316)
local terrorCount = 0
local targetScansDone = 0
local darkOfNightCount = 0
local lightOfDayCount = 0
local breathCount = 0

function mod:ShadowsTarget(targetname)
	warnNightmares:Show(targetname)
	if targetname == UnitName("player") then
		specWarnNightmaresYou:Show()
		yellNightmares:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 10 then
				specWarnNightmaresNear:Show(targetname)
			elseif self:IsDifficulty("normal25", "heroic25", "lfr25") then -- On 25 man, he casts nightmare to 3 men, but target warning works with only 1 man. (like Putricide in ICC Marble Goo). So 25 man shows generic special warning for safety.
				specWarnNightmares:Show()
			end
		end
	end
end

function mod:TargetScanner(ScansDone)
	targetScansDone = targetScansDone + 1
	local targetname, uId = self:GetBossTarget(62442)
	print(targetname, uId)
	if UnitExists(targetname) then--Better way to check if target exists and prevent nil errors at same time, without stopping scans from starting still. so even if target is nil, we stil do more checks instead of just blowing off a warning.
		if self:IsTanking(uId, "boss1") and not ScansDone then--He's targeting his highest threat target.
			if targetScansDone < 16 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "TargetScanner")--Check multiple times to be sure it's not on something other then tank.
			else
				self:TargetScanner(true)--It's still on tank, force true isTank and activate else rule and warn target is on tank.
			end
		else--He's not targeting highest threat target (or isTank was set to true after 16 scans) so this has to be right target.
			self:UnscheduleMethod("TargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			self:ShadowsTarget(targetname)
		end
	else--target was nil, lets schedule a rescan here too.
		if targetScansDone < 16 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "TargetScanner")
		end
	end
end

function mod:OnCombatStart(delay)
	timerShadowBreathCD:Start(8.5-delay)
	timerNightmaresCD:Start(15-delay)
	countdownNightmares:Cancel() -- sometimes it doubles OnCombatStart, wtf?..
	countdownNightmares:Start(15-delay)
	timerSunbeamCD:Start(43-delay)--Sometimes he doesn't emote first cast, so we start a bar for SECOND cast on pull, if we does cast it though, we'll update bar off first cast
	timerDayCD:Start(-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDarkOfNightCD:Start(10-delay)
		darkOfNightCount = 0
		lightOfDayCount = 0
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 122768 then
		if args:IsPlayer() and (args.amount or 1) >= 9 and (args.amount or 1) % 3 == 0  then
			specWarnDreadShadows:Show(args.amount)
		end
	elseif args.spellId == 123012 and args:GetDestCreatureID() == 62442 then
		warnTerrorize:Show(args.destName)
		specWarnTerrorize:Show(args.destName)
	elseif args.spellId == 122858 and args:IsPlayer() then
		timerBathedinLight:Start()
	elseif args.spellId == 123716 then
		lightOfDayCount = lightOfDayCount + 1
		warnLightOfDay:Show(args.destName, lightOfDayCount)
		timerLightOfDay:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args.spellId == 122855 then
		breathCount = breathCount + 1
		warnSunBreath:Show(breathCount)
		if timerNightCD:GetTime() < 100 then
			timerSunBreathCD:Start(29, breathCount+1)
			countdownSunBreath:Start(29)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 122752 then
		warnShadowBreath:Show()
		specWarnShadowBreath:Show()
		if timerNightCD:GetTime() < 93 then
			timerShadowBreathCD:Start()
		end
--"<267.3 22:12:00> [CLEU] SPELL_CAST_SUCCESS#false#0xF150F3EA00000157#Tsulong#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#124176#Gold Active#1", -- [44606]
--"<267.4 22:12:01> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I thank you, strangers. I have been freed.#Tsulong#####0#0##0#4654##0#false#false", -- [44649]
-- 124176 seems not always fires. 123630 seems that followed by after kill events?
	elseif args:IsSpellID(124176, 123630) then
		DBM:EndCombat(self)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:122789") then
		if timerDayCD:GetTime() < 60 then
			timerSunbeamCD:Start()
		end
	elseif msg:find(terrorName) then
		terrorCount = terrorCount + 1
		timerTerrorizeCD:Start()--always cast 14-15 seconds after one spawns (Unless stunned, if you stun the mob you can delay the cast, using this timer)
		warnSummonEmbodiedTerror:Show(terrorCount)
		if terrorCount < 3 then
			timerSummonEmbodiedTerrorCD:Start(nil, terrorCount+1)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122770 and self:AntiSpam(2, 1) then--Nightmares (Night Phase)
		targetScansDone = 0
		self:TargetScanner()
		if timerDayCD:GetTime() < 106 then
			timerNightmaresCD:Start()
			countdownNightmares:Start(15.5)
		end
	elseif spellId == 123252 and self:AntiSpam(2, 2) and self:IsInCombat() then--Dread Shadows Cancel (Sun Phase)
		lightOfDayCount = 0
		terrorCount = 0
		breathCount = 0
		timerShadowBreathCD:Cancel()
		timerSunbeamCD:Cancel()
		timerNightmaresCD:Cancel()
		countdownNightmares:Cancel()
		timerDarkOfNightCD:Cancel()
		warnDay:Show()
		timerSunBreathCD:Start(29, 1)
		countdownSunBreath:Start(29)
		timerNightCD:Start()
	elseif spellId == 122953 and self:AntiSpam(2, 1) then--Summon Unstable Sha (122946 is another ID, but it always triggers at SAME time as Dread Shadows Cancel so can just trigger there too without additional ID scanning.
		warnSummonUnstableSha:Show()
		if timerNightCD:GetTime() < 103 then
			timerSummonUnstableShaCD:Start()
		end
	elseif spellId == 122767 and self:AntiSpam(2, 2) then--Dread Shadows (Night Phase)
		timerSummonUnstableShaCD:Cancel()
		timerSummonEmbodiedTerrorCD:Cancel()
		timerSunBreathCD:Cancel()
		countdownSunBreath:Cancel()
		warnNight:Show()
		timerShadowBreathCD:Start(10)
		timerNightmaresCD:Start()
		countdownNightmares:Start(15.5)
		timerDayCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDarkOfNightCD:Start(10)
			darkOfNightCount = 0
		end
	elseif spellId == 123813 and self:AntiSpam(2, 3) then--The Dark of Night (Night Phase)
		darkOfNightCount = darkOfNightCount + 1
		warnDarkOfNight:Show(darkOfNightCount)
		specWarnDarkOfNight:Show()
		timerDarkOfNightCD:Start()
	end
end
