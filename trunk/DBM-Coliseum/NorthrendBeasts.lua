local mod = DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 599 $"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetMinCombatTime(30)
mod:SetZone()

-- 34816 npc to talk to
-- 34797 npc icehowl died

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED_DOSE"
)

local timerBreath			= mod:NewCastTimer(5, 67650)
local timerNextStomp		= mod:NewNextTimer(20, 66330)
local timerNextImpale		= mod:NewNextTimer(10, 67477)
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758)

local warnImpaleOn			= mod:NewAnnounce("WarningImpale", 2, 67478)
local warnFireBomb			= mod:NewAnnounce("WarningFireBomb", 4, 66317, false)
local warnBreath			= mod:NewAnnounce("WarningBreath", 1, 67650)
local warnRage				= mod:NewAnnounce("WarningRage", 3, 67657)
local warnCharge			= mod:NewAnnounce("WarningCharge", 4)
local warnToxin				= mod:NewAnnounce("WarningToxin", 2, 66823)
local warnBile				= mod:NewAnnounce("WarningBile", 3, 66869)

local specWarnImpale3		= mod:NewSpecialWarning("SpecialWarningImpale3", false)
local specWarnFireBomb		= mod:NewSpecialWarning("SpecialWarningFireBomb")
local specWarnSlimePool		= mod:NewSpecialWarning("SpecialWarningSlimePool")
local specWarnToxin		= mod:NewSpecialWarning("SpecialWarningToxin")
local specWarnBile		= mod:NewSpecialWarning("SpecialWarningBile")
local specWarnSilence		= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge		= mod:NewSpecialWarning("SpecialWarningCharge")
local specWarnChargeNear	= mod:NewSpecialWarning("SpecialWarningChargeNear")

mod:AddBoolOption("SetIconOnChargeTarget", true, "announce")
mod:AddBoolOption("SetIconOnBileTarget", true, "announce")

--local warnSpray				= mod:NewAnnounce("WarningSpray", 2, 67616)
--local specWarnSpray			= mod:NewSpecialWarning("SpecialWarningSpray")

local BileTargets = {}
local ToxinTargets = {}
local burnIcon = 8

function mod:OnCombatStart(delay)
	table.wipe(BurnTargets)
	table.wipe(ToxinTargets)
	burnIcon = 8
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67477 or args.spellId == 66331 then
		timerNextImpale:Start()
	elseif args.spellId == 67657 then
		warnRage:Show()
	elseif args.spellId == 66823 or args.spellId == 67618 then
		self:UnscheduleMethod("warnToxin")
		ToxinTargets[#ToxinTargets + 1] = args.destName
		if UnitName("player") == args.destName then
			specWarnToxin:Show()
		end
		mod:ScheduleMethod(0.2, "warnToxin")
	elseif args.spellId == 66869 then  -- ADD 10man Burning Bile ID
		self:UnscheduleMethod("warnBile")
		BileTargets[#BileTargets + 1] = args.destName
		if UnitName("player") == args.destName then
			specWarnBile:Show()
		end
		if mod.Options.SetIconOnBileTarget and burnIcon > 0 then
			mod:SetIcon(args.destName, burnIcon)
			burnIcon = burnIcon - 1
		end
		mod:ScheduleMethod(0.2, "warnBile")
	elseif args.spellId == 66758 then 
		timerStaggeredDaze:Start()
	end
end

function mod:warnToxin()
	warnToxin:Show(table.comcat(ToxinTargets, "<, >"))
	table.wipe(ToxinTargets)
end

function mod:warnBile()
	warnBile:Show(table.comcat(BileTargets, "<, >"))
	table.wipe(BileTargets)
	burnIcon = 8
end

function mod:SPELL_CAST_START(args)
--	if args.spellId == 66901 or args.spellId == 67615 then	-- seems to be hard buggy  >> unknown on unknown << xD what a message *G*
--		warnSpray:Show(args.spellName, args.destName)
-- 		todo: get target of spellcast
	if args.spellId == 66689 or args.spellId == 67650 then		
		timerBreath:Start()
		warnBreath:Show()
	elseif args.spellId == 66313 then							-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args.spellId == 66330 or args.spellId == 67647 then	-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg:match(L.Charge)
	if target then
		if target == UnitName("player") then
			specWarnCharge:Show()
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnChargeNear:Show()
				end
			end
		end
		if self.Options.SetIconOnChargeTarget then
			self:SetIcon(target, 8, 4)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if (args.spellId == 67477 or args.spellId == 66331) then
		timerNextImpale:Start()
		if args.amount >= 3 then 
			local name = GetSpellInfo(args.spellId)
			warnImpaleOn:Show(name, args.destName)
			if UnitName("player") == args.destName then
				specWarnImpale3:Show(args.amount)
			end
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 66320 or args.spellId == 66317 then
		if UnitName("player") == args.destName then
			specWarnFireBomb:Show()
		end
	elseif args.spellId == 66881 or args.spellId == 66883 then
		if args.destName == UnitName("player") then
			specWarnSlimePool:Show()
		end
	end
end

