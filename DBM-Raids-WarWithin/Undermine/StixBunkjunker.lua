if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2642, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(214503)
mod:SetEncounterID(3012)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 464399 466742 1220752 464149 467802 464112 1217954 467117 467109",
	"SPELL_CAST_SUCCESS 466849",
	"SPELL_AURA_APPLIED 465346 1217685 464854 473115 473066 1218704 1219384 1220648 472893",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 465346 461536 1217685 473115 473066 467117",
	"SPELL_PERIODIC_DAMAGE 464854",
	"SPELL_PERIODIC_MISSED 464854",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe use https://www.wowhead.com/spell=263753/spawn-trash as shortext for sorting
--TODO, see how others handle icons for sorting. Right now I keep them persent until full Rolling Rubish mechanic ends
--TODO, maybe announce garbage pile spawns via secondary scripts like https://www.wowhead.com/ptr-2/spell=466006/large-garbage-pile or others
--TODO, Discarded Doomsplosive spawn and auto marking if possible
--TODO, finish mod when npc database is available. Can't do much with bomb spawns without it
--TODO, fancy infoframe that tracks active bombs, times remaining, as well as time remaining on https://www.wowhead.com/ptr-2/spell=1217975/doomsploded
--TODO, don't forget UNIT_DIED for CIDs
--TODO, more with power coil
--TODO, Target scan or something for dumpster dive. or upgrade emphasis and just make it aoe dodge alert
--TODO, warn for high bite count? https://www.wowhead.com/ptr-2/spell=466748/infected-bite
--TODO, maybe a pre spread warning for incinerator if we can't get pre targets
--TODO, taunt DURING demolish cast, or immediately on completion of cast
--TODO, if traash compactor cast isn't exposed, schedule the alert off overdrive instead
--Sorting
mod:AddTimerLine(DBM:GetSpellName(464399))
local warnSorted									= mod:NewTargetNoFilterAnnounce(465346, 3)
--local warnBigBomb									= mod:NewCountAnnounce(464865, 4)

local specWarnElectroSorting						= mod:NewSpecialWarningCount(464399, nil, nil, nil, 2, 2)
local specWarnSorted								= mod:NewSpecialWarningYouPos(465346, nil, nil, nil, 1, 2)--Pre target debuff for Rolling Rubbish
local yellSorted									= mod:NewShortPosYell(465346)
local yellSortedFades								= mod:NewIconFadesYell(465346)
local specWarnPowercoil								= mod:NewSpecialWarningYou(1218704, nil, nil, nil, 1, 2, 4)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(464854, nil, nil, nil, 1, 8)

local timerElectroSortingCD							= mod:NewAITimer(97.3, 464399, nil, nil, nil, 2)
local timerBigBomb									= mod:NewCastTimer(20, 464865, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerShortFuseCast							= mod:NewCastNPTimer(30, 473115, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnSorted", 465346, true, 0, {1, 2, 3, 4})--Probably change to 6, 3, 7, 1 if that's what BW ends up doing
--mod:AddSetIconOption("SetIconOnBigBomb", 464865, true, 5, {8})
mod:AddSetIconOption("SetIconOnSmallBomb", -30451, true, 1, {5, 6, 7})
mod:AddNamePlateOption("NPAuraOnMessedUp", 1217685)
mod:AddNamePlateOption("NPAuraOnTerritorial", 473066)
--mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)
--Cleanup Crew
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30533))
local specWarnCleanupCrew							= mod:NewSpecialWarningSwitchCount(466849, "Dps", nil, nil, 1, 2)

