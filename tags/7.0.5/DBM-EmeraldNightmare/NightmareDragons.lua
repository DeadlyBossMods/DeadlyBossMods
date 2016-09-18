local mod	= DBM:NewMod(1704, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102679)--Ysondre, 102683 (Emeriss), 102682 (Lethon), 102681 (Taerar)
mod:SetEncounterID(1854)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 203028 204767 205300 203817 203888 204100 204078",
	"SPELL_CAST_SUCCESS 203787 205298 205329",
	"SPELL_AURA_APPLIED 203102 203125 203124 203121 203110 203770 203787 204040",
	"SPELL_AURA_APPLIED_DOSE 203102 203125 203124 203121",
	"SPELL_AURA_REMOVED 203102 203125 203124 203121 203787 204040",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local Ysondre = EJ_GetSectionInfo(12768)
local Emeriss = EJ_GetSectionInfo(12770)
local Lethon = EJ_GetSectionInfo(12772)
local Taerar = EJ_GetSectionInfo(12774)

--(type = "begincast" or type = "cast" or type = "applybuff") and (source.name = "Taerar" or source.name = "Ysondre" or source.name = "Emeriss" or source.name = "Lethon")
--TODO, promote breath warning to special if it's impactful enough. FIgure out if timers are reasonable too
--TODO, if only one volatile infection goes out at a time, hide general alert if player affected
--TODO, remove combined show from any warnings that are only one target
--TODO, verify phase change stuff and timers. Get all remaining data from remaining two dragons since they were never seen during test.
--TODO, when timers are more finalized add countdowns to more things.
--All
local warnSlumberingNightmare		= mod:NewTargetAnnounce(203110, 4, nil, false)--An option to announce fuckups
local warnBreath					= mod:NewSpellAnnounce(203028, 2)
--Ysondre
local warnCallDefiledSpirit			= mod:NewSpellAnnounce(207573, 4)
local warnNightmareBlast			= mod:NewSpellAnnounce(203153, 2)
--Emeriss
local warnVolatileInfection			= mod:NewTargetAnnounce(203787, 3)
local warnEssenceOfCorruption		= mod:NewSpellAnnounce(205298, 2)
--Lethon
local warnGloom						= mod:NewSpellAnnounce(205329, 2)
local warnShadowBurst				= mod:NewTargetAnnounce(204040, 3)
--Taerar

--All
local specWarnYsondreMark			= mod:NewSpecialWarningStack(203102, nil, 7)
local specWarnEmerissMark			= mod:NewSpecialWarningStack(203125, nil, 7)
local specWarnLethonMark			= mod:NewSpecialWarningStack(203124, nil, 7)
local specWarnTaerarMark			= mod:NewSpecialWarningStack(203121, nil, 7)
--Ysondre
--local specWarnNightmareBlast		= mod:NewSpecialWarningSpell(203153, nil, nil, nil, 2)
local specWarnDefiledSpirit			= mod:NewSpecialWarningYou(207573)
local yellSpirit					= mod:NewYell(207573)
local specWarnDefiledVines			= mod:NewSpecialWarningDispel(207573, "Healer", nil, nil, 1, 2)
local specWarnLumberingMindgorger	= mod:NewSpecialWarningSwitch("ej13460", "-Healer", nil, nil, 1, 2)
--Emeriss
local specWarnVolatileInfection		= mod:NewSpecialWarningMoveAway(203787, nil, nil, nil, 1, 2)
local yellVolatileInfection			= mod:NewYell(203787)
local specWarnCorruptedBurst		= mod:NewSpecialWarningDodge(203817, "Melee", nil, nil, 1, 2)
local specWarnCorruption			= mod:NewSpecialWarningInterrupt(205300, "HasInterrupt", nil, nil, 1, 2)
--Lethon
local specWarnSiphonSpirit			= mod:NewSpecialWarningSwitch(203888, "Dps", nil, nil, 3, 2)
local specWarnShadowBurst			= mod:NewSpecialWarningYou(204040, nil, nil, nil, 1, 2)
local yellShadowBurst				= mod:NewFadesYell(204040)
--Taerar
local specWarnShadesOfTaerar		= mod:NewSpecialWarningSwitch(204100, "Tank", nil, nil, 1, 2)
local specWarnBellowingRoar			= mod:NewSpecialWarningSpell(204078, nil, nil, nil, 2, 6)

