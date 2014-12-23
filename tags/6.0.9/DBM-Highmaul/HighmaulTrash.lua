local mod	= DBM:NewMod("HighmaulTrash", "DBM-Highmaul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 175636 173827 172066 166200"
)

--local warnRuneofDestruction			= mod:NewTargetAnnounce(175636, 3)
--local warnRadiatingPoison			= mod:NewTargetAnnounce(172066, 3)
--local warnArcaneVol					= mod:NewTargetAnnounce(166200, 3)

local specWarnRuneofDestruction		= mod:NewSpecialWarningMoveAway(175636)
local specWarnRadiatingPoison		= mod:NewSpecialWarningMoveAway(172066)
local specWarnArcaneVol				= mod:NewSpecialWarningMoveAway(166200)
local specWarnWildFlames			= mod:NewSpecialWarningMove(173827)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175636 then
		--warnRuneofDestruction:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnRuneofDestruction:Show()
		end
	elseif spellId == 172066 then
		--warnRadiatingPoison:CombinedShow(1, args.destName)
		if args:IsPlayer() and not self:IsTank() then--tank can't run out even if they have debuff
			specWarnRadiatingPoison:Show()
		end
	elseif spellId == 166200 then
		--warnArcaneVol:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnArcaneVol:Show()
		end
	elseif spellId == 173827 and args:IsPlayer() then
		specWarnWildFlames:Show()
	end
end
