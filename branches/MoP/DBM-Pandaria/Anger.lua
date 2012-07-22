local mod	= DBM:NewMod(691, "DBM-Pandaria", nil, 322)	-- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60491)
mod:SetModelID(41448)
mod:SetZone(809)--Kun-Lai Summit (zoneid not yet known)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnUnleashedWrath		= mod:NewSpellAnnounce(119488, 3)--Big aoe damage aura when at 100 rage
local warnGrowingAnger			= mod:NewTargetAnnounce(119622, 4)--Mind control trigger
local warnAggressiveBehavior	= mod:NewTargetAnnounce(119626, 4)--Actual mind control targets

local specWarnUnleashedWrath	= mod:NewSpecialWarningSpell(119488, mod:IsTank() or mod:IsHealer())--Defaults to tank and healers cause tank probalby want to Cd through this and healers have to heal it, dps just do what they always do and kill stuff.
local specWarnGrowingAnger		= mod:NewSpecialWarningYou(119622)

local timerGrowingAngerCD		= mod:NewCDTimer(33, 119622)--Not enough data, as majority of log was boss fighting immune NPCS. it may be 45sec but 33sec while berserked (don't ask, pretty bugged log i have heh)
local timerUnleashedWrathCD		= mod:NewCDTimer(50, 119488)--Based on rage, but timing is consistent enough to use a CD bar, might require some perfecting later, similar to xariona's special, if rage doesn't reset after wipes, etc.
local timerUnleashedWrath		= mod:NewBuffActiveTimer(28, 119488, nil, mod:IsTank() or mod:IsHealer())

local berserkTimer				= mod:NewBerserkTimer(900)--at least 13 min, speculate 15 but can also be 13 or 14min

mod:AddBoolOption("RangeFrame", true)--For Mind control spreading.
mod:AddBoolOption("SetIconOnMC", true)

local warnpreMCTargets = {}
local warnMCTargets = {}
local mcIcon = 8

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, GetSpellInfo(119622))
	end
end

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", GetSpellInfo(119622)) then
		DBM.RangeCheck:Show(5, nil)--Show everyone.
	else
		DBM.RangeCheck:Show(5, debuffFilter)--Show only people who have debuff.
	end
end

local function showpreMC()
	mod:updateRangeFrame()
	warnGrowingAnger:Show(table.concat(warnpreMCTargets, "<, >"))
	table.wipe(warnpreMCTargets)
	mcIcon = 8
end

local function showMC()
	warnAggressiveBehavior:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(warnpreMCTargets)
	table.wipe(warnMCTargets)
	mcIcon = 8
--	timerUnleashedWrathCD:Start(-delay)
--	timerGrowingAngerCD:Start(-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119488) then
		warnUnleashedWrath:Show()
		specWarnUnleashedWrath:Show()
		timerUnleashedWrath:Start()
	elseif args:IsSpellID(119622) then
		timerGrowingAngerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119622) then
		warnpreMCTargets[#warnpreMCTargets + 1] = args.destName
		if self.Options.SetIconOnMC then--Set icons on first debuff to get an earlier spread out.
			self:SetIcon(args.destName, mcIcon)
			mcIcon = mcIcon - 1
		end
		if args:IsPlayer() then
			specWarnGrowingAnger:Show()			
		end
		self:Unschedule(showpreMC)
		if #warnpreMCTargets >= 3 then
			showpreMC()
		else
			self:Schedule(1.0, showpreMC)
		end
	elseif args:IsSpellID(119626) then
		--Maybe add in function to update icons here in case of a spread that results in more then the original 3 getting the final MC debuff.
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMC)
		self:Schedule(2.5, showMC)--These can be vastly spread out, not even need to use 3, depends on what more data says. As well as spread failures.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(119626) and self.Options.SetIconOnMC then--Remove them after the MCs break.
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(119488) then
		timerUnleashedWrathCD:Start()
	end
end
