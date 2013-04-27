local mod	= DBM:NewMod("d539", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 884)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)

--Li Te
local warnWaterShell		= mod:NewSpellAnnounce(124653, 2)
--Den Mother Moof
local warnBurrow			= mod:NewSpellAnnounce(124359, 2)
--Warbringer Qobi
local warnFireLine			= mod:NewCastAnnounce(125392, 4, 3)

--Warbringer Qobi
local specWarnFireLine		= mod:NewSpecialWarningSpell(125392, nil, nil, nil, 2)

--Li Te
local timerWaterShellCD		= mod:NewNextTimer(19.5, 124653)
--Den Mother Moof
local timerBurrowCD			= mod:NewNextTimer(26.5, 124359)
--Warbringer Qobi
local timerFireLineCD		= mod:NewCDTimer(16, 125392)

--General
local timerBossCD		= mod:NewTimer(60, "timerBossCD", 2457)--Completely unverified timers. only log of one run. might not even be time based.

mod:RemoveOption("HealthFrame")

local elementalPulled = false
local bossCount = 0
local bossGUIDS = {}

function mod:OnCombatStart(delay)
	elementalPulled = false
	bossCount = 0
	table.wipe(bossGUIDS)
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RatEngage or msg:find(L.RatEngage) then
		self:SendSync("RatPulled")
	elseif msg == L.BeginAttack or msg:find(L.BeginAttack) then
		self:SendSync("AttackBegin")
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	for i = 1, 5 do--If you aren't terrible, it'll always be boss1. However, if boss1 is alive when second and third spawn, you could get other bossN numbers so as failsave we just scan all every time
		if UnitExists("boss"..i) and not bossGUIDS[UnitGUID("boss"..i)] then
			bossGUIDS[UnitGUID("boss"..i)] = true
			bossCount = bossCount + 1
			if bossCount == 1 then
				timerBossCD:Start(62, L.Yeti)
			else
				timerBossCD:Start(58, L.Qobi)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 124428 then
		warnWaterShell:Show()
		timerWaterShellCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 124428 and not elementalPulled then
		elementalPulled = true
		self:SendSync("ElementalPulled")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 124359 then
		warnBurrow:Show()
		timerBurrowCD:Start()
	elseif args.spellId == 125392 then
		warnFireLine:Show()
		specWarnFireLine:Show()
		timerFireLineCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 63520 then--Li Te
		timerWaterShellCD:Cancel()
	elseif cid == 63518 then--Den Mother Moof
		timerBurrowCD:Cancel()
	elseif cid == 63528 then--Warbringer Qobi
		timerFireLineCD:Cancel()
	end
end

function mod:OnSync(msg)
	if msg == "RatPulled" then
		timerBurrowCD:Start(17)
	elseif msg == "ElementalPulled" then
		elementalPulled = true
		timerWaterShellCD:Start(15)
	elseif msg == "AttackBegin" then
		timerBossCD:Start(141.7, L.Yeti)
	end
end
