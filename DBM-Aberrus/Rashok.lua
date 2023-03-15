local mod	= DBM:NewMod(2525, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201320)
mod:SetEncounterID(2680)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20230315000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 405316 405821 406851 406333 406145 400777 407547 407597 406165",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 405819 407547 407597 401419 405091",
	"SPELL_AURA_APPLIED_DOSE 405091",
	"SPELL_AURA_REMOVED 405819 401419",
	"SPELL_PERIODIC_DAMAGE 403543",
	"SPELL_PERIODIC_MISSED 403543",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, https://www.wowhead.com/ptr/spell=407706/molten-wrath seems passive, but still maybe have a 15 second timer with right script
--TODO, verify right spellIds on abilities that had two
--TODO, this boss seems like the guardian of the first ones all over again. A lot of timer correction will probably be needed
--TODO, fury timer whenever conduit is removed
--TODO, does https://www.wowhead.com/ptr/spell=404431/volatile-explosion trigger every time boss gains conduit? does it need a dodge alert?
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnSearingSlam								= mod:NewTargetNoFilterAnnounce(405821, 4)
local warnSiphonEnergyApplied						= mod:NewTargetNoFilterAnnounce(401419, 2)
local warnSiphonEnergyRemoved						= mod:NewFadesAnnounce(401419, 2)

