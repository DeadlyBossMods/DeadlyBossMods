local mod	= DBM:NewMod(2525, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201320)
mod:SetEncounterID(2680)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20230317000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 405316 405821 406851 406333 406145 400777 407547 407597 406165 410070",
--	"SPELL_CAST_SUCCESS 407641",
	"SPELL_AURA_APPLIED 405819 407547 407597 401419 405091 407642 405827",
	"SPELL_AURA_APPLIED_DOSE 405091 405827",
	"SPELL_AURA_REMOVED 405819 401419 407642 405827",
	"SPELL_AURA_REMOVED_DOSE 405827",
	"SPELL_PERIODIC_DAMAGE 403543",
	"SPELL_PERIODIC_MISSED 403543",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 405316 or ability.id = 405821 or ability.id = 406851 or ability.id = 406333 or ability.id = 406145 or ability.id = 400777 or ability.id = 407547 or ability.id = 407597 or ability.id = 406165) and type = "begincast"
 or ability.id = 401419 and (type = "applybuff" or type = "removebuff")
--]]
--TODO, https://www.wowhead.com/ptr/spell=407706/molten-wrath seems passive, but still maybe have a 15 second timer with right script
local warnSearingSlam								= mod:NewTargetNoFilterAnnounce(405821, 4)
local warnSiphonEnergyApplied						= mod:NewTargetNoFilterAnnounce(401419, 2)
local warnSiphonEnergyRemoved						= mod:NewFadesAnnounce(401419, 2)
local warnUnyieldingRage							= mod:NewCountAnnounce(405091, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(405091))

local specWarnAncientFury							= mod:NewSpecialWarningCount(405316, nil, nil, nil, 2, 2)
local specWarnSearingSlam							= mod:NewSpecialWarningYou(405821, nil, nil, nil, 2, 2)
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
local specWarnUnleashedShadowflame					= mod:NewSpecialWarningCount(410070, nil, nil, nil, 2, 2, 4)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(403543, nil, nil, nil, 1, 8)

