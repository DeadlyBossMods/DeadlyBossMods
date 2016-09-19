local mod	= DBM:NewMod(1498, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98205)
mod:SetEncounterID(1825)
mod:SetZone()
mod:SetUsedIcons(1)

mod.onlyMythic = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 196068 195804",
	"SPELL_AURA_REMOVED 195804",
	"SPELL_CAST_START 196070 196115",
	"SPELL_CAST_SUCCESS 195791"
)

local warnSupression				= mod:NewTargetAnnounce(196070, 4)
local warnQuarantine				= mod:NewTargetAnnounce(195804, 3)

local specWarnSupression			= mod:NewSpecialWarningRun(196070, nil, nil, nil, 4, 2)
local yellSupression				= mod:NewYell(196070)
local specWarnQuarantine			= mod:NewSpecialWarningTarget(195804, false, nil, nil, 1, 2)
local yellQuarantine				= mod:NewYell(195804)
local specWarnCleansing				= mod:NewSpecialWarningSpell(196115, nil, nil, nil, 2, 2)

local timerSupressionCD				= mod:NewNextTimer(46, 196070, nil, nil, nil, 3)
local timerQuarantineCD				= mod:NewNextTimer(46, 195804, nil, nil, nil, 3)
local timerCleansingCD				= mod:NewNextTimer(46, 196115, nil, nil, nil, 2)

local voiceSupression				= mod:NewVoice(196070)--runout/keeprun
local voiceQuarantine				= mod:NewVoice(195804)--readyrescue
local voiceCleansing				= mod:NewVoice(196115)--aesoon

mod:AddSetIconOption("SetIconOnQuarantine", 195791)

function mod:OnCombatStart(delay)
	timerSupressionCD:Start(5-delay)
	timerQuarantineCD:Start(22.5-delay)
	timerCleansingCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196068 then
		warnSupression:Show(args.destName)
		if args:IsPlayer() then
			specWarnSupression:Show()
			voiceSupression:Play("runout")
			voiceSupression:Schedule(1, "keeprun")
			yellSupression:Yell()
		end
	elseif spellId == 195804 then
		if self.Options.SpecWarn196115target then
			specWarnQuarantine:Show(args.destName)
			voiceQuarantine:Play("readyrescue")
		else
			warnQuarantine:Show(args.destName)
		end
		if args:IsPlayer() then
			yellQuarantine:Yell()
		end
		if self.Options.SetIconOnQuarantine then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 195804 and self.Options.SetIconOnQuarantine then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196070 then
		timerSupressionCD:Start()
	elseif spellId == 196115 then
		specWarnCleansing:Show()
		voiceCleansing:Play("aesoon")
		timerCleansingCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 195791 then
		timerQuarantineCD:Start()
	end
end
