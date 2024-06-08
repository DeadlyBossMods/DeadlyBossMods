local mod	= DBM:NewMod(2608, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(223779, 223781)--Anub'arash, Skeinspinner Takazj
mod:SetEncounterID(2921)
--mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 451016 438677 452231 441626 450129 441782 450483 438355 443068 451327 442994",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 455849 455850 438218 455080 440503 449857 451611 440001 450980 438708 456252 450728 451277 443598",
	"SPELL_AURA_APPLIED_DOSE 438218",
	"SPELL_AURA_REMOVED 455080 451611 450980 451277"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, obviously verify boss IDs
--TODO, are bosses kept spread and swapped like Amalg?
--TODO, target scan charge? ALsos tooltip unclear, should a player soak it to avoid him hitting a wall or is that purely about aiming charge nots soaking?
--TODO, add https://www.wowhead.com/beta/spell=438200/poison-bolt if it's not spammed. Right now I don't want to add it in case it's something boss just does in instead of melee
--TODO, binding webs multi target alerts to alert who you are bound to once it's clear how it's presented in combat log (if it's presented)
--TODO, when a boss phases, does the other boss stop attacking/doing their abilities?
--TODO, stinging swarm seems to have two versions, complex one that reequires dispeling near other boss to interrupt it, and one that's just ordinary debuff (probably LFR version)
--TODO, if stringing swarm doesn't go private aura, add icons and icon based yells for dispel assignments. Not gonna waste time doing it now though when this fight hasn't had PA flagging done yet
--TODO, add https://www.wowhead.com/beta/spell=441775/void-blast if it's not spammed, similar boat to poison bolt
--TODO, maybe Entropic should be a run away warning instead for melee?
--TODO, lots of cleanup of boss mechanics that interrupt other boss mechanics with better clarity and voices
local anubarash, takazj = DBM:EJ_GetSectionInfo(29012), DBM:EJ_GetSectionInfo(29017)
--General Stuff
local specWarnMarkofParanoia					= mod:NewSpecialWarningYou(455849, nil, nil, nil, 1, 17, 4)
local specWarnMarkofRage						= mod:NewSpecialWarningYou(455850, nil, nil, nil, 1, 17, 4)

mod:AddInfoFrameOption(nil, true)--Absorb shield infoframe
--Stage One: Clash of Rivals
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29011))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnPiercingStrike						= mod:NewStackAnnounce(438218, 2)
local warnCalloftheSwarm						= mod:NewCountAnnounce(438801, 2)
local warnImpaled								= mod:NewTargetNoFilterAnnounce(449857, 4)

