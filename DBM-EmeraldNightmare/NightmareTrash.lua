local mod	= DBM:NewMod("EmeraldNightmareTrash", "DBM-EmeraldNightmare")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED 221028",
	"SPELL_AURA_REMOVED 221028"
)

local warnUnstableDecay				= mod:NewTargetAnnounce(221028, 3)

local specWarnUnstableDecay			= mod:NewSpecialWarningMoveAway(221028, nil, nil, nil, 1, 2)
local yellUnstableDecay				= mod:NewYell(221028)

local voiceUnstableDecay			= mod:NewVoice(221028)--runout

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(10, 221028)

local Bloodthirster = EJ_GetSectionInfo(11266)

--[[
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 189595 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221028 then
		if args:IsPlayer() then--TODO, maybe give it a delay, it does take a while
			specWarnUnstableDecay:Show()
			voiceUnstableDecay:Play("runout")
			yellUnstableDecay:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnUnstableDecay:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221028 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end
