local mod	= DBM:NewMod(2437, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175616)
mod:SetEncounterID(2425)
mod:SetHotfixNoticeRev(20220405000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 346204",
	"SPELL_CAST_SUCCESS 346006",
	"SPELL_AURA_APPLIED 347949 348128 345770 345990",
	"SPELL_AURA_REMOVED 345770 345990"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--Improve/add timers for armed/disarmed phases because it'll probably alternate a buffactive timer instead of CD
--TODO, what do with https://ptr.wowhead.com/spell=347964/rotary-body-armor ?
--[[
(ability.id = 348350 or ability.id = 346204) and type = "begincast"
 or ability.id = 346006 and type = "cast"
 or ability.id = 345990 and (type = "applydebuff" or type = "removedebuff")
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnArmedSecurity				= mod:NewSpellAnnounce(346204, 2)
local warnFullyArmed				= mod:NewSpellAnnounce(348128, 3, nil, "Tank|Healer")
local warnContainmentCell			= mod:NewTargetNoFilterAnnounce(345990)--When cell forms
local warnInpoundContraband			= mod:NewTargetNoFilterAnnounce(345770, 2)--Not filtered, because if it's on a tank or healer its kinda important
local warnInpoundContrabandEnded	= mod:NewEndAnnounce(345770, 1)

local specWarnInterrogation			= mod:NewSpecialWarningRun(347949, nil, nil, nil, 4, 2)
local yellInterrogation				= mod:NewYell(347949)
local specWarnInterrogationOther	= mod:NewSpecialWarningSwitch(347949, "Dps", nil, nil, 1, 2)
local specWarnContainmentCell		= mod:NewSpecialWarningYou(345990, false, nil, nil, 1, 2)--Optional, but probably don't need, you already know it's you from targetting debuff
local specWarnInpoundContraband		= mod:NewSpecialWarningYou(345770, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

--Timers have spell queuing and ordering issues. min times lazily used because it's a 5 man and not worth effort to detect/auto update when spell queuing occurs
local timerInterrogationCD			= mod:NewCDTimer(30.8, 347949, nil, nil, nil, 3)--30.8-32
local timerArmedSecurityCD			= mod:NewCDTimer(34.4, 346204, nil, nil, nil, 6)--Only initial, More work is needed to correct timer aroound containment pausing the ability
--local timerImpoundContrabandCD		= mod:NewCDTimer(26.7, 345770, nil, nil, nil, 3)--Can't be cast if containment is still active
--local timerStichNeedleCD			= mod:NewAITimer(15.8, 320200, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--Basically spammed

function mod:OnCombatStart(delay)
	timerArmedSecurityCD:Start(7.2-delay)
	timerImpoundContrabandCD:Start(18.1-delay)
	timerInterrogationCD:Start(31.6-delay)
	local trashMod = DBM:GetModByName("TazaveshTrash")
	if trashMod then
		trashMod.isTrashModBossFightAllowed = true
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	local trashMod = DBM:GetModByName("TazaveshTrash")
	if trashMod then
		trashMod.isTrashModBossFightAllowed = false
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 346204 then
		warnArmedSecurity:Show()
--		timerArmedSecurityCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 346006 then
--		timerImpoundContrabandCD:Start()--Not reliable beyond first cast
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 347949 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnInterrogation:Show()
			specWarnInterrogation:Play("targetyou")
			yellInterrogation:Yell()
		else
			specWarnInterrogationOther:Show()
			specWarnInterrogationOther:Play("targetchange")
		end
	elseif spellId == 348128 then
		warnFullyArmed:Show()
	elseif spellId == 345770 then
		warnInpoundContraband:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnInpoundContraband:Show()
			specWarnInpoundContraband:Play("targetyou")
		end
	elseif spellId == 345990 then
		if args:IsPlayer() then
			specWarnContainmentCell:Show()
			specWarnContainmentCell:Play("targetyou")
		else
			warnContainmentCell:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 then
		if args:IsPlayer() then
			warnInpoundContrabandEnded:Show()
		end
	elseif spellId == 345990 then--Containment Cell
		timerInterrogationCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
