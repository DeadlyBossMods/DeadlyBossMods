local mod	= DBM:NewMod(2330, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(144747, 144767, 144963, 144941)--Mythic need other 2 IDs?
mod:SetEncounterID(2268)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282098 282107 285889 282155 282411",
	"SPELL_CAST_SUCCESS 282444 285878 282636",
	"SPELL_AURA_APPLIED 282079 285945 282135 286007 282209 282444 282834 286811 284663 285879",
--	"SPELL_AURA_REFRESH 282079",
	"SPELL_AURA_APPLIED_DOSE 285945 282444",
	"SPELL_AURA_REMOVED 282079 282135 286007 282834 286811",
--	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, fine tune Lacerating Claws swap stacks
--TODO, fine tune attack speed swaps?
--Line 2 of expression is wraths (that's right blizz put 0 of them in combat log)
--Line 3 of expression is hex, separated in case want to filter it out since it is a log spammer
--[[
(ability.id = 282098 or ability.id = 282107 or ability.id = 285889 or ability.id = 282155 or ability.id = 282411) and type = "begincast"
 or (ability.id = 282444 or ability.id = 285878 or ability.id = 282636) and type = "cast"
 or (ability.id = 282209 or ability.id = 282834 or ability.id = 286811 or ability.id = 284663) and type = "applydebuff"
 or (ability.id = 282135) and type = "applydebuff"
--]]
--General
local warnActivated						= mod:NewTargetAnnounce(118212, 3, 78740, nil, nil, nil, nil, nil, true)
--Paku's Aspect
local warnGiftofWind					= mod:NewSpellAnnounce(282098, 3)
local warnPakuWrath						= mod:NewSoonAnnounce(282107, 4)
--Gonk's Aspect
local warnCrawlingHex					= mod:NewTargetAnnounce(282135, 2)
--Kimbul's Aspect
local warnLaceratingClaws				= mod:NewStackAnnounce(282444, 2, nil, "Tank")
--Akunda's Aspect
local warnMindWipe						= mod:NewTargetNoFilterAnnounce(285878, 4)
local warnAkundasWrath					= mod:NewTargetAnnounce(286811, 2)
--Bwonsamdi
local warnBwonsamdisWrath				= mod:NewTargetNoFilterAnnounce(284663, 4, nil, false, 2)--Spammy latter fight, opt in, not opt out

--General
local specWarnActivated					= mod:NewSpecialWarningSwitchCount(118212, "Tank", DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(118212), nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--Pa'ku's Aspect
local specWarnHasteningWinds			= mod:NewSpecialWarningCount(270447, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(12, 270447), nil, 1, 2)
local specWarnHasteningWindsOther		= mod:NewSpecialWarningTaunt(270447, nil, nil, nil, 1, 2)--Should be dispelled vs tank swapped, but in super low case a 10 man group has no dispeller, we need tank warning
local specWarnPakusWrath				= mod:NewSpecialWarningMoveTo(282107, nil, nil, nil, 3, 2)
--Gonk's Aspect
local specWarnCrawlingHex				= mod:NewSpecialWarningYou(282135, nil, nil, nil, 1, 2)
local yellCrawlingHex					= mod:NewPosYell(282135)
local yellCrawlingHexFades				= mod:NewIconFadesYell(282135)
local yellCrawlingHexAlt				= mod:NewYell(282135)
local yellCrawlingHexFadesAlt			= mod:NewShortYell(282135)
local specWarnCrawlingHexNear			= mod:NewSpecialWarningClose(282135, nil, nil, nil, 1, 2)
local specWarnRaptorForm				= mod:NewSpecialWarningDefensive(285889, nil, nil, nil, 3, 2)
local specWarnGonksWrath				= mod:NewSpecialWarningSwitch(282155, "Dps", nil, nil, 1, 2)
local specWarnMarkofPrey				= mod:NewSpecialWarningRun(282209, nil, nil, nil, 4, 2)
local yellMarkofPrey					= mod:NewYell(282209)
--Kimbul's Aspect
local specWarnLaceratingClaws			= mod:NewSpecialWarningStack(282444, nil, 8, nil, nil, 1, 6)
local specWarnLaceratingClawsTaunt		= mod:NewSpecialWarningTaunt(282444, nil, nil, nil, 1, 2)
local specWarnKimbulsWrath				= mod:NewSpecialWarningYou(282834, nil, nil, nil, 1, 2)
local yellKimbulsWrath					= mod:NewYell(282834)
local yellKimbulsWrathFades				= mod:NewFadesYell(282834)
local specWarnKimbulsWrathNear			= mod:NewSpecialWarningClose(282834, nil, nil, nil, 1, 2)
--Akunda's Aspect
local specWarnThunderingStorm			= mod:NewSpecialWarningRun(282411, "Melee", nil, nil, 4, 2)
local specWarnMindWipe					= mod:NewSpecialWarningYou(285878, nil, nil, nil, 1, 2)
local specWarnAkundasWrath				= mod:NewSpecialWarningYou(286811, nil, nil, nil, 1, 2)
local yellAkundasWrath					= mod:NewYell(286811)
local yellAkundasWrathFades				= mod:NewFadesYell(286811)
--Krag'wa

--Bwonsamdi
local specWarnBwonsamdisWrath			= mod:NewSpecialWarningYou(284663, nil, nil, nil, 3, 2)
local specWarnBwonsamdisWrathDispel		= mod:NewSpecialWarningDispel(284663, "RemoveCurse", nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Pa'ku's Aspect
local timerGiftofWindCD					= mod:NewCDTimer(31.6, 282098, nil, nil, nil, 2)
local timerPakusWrathCD					= mod:NewCDCountTimer(70, 282107, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Gonk's Aspect
local timerCrawlingHexCD				= mod:NewCDTimer(25.4, 282135, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
local timerRaptorFormCD					= mod:NewCDTimer(15.8, 285889, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--15.8-17
local timerGonksWrathCD					= mod:NewCDTimer(60, 282155, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Kimbul's Aspect
local timerLaceratingClawsCD			= mod:NewCDTimer(26.8, 282444, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--26.8-31.6
local timerKinbulsWrathCD				= mod:NewCDTimer(60, 282834, nil, nil, nil, 3)
--Akunda's Aspect
local timerThunderingStormCD			= mod:NewCDTimer(19.5, 282411, nil, "Melee", nil, 3, nil, DBM_CORE_TANK_ICON)
local timerMindWipeCD					= mod:NewCDTimer(33.7, 285878, nil, nil, nil, 3)
local timerAkundasWrathCD				= mod:NewCDTimer(60, 283685, nil, nil, nil, 3)
--Krag'wa
local timerKragwasWrathCD				= mod:NewCDTimer(49.8, 282636, nil, nil, nil, 3)
--Bwonsamdi
local timerBwonsamdisWrathCD			= mod:NewCDCountTimer(50, 284666, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON..DBM_CORE_HEALER_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPakusWrath				= mod:NewCountdown(70, 282107, true, nil, 5)
--local countdownLaceratingClaws		= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage		= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(282079, true)--Not real spellID, just filler for now
mod:AddNamePlateOption("NPAuraOnPact", 282079)
mod:AddNamePlateOption("NPAuraOnPackHunter", 286007)
mod:AddNamePlateOption("NPAuraOnFixate", 282209)
mod:AddSetIconOption("SetIconHex", 282135, false)

--mod.vb.phase = 1
mod.vb.hexIcon = 1
mod.vb.hexIgnore = false
mod.vb.ignoredActivate = true
mod.vb.pakuWrathCount = 0
mod.vb.wrathCount = 0
mod.vb.kragwaCast = 0
local raptorsSeen = {}

local function clearActivateIgnore(self)
	self.vb.ignoredActivate = false
end

local function setHexIgnore(self)
	self.vb.hexIgnore = false
end

function mod:OnCombatStart(delay)
	table.wipe(raptorsSeen)
	self.vb.hexIcon = 1
	self.vb.hexIgnore = false
	self.vb.ignoredActivate = true
	self.vb.pakuWrathCount = 0
	self.vb.wrathCount = 0
	self.vb.kragwaCast = 0
	self:Schedule(3, clearActivateIgnore, self)
	if self.Options.NPAuraOnPact or self.Options.NPAuraOnPackHunter or self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(4, "enemypower", 2)
	end
	if self:IsMythic() then
		timerBwonsamdisWrathCD:Start(51-delay, 1)
	end
	if self:IsHard() then
		timerKragwasWrathCD:Start(29.7-delay)
	end
end

function mod:OnCombatEnd()
	table.wipe(raptorsSeen)
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPact or self.Options.NPAuraOnPackHunter or self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282098 then
		warnGiftofWind:Show()
		timerGiftofWindCD:Start()
	elseif spellId == 282107 then
		DBM:AddMsg("blizz added Paku's Wrath to CLEU, tell DBM author!")
		--specWarnPakusWrath:Show(args.sourceName)
		--specWarnPakusWrath:Play("gathershare")
		--timerPakusWrathCD:Start()
		--countdownPakusWrath:Start()
	elseif spellId == 285889 then
		timerRaptorFormCD:Start()
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnRaptorForm:Show()
				specWarnRaptorForm:Play("defensive")
				break
			end
		end
	elseif spellId == 282155 then
		DBM:AddMsg("blizz added Gonk's Wrath to CLEU, tell DBM author!")
		--specWarnGonksWrath:Show()
		--specWarnGonksWrath:Play("killmob")
		--timerGonksWrathCD:Start()
	elseif spellId == 282411 then
		timerThunderingStormCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, true, false) then--Only show warning if target/focus on caster
			specWarnThunderingStorm:Show()
			specWarnThunderingStorm:Play("justrun")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282444 then
		timerLaceratingClawsCD:Start()
	elseif spellId == 285878 then
		timerMindWipeCD:Start()
	--elseif spellId == 284666 then
		--timerBwonsamdisWrathCD:Start()
	elseif spellId == 282636 then
		self.vb.kragwaCast = self.vb.kragwaCast + 1
		if self.vb.kragwaCast == 1 or (self.vb.kragwaCast-1) % 3 == 0 then--1, 4, 7, 10, etc
			timerKragwasWrathCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282444 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 8 then
				if args:IsPlayer() then
					specWarnLaceratingClaws:Show(amount)
					specWarnLaceratingClaws:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnLaceratingClawsTaunt:Show(args.destName)
						specWarnLaceratingClawsTaunt:Play("tauntboss")
					else
						warnLaceratingClaws:Show(args.destName, amount)
					end
				end
			else
				warnLaceratingClaws:Show(args.destName, amount)
			end
		end
	elseif spellId == 285945 then
		local amount = args.amount or 1
		if (amount >= 12) and self:AntiSpam(5, 1) then--Fine Tune
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnHasteningWinds:Show(amount)
				specWarnHasteningWinds:Play("changemt")
			else
				specWarnHasteningWindsOther:Show(args.destName)
				specWarnHasteningWindsOther:Play("changemt")
			end
		end
	elseif spellId == 282079 then
		if self.Options.NPAuraOnPact then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 286007 then
		if self.Options.NPAuraOnPackHunter then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 282135 then
		local icon = self.vb.hexIcon
		if args:IsPlayer() then
			specWarnCrawlingHex:Show()
			specWarnCrawlingHex:Play("targetyou")
			if self.vb.hexIgnore then
				yellCrawlingHexAlt:Yell()
				yellCrawlingHexFadesAlt:Countdown(5)
			else
				yellCrawlingHex:Yell(icon, icon, icon)
				yellCrawlingHexFades:Countdown(5, nil, icon)
			end
		elseif self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnCrawlingHexNear:CombinedShow(0.3, args.destName)
			specWarnCrawlingHexNear:CancelVoice()--Avoid spam
			specWarnCrawlingHexNear:ScheduleVoice(0.3, "runaway")
		else
			warnCrawlingHex:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconHex and not self.vb.hexIgnore then
			self:SetIcon(args.destName, icon)
		end
		self.vb.hexIcon = self.vb.hexIcon + 1
	elseif spellId == 282209 then
		if args:IsPlayer() then
			specWarnMarkofPrey:Show()
			specWarnMarkofPrey:Play("justrun")
			yellMarkofPrey:Yell()
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
		if not raptorsSeen[args.sourceGUID] then
			raptorsSeen[args.sourceGUID] = true
			if self:AntiSpam(10, 2) then
				specWarnGonksWrath:Show()
				specWarnGonksWrath:Play("killmob")
				timerGonksWrathCD:Start()
			end
		end
	elseif spellId == 282834 then
		if args:IsPlayer() then
			specWarnKimbulsWrath:Show()
			specWarnKimbulsWrath:Play("targetyou")
			yellKimbulsWrath:Yell()
			yellKimbulsWrathFades:Countdown(12)
		elseif self:CheckNearby(5, args.destName) then
			specWarnKimbulsWrathNear:CombinedShow(1, args.destName)
			specWarnKimbulsWrathNear:ScheduleVoice(1, "runaway")
		end
		if self:AntiSpam(10, 3) then
			timerKinbulsWrathCD:Start()
		end
	elseif spellId == 285879 then
		if args:IsPlayer() then
			specWarnMindWipe:Show()
			specWarnMindWipe:Play("targetyou")
		else
			warnMindWipe:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 286811 then
		if args:IsPlayer() then
			specWarnAkundasWrath:Show()
			specWarnAkundasWrath:Play("runout")
			yellAkundasWrath:Yell()
			yellAkundasWrathFades:Countdown(6)
		else
			warnAkundasWrath:CombinedShow(0.3, args.destName)
		end
		if self:AntiSpam(10, 4) then
			timerAkundasWrathCD:Start()
		end
	elseif spellId == 284663 then
		if args:IsPlayer() then
			specWarnBwonsamdisWrath:Show()
			specWarnBwonsamdisWrath:Play("targetyou")
		else
			warnBwonsamdisWrath:Show(args.destName)
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnBwonsamdisWrathDispel:Show(args.destName)
			specWarnBwonsamdisWrathDispel:Play("helpdispel")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282079 then
		if self.Options.NPAuraOnPact then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 282135 then
		if args:IsPlayer() then
			yellCrawlingHexFades:Cancel()
		end
	elseif spellId == 286007 then
		if self.Options.NPAuraOnPackHunter then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 282209 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 282834 then
		if args:IsPlayer() then
			yellKimbulsWrathFades:Cancel()
		end
	elseif spellId == 286811 then
		if args:IsPlayer() then
			yellAkundasWrathFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:282107") then
		self.vb.pakuWrathCount = self.vb.pakuWrathCount + 1
		specWarnPakusWrath:Show(L.Bird)
		specWarnPakusWrath:Play("gathershare")
		if self:IsMythic() then
			warnPakuWrath:Schedule(50)
			timerPakusWrathCD:Start(60, self.vb.pakuWrathCount+1)
			countdownPakusWrath:Start(60)
		else
			warnPakuWrath:Schedule(60)
			timerPakusWrathCD:Start(70, self.vb.pakuWrathCount+1)
			countdownPakusWrath:Start(70)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if msg:find(L.BwonsamdiWrath) or msg == L.BwonsamdiWrath or msg:find(L.BwonsamdiWrath2) or msg == L.BwonsamdiWrath2 then
		self:SendSync("BwonsamdiWrath")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 130966 then--Permanent Feign Death (dying/leaving) (slightly faster than UNIT_DIED)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 144747 then--Pa'ku's Aspect
			timerGiftofWindCD:Stop()
			--local pakusWrathRemaining = timerPakusWrathCD:GetRemaining(self.vb.pakuWrathCount+1) or 0
			--if pakusWrathRemaining >= 14 then
				--if it's less than 13, it's going to happen regardless of death, because bird spawns 13 seconds before cast
				--timerPakusWrathCD:Stop()
				--countdownPakusWrath:Cancel()
			--end
		elseif cid == 144767 then--Gonk's Aspect
			timerCrawlingHexCD:Stop()
			timerRaptorFormCD:Stop()
			--timerGonksWrathCD:Stop()
		elseif cid == 144963 then--Kimbul's Aspect
			timerLaceratingClawsCD:Stop()
			--timerKinbulsWrathCD:Stop()
		elseif cid == 144941 then--Akunda's Aspect
			timerThunderingStormCD:Stop()
			timerMindWipeCD:Stop()
			--timerAkundasWrathCD:Stop()
		end
	elseif spellId == 282080 then--Loa's Pact (entering)
		if not self.vb.ignoredActivate then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
		end
		--Start Timers
		local cid = self:GetUnitCreatureId(uId)
		if cid == 144747 then--Pa'ku's Aspect
			--self.vb.pakuWrathCount = 0
			timerGiftofWindCD:Start(4.8)--Assuming he always starts at 90 energy even when he isn't spawned on pull
			timerPakusWrathCD:Start(73.5, self.vb.pakuWrathCount+1)--When actual aoe starts, first event we can detect
			countdownPakusWrath:Start(73.5)
		elseif cid == 144767 then--Gonk's Aspect
			timerCrawlingHexCD:Start(14)--Assuming starting at 70 energy is always true
			timerRaptorFormCD:Start(15.7)
			timerGonksWrathCD:Start(31)
		elseif cid == 144963 then--Kimbul's Aspect
			timerLaceratingClawsCD:Start(10.3)
			timerKinbulsWrathCD:Start(42.2)
		elseif cid == 144941 then--Akunda's Aspect
			timerMindWipeCD:Start(5.6)
			timerAkundasWrathCD:Start(13)
			timerThunderingStormCD:Start(15.4)
		end
	elseif spellId == 283193 then--Since blizzard hates combat log so much (clawing hex)
		self.vb.hexIcon = 1
		self.vb.hexIgnore = false
		self:Schedule(1.5, setHexIgnore, self)
		timerCrawlingHexCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "BwonsamdiWrath" then
		self.vb.wrathCount = self.vb.wrathCount + 1
		timerBwonsamdisWrathCD:Start(50, self.vb.wrathCount+1)
	end
end
