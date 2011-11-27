local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)
mod:SetZone(640)--Deepholm

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_POWER",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnTwilightZone			= mod:NewSpellAnnounce(93553, 2)--Used for protection against UnleashedMagic
local warnTwilightFissure		= mod:NewTargetAnnounce(93546, 3)--Typical void zone.
local warnTwilightBuffet		= mod:NewTargetAnnounce(93551, 3)
local warnUnleashedMagicSoon	= mod:NewPreWarnAnnounce(93556, 10, 3)
local warnUnleashedMagic		= mod:NewCastAnnounce(93556, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnUnleashedMagic	= mod:NewSpecialWarningSpell(93556, nil, nil, nil, true)
local specWarnTwilightFissure	= mod:NewSpecialWarningYou(93546)

local timerTwilightFissureCD	= mod:NewCDTimer(23, 93546)
local timerTwilightZoneCD		= mod:NewNextTimer(30, 93553)
local timerTwilightBuffetCD		= mod:NewCDTimer(20, 93551)
local timerTwilightBuffet		= mod:NewTargetTimer(10, 93551)
local timerUnleashedMagicCD		= mod:NewCDTimer(66, 93556)--66 Cd but least priority spell, she will cast breath, fissure zone or buffet before this, so overlapping CDs often delay this upwards to 5 seconds late

local specialCharging = false
local hasPower = false

function mod:FissureTarget()
	local targetname = self:GetBossTarget(50061)
	if not targetname then return end
	warnTwilightFissure:Show(targetname)
	if targetname == UnitName("player") then
		specWarnTwilightFissure:Show()
	end
end

function mod:OnCombatStart(delay)
	specialCharging = false
	hasPower = false
	timerTwilightBuffetCD:Start(10-delay)
	timerTwilightZoneCD:Start(-delay)--Not a large sample size but seems like it'd be right.
	timerTwilightFissureCD:Start(-delay)--May not be right, not a large sample size
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93556) then
		warnUnleashedMagic:Show()
		specWarnUnleashedMagic:Show()
		timerUnleashedMagicCD:Start()
	elseif args:IsSpellID(93546) then
		self:ScheduleMethod(0.2, "FissureTarget")
		timerTwilightFissureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93553) then
		warnTwilightZone:Show()
		timerTwilightZoneCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93551) then
		warnTwilightBuffet:Show(args.destName)
		timerTwilightBuffet:Start(args.destName)
		timerTwilightBuffetCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(93551) then
		timerTwilightBuffet:Cancel(args.destName)
	end
end

function mod:UNIT_POWER(uId)
	if self:GetUnitCreatureId(uId) == 50061 and UnitPower(uId) == 70 and specialCharging then
		warnUnleashedMagicSoon:Schedule(8)
		timerUnleashedMagicCD:Start(18)--Start a bar in case one doesn't exist, so update function can do it's thing after.
		timerUnleashedMagicCD:Update(48, 66)--Create/update bar here if one doesn't exist or it's wrong (since it varies sometimes if she delays her energy gain spell)
	elseif self:GetUnitCreatureId(uId) == 50061 and UnitPower(uId) >= 0 and not hasPower then
		hasPower = true
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(93554) and not specialCharging then -- Fury of the twilight flight. Sometimes she bugs and doesn't cast this,if she doesnt, she won't gain unit power and thus won't use any specials.
		specialCharging = true
		if not hasPower then--She retains power from previous wipes, so only start this bar if it's 0 on engage, otherwise don't bother, let update function start it later
			timerUnleashedMagicCD:Start()
		end
	end
end
--[[
			"<7.8> [REGEN_DISABLED]  ++ > Regen Disabled : Entering combat! ++ > ", -- [11]
			"<9.8> Xariona:Possible Target<Omegal>:target:Fury of the Twilight Flight::0:93554", -- [1]
			"<39.9> Xariona:Possible Target<Omegal>:target:Fury of the Twilight Flight::0:93554", -- [7]
			"<75.9> Xariona:Possible Target<Omegal>:target:Unleashed Magic::0:93556", -- [16]
--]]