local specWarnAncientFury							= mod:NewSpecialWarningCount(405316, nil, nil, nil, 2, 2)
local specWarnSearingSlam							= mod:NewSpecialWarningYou(405821, nil, nil, nil, 3, 2)
local yellSearingSlam								= mod:NewShortYell(405821)
local yellSearingSlamFades							= mod:NewShortFadesYell(405821)
local specWarnDoomFlame								= mod:NewSpecialWarningCount(406851, nil, nil, nil, 2, 2)
local specWarnShadowlavaBlast						= mod:NewSpecialWarningDodgeCount(406333, nil, nil, nil, 2, 2)
local specWarnChargedSmash							= mod:NewSpecialWarningDodgeCount(400777, nil, nil, nil, 2, 2)
local specWarnFlamingUpsurge						= mod:NewSpecialWarningDefensive(407547, nil, nil, nil, 1, 2)
local specWarnFlamingUpsurgeTaunt					= mod:NewSpecialWarningTaunt(407547, nil, nil, nil, 1, 2)
local specWarnEarthenCrush							= mod:NewSpecialWarningDefensive(407597, nil, nil, nil, 1, 2)
local specWarnEarthenCrushTaunt						= mod:NewSpecialWarningTaunt(407597, nil, nil, nil, 1, 2)
local specWarnUnyieldingRage						= mod:NewSpecialWarningSpell(406165, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(403543, nil, nil, nil, 1, 8)

--local timerAncientFuryCD							= mod:NewAITimer(29.9, 405316, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSearingSlamCD							= mod:NewAITimer(28.9, 405821, nil, nil, nil, 3)
local timerDoomFlameCD								= mod:NewAITimer(28.9, 406851, nil, nil, nil, 5)
local timerShadowlavaBlastCD						= mod:NewAITimer(28.9, 406333, nil, nil, nil, 3)
local timerChargedSmashCD							= mod:NewAITimer(28.9, 400777, nil, nil, nil, 3)
local timerVolcanicComboCD							= mod:NewAITimer(29.9, 407641, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerUnyieldingRageCD							= mod:NewNextTimer(10, 405091, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnSearingSlam", 405821, true, 0, {1})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--mod:GroupSpells(390715, 396094)

mod.vb.furyCount = 0
mod.vb.slamCount = 0
mod.vb.doomCount = 0
mod.vb.blastCount = 0
mod.vb.smashCount = 0
mod.vb.tankCombo = 0--Cast
mod.vb.comboCount = 0--Combos within cast

function mod:OnCombatStart(delay)
	self.vb.furyCount = 0
	self.vb.slamCount = 0
	self.vb.doomCount = 0
	self.vb.blastCount = 0
	self.vb.smashCount = 0
	self.vb.tankCombo = 0
	self.vb.comboCount = 0
--	timerAncientFuryCD:Start(1-delay)
	timerSearingSlamCD:Start(1-delay)
	timerDoomFlameCD:Start(1-delay)
	timerShadowlavaBlastCD:Start(1-delay)
	timerChargedSmashCD:Start(1-delay)
	timerVolcanicComboCD:Start(1-delay)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	DBM:AddMsg("AI timers may not update correctly if conduit status changes affect timers")
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
--end

--[[
Taunt code conditions explained

1. Any time first cast begins, the target of cast is checked and if they have the debuff that's bad for that cast, a taunt warning is shown, period
2. After first cast finishes in the 2 part combo, since we now know what the 2nd cast will be, if you don't have the bad debuff to take the second cast, a taunt warning is shown for you to swap boss over to you.
3. When 2nd cast begins, if boss is still on wrong target (because you missed taunt in rule 2, you'll be yelled at again that the tank it's on can't survive that attack and you need to taunt if you don't have debuff and can survive that attack.
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 405316 then
		self.vb.furyCount = self.vb.furyCount + 1
		specWarnAncientFury:Show(self.vb.furyCount)
		specWarnAncientFury:Play("aesoon")
--		timerAncientFuryCD:Start()
	elseif spellId == 405821 then
		self.vb.slamCount = self.vb.slamCount + 1
		timerSearingSlamCD:Start()
	elseif spellId == 406851 then
		self.vb.doomCount = self.vb.doomCount + 1
		specWarnDoomFlame:Show(self.vb.doomCount)
		specWarnDoomFlame:Play("helpsoak")
		timerDoomFlameCD:Start()
	elseif spellId == 406333 or spellId == 406145 then
		self.vb.blastCount = self.vb.blastCount + 1
		specWarnShadowlavaBlast:Show(self.vb.blastCount)
		specWarnShadowlavaBlast:Play("shockwave")
		timerShadowlavaBlastCD:Start()
	elseif spellId == 400777 then
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnChargedSmash:Show(self.vb.smashCount)
		specWarnChargedSmash:Play("watchstep")
		timerChargedSmashCD:Start()
	elseif spellId == 407547 then
		if self:AntiSpam(10, 1) then--In case the success/parent combo ID isn't detectable
			self.vb.tankCombo = self.vb.tankCombo + 1
			self.vb.comboCount = 0
			timerVolcanicComboCD:Start()
		end
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFlamingUpsurge:Show()
			specWarnFlamingUpsurge:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
				local _, _, _, _, _, expireTimeTarget = DBM:UnitDebuff("boss1target", spellId)
				if expireTimeTarget and expireTimeTarget-GetTime() >= 2 then
					specWarnFlamingUpsurgeTaunt:Show(UnitName("boss1target"))
					specWarnFlamingUpsurgeTaunt:Play("tauntboss")
				end
			end
		end
	elseif spellId == 407597 then
		if self:AntiSpam(10, 1) then--In case the success/parent combo ID isn't detectable
			self.vb.tankCombo = self.vb.tankCombo + 1
			self.vb.comboCount = 0
			timerVolcanicComboCD:Start()
		end
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnEarthenCrush:Show()
			specWarnEarthenCrush:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
				local _, _, _, _, _, expireTimeTarget = DBM:UnitDebuff("boss1target", spellId)
				if expireTimeTarget and expireTimeTarget-GetTime() >= 2 then
					specWarnEarthenCrushTaunt:Show(UnitName("boss1target"))
					specWarnEarthenCrushTaunt:Play("tauntboss")
				end
			end
		end
	elseif spellId == 406165 then
		specWarnUnyieldingRage:Show()
		specWarnUnyieldingRage:Play("carefly")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 405819 or spellId == 407642 then
		if args:IsPlayer() then
			specWarnSearingSlam:Show()
			specWarnSearingSlam:Play("targetyou")
			yellSearingSlam:Yell()
			yellSearingSlamFades:Countdown(spellId)
		else
			warnSearingSlam:Show(args.destName)
		end
		if self.Options.SetIconOnSearingSlam then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 407547 and not args:IsPlayer() then
		--Other tank got Flaming Upsurge, it was first part of combo, and you do NOT have Earthen Crush debuff, make you taunt next part of combo so one tank doesn't get both debuffs
		--This condition is mostly a "first combo" catch, where the SPELL_CAST_START checks would fail to assign the tanks automatically based on what they took in previous combo
		if not DBM:UnitDebuff("player", 407597) and self.vb.comboCount == 1 then
			specWarnFlamingUpsurgeTaunt:Show(args.destName)
			specWarnFlamingUpsurgeTaunt:Play("tauntboss")
		end
	elseif spellId == 407597 and not args:IsPlayer() then
		--Other tank got Earthen Crush, it was first part of combo, and you do NOT have Flaming Upsurge debuff, make you taunt next part of combo so one tank doesn't get both debuffs
		--This condition is mostly a "first combo" catch, where the SPELL_CAST_START checks would fail to assign the tanks automatically based on what they took in previous combo
		if not DBM:UnitDebuff("player", 407547) and self.vb.comboCount == 1 then
			specWarnEarthenCrushTaunt:Show(args.destName)
			specWarnEarthenCrushTaunt:Play("tauntboss")
		end
	elseif spellId == 401419 then
		warnSiphonEnergyApplied:Show(args.destName)
		--TODO, timer updates/resets for other timers?
		--timerAncientFuryCD:Stop()
	elseif spellId == 405091 then--Unyielding Rage (stack)
		timerUnyieldingRageCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 405819 or spellId == 407642 then
		if args:IsPlayer() then
			yellSearingSlamFades:Cancel()
		end
		if self.Options.SetIconOnSearingSlam then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 401419 then
		warnSiphonEnergyRemoved:Show(args.destName)
		timerUnyieldingRageCD:Stop()
		--TODO, timer updates/resets for other timers?
		--TODO, calculate (based on bosses new energy when conduit removed, how long til Ancient Fury is cast and start timer for it based on that energy
		--local bossPower = UnitPower("boss1")
		--bossPower = bossPower / 2.5--Update this once power gain rate known
		--local remaining = 40-bossPower
		--if remaining > 0 then
		--	local newTimer = 40-remaining
		--	timerAncientFuryCD:Update(newTimer, 40)
		--end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 403543 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) and not DBM:UnitDebuff("player", 405819, 407642) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 407641 and self:AntiSpam(10, 1) then--Volcanic Combo
		self.vb.tankCombo = self.vb.tankCombo + 1
		self.vb.comboCount = 0
		timerVolcanicComboCD:Start()
	end
end
