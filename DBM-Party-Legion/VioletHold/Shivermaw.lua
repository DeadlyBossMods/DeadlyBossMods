local mod	= DBM:NewMod(1694, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101951)
mod:SetEncounterID(1845)
mod:SetZone()

mod.imaspecialsnowflake = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 202062",
	"SPELL_AURA_REMOVED 202062",
	"SPELL_CAST_START 201672 201960",
	"SPELL_CAST_SUCCESS 202062 201379"
)

local warnBreath					= mod:NewSpellAnnounce(201379, 2, nil, "Tank")

local specWarnRelentlessStorm		= mod:NewSpecialWarningDodge(201672, nil, nil, nil, 2, 2)
local specWarnFrigidWinds			= mod:NewSpecialWarningMoveAway(201672, nil, nil, nil, 1, 2)
local specWarnIceBomb				= mod:NewSpecialWarningDodge(201960, nil, nil, nil, 3, 2)

local timerRelentlessStormCD		= mod:NewNextTimer(14, 201672, nil, nil, nil, 3)--14, 47 alternating
local timerFrigidWindsCD			= mod:NewNextTimer(61, 202062, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerIceBombCD				= mod:NewNextTimer(61, 201960, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerFrostBreathCD			= mod:NewNextTimer(61, 201379, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local voiceRelentlessStorm			= mod:NewVoice(201672)--watchstep
local voiceFrigidWinds				= mod:NewVoice(201672)--scatter
local voiceIceBomb					= mod:NewVoice(201960)--findshelter

mod:AddRangeFrameOption(8, 202062)

mod.vb.stormCount = 0
mod.vb.breathCount = 0

function mod:OnCombatStart(delay)
	self.vb.stormCount = 0
	self.vb.breathCount = 0
	timerFrostBreathCD:Start(5-delay)
	timerRelentlessStormCD:Start(11-delay)
	if not self:IsNormal() then
		timerFrigidWindsCD:Start(36.5-delay)
	end
	timerIceBombCD:Start(45-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 202062 then
		timerFrigidWindsCD:Start()
	elseif spellId == 201379 then
		self.vb.breathCount = self.vb.breathCount + 1
		warnBreath:Show()
		if self.vb.breathCount % 2 == 0 then
			timerFrostBreathCD:Start(35)
		else
			timerFrostBreathCD:Start(26)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 202062 and args:IsPlayer() then
		specWarnFrigidWinds:Show()
		voiceFrigidWinds:Play("scatter")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 202062 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201672 then
		self.vb.stormCount = self.vb.stormCount + 1
		specWarnRelentlessStorm:Show()
		voiceRelentlessStorm:Play("watchstep")
		if self.vb.stormCount % 2 == 0 then
			timerRelentlessStormCD:Start(47)
		else
			timerRelentlessStormCD:Start(14)
		end
	elseif spellId == 201960 then
		specWarnIceBomb:Show()
		voiceIceBomb:Play("findshelter")
		timerIceBombCD:Start()
	end
end
