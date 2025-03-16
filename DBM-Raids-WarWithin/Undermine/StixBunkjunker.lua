if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2642, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(230322)
mod:SetEncounterID(3012)
mod:SetUsedIcons(7, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20250111000000)
mod:SetMinSyncRevision(20250111000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 464399 466742 1220752 464112 1217954 467117 467109",
	"SPELL_CAST_SUCCESS 464149",
	"SPELL_AURA_APPLIED 465346 1217685 464854 473115 473066 1218704 1219384 1220648 466748 472893 461536",
	"SPELL_AURA_APPLIED_DOSE 466748",
	"SPELL_AURA_REMOVED 465346 461536 1217685 473115 473066 467117",
	"SPELL_PERIODIC_DAMAGE 464854 464248",
	"SPELL_PERIODIC_MISSED 464854 464248",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe use https://www.wowhead.com/spell=263753/spawn-trash as shortext for sorting
--TODO, see how others handle icons for sorting. Right now I keep them persent until full Rolling Rubish mechanic ends
--TODO, Discarded Doomsplosive spawn and auto marking if possible?
--TODO, fancy infoframe that tracks active bombs, times remaining, as well as time remaining on https://www.wowhead.com/ptr-2/spell=1217975/doomsploded
--TODO, more with power coil
--TODO, dumpster dive upgrade emphasis and just make it aoe dodge alert
--TODO, taunt DURING demolish cast, or immediately on completion of cast
--TODO, clear bomb count using SPELL_DAMAGE 465747? of course first we have to find a way to increment bomb count
--TODO, prevent starting new timers if overdrive soon. this is on hold til other difficulties seen
--TODO, add rolled? 465611. I feel it's pretty obvious you're stunned...by the stun
--TODO, verify which variant of timers is final version, the slower fight pacing harder tests saw or faster pacing normal and LFR saw, or are both pacings still used
--[[
 (ability.id = 464399 or ability.id = 464112 or ability.id = 1217954) and type = "begincast"
  or ability.id = 464149 and type = "cast"
  or ability.id = 467117
--]]
--Sorting
mod:AddTimerLine(DBM:GetSpellName(464399))
local warnSorted									= mod:NewTargetNoFilterAnnounce(465346, 3)
local warnInfectedbite								= mod:NewCountAnnounce(466748, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(466748))--Player

local specWarnElectroSorting						= mod:NewSpecialWarningCount(464399, nil, nil, DBM_COMMON_L.BALLS.. "+" ..DBM_COMMON_L.ADDS, 2, 2)
local specWarnSorted								= mod:NewSpecialWarningYouPos(461536, nil, nil, nil, 1, 2)--Pre target debuff for Rolling Rubbish
local yellSorted									= mod:NewShortPosYell(461536)
local yellSortedFades								= mod:NewIconFadesYell(461536)
local specWarnSortedTaunt							= mod:NewSpecialWarningTaunt(461536, nil, nil, nil, 1, 2)
local specWarnPowercoil								= mod:NewSpecialWarningYou(1218704, nil, nil, nil, 1, 2, 4)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(464854, nil, nil, nil, 1, 8)

local timerElectroSortingCD							= mod:NewNextCountTimer(51.1, 464399, DBM_COMMON_L.BALLS.. "+" ..DBM_COMMON_L.ADDS.." (%s)", nil, nil, 2)
local timerRollingPlayer							= mod:NewBuffFadesTimer(20, 461536, nil, nil, nil, 5, nil, nil, nil, 1, 5)
--local timerBigBomb								= mod:NewCastTimer(20, 464865, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerShortFuseCast							= mod:NewCastNPTimer(30, 473115, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnBalls", 465346, false, 0, {1, 2, 3, 4, 5}, true)
mod:AddSetIconOption("SetIconOnScrapmasters", -31645, true, 5, {2, 4, 5, 7}, true)
--mod:AddSetIconOption("SetIconOnBigBomb", 464865, true, 5, {8})
--mod:AddSetIconOption("SetIconOnSmallBomb", -30451, false, 5, {5, 6, 7}, true)
mod:AddNamePlateOption("NPAuraOnMessedUp", 1217685)
mod:AddNamePlateOption("NPAuraOnTerritorial", 473066)
--mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)
--Cleanup Crew
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30533))
local warnDumpsterDive								= mod:NewCastAnnounce(466742, 4)--Spammy without way to scope it to specific target
local warnMarkedForRecycling						= mod:NewTargetNoFilterAnnounce(1220648, 4)

local specWarnScrapRockets							= mod:NewSpecialWarningInterruptCount(1219384, "HasInterrupt", nil, nil, 1, 2)
local specWarnMarkedForRecycling					= mod:NewSpecialWarningYou(1220648, nil, nil, nil, 3, 2)

