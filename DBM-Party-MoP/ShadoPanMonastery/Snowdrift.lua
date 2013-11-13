local mod	= DBM:NewMod(657, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56541)
mod:SetEncounterID(1304)
mod:SetZone()
mod:SetMinSyncRevision(7888)
mod:SetReCombatTime(60)

-- pre-bosswave. Novice -> Black Sash (Fragrant Lotus, Flying Snow). this runs automaticially.
-- maybe we need Black Sash wave warns.
-- but boss (Master Snowdrift) not combat starts automaticilly. 
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Chi blast warns very spammy. and not useful.
local warnFistsOfFury		= mod:NewSpellAnnounce(106853, 3)
local warnTornadoKick		= mod:NewSpellAnnounce(106434, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnChaseDown			= mod:NewTargetAnnounce(118961, 3)--Targeting spell for Tornado Slam (106352)
-- phase3 ability not found yet.
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnFists			= mod:NewSpecialWarningMove(106853, mod:IsTank())
local specWarnChaseDown		= mod:NewSpecialWarningYou(118961)

local timerFistsOfFuryCD	= mod:NewCDTimer(23, 106853)--Not enough data to really verify this
local timerTornadoKickCD	= mod:NewCDTimer(32, 106434)--Or this
--local timerChaseDownCD		= mod:NewCDTimer(22, 118961)--Unknown
local timerChaseDown		= mod:NewTargetTimer(11, 118961)

local phase = 1
local remainingNovice = 20

function mod:OnCombatStart(delay)
	phase = 1
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 118961 then
		warnChaseDown:Show(args.destName)
		timerChaseDown:Start(args.destName)
--		timerChaseDownCD:Start()
		if args:IsPlayer() then
			specWarnChaseDown:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 118961 then
		timerChaseDown:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 106853 then
		warnFistsOfFury:Show()
		specWarnFists:Show()
		timerFistsOfFuryCD:Start()
	elseif args.spellId == 106434 then
		warnTornadoKick:Show()
		timerTornadoKickCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 110324 then
		phase = phase + 1
		if phase == 2 then
			warnPhase2:Show()
		elseif phase == 3 then
			warnPhase3:Show()
		end
		timerFistsOfFuryCD:Cancel()
		timerTornadoKickCD:Cancel()
	elseif spellId == 123096 then -- only first defeat?
		DBM:EndCombat(self)
	end
end