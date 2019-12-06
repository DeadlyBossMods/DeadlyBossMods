local mod	= DBM:NewMod("MechagonTrash", "DBM-Party-BfA", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 300687 300764 300777 300650 300159 300177 300171 299588 300087 300188 300207 299475",
	"SPELL_CAST_SUCCESS 299525",
	"SPELL_AURA_APPLIED 300650 299588",
	"SPELL_AURA_APPLIED_DOSE 299438",
	"UNIT_DIED"
)

--TODO, no actual logs, just drycoded using IDs and probable events for spells given by below guide.
--TODO, target scan https://www.wowhead.com/spell=299525/scrap-grenade used by Pistonhead Blaster? Cast is a bit short so it's more iffy
--TODO, verify target scans on Scrap Cannon and B.O.R.K.
--https://www.wowhead.com/guides/operation-mechagon-megadungeon-strategy-guide
local warnExhaust					= mod:NewSpellAnnounce(300177, 2)--Heavy Scrapbot
local warnSledgehammer				= mod:NewStackAnnounce(299438, 2, nil, "Tank|Healer")--Pistonhead Scrapper
local warnScrapGrenade				= mod:NewSpellAnnounce(299525, 3)--Pistonhead Blaster (upgrade to specwarn/yell if target scan possible)

local specWarnShockCoil				= mod:NewSpecialWarningSpell(300207, nil, nil, nil, 2, 2)--Weaponized Crawler
local specWarnSlimewave				= mod:NewSpecialWarningDodge(300777, nil, nil, nil, 2, 2)--Slime Elemental
local specWarnScrapCannon			= mod:NewSpecialWarningDodge(300188, nil, nil, nil, 2, 2)--Weaponized Crawler
local yellScrapCannon				= mod:NewYell(300188)--Weaponized Crawler
local specWarnBORK					= mod:NewSpecialWarningDodge(299475, nil, nil, nil, 2, 2)--Scraphound
local yellBORK						= mod:NewYell(299475)--Scraphound
local specWarnConsume				= mod:NewSpecialWarningRun(300687, nil, nil, nil, 4, 2)--Toxic Monstrosity
local specWarnGyroScrap				= mod:NewSpecialWarningRun(300159, "Melee", nil, nil, 4, 2)--Heavy Scrapbot
local specWarnSlimeBolt				= mod:NewSpecialWarningInterrupt(300764, "HasInterrupt", nil, nil, 1, 2)--Slime Elemental
local specWarnSuffocatingSmog		= mod:NewSpecialWarningInterrupt(300650, "HasInterrupt", nil, nil, 1, 2)--Toxic Lurker
local specWarnRepairProtocol		= mod:NewSpecialWarningInterrupt(300171, "HasInterrupt", nil, nil, 1, 2)--Heavy Scrapbot
local specWarnOverclock				= mod:NewSpecialWarningInterrupt(299588, "HasInterrupt", nil, nil, 1, 2)--Pistonhead Mechanic
local specWarnRepair				= mod:NewSpecialWarningInterrupt(300087, "HasInterrupt", nil, nil, 1, 2)--Pistonhead Mechanic
local specWarnSuffocatingSmogDispel	= mod:NewSpecialWarningDispel(300650, "RemoveDisease", nil, nil, 1, 2)--Toxic Lurker
local specWarnOverclockDispel		= mod:NewSpecialWarningDispel(299588, "MagicDispeller", nil, nil, 1, 2)--Pistonhead Mechanic
--local specWarnRiotShield			= mod:NewSpecialWarningReflect(258317, "CasterDps", nil, nil, 1, 2)

local timerConsumeCD				= mod:NewCDTimer(20, 300687, nil, nil, nil, 2)--Toxic Monstrosity. 20 second based on guide, not actual log. might need fixing

function mod:Scraptarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 5) then
		yellScrapCannon:Yell()
	end
end

function mod:BORKtarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 5) then
		yellBORK:Yell()
	end
end

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 300687 and self:IsValidWarning(args.sourceGUID) then
		if self:AntiSpam(3, 1) then
			specWarnConsume:Show()
			specWarnConsume:Play("justrun")
		end
		timerConsumeCD:Start(20, args.sourceGUID)
	elseif spellId == 300159 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 1) then
		specWarnGyroScrap:Show()
		specWarnGyroScrap:Play("justrun")
	elseif spellId == 300777 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 2) then
		specWarnSlimewave:Show()
		specWarnSlimewave:Play("chargemove")
	elseif spellId == 300764 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSlimeBolt:Show(args.sourceName)
		specWarnSlimeBolt:Play("kickcast")
	elseif spellId == 300650 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSuffocatingSmog:Show(args.sourceName)
		specWarnSuffocatingSmog:Play("kickcast")
	elseif spellId == 300171 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRepairProtocol:Show(args.sourceName)
		specWarnRepairProtocol:Play("kickcast")
	elseif spellId == 299588 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnOverclock:Show(args.sourceName)
		specWarnOverclock:Play("kickcast")
	elseif spellId == 300087 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRepair:Show(args.sourceName)
		specWarnRepair:Play("kickcast")
	elseif spellId == 300177 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 6) then
		warnExhaust:Show()
	elseif spellId == 300188 and self:IsValidWarning(args.sourceGUID) then
		if self:AntiSpam(3, 2) then
			specWarnScrapCannon:Show()
			specWarnScrapCannon:Play("shockwave")
		end
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "Scraptarget", 0.1, 8)
	elseif spellId == 299475 and self:IsValidWarning(args.sourceGUID) then
		if self:AntiSpam(3, 2) then
			specWarnBORK:Show()
			specWarnBORK:Play("shockwave")
		end
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BORKtarget", 0.1, 8)
	elseif spellId == 300207 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 4) then
		specWarnShockCoil:Show()
		specWarnShockCoil:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 299525 and self:AntiSpam(3, 2) then
		warnScrapGrenade:Show()--SUCCESS, because this needs to be dodged when it hits ground, not when it's traveling toward a target that's moving
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 300650 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(5, 3) then
		specWarnSuffocatingSmogDispel:Show()
		specWarnSuffocatingSmogDispel:Play("helpdispel")
	elseif spellId == 299588 and not args:IsDestTypePlayer() and self:AntiSpam(3, 3) then
		specWarnOverclockDispel:Show(args.destName)
		specWarnOverclockDispel:Play("helpdispel")
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 299438 and args:IsDestTypePlayer() then
		local amount = args.amount or 1
		if (amount >= 3) and self:AntiSpam(3, 5) then
			warnSledgehammer:Show(args.destName, amount)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 154744 or cid == 154758 or cid == 150168 then--Toxic Monstrosity
		timerConsumeCD:Stop(args.destGUID)
	end
end
