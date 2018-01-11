local mod	= DBM:NewMod("EmeraldNightmareTrash", "DBM-EmeraldNightmare")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START 222719",
	"SPELL_AURA_APPLIED 221028 222719 223946",
	"SPELL_AURA_REMOVED 221028 222719"
)

local warnUnstableDecay				= mod:NewTargetAnnounce(221028, 3)

local specWarnUnstableDecay			= mod:NewSpecialWarningMoveAway(221028, nil, nil, nil, 1, 2)
local yellUnstableDecay				= mod:NewYell(221028)
local specWarnBefoulment			= mod:NewSpecialWarningMoveTo(222719, nil, nil, nil, 1, 2)
local yellBefoulment				= mod:NewFadesYell(222719)
local specWarnDarkLightning			= mod:NewSpecialWarningMove(223946, nil, nil, nil, 1, 2)

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(10, 221028)

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221028 then
		warnUnstableDecay:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnUnstableDecay:Show()
			specWarnUnstableDecay:Play("runout")
			yellUnstableDecay:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	--"<40.43 21:42:49> [CLEU] SPELL_AURA_APPLIED#Creature-0-3779-1520-17549-111354-000061CEF4#Taintheart Befouler#Player-3693-08EE23F3#Chiivesdh#222719#Befoulment#DEBUFF#nil", -- [914]
	elseif spellId == 222719 then
		specWarnBefoulment:Show(args.destName)
		specWarnBefoulment:Play("gathershare")
		if args:IsPlayer() then
			yellBefoulment:Yell(15)
			yellBefoulment:Countdown(15)
		end
	elseif spellId == 223946 and args:IsPlayer() then--No damage events for trash mod, this should be enough
		specWarnDarkLightning:Show()
		specWarnDarkLightning:Play("runaway")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221028 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 222719 and args:IsPlayer() then
		yellBefoulment:Cancel()
	end
end
