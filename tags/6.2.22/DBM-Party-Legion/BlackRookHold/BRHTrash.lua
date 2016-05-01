local mod	= DBM:NewMod("BRHTrash", "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 200261",
	"SPELL_AURA_APPLIED 194966",
	"SPELL_CAST_SUCCESS 200343"
)

local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(200261, "Tank", nil, nil, 1, 2)
local specWarnSoulEchos				= mod:NewSpecialWarningRun(194966, nil, nil, nil, 1, 2)
local specWarnArrowBarrage			= mod:NewSpecialWarningDodge(200343, nil, nil, nil, 2, 2)

local voiceBonebreakingStrike		= mod:NewVoice(200261, "Tank")
local voiceSoulEchos				= mod:NewVoice(194966)
local voiceArrowBarrage				= mod:NewVoice(200343)--stilldanger (best one i could come up with)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200261 and self:AntiSpam(2, 1) then
		specWarnBonebreakingStrike:Show()
		voiceBonebreakingStrike:Play("shockwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194966 then
		if args:IsPlayer() then
			specWarnSoulEchos:Show()
			voiceSoulEchos:Play("runaway")
			voiceSoulEchos:Schedule(1, "keepmove")
		else
			warnSoulEchoes:Show(args.destName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 and self:AntiSpam(3, 2) then
		specWarnArrowBarrage:Show()
		voiceArrowBarrage:Play("stilldanger")
	end
end
