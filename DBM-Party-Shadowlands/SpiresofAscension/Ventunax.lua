local mod	= DBM:NewMod(2416, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162058)
mod:SetEncounterID(2356)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 325424",
	"SPELL_CAST_START 324205",
	"SPELL_CAST_SUCCESS 324148"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do more with dark stride if targetting possible
--local warnBlackPowder				= mod:NewTargetAnnounce(257314, 4)

local specWarnDarkStride			= mod:NewSpecialWarningTaunt(324148, nil, nil, nil, 1, 2)
local specWarnAnimaflash			= mod:NewSpecialWarningDodge(324205, nil, nil, nil, 2, 2)
local yellAnimaflash				= mod:NewYell(324205)
local specWarnReabsorbAnima			= mod:NewSpecialWarningDodge(325424, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDarkStrideCD				= mod:NewAITimer(13, 324148, nil, nil, nil, 3, nil, DBM_CORE_Translations.TANK_ICON)
local timerAnimaflashCD				= mod:NewAITimer(15.8, 324205, nil, nil, nil, 3)
local timerReabsorbAnimaCD			= mod:NewAITimer(15.8, 325424, nil, nil, nil, 6)

function mod:FlashTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellAnimaflash:Yell()
	end
	DBM:AddMsg("FlashTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

function mod:OnCombatStart(delay)
	timerDarkStrideCD:Start(1-delay)
	timerAnimaflashCD:Start(1-delay)
	timerReabsorbAnimaCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324205 then
		specWarnAnimaflash:Show()
		specWarnAnimaflash:Play("shockwave")
		timerAnimaflashCD:Start()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "FlashTarget", 0.1, 6)
--	elseif spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 324148 then
		specWarnDarkStride:Show(args.destName or "Unknown")
		specWarnDarkStride:Play("tauntboss")
		timerDarkStrideCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 325424 then
		specWarnReabsorbAnima:Show()
		specWarnReabsorbAnima:Play("watchstep")
		timerReabsorbAnimaCD:Start()
		--Possibly reset anima flash and darkstride timers?
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
