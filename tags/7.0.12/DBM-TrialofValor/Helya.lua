local mod	= DBM:NewMod(1829, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114537)
mod:SetEncounterID(2008)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30--None, she doesn't despawn. Remains after a wipe period

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227967 228730 228032 228514 228390 228565",
	"SPELL_CAST_SUCCESS 229119 227967",
	"SPELL_AURA_APPLIED 229119 227982 193367 228519 232488 228054 230267",
	"SPELL_AURA_REMOVED 193367 229119 230267",
	"SPELL_PERIODIC_DAMAGE 227998",
	"SPELL_PERIODIC_MISSED 227998",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Add range finder for Taint of the sea?
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
local warnTaintOfSea				= mod:NewTargetAnnounce(228054, 2)
--
--local warnTorrent					= mod:NewSpellAnnounce(228514, 3)
--Stage Two: From the Mists (65%)
----Helya
--local GrippingTentacle				= mod:NewSpellAnnounce(228797, 3)
----Grimelord
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnFetidRot					= mod:NewSpellAnnounce(193367, 3)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local warnDarkHatred				= mod:NewTargetAnnounce(232488, 3)
local warnOrbOfCorrosion			= mod:NewTargetAnnounce(230267, 3)

--Stage One: Low Tide
local specWarnOrbOfCorruption		= mod:NewSpecialWarningYou(229119, nil, nil, nil, 1, 5)
local yellOrbOfCorruption			= mod:NewPosYell(229119)
local specWarnTaintofSea			= mod:NewSpecialWarningMoveAway(228088, nil, nil, nil, 1, 2)
local specWarnBilewaterBreath		= mod:NewSpecialWarningSpell(227967, nil, nil, nil, 2, 2)
local specWarnBilewaterRedox		= mod:NewSpecialWarningTaunt(227982, nil, nil, nil, 1, 2)
local specWarnBilewaterCorrosion	= mod:NewSpecialWarningMove(227998, nil, nil, nil, 1, 2)
local specWarnTentacleStrike		= mod:NewSpecialWarningSpell(228730, nil, nil, nil, 2)
--Stage Two: From the Mists (65%)
----Helya
local specWarnFuryofMaw				= mod:NewSpecialWarningSpell(228032, nil, nil, nil, 2)
----Grimelord
local specWarnSludgeNova			= mod:NewSpecialWarningRun(228390, "Melee", nil, nil, 4, 3)
local specWarnFetidRot				= mod:NewSpecialWarningYou(193367, nil, nil, nil, 1)
local specWarnAnchorSlam			= mod:NewSpecialWarningTaunt(228519, nil, nil, nil, 1, 2)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local specWarnCorruptedBreath		= mod:NewSpecialWarningSpell(228565, nil, nil, nil, 2)
local specWarnOrbOfCorrosion		= mod:NewSpecialWarningYou(230267, nil, nil, nil, 1, 5)
local yellOrbOfCorrosion			= mod:NewPosYell(230267)

