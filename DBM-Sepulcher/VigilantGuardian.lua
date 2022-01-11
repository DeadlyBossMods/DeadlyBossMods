local mod	= DBM:NewMod(2458, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180773)
mod:SetEncounterID(2512)
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220111000000)
mod:SetMinSyncRevision(20220111000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360412 361001 360176 360162 364447",
	"SPELL_CAST_SUCCESS 360412 366693 359610 361001 360404",--364425
	"SPELL_SUMMON 360848 360623",
	"SPELL_AURA_APPLIED 363447 360458 364447 359610 360415 364881 364962",
	"SPELL_AURA_APPLIED_DOSE 364447 360415",
	"SPELL_AURA_REMOVED 363447 364881 360879",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, improvements for https://ptr.wowhead.com/spell=360403/force-field?
--TODO, https://ptr.wowhead.com/spell=364425/surge target scanable? it's instant cast...Does it need throttle?
--TODO, adjust tank swap stacks for dissonance, if it's even swapped (and not just add soft enrage)
--TODO, https://ptr.wowhead.com/spell=360654/point-defense-drone useful?
--TODO, proper energy Conversion cast and alert prio
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Automa
local warnUnstableCore							= mod:NewTargetNoFilterAnnounce(360458, 3)
local warnForceField							= mod:NewSpellAnnounce(360404, 1)
--local warnSurge									= mod:NewSpellAnnounce(364425, 3)--No Longer in Journal
local warnWaveofDesintegration					= mod:NewCountAnnounce(361001, 4, nil, "Melee")
local warnDissonance							= mod:NewStackAnnounce(364447, 2, nil, "Tank|Healer")
local warnBlast									= mod:NewSpellAnnounce(360176, 3, nil, false)--Spammy
--Stage One: Automated Defense Systems Online!
local warnRefractedBlast						= mod:NewCountAnnounce(366693, 2)
local warnDeresolution							= mod:NewTargetAnnounce(359610, 3)
local warnExposedCore							= mod:NewCastAnnounce(360412, 4)
--Stage Two: Roll Out, then Transform
local warnMatterDisoilution						= mod:NewTargetNoFilterAnnounce(364881, 4)

--Automa
local specWarnPreFabricatedSentry				= mod:NewSpecialWarningSwitch(360848, "Tank", nil, nil, 1, 2)
local specWarnDissonance						= mod:NewSpecialWarningStack(350202, nil, 3, nil, nil, 1, 6)
local specWarnDissonanceTaunt					= mod:NewSpecialWarningTaunt(350202, nil, nil, nil, 1, 2)
--local specWarnBlast								= mod:NewSpecialWarningMoveAway(350202, nil, nil, nil, 1, 2)
--local yellBlast									= mod:NewYell(360176)
--Stage One: Automated Defense Systems Online!
local specWarnDeresolution						= mod:NewSpecialWarningMoveAway(359610, nil, nil, nil, 1, 2)--Change once clear how it works
local yellDeresolution							= mod:NewYell(359610)
local specWarnExposedCore						= mod:NewSpecialWarningMoveTo(360412, nil, nil, nil, 3, 2)
--Stage Two: Roll Out, then Transform
local specWarnSplitResolution					= mod:NewSpecialWarningDefensive(360162, nil, nil, nil, 1, 2)
local specWarnDefenseless						= mod:NewSpecialWarningTaunt(360415, nil, nil, nil, 1, 2)
local specWarnMatterDisolution					= mod:NewSpecialWarningYou(364881, nil, nil, nil, 1, 2)--Initial
local specWarnMatterDisolutionOut				= mod:NewSpecialWarningMoveAway(364881, nil, nil, nil, 1, 2)--Delayed
local yellMatterDisolutionFades					= mod:NewShortFadesYell(364881)
--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Automa
local timerWaveofDisintegrationCD				= mod:NewCDTimer(12.2, 361001, nil, nil, nil, 3)--Time between first and second cast usually 14-15 then 12.2 repeating
local timerDissonanceCD							= mod:NewCDTimer(12.2, 350202, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Second is 16-18 then rest are 12.2-14
--Stage One: Automated Defense Systems Online!
local timerVolatileMateriumCD					= mod:NewNextTimer(30.6, 365315, nil, nil, nil, 1)
local timerSentryCD								= mod:NewNextTimer(71.2, 360658, nil, nil, nil, 1, nil, DBM_COMMON_L.TANK_ICON)--Every odd Volatile
local timerRefractedBlastCD						= mod:NewCDCountTimer(15, 366693, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--15 but can be delayed by shit
local timerDeresolutionCD						= mod:NewNextTimer(35.5, 359610, nil, nil, nil, 3)
local timerExposedCore							= mod:NewCastTimer(10, 360412, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Two: Roll Out, then Transform
local timerSplitResolutionCD					= mod:NewCDTimer(30.2, 360412, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--30.2-34 (also acts as Pneumatic Impact timer)
local timerMatterDisolutionCD					= mod:NewCDTimer(30.4, 360415, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360403, true)
--mod:AddSetIconOption("SetIconOnCallofEternity", 350554, true, false, {1, 2, 3, 4, 5})
mod:AddNamePlateOption("NPAuraOnPoweredDown", 363447, true)

mod.vb.refractedCount = 0
local castsPerGUID = {}

local shieldName = DBM:GetSpellInfo(360403)

--[[
function mod:BlastTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBlast:Show()
		specWarnBlast:Play("runout")
		yellBlast:Yell()
	else
		warnBlast:CombinedShow(1, targetname)
	end
end
--]]

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.refractedCount = 0
	timerVolatileMateriumCD:Start(18.6-delay)
	timerSentryCD:Start(18.6)
	timerRefractedBlastCD:Start(14.9-delay, 1)
	timerDeresolutionCD:Start(26.3-delay)
	if self.Options.NPAuraOnPoweredDown then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPoweredDown then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

local function delayedCoreCheck()
	if not DBM:UnitAura("player", 360403) then--Use unit buff or unit debuff when known
		specWarnExposedCore:Show(shieldName)
		specWarnExposedCore:Play("findshelter")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 360412 then
		warnExposedCore:Show()
		timerExposedCore:Start()
		self:Schedule(6, delayedCoreCheck)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(shieldName)
			DBM.InfoFrame:Show(10, "playerbuff", shieldName)
		end
	elseif spellId == 361001 then
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but failsafe
			castsPerGUID[args.sourceGUID] = {}
			castsPerGUID[args.sourceGUID][1] = 1--Diss
			castsPerGUID[args.sourceGUID][2] = 1--Wave
		end
		warnWaveofDesintegration:Show(castsPerGUID[args.sourceGUID][2])
	elseif spellId == 364447 then
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but failsafe
			castsPerGUID[args.sourceGUID] = {}
			castsPerGUID[args.sourceGUID][1] = 1--Diss
			castsPerGUID[args.sourceGUID][2] = 1--Wave
		end
		castsPerGUID[args.sourceGUID][1] = castsPerGUID[args.sourceGUID][1] + 1
		timerDissonanceCD:Start(castsPerGUID[args.sourceGUID][1] == 1 and 16 or 12.2, args.sourceGUID)
	elseif spellId == 360176 and self:AntiSpam(3, 1) then
--		self:BossTargetScanner(args.sourceGUID, "BlastTarget", 0.1, 12)
		warnBlast:Show()
	elseif spellId == 360162 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSplitResolution:Show()
			specWarnSplitResolution:Play("defensive")
		end
		timerSplitResolutionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 360412 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
--	elseif spellId == 364425 then
--		warnSurge:Show()
--	elseif spellId == 366693 then

--	elseif spellId == 364881 then
--		timerMatterDisolutionCD:Start()
	elseif spellId == 359610 then
		timerDeresolutionCD:Start()
	elseif spellId == 361001 then
		--Cast can be interrupted and is immediately recast, we don't want to increase cast count unless a cast succeeds
		castsPerGUID[args.sourceGUID][2] = castsPerGUID[args.sourceGUID][2] + 1
		timerWaveofDisintegrationCD:Start(castsPerGUID[args.sourceGUID][2] == 1 and 13.3 or 11.2, args.sourceGUID)--CD adjusted from SUCCESS --> Start, timers are 14.3 and 12.2
	elseif spellId == 360404 then
		warnForceField:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if (spellId == 360848 or spellId == 360623) and self:AntiSpam(5, 2) then--Not likley more than one at a time, but safetynet for drycode
		specWarnPreFabricatedSentry:Show()
		specWarnPreFabricatedSentry:Play("changetarget")--or bigmob
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 363447 then
		if self.Options.NPAuraOnPoweredDown then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 360458 then
		warnUnstableCore:CombinedShow(1, args.destName)
	elseif spellId == 364447 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnDissonance:Show(amount)
				specWarnDissonance:Play("stackhigh")
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 6.7) and not UnitIsDeadOrGhost("player") then--TODO, adjust remaining when Cd known
					specWarnDissonanceTaunt:Show(args.destName)
					specWarnDissonanceTaunt:Play("tauntboss")
				else
					warnDissonance:Show(args.destName, amount)
				end
			end
		else
			warnDissonance:Show(args.destName, amount)
		end
	elseif spellId == 359610 then
		if args:IsPlayer() then
			specWarnDeresolution:Show()
			specWarnDeresolution:Play("laserrun")
			yellDeresolution:Yell()
		else
			warnDeresolution:Show(args.destName)
		end
	elseif spellId == 360415 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				specWarnDefenseless:Cancel()
				specWarnDefenseless:CancelVoice()
			else
				specWarnDefenseless:CombinedShow(0.5, args.destName)
				specWarnDefenseless:ScheduleVoice(0.5, "tauntboss")
			end
		end
	elseif spellId == 364881 then
		warnMatterDisoilution:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMatterDisolution:Show()
			specWarnMatterDisolution:Play("targetyou")
			specWarnMatterDisolutionOut:Schedule(6.5)
			specWarnMatterDisolutionOut:ScheduleVoice(6.5, "runout")
			yellMatterDisolutionFades:Countdown(spellId, 5)
		end
	elseif spellId == 364962 and self.vb.phase < 3 then
		self:SetStage(3)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--DO stage 2 timers stop? Like is this all boss does?
		timerRefractedBlastCD:Stop()
		timerSplitResolutionCD:Stop()
		timerMatterDisolutionCD:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363447 then
		if self.Options.NPAuraOnPoweredDown then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 364881 then
		if args:IsPlayer() then
			specWarnMatterDisolutionOut:Cancel()
			specWarnMatterDisolutionOut:CancelVoice()
			yellMatterDisolutionFades:Cancel()
		end
	elseif spellId == 360879 then
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerVolatileMateriumCD:Stop()
		timerSentryCD:Stop()
		timerRefractedBlastCD:Stop()
		timerDeresolutionCD:Stop()
		timerRefractedBlastCD:Start(21, self.vb.refractedCount+1)
		timerSplitResolutionCD:Start(25.8)
		timerMatterDisolutionCD:Start(46.5)
	end
end

--https://ptr.wowhead.com/npc=184540--Unknown
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 182311 or cid == 181850 then--Pre-Fabricated Sentry
		timerDissonanceCD:Stop(args.destGUID)
		timerWaveofDisintegrationCD:Stop(args.destGUID)
		castsPerGUID[args.destGUID] = nil
--	elseif cid == 181859 then--Reclamated Materium

--	elseif cid == 181856 then--Point Defense Drone

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

--NOTE: This may actually be buggy for now since sentries can inherit the bosses guid (and thus not be unique
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not castsPerGUID[unitGUID] then
			castsPerGUID[unitGUID] = {}
			castsPerGUID[unitGUID][1] = 1--Diss
			castsPerGUID[unitGUID][2] = 1--Wave
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 182311 or cid == 181850 then--Pre-Fabricated Sentry
				timerDissonanceCD:Start(11, unitGUID)
				timerWaveofDisintegrationCD:Start(21, unitGUID)
				--Found guid of spawned big add and started timer, kill event
				self:UnregisterShortTermEvents()
			end
		end
	end
end

--"<215.22 23:31:43> [CLEU] SPELL_AURA_REMOVED##nil#Creature-0-4170-2481-3623-180773-00003D0E8C#Vigilant Guardian#360879#Ancient Defenses#DEBUFF#nil", -- [15642]
--"<229.41 23:31:57> [UNIT_SPELLCAST_SUCCEEDED] Vigilant Guardian(Cuteymw) -ROLL OUT!- boss1:Cast-3-4170-2481-3623-361936-00033D0FD0:361936", -- [16622]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360906 then--Refracted Blast
		self.vb.refractedCount = self.vb.refractedCount + 1
		warnRefractedBlast:Show(self.vb.refractedCount)
		timerRefractedBlastCD:Start(nil, self.vb.refractedCount+1)
	elseif spellId == 365315 then--Volatile Materium
		timerVolatileMateriumCD:Start()
	elseif spellId == 360658 then--Pre-Fabricated Sentry
		timerSentryCD:Start()
		--scan for sentry being added to boss frames, so we can grab it's guid
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	elseif spellId == 364881 then--Matter Disolution
		timerMatterDisolutionCD:Start()
--	elseif spellId == 361936 then--ROLL OUT!

	end
end
