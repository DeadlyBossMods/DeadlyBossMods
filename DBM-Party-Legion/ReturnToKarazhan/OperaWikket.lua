local mod	= DBM:NewMod(1820, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114284, 114251)
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227776 227477",
	"SPELL_CAST_SUCCESS 227410",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 227416",
	"SPELL_PERIODIC_MISSED 227416"
)

--TODO, info frame tracking players who do not have gravity when aoe cast starts?
--TODO, target scanning any of the bolts and things?
local warnSummonAdds				= mod:NewSpellAnnounce(227477, 2)

local specWarnMagicMagnificent		= mod:NewSpecialWarningMoveTo(227776, nil, nil, nil, 3, 2)
--local yellFocusedGaze				= mod:NewPosYell(198006)
local specWarnWondrousRadiance		= mod:NewSpecialWarningMove(227416, nil, nil, nil, 1, 2)

local timerSummonAddsCD				= mod:NewAITimer(40, 227477, nil, nil, nil, 1)
local timerMagicMagnificentCD		= mod:NewAITimer(40, 198006, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerWondrousRadianceCD		= mod:NewAITimer(40, 227410, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voiceMagicMagnificent			= mod:NewVoice(227776)--findshelter
local voiceWondrousRadiance			= mod:NewVoice(227416)--runaway

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
--mod:AddInfoFrameOption(198108, false)

function mod:OnCombatStart(delay)
	timerMagicMagnificentCD:Start(1-delay)
	timerWondrousRadianceCD:Start(1-delay)
	timerSummonAddsCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227776 then
		specWarnMagicMagnificent:Show(GetSpellInfo(227405))
		voiceMagicMagnificent:Play("findshelter")
		timerMagicMagnificentCD:Start()
	elseif spellId == 227477 then
		warnSummonAdds:Show()
		timerSummonAddsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227410 then
		timerWondrousRadianceCD:Start()
	end
end

--[[
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
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227416 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnWondrousRadiance:Show()
		voiceWondrousRadiance:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
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
