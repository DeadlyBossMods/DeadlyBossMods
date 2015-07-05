local mod	= DBM:NewMod(893, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(74366, 74475)--74366 Forgemaster Gog'duh, 74475 Magmolatus
mod:SetEncounterID(1655)
mod:SetMainBossID(74475)
mod:SetZone()

mod:SetBossHealthInfo(74366)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 149997 149975 150032",
	"SPELL_CAST_START 149941 150038 150023",
	"SPELL_PERIODIC_DAMAGE 150011",
	"SPELL_ABSORBED 150011",
	"UNIT_DIED"
)

-------------------------------------------
local warnFirestorm				= mod:NewSpellAnnounce(149997, 3)
local warnDancingFlames			= mod:NewTargetAnnounce(149975, 3, nil, "Healer")
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnWitheringFlames		= mod:NewTargetAnnounce(150032, 3, nil, "Healer")

local specWarnMagmaBarrage		= mod:NewSpecialWarningMove(150011)
local specWarnRoughSmash		= mod:NewSpecialWarningDodge(149941, "Melee")
local specWarnRuination			= mod:NewSpecialWarningSwitch("ej8622", "-Healer")
local specWarnCalamity			= mod:NewSpecialWarningSwitch("ej8626", "-Healer")
local specWarnFirestorm			= mod:NewSpecialWarningInterrupt(149997, "-Healer")
local specWarnDancingFlames		= mod:NewSpecialWarningDispel(149975, "Healer")
local specWarnMagmolatus		= mod:NewSpecialWarningSwitch("ej8621", "Tank")--Dps can turn this on too I suppose but 5 seconds after boss spawns they are switching to add anyways, so this is mainly for tank to pick it up
local specWarnSlagSmash			= mod:NewSpecialWarningDodge(150023, "Melee")
local specWarnMoltenImpact		= mod:NewSpecialWarningSpell(150038, nil, nil, nil, 2)
local specWarnWitheringFlames	= mod:NewSpecialWarningDispel(150032, "Healer")

local timerMoltenImpactCD		= mod:NewNextTimer(21.5, 150038, nil, nil, nil, 1)

local voiceRuination			= mod:NewVoice("ej8622", "-Healer")
local voiceCalamity				= mod:NewVoice("ej8626", "-Healer")
local voicePhaseChange			= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceFirestorm			= mod:NewVoice(149997, "-Healer")
local voiceDancingFlames		= mod:NewVoice(149975, "Healer")
local voiceWitheringFlames		= mod:NewVoice(150032, "Healer")
local voiceSlagSmash			= mod:NewVoice(150023, "Melee")

local activeAddGUIDS = {}

function mod:OnCombatStart(delay)
	table.wipe(activeAddGUIDS)
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
	)
end

function mod:OnCombatEnd()
	table.wipe(activeAddGUIDS)
	self:UnregisterShortTermEvents()
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		local cid = self:GetCIDFromGUID(unitGUID)
		if UnitExists(unitID) and not activeAddGUIDS[unitGUID] then
			activeAddGUIDS[unitGUID] = true
			--Ruination#Creature:0:3314:1175:11531:74570
			if cid == 74570 then--Ruination
				specWarnRuination:Show()
				voiceRuination:Play("mobsoon")
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(74570)
				end
			elseif cid == 74571 then--Calamity
				specWarnCalamity:Show()
				voiceCalamity:Play("mobsoon")
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(74571)
				end
			elseif cid == 74475 then--Magmolatus
				warnPhase2:Show()
				voicePhaseChange:Play("ptwo")
				specWarnMagmolatus:Show()
				timerMoltenImpactCD:Start(5)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(74475)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 149997 then
		warnFirestorm:Show()
		specWarnFirestorm:Show(args.sourceName)
		if self:IsTank() then
			voiceFirestorm:Play("kickcast")
		else
			voiceFirestorm:Play("helpkick")
		end
	elseif spellId == 149975 then
		warnDancingFlames:CombinedShow(0.3, args.destName)--heroic is 2 targets so combined.
		if self:CheckDispelFilter() then--only show once. (prevent loud sound)
			specWarnDancingFlames:CombinedShow(0.3, args.destName)
			if self:AntiSpam(2, 2) then
				voiceDancingFlames:Play("dispelnow")
			end
		end
	elseif spellId == 150032 and self:CheckDispelFilter() then
		warnWitheringFlames:Show(args.destName)
		specWarnWitheringFlames:Show(args.destName)
		voiceWitheringFlames:Play("dispelnow")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 149941 then
		specWarnRoughSmash:Show()
	elseif spellId == 150038 then
		specWarnMoltenImpact:Show()
		timerMoltenImpactCD:Start()
	elseif spellId == 150023 then
		specWarnSlagSmash:Show()
		voiceSlagSmash:Play("runaway")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 15011 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then--need to check spell ids again
		specWarnMagmaBarrage:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	if not DBM.BossHealth:IsShown() then return end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 74366 then
		DBM.BossHealth:RemoveBoss(74366)
	elseif cid == 74570 then
		DBM.BossHealth:RemoveBoss(74570)
	elseif cid == 74571 then
		DBM.BossHealth:RemoveBoss(74571)
	end
end
