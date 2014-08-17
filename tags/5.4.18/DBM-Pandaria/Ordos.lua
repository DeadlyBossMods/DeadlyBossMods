local mod	= DBM:NewMod(861, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72057)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(10466)
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144696 144688 144695",
	"SPELL_AURA_APPLIED 144689 144693",
	"SPELL_AURA_REMOVED 144689"
)

local warnAncientFlame			= mod:NewSpellAnnounce(144695, 2)--probably add a move warning with right DAMAGE event
local warnMagmaCrush			= mod:NewSpellAnnounce(144688, 3)
local warnBurningSoul			= mod:NewTargetAnnounce(144689, 3)
local warnEternalAgony			= mod:NewSpellAnnounce(144696, 4)

local specWarnBurningSoul		= mod:NewSpecialWarningMoveAway(144689)
local yellBurningSoul			= mod:NewYell(144689)
local specWarnPoolOfFire		= mod:NewSpecialWarningMove(144693)
local specWarnEternalAgony		= mod:NewSpecialWarningSpell(144696, nil, nil, nil, 2)--Fights over, this is 5 minute berserk spell.

--local timerAncientFlameCD		= mod:NewCDTimer(43, 144695)--Insufficent logs
--local timerBurningSoulCD		= mod:NewCDTimer(22, 144689)--22-30 sec variation (maybe larger, small sample size)
local timerBurningSoul			= mod:NewBuffFadesTimer(10, 144689)

local berserkTimer				= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnBurningSoul")
mod:AddBoolOption("RangeFrame", true)
mod:AddReadyCheckOption(33118, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		if self:IsInCombat() then
			berserkTimer:Cancel()--In case repulled before last pulls EndCombat Could fire
		end
		berserkTimer:Start()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144696 then
		warnEternalAgony:Show()
		specWarnEternalAgony:Show()
	elseif spellId == 144688 then
		warnMagmaCrush:Show()
	elseif spellId == 144695 then
		warnAncientFlame:Show()
--		timerAncientFlameCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144689 then
		warnBurningSoul:CombinedShow(1.2, args.destName)
		timerBurningSoul:Start()
--		timerBurningSoulCD:Start()
		if args:IsPlayer() then
			specWarnBurningSoul:Show()
			specWarnBurningSoul:Schedule(2)
			specWarnBurningSoul:Schedule(4)
			specWarnBurningSoul:Schedule(6)
			yellBurningSoul:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconOnBurningSoul then--Set icons on first debuff to get an earlier spread out.
			self:SetSortedIcon(1.2, args.destName, 8, 3, true)
		end
	elseif spellId == 144693 and args:IsPlayer() then
		specWarnPoolOfFire:Show()--One warning is enough, because it honestly isn't worth moving for unless blizz buffs it.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 144689 then
		if self.Options.SetIconOnBurningSoul then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
