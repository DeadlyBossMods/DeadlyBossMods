local mod	= DBM:NewMod(2414, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162060)
mod:SetEncounterID(2358)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 321355 321936 324392 324608",
	"SPELL_AURA_REMOVED 324046",
	"SPELL_CAST_START 324046 324427 323072 324608"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, use https://shadowlands.wowhead.com/npc=165807/coalesced-anima at all?
--TODO, review some of triggers/spells, this encounter was not fully done in this build
--TODO, change purifying blast to target warning and near warning if target scanning works
--TODO, can tank avoid stomp or does boss follow? is 1.5 seconds enough time for anyone to get out for that matter
local warnDrained					= mod:NewTargetNoFilterAnnounce(321355, 1)
local warnRechargeAnima				= mod:NewSpellAnnounce(324046, 2)
local warnEmpyrealOrdnance			= mod:NewTargetAnnounce(321936, 3)
local warnChargedStomp				= mod:NewTargetNoFilterAnnounce(324608, 2, nil, "RemoveMagic")

local specWarnEmpyrealOrdnance		= mod:NewSpecialWarningMoveAway(321936, nil, nil, nil, 1, 2)
local yellEmpyrealOrdnance			= mod:NewYell(321936)
local specWarnAnimaField			= mod:NewSpecialWarningMove(324392, "Tank", nil, nil, 1, 2)
local specWarnPurifyingBlast		= mod:NewSpecialWarningDodge(323072, nil, nil, nil, 2, 2)
local yellPurifyingBlast			= mod:NewYell(323072)
local specWarnChargedStomp			= mod:NewSpecialWarningRun(324608, "Melee", nil, nil, 4, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerEmpyrealOrdnanceCD		= mod:NewAITimer(15.8, 321936, nil, nil, nil, 3)
local timerPurifyingBlastCD			= mod:NewAITimer(15.8, 323072, nil, nil, nil, 3)
local timerChargedStompCD			= mod:NewAITimer(15.8, 324608, nil, nil, nil, 3, nil, DBM_CORE_Translations.MAGIC_ICON)

mod:AddRangeFrameOption(10, 323072)
mod:AddInfoFrameOption(324046, true)

function mod:BlastTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellPurifyingBlast:Yell()
	end
	DBM:AddMsg("BlastTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

function mod:OnCombatStart(delay)
	timerEmpyrealOrdnanceCD:Start(1-delay)
	timerPurifyingBlastCD:Start(1-delay)
	timerChargedStompCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_Translations.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324046 then--Recharge Anima
		warnRechargeAnima:Show()
	elseif spellId == 324427 then
		timerEmpyrealOrdnanceCD:Start()
	elseif spellId == 323072 then
		timerPurifyingBlastCD:Start()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BlastTarget", 0.1, 6)
	elseif spellId == 324608 then
		specWarnChargedStomp:Show()
		specWarnChargedStomp:Play("justrun")
		timerChargedStompCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321355 then
		warnDrained:Show(args.destName)
		timerEmpyrealOrdnanceCD:Stop()
		timerPurifyingBlastCD:Stop()
		timerChargedStompCD:Stop()
	elseif spellId == 321936 then
		if args:IsPlayer() then
			specWarnEmpyrealOrdnance:Show()
			specWarnEmpyrealOrdnance:Play("runout")
			yellEmpyrealOrdnance:Yell()
		else
			warnEmpyrealOrdnance:Show(args.destName)
		end
	elseif spellId == 324392 and args:IsDestTypeHostile() then
		specWarnAnimaField:Show()
		specWarnAnimaField:Play("moveboss")
	elseif spellId == 324608 then
		warnChargedStomp:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 324046 then--Recharge Anima (or drained instead?)
		--Boss resumes engagement
		timerEmpyrealOrdnanceCD:Start(2)
		timerPurifyingBlastCD:Start(2)
		timerChargedStompCD:Start(2)
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
