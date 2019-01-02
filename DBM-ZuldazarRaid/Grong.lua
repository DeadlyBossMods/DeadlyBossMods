local dungeonID, creatureID
local coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, tankComboId
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2340, 144638--Grong the Revenant
	coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, tankComboId = 286434, 282399, 282543, 282526, 282533, 286450
else--Horde
	dungeonID, creatureID = 2325, 147268--King Grong
	coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, tankComboId = 285659, 281936, 282179, 282247, 282243, 282082
end
local mod	= DBM:NewMod(dungeonID, "DBM-ZuldazarRaid", 1, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(creatureID)
mod:SetEncounterID(2263, 2284)--2263 Alliance, 2284 Horde
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282399 285994 282533 286435 282243 285660 281936",
	"SPELL_CAST_SUCCESS 282543 282526 286450 282179 282247 282082 289292 285875 282083",
	"SPELL_AURA_APPLIED 285671 285875 286434 285659",
	"SPELL_AURA_APPLIED_DOSE 285875 285671",
	"SPELL_AURA_REMOVED 286434 285659",
	"SPELL_ENERGIZE 282533 282243",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 282399 or ability.id = 281936 or ability.id = 285994 or ability.id = 286435 or ability.id = 285660) and type = "begincast"
 or (ability.id = 282543 or ability.id = 282179 or ability.id = 282526 or ability.id = 282247 or ability.id = 286450 or ability.id = 282082) and type = "cast"
 or (ability.id = 282533 or ability.id = 282243) and type = "begincast"
 --Tank Combo
(ability.id = 285875 or ability.id = 286450 or ability.id = 282082 or ability.id = 282083 or ability.id = 289292) and type = "cast" or ability.id = 285671 and type = "applydebuff"
--]]
--TODO, detect Voodoo Blast targets and add runout?
--TODO, add exploding soon and now warnings?
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnCrushed						= mod:NewStackAnnounce(285671, 3, nil, "Tank")
local warnRendingBite					= mod:NewStackAnnounce(285875, 2, nil, "Tank")
local warnCore							= mod:NewTargetNoFilterAnnounce(coreSpellId, 2)
--local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")

