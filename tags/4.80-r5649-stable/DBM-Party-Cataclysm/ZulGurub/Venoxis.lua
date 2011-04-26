local mod	= DBM:NewMod("Venoxis", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52155)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnWordHethiss		= mod:NewSpellAnnounce(96560, 2)
local warnWhisperHethiss	= mod:NewTargetAnnounce(96466, 3)
local warnBreathHethiss		= mod:NewSpellAnnounce(96509, 3)
local warnToxicLinkCast		= mod:NewCastAnnounce(96477, 2, nil, nil, false)
local warnToxicLink			= mod:NewTargetAnnounce(96477, 4)
local warnBlessing			= mod:NewSpellAnnounce(97354, 3)
local warnBloodvenom		= mod:NewSpellAnnounce(96842, 3)

local timerWhisperHethiss	= mod:NewTargetTimer(8, 96466)
local timerBreathHethiss	= mod:NewNextTimer(12, 96509)

local specWarnToxicLink		= mod:NewSpecialWarningYou(96477)
local specWarnBloodvenom	= mod:NewSpecialWarningSpell(96842)

mod:AddBoolOption("SetIconOnToxicLink")

local toxicLinkIcon = 8
local toxicLinkTargets = {}

local function warnToxicLinkTargets()
	warnToxicLink:Show(table.concat(toxicLinkTargets, "<, >"))
	table.wipe(toxicLinkTargets)
	toxicLinkIcon = 8	
end

function mod:OnCombatStart(delay)
	toxicLinkIcon = 8
	table.wipe(toxicLinkTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96477) then
		toxicLinkTargets[#toxicLinkTargets + 1] = args.destName
		toxicLinkIcon = toxicLinkIcon - 1
		self:Unschedule(warnToxicLinkTargets)
		self:Schedule(0.2, warnToxicLinkTargets)
		if args:IsPlayer() then
			specWarnToxicLink:Show()
		end
		if mod.Options.SetIconOnToxicLink then
			self:SetIcon(args.destName, toxicLinkIcon, 10)
		end
	elseif args:IsSpellID(96509) then
		warnBreathHethiss:Show()
		timerBreathHethiss:Start()
	elseif args:IsSpellID(97354) then
		warnBlessing:Show()
	elseif args:IsSpellID(96466) and args:IsDestTypePlayer() then
		warnWhisperHethiss:Show(args.destName)
		timerWhisperHethiss:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(96466) then
		timerWhisperHethiss:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96477) then
		warnToxicLinkCast:Show()
	elseif args:IsSpellID(96842) then
		warnBloodvenom:Show()
		specWarnBloodvenom:Show()
	end
end