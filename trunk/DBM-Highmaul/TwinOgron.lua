local mod	= DBM:NewMod(1148, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78238, 78237)--Pol 78238, Phemos 78237
mod:SetEncounterID(1719)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(11939)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158057 157943 158134 158093 158200 157952 158415 158419 163336",
	"SPELL_AURA_APPLIED 163372 167200 158241 163297",
	"SPELL_AURA_APPLIED_DOSE 167200 158241",
	"SPELL_AURA_REFRESH 163372",
	"SPELL_AURA_REMOVED 163372",
	"SPELL_CAST_SUCCESS 158385"
)

--Phemos
local warnEnfeeblingroar			= mod:NewCountAnnounce(158057, 3)
local warnWhirlwind					= mod:NewCountAnnounce(157943, 3)
local warnQuake						= mod:NewCountAnnounce(158200, 3)
local warnArcaneTwisted				= mod:NewTargetAnnounce(163297, 2)--Mythic, the boss that's going to use empowered abilities
local warnArcaneVolatility			= mod:NewTargetAnnounce(163372, 4)--Mythic
local warnArcaneWound				= mod:NewStackAnnounce("OptionVersion2", 167200, 2, nil, false)--Arcane debuff irrelevant. off by default, even for tanks unless blizz changes it.
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
--Pol
local specWarnShieldCharge			= mod:NewSpecialWarningSpell(158134, nil, nil, nil, 2)
local specWarnInterruptingShout		= mod:NewSpecialWarningCast("OptionVersion2", 158093, mod:IsSpellCaster())
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
local timerArcaneTwistedCD			= mod:NewNextTimer(55, 163297)
local timerArcaneVolatilityCD		= mod:NewNextTimer(60, 163372)--Only first one acurate now. Now it's a mess, was fine on beta. 60 second cd. but now it's boss power based, off BOTH bosses and is a real mess

local berserkTimer					= mod:NewBerserkTimer(420)--As reported in feedback threads

local countdownPhemos				= mod:NewCountdown(33, nil, nil, "PhemosSpecial")
local countdownPol					= mod:NewCountdown("Alt28", nil, nil, "PolSpecial")
local countdownArcaneVolatility		= mod:NewCountdown("AltTwo60", 163372, not mod:IsTank())

local voicePhemos					= mod:NewVoice(nil, nil, "PhemosSpecialVoice")
local voicePol						= mod:NewVoice(nil, nil, "PolSpecialVoice")
local voiceBlaze					= mod:NewVoice(158241, false)
local voiceArcaneVolatility			= mod:NewVoice(163372)

mod:AddRangeFrameOption("8/3", 163372)
mod:AddInfoFrameOption("ej9586")

--Non resetting counts because strategy drastically changes based on number of people. Mechanics like debuff duration change with different player counts.
mod.vb.EnfeebleCount = 0
mod.vb.QuakeCount = 0
mod.vb.WWCount = 0
mod.vb.PulverizeCount = 0
mod.vb.PulverizeRadar = false
mod.vb.LastQuake = 0
mod.vb.arcaneCast = 0
mod.vb.arcaneDebuff = 0
local GetTime = GetTime
local PhemosEnergyRate = 33
local polEnergyRate = 28
local GetSpellInfo = GetSpellInfo
local arcaneDebuff = GetSpellInfo(163372)
local arcaneTwisted = GetSpellInfo(163297)
local UnitDebuff, UnitBuff = UnitDebuff, UnitBuff
local arcaneVTimers = {8.5, 6, 45, 8, 16.5, 8.5, 5.5, 39, 130, 10, 56.5, 8, 6}
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, arcaneDebuff) then
			return true
		end
	end
end

local lines = {}

local function sortInfoFrame(a, b)--is this even needed? no idea. 
	local a = lines[a]
	local b = lines[b]
	if not tonumber(a) then a = -1 end
	if not tonumber(b) then b = -1 end
	if a > b then return true else return false end
