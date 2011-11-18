if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

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
	"CHAT_MSG_MONSTER_SAY"
)

local warnHourofTwilight			= mod:NewSpellAnnounce(109416, 4)
local warnFadingLight				= mod:NewTargetAnnounce(110080, 3)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(109416, nil, nil, nil, true)
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)--Berserk, you have 5 seconds to finish off the boss ;)
local specWarnFadingLight			= mod:NewSpecialWarningYou(110080)

local timerCombatStart				= mod:NewTimer(35, "TimerCombatStart", 2457)
local timerHourofTwilightCD			= mod:NewNextTimer(45, 109416)
local timerTwilightEruptionCD		= mod:NewNextTimer(360, 106388)--Berserk timer more or less.
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLight				= mod:NewBuffFadesTimer(10, 110080)
local timerFadingLightCD			= mod:NewNextTimer(10, 110080)--10 second on heroic, 15 on normal

local FadingLightCountdown			= mod:NewCountdown(10, 110080)--5-10 second variation that's random according to EJ

local fadingLightCount = 0
local fadingLightTargets = {}

local function warnFadingLightTargets()
	warnFadingLight:Show(table.concat(fadingLightTargets, "<, >"))
	table.wipe(fadingLightTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(fadingLightTargets)
	fadingLightCount = 0
	timerTwilightEruptionCD:Start(-delay)
	timerHourofTwilightCD:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106371, 109415, 109416, 109417) then
		fadingLightCount = 0
		warnHourofTwilight:Show()
		specWarnHourofTwilight:Show()
		timerHourofTwilightCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFadingLightCD:Start(13)
		else
			timerFadingLightCD:Start(20)--Same in raid finder too? too many difficulties now
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
		--elseif self:IsDifficulty("lfr25") then
			--timerFadingLightCD:Start(15)--Same in raid finder as normal?
		end
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(expires - GetTime() - 5)
			timerFadingLight:Start(expires-GetTime())
		end
		self:Unschedule(warnFadingLightTargets)
		self:Schedule(0.3, warnFadingLightTargets)
	elseif args:IsSpellID(105925, 109075, 110070, 110080) then--Damage done IDs, dps/healer debuffs
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			FadingLightCountdown:Start(expires - GetTime() - 5)
			timerFadingLight:Start(expires-GetTime())
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