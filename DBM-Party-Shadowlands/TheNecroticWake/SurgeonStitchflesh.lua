local mod	= DBM:NewMod(2392, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162689)
mod:SetEncounterID(2389)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320358 320376 327664",
	"SPELL_CAST_SUCCESS 320359 322681 320376",
	"SPELL_AURA_APPLIED 320200 322681 322548",
	"SPELL_AURA_REMOVED 322681",
	"SPELL_PERIODIC_DAMAGE 320366",
	"SPELL_PERIODIC_MISSED 320366",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, need longer pulls where boss is NOT hooked for a while to see if he goes through cast sequences of spawning more adds or more Ichor
--[[
(ability.id = 320358 or ability.id = 327664 or ability.id = 334488) and type = "begincast"
 or (ability.id = 320359 or ability.id = 326574 or ability.id = 322681) and type = "cast"
 or ability.id = 327041 or ability.id = 322548
 or ability.id = 320376 and type = "begincast"
--]]
local warnSummonCreation			= mod:NewSpellAnnounce(320358, 2)
local warnMutilate					= mod:NewCastAnnounce(320376, 4, nil, nil, "Tank|Healer")--Upgrade to special warning if needed
local warnSeverFlesh				= mod:NewSpellAnnounce(334488, 3, nil, "Tank|Healer")
local warnEscape					= mod:NewCastAnnounce(320359, 3)
local warnEmbalmingIchor			= mod:NewTargetNoFilterAnnounce(327664, 3)
local warnMeatHook					= mod:NewTargetNoFilterAnnounce(322681, 3)
local warnStichNeedle				= mod:NewTargetNoFilterAnnounce(320200, 3, nil, false, 2)--Kind of spammy

local specWarnEmbalmingIchor		= mod:NewSpecialWarningMoveAway(327664, nil, nil, nil, 1, 2)
local yellEmbalmingIchor			= mod:NewYell(327664)
local specWarnMeatHook				= mod:NewSpecialWarningMoveTo(322681, nil, nil, nil, 3, 2)
local yellMeatHook					= mod:NewYell(322681)
local yellMeatHookFades				= mod:NewShortFadesYell(322681)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

--local timerSummonCreationCD			= mod:NewCDTimer(13, 320358, nil, nil, nil, 1)
local timerEmbalmingIchorCD			= mod:NewCDTimer(15.8, 327664, nil, nil, nil, 3)--Might be 18 now
local timerSeverFleshCD				= mod:NewCDTimer(9.7, 334488, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerEscape					= mod:NewCastTimer(30, 320359, nil, nil, nil, 6)
--Add
local timerMutilateCD				= mod:NewCDTimer(11, 320376, nil, nil, nil, 3)
local timerMeatHookCD				= mod:NewCDTimer(18, 322681, nil, nil, nil, 3)
--local timerStichNeedleCD			= mod:NewCDTimer(15.8, 320200, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)--Basically spammed

function mod:IchorTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnEmbalmingIchor:Show()
		specWarnEmbalmingIchor:Play("runout")
		yellEmbalmingIchor:Yell()
	else
		warnEmbalmingIchor:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
--	timerSummonCreationCD:Start(1-delay)--START
	timerEmbalmingIchorCD:Start(9.7-delay)
	timerMeatHookCD:Start(10.6-delay)--The add that's already alive on pull
--	timerStichNeedleCD:Start(1-delay)--SUCCESS
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320358 then
		warnSummonCreation:Show()
		--timerSummonCreationCD:Start()
	elseif spellId == 320376 then
		warnMutilate:Show()
	elseif spellId == 327664 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "IchorTarget", 0.1, 6)
		timerEmbalmingIchorCD:Start()
	elseif spellId == 334488 then
		warnSeverFlesh:Show()
		timerSeverFleshCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320359 then
		warnEscape:Show()
		timerEscape:Stop()--Escaped early?
		timerSeverFleshCD:Stop()
--		timerSummonCreationCD:Start(2.5)--1-3 seconds after escaping
		timerEmbalmingIchorCD:Start(10.9)--8-11
	elseif spellId == 322681 then
		timerMeatHookCD:Start(15, args.sourceGUID)
	elseif spellId == 320376 then
		timerMutilateCD:Start(10, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320200 then
		warnStichNeedle:CombinedShow(0.3, args.destName)
	elseif spellId == 322681 then
		if args:IsPlayer() then
			specWarnMeatHook:Show(DBM_CORE_L.BOSS)
			specWarnMeatHook:Play("targetyou")
			yellMeatHook:Yell()
			yellMeatHookFades:Countdown(spellId)
		else
			warnMeatHook:Show(args.destName)
		end
	elseif spellId == 322548 then--Boss getting meat hooked
--		timerSummonCreationCD:Stop()
		timerEmbalmingIchorCD:Stop()
		warnMeatHook:Show(args.destName)
		timerEscape:Start(30)
		timerSeverFleshCD:Start(6)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 then
		if args:IsPlayer() then
			yellMeatHookFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then--Creation
		timerMeatHookCD:Stop(args.destGUID)
		timerMutilateCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
