local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37813)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFrenzySoon		= mod:NewAnnounce("warnFrenzySoon", 2, 72737, mod:IsTank() or mod:IsHealer())
local warnAddsSoon			= mod:NewPreWarnAnnounce(72173, 10, 3)
local warnFrenzy			= mod:NewSpellAnnounce(72737, 2, nil, mod:IsTank() or mod:IsHealer())
local warnBloodNova			= mod:NewSpellAnnounce(73058, 2)
local warnMark				= mod:NewTargetAnnounce(72444, 4)
local warnBoilingBlood		= mod:NewTargetAnnounce(72441, 2, nil, mod:IsHealer())
local warnRuneofBlood		= mod:NewTargetAnnounce(72410, 3, nil, mod:IsTank() or mod:IsHealer())

local specwarnMark			= mod:NewSpecialWarningTarget(72444, false)
local specwarnRuneofBlood	= mod:NewSpecialWarningTarget(72410, mod:IsTank())

local timerCombatStart		= mod:NewTimer(48, "TimerCombatStart", 2457)
local timerRuneofBlood		= mod:NewTargetTimer(20, 72410, nil, mod:IsTank() or mod:IsHealer())
local timerBoilingBlood		= mod:NewBuffActiveTimer(15, 72441)
local timerBloodNova		= mod:NewCDTimer(20, 73058)--20-25sec cooldown?
local timerCallBloodBeast	= mod:NewNextTimer(40, 72173)

local enrageTimer			= mod:NewBerserkTimer(480)

mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("RunePowerFrame", true, "misc")
mod:AddBoolOption("BeastIcons", true)
mod:AddBoolOption("BoilingBloodIcons", false)
mod:RemoveOption("HealthFrame")

local warned_preFrenzy = false
local boilingBloodTargets = {}
local boilingBloodIcon 	= 8
local spamBloodBeast = 0

local function warnBoilingBloodTargets()
	warnBoilingBlood:Show(table.concat(boilingBloodTargets, "<, >"))
	table.wipe(boilingBloodTargets)
	timerBoilingBlood:Start()
	boilingBloodIcon = 8
end

function mod:OnCombatStart(delay)
	if self.Options.RunePowerFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(37813, L.name)
		self:ScheduleMethod(0.5, "CreateBossRPFrame")
	end
	timerCallBloodBeast:Start(-delay)
	warnAddsSoon:Schedule(30-delay)
	timerBloodNova:Start(-delay)
	if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
		enrageTimer:Start(-delay)
	else
		enrageTimer:Start(360-delay)
	end
	table.wipe(boilingBloodTargets)
	warned_preFrenzy = false
	boilingBloodIcon = 8
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	DBM.BossHealth:Clear()
end

do	-- add the additional Rune Power Bar
	local last = 0
	local function getRunePowerPercent()
		local guid = UnitGUID("focus")
		if mod:GetCIDFromGUID(guid) == 37813 then 
			last = math.floor(UnitPower("focus")/UnitPowerMax("focus") * 100)
			return last
		end
		for i = 0, GetNumRaidMembers(), 1 do
			local unitId = ((i == 0) and "target") or "raid"..i.."target"
			local guid = UnitGUID(unitId)
			if mod:GetCIDFromGUID(guid) == 37813 then
				last = math.floor(UnitPower(unitId)/UnitPowerMax(unitId) * 100)
				return last
			end
		end
		return last
	end
	function mod:CreateBossRPFrame()
		DBM.BossHealth:AddBoss(getRunePowerPercent, L.RunePower)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(73058, 72378) then	-- Blood Nova (only 2 cast IDs, 4 spell damage IDs, and one dummy)
		warnBloodNova:Show()
		timerBloodNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72410) then
		warnRuneofBlood:Show(args.destName)
		specwarnRuneofBlood:Show(args.destName)
	end
end

do
	local beastIcon = {}
	local currentIcon = 1
	local iconsSet = 0
	local function resetBeastIconState()
		table.wipe(beastIcon)
		currentIcon = 1
		iconsSet = 0
	end
	
	local lastBeast = 0
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(72172, 72173) or args:IsSpellID(72356, 72357, 72358) then -- Summon Blood Beasts
			if time() - lastBeast > 5 then
				warnAddsSoon:Schedule(30)
				timerCallBloodBeast:Start()
				lastBeast = time()
				if self.Options.BeastIcons then
					resetBeastIconState()
				end
			end
			if self.Options.BeastIcons then
				beastIcon[args.destGUID] = currentIcon
				currentIcon = currentIcon + 1
			end
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if self.Options.BeastIcons and (DBM:GetRaidRank() > 0 and not (iconsSet == 5 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 2 and self:IsDifficulty("normal10", "heroic10"))) then
			for i = 1, GetNumRaidMembers() do
				local uId = "raid"..i.."target"
				local guid = UnitGUID(uId)
				if beastIcon[guid] then
					SetRaidTarget(uId, beastIcon[guid])
					iconsSet = iconsSet + 1
					beastIcon[guid] = nil
				end
			end
		end
	end, 1)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72293) then		-- Mark of the Fallen Champion
		warnMark:Show(args.destName)
		specwarnMark:Show(args.destName)
	elseif args:IsSpellID(72385, 72441, 72442, 72443) then	-- Boiling Blood
		boilingBloodTargets[#boilingBloodTargets + 1] = args.destName
		if self.Options.BoilingBloodIcons then
			self:SetIcon(args.destName, boilingBloodIcon, 15)
			boilingBloodIcon = boilingBloodIcon - 1
		end
		self:Unschedule(warnBoilingBloodTargets)
		if mod:IsDifficulty("normal10") or (mod:IsDifficulty("normal25") and #boilingBloodTargets >= 3) then	-- Boiling Blood
			warnBoilingBloodTargets()
		else
			self:Schedule(0.3, warnBoilingBloodTargets)
		end
	elseif args:IsSpellID(72410) then						-- Rune of Blood
		timerRuneofBlood:Start(args.destName)
	elseif args:IsSpellID(72737) then						-- Frenzy
		warnFrenzy:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72385, 72441, 72442, 72443) then
		self:SetIcon(args.destName, 0)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preFrenzy and self:GetUnitCreatureId(uId) == 37813 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.33 then
		warned_preFrenzy = true
		warnFrenzySoon:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance, 1, true) then
		timerCombatStart:Start()
	elseif msg:find(L.PullHorde, 1, true) then
		timerCombatStart:Start(99)
	end
end