local specWarnEnergyAOE					= mod:NewSpecialWarningCount(energyAOESpellId, nil, nil, nil, 2, 2)
local specWarnSlam						= mod:NewSpecialWarningDodge(slamSpellId, nil, nil, nil, 2, 2)
--local specWarnFerociousRoar				= mod:NewSpecialWarningSpell(285994, nil, nil, nil, 2, 2)
local specWarnAdd						= mod:NewSpecialWarningSwitch(addSpawnId, "Dps", nil, nil, 1, 2)
local specWarnAddInterrupt				= mod:NewSpecialWarningInterruptCount(addCastId, "HasInterrupt", nil, nil, 1, 2)
local specWarnCrushedTaunt				= mod:NewSpecialWarningTaunt(285671, nil, nil, nil, 1, 2)--After any crush that isn't 3rd cast
local specWarnRendingBiteTaunt			= mod:NewSpecialWarningTaunt(285875, nil, nil, nil, 1, 2)--At 2 stacks, but only if it's first two casts of combo
local specWarnThrow						= mod:NewSpecialWarningTaunt(289292, nil, nil, nil, 1, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
--local yellDarkRevolationFades			= mod:NewIconFadesYell(273365)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerEnergyAOECD					= mod:NewCDCountTimer(100, energyAOESpellId, nil, nil, nil, 2)
local timerTankComboCD					= mod:NewCDTimer(30.3, tankComboId, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSlamCD						= mod:NewCDTimer(29.1, slamSpellId, nil, nil, nil, 3)
--local timerFerociousRoarCD				= mod:NewCDTimer(21.9, 285994, nil, nil, nil, 2)
local timerAddCD						= mod:NewCDTimer(120, addSpawnId, nil, nil, nil, 1)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(energyAOESpellId, true)
--mod:AddNamePlateOption("NPAuraOnPresence", 276093)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

--mod.vb.phase = 1
mod.vb.EnergyAOECount = 0
mod.vb.comboCount = 0
local coreTargets = {}
local castsPerGUID = {}

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--Core Stuff
		for i=1, #coreTargets do
			local name = coreTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local _, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 286434, 285659)
			if expireTime then
				local remaining = expireTime-GetTime()
				addLine(name, math.floor(remaining))
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.EnergyAOECount = 0
	self.vb.comboCount = 0
	table.wipe(coreTargets)
	table.wipe(castsPerGUID)
	timerSlamCD:Start(13.2-delay)
	timerAddCD:Start(16.8-delay)
	timerTankComboCD:Start(18-delay)
	--timerFerociousRoarCD:Start(27.7-delay)--VERIFY
	timerEnergyAOECD:Start(100-delay, 1)
--	if self.Options.NPAuraOnPresence then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnPresence then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282399 or spellId == 281936 then
		self.vb.EnergyAOECount = self.vb.EnergyAOECount + 1
		specWarnEnergyAOE:Show(self.vb.EnergyAOECount)
		specWarnEnergyAOE:Play("aesoon")
		timerEnergyAOECD:Stop()
		timerEnergyAOECD:Start(100, self.vb.EnergyAOECount+1)
	elseif spellId == 285994 then
		--specWarnFerociousRoar:Show()
		--specWarnFerociousRoar:Play("fearsoon")
		--timerFerociousRoarCD:Start()
	elseif spellId == 282533 or spellId == 282243 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnAddInterrupt:Show(args.sourceName, count)
			if count == 1 then
				specWarnAddInterrupt:Play("kick1r")
			elseif count == 2 then
				specWarnAddInterrupt:Play("kick2r")
			elseif count == 3 then
				specWarnAddInterrupt:Play("kick3r")
			elseif count == 4 then
				specWarnAddInterrupt:Play("kick4r")
			elseif count == 5 then
				specWarnAddInterrupt:Play("kick5r")
			else
				specWarnAddInterrupt:Play("kickcast")
			end
		end
	elseif spellId == 286435 or spellId == 285660 then
		--timerEnergyAOECD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282543 or spellId == 282179 then
		specWarnSlam:Show()
		specWarnSlam:Play("watchstep")
		timerSlamCD:Start()
	elseif spellId == 282526 or spellId == 282247 then--Death Spectre/Apetagonizer 3000 Bomb
		specWarnAdd:Show()
		specWarnAdd:Play("killmob")
		timerAddCD:Start()
	elseif spellId == 286450 or spellId == 282082 then--Necrotic Combo/Bestial Combo
		self.vb.comboCount = 0
		timerTankComboCD:Start()
	elseif spellId == 289292 then
		if not args:IsPlayer() then
			specWarnThrow:Show(args.destName)
			specWarnThrow:Play("tauntboss")
		end
	elseif spellId == 282083 then--Beastial Smash
		self.vb.comboCount = self.vb.comboCount + 1
	elseif spellId == 285875 then--Rending Bite
		self.vb.comboCount = self.vb.comboCount + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285671 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if not args:IsPlayer() then
				--always swap after a crush if combo is only at 1 or 2, because crush CAN be 3rd cast of a combo.
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and self.vb.comboCount < 3 then
					specWarnCrushedTaunt:Show(args.destName)
					specWarnCrushedTaunt:Play("tauntboss")
				else
					warnCrushed:Show(args.destName, amount)
				end
			else
				warnCrushed:Show(args.destName, amount)
			end
		end
	elseif spellId == 285875 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if not args:IsPlayer() then
				--Taunt at 2 stacks of rend, if combo count less than 3 (basically any combo starting with rend rend x) to make sure tank doesn't get a 3rd rend
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and amount >= 2 and self.vb.comboCount < 3 then--Can't taunt less you've dropped yours off, period.
					specWarnRendingBiteTaunt:Show(args.destName)
					specWarnRendingBiteTaunt:Play("tauntboss")
				else--only 1 stack, or no risk of it being a rend rend rend combo
					warnRendingBite:Show(args.destName, amount)
				end
			else
				warnCrushed:Show(args.destName, amount)
			end
		end
	elseif spellId == 286434 or spellId == 285659 then
		warnCore:Show(args.destName)
		if not tContains(coreTargets, args.destName) then
			table.insert(coreTargets, args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286434 or spellId == 285659 then
		tDeleteItem(coreTargets, args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if (spellId == 282533 or spellId == 282243) and destGUID == UnitGUID("boss1") then
		DBM:Debug("SPELL_ENERGIZE fired on Boss. Amount: "..amount)
		local elapsed, total = timerEnergyAOECD:GetTime(self.vb.EnergyAOECount+1)--Grab current timer
		local adjustAmount = self:IsHard() and 10 or self:IsNormal() and 5 or 3
		elapsed = elapsed + adjustAmount
		local remaining = total-elapsed
		--countdownRottingRegurg:Cancel()
		timerEnergyAOECD:Stop()--Trash old timer
		if remaining >= 3 then--It's worth showing updated timer
			timerEnergyAOECD:Update(elapsed, total, self.vb.EnergyAOECount+1)--Construct new timer with adjustment
			--countdownRottingRegurg:Start(remaining)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144998 or cid == 144876 then--Death Specter/Apetagonizer 3000
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--Backup add spawn triggers in case CLEU stuff gets purged
	if spellId == 286450 or spellId == 282082 then

	end
end