local timerCleanupCrewCD							= mod:NewAITimer(97.3, 466849, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local warnDumpsterDive								= mod:NewCastAnnounce(466742, 3)
local warnMarkedForRecycling						= mod:NewTargetNoFilterAnnounce(1220648, 4)

local specWarnScrapRockets							= mod:NewSpecialWarningInterruptCount(1219384, "HasInterrupt", nil, nil, 1, 2)
local specWarnMarkedForRecycling					= mod:NewSpecialWarningYou(1220648, nil, nil, nil, 3, 2)

--local timerDumpsterDiveCD							= mod:NewCDNPTimer(97.3, 466742, nil, nil, nil, 3)
--local timerRecyclerCD								= mod:NewCDNPTimer(97.3, 1220752, nil, nil, nil, 3)
local timerRecyclerCast								= mod:NewCastNPTimer(12, 1220752, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Rest of Boss mechanics
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnIncinerator								= mod:NewCountAnnounce(464149, 3)--Change to target warning if we can get pre targets somehow
local warnMeltdown									= mod:NewSpellAnnounce(1217954, 3)

local specWarnIncinerator							= mod:NewSpecialWarningMoveAway(464149, nil, nil, nil, 1, 2)
local yellIncinerator								= mod:NewShortYell(464149)
local specWarnDemolish								= mod:NewSpecialWarningDefensive(464112, nil, nil, nil, 1, 2)
local specWarnDemolishTaunt							= mod:NewSpecialWarningTaunt(464112, nil, nil, nil, 1, 2)
local specWarnTrashCompactor						= mod:NewSpecialWarningDodge(467135, nil, nil, nil, 2, 2)

local timerIncineratorCD							= mod:NewAITimer(97.3, 464149, nil, nil, nil, 3)
local timerTankComboCD								= mod:NewAITimer(97.3, 464112, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerOverdrive								= mod:NewBuffActiveTimer(10, 467117, nil, nil, nil, 6)

mod.vb.sortingCount = 0
mod.vb.sortedIcon = 1
mod.vb.bigBombCount = 0
mod.vb.smallBombIcon = 7
mod.vb.crewCount = 0
mod.vb.IncinCount = 0
mod.vb.tankComboCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	self.vb.sortingCount = 0
	self.vb.sortedIcon = 1
	self.vb.bigBombCount = 0
	self.vb.smallBombIcon = 7
	self.vb.crewCount = 0
	self.vb.IncinCount = 0
	self.vb.tankComboCount = 0
	timerElectroSortingCD:Start(1-delay)
	timerCleanupCrewCD:Start(1-delay)
	timerIncineratorCD:Start(1-delay)
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	if self.Options.NPAuraOnMessedUp or self.Options.NPAuraOnTerritorial then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnMessedUp or self.Options.NPAuraOnTerritorial then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

---@param self DBMMod
---@param bossGUID string
local function delayedTankCheck(self, bossGUID)
	local bossTarget = self:GetBossTarget(bossGUID) or DBM_COMMON_L.UNKNOWN
	specWarnDemolishTaunt:Show(bossTarget)
	specWarnDemolishTaunt:Play("tauntboss")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 464399 then
		self.vb.sortingCount = self.vb.sortingCount + 1
		self.vb.sortedIcon = 1
		self.vb.smallBombIcon = 7
		specWarnElectroSorting:Show(self.vb.sortingCount)
		specWarnElectroSorting:Play("specialsoon")
		timerElectroSortingCD:Start()--nil, self.vb.sortingCount+1
	elseif spellId == 466742 then
		warnDumpsterDive:Show()
		--timerDumpsterDiveCD:Start(nil, args.sourceGUID)
	elseif spellId == 1220752 then
		timerRecyclerCast:Start(nil, args.sourceGUID)
		--timerRecyclerCD:Start(nil, args.sourceGUID)
	elseif spellId == 464149 or spellId == 467802 then
		self.vb.IncinCount = self.vb.IncinCount + 1
		warnIncinerator:Show(self.vb.IncinCount)
		timerIncineratorCD:Start()--nil, self.vb.IncinCount+1
	elseif spellId == 464112 then
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnDemolish:Show()
			specWarnDemolish:Play("defensive")
		else
			--Delayed so it doesn't grab invalid target since boss might be looking at previous target on first frame
			self:Schedule(0.3, delayedTankCheck, self, args.sourceGUID)
		end
	elseif spellId == 1217954 then
		warnMeltdown:Show()
	elseif spellId == 467117 then
		--Stop/restart all timers?
		timerElectroSortingCD:Stop()
		timerCleanupCrewCD:Stop()
		timerIncineratorCD:Stop()
		timerTankComboCD:Stop()
		--TODO, maybe start these timers on overdrive ending instead
		timerOverdrive:Start()
		timerElectroSortingCD:Start(2)
		timerCleanupCrewCD:Start(2)
		timerIncineratorCD:Start(2)
		timerTankComboCD:Start(2)
	elseif spellId == 467109 then
		specWarnTrashCompactor:Show()
		specWarnTrashCompactor:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 466849 then
		self.vb.crewCount = self.vb.crewCount + 1
		specWarnCleanupCrew:Show(self.vb.crewCount)
		specWarnCleanupCrew:Play("mobsoon")
		timerCleanupCrewCD:Start()--nil, self.vb.crewCount+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 465346 then
		local icon = self.vb.sortedIcon
		if self.Options.SetIconOnSorted then
			self:SetIcon(args.destName, icon, 24)--Autoclear after 24 seconds in case player dies before getting 461536
		end
		if args:IsPlayer() then
			specWarnSorted:Show(self:IconNumToTexture(icon))
			specWarnSorted:Play("mm"..icon)
			yellSorted:Yell(icon, icon)
			yellSortedFades:Countdown(spellId, nil, icon)
		end
		warnSorted:CombinedShow(0.5, args.destName)
		self.vb.sortedIcon = self.vb.sortedIcon + 1
	elseif spellId == 1217685 then
		if self.Options.NPAuraOnMessedUp then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 473066 then
		if self.Options.NPAuraOnTerritorial then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 464854 and args:IsPlayer() and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 473115 then
		timerShortFuseCast:Start(30, args.destGUID)
		if self.Options.SetIconOnSmallBomb and self.vb.smallBombIcon >= 5 then--Set only icons 5-7, 1-4 are used for sorting
			self:ScanForMobs(args.destGUID, 2, self.vb.smallBombIcon, 1, nil, 12, "SetIconOnSmallBomb")
		end
		self.vb.smallBombIcon = self.vb.smallBombIcon - 1
	elseif spellId == 1218704 and args:IsPlayer() then
		specWarnPowercoil:Show()
		specWarnPowercoil:Play("targetyou")
	elseif spellId == 1219384 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnScrapRockets:Show(args.sourceName, count)
			if count == 1 then
				specWarnScrapRockets:Play("kick1r")
			elseif count == 2 then
				specWarnScrapRockets:Play("kick2r")
			elseif count == 3 then
				specWarnScrapRockets:Play("kick3r")
			elseif count == 4 then
				specWarnScrapRockets:Play("kick4r")
			elseif count == 5 then
				specWarnScrapRockets:Play("kick5r")
			else
				specWarnScrapRockets:Play("kickcast")
			end
		end
	elseif spellId == 1220648 then
		if args:IsPlayer() then
			specWarnMarkedForRecycling:Show()
			specWarnMarkedForRecycling:Play("targetyou")
		else
			warnMarkedForRecycling:Show(args.destName)
		end
	elseif spellId == 472893 then
		if args:IsPlayer() then
			specWarnIncinerator:Show()
			specWarnIncinerator:Play("scatter")
			yellIncinerator:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 465346 then
		--if self.Options.SetIconOnSorted then
		--	self:SetIcon(args.destName, 0)
		--end
		if args:IsPlayer() then
			yellSortedFades:Cancel()
		end
	elseif spellId == 461536 then--Rolling Rubbish ending
		if self.Options.SetIconOnSorted then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 1217685 then
		if self.Options.NPAuraOnMessedUp then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 473066 then
		if self.Options.NPAuraOnTerritorial then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 467117 then
		timerOverdrive:Stop()
		--timerElectroSortingCD:Start(2)
		--timerCleanupCrewCD:Start(2)
		--timerIncineratorCD:Start(2)
		--timerTankComboCD:Start(2)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 464854 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 0 then--Discarded Doomsplosive
		--NANI
	elseif cid == 1 then--Small Bomb
		timerShortFuseCast:Cancel(args.destGUID)
	elseif cid == 2 then--Scrapmaster
		timerRecyclerCast:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 1217977 or spellId == 464863 or spellId == 464858) and self:AntiSpam(10, 1) then
		self.vb.bigBombCount = self.vb.bigBombCount + 1
--		warnBigBomb:Show(self.vb.bigBombCount)
		timerBigBomb:Start(20)
	end
end
