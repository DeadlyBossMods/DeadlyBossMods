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
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL"
)

local warnHourofTwilight			= mod:NewCountAnnounce(109416, 4)
local warnFadingLight				= mod:NewTargetAnnounce(110080, 3)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(109416, nil, nil, nil, true)
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)--Berserk, you have 5 seconds to finish off the boss ;)
local specWarnFadingLight			= mod:NewSpecialWarningYou(110080)

local timerDrakes					= mod:NewTimer(253, "TimerDrakes", 61248)
local timerCombatStart				= mod:NewTimer(35, "TimerCombatStart", 2457)
local timerHourofTwilight			= mod:NewCastTimer(5, 109416)
local timerHourofTwilightCD			= mod:NewNextCountTimer(45, 109416)
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLight				= mod:NewBuffFadesTimer(10, 110080)--Lets try again using duration, not expire. expire just isn't going to work because of GetTime() 4.3 change.
local timerFadingLightCD			= mod:NewNextTimer(10, 110080)--10 second on heroic, 15 on normal
local timerGiftofLight				= mod:NewNextTimer(80, 105896, nil, mod:IsHealer())
local timerEssenceofDreams			= mod:NewNextTimer(155, 105900, nil, mod:IsHealer())
local timerSourceofMagic			= mod:NewNextTimer(215, 105903, nil, mod:IsHealer())

local berserkTimer					= mod:NewBerserkTimer(360)--some players regard as Ultraxian mod not shows berserk Timer. so it will be better to use Generic Berserk Timer..

local FadingLightCountdown			= mod:NewCountdown(10, 110080)--5-10 second variation that's random according to EJ
local HourofTwilightCountdown		= mod:NewCountdown(45, 109416, mod:IsHealer())--can be confusing with Fading Light, only enable for healer. (healers no dot affect by Fading Light)

local hourOfTwilightCount = 0
local fadingLightCount = 0
local fadingLightTargets = {}

local function warnFadingLightTargets()
	warnFadingLight:Show(table.concat(fadingLightTargets, "<, >"))
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
		timerHourofTwilightCD:Start(45, hourOfTwilightCount+1)
		HourofTwilightCountdown:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFadingLightCD:Start(13)
			timerHourofTwilight:Start(3)
		else
			timerFadingLightCD:Start(20)--Same in raid finder too? too many difficulties now
			timerHourofTwilight:Start()
		end
	elseif args:IsSpellID(106388) then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(110068, 110069, 110078, 110079) then--Damage taken IDs, tank specific debuffs.
		fadingLightCount = fadingLightCount + 1
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if self:IsDifficulty("heroic10", "heroic25") and fadingLightCount < 3 then--It's cast 3 times during hour of twilight buff duration on ultraxion heroic. 20 secomds remaining, 10 seconds remaining, and at 0 seconds remainings.
			timerFadingLightCD:Start()
		elseif self:IsDifficulty("normal10", "normal25") and fadingLightCount < 2 then--It's cast 2 times during hour of twilight buff duration on ultraxion normal. 15 secomds remaining and at 0 seconds remainings.
			timerFadingLightCD:Start(15)
		elseif self:IsDifficulty("lfr25") and self:IsTank() then--Only tanks get it in LFR
			timerFadingLightCD:Start(15)
		end
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(duration-1)--For some reason need to offset it by 1 second to make it accurate but otherwise it's perfect
			timerFadingLight:Start(duration-1)
		end
		self:Unschedule(warnFadingLightTargets)
		self:Schedule(0.3, warnFadingLightTargets)
	elseif args:IsSpellID(105925, 109075, 110070, 110080) then--Damage done IDs, dps/healer debuffs
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(duration-1)
			timerFadingLight:Start(duration-1)
		end
		self:Unschedule(warnFadingLightTargets)
		self:Schedule(0.3, warnFadingLightTargets)
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