local mod	= DBM:NewMod(692, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61485)
mod:SetModelID(43120)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnBladeRush			= mod:NewSpellAnnounce(124283, 3)
local warnTempest			= mod:NewSpellAnnounce(119875, 3)
local warnBulwark			= mod:NewSpellAnnounce(119476, 3)

local specWarnTempest		= mod:NewSpecialWarningSpell(119875, mod:IsHealer())
local specWarnBulwark		= mod:NewSpecialWarningSpell(119476, nil, nil, nil, true)

local timerBladeRushCD		= mod:NewCDTimer(12, 124283)--12-20sec variation
local timerTempestCD		= mod:NewCDTimer(43, 119875)--Tempest has a higher cast priority than blade rush, if it's do, it'll delay blade rush.

mod:AddBoolOption("HealthFrame", true)

local phase = 1

local showShieldHealthBar, hideShieldHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local shieldedMob
	local absorbRemaining = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(absorbRemaining / maxAbsorb * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
		if shieldedMob == destGUID then
			local absorbed
			if subEvent == "SWING_MISSED" then 
				absorbed = select( 3, ... ) 
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then 
				absorbed = select( 6, ... )
			end
			if absorbed then
				absorbRemaining = absorbRemaining - absorbed
			end
		end
	end)
	
	function showShieldHealthBar(self, mob, shieldName, absorb)
		shieldedMob = mob
		absorbRemaining = absorb
		maxAbsorb = absorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
	end
	
	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

function mod:OnCombatStart(delay)
	phase = 1
	timerBladeRushCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 119476 then
		local shieldname = GetSpellInfo(119476)
		showShieldHealthBar(self, args.destGUID, shieldname, 1500000)
		phase = phase + 1
		warnBulwark:Show()
		specWarnBulwark:Show()
		timerBladeRushCD:Cancel()
		timerTempestCD:Cancel()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 119476 then--When bullwark breaks, he will instantly cast either tempest or blade rush, need more logs to determine if it's random or set.
		hideShieldHealthBar()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 124283 then--he do not target anything. so can't use target scan.
		warnBladeRush:Show()
		timerBladeRushCD:Start()
	elseif args.spellId == 119875 then
		warnTempest:Show()
		specWarnTempest:Show()
		timerBladeRushCD:Start(7)--always 7-7.5 seconds after tempest.
		if phase == 2 then
			timerTempestCD:Start(33)--seems to be cast more often between 66-33% health. (might be 100-33 but didn't get 2 casts before first bulwark)
		else
			timerTempestCD:Start()
		end
	end
end
