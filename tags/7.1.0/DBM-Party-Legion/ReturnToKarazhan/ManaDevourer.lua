local mod	= DBM:NewMod(1818, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(100497)--Has 3 CIDs, figure out which one before enable
mod:SetEncounterID(1959)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227507",
	"SPELL_CAST_SUCCESS 227618",
	"SPELL_AURA_APPLIED 227297"
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO: Energy Discharge warning/timer?
--TODO, arcane bomb and void energy timers/warnings?
local warnArcaneBomb				= mod:NewSpellAnnounce(227618, 4)

local specWarnDecimatingEssence		= mod:NewSpecialWarningSpell(227507, nil, nil, nil, 3, 2)
local specWarnCoalescePower			= mod:NewSpecialWarningMoveTo(227297, nil, nil, nil, 1, 2)
--local yellFocusedGaze				= mod:NewPosYell(198006)

local timerCoalescePowerCD			= mod:NewAITimer(40, 227297, nil, nil, nil, 1)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voiceDecimatingEssence		= mod:NewVoice(227507)--aesoon (is there a voice file for "you fucked up and are going to die"?)
local voiceColaescePower			= mod:NewVoice(227297)--helpsoak

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
mod:AddInfoFrameOption(227502, true)

function mod:OnCombatStart(delay)
	timerCoalescePowerCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(227502))
		DBM.InfoFrame:Show(8, "playerdebuffstacks", 227502)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227507 then
		specWarnDecimatingEssence:Show()
		voiceDecimatingEssence:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227618 then
		warnArcaneBomb:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227297 then
		specWarnCoalescePower:Show(GetSpellInfo(227296))
		voiceColaescePower:Play("helpsoak")
		timerCoalescePowerCD:Start()
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227297 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
