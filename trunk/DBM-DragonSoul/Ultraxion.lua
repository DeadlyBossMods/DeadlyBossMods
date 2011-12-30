local mod	= DBM:NewMod(331, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55294)
mod:SetModelID(39099)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL"
)

local warnHourofTwilight			= mod:NewCountAnnounce(109416, 4)
local warnFadingLight				= mod:NewTargetCountAnnounce(110080, 3)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(109416, nil, nil, nil, true)
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)--Berserk, you have 5 seconds to finish off the boss ;)
local specWarnFadingLight			= mod:NewSpecialWarningYou(110080)
local specWarnFadingLightOther		= mod:NewSpecialWarningTarget(110080, mod:IsTank())

local timerDrakes					= mod:NewTimer(253, "TimerDrakes", 61248)
local timerCombatStart				= mod:NewTimer(35, "TimerCombatStart", 2457)
local timerUnstableMonstrosity		= mod:NewNextTimer(60, 106372, nil, mod:IsHealer())
local timerHourofTwilight			= mod:NewCastTimer(5, 109416)
local timerHourofTwilightCD			= mod:NewNextCountTimer(45.5, 109416)
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLight				= mod:NewBuffFadesTimer(10, 110080)--Lets try again using duration, not expire. expire just isn't going to work because of GetTime() 4.3 change.
local timerFadingLightCD			= mod:NewNextTimer(10, 110080)--10 second on heroic, 15 on normal
local timerGiftofLight				= mod:NewNextTimer(80, 105896, nil, mod:IsHealer())
local timerEssenceofDreams			= mod:NewNextTimer(155, 105900, nil, mod:IsHealer())
local timerSourceofMagic			= mod:NewNextTimer(215, 105903, nil, mod:IsHealer())
local timerLoomingDarkness			= mod:NewBuffFadesTimer(120, 106498)--Heroic ability, personal only timer.
local timerRaidCDs					= mod:NewTimer(60, "timerRaidCDs", 2565, nil, false)--Does not need to be localized, has no option, uses ShowRaidCDs bool

local berserkTimer					= mod:NewBerserkTimer(360)--some players regard as Ultraxian mod not shows berserk Timer. so it will be better to use Generic Berserk Timer..

local FadingLightCountdown			= mod:NewCountdown(10, 110080)--5-10 second variation that's random according to EJ
local HourofTwilightCountdown		= mod:NewCountdown(45.5, 109416, mod:IsHealer())--can be confusing with Fading Light, only enable for healer. (healers no dot affect by Fading Light)

mod:AddBoolOption("ResetHoTCount", true, "announce")
mod:AddBoolOption("ShowRaidCDs", false, "timer")--Off by default. This is for RAID cds not personal CDs. Shield wall is added because of 4pc bonus, it's assumed on heroic ultraxion you're tanks have 4pc.
mod:AddBoolOption("ShowRaidCDsSelf", false, "timer")--Will be eliminated when popup options are supported.
--My intent is once tandanu gets popup menu options setup to have variable options for both.
--Reset will have following: Never reset, always reset in 3s, reset in 3s in heroic 2 normal
--Raid CDs will have following options: Don't show Raid CDs, Show only My Raid CDs, Show all raid CDs

local hourOfTwilightCount = 0
local fadingLightCount = 0
local fadingLightTargets = {}

