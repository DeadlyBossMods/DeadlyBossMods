local mod	= DBM:NewMod(1979, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124871)
mod:SetEncounterID(2065)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 246134 244579",
	"SPELL_CAST_SUCCESS 244433",
	"SPELL_AURA_APPLIED 244657 244621",
	"SPELL_AURA_REMOVED 244657 244621",
	"SPELL_DAMAGE 244433",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more timer updates, warning tweaks, countdowns
--TODO, personal alternate power and warn when extra action is ready to leave Umbra Shift
--Void Brute
local warnNullPalm						= mod:NewSpellAnnounce(246134, 2, nil, "Tank")
local warnUmbraShift					= mod:NewTargetAnnounce(246134, 3)
local warnFixate						= mod:NewTargetAnnounce(244657, 3)
local warnVoidTear						= mod:NewTargetAnnounce(244621, 1)

local specWarnCoalescedVoid				= mod:NewSpecialWarningSwitch(244602, "Dps", nil, nil, 1, 2)
local specWarnUmbraShift				= mod:NewSpecialWarningYou(244433, nil, nil, nil, 1, 2)
local specWarnFixate					= mod:NewSpecialWarningRun(244657, nil, nil, nil, 4, 2)

local timerNullPalmCD					= mod:NewCDTimer(10.9, 246134, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDeciminateCD					= mod:NewCDTimer(12.1, 244579, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCoalescedVoidCD				= mod:NewCDTimer(12.1, 244579, nil, nil, nil, 1, nil, DBM_CORE_DAMAGER_ICON)
local timerUmbraShiftCD					= mod:NewCDTimer(12, 244433, nil, nil, nil, 6)
local timerVoidTear						= mod:NewBuffActiveTimer(12, 244621, nil, nil, nil, 6)

--local countdownBreath					= mod:NewCountdown(22, 227233)

local voiceCoalescedVoid				= mod:NewVoice(244602)--killmob
local voiceUmbraShift					= mod:NewVoice(244433)--teleyou
local voiceFixate						= mod:NewVoice(244657)--justrun/keepmove

mod:AddSetIconOption("SetIconOnFixate", 244657, true)

function mod:OnCombatStart(delay)
	timerNullPalmCD:Start(10-delay)
	timerDeciminateCD:Start(17.5-delay)
	timerCoalescedVoidCD:Start(19.5-delay)
	timerUmbraShiftCD:Start(40.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 246134 then
		warnNullPalm:Show()
		timerNullPalmCD:Start()
	elseif spellId == 244579 then
		timerDeciminateCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244602 then
		specWarnCoalescedVoid:Show()
		voiceCoalescedVoid:Play("killmob")
		--timerCoalescedVoidCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244657 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			voiceFixate:Play("justrun")
			voiceFixate:Schedule(1, "keepmove")
		else
			warnFixate:Show(args.destName)
		end
		if self.Options.SetIconOnFixate then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 244621 then--Void Tear
		warnVoidTear:Show(args.destName)
		timerVoidTear:Start()
		--Cancel Timers
		timerNullPalmCD:Stop()
		timerDeciminateCD:Stop()
		timerCoalescedVoidCD:Stop()
		timerUmbraShiftCD:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244657 then
		if self.Options.SetIconOnFixate then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 244621 then--Void Tear
		--Resume timers (TODO, need log, for heroic the boss died with this buff)
		--timerNullPalmCD:Start(10)
		--timerDeciminateCD:Start(17.5)
		--timerCoalescedVoidCD:Start(19.5)
		--timerUmbraShiftCD:Start(40.5)
	end
end

function mod:SPELL_DAMAGE(_, _, _, destName, destGUID, _, _, _, spellId)
	if spellId == 244433 then
		if destGUID == UnitGUID("player") then
			specWarnUmbraShift:Show()
			voiceUmbraShift:Play("teleyou")
		else
			warnUmbraShift:Show(destName)
		end
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 247576 then--Umbra Shift
		--timerUmbraShiftCD:Start()
	end
end
