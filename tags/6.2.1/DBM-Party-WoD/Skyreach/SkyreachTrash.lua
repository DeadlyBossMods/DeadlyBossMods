local mod	= DBM:NewMod("SkyreachTrash", "DBM-Party-WoD", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 160303 160288",
	"SPELL_AURA_REMOVED 160303 160288"
)

local specWarnSolarDetonation		= mod:NewSpecialWarningMoveAway(160288)

local voiceSolarDetonation			= mod:NewVoice(160288)

mod:AddRangeFrameOption(3, 160288)--Range guessed. Maybe 5. one tooltip says 1.5 but it def seemed bigger then that. closer to 3-5

mod:RemoveOption("HealthFrame")

mod.vb.debuffCount = 0
local Debuff = GetSpellInfo(160288)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, Debuff)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 160303 or spellId == 160288 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		if self.Options.RangeFrame then
			if UnitDebuff("player", Debuff) then--You have debuff, show everyone
				DBM.RangeCheck:Show(3, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(3, debuffFilter)
			end
		end
		if args:IsPlayer() then
			specWarnSolarDetonation:Show()
			voiceSolarDetonation:Play("runout")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 160303 or spellId == 160288 then
		self.vb.debuffCount = self.vb.debuffCount - 1
		if self.Options.RangeFrame then
			if self.vb.debuffCount == 0 then
				DBM.RangeCheck:Hide()
			else
				if UnitDebuff("player", Debuff) then--You have debuff, show everyone
					DBM.RangeCheck:Show(3, nil)
				else--You do not have debuff, only show players who do
					DBM.RangeCheck:Show(3, debuffFilter)
				end
			end
		end
	end
end
