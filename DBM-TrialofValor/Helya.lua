local mod	= DBM:NewMod(1829, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(100497)
mod:SetEncounterID(2008)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227967 228730 228032 228514 228390 228565",
	"SPELL_CAST_SUCCESS 229119",
	"SPELL_AURA_APPLIED 229119 227982 193367 228519 232488",
	"SPELL_AURA_REMOVED 193367",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--TODO, warn who for breath?
--TODO, orb icons, etc. Need to know number of orbs/targets.
--TODO, see if tank filter on taunt warning is needed and refine tank warnings.
--TODO, figure out what to do with taint of sea. Not drycoding that, WAY too many spellids to guess correctly. Add range finder for it?
--TODO, fix fury of the maw
--TODO, figure out what to do with Torrent
--TOOD, figure out what to do with Gripping Tentacle
--TODO, figure out what to do with Lantern of Darkness (Night Watch Mariner)
--TODO, figure out what to do with Ghostly Rage (Night Watch Mariner)
--TODO, figure out what to do with Give no Quarter (Night Watch Mariner)
--TODO, add Helarjer Mistcaller stuff for mythic
--TODO, more work with Corrupted Axion and Dark Hatred
--Stage One: Low Tide
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnTorrent					= mod:NewSpellAnnounce(228514, 3)
--Stage Two: From the Mists (65%)
----Helya
--local GrippingTentacle				= mod:NewSpellAnnounce(228797, 3)
----Grimelord
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnFetidRot					= mod:NewSpellAnnounce(193367, 3)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local warnDarkHatred				= mod:NewTargetAnnounce(232488, 3)

--Stage One: Low Tide
local specWarnOrbOfCorruption		= mod:NewSpecialWarningYou(229119, nil, nil, nil, 1)
local yellOrbOfCorruption			= mod:NewYell(229119)
local specWarnBilewaterBreath		= mod:NewSpecialWarningSpell(227967, nil, nil, nil, 2)
local specWarnTentacleStrike		= mod:NewSpecialWarningSpell(228730, nil, nil, nil, 2)
local specWarnBilewaterRedox		= mod:NewSpecialWarningTaunt(227982, nil, nil, nil, 1)
--Stage Two: From the Mists (65%)
----Helya
local specWarnFuryofMaw				= mod:NewSpecialWarningSpell(228032, nil, nil, nil, 2)
----Grimelord
local specWarnSludgeNova			= mod:NewSpecialWarningRun(228390, "Melee", nil, nil, 4, 3)
local specWarnFetidRot				= mod:NewSpecialWarningYou(193367, nil, nil, nil, 1)
local specWarnAnchorSlam			= mod:NewSpecialWarningTaunt(228519, nil, nil, nil, 1)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local specWarnCorruptedBreath		= mod:NewSpecialWarningSpell(228565, nil, nil, nil, 2)

--Stage One: Low Tide
local timerOrbOfCorruptionCD		= mod:NewAITimer(40, 229119, nil, nil, nil, 3)
local timerBilewaterBreathCD		= mod:NewAITimer(40, 227967, nil, nil, nil, 3)
local timerTentacleStrikeCD			= mod:NewAITimer(40, 228730, nil, nil, nil, 2)
--Stage Two: From the Mists (65%)
--local timerFuryofMaw				= mod:NewBuffActiveTimer(40, 228032, nil, nil, nil, 2)
----Helya
local timerFuryofMawCD				= mod:NewAITimer(40, 228032, nil, nil, nil, 2)
----Grimelord
local timerSludgeNovaCD				= mod:NewAITimer(40, 228390, nil, "Melee", nil, 2)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local timerCorruptedBreathCD		= mod:NewAITimer(40, 228565, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(300)

--Stage One: Low Tide
--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)
--Stage Two: From the Mists (65%)
--Stage Three: Helheim's Last Stand (unkonwn %)

--Stage One: Low Tide
--Stage Two: From the Mists (65%)
----Grimelord
local voiceSludgeNova				= mod:NewVoice(228390, "Melee")--runout
--Stage Three: Helheim's Last Stand (unkonwn %)

mod:AddRangeFrameOption(5, 193367)

function mod:OnCombatStart(delay)
	timerOrbOfCorruptionCD:Start(1-delay)
	timerBilewaterBreathCD:Start(1-delay)
	timerTentacleStrikeCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227967 then
		specWarnBilewaterBreath:Show()
		timerBilewaterBreathCD:Start()
	elseif spellId == 228730 then
		specWarnTentacleStrike:Show()
		timerTentacleStrikeCD:Start()
	elseif spellId == 228032 then--Doubt this is correct spellId or event.
		specWarnFuryofMaw:Show()
		--timerFuryofMaw:Start()
		timerFuryofMawCD:Start()--Move this to fury of maw ending with better events
	elseif spellId == 228514 then
		warnTorrent:Show()
	elseif spellId == 228390 then
		specWarnSludgeNova:Show()
		voiceSludgeNova:Play("runout")
		timerSludgeNovaCD:Start()
	elseif spellId == 228565 then
		specWarnCorruptedBreath:Show()
		timerCorruptedBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 229119 then
		timerOrbOfCorruptionCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 229119 then
		warnOrbOfCorruption:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOrbOfCorruption:Show()
			yellOrbOfCorruption:Yell()
		end
	elseif spellId == 227982 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBilewaterRedox:Show(args.destName)
			end
		end
	elseif spellId == 228519 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnAnchorSlam:Show(args.destName)
			end
		end
	elseif spellId == 193367 then
		warnFetidRot:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFetidRot:Show()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 232488 then
		warnDarkHatred:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193367 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114709 then--GrimeLord
		timerSludgeNovaCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
