local mod	= DBM:NewMod("HighmaulTrash", "DBM-Highmaul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 175636 173827 172066 166200 175654"
)

--Maybe add auto range finder for moveaway warnings, and REMOVED event to close it after
local warnRuneofDestruction			= mod:NewTargetAnnounce(175636, 3, nil, false, 2)
local warnRadiatingPoison			= mod:NewTargetAnnounce(172066, 3, nil, false, 2)
local warnArcaneVol					= mod:NewTargetAnnounce(166200, 3, nil, false, 2)

local specWarnRuneofDisintegration	= mod:NewSpecialWarningMove(175654)
local specWarnRuneofDestruction		= mod:NewSpecialWarningMoveAway(175636)
local yellRuneofDestruction			= mod:NewYell(175636)
local specWarnRadiatingPoison		= mod:NewSpecialWarningMoveAway(172066)
local yellRadiatingPoison			= mod:NewYell(172066)
local specWarnArcaneVol				= mod:NewSpecialWarningMoveAway(166200)
local yellArcaneVol					= mod:NewYell(166200)
local specWarnWildFlames			= mod:NewSpecialWarningMove(173827)

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(8, 166200)

local debuff = GetSpellInfo(166200)
local DebuffFilter
do
	DebuffFilter = function(uId)
		return UnitDebuff(uId, debuff)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175636 then
		warnRuneofDestruction:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnRuneofDestruction:Show()
			if not self:IsLFR() then
				yellRuneofDestruction:Yell()
			end
		end
	elseif spellId == 172066 then
		warnRadiatingPoison:CombinedShow(1, args.destName)
		if args:IsPlayer() and not self:IsTank() then--tank can't run out even if they have debuff
			specWarnRadiatingPoison:Show()
			if not self:IsLFR() then
				yellRadiatingPoison:Yell()
			end
		end
	elseif spellId == 166200 then
		warnArcaneVol:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnArcaneVol:Show()
			if not self:IsLFR() and self:AntiSpam(3, 1) then
				yellArcaneVol:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8, nil, nil, nil, nil, 6.5)
			end
		end
		if self.Options.RangeFrame and not UnitDebuff("player", debuff) then
			DBM.RangeCheck:Show(8, DebuffFilter, nil, nil, nil, 6.5)
		end
	elseif spellId == 173827 and args:IsPlayer() then
		specWarnWildFlames:Show()
	elseif spellId == 175654 and args:IsPlayer() then
		specWarnRuneofDisintegration:Show()
	end
end
