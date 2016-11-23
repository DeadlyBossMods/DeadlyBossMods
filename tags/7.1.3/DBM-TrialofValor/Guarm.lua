local mod	= DBM:NewMod(1830, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114323)
mod:SetEncounterID(1962)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(15488)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227514",
	"SPELL_CAST_SUCCESS 227883 227816 228824",
	"SPELL_AURA_APPLIED 228744 228810 228818 232173 228228 228253 228248",
	"SPELL_AURA_REMOVED 228744 228810 228818",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, licks timers stillnot possible? they were still random/chaotic even in LFR
--TODO, info frame with fancy info like what your current debuff is as well as debuff count totals for entire raid? Maybe some other stuff
--TODO, More Volatile Foam stuff
local warnOffLeash					= mod:NewSpellAnnounce(228201, 2, 129417)
local warnFangs						= mod:NewCountAnnounce(227514, 2)
local warnShadowLick				= mod:NewTargetAnnounce(228253, 2, nil, "Healer")
local warnFrostLick					= mod:NewTargetAnnounce(228248, 3)

local specWarnBreath				= mod:NewSpecialWarningCount(228187, nil, nil, nil, 1, 2)
local specWarnLeap					= mod:NewSpecialWarningCount(227883, nil, nil, nil, 2)
local specWarnCharge				= mod:NewSpecialWarningDodge(227816, nil, nil, nil, 2, 2)
local specWarnBerserk				= mod:NewSpecialWarningSpell(227883, nil, nil, nil, 3)
local specWarnFlameLick				= mod:NewSpecialWarningMoveAway(228228, nil, nil, nil, 1, 2)
local yellFlameLick					= mod:NewYell(228228)
local specWarnShadowLick			= mod:NewSpecialWarningYou(228253, false, nil, nil, 1)--Not sure warning player is helpful
local specWarnFrostLick				= mod:NewSpecialWarningYou(228248, false, nil, nil, 1)--Warning player they are stunned probably somewhat useful. Still can't do much about it.
local specWarnFrostLickDispel		= mod:NewSpecialWarningDispel(228248, "Healer", nil, nil, 1, 2)
--Mythic
local specWarnFlamingFoam			= mod:NewSpecialWarningYou(228744, nil, nil, nil, 1)
local specWarnBrineyFoam			= mod:NewSpecialWarningYou(228810, nil, nil, nil, 1)
local specWarnShadowyFoam			= mod:NewSpecialWarningYou(228818, nil, nil, nil, 1)

