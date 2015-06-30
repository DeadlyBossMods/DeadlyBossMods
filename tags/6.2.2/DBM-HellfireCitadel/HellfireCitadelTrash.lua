local mod	= DBM:NewMod("HellfireCitadelTrash", "DBM-HellfireCitadel")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 189595 189612",
	"SPELL_AURA_APPLIED 189533 188476 182644 186961 189512",
	"SPELL_AURA_REMOVED 186961"
)

--First time mod loads, inject custom sound for kaz
if not mod.Options.SpecWarn189512youSWSound then
	mod.Options.SpecWarn189512youSWSound = "Sound\\Creature\\KazRogal\\CAV_Kaz_Mark02.ogg"
end

--TODO, http://ptr.wowhead.com/spell=188510/graggra-smash
--http://ptr.wowhead.com/spell=188448/blazing-fel-touch
--Add Solar Chakram once right spellid is seen
--Add Phantasmal Corruption when trash version is observed.
--Add Phantasmal Fel Bomb when trash version is observed
--Add Harbinger's Mending when trash version is observed
local warnDarkFate					= mod:NewTargetAnnounce(182644, 3)

local specWarnCrowdControl			= mod:NewSpecialWarningSpell(189595, nil, nil, nil, 1, 2)--Maybe use a custom "Look Away" warning
local specWarnSeverSoul				= mod:NewSpecialWarningYou(189533, nil, nil, nil, 1, 2)
local specWarnSeverSoulOther		= mod:NewSpecialWarningTaunt(189533, nil, nil, nil, 1, 2)
local specWarnBadBreathOther		= mod:NewSpecialWarningTaunt(188476, nil, nil, nil, 1, 2)
local specWarnRendingHowl			= mod:NewSpecialWarningInterrupt(189612, "-Healer", nil, nil, 1, 2)
local yellDarkFate					= mod:NewFadesYell(182644)
local specWarnMarkofKaz				= mod:NewSpecialWarningYou(189512)

local voiceSeverSoul				= mod:NewVoice(189533, "Tank")--changemt
local voiceCrowdControl				= mod:NewVoice(189595)--turnaway
local voiceRendingHowl				= mod:NewVoice(189612, "-Healer")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 189595 then
		specWarnCrowdControl:Show()
		voiceCrowdControl:Play("turnaway")
	elseif spellId == 189612 and self:CheckInterruptFilter(args.sourceGUID) and self:AntiSpam(3, 1) then
		specWarnRendingHowl:Show(args.sourceName)
		voiceRendingHowl:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 189533 then
		voiceSeverSoul:Play("changemt")
		if args:IsPlayer() then
			specWarnSeverSoul:Show()
		else
			specWarnSeverSoulOther:Show(args.destName)
		end
	elseif spellId == 188476 and not args:IsPlayer() and not UnitDebuff("player", GetSpellInfo(188476)) then
		specWarnBadBreathOther:Show(args.destName)
	elseif spellId == 186961 then
		warnDarkFate:Show(args.destName)
		if args:IsPlayer() then
			yellDarkFate:Schedule(14, 1)
			yellDarkFate:Schedule(13, 2)
			yellDarkFate:Schedule(12, 3)
			yellDarkFate:Schedule(11, 4)
			yellDarkFate:Schedule(10, 5)
		end
	elseif spellId == 189512 then
		if args:IsPlayer() then
			specWarnMarkofKaz:Show()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186961 and args:IsPlayer() then
		yellDarkFate:Cancel()
	end
end