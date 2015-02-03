local mod	= DBM:NewMod(1262, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83746)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 167647 167615",
	"SPELL_AURA_APPLIED_DOSE 167615",
	"SPELL_CAST_START 167614 167679",
	"RAID_BOSS_WHISPER"
)

--TODO, taunt stacks and what not
--TODO, timers.
--TODO, health percents feathers/glory happen at. Add warnings if cast detectable too.
--TODO, add warnings for fixates birds do if they fixate.
local warnPiercedArmor			= mod:NewStackAnnounce(167615, 3, nil, "Tank")

local specWarnLooseQuills		= mod:NewSpecialWarningSpell(167647, nil, nil, nil, 2)
local specWarnSolarBreath		= mod:NewSpecialWarningSpell(167679, "Tank")
local specWarnExplode			= mod:NewSpecialWarningYou(167630)

local timerLooseQuills			= mod:NewBuffActiveTimer(30, 167647)
--local timerLooseQuillsCD		= mod:NewCDTimer(30, 167647)
local timerSharpBeakCD			= mod:NewCDTimer(18, 167614, nil, "Tank")--Could be wrong, server was highly unstable
--local timerSolarBreathCD		= mod:NewCDTimer(15, 167687, nil, "Tank")

--mod:AddReadyCheckOption(37474, false)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 167647 then
		specWarnLooseQuills:Show()
		timerLooseQuills:Start()
	elseif spellId == 167615 then
		local amount = args.amount or 1
		warnPiercedArmor:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 167614 then
		timerSharpBeakCD:Start()
	elseif spellId == 167679 then
		specWarnSolarBreath:Show()
		--timerSolarBreathCD:Start()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:167630") then
		specWarnExplode:Show()
	end
end
