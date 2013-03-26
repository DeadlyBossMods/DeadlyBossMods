local mod	= DBM:NewMod("Troves", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 8980 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 934)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_AURA"
)

local warnStoneSmash		= mod:NewCastAnnounce(139777, 3, nil, nil, false)

local timerEvent			= mod:NewBuffFadesTimer(299, 140000)
local timerStoneSmash		= mod:NewCastTimer(3, 139777, nil, false)

local countdownEvent		= mod:NewCountdown(299, 140000, nil, nil, 10)

mod:RemoveOption("HealthFrame")

local timerDebuff = GetSpellInfo(140000)
local timerStarted = false

function mod:SPELL_CAST_START(args)
	if args.spellId == 139777 then
		warnStoneSmash:Show()
		timerStoneSmash:Start(3, args.sourceGUID)
	end
end

--Apparently this doesn't fire in combat log, have to use UNIT_AURA instead.
function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", timerDebuff) and not timerStarted then
		timerStarted = true
		timerEvent:Start()
		countdownEvent:Start()
	elseif not UnitDebuff("player", timerDebuff) and timerStarted then
		timerStarted = false
		timerEvent:Cancel()
		countdownEvent:Cancel()
--		DBM:EndCombat(self)--Maybe consider it a victory if you do a loot run and not boss run?
--		Or maybe just only delcare it a victory when you defeat end boss and reach end and fire scenario completed event?
	end
end