--Ysondre
mod:AddTimerLine(Ysondre)
local timerNightmareBlastCD			= mod:NewCDTimer(15, 203153, nil, "-Tank", nil, 3)--15-20
local timerDefiledSpiritCD			= mod:NewCDTimer(33.2, 207573, nil, nil, nil, 3)
--Emeriss
mod:AddTimerLine(Emeriss)
local timerVolatileInfectionCD		= mod:NewCDTimer(46, 203787, nil, nil, nil, 3)
local timerEssenceOfCorruptionCD	= mod:NewNextTimer(30, 205298, nil, nil, nil, 1)
--Lethon
mod:AddTimerLine(Lethon)
local timerSiphonSpiritCD			= mod:NewNextTimer(49.9, 203888, nil, nil, nil, 1)
local timerShadowBurstCD			= mod:NewNextTimer(15, 204040, nil, nil, nil, 3)--Air
--Taerar
mod:AddTimerLine(Taerar)
local timerShadesOfTaerarCD			= mod:NewNextTimer(48.5, 204100, nil, "-Healer", nil, 1)
local timerSeepingFogCD				= mod:NewCDTimer(15.5, 205341, nil, nil, nil, 3, 24814)
local timerBellowingRoarCD			= mod:NewCDTimer(44.5, 204078, nil, nil, nil, 2)--Air

--Ysondre
--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
--Emeriss
--Lethon
--Taerar
local countdownShadesOfTaerar		= mod:NewCountdown(48.5, 204100, "Tank")

--Ysondre
--local voiceNightmareBlast			= mod:NewVoice(203153)--169613 (run over theh flower?)
--local voiceDefiledSpirit			= mod:NewVoice(207573)--watchstep
local voiceDefiledVines				= mod:NewVoice(207573, "Healer")--helpdispel
local voiceLumberingMindgorger		= mod:NewVoice("ej13460", "-Healer")--bigmob
--Emeriss
local voiceVolatileInfection		= mod:NewVoice(203787)--scatter
local voiceCorruption				= mod:NewVoice(205300, "HasInterrupt")--kickcast
local voiceCorruptedBurst			= mod:NewVoice(203817, "Melee")--watchstep
--Lethon
local voiceSiphonSpirit				= mod:NewVoice(203817, "Dps")--killspirit
--Taerar
local voiceShadesOfTaerar			= mod:NewVoice(203817, "Tank")--mobsoon
local voiceBellowingRoar			= mod:NewVoice(204078)--fearsoon

mod:AddRangeFrameOption(10, 203787)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)

local activeBossGUIDS = {}

local function whoDatUpThere(self)
	local emerissFound = false
	local lethonFound = false
	local taerarFound = false
	for i = 1, 5 do
		local bossUID = "boss"..i
		if UnitExists(bossUID) then--if they are in air they won't exist.
			local cid = self:GetUnitCreatureId(bossUID)
			if cid == 102683 then -- Emeriss
				emerissFound = true
			elseif cid == 102682 then -- Lethon
				lethonFound = true
			elseif cid == 102681 then -- Taerar
				taerarFound = true
			end
		end
	end
	--Subtracking 2 from all timers do to delay
	if not emerissFound then -- Emeriss

	end
	if not lethonFound then -- Lethon
		timerShadowBurstCD:Start(18)
	end
	if not taerarFound then -- Taerar
		timerBellowingRoarCD:Start(43)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(activeBossGUIDS)
	timerDefiledSpiritCD:Start(30-delay)
	timerNightmareBlastCD:Start(40-delay)--40 on mythic, it changing on heroic too is assumed. Was 22.5 before
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to make sure we wipe vb.on pull
	)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
	end
	if self:IsMythic() then
		--Only done on mythic for now since we know for sure what dragons are up once we know what dragons are down.
		--On non mythic one dragon is missing from encounter and we have no way of knowing what one currently :\
		self:Schedule(2, whoDatUpThere, self)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203028 or spellId == 204767 then--204767 is weaker version used by Shade of Taerar
		local targetName, uId, bossuid = self:GetBossTarget(args.sourceGUID)
		if not bossuid then
			DBM:Debug("GetBossTarget failed, no bossuid")
			return
		end
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			warnBreath:Show()
		end
	elseif spellId == 207573 then
		warnCallDefiledSpirit:Show()
		timerDefiledSpiritCD:Start()
	elseif spellId == 205300 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnCorruption:Show(args.sourceName)
		voiceCorruption:Play("kickcast")
	elseif spellId == 203817 then
		specWarnCorruptedBurst:Show()
		voiceCorruptedBurst:Play("watchstep")
	elseif spellId == 203888 then
		specWarnSiphonSpirit:Show()
		voiceSiphonSpirit:Play("killspirit")
		timerSiphonSpiritCD:Start()
	elseif spellId == 204100 then
		specWarnShadesOfTaerar:Show()
		voiceShadesOfTaerar:Play("mobsoon")
		timerShadesOfTaerarCD:Start()
		countdownShadesOfTaerar:Start()
	elseif spellId == 204078 then
		specWarnBellowingRoar:Show()
		voiceBellowingRoar:Play("fearsoon")
		timerBellowingRoarCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 203787 then
		timerVolatileInfectionCD:Start()
	elseif spellId == 205298 then
		warnEssenceOfCorruption:Show()
		timerEssenceOfCorruptionCD:Start()
	elseif spellId == 205329 then
		warnGloom:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 203102 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnYsondreMark:Show(amount)
		end
	elseif spellId == 203125 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnEmerissMark:Show(amount)
		end
	elseif spellId == 203124 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnLethonMark:Show(amount)
		end
	elseif spellId == 203121 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnTaerarMark:Show(amount)
		end
	elseif spellId == 203110 then
		warnSlumberingNightmare:CombinedShow(0.5, args.destName)
	elseif spellId == 203770 then
		specWarnDefiledVines:CombinedShow(0.5, args.destName)
		if self:AntiSpam(2, 1) then
			voiceDefiledVines:Play("helpdispel")
		end
	elseif spellId == 203787 then
		warnVolatileInfection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVolatileInfection:Show()
			yellVolatileInfection:Yell()
			voiceVolatileInfection:Play("scatter")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 204040 then
		warnShadowBurst:CombinedShow(0.5, args.destName)
		if self:AntiSpam(2, 5) then
			timerShadowBurstCD:Start()
		end
		if args:IsPlayer() then
			specWarnShadowBurst:Show()
			yellShadowBurst:Schedule(5, 1)
			yellShadowBurst:Schedule(4, 2)
			yellShadowBurst:Schedule(3, 3)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 203787 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 204040 and args:IsPlayer() then
		yellShadowBurst:Cancel()
	end
