local mod	= DBM:NewMod(1982, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124870)--124745 Greater Rift Warden
mod:SetEncounterID(2068)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247795 245164 249009",
	"SPELL_AURA_APPLIED 247816",
	"SPELL_AURA_REMOVED 247816",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Warn better phase detection to cancel call to void timer
--TODO, review throttling for fragments of despair and review adding per add timer for it maybe if it's not cast that often
--TODO, what to do with aoe abilities like Umbral Cadence and Naaru's Lament
--TODO, start grand shift timer on phase 2 trigger on mythic/mythic+ only
local warnBacklash						= mod:NewTargetAnnounce(247816, 1)

local specWarnCalltoVoid				= mod:NewSpecialWarningSwitch(247795, nil, nil, nil, 1, 2)
local specWarnFragmentOfDespair			= mod:NewSpecialWarningSpell(245164, nil, nil, nil, 1, 2)
local specWarnGrandShift				= mod:NewSpecialWarningDodge(249009, nil, nil, nil, 2, 2)

local timerCalltoVoidCD					= mod:NewAITimer(12, 247795, nil, nil, nil, 1)
local timerGrandShiftCD					= mod:NewAITimer(12, 249009, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerBacklash						= mod:NewBuffActiveTimer(12.5, 247816, nil, nil, nil, 6)

--local countdownBreath					= mod:NewCountdown(22, 227233)

local voiceCalltoVoid					= mod:NewVoice(247795)--killmob
local voiceFragmentOfDespair			= mod:NewVoice(245164)--helpsoak
local voiceGrandShift					= mod:NewVoice(249009)--watchstep

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerCalltoVoidCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247795 then
		specWarnCalltoVoid:Show()
		voiceCalltoVoid:Play("killmob")
		timerCalltoVoidCD:Start()
	elseif spellId == 245164 and self:AntiSpam(3, 1) then
		specWarnFragmentOfDespair:Show()
		voiceFragmentOfDespair:Play("helpsoak")
	elseif spellId == 249009 then
		specWarnGrandShift:Show()
		voiceGrandShift:Play("watchstep")
		voiceGrandShift:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247816 then--Backlash
		warnBacklash:Show(args.destName)
		timerBacklash:Start()
		--Pause Timers?
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
