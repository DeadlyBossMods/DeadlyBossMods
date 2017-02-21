local mod	= DBM:NewMod(1830, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114323)
mod:SetEncounterID(1962)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(15651)
mod.respawnTime = 15
mod:SetMinSyncRevision(15635)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227514",
	"SPELL_CAST_SUCCESS 227883 227816 228824",
	"SPELL_AURA_APPLIED 228744 228794 228810 228811 228818 228819 232173 228228 228253 228248",
	"SPELL_AURA_REMOVED 228744 228794 228810 228811 228818 228819",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 228247 or ability.id = 228251 or ability.id = 228227) and type = "cast"
local warnOffLeash					= mod:NewSpellAnnounce(228201, 2, 129417)
local warnFangs						= mod:NewCountAnnounce(227514, 2)
local warnShadowLick				= mod:NewTargetAnnounce(228253, 2, nil, "Healer")
local warnFrostLick					= mod:NewTargetAnnounce(228248, 3)

local specWarnBreath				= mod:NewSpecialWarningCount(228187, nil, nil, nil, 1, 2)
local specWarnLeap					= mod:NewSpecialWarningCount(227883, nil, nil, nil, 2)
local specWarnCharge				= mod:NewSpecialWarningDodge(227816, nil, nil, nil, 2, 2)
local specWarnBerserk				= mod:NewSpecialWarningSpell(227883, nil, nil, nil, 3)
local specWarnFlameLick				= mod:NewSpecialWarningMoveAway(228228, nil, nil, nil, 1, 2)
local yellFlameLick					= mod:NewYell(228228, nil, false, 2)
local specWarnShadowLick			= mod:NewSpecialWarningYou(228253, false, nil, nil, 1)--Not sure warning player is helpful
local yellShadowLick				= mod:NewYell(228253, nil, false, 2)
local specWarnFrostLick				= mod:NewSpecialWarningYou(228248, false, nil, nil, 1)--Warning player they are stunned probably somewhat useful. Still can't do much about it.
local yellFrostLick					= mod:NewYell(228248, nil, false, 2)
local specWarnFrostLickDispel		= mod:NewSpecialWarningDispel(228248, "Healer", nil, nil, 1, 2)
--Mythic
local specWarnFlamingFoam			= mod:NewSpecialWarningYou(228744, nil, nil, nil, 1)--228794 jump id
local yellFlameFoam					= mod:NewPosYell(228744, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local specWarnBrineyFoam			= mod:NewSpecialWarningYou(228810, nil, nil, nil, 1)--228811 jump id
local yellBrineyFoam				= mod:NewPosYell(228810, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local specWarnShadowyFoam			= mod:NewSpecialWarningYou(228818, nil, nil, nil, 1)
local yellShadowyFoam				= mod:NewPosYell(228818, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)

--local timerLickCD					= mod:NewCDCountTimer(45, "ej14463", nil, nil, nil, 3, 228228)
local timerLeashCD					= mod:NewNextTimer(45, 228201, nil, nil, nil, 6, 129417)
local timerLeash					= mod:NewBuffActiveTimer(30, 228201, nil, nil, nil, 6)
local timerFangsCD					= mod:NewCDCountTimer(20.5, 227514, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--20.5-23
local timerBreathCD					= mod:NewCDCountTimer(20.5, 228187, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerLeapCD					= mod:NewCDCountTimer(22, 227883, nil, nil, nil, 3)
local timerChargeCD					= mod:NewCDTimer(10.9, 227816, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerVolatileFoamCD			= mod:NewCDCountTimer(15.4, 228824, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownBreath				= mod:NewCountdown(20.5, 228187)
local countdownFangs				= mod:NewCountdown("Alt20", 227514, "Tank")

local voiceBreath					= mod:NewVoice(228187)--breathsoon
local voiceCharge					= mod:NewVoice(227816)--chargemove
local voiceFlameLick				= mod:NewVoice(228228)--runout
local voiceFrostLick				= mod:NewVoice(228248)--helpdispel

mod:AddSetIconOption("SetIconOnFoam", "ej14535", true)
mod:AddBoolOption("YellActualRaidIcon", false)
mod:AddBoolOption("FilterSameColor", true)
mod:AddInfoFrameOption(228824, true)
mod:AddRangeFrameOption(5, 228824)
mod:AddNamePlateOption("NPAuraOnFoam", 228824, true)

mod.vb.fangCast = 0
mod.vb.breathCast = 0
mod.vb.leapCast = 0
mod.vb.foamCast = 0
mod.vb.YellRealIcons = false
--Ugly way to do it, vs a local table, but this ensures that if icon setter disconnects, it doesn't get messed up
mod.vb.one = "None"
mod.vb.two = "None"
mod.vb.three = "None"

local updateInfoFrame
local fireFoam, frostFoam, shadowFoam = GetSpellInfo(228744), GetSpellInfo(228810), GetSpellInfo(228818)
local fireDebuff, frostDebuff, shadowDebuff = GetSpellInfo(227539), GetSpellInfo(227566), GetSpellInfo(227570)
local UnitDebuff = UnitDebuff
do
	local lines = {}
	updateInfoFrame = function()
		table.wipe(lines)
		for uId in DBM:GetGroupMembers() do
			if UnitDebuff(uId, fireFoam) then
				if mod.Options.FilterSameColor and UnitDebuff(uId, fireDebuff) then
					--Do nothing
				else
					lines[UnitName(uId)] = "|cffff0000"..STRING_SCHOOL_FIRE.."|r"
				end
			elseif UnitDebuff(uId, frostFoam) then
				if mod.Options.FilterSameColor and UnitDebuff(uId, frostDebuff) then
					--Do nothing
				else
					lines[UnitName(uId)] = "|cff0000ff"..STRING_SCHOOL_FROST.."|r"
				end
			elseif UnitDebuff(uId, shadowFoam) then
				if mod.Options.FilterSameColor and UnitDebuff(uId, shadowDebuff) then
					--Do nothing
				else
					lines[UnitName(uId)] = "|cFF9932CD"..STRING_SCHOOL_SHADOW.."|r"
				end
			end
		end
		return lines
	end
end

local function delayedSync(self)
	self:SendSync("YellActualRaidIcon")
end

function mod:OnCombatStart(delay)
	self.vb.fangCast = 0
	self.vb.breathCast = 0
	self.vb.leapCast = 0
	--All other combat start timers started by Helyatosis
	if not self:IsLFR() then
		if self:IsMythic() then
			self.vb.one = "None"
			self.vb.two = "None"
			self.vb.three = "None"
			self.vb.foamCast = 0
			self.vb.YellRealIcons = false
			--timerLickCD:Start(12.4, 1)
			berserkTimer:Start(240-delay)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(GetSpellInfo(228824))
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
			end
			if UnitIsGroupLeader("player") then
				if self.Options.YellActualRaidIcon then
					self:Schedule(5, delayedSync, self)--Delayed to ensure it's not sent at same time as someone elses OnCombatStart firing and setting YellRealIcons back to false
				end
			end
			if self.Options.NPAuraOnFoam then
				DBM:FireEvent("BossMod_EnableFriendlyNameplates")
			end
		else
			berserkTimer:Start(-delay)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	else
		berserkTimer:Start(420-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnFoam and self:IsMythic() then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
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
	if (spellId == 228744 or spellId == 228794 or spellId == 228810 or spellId == 228811 or spellId == 228818 or spellId == 228819) and args:IsDestTypePlayer() then
		local icon = 0
		local uId = DBM:GetRaidUnitId(args.destName)
		local currentIcon = GetRaidTargetIndex(uId) or 0
		if currentIcon == 0 then--Only if player doesn't already have a debuff
			if self.vb.one == "None" then
				self.vb.one = args.destName
				icon = 1
			elseif self.vb.two == "None" then
				self.vb.two = args.destName
				icon = 2
			elseif self.vb.three == "None" then
				self.vb.three = args.destName
				icon = 3
			end
		end
		if spellId == 228744 or spellId == 228794 then
			if self.Options.FilterSameColor and UnitDebuff(uId, fireDebuff) then
				if icon == 1 then
					self.vb.one = "None"
				elseif icon == 2 then
					self.vb.two = "None"
				elseif icon == 3 then
					self.vb.three = "None"
				end
				return
			end
			if args:IsPlayer() then
				specWarnFlamingFoam:Show()
				if self.vb.YellRealIcons then
					if icon ~= 0 then
						yellFlameFoam:Yell(icon, args.spellName, icon)
					end
				else
					yellFlameFoam:Yell(7, args.spellName, 7)
				end
			end
			if self.Options.SetIconOnFoam and icon ~= 0 then
				self:SetIcon(args.destName, icon)
			end
		elseif spellId == 228810 or spellId == 228811 then
			if self.Options.FilterSameColor and UnitDebuff(uId, frostDebuff) then
				if icon == 1 then
					self.vb.one = "None"
				elseif icon == 2 then
					self.vb.two = "None"
				elseif icon == 3 then
					self.vb.three = "None"
				end
				return
			end
			if args:IsPlayer() then
				specWarnBrineyFoam:Show()
				if self.vb.YellRealIcons then
					if icon ~= 0 then
						yellBrineyFoam:Yell(icon, args.spellName, icon)
					end
				else
					yellBrineyFoam:Yell(6, args.spellName, 6)
				end
			end
			if self.Options.SetIconOnFoam and icon ~= 0 then
				self:SetIcon(args.destName, icon)
			end
		elseif spellId == 228818 or spellId == 228819 then
			if self.Options.FilterSameColor and UnitDebuff(uId, shadowDebuff) then
				if icon == 1 then
					self.vb.one = "None"
				elseif icon == 2 then
					self.vb.two = "None"
				elseif icon == 3 then
					self.vb.three = "None"
				end
				return
			end
			if args:IsPlayer() then
				specWarnShadowyFoam:Show()
				if self.vb.YellRealIcons then
					if icon ~= 0 then
						yellShadowyFoam:Yell(icon, args.spellName, icon)
					end
				else
					yellShadowyFoam:Yell(3, args.spellName, 3)
				end
			end
			if self.Options.SetIconOnFoam and icon ~= 0 then
				self:SetIcon(args.destName, icon)
			end
		end
		if self.Options.NPAuraOnFoam then
			local uId = DBM:GetRaidUnitId(args.destName)
			local remaining
			if uId then
				local _, _, _, _, _, _, expires, _, _ = UnitDebuff(uId, args.spellName)
				remaining = expires-GetTime()
			end
			DBM.Nameplate:Show(false, args.destName, spellId, nil, remaining)
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
			yellShadowLick:Yell()
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
			yellFrostLick:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 228744 or spellId == 228794 or spellId == 228810 or spellId == 228811 or spellId == 228818 or spellId == 228819) and args:IsDestTypePlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self.Options.SetIconOnFoam and not (UnitDebuff(uId, fireFoam) or UnitDebuff(uId, frostFoam) or UnitDebuff(uId, shadowFoam)) then
			if args.destName == self.vb.one then
				self.vb.one = "None"
			elseif args.destName == self.vb.two then
				self.vb.two = "None"
			elseif args.destName == self.vb.three then
				self.vb.three = "None"
			end
			self:SetIcon(args.destName, 0)
		end
		if self.Options.NPAuraOnFoam then
			DBM.Nameplate:Hide(false, args.destName, spellId)
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

function mod:OnSync(msg)
	if msg == "YellActualRaidIcon" then
		DBM:Debug("YellRealIcons = true", 2)
		self.vb.YellRealIcons = true
	end
end
