local mod	= DBM:NewMod("d647", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 937)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Trash (and somewhat Urtharges)
local warnStoneRain				= mod:NewSpellAnnounce(142139, 3)--Hit debuff, interrupt or move out of it
local warnSpellShatter			= mod:NewCastAnnounce(141421, 3, 2, nil, false)--Spell interrupt. Cast time is long enough to /stopcasting this
local warnSummonFieryAnger		= mod:NewCastAnnounce(141488, 3, 2.5)
local warnDetonate				= mod:NewCastAnnounce(141456, 4, 5)--Can kill or run away from. It's actually more practical to ignore it and let it kill itself to speed up run
--Urtharges the Destroyer
local warnRuptureLine			= mod:NewTargetAnnounce(141418, 3)
local warnCallElemental			= mod:NewSpellAnnounce(141872, 4)
--Echo of Y'Shaarj
local warnMalevolentForce		= mod:NewCastAnnounce(142840, 4, 2)

--Trash (and somewhat Urtharges)
local specWarnStoneRain			= mod:NewSpecialWarningSpell(142139, nil, nil, nil, 2)--Let you choose to interrupt it or move out of it.
local specWarnSpellShatter		= mod:NewSpecialWarningCast(141421, false)
local specWarnSummonFieryAnger	= mod:NewSpecialWarningInterrupt(141488)
local specWarnDetonate			= mod:NewSpecialWarningRun(141456)--Technically can kill it too vs run, but I favor run strategy more.
--Urtharges the Destroyer
local specWarnRuptureLine		= mod:NewSpecialWarningMove(141418)
local specWarnCallElemental		= mod:NewSpecialWarningSpell(141872)
--Echo of Y'Shaarj
local specWarnMalevolentForce	= mod:NewSpecialWarningInterrupt(142840)--Not only cast by last boss but trash near him as well, interrupt important for both. Although only bosses counts for achievement.

--Urtharges the Destroyer
local timerCallElementalCD	= mod:NewCDTimer(50, 141872)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args.spellId == 142139 then
		warnStoneRain:Show()
		specWarnStoneRain:Show()
	elseif args.spellId == 141421 then
		warnSpellShatter:Show()
		specWarnSpellShatter:Show()
	elseif args.spellId == 141421 then
		warnSummonFieryAnger:Show()
		specWarnSummonFieryAnger:Show(args.sourceName)
	elseif args.spellId == 142840 then
		warnMalevolentForce:Show()
		specWarnMalevolentForce:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 141418 then
		warnRuptureLine:Show(args.destName)
		if args:IsPlayer() then
			specWarnRuptureLine:Show()
		end
	elseif args.spellId == 141456 then
		warnDetonate:Show()
		specWarnDetonate:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70959 then--Urtharges the Destroyer
		timerCallElementalCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 141872 and self:AntiSpam(3, 1) then--Call Elemental
		self:SendSync("CallElemental")
	end
end

--"<515.8 16:07:40> [SCENARIO_CRITERIA_UPDATE] criteriaID#23357#Info#Dark Heart of Pandaria#5#5#0#true#false#false#StepInfo#Heartbreak#Destroy the Echo of Y'Sharrj.#1#BonusStepInfo#Bonus Objectives#Complete the Bonus Objective to receive bonus Valor.#1#false#CriteriaInfo1#Echo of Y'Sharrj slain#0#false#0#1#0#71123#0#23251#0#BonusCriteriaInfo1#Echo of Y'Shaarj slain (Timed)#0#false#0#1#0#71123#0#23357#180#false", -- [6605]
--function mod:SCENARIO_CRITERIA_UPDATE(criteriaID)
	--Just in case this is needed, i can't find any consistency in bosses timers at the moment to make use of engage timing.
--end

--Fallback, in case no one is targeting boss (cause he does summon adds, may be targeting adds)
--"<70.5 16:00:15> [UNIT_SPELLCAST_SUCCEEDED] Urtharges the Destroyer [[target:Call Elemental::0:141872]]",
--"<70.7 16:00:15> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Minions, destroy these insects!#Urtharges the Destroyer#####0#0##0#447#nil#0#false#false",
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.summonElemental or msg:find(L.summonElemental)) and self:AntiSpam(3, 1) then
		self:SendSync("CallElemental")
	end
end

function mod:OnSync(msg)
	if msg == "CallElemental" then
		warnCallElemental:Show()
		specWarnCallElemental:Show()
		timerCallElementalCD:Start()
	end
end
