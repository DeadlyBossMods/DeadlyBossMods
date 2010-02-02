local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID()
mod:RegisterCombat("combat")
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnSpiritBurst 		= mod:NewTargetAnnounce(73808)

local specWarnSpiritBurst	= mod:NewSpecialWarningYou(73808)

local timerSpiritBurst 		= mod:NewNextTimer(5, 73808)

mod:AddBoolOption("SpiritBurstIcon", true)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(73808) then -- Spirit Burst
		warnSpiritBurst:Show(args.destName)
		timerSpiritBurst:Start(args.destName)
		if args:IsPlayer() then
			specWarnSpiritBurst:Show()
		end
		if self.Options.SpiritBurstIcon then
			self:SetIcon(targetname, 8, 5)
		end
	end
end