end

--this should work for both pull and any of them landing from air, well assuming the timers in both situations are same
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetUnitCreatureId(unitID)
			--Subtracking .5 from all timers do to slight delay in IEEU vs ENCOUNTER_START
			if cid == 102683 then -- Emeriss
				timerVolatileInfectionCD:Start(19.5)
				timerEssenceOfCorruptionCD:Start(29.5)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(cid, Emeriss)
				end
			elseif cid == 102682 then -- Lethon
				timerShadowBurstCD:Stop()
				timerSiphonSpiritCD:Start(20.5)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(cid, Lethon)
				end
			elseif cid == 102681 then -- Taerar
				timerBellowingRoarCD:Stop()
				timerShadesOfTaerarCD:Start(19.5)--19.5-21
				countdownShadesOfTaerar:Start(19.5)
				timerSeepingFogCD:Start(25)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(cid, Taerar)
				end
			end
		end
	end
end

--"<38.03 01:01:06> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\sha_ability_rogue_envelopingshadows_nightmare:20|tA Lumbering Mindgorger forms in the mists of The Hinterlands!#Ysondre#####0#0##0#1
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("sha_ability_rogue_envelopingshadows_nightmare") then
		specWarnLumberingMindgorger:Show()
		voiceLumberingMindgorger:Play("bigmob")
	end
end

local function delayedClear(self, GUID)
	activeBossGUIDS[GUID] = nil
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 203147 then--Nightmare Blast
		warnNightmareBlast:Show()
		timerNightmareBlastCD:Start()
	elseif spellId == 205331 then--Seeping Fog
		timerSeepingFogCD:Start()
	elseif spellId == 204720 then--Aeriel
		local cid = self:GetUnitCreatureId(uId)
		local unitGUID = UnitGUID(uId)
		self:Schedule(10, delayedClear, self, unitGUID)
		if cid == 102683 then--Emeriss
			timerVolatileInfectionCD:Stop()
			timerEssenceOfCorruptionCD:Stop()
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(cid)
			end
		elseif cid == 102682 then--Lethon
			timerSiphonSpiritCD:Stop()
			if not self:IsEasy() then
				timerShadowBurstCD:Start(19.5)
			end
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(cid)
			end
		elseif cid == 102681 then--Taerar
			timerShadesOfTaerarCD:Stop()
			countdownShadesOfTaerar:Cancel()
			timerSeepingFogCD:Stop()
			if not self:IsEasy() then
				timerBellowingRoarCD:Start(44.5)
			end
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(cid)
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
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
