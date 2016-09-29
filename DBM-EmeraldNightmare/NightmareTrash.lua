local mod	= DBM:NewMod("EmeraldNightmareTrash", "DBM-EmeraldNightmare")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START 222719",
	"SPELL_AURA_APPLIED 221028 222719",
	"SPELL_AURA_REMOVED 221028 222719"
)

local warnUnstableDecay				= mod:NewTargetAnnounce(221028, 3)

local specWarnUnstableDecay			= mod:NewSpecialWarningMoveAway(221028, nil, nil, nil, 1, 2)
local yellUnstableDecay				= mod:NewYell(221028)
local specWarnBefoulment			= mod:NewSpecialWarningMoveTo(222719, nil, nil, nil, 1, 2)
local yellBefoulment				= mod:NewFadesYell(221028)

local voiceUnstableDecay			= mod:NewVoice(221028)--runout
local voiceBefoulment				= mod:NewVoice(222719)--gathershare

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(10, 221028)

--"<10.06 21:42:19> [CLEU] SPELL_CAST_START#Creature-0-3779-1520-17549-111354-0000E1CEF5#Taintheart Befouler##nil#222719#Befoulment#nil#nil", -- [280]
--"<10.67 21:42:19> [UNIT_SPELLCAST_INTERRUPTED] Taintheart Befouler(Chiivesdh) [[nameplate5:Befoulment::3-3779-1520-17549-222719-001361E57B:222719]]", -- [300]
--TODO, see what caused this. Stun? I don't think spell is interruptable by traditional interrupts
--[[
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 222719 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221028 then
		if args:IsPlayer() then--TODO, maybe give it a delay, it does take a while
			specWarnUnstableDecay:Show()
			voiceUnstableDecay:Play("runout")
			yellUnstableDecay:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnUnstableDecay:Show(args.destName)
		end
	--"<40.43 21:42:49> [CLEU] SPELL_AURA_APPLIED#Creature-0-3779-1520-17549-111354-000061CEF4#Taintheart Befouler#Player-3693-08EE23F3#Chiivesdh#222719#Befoulment#DEBUFF#nil", -- [914]
	elseif spellId == 222719 then
		specWarnBefoulment:Show(args.destName)
		voiceBefoulment:Play("gathershare")
		if args:IsPlayer() then
			yellBefoulment:Yell(15)
			yellBefoulment:Schedule(14, 1)
			yellBefoulment:Schedule(13, 2)
			yellBefoulment:Schedule(12, 3)
		end
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
