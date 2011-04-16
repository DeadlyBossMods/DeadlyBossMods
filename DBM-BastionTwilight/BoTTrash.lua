local mod	= DBM:NewMod("BoTrash", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE"
)

--do we need warnings for http://www.wowhead.com/npc=49826#abilities or http://www.wowhead.com/npc=49821#abilities debuff stacks?
local warnVolcanicWrath		= mod:NewSpellAnnounce(87903, 4)--This is nasty volcano aoe that's channeled that will wipe raid on trash if not interrupted.
local warnFrostWhirl		= mod:NewSpellAnnounce(93340, 4)--This is nasty frost whirl elementals do before ascendant Council.
local warnFlameStrike		= mod:NewTargetAnnounce(93383, 4)--This is Flame strike we need to not stand in unless we're dispeling frost dudes shield.
local warnRupture			= mod:NewTargetAnnounce(93377, 4)--This is twilight rupture the big guys do in hallway before halfus.

local specWarnVolcanicWrath	= mod:NewSpecialWarningSpell(87903, nil, nil, nil, true)
local specWarnRupture		= mod:NewSpecialWarningSpell(93377, nil, nil, nil, true)
local specWarnFrostWhirl	= mod:NewSpecialWarningSpell(93340, nil, nil, nil, true)
local specWarnFlameStrike	= mod:NewSpecialWarningMove(93362)
local yellFlamestrike		= mod:NewYell(93362)

local timerVolcanicWrath	= mod:NewBuffActiveTimer(9, 87903)--Maybe need a Guid based targettimer since most pulls have 2 of these?
local timerFrostWhirl		= mod:NewBuffActiveTimer(4, 93340)--Maybe need a Guid based targettimer in case you pull more than one?

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:RuptureTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	warnRupture:Show(targetname)
end

function mod:FlameStrikeTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	warnFlameStrike:Show(targetname)
	if targetname == UnitName("player") then
		yellFlamestrike:Yell()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93340) then
		warnFrostWhirl:Show()
		specWarnFrostWhirl:Show()
		timerFrostWhirl:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87903) then
		warnVolcanicWrath:Show()
		specWarnVolcanicWrath:Show()
		timerVolcanicWrath:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(80652) then
		timerFrostWhirl:Cancel()
	elseif args:IsSpellID(87903) then--I will have to log this trash to verify this spell event.
		timerVolcanicWrath:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93383, 93362) then--Are both IDs used?
		self:ScheduleMethod(0.2, "FlameStrikeTarget", args.sourceGUID)--Timing might need tuning but target scanning definitely works for this.
	elseif args:IsSpellID(93377) then
		specWarnRupture:Show()
		self:ScheduleMethod(0.2, "RuptureTarget", args.sourceGUID)--Timing might need tuning but target scanning definitely works for this.
	end
end

do 
	local lastFlamestrike = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(93383, 93362) and args:IsPlayer() and GetTime() - lastFlamestrike > 3 then
			specWarnFlameStrike:Show()
			lastFlamestrike = GetTime()
		end
	end
end