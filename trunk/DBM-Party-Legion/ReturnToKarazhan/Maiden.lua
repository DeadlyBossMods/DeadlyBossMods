local mod	= DBM:NewMod(1825, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(113971)
mod:SetEncounterID(1954)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227800 227508 227823",
	"SPELL_AURA_APPLIED 227817",
	"SPELL_AURA_REMOVED 227817",
	"SPELL_INTERRUPT"
)

local warnHolyWrath					= mod:NewCastAnnounce(227823, 4)

local specWarnHolyShock				= mod:NewSpecialWarningInterrupt(227800, "HasInterrupt", nil, nil, 1, 2)
local specWarnRepentance			= mod:NewSpecialWarningMoveTo(227508, nil, nil, nil, 1, 2)
local specWarnHolyWrath				= mod:NewSpecialWarningInterrupt(227823, "HasInterrupt", nil, nil, 1, 2)

local timerHolyShockCD				= mod:NewAITimer(40, 227800, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerRepentanceCD				= mod:NewAITimer(40, 227508, nil, nil, nil, 3)
local timerHolyWrath				= mod:NewCastTimer(10, 227823, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

local countdownHolyWrath			= mod:NewCountdown(10, 227823)

local voiceHolyShock				= mod:NewVoice(227800, "HasInterrupt")--kickcast
local voiceHolyWrath				= mod:NewVoice(227823, "HasInterrupt")--kickcast

mod:AddRangeFrameOption(8, 227809)--TODO, keep looking for a VALID 6 yard item/spell
mod:AddBoolOption("HealthFrame", true)

function mod:OnCombatStart(delay)
	timerHolyShockCD:Start(1-delay)
	timerRepentanceCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)--Will open to 6 when supported, else 8
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227800 then
		timerHolyShockCD:Start()
		specWarnHolyShock:Show(args.sourceName)
		voiceHolyShock:Play("kickcast")
	elseif spellId == 227508 then
		specWarnRepentance:Show(GetSpellInfo(227789))
		timerRepentanceCD:Start()
	elseif spellId == 227823 then
		warnHolyWrath:Show()
		timerHolyWrath:Start()
		countdownHolyWrath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227817 and DBM.BossHealth:IsShown() then
		self:ShowShieldHealthBar(args.destGUID, args.spellName, 4680000)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227817 then
		self:RemoveShieldHealthBar(args.destGUID)
		if UnitCastingInfo("boss1") then
			specWarnHolyWrath:Show(L.name)
			voiceHolyWrath:Play("kickcast")
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 227823 then
		timerHolyWrath:Stop()
		countdownHolyWrath:Cancel()
	end
end
