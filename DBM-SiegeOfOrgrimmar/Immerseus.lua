local mod	= DBM:NewMod(852, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71543)--Doesn't die, will need kill detection
mod:SetReCombatTime(45)--Lets just assume he has same bug as tsulong in advance and avoid problems
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBreath			= mod:NewSpellAnnounce(143436, 3, nil, mod:IsTank() or mod:IsHealer())
local warnShaBolt			= mod:NewSpellAnnounce(143295, 3, nil, false)
local warnSwirl				= mod:NewSpellAnnounce(143309, 4)
local warnSplit				= mod:NewSpellAnnounce(143020, 2)
local warnReform			= mod:NewSpellAnnounce(143469, 2)

local specWarnBreath		= mod:NewSpecialWarningSpell(143436, mod:IsTank())
local specWarnShaSplash		= mod:NewSpecialWarningMove(143297)
local specWarnSwirl			= mod:NewSpecialWarningSpell(143309, nil, nil, nil, 2)

local timerBreathCD			= mod:NewCDTimer(35, 143436, nil, mod:IsTank() or mod:IsHealer())--35-65 second variation wtf?
local timerShaBoltCD		= mod:NewCDTimer(6, 143295, nil, false)--every 6-20 seconds (yeah it variates that much)
local timerSwirlCD			= mod:NewCDTimer(48.5, 143309)
local timerShaResidue		= mod:NewBuffActiveTimer(10, 143459)
local timerPurifiedResidue	= mod:NewBuffActiveTimer(15, 143524)

local berserkTimer			= mod:NewBerserkTimer(605)

local lastPower = 100

function mod:OnCombatStart(delay)
	lastPower = 100
	timerBreathCD:Start(10-delay)
	timerSwirlCD:Start(20-delay)
	berserkTimer:Start(-delay)
	self:RegisterShortTermEvents(
		"UNIT_POWER_FREQUENT boss1"--Do not want this one persisting out of combat even after a wipe, in case you go somewhere else.
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143436 then
		warnBreath:Show()
		specWarnBreath:Show()
		timerBreathCD:Start()
	elseif args.spellId == 143309 then
		warnSwirl:Show()
		specWarnSwirl:Show()
		timerSwirlCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Start()
	elseif args.spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Start()
	elseif args.spellId == 143297 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnShaSplash:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Cancel()
	elseif args.spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 143297 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnShaSplash:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143020 then--Split
		warnSplit:Show()
		timerBreathCD:Cancel()
		timerSwirlCD:Cancel()
		timerShaBoltCD:Cancel()
	elseif spellId == 143293 and self:AntiSpam(3, 2) then--Sha Bolt
		warnShaBolt:Show()
		timerShaBoltCD:Start()
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	local power = UnitPower(uId)
	if power == 0 and self:AntiSpam(3, 1) then
		print("DBM Debug: Boss defeated?")
	end
	if power > lastPower then--Only time his power ever goes UP is when he is defeated. he reaches 0 power, then goes back to 1 power
		DBM:EndCombat(self)
		print("DBM Debug: Boss gained power. This has only been observed in victories so assuming this is a victory")
	end
	lastPower = power
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:143469") then--Reforms
		warnReform:Show()
--		timerBreathCD:Start(15)--8-15 second variation, iffy on this being set
		timerSwirlCD:Start(24)--24-26 variation, this probably is set?
	end
end
