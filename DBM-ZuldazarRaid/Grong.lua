local dungeonID, creatureID
local coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, addProjectileId, tankComboId
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2340, 144638--Grong the Revenant
	coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, addProjectileId, tankComboId = 286434, 282399, 282543, 282526, 282533, 282467, 286450
else--Horde
	dungeonID, creatureID = 2325, 144637--King Grong
	coreSpellId, energyAOESpellId, slamSpellId, addSpawnId, addCastId, addProjectileId, tankComboId = 285659, 281936, 282179, 282247, 282243, 282190, 282082
end
local mod	= DBM:NewMod(dungeonID, "DBM-ZuldazarRaid", 1, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(creatureID)
mod:SetEncounterID(2263, 2284)--2263 Alliance, 2284 Horde
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(18176)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282399 285994 282533 286435 282243 285660 281936 290574",
	"SPELL_CAST_SUCCESS 282543 282526 286450 282179 282247 282082 289292 285875 282083 289307",
	"SPELL_AURA_APPLIED 285671 285875 286434 285659",
	"SPELL_AURA_APPLIED_DOSE 285875 285671",
	"SPELL_AURA_REMOVED 286434 285659",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 282399 or ability.id = 281936 or ability.id = 285994 or ability.id = 286435 or ability.id = 285660 or ability.id = 290574) and type = "begincast"
 or (ability.id = 282543 or ability.id = 282179 or ability.id = 282526 or ability.id = 282247 or ability.id = 286450 or ability.id = 282082) and type = "cast"
 or (ability.id = 282533 or ability.id = 282243) and type = "begincast"
 or (ability.id = 286434 or ability.id = 285659) and type = "applydebuff"
 --Tank Combo Only
(ability.id = 285875 or ability.id = 286450 or ability.id = 282082 or ability.id = 282083 or ability.id = 289292) and type = "cast" or ability.id = 285671 and type = "applydebuff"
--]]
--TODO, detect Voodoo Blast targets and add runout?
--TODO, add exploding soon and now warnings?
local warnCrushed						= mod:NewStackAnnounce(285671, 3, nil, "Tank")
local warnRendingBite					= mod:NewStackAnnounce(285875, 2, nil, "Tank")
local warnCore							= mod:NewTargetNoFilterAnnounce(coreSpellId, 2)
local warnThrowTarget					= mod:NewTargetNoFilterAnnounce(289307, 2)
local warnAddProjectile					= mod:NewSpellAnnounce(addProjectileId, 2)

local specWarnEnergyAOE					= mod:NewSpecialWarningCount(energyAOESpellId, nil, nil, nil, 2, 2)
local specWarnSlam						= mod:NewSpecialWarningDodge(slamSpellId, nil, nil, nil, 2, 2)
local specWarnFerociousRoar				= mod:NewSpecialWarningSpell(285994, nil, nil, nil, 2, 2)
local specWarnAdd						= mod:NewSpecialWarningSwitch(addSpawnId, "Dps", nil, nil, 1, 2)
local specWarnAddInterrupt				= mod:NewSpecialWarningInterruptCount(addCastId, "HasInterrupt", nil, nil, 1, 2)
local specWarnCrushedTaunt				= mod:NewSpecialWarningTaunt(285671, nil, nil, nil, 1, 2)--After any crush that isn't 3rd cast
local specWarnRendingBiteTaunt			= mod:NewSpecialWarningTaunt(285875, nil, nil, nil, 1, 2)--At 2 stacks, but only if it's first two casts of combo
local specWarnThrow						= mod:NewSpecialWarningTaunt(289292, nil, nil, nil, 1, 2)
local specWarnThrowTarget				= mod:NewSpecialWarningMoveAway(289307, nil, nil, nil, 3, 2)
local yellThrowTarget					= mod:NewYell(289307)
local yellThrowTargetFades				= mod:NewShortFadesYell(289307)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
mod:AddTimerLine(DBM_BOSS)
--local timerEnergyAOECD				= mod:NewCDCountTimer(100, energyAOESpellId, nil, nil, nil, 2)
local timerTankComboCD					= mod:NewCDTimer(30.3, tankComboId, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerSlamCD						= mod:NewCDTimer(27, slamSpellId, nil, nil, nil, 3)
local timerFerociousRoarCD				= mod:NewCDTimer(36.5, 285994, nil, nil, nil, 2, nil, nil, nil, 3, 3)
mod:AddTimerLine(DBM_ADDS)
local timerAddCD						= mod:NewCDTimer(120, addSpawnId, nil, nil, nil, 1, nil, nil, nil, 1, 5)
local timerAddAttackCD					= mod:NewCDTimer(23.8, addProjectileId, nil, nil, nil, 3)--12-32

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 285994)
mod:AddInfoFrameOption(energyAOESpellId, true)

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
	timerSlamCD:Start(15-delay)
	timerAddCD:Start(16.5-delay)
	timerTankComboCD:Start(22-delay)
	if self:IsHard() then
		timerAddAttackCD:Start(10.6-delay)
		timerFerociousRoarCD:Start(35.5-delay)--First one can be between 35.5-39
	end
--	timerEnergyAOECD:Start(100-delay, 1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8, nil, nil, 1, true)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
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
	if spellId == 282399 or spellId == 281936 then
		self.vb.EnergyAOECount = self.vb.EnergyAOECount + 1
		specWarnEnergyAOE:Show(self.vb.EnergyAOECount)
		specWarnEnergyAOE:Play("aesoon")
		--timerEnergyAOECD:Stop()
		--timerEnergyAOECD:Start(100, self.vb.EnergyAOECount+1)
	elseif spellId == 285994 or spellId == 290574 then
		specWarnFerociousRoar:Show()
		specWarnFerociousRoar:Play("fearsoon")
		timerFerociousRoarCD:Start()
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
		if self:IsMythic() then
			timerAddCD:Start(120)--2 every 2 minutes
		else
			timerAddCD:Start(60)--1 every 1 minute
		end
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
	elseif spellId == 289307 then
		if args:IsPlayer() then
			specWarnThrowTarget:Show()
			specWarnThrowTarget:Play("runout")
			yellThrowTarget:Yell()
			yellThrowTargetFades:Countdown(spellId, 3)
		else
			warnThrowTarget:Show(args.destName)
		end
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
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and amount >= 2 then--Can't taunt less you've dropped yours off, period.
					specWarnRendingBiteTaunt:Show(args.destName)
					specWarnRendingBiteTaunt:Play("tauntboss")
				else--only 1 stack, or no risk of it being a rend rend rend combo
					warnRendingBite:Show(args.destName, amount)
				end
			else
				warnRendingBite:Show(args.destName, amount)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144998 or cid == 149617 or cid == 144876 or cid == 149611 then--Death Specter/Apetagonizer 3000
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 282467 or spellId == 282190 then
		warnAddProjectile:Show()
		timerAddAttackCD:Start()
	end
end
