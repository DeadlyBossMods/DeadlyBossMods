local mod	= DBM:NewMod("NLTrash", "DBM-Party-Legion", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 183088",
	"SPELL_AURA_APPLIED 200154 183407"
)

local warnBurningHatred			= mod:NewTargetAnnounce(182879, 3)

local specWarnBurningHatred		= mod:NewSpecialWarningYou(200154, nil, nil, nil, 1, 2)
local specWarnAcidSplatter		= mod:NewSpecialWarningMove(183407, nil, nil, nil, 1, 2)
local specWarnAvalanche			= mod:NewSpecialWarningDodge(183088, "Tank", nil, nil, 1, 2)

local voiceBurningHatred		= mod:NewVoice(200154)--targetyou
local voiceAcidSplatter			= mod:NewVoice(183407)--runaway
local voiceAvalanche			= mod:NewVoice(183088, "Tank")--shockwave

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 183088 then
		specWarnAvalanche:Show()
		voiceAvalanche:Play("shockwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200154 then
		if args:IsPlayer() then
			specWarnBurningHatred:Show()
			voiceBurningHatred:Play("targetyou")
		else
			warnBurningHatred:Show(args.destName)
		end
	elseif spellId == 183407 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnAcidSplatter:Show()
		voiceAcidSplatter:Play("runaway")
	end
end
