local mod	= DBM:NewMod(2442, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175725)
mod:SetEncounterID(2433)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210624000000)--2021-06-24
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350803 350828 348074 349030 349031 350847 350816 351413 355914 348974 350453",
	"SPELL_CAST_SUCCESS 350022 351835",
	"SPELL_AURA_APPLIED 351143 350604 354004 350034 351825 350713 355240 355245 348969 348805 358609 358610",
	"SPELL_AURA_APPLIED_DOSE 348969",
	"SPELL_AURA_REMOVED 351825 348805 355240 355245 358610",
--	"SPELL_PERIODIC_DAMAGE 352559",
--	"SPELL_PERIODIC_MISSED 352559",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Eye Bolt? probably just random damage to give healers something to do. https://ptr.wowhead.com/spell=348054/eye-bolt
--TODO, more with dragging chains if they need timer or more refined alerts
--TODO, GTFO the right ID, https://ptr.wowhead.com/spell=352559/jailers-misery or https://ptr.wowhead.com/spell=350809/jailers-misery
--TODO, more work with https://ptr.wowhead.com/spell=355232/scorn-and-ire ?
--TODO, remove desolation beam redundancy if there is no longer any speed gain to using target scan
--TODO, verify changeover to newly exposed pre chains debuff
--[[
(ability.id = 350828 or ability.id = 349979 or ability.id = 348117 or ability.id = 349030 or ability.id = 349031 or ability.id = 350847 or ability.id = 355914 or ability.id = 351413 or ability.id = 348974 or ability.id = 350816) and type = "begincast"
 or (ability.id = 350604 or ability.id = 350022 or ability.id = 351835) and type = "cast"
 or ability.id = 348805 and (type = "applybuff" or type = "removebuff")
 or ability.id = 350604 and type = "applydebuff"
 or (ability.id = 350803 or ability.id = 350453 or ability.id = 348074) and type = "begincast"
--]]
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: His Gaze Upon You
--local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnPiercingLens								= mod:NewCastAnnounce(350803, 2, nil, nil, false)--Boss effectively spams this every 1-4 seconds
local warnDraggingChains							= mod:NewTargetNoFilterAnnounce(358609, 2)
local warnAssailingLance							= mod:NewCastAnnounce(348074, 4)
local warnHopelessLethargy							= mod:NewTargetNoFilterAnnounce(350604, 2)--Mythic
--Stage Two: Double Vision
local warnTitanicDeathGaze							= mod:NewCountAnnounce(349030, 2)
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
local specWarnDraggingChains						= mod:NewSpecialWarningYou(358609, nil, nil, nil, 1, 2)
local yellDraggingChains							= mod:NewYell(358609)
local specWarnHopelessLethargy						= mod:NewSpecialWarningMoveAway(350604, nil, nil, nil, 1, 2, 4)--Mythic
local yellHopelessLethargy							= mod:NewYell(350604)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Stage Two: Double Vision
local specWarnDesolationBeam						= mod:NewSpecialWarningMoveAway(358610, nil, nil, nil, 1, 2)
local yellDesolationBeam							= mod:NewYell(358610)
local yellDesolationBeamFades						= mod:NewShortFadesYell(358610)
local specWarnShatteredSoul							= mod:NewSpecialWarningYou(354004, nil, nil, nil, 1, 2)--Debuff of Soul Shatter
local specWarnSlothfulCorruption					= mod:NewSpecialWarningYou(350713, nil, nil, nil, 1, 2)
local yellScornandIre								= mod:NewIconRepeatYell(355232)--Mythic

local specWarnAnnihilatingGlare						= mod:NewSpecialWarningDodge(350764, nil, 143444, nil, 3, 2)

