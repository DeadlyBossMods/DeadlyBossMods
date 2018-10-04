local mod	= DBM:NewMod(2340, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(144638)
mod:SetEncounterID(2263)--Grongs are separate mods because they have too many diff names and IDs plus have unique encounter IDs
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282399 285994 282533 286435",
	"SPELL_CAST_SUCCESS 282543",
	"SPELL_AURA_APPLIED 285671 285875 286434",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 286434",
	"SPELL_ENERGIZE 282533",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify tank swaps, for most part, asuming it's Ursoc 2.0, but it may be more of a zekvoz and one tank gets both attacks. Until verified, disabled taunt warnings to avoid misleading
--TODO, detect Voodoo Blast targets and add runout?
--TODO, death empowerment timers and count if it's not a frequent/spammed cast
--TODO, add exploding soon and now warnings?
--TODO, finish timer updates code for when boss gains SPELL_ENERGIZE
--TODO, same as above, but with Core. Update energy/timers
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnCrushed						= mod:NewYouAnnounce(285671, 3)
local warnRendingBite					= mod:NewYouAnnounce(285875, 3)
local warnDeathEmpowerment				= mod:NewCastAnnounce(282533, 3)
local warnShadowCore					= mod:NewTargetNoFilterAnnounce(286434, 2)
--local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")

local specWarnDeathKnell				= mod:NewSpecialWarningCount(282399, nil, nil, nil, 2, 2)
local specWarnDeathlySlam				= mod:NewSpecialWarningRun(282543, nil, nil, nil, 4, 2)
local specWarnFerociousRoar				= mod:NewSpecialWarningSpell(285994, nil, nil, nil, 2, 2)
--local specWarnCrushedTaunt				= mod:NewSpecialWarningTaunt(285671, nil, nil, nil, 1, 2)
--local specWarnRendingBiteTaunt			= mod:NewSpecialWarningTaunt(285875, nil, nil, nil, 1, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
--local yellDarkRevolationFades			= mod:NewIconFadesYell(273365)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerDeathKnellCD					= mod:NewAITimer(55, 282399, nil, nil, nil, 2)
local timerNecroticComboCD				= mod:NewAITimer(14.1, 286450, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDeathlySlamCD				= mod:NewAITimer(55, 282543, nil, nil, nil, 2)
local timerFerociousRoarCD				= mod:NewAITimer(55, 285994, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(282399, true)
--mod:AddNamePlateOption("NPAuraOnPresence", 276093)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

--mod.vb.phase = 1
mod.vb.deathKnellCount = 0
local coreTargets = {}

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
			local _, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 286434)
			if expireTime then
				local remaining = expireTime-GetTime()
				addLine(name, math.floor(remaining))
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.deathKnellCount = 0
	table.wipe(coreTargets)
	timerDeathKnellCD:Start(1-delay)
	timerNecroticComboCD:Start(1-delay)
	timerDeathlySlamCD:Start(1-delay)
	timerFerociousRoarCD:Start(1-delay)
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
	if spellId == 273316 then
		self.vb.deathKnellCount = self.vb.deathKnellCount + 1
		specWarnDeathKnell:Show(self.vb.deathKnellCount)
		specWarnDeathKnell:Play("aesoon")
		timerDeathKnellCD:Start()
	elseif spellId == 285994 then
		specWarnFerociousRoar:Show()
		specWarnFerociousRoar:Play("fearsoon")
		timerFerociousRoarCD:Start()
	elseif spellId == 282533 then
		warnDeathEmpowerment:Show()
	elseif spellId == 286435 then
		timerDeathKnellCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282543 then
		specWarnDeathlySlam:Show()
		specWarnDeathlySlam:Play("justrun")
		timerDeathlySlamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285671 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				warnCrushed:Show()
			else
				--if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					--specWarnCrushedTaunt:Show(args.destName)
					--specWarnCrushedTaunt:Play("tauntboss")
				--else
					--warnRupturingBlood:Show(args.destName, amount)
				--end
			end
		end
	elseif spellId == 285875 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				warnRendingBite:Show()
			else
				--if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					--specWarnRendingBiteTaunt:Show(args.destName)
					--specWarnRendingBiteTaunt:Play("tauntboss")
				--else
					--warnRupturingBlood:Show(args.destName, amount)
				--end
			end
		end
	elseif spellId == 286434 then
		warnShadowCore:Show(args.destName)
		if not tContains(coreTargets, args.destName) then
			table.insert(coreTargets, args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286434 then
		tDeleteItem(coreTargets, args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if spellId == 282533 and destGUID == UnitGUID("boss1") then
		--TODO, even more complex marked for death checks here to factor that into energy updating.
		DBM:Debug("SPELL_ENERGIZE fired on Boss. Amount: "..amount)
		--[[local bossPower = UnitPower("boss1")
		bossPower = bossPower / 4--4 energy per second, smash every 25 seconds there abouts.
		local remaining = 25-bossPower
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(remaining)
		timerShatteringSmashCD:Stop()--Prevent timer debug when updating timer
		timerShatteringSmashCD:Start(remaining, self.vb.smashCount+1)--]]
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144998 then--Death Specter

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 286450 then--Necrotic Combo
		timerNecroticComboCD:Start()
	end
end
