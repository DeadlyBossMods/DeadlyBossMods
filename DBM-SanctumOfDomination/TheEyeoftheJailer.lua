local mod	= DBM:NewMod(2442, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(179128)
mod:SetEncounterID(2433)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350803 350828 349979 348074 348117 349030 349031 350847 350816 350764 355914",
	"SPELL_CAST_SUCCESS 350604 350028 350713",
	"SPELL_AURA_APPLIED 351143 350604 354004 350034 351825 350713 348969",
	"SPELL_AURA_APPLIED_DOSE 348969",
	"SPELL_AURA_REMOVED 351825"
--	"SPELL_PERIODIC_DAMAGE 352559",
--	"SPELL_PERIODIC_MISSED 352559",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Eye Bolt? probably just random damage to give healers something to do. https://ptr.wowhead.com/spell=348054/eye-bolt
--TODO, Stygian Abductors spawn detection
--TODO, more with dragging chains if they need timer or more refined alerts
--TODO, likely fix Titanic Death Gaze cast trigger
--TODO, verify Desolation Beam target scanner and improve it if it works (don't want to invest extra time into it if it doesn't)
--TODO, GTFO the right ID, https://ptr.wowhead.com/spell=352559/jailers-misery or https://ptr.wowhead.com/spell=350809/jailers-misery
--TODO, Deathseeker Eye timers, are they synced or independant?
--TODO, https://ptr.wowhead.com/spell=351835/slothful-corruption instead? doesn't match journal though
--TODO, speed up Scorn and Ire, technically where yell code is right now is kinda useless, it needs to be a pre warning, it likely has a pre warning via EMOTE whisper to players
--TODO, more work with https://ptr.wowhead.com/spell=355232/scorn-and-ire
--TODO, better phase change detection than debuff, if that's even correct, may be wrong spellId
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: His Gaze Upon You
--local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnPiercingLens								= mod:NewCastAnnounce(350803, 2)
local warnDraggingChains							= mod:NewCastAnnounce(349979, 2)
local warnAssailingLance							= mod:NewCastAnnounce(348074, 4)
local warnHopelessLethargy							= mod:NewTargetAnnounce(350604, 2)--Mythic
--Stage Two: Double Vision
local warnDesolationBeam							= mod:NewTargetNoFilterAnnounce(350847, 2)
local warnShatteredSoul								= mod:NewTargetAnnounce(350034, 2)
local warnSlothfulCorruption						= mod:NewTargetNoFilterAnnounce(350713, 2, nil, "RemoveMagic")
local warnSpreadingMisery							= mod:NewCastAnnounce(350816, 2)
--Stage Three: Immediate Extermination
local warnImmediateExtermination					= mod:NewCountAnnounce(348969, 2)

--Stage One: His Gaze Upon You
--local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
local specWarnDeathlink								= mod:NewSpecialWarningDefensive(350828, nil, nil, nil, 3, 2)
local specWarnDeathlinkTaunt						= mod:NewSpecialWarningTaunt(351143, nil, nil, nil, 1, 2)
local specWarnDraggingChains						= mod:NewSpecialWarningSpell(349979, nil, nil, nil, 1, 2)
local specWarnHopelessLethargy						= mod:NewSpecialWarningMoveAway(350604, nil, nil, nil, 1, 2, 4)--Mythic
local yellHopelessLethargy							= mod:NewYell(350604)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Stage Two: Double Vision
local specWarnTitanicDeathGaze						= mod:NewSpecialWarningSpell(349028, nil, nil, nil, 2, 2)
local specWarnDesolationBeam						= mod:NewSpecialWarningMoveAway(350847, nil, nil, nil, 1, 2)
local yellDesolationBeam							= mod:NewYell(350847)
local yellDesolationBeamFades						= mod:NewShortFadesYell(350847)
local specWarnShatteredSoul							= mod:NewSpecialWarningYou(354004, nil, nil, nil, 1, 2)--Debuff of Soul Shatter
local specWarnSlothfulCorruption					= mod:NewSpecialWarningYou(350713, nil, nil, nil, 1, 2)
local yellScornandIre								= mod:NewIconRepeatYell(355232)--Mythic

local specWarnAnnihilatingGlare						= mod:NewSpecialWarningDodge(350764, nil, nil, nil, 3, 2)

--mod:AddTimerLine(BOSS)
--Stage One: His Gaze Upon You
local timerPiercingLenseCD						= mod:NewAITimer(17.8, 350803, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerDeathlinkCD							= mod:NewAITimer(17.8, 350828, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.DEADLY_ICON..DBM_CORE_L.TANK_ICON)
--local timerStygianAbductorCD					= mod:NewAITimer(23, 346767, nil, nil, nil, 3, nil, nil, nil, 1, 3)--Not actual spellID, but compatible one
local timerAssailingLanceCD						= mod:NewAITimer(17.8, 348074, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.DEADLY_ICON..DBM_CORE_L.TANK_ICON)
local timerHopelessLethargyCD					= mod:NewAITimer(23, 350604, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
--Stage Two: Double Vision
local timerTitanticDeathGazeCD					= mod:NewAITimer(23, 349028, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerDesolationBeamCD						= mod:NewAITimer(23, 350847, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerSoulShatterCD						= mod:NewAITimer(23, 350028, nil, nil, nil, 3)
----Deathseeker Eye
local timerSlothfulCorruptionCD					= mod:NewAITimer(23, 350713, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerSpreadingMiseryCD					= mod:NewAITimer(23, 350816, nil, nil, nil, 3)
--Stage Three: Immediate Extermination
local timerAnnihilatingGlareCD					= mod:NewAITimer(23, 350764, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
--mod:AddSetIconOption("SetIconOnEcholocation", 342077, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnSharedSuffering", 351825)

mod.vb.phase = 1

local function scornandIreYellRepeater(self, text, runTimes)
	yellScornandIre:Yell(text)
	runTimes = runTimes + 1
	if runTimes < 3 then
		self:Schedule(2, scornandIreYellRepeater, self, text, runTimes)
	end
end

function mod:DesolationBeam(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDesolationBeam:Show()
		specWarnDesolationBeam:Play("targetyou")
		yellDesolationBeam:Yell()
		yellDesolationBeamFades:Countdown(6-scanningTime)
	else
		warnDesolationBeam:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerPiercingLenseCD:Start(1-delay)
	timerDeathlinkCD:Start(1-delay)
--	timerStygianAbductorCD:Start(1-delay)
	if self:IsMythic() then
		timerHopelessLethargyCD:Start(1-delay)
	end
--	berserkTimer:Start(-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnSharedSuffering then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnSharedSuffering then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350803 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnPiercingLens:Show()
		end
		if args:GetSrcCreatureID() == 179128 then--Main boss
			timerPiercingLenseCD:Start()
		--else--Deathseeker Eyes
			--timerPiercingLenseCD:Start()
		end
	elseif spellId == 350828 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnDeathlink:Show()
			specWarnDeathlink:Play("defensive")
		end
		timerDeathlinkCD:Start()
	elseif spellId == 349979 then
		if self.Options.SpecWarn349979spell then
			specWarnDraggingChains:Show()
			specWarnDraggingChains:Play("specialsoon")
		else
			warnDraggingChains:Show()
		end
	elseif spellId == 348074 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnAssailingLance:Show()
		end
		timerAssailingLanceCD:Start()
	elseif spellId == 348117 then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerPiercingLenseCD:Stop()
		timerDeathlinkCD:Stop()
		--timerStygianAbductorCD:Stop()
		timerHopelessLethargyCD:Stop()
		--Eye of the Jailer
		timerTitanticDeathGazeCD:Start(2)
		timerDesolationBeamCD:Start(2)
		timerSoulShatterCD:Start(2)
		--Deathseeker Eyes (are they synced?)
		timerSlothfulCorruptionCD:Start(2)
		timerSpreadingMiseryCD:Start(2)
	elseif spellId == 349030 or spellId == 349031 then
		specWarnTitanicDeathGaze:Show()
		specWarnTitanicDeathGaze:Play("aesoon")
		timerTitanticDeathGazeCD:Start()
	elseif spellId == 350847 or spellId == 355914 then
		timerDesolationBeamCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DesolationBeam", 0.2, 8, true)
	elseif spellId == 350816 and self:AntiSpam(3, 1) then--TODO, remove antispam if they don't cast it at same time
		warnSpreadingMisery:Show()
		timerSpreadingMiseryCD:Start()
	elseif spellId == 350764 then
		specWarnAnnihilatingGlare:Show()
		specWarnAnnihilatingGlare:Play("laserrun")
		timerAnnihilatingGlareCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350604 then
		timerHopelessLethargyCD:Start()
	elseif spellId == 350028 then
		timerSoulShatterCD:Start()
	elseif spellId == 350713 and self:AntiSpam(3, 2) then
		timerSlothfulCorruptionCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 351143 then
		if not args:IsPlayer() then
			specWarnDeathlinkTaunt:Show(args.destName)
			specWarnDeathlinkTaunt:Play("tauntboss")
		end
	elseif spellId == 350604 then
		warnHopelessLethargy:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnHopelessLethargy:Show()
			specWarnHopelessLethargy:Play("runout")
			yellHopelessLethargy:Yell()
		end
	elseif spellId == 354004 or spellId == 350034 then
		warnShatteredSoul:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShatteredSoul:Show()
			specWarnShatteredSoul:Play("targetyou")
		end
	elseif spellId == 351825 then
		if self.Options.NPAuraOnSharedSuffering then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350713 then
		warnSlothfulCorruption:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSlothfulCorruption:Show()
			specWarnSlothfulCorruption:Play("targetyou")
		end
	elseif spellId == 355240 then--Scorn
		if args:IsPlayer() then
			self:Schedule(2, scornandIreYellRepeater, self, 2, 0)
			yellScornandIre:Yell(2)--Orange Circle
		end
	elseif spellId == 355245 then--Ire
		if args:IsPlayer() then
			self:Schedule(2, scornandIreYellRepeater, self, 3, 0)
			yellScornandIre:Yell(3)--Purple Diamond
		end
	elseif spellId == 348969 then----Immedite Extermination stacks
		if self.vb.phase < 3 then
			self.vb.phase = 3
			--Eye of the Jailer
			timerTitanticDeathGazeCD:Stop()
			timerDesolationBeamCD:Stop()
			timerSoulShatterCD:Stop()
			--Deathseeker Eyes
			timerSlothfulCorruptionCD:Stop()
			timerSpreadingMiseryCD:Stop()

			timerPiercingLenseCD:Start(3)
			timerDeathlinkCD:Start(3)
			timerDesolationBeamCD:Start(3)
			timerSoulShatterCD:Start(3)
			timerAnnihilatingGlareCD:Start(3)
			--timerStygianAbductorCD:Start(3)
			if self:IsMythic() then
				timerHopelessLethargyCD:Start(3)
			end
		end
		if args:IsPlayer() then
			warnImmediateExtermination:Show(args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 351825 then
		if self.Options.NPAuraOnSharedSuffering then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
