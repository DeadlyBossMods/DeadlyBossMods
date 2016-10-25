local mod	= DBM:NewMod(1835, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114262)
mod:SetEncounterID(1960)--Verify
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227363 227365 227339 227493 228852",
	"SPELL_CAST_SUCCESS 228852"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

--TODO: add support for Intangible Presence once it's determined what spellIDs do what
--TODO, phase change detection for timer updates
--local warnBloodFrenzy				= mod:NewSpellAnnounce(198388, 4)

local specWarnMightyStomp			= mod:NewSpecialWarningCast(227363, "SpellCaster", nil, nil, 1, 2)
local specWarnSpectralCharge		= mod:NewSpecialWarningDodge(227365, nil, nil, nil, 2, 2)
--On Foot
local specWarnMezair				= mod:NewSpecialWarningDodge(227339, nil, nil, nil, 1, 2)
local specWarnMortalStrike			= mod:NewSpecialWarningDefensive(227493, "Tank", nil, nil, 2, 2)
local specWarnSharedSuffering		= mod:NewSpecialWarningMoveTo(228852, nil, nil, nil, 3, 2)
local specWarnSharedSufferingOver	= mod:NewSpecialWarningMoveAway(228852, nil, nil, nil, 1, 2)
local yellSharedSuffering			= mod:NewYell(228852)

local timerMightyStompCD			= mod:NewAITimer(40, 227363, nil, nil, nil, 2)
local timerSpectralChargeCD			= mod:NewAITimer(40, 227365, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voiceMightyStomp				= mod:NewVoice(227363, "SpellCaster")--stopcast
local voiceSpectralcharge			= mod:NewVoice(227365)--watchstep
--On Foot
local voiceMezair					= mod:NewVoice(227339)--chargemove
local voiceMortalStrike				= mod:NewVoice(227493, "Tank")--defensive
local voiceSharedSuffering			= mod:NewVoice(228852)--defensive

mod:AddSetIconOption("SetIconOnSharedSuffering", 228852, true)

function mod:OnCombatStart(delay)
	timerMightyStompCD:Start(1-delay)
	timerSpectralChargeCD:Start(1-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227363 then
		specWarnMightyStomp:Show()
		voiceMightyStomp:Play("stopcast")
		timerMightyStompCD:Start()
	elseif spellId == 227365 then
		specWarnSpectralCharge:Show()
		voiceSpectralcharge:Play("watchstep")
		timerSpectralChargeCD:Start()
	elseif spellId == 227339 then
		specWarnMezair:Show()
		voiceMezair:Play("chargemove")
	elseif spellId == 227493 then
		specWarnMortalStrike:Show()
		voiceMortalStrike:Play("defensive")
	elseif spellId == 228852 then
		local targetName = TANK
		local unitIsPlayer = false
		for uId in DBM:GetGroupMembers() do
			if self:IsTanking(uId) then
				targetName = UnitName(uId)
				if UnitIsUnit("player", uId) then
					unitIsPlayer = true
				end
				if self.Options.SetIconOnSharedSuffering then
					self:SetIcon(args.destName, 1, 4)
				end
				break
			end
		end
		if unitIsPlayer then
			yellSharedSuffering:Yell()
		else
			specWarnSharedSuffering:Show(targetName)
			voiceSharedSuffering:Play("gathershare")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 228852 then
		specWarnSharedSufferingOver:Show()
		voiceSharedSuffering:Play("scatter")
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
