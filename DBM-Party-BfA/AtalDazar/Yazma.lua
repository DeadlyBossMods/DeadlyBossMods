local mod	= DBM:NewMod(2030, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(122968)
mod:SetEncounterID(2087)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 250036",
	"SPELL_CAST_START 249923 259187 250096 249919 250050",
	"SPELL_PERIODIC_DAMAGE 250036",
	"SPELL_PERIODIC_MISSED 250036",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--(ability.id = 249923 or ability.id = 250096 or ability.id = 250050 or ability.id = 249919) and type = "begincast"
--TODO: Verify CHAT_MSG_RAID_BOSS_EMOTE for soulrend. I know i saw it but not sure I got spellId right since chatlog only grabs parsed name
local warnSoulRend					= mod:NewTargetAnnounce(249923, 4)

local specWarnSoulRend				= mod:NewSpecialWarningRun(249923, nil, nil, nil, 4, 2)
local yellSoulRend					= mod:NewYell(249923)
local specWarnWrackingPain			= mod:NewSpecialWarningInterrupt(250096, "HasInterrupt", nil, nil, 1, 2)
local specWarnSkewer				= mod:NewSpecialWarningDefensive(249919, "Tank", nil, nil, 1, 2)
local specWarnEchoes				= mod:NewSpecialWarningDodge(250050, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(250036, nil, nil, nil, 1, 8)

local timerSoulrendCD				= mod:NewCDTimer(41.3, 249923, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerWrackingPainCD			= mod:NewCDTimer(17, 250096, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--17-23
local timerSkewerCD					= mod:NewCDTimer(12, 249919, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerEchoesCD					= mod:NewCDTimer(32.8, 250050, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerWrackingPainCD:Start(3.5-delay)
	timerSkewerCD:Start(5-delay)
	timerSoulrendCD:Start(10-delay)
	timerEchoesCD:Start(16.9-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 250036 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249923 or spellId == 259187 then
		timerSoulrendCD:Start()
		if not self:IsNormal() and not self:IsTank() then
			specWarnSoulRend:Show()
			specWarnSoulRend:Play("runout")
		end
	elseif spellId == 250096 then
		timerWrackingPainCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWrackingPain:Show(args.sourceName)
			specWarnWrackingPain:Play("kickcast")
		end
	elseif spellId == 249919 then
		specWarnSkewer:Show()
		specWarnSkewer:Play("defensive")
		timerSkewerCD:Start()
	elseif spellId == 250050 then
		specWarnEchoes:Show()
		specWarnEchoes:Play("watchstep")
		timerEchoesCD:Start()
	end
end

--Same time as SPELL_CAST_START but has target information on normal
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:249924") then
		if targetname then--Normal, only one person affected, name in emote
			if targetname == UnitName("player") then
				specWarnSoulRend:Show()
				specWarnSoulRend:Play("runout")
				yellSoulRend:Yell()
			else
				warnSoulRend:Show(targetname)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 250036 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
