local mod	= DBM:NewMod(2414, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162060)
mod:SetEncounterID(2358)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 324608 334053",
	"SPELL_CAST_SUCCESS 324444",
	"SPELL_AURA_APPLIED 321936 324392 338729 338731 327416 327416 324046",
	"SPELL_AURA_REMOVED 327416 324392 324046"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_START boss1"
)

--TODO, use https://shadowlands.wowhead.com/npc=165807/coalesced-anima at all?
--TODO, purifying blast cast has been removed from combat log, testing a unit event for it, for now. If not, not much can do with it warning/timer wise
--TODO, drained still a thing? I don't even see it occur in a M+ 10
--[[
(ability.id = 334053 or ability.id = 324427 or ability.id = 324608) and type = "begincast"
 or ability.id = 324444 and type = "cast"
 or (ability.id = 321355 or ability.id = 327416 or ability.id = 324046) and (type = "applybuff" or type = "removebuff" or type = "removedebuff" or type = "applydebuff")
--]]
local warnRechargeAnima				= mod:NewSpellAnnounce(327416, 2)
local warnEmpyrealOrdnance			= mod:NewTargetAnnounce(321936, 3)
local warnChargedStomp				= mod:NewTargetNoFilterAnnounce(338731, 2, nil, "RemoveMagic")
local warnPurifyingBlast			= mod:NewTargetNoFilterAnnounce(334053, 3)

local specWarnEmpyrealOrdnance		= mod:NewSpecialWarningMoveAway(321936, nil, nil, nil, 1, 2)
local yellEmpyrealOrdnance			= mod:NewYell(321936)
local specWarnAnimaField			= mod:NewSpecialWarningMove(324392, "Tank", nil, nil, 1, 2)
local specWarnPurifyingBlast		= mod:NewSpecialWarningMoveAway(334053, nil, nil, nil, 1, 2)
local yellPurifyingBlast			= mod:NewYell(334053)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerEmpyrealOrdnanceCD		= mod:NewCDTimer(26.7, 324427, nil, nil, nil, 3)
local timerPurifyingBlastCD			= mod:NewCDTimer(13.4, 334053, nil, nil, nil, 3)--Wild variations do to spell queuing problems
local timerChargedStompCD			= mod:NewCDTimer(13.4, 324608, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)--Wild variations do to spell queuing problems

mod:AddRangeFrameOption(8, 334053)
mod:AddInfoFrameOption(327416, true)
mod:AddNamePlateOption("NPAuraOnAnimaField", 324392)

function mod:BlastTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnPurifyingBlast:Show()
		specWarnPurifyingBlast:Play("runout")
		yellPurifyingBlast:Yell()
	else
		warnPurifyingBlast:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerPurifyingBlastCD:Start(8.4-delay)
	timerChargedStompCD:Start(14.3-delay)--Wild pull variation depending on boss casts ordinance or stomp first
	timerEmpyrealOrdnanceCD:Start(16.9-delay)--Wild pull variation depending on boss casts ordinance or stomp first
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnAnimaField then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnAnimaField then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324608 then
		timerChargedStompCD:Start()
	elseif spellId == 334053 then
		timerPurifyingBlastCD:Start()
		--Intentionally not using UNIT_TARGET scanner, boss doesn't fire a UNIT_TARGET event during this
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BlastTarget", 0.1, 10)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 324444 then
		timerEmpyrealOrdnanceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321936 then
		if args:IsPlayer() then
			specWarnEmpyrealOrdnance:Show()
			specWarnEmpyrealOrdnance:Play("runout")
			yellEmpyrealOrdnance:Yell()
		else
			warnEmpyrealOrdnance:Show(args.destName)
		end
	elseif spellId == 324392 and args:IsDestTypeHostile() then
		if self:AntiSpam(3, 1) then
			specWarnAnimaField:Show()
			specWarnAnimaField:Play("moveboss")
		end
		if self.Options.NPAuraOnAnimaField then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 338731 or spellId == 338729 then
		warnChargedStomp:CombinedShow(0.3, args.destName)
	elseif spellId == 327416 or spellId == 324046 then
		warnRechargeAnima:Show()
		timerEmpyrealOrdnanceCD:Stop()
		timerPurifyingBlastCD:Stop()
		timerChargedStompCD:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 327416 or spellId == 324046 then--Recharge Anima (or drained instead?)
		--Boss resumes engagement
		timerPurifyingBlastCD:Start(8.4)
		timerChargedStompCD:Start(14.3)
		timerEmpyrealOrdnanceCD:Start(16.9)
	elseif spellId == 324392 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnAnimaField then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
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

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 334053 then
		local guid = UnitGUID(uId)
	end
end
--]]