end

--Layout
--Boss 1 name - Power
--Boss 1 next ability
--Boss 2 name - Power
--Boss 2 next ability
--if mythic, ability will show if ability empowered or not to right with empowerment name and purple coloring
local function updateInfoFrame()
	table.wipe(lines)
	local bossPower = 0
	local bossPower2 = 0
	if UnitExists("boss1") and UnitExists("boss2") then
		bossPower = UnitPower("boss1")
		bossPower2 = UnitPower("boss2")
	end
	--First, Phem
	if DBM:GetUnitCreatureId("boss1") == 78237 then
		lines[UnitName("boss1")] = bossPower
		if bossPower < 33 then--Whirlwind
			if UnitBuff("boss1", arcaneTwisted) then--Empowered attack
				lines["|cFF9932CD"..GetSpellInfo(157943).."|r"] = GetSpellInfo(163321)
			else
				lines[GetSpellInfo(157943)] = ""
			end
		elseif bossPower < 66 then--Enfeabling Roar
			lines[GetSpellInfo(158057)] = ""
		elseif bossPower < 100 then--Quake
			lines[GetSpellInfo(158200)] = ""
		end
	elseif DBM:GetUnitCreatureId("boss2") == 78237 then
		lines[UnitName("boss2")] = bossPower
		if bossPower2 < 33 then--Whirlwind
			if UnitBuff("boss2", arcaneTwisted) then--Empowered attack
				lines["|cFF9932CD"..GetSpellInfo(157943).."|r"] = GetSpellInfo(163321)
			else
				lines[GetSpellInfo(157943)] = ""
			end
		elseif bossPower2 < 66 then--Enfeabling Roar
			lines[GetSpellInfo(158057)] = ""
		elseif bossPower2 < 100 then--Quake
			lines[GetSpellInfo(158200)] = ""
		end
	end
	--Second, Pol
	if DBM:GetUnitCreatureId("boss1") == 78238 then
		if bossPower < 33 then--Shield Charge
			lines[UnitName("boss1")] = bossPower
			if UnitBuff("boss1", arcaneTwisted) then--Empowered attack
				lines["|cFFFF0000"..GetSpellInfo(158134).."|r"] = GetSpellInfo(163336)
			else
				lines[GetSpellInfo(158134)] = ""
			end
		elseif bossPower < 66 then--Disruptiong Shout
			lines[GetSpellInfo(158093)] = ""
		elseif bossPower < 100 then--Pulverize
			lines[GetSpellInfo(158385)] = ""
		end
	elseif DBM:GetUnitCreatureId("boss2") == 78238 then
		lines[UnitName("boss2")] = bossPower
		if bossPower2 < 33 then--Shield Charge
			if UnitBuff("boss2", arcaneTwisted) then--Empowered attack
				lines["|cFFFF0000"..GetSpellInfo(158134).."|r"] = GetSpellInfo(163336)
			else
				lines[GetSpellInfo(158134)] = ""
			end
		elseif bossPower2 < 66 then--Disruptiong Shout
			lines[GetSpellInfo(158093)] = ""
		elseif bossPower2 < 100 then--Pulverize
			lines[GetSpellInfo(158385)] = ""
		end
	end
	return lines
end