local timerAncientFuryCD							= mod:NewCDTimer(29.9, 405316, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSearingSlamCD							= mod:NewCDCountTimer(40, 405821, nil, nil, nil, 3)
local timerDoomFlameCD								= mod:NewCDCountTimer(28.9, 406851, nil, nil, nil, 5)
local timerShadowlavaBlastCD						= mod:NewCDCountTimer(28.9, 406333, nil, nil, nil, 3)
local timerChargedSmashCD							= mod:NewCDCountTimer(40, 400777, nil, nil, nil, 3)
local timerVolcanicComboCD							= mod:NewCDCountTimer(40, 407641, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerUnleashedShadowflameCD					= mod:NewAITimer(40, 410070, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(405827)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnSearingSlam", 405821, false, 0, {1})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("TankSwapBehavior", {"DoubleSoak", "MinMaxSoak", "OnlyIfDanger"}, "DoubleSoak", "misc")
--mod:GroupSpells(390715, 396094)

mod.vb.slamCount = 0
mod.vb.doomCount = 0
mod.vb.blastCount = 0
mod.vb.smashCount = 0
mod.vb.tankCombo = 0--Cast
mod.vb.comboCount = 0--Combos within cast
mod.vb.shadowflameCount = 0
local overchargedStacks = {}
--local allTimers = {--Will only be used if not same on all difficulties, then it'll be cleaner than tons if conditionals
--	--Searing Slam
--	[405821] = {4.1, 40.0, 31.0},
--	--Charged Smash
--	[400777] = {15.1, 40.0},
--	--Volcanic Combo
--	[407641] = {24.1, 41.1}
--}

function mod:OnCombatStart(delay)
	table.wipe(overchargedStacks)
	self.vb.slamCount = 0
	self.vb.doomCount = 0
	self.vb.blastCount = 0
	self.vb.smashCount = 0
	self.vb.tankCombo = 0
	self.vb.comboCount = 0
	self.vb.shadowflameCount = 0
	timerSearingSlamCD:Start(4.1-delay, 1)
	timerChargedSmashCD:Start(15.1-delay, 1)
	timerVolcanicComboCD:Start(24.1-delay, 1)
	timerDoomFlameCD:Start(35.2-delay, 1)
	timerShadowlavaBlastCD:Start(81.6-delay, 1)
	timerAncientFuryCD:Start(100-delay)
	if self:IsMythic() then
		timerUnleashedShadowflameCD:Start(1-delay)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(405827))
			DBM.InfoFrame:Show(5, "table", overchargedStacks, 1)
		end
	end
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 405316 then
		specWarnAncientFury:Show()
		specWarnAncientFury:Play("aesoon")
	elseif spellId == 405821 then
		self.vb.slamCount = self.vb.slamCount + 1
		local timer = self.vb.slamCount == 1 and 40 or self.vb.slamCount == 2 and 31
		if timer then
			timerSearingSlamCD:Start(nil, self.vb.slamCount+1)
		end
	elseif spellId == 406851 then
		self.vb.doomCount = self.vb.doomCount + 1
		specWarnDoomFlame:Show(self.vb.doomCount)
		specWarnDoomFlame:Play("helpsoak")
	elseif spellId == 406333 or spellId == 406145 then
		self.vb.blastCount = self.vb.blastCount + 1
		specWarnShadowlavaBlast:Show(self.vb.blastCount)
		specWarnShadowlavaBlast:Play("shockwave")
	elseif spellId == 400777 then
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnChargedSmash:Show(self.vb.smashCount)
		specWarnChargedSmash:Play("watchstep")
		if self.vb.smashCount == 1 then
			timerChargedSmashCD:Start(nil, self.vb.smashCount+1)
		end
	elseif spellId == 407547 then
		if self:AntiSpam(10, 1) then--In case the success/parent combo ID isn't detectable
			self.vb.tankCombo = self.vb.tankCombo + 1
			self.vb.comboCount = 0
			if self.vb.tankCombo == 1 then
				timerVolcanicComboCD:Start(nil, self.vb.tankCombo+1)
			end
		end
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFlamingUpsurge:Show()
			specWarnFlamingUpsurge:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			--This doesn't check TankSwapBehavior dropdown because this always validates that the player about to get hit by this, shouldn't be hit by it
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
			if self.vb.tankCombo == 1 then
				timerVolcanicComboCD:Start(nil, self.vb.tankCombo+1)
			end
		end
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnEarthenCrush:Show()
			specWarnEarthenCrush:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			--This doesn't check TankSwapBehavior dropdown because this always validates that the player about to get hit by this, shouldn't be hit by it
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
	elseif spellId == 410070 then
		self.vb.shadowflameCount = self.vb.shadowflameCount + 1
		specWarnUnleashedShadowflame:Show(self.vb.shadowflameCount)
		specWarnUnleashedShadowflame:Play("specialsoon")--Better voice?
		timerUnleashedShadowflameCD:Start()
	end
end

--[[
--Exists but fires too slow. it's in CLEU after first combo already started
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 407641 then
		self.vb.tankCombo = self.vb.tankCombo + 1
		self.vb.comboCount = 0
		timerVolcanicComboCD:Start()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 405819 or spellId == 407642 then--405819 confirmed on heroic, 407642 for lfr/normal maybe?
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
	elseif (spellId == 407597 or spellId == 407547) and not args:IsPlayer() then
		local alertTaunt
		if self.Options.TankSwapBehavior == "OnlyIfDanger" then
			--This means there are 0 preemtive taunts at all and you only taunt when a combo hit starts and it's not safe for the current target to take
			--This uses minimum amount of taunts but poses greater risk of messup since it's reactiev only and not proactive
			return
		elseif self.Options.TankSwapBehavior == "DoubleSoak" and self.vb.comboCount == 2 then
			--This basically means the only strategy here is each tank just eats both hits and calls it a day
			--Then next tank takes the next combo.
			alertTaunt = true
		elseif self.Options.TankSwapBehavior == "MinMaxSoak" and self.vb.comboCount == 1 then
			--Min Max soaking to spread combo across both tanks to mitigate having one tank eat all the damage
			--Other tank got first part of combo, and you do NOT have debuff for next part of combo, make you taunt next part of combo so one tank doesn't get both debuffs
			--This condition is mostly a "first combo" catch, where the SPELL_CAST_START checks would fail to assign the tanks automatically based on what they took in previous combo
			local checkedSpellId
			if spellId == 407597 then
				checkedSpellId = 407547
			else
				checkedSpellId = 407597
			end
			if not DBM:UnitDebuff("player", checkedSpellId) then
				alertTaunt = true
			end
		end
		if alertTaunt then
			specWarnFlamingUpsurgeTaunt:Show(args.destName)
			specWarnFlamingUpsurgeTaunt:Play("tauntboss")
		end
	elseif spellId == 401419 then
		warnSiphonEnergyApplied:Show(args.destName)
		timerSearingSlamCD:Stop()
		timerChargedSmashCD:Stop()
		timerVolcanicComboCD:Stop()
		timerDoomFlameCD:Stop()
		timerShadowlavaBlastCD:Stop()
		timerAncientFuryCD:Stop()
		timerUnleashedShadowflameCD:Stop()
	elseif spellId == 405091 then--Unyielding Rage (stack)
		local amount = args.amount or 1
		if amount == 1 or amount == 4 or amount >= 7 then
			warnUnyieldingRage:Show(amount)
		end
	elseif spellId == 405827 then
		local amount = args.amount or 1
		overchargedStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(overchargedStacks)
		end
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
	elseif spellId == 405827 then
		overchargedStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(overchargedStacks)
		end
	elseif spellId == 401419 then
		warnSiphonEnergyRemoved:Show(args.destName)
		self.vb.slamCount = 0
		self.vb.doomCount = 0
		self.vb.blastCount = 0
		self.vb.smashCount = 0
		self.vb.tankCombo = 0
		self.vb.comboCount = 0
		self.vb.shadowflameCount = 0
		timerSearingSlamCD:Start(6.1, 1)
		timerChargedSmashCD:Start(17.1, 1)
		timerVolcanicComboCD:Start(26.1, 1)
		timerDoomFlameCD:Start(37.1, 1)
		timerShadowlavaBlastCD:Start(83.6, 1)
		timerAncientFuryCD:Start(102)
		if self:IsMythic() then
			timerUnleashedShadowflameCD:Start(2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 405827 then
		overchargedStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(overchargedStacks)
		end
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
