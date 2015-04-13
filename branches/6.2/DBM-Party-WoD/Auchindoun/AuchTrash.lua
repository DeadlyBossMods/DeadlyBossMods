local mod	= DBM:NewMod("AuchTrash", "DBM-Party-WoD", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 157173 157797 154527 154623 160312"
)

local warnVoidShell					= mod:NewSpellAnnounce(160312, 3)

local specWarnBendWill				= mod:NewSpecialWarningInterrupt(154527)
local specWarnVoidShell				= mod:NewSpecialWarningDispel(160312, "MagicDispeller")
local specWarnVoidMending			= mod:NewSpecialWarningInterrupt(154623)
local specWarnFelStomp				= mod:NewSpecialWarningDodge(157173, "Tank")
local specWarnArbitersHammer		= mod:NewSpecialWarningInterrupt(157797)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 157173 then
		specWarnFelStomp:Show()
	elseif spellId == 157797 then
		specWarnArbitersHammer:Show(args.sourceName)
	elseif spellId == 154527 then
		specWarnBendWill:Show(args.sourceName)
	elseif spellId == 154623 then
		specWarnVoidMending:Show(args.sourceName)
	elseif spellId == 160312 then
		warnVoidShell:Schedule(2)
		specWarnVoidShell:Schedule(2, SPELL_TARGET_TYPE13_DESC)--"enemies"
	end
end