--Stage One: Low Tide
local timerOrbOfCorruptionCD		= mod:NewNextTimer(25, 229119, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTaintOfSeaCD				= mod:NewCDTimer(16.2, 228088, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
local timerBilewaterBreathCD		= mod:NewNextTimer(40, 227967, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--On for everyone though so others avoid it too
local timerTentacleStrikeCD			= mod:NewNextTimer(30, 228730, nil, nil, nil, 2)
local timerExplodingOozes			= mod:NewCastTimer(22.5, 227992, nil, nil, nil, 2, nil, DBM_CORE_DAMAGE_ICON)
--Stage Two: From the Mists (65%)
--local timerFuryofMaw				= mod:NewBuffActiveTimer(40, 228032, nil, nil, nil, 2)
----Helya
local timerFuryofMawCD				= mod:NewAITimer(40, 228032, nil, nil, nil, 2)
----Grimelord
local timerSludgeNovaCD				= mod:NewAITimer(40, 228390, nil, "Melee", nil, 2)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand (unkonwn %)
local timerCorruptedBreathCD		= mod:NewAITimer(40, 228565, nil, nil, nil, 2)
local timerOrbOfCorrosionCD			= mod:NewAITimer(25, 230267, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(300)

--Stage One: Low Tide
local countdownOrbs					= mod:NewCountdown("AltTwo25", 229119)
local countdownOozeExplosions		= mod:NewCountdown(22.5, 227992)
--Stage Two: From the Mists (65%)
--Stage Three: Helheim's Last Stand (unkonwn %)

--Stage One: Low Tide
local voiceOrbofCorruption			= mod:NewVoice(229119)--orbrun
local voiceTaintOfSea				= mod:NewVoice(228088)--scatter?runout?
local voiceBilewaterBreath			= mod:NewVoice(227967)--breathsoon
local voiceBilewaterRedox			= mod:NewVoice(227982)--tauntboss
local voiceBilewaterCorrosion		= mod:NewVoice(227998)--runaway
--Stage Two: From the Mists (65%)
----Grimelord
local voiceSludgeNova				= mod:NewVoice(228390, "Melee")--runout
local voiceAnchorSlam				= mod:NewVoice(228519)--tauntboss (maybe change to "changemt" if this add can be up with boss)
--Stage Three: Helheim's Last Stand (unkonwn %)
local voiceOrbofCorrosion			= mod:NewVoice(230267)--orbrun

mod:AddRangeFrameOption(5, 193367)
mod:AddSetIconOption("SetIconOnOrbs", 229119, true)--Healer (Star), Tank (Circle), Deeps (Diamond)

function mod:OnCombatStart(delay)
	timerOrbOfCorruptionCD:Start(15-delay)--SUCCESS
	countdownOrbs:Start(15-delay)
	timerBilewaterBreathCD:Start(32-delay)
	timerTentacleStrikeCD:Start(41-delay)
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
		voiceBilewaterBreath:Play("breathsoon")
		timerBilewaterBreathCD:Start()
	elseif spellId == 228730 then
		specWarnTentacleStrike:Show()
		timerTentacleStrikeCD:Start()
	elseif spellId == 228032 then--Doubt this is correct spellId or event.
		specWarnFuryofMaw:Show()
		--timerFuryofMaw:Start()
		timerFuryofMawCD:Start()--Move this to fury of maw ending with better events
--	elseif spellId == 228514 then
--		warnTorrent:Show()
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
		countdownOrbs:Start()
	elseif spellId == 230267 then
		timerOrbOfCorrosionCD:Start()
		--countdownOrbs:Start()
	elseif spellId == 227967 then
		--Start ooze stuff here since all their stuff is hidden from combat log
		timerExplodingOozes:Start()
		countdownOozeExplosions:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 229119 then
		warnOrbOfCorruption:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOrbOfCorruption:Show()
			voiceOrbofCorruption:Play("orbrun")
			if self:IsTank() then
				yellOrbOfCorruption:Yell(2, 2, 2)
			elseif self:IsHealer() then
				yellOrbOfCorruption:Yell(1, 1, 1)
			else
				yellOrbOfCorruption:Yell(3, 3, 3)
			end
		end
		if self.Options.SetIconOnOrbs then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				self:SetIcon(args.destName, 2)--Circle
			elseif self:IsHealer(uId) then
				self:SetIcon(args.destName, 1)--Star
			else
				self:SetIcon(args.destName, 3)--Diamond
			end
		end
	elseif spellId == 230267 then
		warnOrbOfCorrosion:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOrbOfCorrosion:Show()
			voiceOrbofCorrosion:Play("orbrun")
			if self:IsTank() then
				yellOrbOfCorrosion:Yell(2, 2, 2)
			elseif self:IsHealer() then
				yellOrbOfCorrosion:Yell(1, 1, 1)
			else
				yellOrbOfCorrosion:Yell(3, 3, 3)
			end
		end
		if self.Options.SetIconOnOrbs then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				self:SetIcon(args.destName, 2)--Circle
			elseif self:IsHealer(uId) then
				self:SetIcon(args.destName, 1)--Star
			else
				self:SetIcon(args.destName, 3)--Diamond
			end
		end
	elseif spellId == 227982 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--Filter numties standing in front of boss that shouldn't be
				specWarnBilewaterRedox:Show(args.destName)
				voiceBilewaterRedox:Play("tauntboss")
			end
		end
	elseif spellId == 228519 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--Filter numties standing in front of boss that shouldn't be
				specWarnAnchorSlam:Show(args.destName)
				voiceAnchorSlam:Play("tauntboss")
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
	elseif spellId == 228054 then
		warnTaintOfSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnTaintofSea:Show()
			voiceTaintOfSea:Play("scatter")
		end
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
	elseif spellId == 229119 then
		if self.Options.SetIconOnOrbs then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227998 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBilewaterCorrosion:Show()
		voiceBilewaterCorrosion:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114709 then--GrimeLord
		timerSludgeNovaCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 228088 then--Taint of Sea
		timerTaintOfSeaCD:Start()
	end
end
