local mod	= DBM:NewMod(857, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71953)
--mod:SetQuestID(32519)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnInspiringSong			= mod:NewSpellAnnounce(144468, 3)
local warnBeaconOfHope			= mod:NewTargetAnnounce(144473, 1)
local warnBlazingSong			= mod:NewSpellAnnounce(144471, 4)
local warnCraneRush				= mod:NewSpellAnnounce(144470, 3)--Health based, 66% and 33% (maybe register UNIT_HEALTH and give soon warning?)

local specWarnInspiringSong		= mod:NewSpecialWarningInterrupt(144468)
local specWarnBeaconOfHope		= mod:NewSpecialWarningYou(144473)
local yellBeaconOfHope			= mod:NewYell(144473)
local specWarnBeaconOfHopeOther	= mod:NewSpecialWarningTarget(144473)
local specWarnBlazingSong		= mod:NewSpecialWarningSpell(144471, nil, nil, nil, 3)
local specWarnCraneRush			= mod:NewSpecialWarningSpell(144470, nil, nil, nil, 2)--Add range frame for spreading?

--local timerInspiringSongCD	= mod:NewCDTimer(26, 144468)
--local timerBeaconOfhopeCD		= mod:NewCDTimer(25, 144473)
local timerBlazingSong			= mod:NewCastTimer(5, 144471)--Possibly redundant, if it's always after beacon of hope

mod:AddBoolOption("SetIconOnBeacon", true)
mod:AddBoolOption("BeaconArrow")

--local yellTriggered = false

function mod:OnCombatStart(delay)
--[[	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerInspiringSongCD:Start(15-delay)
		timerBeaconOfhopeCD:Start(20-delay)
		timerBlazingSongCD:Start(40-delay)
	end-]]
end

function mod:OnCombatEnd()
--	yellTriggered = false
	if self.Options.BeaconArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144468 then
		warnInspiringSong:Show()
		specWarnInspiringSong:Show()
--		timerInspiringSongCD:Start()
	elseif args.spellId == 144471 then
		warnBlazingSong:Show()
		specWarnBlazingSong:Show()
		timerBlazingSong:Start()
	elseif args.spellId == 144470 then
		warnCraneRush:Show()
		specWarnCraneRush:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144473 then
		warnBeaconOfHope:Show(args.destName)
--		timerBeaconOfhopeCD:Start()
		if args:IsPlayer() then
			specWarnBeaconOfHope:Show()
			yellBeaconOfHope:Yell()
		else
			specWarnBeaconOfHopeOther:Show(args.destName)
			if self.Options.BeaconArrow then
				DBM.Arrow:ShowRunTo(args.destName, 3, 3, 5)
			end
		end
		if self.Options.SetIconOnBeacon then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144473 and self.Options.SetIconOnBeacon then
		self:SetIcon(args.destName, 0)
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 71953 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 71953 then--Whole zone gets yell, so lets not engage combat off yell unless he is our target (or the target of our target for healers)
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end--]]

