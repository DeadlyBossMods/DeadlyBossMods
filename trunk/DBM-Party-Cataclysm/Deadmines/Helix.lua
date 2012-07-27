local mod	= DBM:NewMod(90, "DBM-Party-Cataclysm", 2, 63)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47296, 47297)
mod:SetModelID(33002)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnChestBomb			= mod:NewTargetAnnounce(88352, 4)
local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

local timerChestBomb		= mod:NewTargetTimer(10, 88352)

local specWarnChestBomb		= mod:NewSpecialWarningYou(88352)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(88352) then
		warnChestBomb:Show(args.destName)
		timerChestBomb:Start(args.destName)
		if args:IsPlayer() then
			specWarnChestBomb:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(59304) and mod:IsInCombat() then
		warnSpiritStrike:Show()
	end
end
