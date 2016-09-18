local mod	= DBM:NewMod(1819, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116760, 116761, 116830)--116760 Odyn, 116761 Hymdall, 116830 Hyrja
mod:SetEncounterID(1958)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 228003 228012 228171 231013",
	"SPELL_CAST_SUCCESS 228012 228029 228270",
	"SPELL_AURA_APPLIED 228029 227807 227959 228270 227503 227626 228918",
	"SPELL_AURA_APPLIED_DOSE 227626",
	"SPELL_AURA_REMOVED 228029 227807 227959 228270 227503",
	"SPELL_PERIODIC_DAMAGE 228007 228683",
	"SPELL_PERIODIC_MISSED 228007 228683"
)

--TODO: Phase changes, until done timers and warnings wont' cancel appropriately
--TODO, spear of light stuff, too many spellids and I'm not playing guess work with it
--TODO, Cleansing flame timers/target announces?
--Stage 1: Halls of Valor was merely a set back
local warnDancingBlade				= mod:NewSpellAnnounce(228003, 3)--Change if target scanning works, but considering it doesn't in 5 man version of this spell, omitting for now
local warnRevivify					= mod:NewCastAnnounce(228171, 4)
local warnExpelLight				= mod:NewTargetAnnounce(228029, 3)
local warnShieldofLight				= mod:NewTargetAnnounce(228270, 3)
--Stage 3: Odyn immitates lei shen
local warnStormofJustice			= mod:NewTargetAnnounce(227807, 3)

--Stage 1: Halls of Valor was merely a set back
local specWarnDancingBlade			= mod:NewSpecialWarningMove(228003, nil, nil, nil, 1, 2)
--local yellDancingBlade			= mod:NewYell(228003)
local specWarnHornOfValor			= mod:NewSpecialWarningMoveAway(228012, nil, nil, nil, 1, 2)
local specWarnExpelLight			= mod:NewSpecialWarningMoveAway(228029, nil, nil, nil, 1, 2)
local yellExpelLight				= mod:NewYell(228029)
local specWarnShieldofLight			= mod:NewSpecialWarningYou(228270, nil, nil, nil, 1, 2)
local yellShieldofLight				= mod:NewYell(228270)
local yellShieldofLightFades		= mod:NewFadesYell(228270)
--Stage 2: Odyn immitates margok
local specWarnOdynsTest				= mod:NewSpecialWarningCount(227626, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(5, 159515))
local specWarnOdynsTestOther		= mod:NewSpecialWarningTaunt(227626, nil, nil, nil, 1, 2)
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(231013, nil, nil, nil, 2, 2)

--Stage 3: Odyn immitates lei shen
local specWarnStormofJustice		= mod:NewSpecialWarningMoveAway(227807, nil, nil, nil, 1, 2)
local yellStormofJustice			= mod:NewYell(227807)
local specWarnStormforgedSpear		= mod:NewSpecialWarningRun(228918, nil, nil, nil, 4, 2)
local specWarnStormforgedSpearOther	= mod:NewSpecialWarningTaunt(228918, nil, nil, nil, 1, 2)
local specWarnCleansingFlame		= mod:NewSpecialWarningMove(228683, nil, nil, nil, 1, 2)

