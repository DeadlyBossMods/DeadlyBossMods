local mod	= DBM:NewMod(1148, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78238, 78237)--Pol 78238, Phemos 78237
mod:SetEncounterID(1719)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158057 157943 158134 158093 158200 157952 158415 158419",
	"SPELL_CAST_SUCCESS 158385"
)

--Phemos
local warnEnfeeblingroar			= mod:NewCountAnnounce(158057, 3)
local warnWhirlwind					= mod:NewCountAnnounce(157943, 3)
local warnQuake						= mod:NewCountAnnounce(158200, 3)
--Pol
local warnShieldCharge				= mod:NewTargetAnnounce(158134, 4)--Target scanning assumed
local warnInterruptingShout			= mod:NewCastAnnounce(158093, 3)
local warnPulverize					= mod:NewCountAnnounce(158385, 3)--158385 is primary activation with SPELL_CAST_SUCCESS, cast at start, followed by 3 channeled IDs using SPELL_CAST_START

--Phemos
local specWarnEnfeeblingRoar		= mod:NewSpecialWarningCount(158057)
local specWarnWhirlWind				= mod:NewSpecialWarningCount(157943, nil, nil, nil, 2)
local specWarnQuake					= mod:NewSpecialWarningCount(158200, nil, nil, nil, 2)
--Pol
local specWarnShieldCharge			= mod:NewSpecialWarningYou(158134)
local specWarnShieldChargeNear		= mod:NewSpecialWarningClose(158134)
local yellShieldCharge				= mod:NewYell(158134)
local specWarnInterruptingShout		= mod:NewSpecialWarningCast(158093)
local specWarnPulverize				= mod:NewSpecialWarningSpell(158385, nil, nil, nil, 2)

--Phemos (83 second full rotation, 27-28 in between)
local timerEnfeeblingRoarCD			= mod:NewNextCountTimer(28, 158057)
local timerWhirlwindCD				= mod:NewNextCountTimer(27, 157943)
local timerQuakeCD					= mod:NewNextCountTimer(27, 158200)
--Pol (70 seconds full rotation, 23-24 seconds in between)
local timerShieldChargeCD			= mod:NewNextTimer(24, 158134)
local timerInterruptingShoutCD		= mod:NewNextTimer(23, 158093)
local timerPulverizeCD				= mod:NewNextTimer(23, 158385)
--^^Even though 6 cd timers, coded smart to only need 2 up at a time, by using the predictability of "next ability" timing.

--Non resetting counts because strategy drastically changes based on number of people. Mechanics like debuff duration change with different player counts.
mod.vb.EnfeebleCount = 0
mod.vb.QuakeCount = 0
mod.vb.WWCount = 0
mod.vb.PulverizeCount = 0

function mod:ShieldTarget(targetname, uId)
	if not targetname then return end
	warnShieldCharge:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShieldCharge:Show()
		yellShieldCharge:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnShieldChargeNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.EnfeebleCount = 0
	self.vb.QuakeCount = 0
	self.vb.WWCount = 0
	self.vb.PulverizeCount = 0
	timerShieldChargeCD:Start(24-delay)
	--2nd timer will start 2 seconds into pull when quake is cast.
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 158057 then
		self.vb.EnfeebleCount = self.vb.EnfeebleCount + 1
		warnEnfeeblingroar:Show(self.vb.EnfeebleCount)
		specWarnEnfeeblingRoar:Show(self.vb.EnfeebleCount)
		timerQuakeCD:Start()--Next Special
	elseif spellId == 157943 then
		self.vb.WWCount = self.vb.WWCount + 1
		warnWhirlwind:Show(self.vb.WWCount)
		specWarnWhirlWind:Show(self.vb.WWCount)
		timerEnfeeblingRoarCD:Start()--Next Special
	elseif spellId == 158134 then
		self:BossTargetScanner(78238, "ShieldTarget", 0.01, 20)--This may still not be fast enough, it may require pre scanning like paragons and iron qon do. He spends most of his time looking at target PRE cast
		timerInterruptingShoutCD:Start()--Next Special
	elseif spellId == 158093 then
		warnInterruptingShout:Show()
		specWarnInterruptingShout:Show()
		timerPulverizeCD:Start()--Next Special
	elseif spellId == 158200 then
		self.vb.QuakeCount = self.vb.QuakeCount + 1
		warnQuake:Show(self.vb.QuakeCount)
		specWarnQuake:Show(self.vb.QuakeCount)
		timerWhirlwindCD:Start()--Next Special
	elseif args:IsSpellID(157952, 158415, 158419) then--Pulverize channel IDs
		self.vb.PulverizeCount = self.vb.PulverizeCount + 1
		warnPulverize:Show(self.vb.PulverizeCount)
		timerShieldChargeCD:Start()--Next Special
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158385 then--Activation
		self.vb.PulverizeCount = 0
		specWarnPulverize:Show()
	end
end
