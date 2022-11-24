local mod	= DBM:NewMod(2469, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181954)
mod:SetEncounterID(2546)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220405000000)
mod:SetMinSyncRevision(20220405000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362405 361989 365295 361815 362771 363024 365120 365872 365958 365805",
	"SPELL_CAST_SUCCESS 365030 367631 363133",
	"SPELL_SUMMON 365039",
	"SPELL_AURA_APPLIED 362055 364031 361992 361993 365021 362505 362862 365966 366849 363028 367632 362774",
	"SPELL_AURA_APPLIED_DOSE 364248",
	"SPELL_AURA_REMOVED 362055 361992 361993 365021 362505 365966 367632",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, actually test all blasphemy stuff. Specifically using drop down and auto assignments.
--TODO, track https://ptr.wowhead.com/spell=365293/befouled-barrier somehow?
--TODO, adjust dark zeal count?
--TODO, add 10 second timer loop for https://ptr.wowhead.com/spell=362543/remorseless-winter with right events, not even gonna drycode it now in case it's wrong
--TODO, verify grim reflection auto marking, and number of spawns (still needs doing)
--TODO, dire hopelessness need repeat yell? it's not about partners finding each other this time, just a player walking into the light
--TODO, track https://ptr.wowhead.com/spell=362394/rain-of-despair maybe? definitely add https://ptr.wowhead.com/spell=362391/rain-of-despair with right trigger
--[[
(ability.id = 362405 or ability.id = 361989 or ability.id = 365295 or ability.id = 361815 or ability.id = 362771 or ability.id = 363024 or ability.id = 365120 or ability.id = 365872 or ability.id = 365958 or ability.id = 365805) and type = "begincast"
 or (ability.id = 363133 or ability.id = 365235 or ability.id = 365636 or ability.id = 365030 or ability.id = 367631 or ability.id = 366849) and type = "cast"
 or (ability.id = 362505 or ability.id = 365216) and (type = "applybuff" or type = "removebuff")
 or ability.id = 362862 and type = "applybuff"
--]]
--Stage One: Kingsmourne Hungers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24462))
local warnBefouledBarrier						= mod:NewSpellAnnounce(365295, 3, nil, nil, 300531)
local warnWickedStar							= mod:NewTargetCountAnnounce(365030, 3, nil, nil, nil, nil, nil, nil, true)
local warnDominationWordPain					= mod:NewTargetNoFilterAnnounce(366849, 3, nil, "Healer", 249194)

local specWarnKingsmourneHungers				= mod:NewSpecialWarningCount(362405, nil, nil, nil, 1, 2)
local specWarnMalignantward						= mod:NewSpecialWarningDispel(364031, "RemoveMagic", nil, nil, 1, 2)
local specWarnBlasphemy							= mod:NewSpecialWarningMoveAway(361989, nil, nil, nil, 3, 2)
local specWarnOverconfidence					= mod:NewSpecialWarningMoveTo(361992, nil, nil, nil, 1, 2)
local specWarnHopelessness						= mod:NewSpecialWarningMoveTo(361993, nil, nil, nil, 1, 2)
local yellBlasphemy								= mod:NewIconRepeatYell(361989, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell, nil, false)--Option hidden, it's controlled by dropdown
local specWarnWickedStar						= mod:NewSpecialWarningYou(365021, nil, nil, nil, 1, 2)
local yellWickedStar							= mod:NewShortPosYell(365021)
local yellWickedStarFades						= mod:NewIconFadesYell(365021)
local specWarnHopebreaker						= mod:NewSpecialWarningCount(361815, nil, nil, nil, 2, 2)
local specWarnDarkZeal							= mod:NewSpecialWarningCount(364248, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.stack:format(12, 364248), nil, 1, 2)
local specWarnDarkZealOther						= mod:NewSpecialWarningTaunt(364248, nil, nil, nil, 1, 2)

