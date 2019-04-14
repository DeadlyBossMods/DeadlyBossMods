local mod	= DBM:NewMod("SethralissTrash", "DBM-Party-BfA", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 265968 272657 264574 258908 272655 261635 273995 272700 268061",
	"SPELL_AURA_APPLIED 273563 272659 267027 272699 268013 268008",
	"SPELL_CAST_SUCCESS 268705",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, GTFO for Lightning in a Bottle?
--TODO, get right event for 265912 (Accumulate Charge. Can't find a START event)
local warnBladeFlurry				= mod:NewSpellAnnounce(258908, 3)
local warnPyrrhicBlast				= mod:NewCastAnnounce(273995, 4)

--local yellArrowBarrage			= mod:NewYell(200343)
local specWarnDustCloud				= mod:NewSpecialWarningMove(268705, "Tank", nil, nil, 1, 2)
local specWarnNoxiousBreath			= mod:NewSpecialWarningDodge(272657, "Tank", nil, nil, 1, 2)
local specWarnPowerShot				= mod:NewSpecialWarningDodge(264574, nil, nil, nil, 1, 2)
local specWarnScouringSand			= mod:NewSpecialWarningDodge(272655, nil, nil, nil, 2, 8)
local specWarnCallLightning			= mod:NewSpecialWarningDodge(272823, nil, nil, nil, 2, 2)
local specWarnHealingSurge			= mod:NewSpecialWarningInterrupt(265968, "HasInterrupt", nil, nil, 1, 2)
local specWarnStoneshieldPotion		= mod:NewSpecialWarningInterrupt(261635, "HasInterrupt", nil, nil, 1, 2)
local specWarnGreaterHealingPotion	= mod:NewSpecialWarningInterrupt(272700, "HasInterrupt", nil, nil, 1, 2)
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(268061, "HasInterrupt", nil, nil, 1, 2)
--local specWarnAccumulateCharge		= mod:NewSpecialWarningInterrupt(265912, "HasInterrupt", nil, nil, 1, 2)
local specWarnNeurotoxinDispel		= mod:NewSpecialWarningDispel(273563, "RemovePoison", nil, nil, 1, 2)
local specWarnCytotoxin				= mod:NewSpecialWarningDispel(267027, "RemovePoison", nil, nil, 1, 2)
local specWarnVenomousSpit			= mod:NewSpecialWarningDispel(272699, "RemovePoison", nil, nil, 1, 2)
local specWarnElectrifiedScales		= mod:NewSpecialWarningDispel(272659, "MagicDispeller", nil, nil, 1, 2)
local specWarnFlameShock			= mod:NewSpecialWarningDispel(268013, "Healer", nil, nil, 1, 2)
local specWarnSnakeCharm			= mod:NewSpecialWarningDispel(268008, "Healer", nil, nil, 1, 2)
local specWarnNeurotoxin			= mod:NewSpecialWarningYou(273563, nil, nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265968 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingSurge:Show(args.sourceName)
		specWarnHealingSurge:Play("kickcast")
	elseif spellId == 272657 and self:AntiSpam(2.5, 1) then
		specWarnNoxiousBreath:Show()
		specWarnNoxiousBreath:Play("shockwave")
	elseif spellId == 264574 and self:AntiSpam(2.5, 1) then
		specWarnPowerShot:Show()
		specWarnPowerShot:Play("shockwave")
	elseif spellId == 272655 and self:AntiSpam(2.5, 1) then
		specWarnScouringSand:Show()
		specWarnScouringSand:Play("behindmob")
	elseif spellId == 258908 and self:AntiSpam(3, 2) then
		warnBladeFlurry:Show()
	elseif spellId == 273995 and self:AntiSpam(3, 6) then
		warnPyrrhicBlast:Show()
	elseif spellId == 261635 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStoneshieldPotion:Show(args.sourceName)
		specWarnStoneshieldPotion:Play("kickcast")
	elseif spellId == 272700 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGreaterHealingPotion:Show(args.sourceName)
		specWarnGreaterHealingPotion:Play("kickcast")
	elseif spellId == 268061 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChainLightning:Show(args.sourceName)
		specWarnChainLightning:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 273563 and args:IsDestTypePlayer() then
		if self.Options.SpecWarn273563dispel and self:CheckDispelFilter() then
			specWarnNeurotoxinDispel:Show(args.destName)
			specWarnNeurotoxinDispel:Play("helpdispel")
		elseif args:IsPlayer() then
			specWarnNeurotoxin:Show()
			specWarnNeurotoxin:Play("stopmove")
		end
	elseif spellId == 272659 and not args:IsDestTypePlayer() and self:AntiSpam(3, 3) then
		specWarnElectrifiedScales:Show(args.destName)
		specWarnElectrifiedScales:Play("helpdispel")
	elseif spellId == 267027 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 4) then
		specWarnCytotoxin:Show(args.destName)
		specWarnCytotoxin:Play("helpdispel")
	elseif spellId == 272699 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 4) then
		specWarnVenomousSpit:Show(args.destName)
		specWarnVenomousSpit:Play("helpdispel")
	elseif spellId == 268013 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 8) then
		specWarnFlameShock:Show(args.destName)
		specWarnFlameShock:Play("helpdispel")
	elseif spellId == 268008 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 8) then
		specWarnSnakeCharm:Show(args.destName)
		specWarnSnakeCharm:Play("helpdispel")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268705 and self:AntiSpam(3, 5) then
		specWarnDustCloud:Show()
		specWarnDustCloud:Play("moveboss")
	end
end

--Events not in combat log
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 272823 then
		--local guid = UnitGUID(uId)
		--if self:IsValidWarning(guid, uId) then
			self:SendSync("CallLightning")
		--end
	end
end

function mod:OnSync(msg)
	if msg == "CallLightning" and self:AntiSpam(4, 7) then
		specWarnCallLightning:Show()
		specWarnCallLightning:Play("watchstep")
	end
end
