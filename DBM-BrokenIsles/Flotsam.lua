local mod	= DBM:NewMod(1795, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(99929)
mod:SetEncounterID(1951)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 220340 223317 223373",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnYaksam				= mod:NewCastAnnounce(223373, 3)
local warnJetsam				= mod:NewTargetAnnounce(220295, 2)

local specWarnGetsam			= mod:NewSpecialWarningDodge(220340, "Tank", nil, nil, 1, 2)
local specWarnBreakSam			= mod:NewSpecialWarningSpell(223317, "Melee", nil, nil, 1, 2)
local specWarnJetsam			= mod:NewSpecialWarningMoveAway(220295, nil, nil, nil, 1, 2)
local yellJetsam				= mod:NewYell(220295)
local specWarnJetsamNear		= mod:NewSpecialWarningClose(220295, nil, nil, nil, 1, 2)

local timerGetsamCD				= mod:NewCDTimer(53, 220340, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerYaksamCD				= mod:NewCDTimer(50, 223373, nil, nil, nil, 1)--50-55

local voiceGetsam				= mod:NewVoice(220340, "Tank")--shockwave
local voiceBreakSam				= mod:NewVoice(223317, "Melee")--carefly
local voiceJetsam				= mod:NewVoice(220295)--runout/watchstep

--mod:AddReadyCheckOption(37460, false)

function mod:JetsamTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnJetsam:Show()
		voiceJetsam:Play("runout")
		yellJetsam:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnJetsamNear:Show(targetname)
		voiceJetsam:Play("watchstep")
	else
		warnJetsam:Show(targetname)
	end
end

--[[
function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end
--]]

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 223317 then
		specWarnBreakSam:Show()
		voiceBreakSam:Play("carefly")
	elseif spellId == 220340 then
		specWarnGetsam:Show()
		voiceGetsam:Play("shockwave")
		timerGetsamCD:Start()
	elseif spellId == 223373 then
		warnYaksam:Show()
		timerYaksamCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 220295 and self:AntiSpam(4, 1) then---220277-Summon Jetsam Stalker/220295-Jetsam
		self:BossTargetScanner(99929, "JetsamTarget", 0.2, 5)
	end
end