local mod	= DBM:NewMod(1654, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96512)
mod:SetEncounterID(1836)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198379",
	"SPELL_CAST_SUCCESS 198401",
	"SPELL_PERIODIC_DAMAGE 198408",
	"SPELL_PERIODIC_MISSED 198408",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnLeap					= mod:NewTargetAnnounce(196346, 2)--0.5 seconds may still be too hard to dodge even if target scanning works.
local warnNightFall				= mod:NewSpellAnnounce(198401, 2)

local specWarnNightfall			= mod:NewSpecialWarningMove(198408, nil, nil, nil, 1, 2)
--local specWarnLeap			= mod:NewSpecialWarningDodge(196346, nil, nil, nil, 1)
local yellLeap					= mod:NewYell(196346)
local specWarnRampage			= mod:NewSpecialWarningDefensive(198379, "Tank", nil, nil, 1, 2)

local timerLeapCD				= mod:NewCDTimer(16.5, 196346, nil, nil, nil, 3)
local timerRampageCD			= mod:NewCDTimer(15.8, 198379, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNightfallCD			= mod:NewCDTimer(14.5, 198379, nil, nil, nil, 3)

local voiceNightFall			= mod:NewVoice(198408)--runaway
local voiceRampage				= mod:NewVoice(198379, "Tank")--defensive

--mod:AddRangeFrameOption(5, 153396)

function mod:LeapTarget(targetname, uId)
	if not targetname then
		warnLeap:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
--		specWarnLeap:Show()
--		voiceSwirlingScythe:Play("runaway")
		yellLeap:Yell()
	else
		warnLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerLeapCD:Start(5.9-delay)
	timerRampageCD:Start(12.2-delay)
	timerNightfallCD:Start(19-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 198401 and self:AntiSpam(2, 1) then
		warnNightFall:Show()
		timerNightfallCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198379 then
		specWarnRampage:Show()
		voiceRampage:Play("defensive")
		timerRampageCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 198408 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnNightfall:Show()
		voiceNightFall:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	--"<13.84 02:50:50> [UNIT_SPELLCAST_SUCCEEDED] Arch-Druid Glaidalis(Omegal) [[boss1:Grievous Leap::3-2084-1466-6383-196346-000018A4DA:196346]]", -- [47]
	if spellId == 196346 then
		self:BossTargetScanner(96512, "LeapTarget", 0.05, 12, true, nil, nil, nil, true)
		timerLeapCD:Start()
	end
end