local function warnFadingLightTargets()
	warnFadingLight:Show(fadingLightCount, table.concat(fadingLightTargets, "<, >"))
	table.wipe(fadingLightTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(fadingLightTargets)
	hourOfTwilightCount = 0
	fadingLightCount = 0
	timerHourofTwilightCD:Start(45.5-delay, 1)
	HourofTwilightCountdown:Start(45.5)
	timerGiftofLight:Start(-delay)
	timerEssenceofDreams:Start(-delay)
	timerSourceofMagic:Start(-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106371, 109415, 109416, 109417) then
		fadingLightCount = 0
		hourOfTwilightCount = hourOfTwilightCount + 1
		warnHourofTwilight:Show(hourOfTwilightCount)
		specWarnHourofTwilight:Show()
		if self.Options.ResetHoTCount and ((self:IsDifficulty("heroic10", "heroic25") and hourOfTwilightCount == 3) or (self:IsDifficulty("normal10", "normal25", "lfr25") and hourOfTwilightCount == 2)) then
			hourOfTwilightCount = 0
		end
		timerHourofTwilightCD:Start(45.5, hourOfTwilightCount+1)
		HourofTwilightCountdown:Start(45.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFadingLightCD:Start(13)
			timerHourofTwilight:Start(3)
		else
			timerFadingLightCD:Start(20)
			timerHourofTwilight:Start()
		end
	elseif args:IsSpellID(106388) then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(106372, 106376, 106377, 106378, 106379) then
		timerUnstableMonstrosity:Start()
	elseif args:IsSpellID(97462) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--Warrior Rallying Cry
		if UnitDebuff(args.sourceName, GetSpellInfo(106218)) then--Last Defender of Azeroth
			timerRaidCDs:Start(90, args.spellName, args.sourceName)
		else
			timerRaidCDs:Start(180, args.spellName, args.sourceName)
		end
	elseif args:IsSpellID(871) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--Warrior Shield Wall (4pc Assumed)
		if UnitDebuff(args.sourceName, GetSpellInfo(106218)) then--Last Defender of Azeroth
			timerRaidCDs:Start(60, args.spellName, args.sourceName)
		else
			timerRaidCDs:Start(120, args.spellName, args.sourceName)
		end
	elseif args:IsSpellID(62618) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--Paladin Divine Guardian (4pc assumed)
		if UnitDebuff(args.sourceName, GetSpellInfo(106218)) then--Last Defender of Azeroth
			timerRaidCDs:Start(60, args.spellName, args.sourceName)
		else
			timerRaidCDs:Start(120, args.spellName, args.sourceName)
		end
	elseif args:IsSpellID(55233) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--DK Vampric Blood (4pc assumed)
		if UnitDebuff(args.sourceName, GetSpellInfo(106218)) then--Last Defender of Azeroth
			timerRaidCDs:Start(30, args.spellName, args.sourceName)
		else
			timerRaidCDs:Start(60, args.spellName, args.sourceName)
		end
	elseif args:IsSpellID(98008) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--Spirit Link
		timerRaidCDs:Start(180, args.spellName, args.sourceName)
	elseif args:IsSpellID(62618) and self:IsInCombat() and ((self.Options.ShowRaidCDs and not self.Options.ShowRaidCDsSelf) or (self.Options.ShowRaidCDs and self.Options.ShowRaidCDsSelf and UnitName("player") == args.sourceName)) then--Power Word: Barrior
		timerRaidCDs:Start(180, args.spellName, args.sourceName)
	end
end

--Tank IDs
--105925, 110068, 110069, 110070
--Non tank IDs
--109075, 110078, 110079, 110080
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105925, 110068, 110069, 110070) then--Tank Only SpellIDS
		fadingLightCount = fadingLightCount + 1
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if self:IsDifficulty("heroic10", "heroic25") and fadingLightCount < 3 then--It's cast 3 times during hour of twilight buff duration on ultraxion heroic. 20 secomds remaining, 10 seconds remaining, and at 0 seconds remainings.
			timerFadingLightCD:Start()
		elseif self:IsDifficulty("normal10", "normal25") and fadingLightCount < 2 then--It's cast 2 times during hour of twilight buff duration on ultraxion normal. 15 secomds remaining and at 0 seconds remainings.
			timerFadingLightCD:Start(15)
		elseif self:IsDifficulty("lfr25") and self:IsTank() and fadingLightCount < 2 then--Only tanks get it in LFR
			timerFadingLightCD:Start(15)
		end
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(duration-1)--For some reason need to offset it by 1 second to make it accurate but otherwise it's perfect
			timerFadingLight:Start(duration-1)
		else
			specWarnFadingLightOther:Show(args.destName)
		end
		self:Unschedule(warnFadingLightTargets)
		self:Schedule(0.3, warnFadingLightTargets)
	elseif args:IsSpellID(109075, 110078, 110079, 110080) then--Non Tank IDs
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(duration-1)
			timerFadingLight:Start(duration-1)
		end
		self:Unschedule(warnFadingLightTargets)
		self:Schedule(0.3, warnFadingLightTargets)
	elseif args:IsSpellID(106498) and args:IsPlayer() then
		timerLoomingDarkness:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	end
end

--	"<18.7> CHAT_MSG_MONSTER_YELL#It is good to see you again, Alexstrasza. I have been busy in my absence.#Deathwing###Notarget##0#0##0#3731##0#false", -- [1]
--	"<271.9> [UNIT_SPELLCAST_SUCCEEDED] Twilight Assaulter:Possible Target<nil>:target:Twilight Escape::0:109904", -- [11926]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Trash or msg:find(L.Trash) then
		timerDrakes:Start(253, GetSpellInfo(109904))
	end
end