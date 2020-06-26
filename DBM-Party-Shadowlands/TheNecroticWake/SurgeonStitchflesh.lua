local mod	= DBM:NewMod(2392, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166882)
mod:SetEncounterID(2389)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 320200",
	"SPELL_CAST_START 320358 320376 320359 327664",
	"SPELL_CAST_SUCCESS 326629 320200",
	"SPELL_PERIODIC_DAMAGE 320366",
	"SPELL_PERIODIC_MISSED 320366",
	"RAID_BOSS_WHISPER"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, where did 323016 go?
--TODO, get right meat hook spell to warn who it's targetting etc and get a yell/target warning operational. Too many to guess/drycode
local warnSummonCreation			= mod:NewSpellAnnounce(320358, 2)
local warnMutilate					= mod:NewCastAnnounce(320376, 4, nil, nil, "Tank|Healer")--Upgrade to special warning if needed
--local warnObscuringGas				= mod:NewSpellAnnounce(326629, 2)
local warnEscape					= mod:NewCastAnnounce(320359, 3)
local warnEmbalmingIchor			= mod:NewTargetNoFilterAnnounce(322681, 3)
local warnMeatHook					= mod:NewTargetNoFilterAnnounce(327461, 3)
local warnStichNeedle				= mod:NewTargetNoFilterAnnounce(320200, 3, nil, "Healer")
--local warnDarkInfusion				= mod:NewCastAnnounce(323016, 3)

local specWarnEmbalmingIchor		= mod:NewSpecialWarningMoveAway(322681, nil, nil, nil, 1, 2)
local yellEmbalmingIchor			= mod:NewYell(322681)
local specWarnMeatHook				= mod:NewSpecialWarningMoveTo(327461, nil, nil, nil, 3, 2)
local yellMeatHook					= mod:NewYell(327461)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

local timerSummonCreationCD			= mod:NewAITimer(13, 320358, nil, nil, nil, 1)
--local timerMeatHookCD				= mod:NewAITimer(15.8, 322681, nil, nil, nil, 3)
--local timerMutilateCD				= mod:NewCDTimer(13, 320376, nil, nil, nil, 3)--Can't AI timer, multiple adds might be up, enable later
local timerEmbalmingIchorCD			= mod:NewAITimer(15.8, 322681, nil, nil, nil, 3)
local timerStichNeedleCD			= mod:NewAITimer(15.8, 320200, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
--local timerDarkinfusionCD			= mod:NewAITimer(13, 323016, nil, nil, nil, 2)

function mod:IchorTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnEmbalmingIchor:Show()
		specWarnEmbalmingIchor:Play("runout")
		yellEmbalmingIchor:Yell()
	else
		warnEmbalmingIchor:Show(targetname)
	end
	DBM:AddMsg("IchorTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

function mod:OnCombatStart(delay)
--	timerSummonCreationCD:Start(1-delay)--START
--	timerEmbalmingIchorCD:Start(1-delay)
--	timerStichNeedleCD:Start(1-delay)--SUCCESS
--	timerDarkinfusionCD:Start(1-delay)--START
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320358 then
		warnSummonCreation:Show()
		timerSummonCreationCD:Start()
	elseif spellId == 320376 then
		warnMutilate:Show()
		--timerMutilateCD:Start()
	elseif spellId == 320359 then
		warnEscape:Show()
		--TODO, phase change/timer stuff?
	elseif spellId == 327664 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "IchorTarget", 0.1, 6)
		timerEmbalmingIchorCD:Start()
--	elseif spellId == 323016 then
--		warnDarkInfusion:Show()
--		timerDarkinfusionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 326629 then
		--warnObscuringGas:Show()
		--timerSummonCreationCD:Stop()
		--TODO, phase change/timer stuff?
	elseif spellId == 320200 then
		timerStichNeedleCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320200 then
		warnStichNeedle:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:327461") then
		specWarnMeatHook:Show(DBM_CORE_L.BOSS)
		specWarnMeatHook:Play("targetyou")
		yellMeatHook:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("327461") and targetName then
		targetName = Ambiguate(targetName, "none")
		if UnitName("player") == targetName then return end--Player already got warned
		warnMeatHook:Show(targetName)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157467 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
