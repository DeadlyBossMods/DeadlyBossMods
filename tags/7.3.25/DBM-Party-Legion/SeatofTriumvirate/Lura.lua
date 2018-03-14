local mod	= DBM:NewMod(1982, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124870)--124745 Greater Rift Warden
mod:SetEncounterID(2068)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247795 245164 249009",
	"SPELL_CAST_SUCCESS 247930",
	"SPELL_AURA_APPLIED 247816 248535",
	"SPELL_AURA_REMOVED 247816",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more timer work, with good english mythic or mythic+ transcriptor logs with start/stop properly used
--TODO, start grand shift timer on phase 2 trigger on mythic/mythic+ only
--TODO, RP timer
local warnBacklash						= mod:NewTargetAnnounce(247816, 1)
local warnNaarusLamen					= mod:NewTargetAnnounce(248535, 2)

local specWarnCalltoVoid				= mod:NewSpecialWarningSwitch(247795, nil, nil, nil, 1, 2)
local specWarnFragmentOfDespair			= mod:NewSpecialWarningSpell(245164, nil, nil, nil, 1, 2)
local specWarnGrandShift				= mod:NewSpecialWarningDodge(249009, nil, nil, nil, 2, 2)

--local timerCalltoVoidCD					= mod:NewAITimer(12, 247795, nil, nil, nil, 1)
local timerGrandShiftCD					= mod:NewCDTimer(14.6, 249009, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerUmbralCadenceCD				= mod:NewCDTimer(10.9, 247930, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerBacklash						= mod:NewBuffActiveTimer(12.5, 247816, nil, nil, nil, 6)

--local countdownBreath					= mod:NewCountdown(22, 227233)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	--timerCalltoVoidCD:Start(1-delay)--Done instantly
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247795 then
		specWarnCalltoVoid:Show()
		specWarnCalltoVoid:Play("killmob")
		--timerCalltoVoidCD:Start()
	elseif spellId == 245164 and self:AntiSpam(3, 1) then
		specWarnFragmentOfDespair:Show()
		specWarnFragmentOfDespair:Play("helpsoak")
	elseif spellId == 249009 then
		specWarnGrandShift:Show()
		specWarnGrandShift:Play("watchstep")
		timerGrandShiftCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247930 then
		timerUmbralCadenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247816 then--Backlash
		warnBacklash:Show(args.destName)
		timerBacklash:Start()
		--Pause Timers?
	elseif spellId == 248535 then
		warnNaarusLamen:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 247816 then--Backlash
		timerBacklash:Stop()
		--Resume timers?
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 250011 then--Alleria Describes L'ura Conversation

	end
end
--]]
