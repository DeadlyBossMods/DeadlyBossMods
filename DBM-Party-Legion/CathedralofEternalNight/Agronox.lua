local mod	= DBM:NewMod(1905, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(117193)
mod:SetEncounterID(2055)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235751",
	"SPELL_CAST_SUCCESS 236527 236639",
	"SPELL_AURA_APPLIED 238598",
	"SPELL_PERIODIC_DAMAGE 240065",
	"SPELL_PERIODIC_MISSED 240065",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Fulminating and succulant lashers after first. Mythic pull logs I have too short
local warnSpores					= mod:NewSpellAnnounce(236524, 2)

local specWarnTimberSmash			= mod:NewSpecialWarningDefensive(235751, "Tank", nil, nil, 1, 2)
local specWarnChokingVine			= mod:NewSpecialWarningMove(238598, nil, nil, nil, 1, 2)
local specWarnSucculentSecretion	= mod:NewSpecialWarningMove(240065, nil, nil, nil, 1, 2)
local specWarnFulminatingLashers	= mod:NewSpecialWarningSwitch(236527, "-Healer", nil, nil, 1, 2)
local specWarnSucculentLashers		= mod:NewSpecialWarningSwitch(236639, "-Healer", nil, nil, 1, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(238674, nil, nil, nil, 4, 2)
local yellFixate					= mod:NewYell(238674)

local timerTimberSmashCD			= mod:NewCDTimer(21.7, 235751, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChokingVinesCD			= mod:NewCDTimer(30, 238598, nil, nil, nil, 3)
local timerFulminatingLashersCD		= mod:NewCDTimer(30, 236527, nil, nil, nil, 1)
local timerSucculentLashersCD		= mod:NewCDTimer(16.5, 236639, nil, nil, nil, 1)
local timerSporesCD					= mod:NewCDTimer(20.5, 236524, nil, nil, nil, 2)

local countdownTimberSmash			= mod:NewCountdown("Alt21", 235751, "Tank")

local voiceTimberSmash				= mod:NewVoice(235751, "Tank")--carefly
local voiceChokingVine				= mod:NewVoice(238598)--runaway
local voiceSucculentSecretion		= mod:NewVoice(240065)--runaway
local voiceFulminatingLashers		= mod:NewVoice(236527, "-Healer")--killmob
local voiceSucculentLashers			= mod:NewVoice(236639, "-Healer")--killmob
local voiceFixate					= mod:NewVoice(238674)--justrun/keepmove

function mod:OnCombatStart(delay)
	timerTimberSmashCD:Start(6-delay)
	countdownTimberSmash:Start(6-delay)
	timerSporesCD:Start(12-delay)
	timerFulminatingLashersCD:Start(17.5-delay)
	timerChokingVinesCD:Start(24.2-delay)
	if self:IsHard() then
		timerSucculentLashersCD:Start(18-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235751 then
		specWarnTimberSmash:Show()
		voiceTimberSmash:Play("carefly")
		timerTimberSmashCD:Start()
		countdownTimberSmash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236527 then
		specWarnFulminatingLashers:Show()
		voiceFulminatingLashers:Play("killmob")
		--timerFulminatingLashersCD:Start()
	elseif spellId == 236639 then
		specWarnSucculentLashers:Show()
		voiceSucculentLashers:Play("killmob")
		--timerSucculentLashersCD:Start()
	elseif spellId == 236524 then
		warnSpores:Show()
		timerSporesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 238598 and args:IsPlayer() then
		specWarnChokingVine:Show()
		voiceChokingVine:Play("runaway")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 240065 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnSucculentSecretion:Show()
		voiceSucculentSecretion:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:238674") then
		specWarnFixate:Show()
		voiceFixate:Play("justrun")
		voiceFixate:Schedule(1, "keepmove")
		yellFixate:Yell()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 236650 then--Choking Vines
		timerChokingVinesCD:Start()
	end
end
