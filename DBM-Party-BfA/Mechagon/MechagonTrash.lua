local mod	= DBM:NewMod("MechagonTrash", "DBM-Party-BfA", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 300687 300764 300777 300650",
	"SPELL_AURA_APPLIED 300650",
--	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

--https://www.wowhead.com/guides/operation-mechagon-megadungeon-strategy-guide
--local warnRiotShield				= mod:NewSpellAnnounce(258317, 4)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnSlimewave				= mod:NewSpecialWarningDodge(300777, nil, nil, nil, 2, 2)
--local specWarnRiotShieldMove		= mod:NewSpecialWarningMove(258317, nil, nil, nil, 1, 2)
local specWarnConsume				= mod:NewSpecialWarningRun(300687, nil, nil, nil, 4, 2)
local specWarnSlimeBolt				= mod:NewSpecialWarningInterrupt(300764, "HasInterrupt", nil, nil, 1, 2)
local specWarnSuffocatingSmog		= mod:NewSpecialWarningInterrupt(300650, "HasInterrupt", nil, nil, 1, 2)
local specWarnSuffocatingSmogDispel	= mod:NewSpecialWarningDispel(300650, "RemoveDisease", nil, nil, 1, 2)
--local specWarnRiotShield			= mod:NewSpecialWarningReflect(258317, "CasterDps", nil, nil, 1, 2)


local timerConsume					= mod:NewCDTimer(20, 300687, nil, nil, nil, 2)

--Antispam IDs for this mod: 1 run away, 2 dodges, 3 dispels
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 300687 and self:IsValidWarning(args.sourceGUID) then
		if self:AntiSpam(3, 1) then
			specWarnConsume:Show()
			specWarnConsume:Play("justrun")
		end
		timerConsume:Start(20, args.sourceGUID)
	elseif spellId == 300777 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnSlimewave:Show()
		specWarnSlimewave:Play("chargemove")
	elseif spellId == 300764 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSlimeBolt:Show(args.sourceName)
		specWarnSlimeBolt:Play("kickcast")
	elseif spellId == 300650 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSuffocatingSmog:Show(args.sourceName)
		specWarnSuffocatingSmog:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 300650 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(5, 3) then
		specWarnSuffocatingSmogDispel:Show()
		specWarnSuffocatingSmogDispel:Play("helpdispel")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 154744 or cid == 154758 or cid == 150168 then--Toxic Monstrosity
		timerConsume:Stop(args.destGUID)
	end
end
