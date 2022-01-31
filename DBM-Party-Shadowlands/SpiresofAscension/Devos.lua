local mod	= DBM:NewMod(2412, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162061)
mod:SetEncounterID(2359)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 334625 322999 323943 322921",
	"SPELL_CAST_SUCCESS 322818 322893 322908",
	"SPELL_AURA_APPLIED 322818",
--	"SPELL_PERIODIC_DAMAGE 322817",
--	"SPELL_PERIODIC_MISSED 322817",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 322999 or ability.id = 323943 or ability.id = 334625) and type = "begincast"
 or (ability.id = 322818 or ability.id = 322893 or ability.id = 322908) and type = "cast"
 --]]
--General
local warnPhase						= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage 1
local warnLostConfidence			= mod:NewTargetNoFilterAnnounce(322818, 2)
local warnRunThrough				= mod:NewTargetNoFilterAnnounce(323943, 3)
--Stage 2
local warnSlipStream				= mod:NewSpellAnnounce(322893, 4)
local warnBackdraft					= mod:NewSpellAnnounce(322908, 4)
local warnSpear						= mod:NewSpellAnnounce(322921, 1)

--Stage 1
local specWarnAbyssalDetonation		= mod:NewSpecialWarningMoveTo(334625, nil, nil, nil, 3, 2)
local specWarnLostConfidence		= mod:NewSpecialWarningMoveAway(322818, nil, nil, nil, 1, 2)
local yellLostConfidence			= mod:NewYell(322818)
local specWarnRunThrough			= mod:NewSpecialWarningMoveAway(323943, nil, nil, nil, 1, 2)
local yellRunThrough				= mod:NewYell(323943)
local specWarnRunThroughNear		= mod:NewSpecialWarningClose(323943, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(322817, nil, nil, nil, 1, 8)

--Stage 1
local timerAbyssalDetonationCD		= mod:NewCDTimer(20.6, 334625, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerLostConfidenceCD			= mod:NewCDTimer(31.6, 322818, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON..DBM_COMMON_L.HEALER_ICON)
local timerRunThroughCD				= mod:NewCDTimer(14.3, 323943, nil, nil, nil, 3)--14.3-20.6
--Stage 2
local timerSlipstreamCD				= mod:NewNextTimer(18.2, 322893, nil, nil, nil, 2)
local timerBackdraftCD				= mod:NewNextTimer(18.2, 322908, nil, nil, nil, 2)

local shelter = DBM:GetSpellInfo(335806)

function mod:OnCombatStart(delay)
	timerRunThroughCD:Start(10-delay)
	timerAbyssalDetonationCD:Start(20.1-delay)
	timerLostConfidenceCD:Start(24.6-delay)--SUCCESS
end

--function mod:OnCombatEnd()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 334625 then
		specWarnAbyssalDetonation:Show(shelter)
		specWarnAbyssalDetonation:Play("findshelter")
		timerAbyssalDetonationCD:Start()
	elseif spellId == 322999 then--Stage 2
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerAbyssalDetonationCD:Stop()
		timerLostConfidenceCD:Stop()
		timerRunThroughCD:Stop()
		timerSlipstreamCD:Start(10)
	elseif spellId == 323943 then
		timerRunThroughCD:Start()
	elseif spellId == 322921 then--Spear activation
		warnSpear:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322818 then
--		timerLostConfidenceCD:Start()--Need data on in between casts, only have phase change data
	elseif spellId == 322893 then
		warnSlipStream:Show()
		timerBackdraftCD:Start()
	elseif spellId == 322908 then
		warnBackdraft:Show()
		timerSlipstreamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322818 then
		if args:IsPlayer() then
			specWarnLostConfidence:Show()
			specWarnLostConfidence:Play("scatter")
			yellLostConfidence:Yell()
		else
			warnLostConfidence:CombinedShow(0.5, args.destName)
		end
	end
end

do
	local playerName = UnitName("player")
	--"<1359.36 03:16:15> [CLEU] SPELL_CAST_START#Creature-0-2084-2285-28379-162061-000024ADE1#Devos##nil#323943#Run Through#nil#nil", -- [12686]
	--"<1359.57 03:16:15> [CHAT_MSG_MONSTER_YELL] This spear shall pierce your heart!#Devos###Nirdail##0#0##0#303#nil#0#false#false#false#false", -- [12689]
	function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, targetname)
		if (msg == L.RunThrough or msg:find(L.RunThrough)) and targetname then
			self:SendSync("Spear", targetname)
		end
	end

	function mod:OnSync(msg, targetname, sender)
		if not self:IsInCombat() then return end
		if msg == "Spear" and sender then
			targetname = Ambiguate(targetname, "none")
			if targetname == playerName then
				specWarnRunThrough:Show()
				specWarnRunThrough:Play("targetyou")
				yellRunThrough:Yell()
			elseif self:CheckNearby(8, targetname) then
				specWarnRunThroughNear:Show(targetname)
				specWarnRunThroughNear:Play("runaway")
			else
				warnRunThrough:Show(targetname)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 322817 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 330433 then--Shut Down (earlier triggers exist that kinda signal end to air phase but don't nessesarily stop timers, this is safer place to do that)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerSlipstreamCD:Stop()
		timerBackdraftCD:Stop()
		--Timers seem same as pull, minus 0.4 (give or take, because of landing time)
		timerRunThroughCD:Start(9.6)
		timerAbyssalDetonationCD:Start(19.7)
		timerLostConfidenceCD:Start(24.2)--SUCCESS
	end
end