local timerPhaseCD								= mod:NewPhaseTimer(30)
local timerKingsmourneHungersCD					= mod:NewCDCountTimer(28.8, 362405, nil, nil, nil, 3)
local timerLostSoul								= mod:NewBuffFadesTimer(35, 362055, nil, nil, nil, 5)
local timerBlasphemyCD							= mod:NewCDCountTimer(28.8, 361989, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBefouledBarrierCD					= mod:NewCDCountTimer(28.8, 365295, 300531, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerWickedStarCD							= mod:NewCDCountTimer(28.8, 365030, nil, nil, nil, 3)
local timerWickedStar							= mod:NewTargetCountTimer(4, 365021, nil, false, nil, 5)
local timerHopebreakerCD						= mod:NewCDCountTimer(28.8, 361815, nil, nil, nil, 2)
local timerDominationWordPainCD					= mod:NewCDCountTimer(28.8, 366849, 249194, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddSetIconOption("SetIconOnAnduinsHope", "ej24468", true, true, {1, 2, 3, 4})
mod:GroupSpells(361989, 361992, 361993)--Group two debuffs with parent spell Blasphemy
mod:GroupSpells(365030, 365021)--Group both wicked star IDs
--Intermission: Remnant of a Fallen King
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24494))
local warnArmyofDead							= mod:NewSpellAnnounce(362862, 3)

local specWarnSoulReaper						= mod:NewSpecialWarningDefensive(362771, nil, nil, nil, 1, 2)
local specWarnSoulReaperTaunt					= mod:NewSpecialWarningTaunt(362771, nil, nil, nil, 1, 2)

local timerSoulReaperCD							= mod:NewCDCountTimer(12, 362771, nil, "Healer|Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArmyofDeadCD							= mod:NewCDTimer(36.9, 362862, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
----Monstrous Soul
local specWarnNecroticDetonation				= mod:NewSpecialWarningDefensive(363024, nil, nil, nil, 2, 2)--Aoe defensive, big damage followed by heal immunity

mod:AddRangeFrameOption(8, 363020)
mod:AddSetIconOption("SetIconOnMonstrousSoul", 363028, true, true, {8})

--Stage Two: Grim Reflections
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24478))
local specWarnGrimReflections					= mod:NewSpecialWarningSwitch(365120, "-Healer", nil, nil, 1, 2)
local specWarnPsychicTerror						= mod:NewSpecialWarningInterruptCount(365008, "HasInterrupt", nil, nil, 1, 2)

local timerGrimReflectionsCD					= mod:NewCDCountTimer(28.8, 365120, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)

mod:AddSetIconOption("SetIconOnGrimReflection", 365120, true, true, {5, 6, 7, 8})

--Intermission: March of the Damned
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24172))
local warnMarchoftheDamned						= mod:NewSpellAnnounce(364020, 3)

local timerMarchofDamnedCD						= mod:NewCDTimer(28.8, 364020, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

--Stage Three: A Moment of Clarity
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24417))
local warnBeaconofHope							= mod:NewCastAnnounce(365872, 1)

