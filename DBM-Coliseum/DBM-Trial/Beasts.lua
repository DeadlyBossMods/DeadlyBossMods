local mod = DBM:NewMod("Beasts", "DBM-Trial")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34799)  

mod:RegisterCombat("combat", 34799, 35144, 35469, 35470)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS"
)

mod:SetBossHealthInfo(
	35799, L,Dreadscale,
	35144, L.Acidmaw,
	35470, L.Icehowl,
	35469, L.Gormok
)

-- GORMOK OPTIONS
-- local warnFireBomb	= mod:NewAnnounce("WarnFireBomb", 3)	-- 67472
local warnStomp		= mod:NewAnnounce("WarnStomp", 3)	-- 67647
local warnStompSoon	= mod:NewAnnounce("WarnStompSoon", 2)
local warnImpaler	= mod:NewAnnounce("WarnImpaler", 4)	-- 67477

local timerStomp	= mod:NewCDTimer(21, 67647)


-- JORMUNGARS
local warnAcidicSpew	= mod:NewAnnounce("WarnAcidicSpew", 3)	--66818
local warnMoltenSpew	= mod:NewAnnounce("WarnMoltenSpew", 3)	--66821
local warnToxic		= mod:NewAnnounce("WarnToxic", 3)	--67618
local warnBurn		= mod:NewAnnounce("WarnBurn", 3)	--66869
local warnSlime		= mod:NewAnnounce("WarnSlime", 3)	--67641
local warnEnrage	= mod:NewAnnounce("WarnEnrage", 3)	--68335

local specWarnToxic	= mod:NewSpecialWarning("SpecWarnToxic")
local specWarnBurn	= mod:NewSpecialWarning("SpecWarnBurn")


-- ICEHOWL OPTIONS
local warnButt		= mod:NewAnnounce("WarnButt", 3)	--67654
local warnCharge	= mod:NewAnnounce("WarnCharge", 3)	--
local warnChargeSoon	= mod:NewAnnounce("WarnChargeSoon", 2)
local warnDaze		= mod:NewAnnounce("WarnDaze", 3)	--66758
local warnRage		= mod:NewAnnounce("WarnRage", 3)	--66759

local timerButt		= mod:NewCDTimer(12, 67654)
local timerCharge	= mod:NewTargetTimer(7, 62374)

local specWarnCharge	= mod:NewSpecialWarning("SpecWarnCharge")


local burn = {}
local toxin = {}
local StompCounter = 0

function mod:OnCombatStart(delay)
	StompCounter = 0
	DBM.BossHealth:Clear()
	DBM.BossHealth:AddBoss(35469, L.Gormok)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 67647 then
		StompCounter = StompCounter + 1
		warnStomp:Show()
		timerStomp:Start(StompCounter)
		warnStompSoon:Schedule(16)
	elseif args.spellId == 66818 then
		warnAcidicSpew:Show()
	elseif args.spellId == 66821 then
		warnMoltenSpew:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67641 then
		warnSlime:Show()
	end
end
		
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67654 then
		warnButt:Show(args.destName)
		timerButt:Start()
	elseif args.spellId == 66758 then
		warnDaze:Show()
	elseif args.spellId == 66759 then
		warnRage:Show()
	elseif args.spellId == 67618 then
		self:UnscheduleMethod("warnToxin")
		toxin[#toxin + 1] = args.destName
		if args.destName == UnitName("player") then
			specWarnToxic:Show()
		end
		self:ScheduleMethod(0.2, "warnToxin")
	elseif args.spellId == 66869 then
		self:UnscheduleMethod("warnBurn")
		burn[#burn + 1] = args.destName
		if args.destName == UnitName("player") then
			specWarnBurn:Show()
		end
		self:ScheduleMethod(0.2, "warnBurn")
	elseif args.spellId == 68335 then
		warnEnrage:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 67477 then
		if args.amount > 1 then
			warmImpaler:Show(args.amount, args.destName)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(args)
	if msg == L.Charge then
		target = msg:find(L.Charge)
		if target == UnitName("player") then
			specWarnCharge:Show()
		end
		warnCharge:Show(target)
		timerCharge:Start()
		warnChargeSoon:Schedule(4)
	end
end

function mod:CHAT_MSG_MONSTER_YELL()
	if arg1 == L.Phase2 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(35144, L.Acidmaw)
		DBM.BossHealth:AddBoss(35799, L.Dreadscale)
	elseif arg1 == L.Phase3 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBosS(35470, L.Icehowl)
	end
end

function mod:warnToxin()
	warnToxin:Show(table.concat(toxin, "<, >"))
end

function mod:warnToxin()
	warnBurn:Show(table.concat(burn, "<, >"))
end