function mod:OnCombatStart(delay)
	self.vb.EnfeebleCount = 0
	self.vb.QuakeCount = 0
	self.vb.WWCount = 0
	self.vb.PulverizeCount = 0
	self.vb.LastQuake = 0
	self.vb.arcaneCast = 0
	self.vb.arcaneDebuff = 0
	self.vb.PulverizeRadar = false
	timerQuakeCD:Start(11.5-delay, 1)
	countdownPhemos:Start(11.5-delay)
	if self:IsMythic() then
		PhemosEnergyRate = 28
		polEnergyRate = 23
		timerArcaneTwistedCD:Start(33-delay)
		timerArcaneVolatilityCD:Start(65-delay)
		countdownArcaneVolatility:Start(65-delay)
		berserkTimer:Start(-delay)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	elseif self:IsHeroic() then
		PhemosEnergyRate = 31
		polEnergyRate = 25
	else--TODO, find out if LFR is even slower
		PhemosEnergyRate = 33
		polEnergyRate = 28
	end
	timerShieldChargeCD:Start(polEnergyRate+10-delay)
	countdownPol:Start(polEnergyRate+10-delay)
	voicePol:Schedule(polEnergyRate+10-delay, "158134") --shield
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(4, "function", updateInfoFrame, sortInfoFrame)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 158057 then
		self.vb.EnfeebleCount = self.vb.EnfeebleCount + 1
		warnEnfeeblingroar:Show(self.vb.EnfeebleCount)
		specWarnEnfeeblingRoar:Show(self.vb.EnfeebleCount)
		if not self:IsMythic() then--On all other difficulties, quake is 1 second longer
			timerQuakeCD:Start(PhemosEnergyRate+1, self.vb.QuakeCount+1)--Next Special
			countdownPhemos:Start(PhemosEnergyRate+1)	
			voicePhemos:Schedule(PhemosEnergyRate + 1 - 6.5, "158200")
		else--On mythic, there is no longer ability than other 2, since 84 is more divisible by 3 than 100 is
			timerQuakeCD:Start(PhemosEnergyRate, self.vb.QuakeCount+1)--Next Special
			countdownPhemos:Start(PhemosEnergyRate)
			voicePhemos:Schedule(PhemosEnergyRate - 6.5, "158200")
		end	
	elseif spellId == 157943 then
		self.vb.WWCount = self.vb.WWCount + 1
		warnWhirlwind:Show(self.vb.WWCount)
		specWarnWhirlWind:Show(self.vb.WWCount)
		timerEnfeeblingRoarCD:Start(PhemosEnergyRate, self.vb.EnfeebleCount+1)--Next Special
		countdownPhemos:Start(PhemosEnergyRate)
		voicePhemos:Schedule(PhemosEnergyRate - 6.5, "158057") --roar
	elseif spellId == 158134 then
		warnShieldCharge:Show()
		specWarnShieldCharge:Show()
		timerInterruptingShoutCD:Start(polEnergyRate)--Next Special
		countdownPol:Start(polEnergyRate)
		voicePol:Schedule(polEnergyRate - 6.5, "158093") --shot
		if self:IsSpellCaster() then
			voicePol:Schedule(polEnergyRate - 0.5, "stopcast")
		end
	elseif spellId == 158093 then
		warnInterruptingShout:Show()
		specWarnInterruptingShout:Show()
		if not self:IsMythic() then
			timerPulverizeCD:Start(polEnergyRate+1)--Next Special
			countdownPol:Start(polEnergyRate+1)
			voicePol:Schedule(polEnergyRate + 1 - 6.5, "157952") --pulverize
		else--On mythic, there is no longer ability than other 2, since 84 is more divisible by 3 than 100 is
			timerPulverizeCD:Start(polEnergyRate)--Next Special
			countdownPol:Start(polEnergyRate)
			voicePol:Schedule(polEnergyRate - 6.5, "157952") --pulverize
		end
	elseif spellId == 158200 then
		self.vb.LastQuake = GetTime()
		self.vb.QuakeCount = self.vb.QuakeCount + 1
		warnQuake:Show(self.vb.QuakeCount)
		specWarnQuake:Show(self.vb.QuakeCount)
		timerWhirlwindCD:Start(PhemosEnergyRate, self.vb.WWCount+1)
		countdownPhemos:Start(PhemosEnergyRate)
		voicePhemos:Schedule(PhemosEnergyRate - 6.5, "157943") --ww
	elseif spellId == 157952 then--Pulverize first cast that needs range finder
		self.vb.PulverizeCount = self.vb.PulverizeCount + 1
		warnPulverize:Show(self.vb.PulverizeCount)
	elseif spellId == 158415 then--Pulverize channel ID2
		self.vb.PulverizeRadar = false
		self.vb.PulverizeCount = self.vb.PulverizeCount + 1
		warnPulverize:Show(self.vb.PulverizeCount)
		--Hide range frame if arcane debuff not active, else switch 
		if self.Options.RangeFrame then
			if self.vb.arcaneDebuff > 0 then
				if UnitDebuff("player", arcaneDebuff) then
					DBM.RangeCheck:Show(8, nil)
				else
					DBM.RangeCheck:Show(8, debuffFilter)
				end
			else
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 158419 then--Pulverize channel ID3
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
		self.vb.arcaneDebuff = self.vb.arcaneDebuff + 1
		warnArcaneVolatility:CombinedShow(1.5, args.destName)--Applies slowly to all targets
		if self:AntiSpam(4, 2) then
			self.vb.arcaneCast = self.vb.arcaneCast + 1
			local cooldown = arcaneVTimers[self.vb.arcaneCast]
			timerArcaneVolatilityCD:Start(cooldown)
			countdownArcaneVolatility:Start(cooldown)
		end
		if args:IsPlayer() then
			specWarnArcaneVolatility:Show()
			yellArcaneVolatility:Yell()
			voiceArcaneVolatility:Play("runout")
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", arcaneDebuff) then
				DBM.RangeCheck:Show(8, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter)
			end
		end
	elseif spellId == 167200 then
		local amount = args.amount or 1
		warnArcaneWound:Show(args.destName, amount)
	elseif spellId == 158241 and args:IsPlayer() and self:AntiSpam(2, 3) then
		specWarnBlaze:Show()
		voiceBlaze:Play("runaway")
	elseif spellId == 163297 then
		warnArcaneTwisted:Show(args.destName)
		timerArcaneTwistedCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--refresh event verified, https://www.warcraftlogs.com/reports/Ya31FTj9bGMyQk8C#view=events&pins=2%24Off%24%23244F4B%24expression%24ability.id+%3D+163372