local specWarnDireBlasphemy						= mod:NewSpecialWarningMoveAway(365966, nil, nil, nil, 3, 2)
local specWarnS3Hopelessness					= mod:NewSpecialWarningYou(365966, nil, nil, nil, 1, 2)
local yellHopelessness							= mod:NewYell(365966)
local yellHopelessnessRepeat					= mod:NewIconRepeatYell(365966, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnEmpoweredHopebreaker				= mod:NewSpecialWarningCount(365805, nil, nil, nil, 2, 2)

local timerHopelessnessCD						= mod:NewCDTimer(28.8, 365966, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddInfoFrameOption(365966, false)

mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("PairingBehavior", {"Auto", "Generic", "None"}, "Generic", "misc")--Controls the yellBlasphemy/specWarnOverconfidence/specWarnHopelessness

mod.vb.hungersCount = 0
mod.vb.blastphemyCount = 0
mod.vb.befouledCount = 0
mod.vb.hopebreakerCount = 0
mod.vb.wickedCount = 0
mod.vb.domCount = 0
mod.vb.wickedSet = 1
mod.vb.addIcon = 8
mod.vb.PairingBehavior = "Generic"
local playersSouled = {}
local playerName = UnitName("player")
local overconfidentTargets = {}
local hopelessnessTargets = {}
local hopelessnessName, overconfidenceName = DBM:GetSpellInfo(361993), DBM:GetSpellInfo(361992)
local castsPerGUID = {}
local allTimers = {
	[1] = {
		--Befouled Barrier
		[365295] = {17, 51.9, 48},
		--Blasphemy
		[361989] = {30, 49.9, 54.9},
		--Hopebreaker
		[361815] = {5, 31.9, 28, 29.9, 29.9},
		--Kingsmourne Hungers
		[362405] = {45, 60},
		--Wicked Star
		[365030] = {55, 34.9, 29.9},
		--Domination Word: Pain
		[366849] = {7.0, 13.0, 13.0, 10.0, 15.0, 13.1, 12.9, 13.0, 13.9, 12.2, 14.8},
	},
	[2] = {
		--Befouled Barrier
		[365295] = {80.6, 47},
		--Grim Reflections (Replaces Blasphemy in Stage 2)
		[365120] = {8.5, 87},
		--Hopebreaker
		[361815] = {13.6, 24.9, 32.9, 29, 28.9},
		--Kingsmourne Hungers
		[362405] = {48.6, 60},
		--Wicked Star
		[365030] = {18.6, 39, 25.9, 30.8, 19.1},
		--Domination Word: Pain
		[366849] = {10.6, 13, 13, 17.7, 8.1, 13, 13, 14.4, 11.2, 12.2},
	},
}

local function updateTimerFades(self)
	if playersSouled[playerName] then
		timerBlasphemyCD:SetFade(true)
		timerBefouledBarrierCD:SetFade(true)
		timerWickedStarCD:SetFade(true)
		timerHopebreakerCD:SetFade(true)
		timerGrimReflectionsCD:SetFade(true)
	else
		timerBlasphemyCD:SetFade(false)
		timerBefouledBarrierCD:SetFade(false)
		timerWickedStarCD:SetFade(false)
		timerHopebreakerCD:SetFade(false)
		timerGrimReflectionsCD:SetFade(false)
	end
end

local function BlasphemyYellRepeater(self, text)
	yellBlasphemy:Yell(text)
	self:Schedule(1.5, BlasphemyYellRepeater, self, text)
end

local function DireYellRepeater(self, text)
	yellHopelessnessRepeat:Yell(text)
	self:Schedule(1.5, DireYellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.hungersCount = 0
	self.vb.blastphemyCount = 0
	self.vb.befouledCount = 0
	self.vb.hopebreakerCount = 0
	self.vb.wickedCount = 0
	self.vb.domCount = 0
	self.vb.PairingBehavior = self.Options.PairingBehavior--Default it to whatever user has it set to, until group leader overrides it
	table.wipe(playersSouled)
	updateTimerFades(self)--Reset to normal status
	--Presently same in all modes
	timerHopebreakerCD:Start(5-delay, 1)
	timerDominationWordPainCD:Start(7-delay, 1)
	timerBefouledBarrierCD:Start(17-delay, 1)
	timerBlasphemyCD:Start(30-delay, 1)
	timerKingsmourneHungersCD:Start(45-delay, 1)
	timerWickedStarCD:Start(55-delay, 1)
	if self:IsMythic() or self:IsLFR() then
		timerPhaseCD:Start(164-delay)
	else
		timerPhaseCD:Start(155-delay)
	end
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.PairingBehavior == "Auto" then
			self:SendSync("Auto")
		elseif self.Options.PairingBehavior == "Generic" then
			self:SendSync("Generic")
		elseif self.Options.PairingBehavior == "None" then
			self:SendSync("None")
		end
	end
end

function mod:OnCombatEnd()
	table.wipe(overconfidentTargets)
	table.wipe(hopelessnessTargets)
	table.wipe(castsPerGUID)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 362055) then
			local name = DBM:GetUnitFullName(uId)
			playersSouled[name] = true
		end
	end
	updateTimerFades(self)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362405 then
		self.vb.hungersCount = self.vb.hungersCount + 1
		specWarnKingsmourneHungers:Show(self.vb.hungersCount)
		specWarnKingsmourneHungers:Play("shockwave")
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.hungersCount+1)
		if timer then
			timerKingsmourneHungersCD:Start(timer, self.vb.hungersCount+1)
		end
		if self.Options.SetIconOnAnduinsHope then
			self:ScanForMobs(184493, 1, 1, 4, nil, 12, "SetIconOnAnduinsHope", true)
		end
	elseif spellId == 361989 then
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1
		if not playersSouled[playerName] then
			specWarnBlasphemy:Show()
			specWarnBlasphemy:Play("scatter")
		end
		table.wipe(overconfidentTargets)
		table.wipe(hopelessnessTargets)
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.blastphemyCount+1)
		if timer then
			timerBlasphemyCD:Start(timer, self.vb.blastphemyCount+1)
		end
	elseif spellId == 365958 then
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1
		specWarnDireBlasphemy:Show()
		specWarnDireBlasphemy:Play("scatter")
		timerHopelessnessCD:Start(self:IsMythic() and 65.5 or 58.4)
	elseif spellId == 365295 then
		self.vb.befouledCount = self.vb.befouledCount + 1
		warnBefouledBarrier:Show(self.vb.befouledCount)
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.befouledCount+1)
		if timer then
			timerBefouledBarrierCD:Start(timer, self.vb.befouledCount+1)
		end
	elseif spellId == 361815 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		if not playersSouled[playerName] then
			specWarnHopebreaker:Show(self.vb.hopebreakerCount)
			specWarnHopebreaker:Play("aesoon")
		end
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.hopebreakerCount+1)
		if timer then
			timerHopebreakerCD:Start(timer, self.vb.hopebreakerCount+1)
		end
	elseif spellId == 365805 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		specWarnEmpoweredHopebreaker:Show(self.vb.hopebreakerCount)
		specWarnEmpoweredHopebreaker:Play("aesoon")
		timerHopebreakerCD:Start(self:IsMythic() and 65.5 or 58.4, self.vb.hopebreakerCount+1)
	elseif spellId == 362771 then
		self.vb.befouledCount = self.vb.befouledCount + 1--Reused since befoulment not happening here
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss2 if confirmed remnant is always boss2, to save cpu
			specWarnSoulReaper:Show()
			specWarnSoulReaper:Play("defensive")
		end
		timerSoulReaperCD:Start(12, self.vb.befouledCount+1)
	elseif spellId == 363024 then
		specWarnNecroticDetonation:Show()
		specWarnNecroticDetonation:Play("defensive")
	elseif spellId == 365120 then
		self.vb.addIcon = 8
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1--This ability replaces blasphomy in stage 2, so might as well use it's variable
		specWarnGrimReflections:Show()
		specWarnGrimReflections:Play("killmob")
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.blastphemyCount+1)
		if timer then
			timerGrimReflectionsCD:Start(timer, self.vb.blastphemyCount+1)
		end
	elseif spellId == 365008 then
		if not castsPerGUID[args.sourceGUID] then--This should have been set in summon event
			--But if that failed, do it again here and scan for mobs again here too
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnGrimReflection and self.vb.addIcon > 4 then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGrimReflection")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnPsychicTerror:Show(args.sourceName, count)
			if count < 6 then
				specWarnPsychicTerror:Play("kick"..count.."r")
			else
				specWarnPsychicTerror:Play("kickcast")
			end
		end
	elseif spellId == 365872 then
		warnBeaconofHope:Show()
		--Check for skipped intermission, which happens when overgearing
		if self.vb.phase < 3 then
			self.vb.blastphemyCount = 0
			self.vb.hopebreakerCount = 0
			self.vb.wickedCount = 0
			self:SetStage(3)
			timerArmyofDeadCD:Stop()
			timerSoulReaperCD:Stop()
			timerMarchofDamnedCD:Stop()
			timerHopebreakerCD:Start(9.8, 1)
			timerHopelessnessCD:Start(19.8)
			timerWickedStarCD:Start(39.8, 1)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(365966))
				DBM.InfoFrame:Show(20, "playerdebuffremaining", 365966)
			end
			--If an intermission was skipped, affix timer does NOT reset, it continues from previous reset (intermission)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365030 or spellId == 367631 then
		self.vb.wickedCount = self.vb.wickedCount + 1
		self.vb.wickedSet = 1
		if self.vb.phase then
			if self.vb.phase < 3 then
				local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, 365030, self.vb.wickedCount+1)
				if timer then
					timerWickedStarCD:Start(timer, self.vb.wickedCount+1)
				end
			else
				timerWickedStarCD:Start(self:IsMythic() and 65.5 or 58.4, self.vb.wickedCount+1)
			end
		end
	elseif spellId == 363133 then
		warnMarchoftheDamned:Show()
		timerMarchofDamnedCD:Start(7.4)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 365039 then--Hiddem from CLEU, but if it's ever enabled, marking will become about 1-2 sec faster automatically
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
		end
		if self.Options.SetIconOnGrimReflection then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGrimReflection")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 362055 then--Not currently in combat log
		playersSouled[args.destName] = true
		if #playersSouled == 1 then
			timerLostSoul:Start()
			if self.Options.InfoFrame and self:IsMythic() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(20, "playerbaddebuff", 362055, nil, true)
			end
		end
		if args:IsPlayer() then
			updateTimerFades(self)
		end
	elseif spellId == 364031 and playersSouled[playerName] and self:CheckDispelFilter("magic") then
		specWarnMalignantward:Show(args.destName)
		specWarnMalignantward:Play("helpdispel")
	elseif spellId == 361992 or spellId == 361993 then--361992 Overconfidence, 361993 Hopelessness
		local icon
		local count
		--Determin this debuff and assign icon based on dropdown setting and which debuff it is and construct tables
		if spellId == 361992 then--Overconfidence
			overconfidentTargets[#overconfidentTargets + 1] = args.destName
			count = #overconfidentTargets
		else--Hopelessness
			hopelessnessTargets[#hopelessnessTargets + 1] = args.destName
			count = #hopelessnessTargets
		end
		--Determine if player is in either debuff table by matching current table with other table.
		--If no other table can be found yet, it'll actually not do anything until it has a pair
		local playerIsInPair = false
		if hopelessnessTargets[count] and overconfidentTargets[count] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnOverconfidence:Show(hopelessnessTargets[count])--Paired players name
				icon = count
			else
				specWarnOverconfidence:Show(hopelessnessName)--Just the name of debuff they need to pair with
				icon = 1--Star
			end
			specWarnOverconfidence:Play("gather")
			playerIsInPair = true
		elseif overconfidentTargets[count] and hopelessnessTargets[count] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnHopelessness:Show(overconfidentTargets[count])--Paired players name
				icon = count
			else
				specWarnHopelessness:Show(overconfidenceName)--Just the name of debuff they need to pair with
				icon = 3--Diamond
			end
			specWarnHopelessness:Play("gather")
			playerIsInPair = true
		end
		--Player is in current pair, finish constructing icon and schedule repeating yell
		if playerIsInPair and self.vb.PairingBehavior ~= "None" then
			--need to account for up to 30 people (15 pairs)?
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			elseif icon == 11 then
				icon = "(ಥ﹏ಥ)"
			elseif icon == 12 then
				icon = "(ツ)"
			elseif icon == 13 then
				icon = "ʕ•ᴥ•ʔ"
			elseif icon == 14 then
				icon = "ಠ_ಠ"
			elseif icon == 15 then
				icon = "(͡°͜°)"
			end
			self:Unschedule(BlasphemyYellRepeater)
			if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
			self:Schedule(1.5, BlasphemyYellRepeater, self, icon)--Shorter repeater since 6 seconds won't trigger throttle.
			yellBlasphemy:Yell(icon)
		end
	elseif spellId == 365966 then
		if args:IsPlayer() then
			specWarnS3Hopelessness:Show()
			specWarnS3Hopelessness:Play("targetyou")
			yellHopelessness:Yell()
			self:Unschedule(DireYellRepeater)
			self:Schedule(1.5, DireYellRepeater, self, 3)--Lasts longer, so slightly slower repeater to avoid throttling
		end
	elseif spellId == 365021 or spellId == 367632 then
		local icon = self.vb.wickedSet
		if args:IsPlayer() then
			specWarnWickedStar:Show()
			specWarnWickedStar:Play("runout")
			yellWickedStar:Yell(icon, icon)
			yellWickedStarFades:Countdown(spellId, nil, icon)
--		else
--			local uId = DBM:GetRaidUnitId(args.destName)
--			if self:IsTanking(uId) then
--				specWarnWickedStarTaunt:Show(args.destName)
--				specWarnWickedStarTaunt:Play("tauntboss")
--			end
		end
		warnWickedStar:Show(icon, args.destName)
		if not playersSouled[playerName] then
			timerWickedStar:Start(4, args.destName, icon)
		end
		self.vb.wickedSet = self.vb.wickedSet + 1
	elseif spellId == 364248 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnDarkZeal:Show(amount)
				specWarnDarkZeal:Play("changemt")
			elseif not playersSouled[playerName] then
				specWarnDarkZealOther:Show(args.destName)
				specWarnDarkZealOther:Play("tauntboss")
			end
		end
	elseif spellId == 362505 then--or spellId == 365216
		timerKingsmourneHungersCD:Stop()
		timerBlasphemyCD:Stop()
		timerBefouledBarrierCD:Stop()
		timerWickedStarCD:Stop()
		timerHopebreakerCD:Stop()
		timerDominationWordPainCD:Stop()
		self.vb.befouledCount = 0--Reused for soulreaper to save on sync variables
		if self.vb.phase == 1 then
			self:SetStage(1.5)
			if self:IsMythic() then
				timerMarchofDamnedCD:Start(7.5)--Only mythic has this in first intermission
				timerPhaseCD:Start(81.9)--Mythic also has 2nd intermission length for first one
			else
				timerPhaseCD:Start(self:IsLFR() and 73 or 156)
			end
			timerArmyofDeadCD:Start(7.5)
			timerSoulReaperCD:Start(14.5, 1)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			self:SetStage(2.5)
			timerArmyofDeadCD:Start(12.7)
			timerMarchofDamnedCD:Start(12.7)--Only used in second intermission (on non mythic)
			timerSoulReaperCD:Start(19.7, 1)
			timerPhaseCD:Start(self:IsMythic() and 86.7 or self:IsLFR() and 56.7 or 80)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self:IsFated() then
			self:AffixEvent(0)
		end
	elseif spellId == 362774 and not args:IsPlayer() then
		specWarnSoulReaperTaunt:Show(args.destName)
		specWarnSoulReaperTaunt:Play("tauntboss")
	elseif spellId == 362862 then
		warnArmyofDead:Show()
		timerArmyofDeadCD:Start(36.9)
	elseif spellId == 366849 then
		warnDominationWordPain:CombinedShow(0.3, args.destName)
	elseif spellId == 363028 then
		if self.Options.SetIconOnMonstrousSoul then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnMonstrousSoul")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 362055 then
		playersSouled[args.destName] = nil
		if #playersSouled == 0 then
			timerLostSoul:Stop()
			if self.Options.InfoFrame and self:IsMythic() then
				DBM.InfoFrame:Hide()
			end
		end
		if args:IsPlayer() then
			updateTimerFades(self)
		end
	elseif spellId == 361992 or spellId == 361993 then--361992 Overconfidence, 361993 Hopelessness
		if args:IsPlayer() then
			self:Unschedule(BlasphemyYellRepeater)
		end
	elseif spellId == 365966 then
		if args:IsPlayer() then
			self:Unschedule(DireYellRepeater)
		end
	elseif spellId == 365021 or spellId == 367632 then
		if args:IsPlayer() then
			yellWickedStarFades:Cancel()
		end
	elseif spellId == 362505 then-- or spellId == 365216
		self.vb.hungersCount = 0
		self.vb.blastphemyCount = 0
		self.vb.befouledCount = 0
		self.vb.hopebreakerCount = 0
		self.vb.wickedCount = 0
		self.vb.domCount = 0
		if self.vb.phase == 1.5 then
			self:SetStage(2)
			timerArmyofDeadCD:Stop()
			timerSoulReaperCD:Stop()
			timerGrimReflectionsCD:Start(8.5, 1)--Only new ability in stage 2, basically replaces Blasphemy
			timerDominationWordPainCD:Start(10.6, 1)
			timerHopebreakerCD:Start(13.6, 1)
			timerWickedStarCD:Start(18.6, 1)
			timerKingsmourneHungersCD:Start(48.6, 1)
			timerBefouledBarrierCD:Start(80.6, 1)
			timerPhaseCD:Start(self:IsMythic() and 171 or 156)
			if self:IsFated() then
				self:AffixEvent(1, 2)
			end
		else--end of 2.5
			self:SetStage(3)
			timerArmyofDeadCD:Stop()
			timerSoulReaperCD:Stop()
			timerMarchofDamnedCD:Stop()
			timerHopebreakerCD:Start(10.4, 1)
			timerHopelessnessCD:Start(20.4)
			timerWickedStarCD:Start(40.4, 1)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(365966))
				DBM.InfoFrame:Show(20, "playerdebuffremaining", 365966)
			end
			if self:IsFated() then
				self:AffixEvent(1, 3)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183033 then--Grim Reflection
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 366849 then
		self.vb.domCount = self.vb.domCount + 1
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.domCount+1)
		if timer then
			timerDominationWordPainCD:Start(timer, self.vb.domCount+1)
		end
	end
end

do
	--Delayed function just to make absolute sure RL sync overrides user settings after OnCombatStart functions run
	local function UpdateRLPreference(self, msg)
		if msg == "Auto" then
			self.vb.PairingBehavior = "Auto"
		elseif msg == "Generic" then
			self.vb.PairingBehavior = "Generic"
		elseif msg == "None" then
			self.vb.PairingBehavior = "None"
		end
	end
	function mod:OnSync(msg)
		if self:IsLFR() then return end
		if msg == "Auto" or msg == "Generic" or msg == "None" then
			self:Schedule(3, UpdateRLPreference, self, msg)
		end
	end
end
