local mod	= DBM:NewMod("Silverlaine", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(3887)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnVeilShadow	= mod:NewSpellAnnounce(93956, 3)
local warnWorgenSpirit	= mod:NewSpellAnnounce(93857, 3)

local timerVeilShadow	= mod:NewBuffActiveTimer(8, 93956)
local timerWorgenSpirit	= mod:NewCastTimer(2, 93857)

local veilShadowCast = 0
local lastVeilShadow = 0

function mod:OnCombatStart(delay)
	veilShadowCast = 0
	lastVeilShadow = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93956) and GetTime() - lastVeilShadow > 4 then
		warnVeilShadow:Show()
		timerVeilShadow:Start()
		lastVeilShadow = GetTime()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(93956) then
		veilShadowCast = veilShadowCast + 1
		if veilShadowCast >= 5 then
			veilShadowCast = 0
			timerVeilShadow:Cancel()--Cancel timer after it's been dispelled off at least 5 players. Not a perfect hack but it'll do vs having 5 bars pop up
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93857) then
		warnWorgenSpirit:Show()
		timerWorgenSpirit:Start()
	end
end