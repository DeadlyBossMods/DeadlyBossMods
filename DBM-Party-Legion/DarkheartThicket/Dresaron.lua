local mod	= DBM:NewMod(1656, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(99200)
mod:SetEncounterID(1838)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 199389 199345",
	"SPELL_PERIODIC_DAMAGE 199460",
	"SPELL_PERIODIC_MISSED 199460",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Breath scanning tweaks. it CAN target tank so we need a more complex system to grab any target he looks at that's not tank during cast, but fall back to tank as target if no other target found.
local warnBreath					= mod:NewTargetAnnounce(199332, 3)
local warnRoar						= mod:NewSpellAnnounce(199389, 2)

local specWarnDownDraft				= mod:NewSpecialWarningSpell(199345, nil, nil, nil, 2, 2)
local yellBreath					= mod:NewYell(199332)
local specWarnFallingRocks			= mod:NewSpecialWarningMove(199460, nil, nil, nil, 2, 2)

local timerBreathCD					= mod:NewCDTimer(30, 199332, nil, nil, nil, 3)
local timerEarthShakerCD			= mod:NewCDTimer(29, 199389, nil, nil, nil, 3)
local timerDownDraftCD				= mod:NewCDTimer(38, 199345, nil, nil, nil, 2)--38-42 (health based or varaible?)

local voiceDownDraft				= mod:NewVoice(199345)--keepmove
local voiceBreath					= mod:NewVoice(199332)--breathsoon
local voiceFallingRocks				= mod:NewVoice(199460)--runaway

--mod:AddRangeFrameOption(5, 153396)

function mod:BreathTarget(targetname, uId)
	if not targetname then
		DBM:Debug("Probably on the tank")
		return
	end
	warnBreath:Show(targetname)
	if targetname == UnitName("player") then
		yellBreath:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerBreathCD:Start(8-delay)
	timerEarthShakerCD:Start(15-delay)
	timerDownDraftCD:Start(19-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 199389 then
		warnRoar:Show()
	elseif spellId == 199345 then
		specWarnDownDraft:Show()
		voiceDownDraft:Play("keepmove")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 199460 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFallingRocks:Show()
		voiceFallingRocks:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 199332 then--Even with this scanner, it's abougt 50/50 hit or miss you can grab a target at all
		voiceBreath:Play("breathsoon")
		self:BossUnitTargetScanner(uId, "BreathTarget", 2)
		timerBreathCD:Start()
	end
end
