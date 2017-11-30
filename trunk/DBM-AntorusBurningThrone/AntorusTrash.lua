local mod	= DBM:NewMod("AntorusTrash", "DBM-AntorusBurningThrone")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 246209 245807",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 252760 253600 254122",
--	"SPELL_AURA_APPLIED_DOSE"
	"SPELL_AURA_REMOVED 252760 254122"
)

--TODO, these
				--"Annihilation-252740-npc:127230 = pull:9.5", -- [1]
				--"Decimation-252793-npc:127231 = pull:10.9, 0.0", -- [2]
local warnDemolish						= mod:NewTargetAnnounce(252760, 4)
local warnCloudofConfuse					= mod:NewTargetAnnounce(254122, 4)
local warnSoulburn						= mod:NewTargetAnnounce(253600, 3)

local specWarnDemolish					= mod:NewSpecialWarningYou(252760, nil, nil, nil, 1, 2)
local yellDemolish						= mod:NewYell(252760)
local yellDemolishFades					= mod:NewShortFadesYell(252760)
local specWarnCloudofConfuse			= mod:NewSpecialWarningYou(254122, nil, nil, nil, 1, 2)
local yellCloudofConfuse				= mod:NewYell(254122)
local yellCloudofConfuseFades			= mod:NewShortFadesYell(254122)
local specWarnSoulburn					= mod:NewSpecialWarningMoveAway(253600, nil, nil, nil, 1, 2)
local yellSoulburn						= mod:NewYell(253600)
local specWarnPunishingFlame			= mod:NewSpecialWarningRun(246209, "Melee", nil, nil, 4, 2)
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(245807, nil, nil, nil, 2, 2)
--local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)

local voiceDemolish						= mod:NewVoice(252760)--gathershare/targetyou
local voiceCloudofConfuse				= mod:NewVoice(254122)--runout
local voiceSoulburn						= mod:NewVoice(253600)--runout
local voicePunishingFlame				= mod:NewVoice(246209, "Melee")--justrun
local voiceAnnihilation					= mod:NewVoice(245807)--helpsoak
--local voiceShadowBoltVolley			= mod:NewVoice(243171, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 246209 then
		specWarnPunishingFlame:Show()
		voicePunishingFlame:Play("justrun")
	elseif spellId == 245807 and self:AntiSpam(5, 1) then
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
	--elseif spellId == 246209 and self:CheckInterruptFilter(args.sourceGUID) then
		--specWarnShadowBoltVolley:Show(args.sourceName)
		--voiceShadowBoltVolley:Play("kickcast")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 then
		warnDemolish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDemolish:Show()
			voiceDemolish:Play("targetyou")
			yellDemolish:Yell()
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellDemolishFades:Countdown(remaining)
		end
	elseif spellId == 254122 then
		warnCloudofConfuse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCloudofConfuse:Show()
			voiceCloudofConfuse:Play("runout")
			yellCloudofConfuse:Yell()
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellCloudofConfuseFades:Countdown(remaining)
		end
	elseif spellId == 253600 then
		warnSoulburn:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSoulburn:Show()
			voiceSoulburn:Play("runout")
			yellSoulburn:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 then
		if args:IsPlayer() then
			yellDemolishFades:Cancel()
		end
	elseif spellId == 254122 then
		if args:IsPlayer() then
			yellCloudofConfuseFades:Cancel()
		end
	end
end
