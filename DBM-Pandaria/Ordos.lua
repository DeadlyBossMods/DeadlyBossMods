local mod	= DBM:NewMod(861, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72057)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnAncientFlame			= mod:NewSpellAnnounce(144695, 2)--probably add a move warning with right DAMAGE event
local warnBurningSoul			= mod:NewTargetAnnounce(144689, 3)
local warnEternalAgony			= mod:NewSpellAnnounce(144696, 4)

local specWarnBurningSoul		= mod:NewSpecialWarningYou(144689)
local yellBurningSoul			= mod:NewYell(144689)
local specWarnPoolOfFire		= mod:NewSpecialWarningMove(144693)
local specWarnEternalAgony		= mod:NewSpecialWarningSpell(144696, nil, nil, nil, 2)--Fights over, this is 5 minute berserk spell.

--local timerAncientFlameCD		= mod:NewCDTimer(43, 144695)--Insufficent logs
--local timerBurningSoulCD		= mod:NewCDTimer(22, 144689)--22-30 sec variation (maybe larger, small sample size)w

local berserkTimer				= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnBurningSoul")
mod:AddBoolOption("RangeFrame", true)

local yellTriggered = false
local DebuffTargets = {}
local DebuffIcons = {}
local DebuffIcon = 8

local function warnDebuffTargets()
	warnBurningSoul:Show(table.concat(DebuffTargets, "<, >"))
	table.wipe(DebuffTargets)
	DebuffIcon = 8
end

do
	local function sortByGroup(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetIcons()
		table.sort(DebuffIcons, sortByGroup)
		for i, v in ipairs(DebuffIcons) do
			self:SetIcon(v, DebuffIcon)
			DebuffIcon = DebuffIcon - 1
		end
		table.wipe(DebuffIcons)
	end
end

function mod:OnCombatStart(delay)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		berserkTimer:Start()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	yellTriggered = false
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
		DebuffTargets[#DebuffTargets + 1] = args.destName
--		timerBurningSoulCD:Start()
		if args:IsPlayer() then
			specWarnBurningSoul:Show()
			yellBurningSoul:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconOnBurningSoul then--Set icons on first debuff to get an earlier spread out.
			local targetUnitID = DBM:GetRaidUnitId(args.destName)
			--Added to fix a bug with duplicate entries of same person in icon table more than once
			local foundDuplicate = false
			for i = #DebuffIcons, 1, -1 do
				if DebuffIcons[i].targetUnitID then--make sure they aren't in table before inserting into table again. (not sure why this happens in LFR but it does, probably someone really high ping that cranked latency check way up)
					foundDuplicate = true
				end
			end
			if not foundDuplicate then
				table.insert(DebuffIcons, targetUnitID)
			end
			self:UnscheduleMethod("SetIcons")
			if self:LatencyCheck() then
				self:ScheduleMethod(1.2, "SetIcons")
			end
		end
		self:Unschedule(warnDebuffTargets)
		if #DebuffTargets >= 3 then
			warnDebuffTargets()
		else
			self:Schedule(1.2, warnDebuffTargets)
		end
	elseif args.spellId == 144693 and args:IsPlayer() then
		specWarnPoolOfFire:Show()--One warning is enough, because it honestly isn't worth moving for unless blizz buffs it.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144689 then
		if self.Options.SetIconOnBurningSoul then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 72057 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 72057 then
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end
