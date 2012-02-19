local mod	= DBM:NewMod("BWDTrash", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(29539)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warnLaserStrike		= mod:NewSpellAnnounce(81063, 2)--Big red don't stand in beam golems use.
local warnFlashBomb			= mod:NewSpellAnnounce(81056, 2)--Flash bomb used by golems that disorients anyone within 12 yards of target.
local warnEnrage			= mod:NewStackAnnounce(80084, 3)--This is enrage effect for Maimgor drake in front of maloriaks area.
local warnSacrifice			= mod:NewTargetAnnounce(80727, 2)--Sacrifice used by spirits before atramedes
local warnWhirlwind			= mod:NewTargetAnnounce(80652, 2)--Whirlwind used by spirits before atramedes

local timerChargeCD			= mod:NewNextTimer(30, 79630)--Guesswork
local timerSacrifice		= mod:NewTargetTimer(20, 80727)
local timerWhirlwind		= mod:NewTargetTimer(5, 80652)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local drakonidDied = 0

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(80727) and args:IsDestTypePlayer() then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	elseif args:IsSpellID(80084) then
		warnEnrage:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(80652) then
		warnWhirlwind:Show(args.destName)
		timerWhirlwind:Start(args.destName)
	elseif args:IsSpellID(79630) then--Drakonid Rush
		timerChargeCD:Start()
	elseif args:IsSpellID(80035) then--Drakonid Vengeful rage, good way to reset dragonid died counter without a pull mechanic to reset on.
		drakonidDied = 1
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 42362 then
		drakonidDied = drakonidDied + 1
		if drakonidDied == 2 then
			timerChargeCD:Cancel()
		end
	end
end