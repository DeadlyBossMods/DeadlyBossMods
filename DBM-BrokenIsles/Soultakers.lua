if DBM:GetTOC() < 70000 then return end
local mod	= DBM:NewMod(1756, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106981, 106984, 106982)--Captain Hring, Soultrapper Mevra, Reaver Jdorn
mod:SetEncounterID(1879)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 187466",
	"SPELL_AURA_APPLIED 187668",
	"SPELL_AURA_REMOVED 187668"
	"UNIT_DIED"
)

local warnMark						= mod:NewTargetAnnounce(187668, 2)

local specWarnDoom					= mod:NewSpecialWarningSpell(187466, nil, nil, nil, 2)
local specWarnMark					= mod:NewSpecialWarningYou(187668)
local yellMark						= mod:NewYell(187668)

local timerDoomD					= mod:NewCDTimer(51, 187466, nil, nil, nil, 3)
local timerBreathCD					= mod:NewCDTimer(22, 187664, nil, nil, nil, 5)

--mod:AddReadyCheckOption(37462, false)--Unknown quest flag
mod:AddRangeFrameOption(8, 187668)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 187466 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 187668 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 187668 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 106981 then--Captain Hring

	elseif cid == 106984 then--Soultrapper Mevra

	elseif cid == 106982 then--Reaver Jdorn

	end
end
--]]
