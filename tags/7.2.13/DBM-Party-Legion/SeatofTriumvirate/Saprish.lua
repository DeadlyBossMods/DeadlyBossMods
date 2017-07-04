local mod	= DBM:NewMod(1980, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124872)
mod:SetEncounterID(2066)
mod:SetZone()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnSubmerged						= mod:NewTargetAnnounce(196947, 2)

local specWarnSubmergedOver				= mod:NewSpecialWarningEnd(196947)
local specWarnTorrent					= mod:NewSpecialWarningInterrupt(198495, "HasInterrupt", nil, nil, 1, 2)

local timerTaintofSeaCD					= mod:NewAITimer(12, 197262, nil, nil, nil, 3)
--local timerTorrentCD					= mod:NewCDTimer(9.7, 198495, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

local countdownBreath					= mod:NewCountdown(22, 227233)

local voiceBrackwaterBarrage			= mod:NewVoice(202088)--breathsoon
local voiceTorrent						= mod:NewVoice(198495, "HasInterrupt")--kickcast

mod.vb.phase = 1

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227233 then

	elseif spellId == 198495 then
		timerTorrentCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnTorrent:Show(args.sourceName)
			voiceTorrent:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196947 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196947 then
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 197596 then

	end
end
--]]