function mod:SPELL_AURA_REFRESH(args)
	local spellId = args.spellId
	if spellId == 163372 then
		--self.vb.arcaneDebuff missing on purpose. refresh is not +1 since REMOVED not fired yet.
		warnArcaneVolatility:CombinedShow(1.5, args.destName)--Applies slowly to all targets
		if self:AntiSpam(4, 2) then
			self.vb.arcaneCast = self.vb.arcaneCast + 1
			local cooldown = arcaneVTimers[self.vb.arcaneCast]
			timerArcaneVolatilityCD:Start(cooldown)
			countdownArcaneVolatility:Start(cooldown)
		end
		if args:IsPlayer() then
			specWarnArcaneVolatility:Show()
			yellArcaneVolatility:Yell()
			voiceArcaneVolatility:Play("runout")
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", arcaneDebuff) then
				DBM.RangeCheck:Show(8, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 163372 then
		self.vb.arcaneDebuff = self.vb.arcaneDebuff - 1
		if args:IsPlayer() and self.Options.RangeFrame then
			if self.vb.PulverizeRadar then
				DBM.RangeCheck:Show(3, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158385 then--Activation
		self.vb.PulverizeRadar = true
		self.vb.PulverizeCount = 0
		specWarnPulverize:Show()
		timerShieldChargeCD:Start(polEnergyRate)--Next Special
		countdownPol:Start(polEnergyRate)
		voicePol:Play("scatter")
		voicePol:Schedule(polEnergyRate-6.5, "158134")
		if self.Options.RangeFrame and not UnitDebuff("player", arcaneDebuff) then--Show range 3 for everyone, unless have arcane debuff, then you already have range 8 showing everyone that's more important
			DBM.RangeCheck:Show(3, nil)
		end
	end
end