local specWarnPiercingStrike					= mod:NewSpecialWarningDefensive(438218, nil, nil, nil, 1, 2)
local specWarnRecklessCharge					= mod:NewSpecialWarningCount(440246, nil, nil, nil, 1, 2)--If we can get target, make dodge warning for non target and "move to web" for target
local specWarnImpalingEruption					= mod:NewSpecialWarningYou(440504, nil, nil, nil, 1, 2)
local yellImpalingEruption						= mod:NewShortYell(440504)
local specWarnImpalingEruptionOther				= mod:NewSpecialWarningDodge(440504, nil, nil, nil, 2, 2)
--local yellImpalingEruptionFades				= mod:NewShortFadesYell(440504)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerPiercingStrikeCD						= mod:NewAITimer(49, 438218, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCalloftheSwarmCD						= mod:NewAITimer(49, 438801, nil, nil, nil, 1)
local timerRecklessChargeCD						= mod:NewAITimer(49, 440246, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerImpalingEruptionCD					= mod:NewAITimer(49, 440504, nil, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnPerseverance", 455080, true)
--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVenomousRain						= mod:NewCountAnnounce(438343, 2)
local warnWebBomb							= mod:NewCountAnnounce(439838, 3)--General announce for everyone, personal special announce to target
local warnSkitteringLeap					= mod:NewCountAnnounce(450045, 2)

local specWarnWebBomb						= mod:NewSpecialWarningYou(439838, nil, nil, nil, 1, 2)
local yellWebBomb							= mod:NewShortYell(439838)
local yellWebBombFades						= mod:NewShortFadesYell(439838)
local specWarnBindingWebs					= mod:NewSpecialWarningYou(440001, nil, nil, nil, 1, 2)

local timerVenomousRainCD					= mod:NewAITimer(49, 438343, nil, nil, nil, 3)
local timerWebBombCD						= mod:NewAITimer(49, 439838, nil, nil, nil, 3)
local timerSkitteringLeapCD					= mod:NewAITimer(49, 450045, nil, nil, nil, 3)
--Stage Two: Grasp of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29021))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnStingingSwarm						= mod:NewTargetNoFilterAnnounce(450045, 2)--No Filter because this is a raid wiping mechanic if the 3 players don't get to boss

local specWarnStingingSwarm					= mod:NewSpecialWarningMoveTo(438677, nil, nil, nil, 1, 2)
local yellStingingSwarm						= mod:NewShortYell(438677)

local timerStingingSwarmCD					= mod:NewAITimer(49, 438677, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVoidStep							= mod:NewCountAnnounce(450483, 2)

local specWarnWebVortex						= mod:NewSpecialWarningCount(441626, nil, nil, nil, 2, 2)
local specWarnEntropicDesolation			= mod:NewSpecialWarningCount(450129, nil, nil, nil, 2, 2)
local specWarnStrandsofReality				= mod:NewSpecialWarningDodgeCount(441782, nil, nil, nil, 2, 2)
local specWarnCataclysmicEntropy			= mod:NewSpecialWarningCount(438355, nil, nil, nil, 2, 2)

local timerWebVortexCD						= mod:NewAITimer(49, 441626, nil, nil, nil, 2)
local timerEntropicDesolationCD				= mod:NewAITimer(49, 450129, nil, nil, nil, 2)
local timerStrandsofRealityCD				= mod:NewAITimer(49, 441782, nil, nil, nil, 3)
local timerVoidStepCD						= mod:NewAITimer(49, 450483, nil, nil, nil, 3)
local timerCataclysmicEntropyCD				= mod:NewAITimer(49, 438355, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Three: Unleashed Rage
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29022))
local specWarnEnragedFerocity				= mod:NewSpecialWarningDispel(443598, "RemoveEnrage", nil, nil, 1, 2)
----Anub'arash
mod:AddTimerLine(anubarash)
local specWarnUnleashedSwarm				= mod:NewSpecialWarningCount(442994, nil, nil, nil, 2, 2)

local timerSpikeEruptionCD					= mod:NewAITimer(49, 443068, nil, nil, nil, 3)
local timerUnleashedSwarmCD					= mod:NewAITimer(49, 442994, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerRagingFuryCD						= mod:NewAITimer(49, 451327, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)

mod.vb.swarmCount = 0--Call and stinging only.
mod.vb.chargeCount = 0
mod.vb.eruptionCount = 0--Also used for Spike Eruption
mod.vb.rainCount = 0--Also used for Entropic Desolation
mod.vb.webBombCount = 0--Also web vortex
mod.vb.leapCount = 0--Also used for void step
mod.vb.stingingCount = 0
mod.vb.strandsCount = 0
mod.vb.cataCount = 0
mod.vb.rageCount = 0
mod.vb.unleashedCount = 0
--local nearAnub, nearTakazj = true, true

--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
--[[
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Anub'arash
	if self:CheckBossDistance(223779, true, 32698, 48) then
		if not nearAnub then
			nearAnub = true
			--timerCoalescingVoidCD:SetFade(false, self.vb.coalescingCount+1)
			--timerUmbralDetonationCD:SetFade(false, self.vb.umbralCount+1)
			--timerShadowsConvergenceCD:SetFade(false, self.vb.shadowConvergeCount+1)
			--timerShadowSpikeCD:SetFade(false, self.vb.shadowStrikeCount+1)
		end
	else
		if nearAnub then
			nearAnub = false
			--timerCoalescingVoidCD:SetFade(true, self.vb.coalescingCount+1)
			--timerUmbralDetonationCD:SetFade(true, self.vb.umbralCount+1)
			--timerShadowsConvergenceCD:SetFade(true, self.vb.shadowConvergeCount+1)
			--timerShadowSpikeCD:SetFade(true, self.vb.shadowStrikeCount+1)
		end
	end
	--Check if near or far from Skeinspinner Takazj
	if self:CheckBossDistance(223781, true, 32698, 48) then
		if not nearTakazj then
			nearTakazj = true
			--timerFieryMeteorCD:SetFade(false, self.vb.meteorCast+1)
			--timerMoltenEruptionCD:SetFade(false, self.vb.moltenEruptionCast+1)
			--timerSwirlingFlameCD:SetFade(false, self.vb.swirlingCount+1)
			--timerFlameSlashCD:SetFade(false, self.vb.flameSlashCast+1)
		end
	else
		if nearTakazj then
			nearTakazj = false
			--timerFieryMeteorCD:SetFade(true, self.vb.meteorCast+1)
			--timerMoltenEruptionCD:SetFade(true, self.vb.moltenEruptionCast+1)
			--timerSwirlingFlameCD:SetFade(true, self.vb.swirlingCount+1)
			--timerFlameSlashCD:SetFade(true, self.vb.flameSlashCast+1)
		end
	end
	self:Schedule(2, updateBossDistance, self)
end
--]]

function mod:OnCombatStart(delay)
	self.vb.swarmCount = 0
	self.vb.chargeCount = 0
	self.vb.eruptionCount = 0
	self.vb.rainCount = 0
	self.vb.webBombCount = 0
	self.vb.leapCount = 0
	self.vb.stingingCount = 0
	self.vb.strandsCount = 0
	self.vb.cataCount = 0
	self.vb.rageCount = 0
	self.vb.unleashedCount = 0
	--Anub
	timerPiercingStrikeCD:Start(1)
	timerCalloftheSwarmCD:Start(1)
	timerRecklessChargeCD:Start(1)
	timerImpalingEruptionCD:Start(1)
	--Takazj
	timerVenomousRainCD:Start(1)
	timerWebBombCD:Start(1)--Likely always same time or just before reckless charge
	timerSkitteringLeapCD:Start(1)
	if self.Options.NPAuraOnPerseverance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	self:Schedule(2, updateBossDistance, self)
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnPerseverance then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 438218 then
		timerPiercingStrikeCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnPiercingStrike:Show()
			specWarnPiercingStrike:Play("defensive")
		end
	elseif spellId == 438801 then
		self.vb.swarmCount = self.vb.swarmCount + 1
		warnCalloftheSwarm:Show(self.vb.swarmCount)
		timerCalloftheSwarmCD:Start()
	elseif spellId == 440246 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnRecklessCharge:Show(self.vb.chargeCount)
		specWarnRecklessCharge:Play("chargemove")
		timerRecklessChargeCD:Start()
	elseif spellId == 440504 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		timerImpalingEruptionCD:Start()
	elseif spellId == 438343 then
		self.vb.rainCount = self.vb.rainCount + 1
		warnVenomousRain:Show()
		timerVenomousRainCD:Start()
	elseif spellId == 439838 then
		self.vb.webBombCount = self.vb.webBombCount + 1
		warnWebBomb:Show()
		timerWebBombCD:Start()
	elseif spellId == 450045 then
		self.vb.leapCount = self.vb.leapCount + 1
		warnSkitteringLeap:Show(self.vb.leapCount)
		timerSkitteringLeapCD:Start()
	elseif spellId == 451016 and self:GetStage(1) then
		self:SetStage(1.5)
		--Anub stops charging
		timerRecklessChargeCD:Stop()
		--Stop or restart anubs other timers?
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()

		timerVenomousRainCD:Stop()
		timerWebBombCD:Stop()--Likely always same time or just before reckless charge
		timerSkitteringLeapCD:Stop()
	elseif spellId == 438677 or spellId == 452231 then--Hard difficulty, and second ID LFR assumed
		self.vb.stingingCount = self.vb.stingingCount + 1
		timerStingingSwarmCD:Start()
	elseif spellId == 441626 then
		self.vb.webBombCount = self.vb.webBombCount + 1
		specWarnWebVortex:Show(self.vb.webBombCount)
		specWarnWebVortex:Play("pullin")
		timerWebVortexCD:Start()
	elseif spellId == 450129 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnEntropicDesolation:Show()
		specWarnEntropicDesolation:Play("aesoon")
		timerEntropicDesolationCD:Start()
	elseif spellId == 441782 then
		self.vb.strandsCount = self.vb.strandsCount + 1
		specWarnStrandsofReality:Show(self.vb.strandsCount)
		specWarnStrandsofReality:Play("shockwave")
		timerStrandsofRealityCD:Start()
	elseif spellId == 450483 then
		self.vb.leapCount = self.vb.leapCount + 1
		warnVoidStep:Show(self.vb.leapCount)
		timerVoidStepCD:Start()
	elseif spellId == 438355 then
		self.vb.cataCount = self.vb.cataCount + 1
		specWarnCataclysmicEntropy:Show(self.vb.cataCount)
		specWarnCataclysmicEntropy:Play("specialsoon")--Maybe custom sound?
		timerCataclysmicEntropyCD:Start()
	elseif spellId == 443068 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		timerSpikeEruptionCD:Start()
	elseif spellId == 451327 and self:GetStage(3) then--Only want timer and count incremented during actual stage 3, during 2.5 doesn't count for now
		self.vb.rageCount = self.vb.rageCount + 1
		timerRagingFuryCD:Start()
	elseif spellId == 442994 then
		self.vb.unleashedCount = self.vb.unleashedCount + 1
		specWarnUnleashedSwarm:Show()
		specWarnUnleashedSwarm:Play("aesoon")
		timerUnleashedSwarmCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 455849 and args:IsPlayer() then
		specWarnMarkofParanoia:Show()
		specWarnMarkofParanoia:Play("paranoiayou")
	elseif spellId == 455850 and args:IsPlayer() then
		specWarnMarkofRage:Show()
		specWarnMarkofRage:Play("rageyou")
	elseif spellId == 438218 then
		warnPiercingStrike:Show(args.destName, args.amount or 1)
	elseif spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 440503 then
		if args:IsPlayer() then
			specWarnImpalingEruption:Show()
			specWarnImpalingEruption:Play("targetyou")
			yellImpalingEruption:Yell()
		else
			specWarnImpalingEruptionOther:Show()
			specWarnImpalingEruptionOther:Play("shockwave")
		end
	elseif spellId == 449857 then
		warnImpaled:CombinedShow(0.5, args.destName)
	elseif spellId == 451611 then
		if args:IsPlayer() then
			specWarnWebBomb:Show()
			specWarnWebBomb:Play("bombyou")
			yellWebBomb:Yell()
			yellWebBombFades:Countdown(spellId)
		end
	elseif spellId == 440001 then
		if args:IsPlayer() then
			specWarnBindingWebs:Show()
			specWarnBindingWebs:Play("lineapart")--Maybe use a diff sound during charge like "block charge"?
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
		if self:GetStage(1) then--In case spell cast start failed
			self:SetStage(1.5)
			--Anub stops charging
			timerRecklessChargeCD:Stop()
			--Stop or restart anubs other timers?
			timerPiercingStrikeCD:Stop()
			timerCalloftheSwarmCD:Stop()
			timerImpalingEruptionCD:Stop()

			timerVenomousRainCD:Stop()
			timerWebBombCD:Stop()--Likely always same time or just before reckless charge
			timerSkitteringLeapCD:Stop()
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
	elseif spellId == 451277 then--Spike Storm Absorb
		self:SetStage(2.5)
		--Stop Anub's timers
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()
		timerStingingSwarmCD:Stop()
		--Stop Takazj's timers?
		timerWebVortexCD:Stop()
		timerEntropicDesolationCD:Stop()
		timerStrandsofRealityCD:Stop()
		timerVoidStepCD:Stop()
		timerCataclysmicEntropyCD:Stop()
	elseif spellId == 438708 or spellId == 456252 or spellId == 450728 then--One is unlimited version one is 9 second. I suspect one is initial version and one is jump?
		warnStingingSwarm:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnStingingSwarm:Show(takazj)
			specWarnStingingSwarm:Play("movetoboss")
			yellStingingSwarm:Yell()
		end
	elseif spellId == 443598 then
		specWarnEnragedFerocity:Show(args.destName)
		specWarnEnragedFerocity:Play("enrage")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 451611 then
		if args:IsPlayer() then
			yellWebBombFades:Cancel()
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
		self:SetStage(2)
		self.vb.swarmCount = 0
		self.vb.chargeCount = 0
		self.vb.eruptionCount = 0
		self.vb.rainCount = 0--Also used for Entropic Desolation
		self.vb.webBombCount = 0--Also web vortex
		self.vb.leapCount = 0--Also used for void step
		self.vb.stingingCount = 0
		--Restart anubs timers?
		timerPiercingStrikeCD:Start(2)
		timerCalloftheSwarmCD:Start(2)
		timerImpalingEruptionCD:Start(2)
		timerStingingSwarmCD:Start(2)
		--Start new Takazj timers
		timerWebVortexCD:Start(2)
		timerEntropicDesolationCD:Start(2)
		timerStrandsofRealityCD:Start(2)
		timerVoidStepCD:Start(2)
		timerCataclysmicEntropyCD:Start(2)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 451277 then--Spike Storm Absorb
		self:SetStage(3)
		--Start Anub timers
		timerSpikeEruptionCD:Start(3)
		timerPiercingStrikeCD:Start(3)
		timerUnleashedSwarmCD:Start(3)
		timerRecklessChargeCD:Start(3)
		timerStingingSwarmCD:Start(3)
		timerRagingFuryCD:Start(3)
		--Restart Takazj timers?
		timerWebVortexCD:Start(3)
		timerEntropicDesolationCD:Start(3)
		timerStrandsofRealityCD:Start(3)
		timerVoidStepCD:Start(3)
		timerCataclysmicEntropyCD:Start(3)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
--https://www.wowhead.com/beta/npc=218884/shattershell-scarab
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