--local timerDumpsterDiveCD							= mod:NewCDNPTimer(10.9, 466742, nil, nil, nil, 3)--10.9-24.4
--local timerRecyclerCD								= mod:NewCDNPTimer(97.3, 1220752, nil, nil, nil, 3)
local timerRecyclerCast								= mod:NewCastNPTimer(12, 1220752, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Rest of Boss mechanics
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local specWarnIncinerator							= mod:NewSpecialWarningMoveAwayCount(464149, nil, nil, nil, 2, 2)--Debuff is 472893 but we pre warn first
local specWarnIncineratorVictim						= mod:NewSpecialWarningYou(472893, nil, nil, nil, 1, 17)
--local yellIncinerator								= mod:NewShortYell(464149)--Spammy
local specWarnDemolish								= mod:NewSpecialWarningDefensive(464112, nil, nil, nil, 1, 2)
local specWarnMeltdown								= mod:NewSpecialWarningDefensive(1217954, nil, nil, nil, 1, 2)
local specWarnTrashCompactor						= mod:NewSpecialWarningDodge(467135, nil, nil, nil, 2, 2)

local timerIncineratorCD							= mod:NewNextCountTimer(25.5, 464149, nil, nil, nil, 3)
local timerDemolishCD								= mod:NewNextCountTimer(51.1, 464112, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMeltdownCD								= mod:NewNextCountTimer(51.1, 1217954, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerOverDriveCD								= mod:NewNextTimer(111.1, 467117, nil, nil, nil, 6)
local timerOverdrive								= mod:NewBuffActiveTimer(10, 467117, nil, nil, nil, 6)
local berserkTimer									= mod:NewBerserkTimer(600)

mod.vb.sortingCount = 0
mod.vb.sortedIcon = 1
mod.vb.bigBombCount = 0
mod.vb.IncinCount = 0
mod.vb.demolishCount = 0
mod.vb.meltdownCount = 0
local castsPerGUID = {}
local JWIconOrder = {2, 4, 5, 7} -- Circle, Triangle, Moon, Cross
local usedMarks, seenGUIDs = {}, {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	table.wipe(usedMarks)
	table.wipe(seenGUIDs)
	self.vb.sortingCount = 0
	self.vb.sortedIcon = 1
	self.vb.bigBombCount = 0
	self.vb.IncinCount = 0
	self.vb.demolishCount = 0
	self.vb.meltdownCount = 0
	if self:IsHard() then
		timerIncineratorCD:Start(11.1-delay, 1)
		timerDemolishCD:Start(17.8-delay, 1)
		timerElectroSortingCD:Start(22.2-delay, 1)
		timerMeltdownCD:Start(44.4-delay, 1)
		timerOverDriveCD:Start((self:IsMythic() and 55.6 or 111.1)-delay)
		berserkTimer:Start(self:IsMythic() and 385 or 480)
	else
		timerIncineratorCD:Start(10-delay, 1)
		timerDemolishCD:Start(16-delay, 1)
		timerElectroSortingCD:Start(20.1-delay, 1)
		timerMeltdownCD:Start(40-delay, 1)
		timerOverDriveCD:Start(100-delay)
	end
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 464399 then
		self.vb.sortingCount = self.vb.sortingCount + 1
		self.vb.sortedIcon = 1
		specWarnElectroSorting:Show(self.vb.sortingCount)
		specWarnElectroSorting:Play("specialsoon")
		timerElectroSortingCD:Start(self:IsHard() and 51.1 or 46.0, self.vb.sortingCount+1)
		--Hard reset icons, even if last adds are up, because new adds need prio marking
		table.wipe(usedMarks)
		table.wipe(seenGUIDs)
	elseif spellId == 466742 then
		if self:AntiSpam(4, 1) then
			warnDumpsterDive:Show()
		end
		--timerDumpsterDiveCD:Start(self:IsHard() and 10.9 or 15.8, args.sourceGUID)--Just not reliable
	elseif spellId == 1220752 then
		timerRecyclerCast:Start(nil, args.sourceGUID)
		--timerRecyclerCD:Start(nil, args.sourceGUID)
	elseif spellId == 464112 then
		self.vb.demolishCount = self.vb.demolishCount + 1
		timerDemolishCD:Start(self:IsHard() and 51.1 or 46.0, self.vb.demolishCount+1)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnDemolish:Show()
			specWarnDemolish:Play("defensive")
		end
	elseif spellId == 1217954 then
		self.vb.meltdownCount = self.vb.meltdownCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnMeltdown:Show()
			specWarnMeltdown:Play("defensive")
		end
		timerMeltdownCD:Start(self:IsHard() and 51.1 or 46.0, self.vb.meltdownCount+1)
	elseif spellId == 467117 then--Overdrive (P2 start)
		timerOverdrive:Start()
		--Stop Timers
		timerElectroSortingCD:Stop()
		timerIncineratorCD:Stop()
		timerDemolishCD:Stop()
		timerMeltdownCD:Stop()
	elseif spellId == 467109 then
		specWarnTrashCompactor:Show()
		specWarnTrashCompactor:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 464149 then
		self.vb.IncinCount = self.vb.IncinCount + 1
		specWarnIncinerator:Show(self.vb.IncinCount)
		specWarnIncinerator:Play("scatter")
		timerIncineratorCD:Start(self:IsHard() and 25.5 or 22.9, self.vb.IncinCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 465346 then
		local icon = self.vb.sortedIcon
		if self.Options.SetIconOnBalls then
			self:SetIcon(args.destName, icon, 24)--Autoclear after 24 seconds in case player dies before getting 461536
		end
		if args:IsPlayer() then
			specWarnSorted:Show(self:IconNumToTexture(icon))
			specWarnSorted:Play("mm"..icon)
			yellSorted:Yell(icon, icon)
			yellSortedFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--One of ball is always the tank, so it's also a tank swap
				specWarnSortedTaunt:Show(args.destName)
				specWarnSortedTaunt:Play("tauntboss")
			end
		end
		warnSorted:CombinedShow(0.5, args.destName)--Up to 5 targets, but scalable so no precise show
		self.vb.sortedIcon = self.vb.sortedIcon + 1
	elseif spellId == 1217685 then
		if self.Options.NPAuraOnMessedUp then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		if args:GetDestCreatureID() == 231839 then -- Scrapmaster
			for i = 1, 4 do
				if not usedMarks[i] and not seenGUIDs[args.destGUID] then
					seenGUIDs[args.destGUID] = i
					usedMarks[i] = args.destGUID
					if self.Options.SetIconOnScrapmasters then
						self:ScanForMobs(args.destGUID, 2, JWIconOrder[i], 1, nil, 12, "SetIconOnScrapmasters")
					end
					return
				end
			end
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
	elseif spellId == 466748 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 2 == 0 then--Stack frequency guesswork
			warnInfectedbite:Show(amount)
		end
	elseif spellId == 472893 and args:IsPlayer() then
		specWarnIncineratorVictim:Show()
		specWarnIncineratorVictim:Play("debuffyou")
		--yellIncinerator:Yell()
	elseif spellId == 461536 and args:IsPlayer() then
		timerRollingPlayer:Start(20)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 465346 then
		--if self.Options.SetIconOnBalls then
		--	self:SetIcon(args.destName, 0)
		--end
		if args:IsPlayer() then
			yellSortedFades:Cancel()
		end
	elseif spellId == 461536 then--Rolling Rubbish ending
		if self.Options.SetIconOnBalls then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			timerRollingPlayer:Stop()
		end
	elseif spellId == 1217685 then
		if self.Options.NPAuraOnMessedUp then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 473066 then
		if self.Options.NPAuraOnTerritorial then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 473115 then
		timerShortFuseCast:Stop(args.destGUID)
	elseif spellId == 467117 and self:IsInCombat() then
		timerOverdrive:Stop()
		if self:IsHard() then
			timerIncineratorCD:Start(13.2, self.vb.IncinCount+1)
			timerDemolishCD:Start(19.8, self.vb.demolishCount+1)
			timerElectroSortingCD:Start(24.2, self.vb.sortingCount+1)
			timerMeltdownCD:Start(46.5, self.vb.meltdownCount+1)
		else
			timerIncineratorCD:Start(12.2, self.vb.IncinCount+1)
			timerDemolishCD:Start(18.2, self.vb.demolishCount+1)
			timerElectroSortingCD:Start(22.3, self.vb.sortingCount+1)
			timerMeltdownCD:Start(42.2, self.vb.meltdownCount+1)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 464248 or spellId == 464854) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 231531 then--Territorial Bombshell
		timerShortFuseCast:Cancel(args.destGUID)
	elseif cid == 231839 then--Scrapmaster
		timerRecyclerCast:Cancel(args.destGUID)
		--timerDumpsterDiveCD:Stop(args.destGUID)
--	elseif cid == 230863 then--Discarded Doomsplosive

	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 1217977 or spellId == 464863 or spellId == 464858) and self:AntiSpam(10, 1) then
		self.vb.bigBombCount = self.vb.bigBombCount + 1
--		warnBigBomb:Show(self.vb.bigBombCount)
--		timerBigBomb:Start(20)
	end
end
--]]
