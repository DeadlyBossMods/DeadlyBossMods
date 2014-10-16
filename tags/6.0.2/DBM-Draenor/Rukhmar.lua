local mod	= DBM:NewMod(1262, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83746)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 167647 167615",
	"SPELL_AURA_APPLIED_DOSE 167615",
	"SPELL_CAST_START 167614 167687",
	"SPELL_CAST_SUCCESS 167710"
)

--TODO, does breath face tank?
--TODO, taunt stacks and what not
--TODO, timers.
--TODO, health percents feathers/glory happen at. Add warnings if cast detectable too.
--TODO, add warnings for fixates birds do if they fixate.
local warnLooseQuills			= mod:NewSpellAnnounce(167647, 3)
local warnPiercedArmor			= mod:NewStackAnnounce(167615, 3, nil, mod:IsTank())
local warnSolarBreath			= mod:NewSpellAnnounce(167687, 3, nil, mod:IsTank())
local warnSolarRadiation		= mod:NewSpellAnnounce(167710, 3, nil, mod:IsHealer())

local specWarnLooseQuills		= mod:NewSpecialWarningSpell(167647, nil, nil, nil, 2)
local specWarnSolarBreath		= mod:NewSpecialWarningSpell(167687, false)

local timerLooseQuills			= mod:NewBuffActiveTimer(30, 167647)
--local timerLooseQuillsCD		= mod:NewCDTimer(30, 167647)
local timerSolarRadiationCD		= mod:NewNextTimer(15, 167710)--15 seconds according to journal. Doesn't mean it's right though.
--local timerSharpBeakCD		= mod:NewCDTimer(15, 167614)
--local timerSolarBreathCD		= mod:NewCDTimer(15, 167687)

--mod:AddReadyCheckOption(33117, false)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 167647 then
		warnLooseQuills:Show()
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
		--timerSharpBeakCD:Start()
	elseif spellId == 167687 then
		warnSolarBreath:Show()
		specWarnSolarBreath:Show()
		--timerSolarBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 167710 then
		warnSolarRadiation:Show()
		timerSolarRadiationCD:Start()
	end
end
