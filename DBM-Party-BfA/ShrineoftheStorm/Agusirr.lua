local mod	= DBM:NewMod(2153, "DBM-Party-BfA", 4, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134056)--134828 split forms
mod:SetEncounterID(2130)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 264144 264166 264560 264773",
	"SPELL_AURA_REMOVED 264560 264773 264903",
	"SPELL_CAST_START 264101 264903 264144 264166"
)

--TODO, timer work needs longer pull, so heroic or mythic cause boss health drops too fast on normal
local warnUndertow					= mod:NewTargetAnnounce(264144, 2)
local warnChokingBrine				= mod:NewTargetNoFilterAnnounce(264560, 2, nil, "Healer")
local warnEruptingWaters			= mod:NewSpellAnnounce(264903, 2, nil, nil, nil, nil, nil, 2)

local specWarnSurgingRush			= mod:NewSpecialWarningDodge(264101, nil, nil, nil, 1, 2)
local specWarnChokingBrine			= mod:NewSpecialWarningDodge(264560, nil, nil, nil, 1, 2)
local yellChokingBrine				= mod:NewFadesYell(264560, DBM_CORE_AUTO_YELL_CUSTOM_FADE)
local specWarnUndertow				= mod:NewSpecialWarningYou(264144, nil, nil, nil, 3, 2)

local timerSurgingRushCD			= mod:NewCDTimer(13, 264101, nil, nil, nil, 3)
local timerChokingBrineCD			= mod:NewCDTimer(13, 264560, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)
local timerUndertowCD				= mod:NewCDTimer(13, 264144, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

function mod:UndertowTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnUndertow:Show()
			specWarnUndertow:Play("targetyou")
			specWarnUndertow:ScheduleVoice(1.8, "keepmove")
		else
			warnUndertow:CombinedShow(0.5, targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	timerChokingBrineCD:Start(10.5-delay)--SUCCESS
	timerSurgingRushCD:Start(17-delay)
	timerUndertowCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 264144 or spellId == 264166) and self:AntiSpam(4, args.destName) then--Backup warning if scan failed
		warnUndertow:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnUndertow:Show()
			specWarnUndertow:Play("targetyou")
			specWarnUndertow:ScheduleVoice(1.8, "keepmove")
		end
	elseif spellId == 264560 or spellId == 264773 then--264773 spread one for not avoiding swirls from dispel/expire
		warnChokingBrine:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 264560 or spellId == 264773) then
		if self:AntiSpam(4, 2) then
			specWarnChokingBrine:Show()
			specWarnChokingBrine:Play("watchstep")
		end
		if args:IsPlayer() then
			yellChokingBrine:Yell(args.spellName)
		end
	elseif spellId == 264903 then--Erupting Waters Removed
		timerChokingBrineCD:Start(10)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 264101 and self:AntiSpam(3, 1) then
		specWarnSurgingRush:Show()
		specWarnSurgingRush:Play("chargemove")
	elseif spellId == 264903 then
		warnEruptingWaters:Show()
		warnEruptingWaters:Play("phasechange")
		--Boss Timer stops
		timerChokingBrineCD:Stop()
		timerUndertowCD:Stop()
		timerSurgingRushCD:Stop()
		--Little add timer starts
		timerChokingBrineCD:Start(13.5)
		timerSurgingRushCD:Start(19)
		timerUndertowCD:Start(26)
	elseif spellId == 264144 or spellId == 264166 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "UndertowTarget", 0.1, 12, true, nil, nil, nil, true)
	end
end