local timerLeashCD					= mod:NewNextTimer(45, 228201, nil, nil, nil, 6, 129417)
local timerLeash					= mod:NewBuffActiveTimer(30, 228201, nil, nil, nil, 6)
local timerFangsCD					= mod:NewCDCountTimer(20.5, 227514, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--20.5-23
local timerBreathCD					= mod:NewCDCountTimer(20.5, 228187, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerLeapCD					= mod:NewCDCountTimer(22, 227883, nil, nil, nil, 3)
local timerChargeCD					= mod:NewCDTimer(10.9, 227816, nil, nil, nil, 3)
local timerVolatileFoamCD			= mod:NewCDCountTimer(15.7, 228824, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownBreath				= mod:NewCountdown(20.5, 228187)
local countdownFangs				= mod:NewCountdown("Alt20", 227514, "Tank")

local voiceBreath					= mod:NewVoice(228187)--breathsoon
local voiceCharge					= mod:NewVoice(227816)--chargemove
local voiceFlameLick				= mod:NewVoice(228228)--runout
local voiceFrostLick				= mod:NewVoice(228248)--helpdispel

mod:AddSetIconOption("SetIconOnFoam", "ej14535", true)
mod:AddInfoFrameOption(228824, true)
mod:AddRangeFrameOption(5, 228824)

mod.vb.fangCast = 0
mod.vb.breathCast = 0
mod.vb.leapCast = 0
mod.vb.foamCast = 0
--Ugly way to do it, vs a local table, but this ensures that if icon setter disconnects, it doesn't get messed up
mod.vb.one = false
mod.vb.two = false
mod.vb.three = false

local updateInfoFrame
do
	local lines = {}
	local fireDebuff, frostDebuff, shadowDebuff = GetSpellInfo(228744), GetSpellInfo(228818), GetSpellInfo(228818)
	local UnitDebuff = UnitDebuff
	updateInfoFrame = function()
		table.wipe(lines)
		for uId in DBM:GetGroupMembers() do
			if UnitDebuff(uId, fireDebuff) then
				lines[UnitName(uId)] = fireDebuff
			elseif UnitDebuff(uId, frostDebuff) then
				lines[UnitName(uId)] = frostDebuff
			elseif UnitDebuff(uId, shadowDebuff) then
				lines[UnitName(uId)] = shadowDebuff
			end
		end
		return lines
	end
end

function mod:OnCombatStart(delay)
	self.vb.fangCast = 0
	self.vb.breathCast = 0
	self.vb.leapCast = 0
	--All other combat start timers started by Helyatosis
	if not self:IsLFR() then
		if self:IsMythic() then
			self.vb.one = false
			self.vb.two = false
			self.vb.three = false
			self.vb.foamCast = 0
			berserkTimer:Start(240-delay)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(GetSpellInfo(228824))
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
			end
		else
			berserkTimer:Start(-delay)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
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
	if spellId == 227514 then
		self.vb.fangCast = self.vb.fangCast + 1
		warnFangs:Show(self.vb.fangCast)
		if self.vb.fangCast == 1 then
			timerFangsCD:Start(nil, 2)
			countdownFangs:Start(20.5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227883 then
		self.vb.leapCast = self.vb.leapCast + 1
		specWarnLeap:Show(self.vb.leapCast)
		if self.vb.leapCast == 1 then
			timerLeapCD:Start(nil, 2)
		end
	elseif spellId == 227816 then
		specWarnCharge:Show()
		voiceCharge:Play("chargemove")
	elseif spellId == 228824 then
		self.vb.foamCast = self.vb.foamCast + 1
		if self.vb.foamCast < 3 then
			timerVolatileFoamCD:Start(nil, self.vb.foamCast+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228744 or spellId == 228810 or spellId == 228818 then
		if spellId == 228744 then
			if args:IsPlayer() then
				specWarnFlamingFoam:Show()
			end
		elseif spellId == 228810 then
			if args:IsPlayer() then
				specWarnBrineyFoam:Show()
			end
		elseif spellId == 228818 then
			if args:IsPlayer() then
				specWarnShadowyFoam:Show()
			end
		end
		if self.Options.SetIconOnFoam then
			if not self.vb.one then
				self.vb.one = true
				self:SetIcon(args.destName, 1)
			elseif not self.vb.two then
				self.vb.two = true
				self:SetIcon(args.destName, 2)
			elseif not self.vb.three then
				self.vb.three = true
				self:SetIcon(args.destName, 3)
			end
		end
	elseif spellId == 232173 then--Berserk
		timerLeapCD:Stop()
		timerChargeCD:Stop()
		specWarnBerserk:Show()
	elseif spellId == 228228 then
		if args:IsPlayer() then
			specWarnFlameLick:Show()
			voiceFlameLick:Play("runout")
			yellFlameLick:Yell()
		end
	elseif spellId == 228253 then
		warnShadowLick:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShadowLick:Show()
		end
	elseif spellId == 228248 then
		if self.Options.specwarn228248dispel then
			specWarnFrostLickDispel:CombinedShow(0.3, args.destName)
			if self:AntiSpam(3, 1) then
				voiceFrostLick:Play("helpdispel")
			end
		else
			warnFrostLick:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() then
			specWarnFrostLick:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 228744 or spellId == 228810 or spellId == 228818 then
		local uId = DBM:GetRaidUnitId(args.destName)
		local currentIcon = GetRaidTargetIndex(uId)
		if self.Options.SetIconOnFoam then
			if currentIcon == 1 then
				self.vb.one = false
			elseif currentIcon == 2 then
				self.vb.two = false
			elseif currentIcon == 3 then
				self.vb.three = false
			end
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
Might be inversed depending on perspective.
227658: Fiery left, Salty middle, Dark right
227660: Fiery left, Dark middle, Salty right
227666: Salty left, Fiery middle, Dark right
227667: Salty left, Dark middle, Fiery right
227669: Dark left, Fiery middle, Salty right
227673: Dark left, Salty middle, Fiery right
--]]

--Better to just assume things aren't in cobmat log anymore, then switch if they actually are.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227573 then--Guardian's Breath (pre cast used for all 6 versions of breath. Not a bad guess for my drycode huh? :) )
		self.vb.breathCast = self.vb.breathCast + 1
		specWarnBreath:Show(self.vb.breathCast)
		voiceBreath:Play("breathsoon")
		if self.vb.breathCast == 1 then
			timerBreathCD:Start(nil, 2)
			countdownBreath:Start()
		end
	elseif spellId == 228201 then--Off the Leash
		self.vb.leapCast = 0
		warnOffLeash:Show()
		timerLeash:Start()
		--self:Schedule(30, cancelLeash, self)
		timerChargeCD:Start()
	elseif spellId == 231561 then--Helyatosis (off the leash ending)
		self.vb.fangCast = 0
		self.vb.breathCast = 0
		timerFangsCD:Start(4, 1)
		countdownFangs:Start(4)
		timerLeashCD:Start()--45
		timerBreathCD:Start(11, 1)--11-14
		countdownBreath:Start(11)--11-14
		if self:IsMythic() then
			self.vb.foamCast = 0
			timerVolatileFoamCD:Start(10, 1)
		end
	end
end
