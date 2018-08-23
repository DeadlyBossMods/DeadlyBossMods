local mod	= DBM:NewMod("BoralusTrash", "DBM-Party-BfA", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 275826",
--	"SPELL_AURA_APPLIED",
--	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_START"
)

--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnBolsteringShout		= mod:NewSpecialWarningMove(275826, "Tank", nil, nil, 1, 2)
local specWarnTrample				= mod:NewSpecialWarningDodge(272874, nil, nil, nil, 2, 2)
--local specWarnDarkMending			= mod:NewSpecialWarningInterrupt(225573, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 275826 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 1) then
		specWarnBolsteringShout:Show()
		specWarnBolsteringShout:Play("moveboss")
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]

--Not in combat log what so ever, so this relies on unit event off a users target or nameplate unit IDs, then syncing to group
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 272874 then
		local guid = UnitGUID(uId)
		if self:IsValidWarning(guid, uId) then
			self:SendSync("Trample")
		end
	end
end

function mod:OnSync(msg)
	if msg == "Trample" and self:AntiSpam(4, 2) then
		specWarnTrample:Show()
		specWarnTrample:Play("chargemove")
	end
end
