local mod	= DBM:NewMod(1818, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(100497)
mod:SetEncounterID(1959)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnBloodFrenzy				= mod:NewSpellAnnounce(198388, 4)

local specWarnFocusedGaze			= mod:NewSpecialWarningYou(198006, nil, nil, nil, 1, 2)
local yellFocusedGaze				= mod:NewPosYell(198006)

local timerFocusedGazeCD			= mod:NewNextCountTimer(40, 198006, nil, nil, nil, 3)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voiceFocusedGaze				= mod:NewVoice(198006, "-Tank")--targetyou/share

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
--mod:AddInfoFrameOption(198108, false)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197942 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197943 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 198006 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198006 then

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