--Stage 1: Halls of Valor was merely a set back
local timerDancingBladeCD			= mod:NewAITimer(40, 228003, nil, nil, nil, 3)
local timerHornOfValorCD			= mod:NewAITimer(40, 228012, nil, nil, nil, 2)
local timerExpelLightCD				= mod:NewAITimer(40, 228029, nil, nil, nil, 3)
local timerShieldofLightCD			= mod:NewAITimer(40, 228270, nil, nil, nil, 3)
local timerDrawPower				= mod:NewCastTimer(30, 227503, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage 2: Odyn immitates margok
local timerShatterSpearsCD			= mod:NewAITimer(40, 231013, nil, nil, nil, 2)
--Stage 3: Odyn immitates lei shen
local timerStormforgedSpearCD		= mod:NewAITimer(40, 228918, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage 1: Halls of Valor was merely a set back
local countdownDrawPower			= mod:NewCountdown(30, 227503)

--Stage 1: Halls of Valor was merely a set back
local voiceDancingBlade				= mod:NewVoice(228003)--runaway
local voiceHornOfValor				= mod:NewVoice(228012)--scatter
local voiceExpelLight				= mod:NewVoice(228029)--runout
local voiceShieldofLight			= mod:NewVoice(228270)--targetyou
--Stage 2: Odyn immitates margok
local voiceOdynsTest				= mod:NewVoice(227626)--changemt
local voiceShatterSpears			= mod:NewVoice(231013)--watchorb
--Stage 3: Odyn immitates lei shen
local voiceStormofJustice			= mod:NewVoice(227807)--runout
local voiceStormforgedSpear			= mod:NewVoice(228918)--justrun
local voiceCleansingFlame			= mod:NewVoice(228683)--runaway

mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(198108, false)
mod:AddRangeFrameOption("5/8")

mod.vb.phase = 1
mod.vb.hornCasting = false

local expelLight, stormOfJustice = GetSpellInfo(228029), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.hornCasting = false
	timerDancingBladeCD:Start(1-delay)
	timerHornOfValorCD:Start(1-delay)
	timerExpelLightCD:Start(1-delay)
	timerShieldofLightCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197942 then
		warnDancingBlade:Show()
		timerDancingBladeCD:Start()
	elseif spellId == 228012 then
		self.vb.hornCasting = true
		specWarnHornOfValor:Show()
		voiceHornOfValor:Play("scatter")
		timerHornOfValorCD:Start()
		updateRangeFrame(self)
	elseif spellId == 228171 and self:AntiSpam(2, 2) then
		warnRevivify:Show()
	elseif spellId == 231013 then
		specWarnShatterSpears:Show()
		voiceShatterSpears:Play("watchorb")
		timerShatterSpearsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 228012 then
		self.vb.hornCasting = false
		updateRangeFrame(self)
	elseif spellId == 228029 then
		timerExpelLightCD:Start()
	elseif spellId == 228270 then
		timerShieldofLightCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228029 then
		warnExpelLight:CombinedShow(0.3, args.destName)--TODO: Confirm can be more than one target
		if args:IsPlayer() then
			specWarnExpelLight:Show()
			voiceExpelLight:Play("runout")
			yellExpelLight:Yell()
			updateRangeFrame(self)
		end
	elseif spellId == 227807 or spellId == 227959 then--Add and non add version
		warnStormofJustice:CombinedShow(0.3, args.destName)--TODO: Confirm can be more than one target
		if args:IsPlayer() then
			specWarnStormofJustice:Show()
			voiceStormofJustice:Play("runout")
			yellStormofJustice:Yell()
			updateRangeFrame(self)
		end
	elseif spellId == 228270 then
		if args:IsPlayer() then
			specWarnShieldofLight:Show()
			voiceShieldofLight:Play("targetyou")
			yellShieldofLight:Yell()
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellShieldofLightFades:Schedule(remaining-1, 1)
				yellShieldofLightFades:Schedule(remaining-2, 2)
				yellShieldofLightFades:Schedule(remaining-3, 3)
			end
		end
		if self.Options.SetIconOnShield then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 227503 then--Draw power, assumed
		timerDrawPower:Start()
		countdownDrawPower:Start()
	elseif spellId == 227626 then
		local amount = args.amount or 1
		if (amount == 5 or amount >= 9) and not self.vb.noTaunt and self:AntiSpam(3, 3) then--First warning at 5, then a decent amount of time until 8. then spam every 3 seconds at 8 and above.
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then
				specWarnOdynsTest:Show(amount)
			else
				specWarnOdynsTestOther:Show(L.name)
			end
			voiceOdynsTest:Play("changemt")
		end
	elseif spellId == 228918 then
		timerStormforgedSpearCD:Start()--If this can miss, move it to a success event.
		if args:IsPlayer() then
			specWarnStormforgedSpear:Show()
			voiceStormforgedSpear:Play("justrun")
		else
			specWarnStormforgedSpearOther:Show(args.destName)
			voiceStormforgedSpear:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 228029 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 227807 or spellId == 227959 then--Add and non add version
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 228270 then
		if args:IsPlayer() then
			yellShieldofLightFades:Cancel()
		end
		if self.Options.SetIconOnShield then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 227503 then--Draw power, assumed
		timerDrawPower:Stop()
		countdownDrawPower:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnDancingBlade:Show()
		voiceDancingBlade:Play("runaway")
	elseif spellId == 228683 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnCleansingFlame:Show()
		voiceCleansingFlame:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114363 or cid == 114996 then--Valarjar Runebearer

	end
end

--http://ptr.wowhead.com/spell=228297/phase-1-draw-power-periodic
--http://ptr.wowhead.com/spell=228296/phase-1-stormforged-periodic
--http://ptr.wowhead.com/spell=232581/odyn-teleport ?
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
