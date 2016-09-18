local mod	= DBM:NewMod("VoWTrash", "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196799 193069 196799 196249",
	"SPELL_AURA_APPLIED 202615 193069"
)

local warnTorment				= mod:NewTargetAnnounce(202615, 3)
local warnNightmares			= mod:NewTargetAnnounce(202615, 4)

local specWarnUnleashedFury		= mod:NewSpecialWarningSpell(196799, nil, nil, nil, 1, 2)
local specWarnNightmares		= mod:NewSpecialWarningInterrupt(193069, "HasInterrupt", nil, nil, 1, 2)
local yellNightmares			= mod:NewYell(193069)
local yellTorment				= mod:NewYell(202615)
local specWarnMeteor			= mod:NewSpecialWarningSpell(196249, nil, nil, nil, 1, 2)

local voiceUnleashedFury		= mod:NewVoice(196799)--aesoon
local voiceNightmares			= mod:NewVoice(193069, "HasInterrupt")--kickcast
local voiceMeteor				= mod:NewVoice(196249)--gathershare

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196799 then
		specWarnUnleashedFury:Show()
		voiceUnleashedFury:Play("aesoon")
	elseif spellId == 193069 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnNightmares:Show(args.sourceName)
		voiceNightmares:Play("kickcast")
	elseif spellId == 196249 then
		specWarnMeteor:Show()
		voiceMeteor:Play("gathershare")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202615 then
		warnTorment:Show(args.destName)
		if args:IsPlayer() then
			yellTorment:Yell()
		end
	elseif spellId == 193069 then
		warnNightmares:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellNightmares:Yell()
		end
	end
end
