local mod	= DBM:NewMod(2030, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122968)
mod:SetEncounterID(2087)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 250036",
	"SPELL_CAST_START 249923 259190 250096 249919 250050",
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
local specWarnGTFO					= mod:NewSpecialWarningGTFO(250036, nil, nil, nil, 1, 2)

local timerSoulrendCD				= mod:NewCDTimer(26, 249923, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerWrackingPainCD			= mod:NewCDTimer(11, 250096, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSkewerCD					= mod:NewCDTimer(25, 249919, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--25-30 or health based
local timerEchoesCD					= mod:NewCDTimer(26.8, 250050, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerWrackingPainCD:Start(3.5-delay)
	timerSoulrendCD:Start(6-delay)
	timerEchoesCD:Start(22.9-delay)
	timerSkewerCD:Start(28.9-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 250036 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249923 or spellId == 259190 then
		timerSoulrendCD:Start()
	elseif spellId == 250096 then
		timerWrackingPainCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
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
	if msg:find("spell:249923") then
		if targetname then--Normal, only one person affected, name in emote
			if targetname == UnitName("player") then
				specWarnSoulRend:Show()
				specWarnSoulRend:Play("runout")
				yellSoulRend:Yell()
			else
				warnSoulRend:Show(targetname)
			end
		else--No target name, probably heroic+ and affecting everyone
			specWarnSoulRend:Show()
			specWarnSoulRend:Play("runout")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 250036 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
	end
end
--]]
