local mod	= DBM:NewMod(1452, "DBM-Draenor", nil, 557)--Not yet in journal, needs journalID in whatever build they add his ID in
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(94015)
mod:SetEncounterID(1801)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat")--no yell

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 187466",
	"SPELL_AURA_APPLIED 187668",
	"SPELL_AURA_REMOVED 187668"
)

local warnMark						= mod:NewTargetAnnounce(187668, 2)

local specWarnDoom					= mod:NewSpecialWarningSpell(187466, nil, nil, nil, 2)
local specWarnMark					= mod:NewSpecialWarningYou(187668)
local yellMark						= mod:NewYell(187668)

local timerDoomD					= mod:NewCDTimer(52, 187466, nil, nil, nil, 3)

--mod:AddReadyCheckOption(37462, false)
mod:AddRangeFrameOption(8, 187668)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then
		--timerDoomD:Start()
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 187466 then
		specWarnDoom:Show()
		timerDoomD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 187668 then
		warnMark:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMark:Show()
			yellMark:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 187668 then
		warnMark:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMark:Show()
			yellMark:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end
