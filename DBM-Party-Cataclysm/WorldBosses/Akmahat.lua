local mod	= DBM:NewMod("Akmahat", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50063)
mod:SetModelID(34573)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnShockwave			= mod:NewSpellAnnounce(94968, 3, nil, mod:IsTank() or mod:IsHealer())
local warnFuryofSands		= mod:NewSpellAnnounce(94946, 3)
local warnMantle			= mod:NewSpellAnnounce(93561, 4)

local specWarnFuryofSands	= mod:NewSpecialWarningSpell(94946, nil, nil, nil, true)
local specWarnMantle		= mod:NewSpecialWarningSpell(93561)

--local timerShockwaveCD	= mod:NewNextTimer(28.5, 94968)
--local timerFuryofSandsCD	= mod:NewNextTimer(28.5, 93494)
--local timerMantleCD		= mod:NewNextTimer(28.5, 93561)

mod:AddBoolOption("HealthFrame", true)

local shieldValues = {
	[93561] = 500000,
}
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
				absorbed = select( 2, ... ) 
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then 
				absorbed = select( 5, ... )
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
	--timerMantleCD:Start(-delay)
	--timerFuryofSandsCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93561) then
		warnMantle:Show()
		specWarnMantle:Show()
--		timerMantleCD:Start()
	elseif args:IsSpellID(94946) then
		warnFuryofSands:Show()
		specWarnFuryofSands:Show()
--		timerFuryofSandsCD:Start()
	elseif args:IsSpellID(94968) then
		warnShockwave:Show()
--		timerShockwaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)--Assumed spell event, might need to use spell damage, or spell periodic damage instead.
	if args:IsSpellID(93561) then
		local shieldname = GetSpellInfo(93561)
		showShieldHealthBar(self, args.destGUID, shieldname, shieldValues[args.spellId] or 0)
		self:Schedule(60, hideShieldHealthBar)
	end
end

function mod:SPELL_AURA_REMOVED(args)--Assumed spell event, might need to use spell damage, or spell periodic damage instead.
	if args:IsSpellID(93561) then
		self:Unschedule(hideShieldHealthBar)
		hideShieldHealthBar()
	end
end
