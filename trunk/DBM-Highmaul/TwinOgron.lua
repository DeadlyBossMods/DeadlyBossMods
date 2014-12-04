local mod	= DBM:NewMod(1148, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78238, 78237)--Pol 78238, Phemos 78237
mod:SetEncounterID(1719)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158057 157943 158134 158093 158200 157952 158415 158419 163336",
	"SPELL_AURA_APPLIED 163372 167200 158241",
	"SPELL_AURA_APPLIED_DOSE 167200 158241",
	"SPELL_AURA_REMOVED 163372",
	"SPELL_CAST_SUCCESS 158385"
)

--TODO, figure out stack tanks swap at for Arcane Wound(or if they can avoid swapping somehow). (bugged, there were no swapps on mythic, in fact tank debuff was irrelevant
--Note, watch to see if whirlwind returns to 60 60 86, repeating, or if the hotfix to make it old way, is perm
--Phemos
local warnEnfeeblingroar			= mod:NewCountAnnounce(158057, 3)
local warnWhirlwind					= mod:NewCountAnnounce(157943, 3)
local warnQuake						= mod:NewCountAnnounce(158200, 3)
local warnArcaneVolatility			= mod:NewTargetAnnounce(163372, 4)--Mythic
local warnArcaneWound				= mod:NewStackAnnounce(167200, 2, nil, mod:IsTank())
--Pol
local warnShieldCharge				= mod:NewSpellAnnounce(158134, 4)--Target scanning assumed
local warnInterruptingShout			= mod:NewCastAnnounce(158093, 3)
local warnPulverize					= mod:NewCountAnnounce(158385, 3)--158385 is primary activation with SPELL_CAST_SUCCESS, cast at start, followed by 3 channeled IDs using SPELL_CAST_START
local warnArcaneCharge				= mod:NewCastAnnounce(163336, 4)--Mythic. Seems not reliable timer, has a chance to happen immediately after a charge (but not always)

--Phemos
local specWarnEnfeeblingRoar		= mod:NewSpecialWarningCount(158057)
local specWarnWhirlWind				= mod:NewSpecialWarningCount(157943, nil, nil, nil, 2)
local specWarnQuake					= mod:NewSpecialWarningCount(158200, nil, nil, nil, 2)
local specWarnBlaze					= mod:NewSpecialWarningMove(158241, false)
local specWarnArcaneVolatility		= mod:NewSpecialWarningMoveAway(163372)--Mythic
local yellArcaneVolatility			= mod:NewYell(163372)--Mythic
--local specWarnArcaneWound			= mod:NewSpecialWarningStack(167200, nil, 2)
--local specWarnArcaneWoundOther	= mod:NewSpecialWarningTaunt(167200)
--Pol
local specWarnShieldCharge			= mod:NewSpecialWarningSpell(158134, nil, nil, nil, 2)
local specWarnInterruptingShout		= mod:NewSpecialWarningCast(158093)
local specWarnPulverize				= mod:NewSpecialWarningSpell(158385, nil, nil, nil, 2)
local specWarnArcaneCharge			= mod:NewSpecialWarningSpell(163336, nil, nil, nil, 2)--Mythic. Seems not reliable timer, has a chance to happen immediately after a charge (but not always)

--Phemos (100-106 second full rotation, 33-34 in between)
local timerEnfeeblingRoarCD			= mod:NewNextCountTimer(33, 158057)
local timerWhirlwindCD				= mod:NewNextCountTimer(33, 157943)
local timerQuakeCD					= mod:NewNextCountTimer(34, 158200)
--Pol (84 seconds full rotation, 28-29 seconds in between)
local timerShieldChargeCD			= mod:NewNextTimer(28, 158134)
local timerInterruptingShoutCD		= mod:NewNextTimer(28, 158093)
local timerPulverizeCD				= mod:NewNextTimer(29, 158385)
--^^Even though 6 cd timers, coded smart to only need 2 up at a time, by using the predictability of "next ability" timing.
local timerArcaneVolatilityCD		= mod:NewNextTimer(60, 163372)--NOT BOSS POWER BASED, this debuff is cast by outside influence every 60 seconds

--local berserkTimer				= mod:NewBerserkTimer(600)--As reported in feedback threads

local countdownPhemos				= mod:NewCountdown(33, nil, nil, "PhemosSpecial")
local countdownPol					= mod:NewCountdown("Alt28", nil, nil, "PolSpecial")

mod:AddRangeFrameOption(8, 163372)

--Non resetting counts because strategy drastically changes based on number of people. Mechanics like debuff duration change with different player counts.
mod.vb.EnfeebleCount = 0
mod.vb.QuakeCount = 0
mod.vb.WWCount = 0
mod.vb.PulverizeCount = 0
mod.vb.LastQuake = 0
local GetTime = GetTime

function mod:OnCombatStart(delay)
	self.vb.EnfeebleCount = 0
	self.vb.QuakeCount = 0
	self.vb.WWCount = 0
	self.vb.PulverizeCount = 0
	self.vb.LastQuake = 0
	timerQuakeCD:Start(11.5-delay, 1)
	countdownPhemos:Start(11.5-delay)
	timerShieldChargeCD:Start(37.5-delay)--Variable on pull
	countdownPol:Start(37.5-delay)
	if self:IsMythic() then
		timerArcaneVolatilityCD:Start(65-delay)
	end
--[[	if not self:IsLFR() then
		berserkTimer:Start(-delay)
	end--]]
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 158057 then
		self.vb.EnfeebleCount = self.vb.EnfeebleCount + 1
		warnEnfeeblingroar:Show(self.vb.EnfeebleCount)
		specWarnEnfeeblingRoar:Show(self.vb.EnfeebleCount)
		timerQuakeCD:Start(nil, self.vb.QuakeCount+1)--Next Special
		countdownPhemos:Start(34)	
	elseif spellId == 157943 then
		self.vb.WWCount = self.vb.WWCount + 1
		warnWhirlwind:Show(self.vb.WWCount)
		specWarnWhirlWind:Show(self.vb.WWCount)
		timerEnfeeblingRoarCD:Start(nil, self.vb.EnfeebleCount+1)--Next Special
		countdownPhemos:Start(33)
	elseif spellId == 158134 then
		warnShieldCharge:Show()
		specWarnShieldCharge:Show()
		timerInterruptingShoutCD:Start()--Next Special
		countdownPol:Start()
	elseif spellId == 158093 then
		warnInterruptingShout:Show()
		specWarnInterruptingShout:Show()
		timerPulverizeCD:Start()--Next Special
		countdownPol:Start()
	elseif spellId == 158200 then
		self.vb.LastQuake = GetTime()
		self.vb.QuakeCount = self.vb.QuakeCount + 1
		warnQuake:Show(self.vb.QuakeCount)
		specWarnQuake:Show(self.vb.QuakeCount)
		timerWhirlwindCD:Start(nil, self.vb.WWCount+1)
		countdownPhemos:Start(33)	
	elseif args:IsSpellID(157952, 158415, 158419) then--Pulverize channel IDs
		self.vb.PulverizeCount = self.vb.PulverizeCount + 1
		warnPulverize:Show(self.vb.PulverizeCount)
	elseif spellId == 163336 and self:AntiSpam(2, 1) then
		warnArcaneCharge:Show()
		specWarnArcaneCharge:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 163372 then
		warnArcaneVolatility:CombinedShow(1, args.destName)--Applies slowly to all targets
		if self:AntiSpam(2, 2) then
			timerArcaneVolatilityCD:Start()
		end
		if args:IsPlayer() then
			specWarnArcaneVolatility:Show()
			yellArcaneVolatility:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 167200 then
		local amount = args.amount or 1
		warnArcaneWound:Show(args.destName, amount)
--[[		if amount >= 2 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnArcaneWound:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(167200)) and not UnitIsDeadOrGhost("player") then
					specWarnArcaneWoundOther:Show(args.destName)
				end
			end
		end--]]
	elseif spellId == 158241 and args:IsPlayer() and self:AntiSpam(2, 3) then
		specWarnBlaze:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 163372 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158385 then--Activation
		self.vb.PulverizeCount = 0
		specWarnPulverize:Show()
		timerShieldChargeCD:Start()--Next Special
		countdownPol:Start(28)
	end
end
