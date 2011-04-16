local mod	= DBM:NewMod("BWDTrash", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnLaserStrike		= mod:NewSpellAnnounce(81063, 2)--Big red don't stand in beam golems use.
local warnFlashBomb			= mod:NewSpellAnnounce(81056, 2)--Flash bomb used by golems that disorients anyone within 12 yards of target.
local warnBPBronze			= mod:NewTargetAnnounce(80372, 3)--Debuff is 80329, but not sure what aspect uses it. Fairly certain it's bronze though so that's what we warn for, for now.
local warnEnrage			= mod:NewTargetAnnounce(80084, 3)--This is enrage effect for Maimgor drake in front of maloriaks area.
local warnSacrifice			= mod:NewTargetAnnounce(80727, 2)--Sacrifice used by spirits before atramedes
local warnWhirlwind			= mod:NewTargetAnnounce(80652, 2)--Whirlwind used by spirits before atramedes

local yellFlashBomb			= mod:NewYell(81056)

local timerSacrifice		= mod:NewTargetTimer(20, 80727)
local timerWhirlwind		= mod:NewTargetTimer(5, 80652)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(80372) then
		warnBPBronze:Show(args.destName)
	elseif args:IsSpellID(80727) and args:IsDestTypePlayer() then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	elseif args:IsSpellID(80084) then
		warnEnrage:Show(args.destName)
	elseif args:IsSpellID(80652) then
		warnWhirlwind:Show(args.destName)
		timerWhirlwind:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(80727) and args:IsDestTypePlayer() then
		timerSacrifice:Cancel(args.destName)
	elseif args:IsSpellID(80652) then
		timerWhirlwind:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(81063) then
		warnLaserStrike:Show()
	elseif args:IsSpellID(81056) then
		warnFlashBomb:Show()
	end
end
