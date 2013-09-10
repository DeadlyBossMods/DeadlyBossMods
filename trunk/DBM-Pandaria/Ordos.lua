local mod	= DBM:NewMod(861, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72057)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--[[
mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)--]]

local warnAncientFlame			= mod:NewSpellAnnounce(144695, 2)--probably add a move warning with right DAMAGE event
local warnBurningSoul			= mod:NewTargetAnnounce(144689, 3)
local warnEternalAgony			= mod:NewSpellAnnounce(144696, 4)

local specWarnBurningSoul		= mod:NewSpecialWarningYou(144689)
local yellBurningSoul			= mod:NewYell(144689)
local specWarnPoolOfFire		= mod:NewSpecialWarningMove(144693)
local specWarnEternalAgony		= mod:NewSpecialWarningSpell(144696, nil, nil, nil, 2)--Fights over, this is 5 minute berserk spell.

--local timerAncientFlameCD		= mod:NewCDTimer(25, 144695)
local timerBurningSoul			= mod:NewTargetTimer(10, 144689)
--local timerBurningSoulCD		= mod:NewCDTimer(26, 144689)

--local berserkTimer				= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnBurningSoul", true)
mod:AddBoolOption("RangeFrame", true)

--local yellTriggered = false

function mod:OnCombatStart(delay)
--[[	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerPiercingRoarCD:Start(20-delay)
		timerFrillBlastCD:Start(40-delay)
		berserkTimer:Start(-delay)
	end--]]
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	yellTriggered = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144696 then
		warnEternalAgony:Show()
		specWarnEternalAgony:Show()
	elseif args.spellId == 144695 then
		warnAncientFlame:Show()
--		timerAncientFlameCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144689 then
		warnBurningSoul:Show(args.destName)
		timerBurningSoul:Start(args.destName)
--		timerBurningSoulCD:Start()
		if args:IsPlayer() then
			specWarnBurningSoul:Show()
			yellBurningSoul:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconOnBurningSoul then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 144693 then
		specWarnPoolOfFire:Show()--maybe add DAMAGE event too if it feels like this isn't enough
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144689 then
		timerBurningSoul:Cancel(args.destName)
		if self.Options.SetIconOnBurningSoul then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 72057 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 72057 then
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end
--]]
