local mod	= DBM:NewMod("Drogan", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90841)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180882",
	"SPELL_AURA_APPLIED 180880"
)

local warnWhirlingAxe			= mod:NewSpellAnnounce(180882, 3)
local warnChainGrasp			= mod:NewTargetAnnounce(180880, 3)

local specWarnChainGrasp		= mod:NewSpecialWarningYou(180880)--Persists for 30 seconds or until you get 30 yards from boss, whichever first.

--local voiceChainGrasp			= mod:NewVoice(180880)--runout? For this, you have to run away from boss by 30 yards to break chain

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180882 then
		warnWhirlingAxe:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180880 then
		if args:IsPlayer() then
			specWarnChainGrasp:Show()
			--voiceChainGrasp:Play("runout")
		else
			warnChainGrasp:Show(args.destName)
		end
	end
end
