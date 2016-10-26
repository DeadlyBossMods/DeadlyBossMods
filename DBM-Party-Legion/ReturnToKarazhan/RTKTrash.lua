local mod	= DBM:NewMod("RTKTrash", "DBM-Party-Legion", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 228255 228239 227917 227925 228625 228606 229714 227966",
	"SPELL_AURA_APPLIED 228331 229706 229716",
	"SPELL_AURA_REMOVED 229489"
--	"SPELL_DAMAGE 204762",
--	"SPELL_MISSED 204762",
--	"UNIT_DIED"
--	"CHAT_MSG_MONSTER_YELL"
)

local warnVolatileCharge			= mod:NewSpellAnnounce(227925, 2)

local specWarnSoulLeech				= mod:NewSpecialWarningInterrupt(228255, "HasInterrupt", nil, nil, 1, 2)
local specWarnTerrifyingWail		= mod:NewSpecialWarningInterrupt(228239, "HasInterrupt", nil, nil, 1, 2)
local specWarnPoetrySlam			= mod:NewSpecialWarningInterrupt(227917, "HasInterrupt", nil, nil, 1, 2)
local specWarnBansheeWail			= mod:NewSpecialWarningInterrupt(228625, "HasInterrupt", nil, nil, 1, 2)
local specWarnHealingTouch			= mod:NewSpecialWarningInterrupt(228606, "HasInterrupt", nil, nil, 1, 2)
local specWarnConsumeMagic			= mod:NewSpecialWarningInterrupt(229714, "HasInterrupt", nil, nil, 1, 2)
local specWarnFinalCurtain			= mod:NewSpecialWarningDodge(227925, "Melee", nil, nil, 1, 2)
local specWarnVolatileCharge		= mod:NewSpecialWarningMoveAway(227925, nil, nil, nil, 1, 2)
local yellVolatileCharge			= mod:NewYell(227925)
local specWarnLeechLife				= mod:NewSpecialWarningDispel(228606, "Healer", nil, nil, 1, 2)
local specWarnCurseofDoom			= mod:NewSpecialWarningDispel(229716, "Healer", nil, nil, 1, 2)
local specWarnRoyalty				= mod:NewSpecialWarningSwitch(229489, nil, nil, nil, 1, 2)
local specWarnFlashlight			= mod:NewSpecialWarningSpell(227966, nil, nil, nil, 1, 2)

local voiceSoulLeech				= mod:NewVoice(228255, "HasInterrupt")--kickcast
local voiceTerrifyingWail			= mod:NewVoice(228239, "HasInterrupt")--kickcast
local voicePoetrySlam				= mod:NewVoice(227917, "HasInterrupt")--kickcast
local voiceBansheeWail				= mod:NewVoice(228625, "HasInterrupt")--kickcast
local voiceHealingTouch				= mod:NewVoice(228606, "HasInterrupt")--kickcast
local voiceConsumeMagic				= mod:NewVoice(229714, "HasInterrupt")--kickcast
local voiceFinalCurtain				= mod:NewVoice(227925, "Melee")--runout
local voiceLeechLife				= mod:NewVoice(228606, "Healer")--dispelnow
local voiceCurseofDoom				= mod:NewVoice(229716, "Healer")--dispelnow
local voiceFlashLight				= mod:NewVoice(227966)--turnaway

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 228255 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSoulLeech:Show(args.sourceName)
		voiceSoulLeech:Play("kickcast")
	elseif spellId == 228239 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnTerrifyingWail:Show(args.sourceName)
		voiceTerrifyingWail:Play("kickcast")
	elseif spellId == 227917 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnPoetrySlam:Show(args.sourceName)
		voicePoetrySlam:Play("kickcast")
	elseif spellId == 228625 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBansheeWail:Show(args.sourceName)
		voiceBansheeWail:Play("kickcast")
	elseif spellId == 228606 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnHealingTouch:Show(args.sourceName)
		voiceHealingTouch:Play("kickcast")
	elseif spellId == 229714 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnConsumeMagic:Show(args.destName)
		voiceConsumeMagic:Play("kickcast")
	elseif spellId == 227925 and self:AntiSpam(3, 1) then
		specWarnFinalCurtain:Show()
		voiceFinalCurtain:Play("runout")
	elseif spellId == 227966 and self:AntiSpam(3, 2) then
		specWarnFlashlight:Show()
		voiceFlashLight:Play("turnaway")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 228331 then
		warnVolatileCharge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVolatileCharge:Show()
			yellVolatileCharge:Yell()
		end
	elseif spellId == 229706 then
		specWarnLeechLife:Show(args.destName)
		voiceLeechLife:Play("dispelnow")
	elseif spellId == 229716 then
		specWarnCurseofDoom:Show(args.destName)
		voiceCurseofDoom:Play("dispelnow")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 229489 then
		specWarnRoyalty:Show(args.destName)
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if not self.Options.Enabled then return end
	if spellId == 204762 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnFelEnergy:Show()
		voiceFelEnergy:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = mod:GetCIDFromGUID(args.destGUID)
	if cid == 102246 then

	end
end

--]]