--mod:AddTimerLine(BOSS)
--Stage One: His Gaze Upon You
local timerDeathlinkCD							= mod:NewCDCountTimer(10.9, 350828, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.DEADLY_ICON..DBM_CORE_L.TANK_ICON)
local timerHopelessLethargyCD					= mod:NewCDCountTimer(20.2, 350604, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
local timerSoulShatterCD						= mod:NewCDCountTimer(23, 350022, nil, nil, nil, 3)
local timerStygianAbductorCD					= mod:NewCDCountTimer(20.6, 346767, nil, nil, nil, 3, nil, nil, nil, 1, 3)--Not actual spellID, but compatible one
----Add
local timerAssailingLanceCD						= mod:NewCDTimer(8.5, 348074, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.DEADLY_ICON..DBM_CORE_L.TANK_ICON)--Add
--Stage Two: Double Vision
local timerTitanticDeathGazeCD					= mod:NewCDCountTimer(32.9, 349030, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerDesolationBeamCD						= mod:NewCDCountTimer(17, 350847, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--17-18.3
local timerScornandIreCD						= mod:NewCDTimer(12.1, 355232, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
----Deathseeker Eye
local timerSlothfulCorruptionCD					= mod:NewCDTimer(24.2, 350713, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerSpreadingMiseryCD					= mod:NewCDTimer(12.1, 350816, nil, nil, nil, 3)
--Stage Three: Immediate Extermination
local timerAnnihilatingGlareCD					= mod:NewCDCountTimer(23, 350764, 143444, nil, nil, 3)--actual CD between casts unknown

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
--mod:AddSetIconOption("SetIconOnEcholocation", 342077, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnSharedSuffering", 351825)
mod:AddBoolOption("ContinueRepeating", false)

mod.vb.gazeCount = 0
mod.vb.beamCount = 0
mod.vb.deathlinkCount = 0
mod.vb.lethargyCount = 0
mod.vb.shatterCount = 0
mod.vb.abductorCount = 0
mod.vb.glareCount = 0

local function scornandIreYellRepeater(self, text, runTimes)
	yellScornandIre:Yell(text)
	runTimes = runTimes + 1
	if self.Options.ContinueRepeating or runTimes < 3 then
		self:Schedule(2, scornandIreYellRepeater, self, text, runTimes)
	end
end

function mod:DesolationBeam(targetname, uId, bossuid)--scanningTime
	if not targetname then return end
	if self:AntiSpam(5, targetname) then
		if targetname == UnitName("player") then
			specWarnDesolationBeam:Show()
			specWarnDesolationBeam:Play("targetyou")
			yellDesolationBeam:Yell()
			yellDesolationBeamFades:Countdown(6)
		else
			warnDesolationBeam:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.gazeCount = 0
	self.vb.beamCount = 0
	self.vb.lethargyCount = 0
	self.vb.shatterCount = 0
	self.vb.deathlinkCount = 0
	self.vb.abductorCount = 0
	self.vb.glareCount = 0
	timerDeathlinkCD:Start(7-delay, 1)
	timerStygianAbductorCD:Start(9.7-delay, 1)
	timerSoulShatterCD:Start(10.8-delay, 1)
	timerAnnihilatingGlareCD:Start(25.2-delay, 1)--ReCheck heroic, it coming earlier on mythic may just be a mythic thing
	if self:IsMythic() then
		timerHopelessLethargyCD:Start(9.4-delay, 1)
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
	if spellId == 350803 or spellId == 350453 then--350453 Adds, 350803 Boss
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnPiercingLens:Show()
		end
	elseif spellId == 350828 then
		self.vb.deathlinkCount = self.vb.deathlinkCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnDeathlink:Show()
			specWarnDeathlink:Play("defensive")
		end
		timerDeathlinkCD:Start(nil, self.vb.deathlinkCount+1)
	elseif spellId == 348074 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnAssailingLance:Show()
		end
		timerAssailingLanceCD:Start(8.5, args.sourceGUID)
	elseif spellId == 349030 or spellId == 349031 then--349030 confirmed, 349031 unknown
		self.vb.gazeCount = self.vb.gazeCount + 1
		warnTitanicDeathGaze:Show(self.vb.gazeCount)
		timerTitanticDeathGazeCD:Start(nil, self.vb.gazeCount+1)
	elseif spellId == 350847 or spellId == 355914 then
		self.vb.beamCount = self.vb.beamCount + 1
		timerDesolationBeamCD:Start(nil, self.vb.beamCount+1)
--		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DesolationBeam", 0.2, 8, true)
	elseif spellId == 350816 then--TODO, remove antispam if they don't cast it at same time
		warnSpreadingMisery:Show()
		timerSpreadingMiseryCD:Start(nil, args.sourceGUID)
	elseif spellId == 351413 then
		self.vb.glareCount = self.vb.glareCount + 1
		specWarnAnnihilatingGlare:Show()
		specWarnAnnihilatingGlare:Play("laserrun")
		timerAnnihilatingGlareCD:Start(70, self.vb.glareCount+1)
	elseif spellId == 348974 then--Immediate Extermination (10sec cast)
		if self.vb.phase < 3 then
			self:SetStage(3)
			self.vb.lethargyCount = 0
			self.vb.shatterCount = 0
			self.vb.deathlinkCount = 0
			self.vb.abductorCount = 0
			self.vb.beamCount = 0
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--Eye of the Jailer
			timerDeathlinkCD:Stop()
			timerTitanticDeathGazeCD:Stop()
			timerDesolationBeamCD:Stop()
			timerSoulShatterCD:Stop()
			--Deathseeker Eyes
			timerSlothfulCorruptionCD:Stop()
			timerSpreadingMiseryCD:Stop()

			timerDeathlinkCD:Start(11.5, 1)
			timerSoulShatterCD:Start(16.3, 1)
			timerDesolationBeamCD:Start(20, 1)
			timerStygianAbductorCD:Start(27.7, 1)--VERIFY with trancsriptor
			if self:IsMythic() then
				--timerHopelessLethargyCD:Start(13.6, 1)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350022 then
		--Phase 2 is 15.8-18
		self.vb.shatterCount = self.vb.shatterCount + 1
		timerSoulShatterCD:Start(self.vb.phase == 2 and 15 or self.vb.phase == 1 and 10.9, self.vb.shatterCount+1)
	elseif spellId == 351835 then
		timerSlothfulCorruptionCD:Start(nil, args.sourceGUID)--Cast only once?
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
	elseif spellId == 354004 or spellId == 350034 then--Heroic/Mythic 350034 Confirmed. 354004 probably normal/LFR
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
	elseif spellId == 348969 then----Immediate Extermination stacks
		if args:IsPlayer() then
			warnImmediateExtermination:Show(args.amount or 1)
		end
	elseif spellId == 358609 then
		warnDraggingChains:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDraggingChains:Show()
			specWarnDraggingChains:Play("targetyou")
			yellDraggingChains:Yell()
		end
	elseif spellId == 358610 and self:AntiSpam(5, args.destName) then
		if args:IsPlayer() then
			specWarnDesolationBeam:Show()
			specWarnDesolationBeam:Play("targetyou")
			yellDesolationBeam:Yell()
			yellDesolationBeamFades:Countdown(spellId)
		else
			warnDesolationBeam:Show(args.destName)
		end
	elseif spellId == 348805 then--Stygian Darkshield (Entering Adds phase)
		timerAnnihilatingGlareCD:Pause(self.vb.glareCount+1)
		self:SetStage(2)
		self.vb.gazeCount = 0--Still used during intermisison
		self.vb.shatterCount = 0--Still used during intermisison
		self.vb.beamCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerDeathlinkCD:Stop()
		timerStygianAbductorCD:Stop()
		timerSoulShatterCD:Stop()
		timerHopelessLethargyCD:Stop()
		--Eye of the Jailer
		timerDesolationBeamCD:Start(8.4, 1)--RECHECK ME
		timerSoulShatterCD:Start(14, 1)--RECHECK ME
		timerTitanticDeathGazeCD:Start(18)--RECHECK ME
		--Deathseeker Eyes (are they synced?)
		timerSpreadingMiseryCD:Start(11.7)--Don't nessesarily sync up first cast, it's approx
		timerSlothfulCorruptionCD:Start(19.6)--Don't nessesarily sync up first cast, it's approx
		if self:IsMythic() then
			timerScornandIreCD:Start(12)
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
	elseif spellId == 348805 then--Stygian Darkshield (Exiting Adds phase)
		timerAnnihilatingGlareCD:Resume(self.vb.glareCount+1)--Happens regardless of going back into stage 1 or into stage 3
		if self.vb.phase == 2 then
			self:SetStage(1)
			self.vb.lethargyCount = 0
			self.vb.shatterCount = 0
			self.vb.deathlinkCount = 0
			self.vb.abductorCount = 0
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
			warnPhase:Play("pone")
			--Eye of the Jailer
			timerTitanticDeathGazeCD:Stop()
			timerDesolationBeamCD:Stop()
			timerSoulShatterCD:Stop()
			--Deathseeker Eyes
			timerSlothfulCorruptionCD:Stop()
			timerSpreadingMiseryCD:Stop()
			--Eye of the Jailer
			if self:IsMythic() then
				--Pretty much all of these can be delayed by spell queue with one another
				timerDeathlinkCD:Start(10.4, 1)--Usually 20ish when you get common order
				timerSoulShatterCD:Start(11.3, 1)--Usually 14ish when you get the common order
				timerStygianAbductorCD:Start(11.7, 1)
				timerHopelessLethargyCD:Start(11.7, 1)--fairly consistent but with a 1 second variance, and that variance throws chaos into deathlink and souls hatter orders
			else--Non mythic is less likely to run into spell queue issues and be little more consistent without Hopeless Lethargy
				timerDeathlinkCD:Start(10.4, 1)
				timerStygianAbductorCD:Start(11.7, 1)--VERIFY ME with transcriptor
				timerSoulShatterCD:Start(16.5, 1)
			end
		end
	elseif spellId == 355240 or spellId == 355245 then--Scorn
		if args:IsPlayer() then
			self:Unschedule(scornandIreYellRepeater)
		end
	elseif spellId == 358610 then
		if args:IsPlayer() then
			yellDesolationBeamFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 176521 then--Flying things
		timerAssailingLanceCD:Stop(args.destGUID)
	elseif cid == 176531 then--Deathstalker Eye
		timerSpreadingMiseryCD:Stop(args.destGUID)
		timerSlothfulCorruptionCD:Stop(args.destGUID)
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
--]]

--"<33.71 00:14:17> [UNIT_SPELLCAST_START] Eye of the Jailer(Ribmuncher) - Desolation Beam - 6s [[boss1:Cast-3-2083-2450-6732-350847-0021146A39:350847]]", -- [672]
--"<33.72 00:14:17> [UNIT_TARGET] boss1#Eye of the Jailer#Target: Twomuchpie#TargetOfTarget: Deathseeker Eye", -- [683]
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 350847 or spellId == 355914 then
		self:BossUnitTargetScanner(uId, "DesolationBeam", 1)
	end
end

--"<194.46 00:16:57> [UNIT_SPELLCAST_SUCCEEDED] Eye of the Jailer(Lonecrusader) -[DNT] Summon Shackler- [[boss1:Cast-3-2083-2450-6732-349957-0010146ADA:349957]]", -- [4817]
--"<199.64 00:17:03> [CLEU] SPELL_AURA_APPLIED#Creature-0-2083-2450-6732-176521-0000146ADA#Stygian Abductor#Player-969-004F2318#Soulmatèstm#349979#Dragging Chains#DEBUFF#nil", -- [5002]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 349957 then--Summon Shackler (Heroic confirmed)
		self.vb.abductorCount = self.vb.abductorCount + 1
		timerStygianAbductorCD:Start(45.4, self.vb.abductorCount+1)
	elseif spellId == 350604 then
		self.vb.lethargyCount = self.vb.lethargyCount + 1
		timerHopelessLethargyCD:Start(nil, self.vb.lethargyCount+1)
	end
end
