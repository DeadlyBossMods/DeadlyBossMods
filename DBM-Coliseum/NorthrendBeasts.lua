local mod = DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetMinCombatTime(30)

-- 34816 npc to talk to
-- 34796 Gormok the Impaler
-- 34797 npc icehowl died

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_DIED"
)

local enrageTimer			= mod:NewEnrageTimer(210)		-- heroic 3:30 after Icehowl spawns

local timerBreath			= mod:NewCastTimer(5, 67650)
local timerNextStomp		= mod:NewNextTimer(20, 66330)
local timerNextImpale		= mod:NewNextTimer(10, 67477)
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758)
local timerNextBoss			= mod:NewTimer(160, "TimerNextBoss")
local timerNextCrash		= mod:NewCDTimer(55, 67662)

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
local specWarnToxin			= mod:NewSpecialWarning("SpecialWarningToxin")
local specWarnBile			= mod:NewSpecialWarning("SpecialWarningBile")
local specWarnSilence		= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge		= mod:NewSpecialWarning("SpecialWarningCharge")
local specWarnChargeNear	= mod:NewSpecialWarning("SpecialWarningChargeNear")

mod:AddBoolOption("SetIconOnChargeTarget", true, "announce")
mod:AddBoolOption("SetIconOnBileTarget", true, "announce")
mod:AddBoolOption("ClearIconsOnIceHowl", true, "announce")

--local warnSpray				= mod:NewAnnounce("WarningSpray", 2, 67616)
--local specWarnSpray			= mod:NewSpecialWarning("SpecialWarningSpray")

local BileTargets = {}
local ToxinTargets = {}
local burnIcon = 8

function mod:OnCombatStart(delay)
	table.wipe(BileTargets)
	table.wipe(ToxinTargets)
	burnIcon = 8
	specWarnSilence:Schedule(37-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerNextBoss:Start(-delay)
		timerNextBoss:Schedule(150)
	end
	timerNextStomp:Start(38-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then					-- Impale
		timerNextImpale:Start()
	elseif args:IsSpellID(67657, 66759, 67658, 67659) then				-- Frothing Rage
		warnRage:Show()
	elseif args:IsSpellID(66823, 67618, 67619, 67620) then				-- Paralytic Toxin
		self:UnscheduleMethod("warnToxin")
		ToxinTargets[#ToxinTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnToxin:Show()
		end
		mod:ScheduleMethod(0.2, "warnToxin")
	elseif args:IsSpellID(66869, 66870, 67621, 67622, 67623) then		-- Burning Bile
		self:UnscheduleMethod("warnBile")
		BileTargets[#BileTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBile:Show()
		end
		if mod.Options.SetIconOnBileTarget and burnIcon > 0 then
			mod:SetIcon(args.destName, burnIcon)
			burnIcon = burnIcon - 1
		end
		mod:ScheduleMethod(0.2, "warnBile")
	elseif args:IsSpellID(66758) then 
		timerStaggeredDaze:Start()
	end
end

function mod:warnToxin()
	warnToxin:Show(table.concat(ToxinTargets, "<, >"))
	table.wipe(ToxinTargets)
end

function mod:warnBile()
	warnBile:Show(table.concat(BileTargets, "<, >"))
	table.wipe(BileTargets)
	burnIcon = 8
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34796 then
		specWarnSilence:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66689, 67650, 67651, 67652) then		-- Arctic Breath
		timerBreath:Start()
		warnBreath:Show()
	elseif args:IsSpellID(66313) then						-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args:IsSpellID(66330, 67647, 67648, 67649) then	-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)						-- prewarn ~1,5 sec before next
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg:match(L.Charge)
	if target then
		timerNextCrash:Start()
		if self.Options.ClearIconsOnIceHowl then
			self:ClearIcons()
		end
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
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then		-- Impale
		timerNextImpale:Start()
		local name = GetSpellInfo(args.spellId)
		warnImpaleOn:Show(name, args.destName)
		if (args.amount >= 3 and not self:IsDifficulty("heroic10", "heroic25") ) or ( args.amount >= 2 and self:IsDifficulty("heroic10", "heroic25") ) then 
			if args:IsPlayer() then
				specWarnImpale3:Show(args.amount)
			end
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(66320, 66317, 67472) and args:IsPlayer() then				-- Fire Bomb
		specWarnFireBomb:Show()
	elseif args:IsSpellID(66881, 66883) and args:IsPlayer() then				-- Slime Pool
		specWarnSlimePool:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase3 then
		if self:IsDifficulty("heroic10", "heroic25") then
			enrageTimer:Start()
		end
		timerNextCrash:Start(45)
	end
end

