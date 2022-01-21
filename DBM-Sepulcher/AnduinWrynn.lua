local mod	= DBM:NewMod(2469, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181954)
mod:SetEncounterID(2546)
mod:SetUsedIcons(1, 2, 3, 6, 7, 8)
mod:SetHotfixNoticeRev(20220111000000)
mod:SetMinSyncRevision(20220111000000)
--mod.respawnTime = 29
mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362405 361989 365295 361815 362771 363024 365120 365872 365958 365805",
	"SPELL_CAST_SUCCESS 365235 365636 365030 367631",
	"SPELL_SUMMON 365039",
	"SPELL_AURA_APPLIED 362055 364031 361992 361993 365021 362505 365216 362862 365966 366849 363028 367632",
	"SPELL_AURA_APPLIED_DOSE 364248",
	"SPELL_AURA_REMOVED 362055 361992 361993 365021 362505 365216 365966 367632",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"UNIT_AURA_UNFILTERED",--Huge waste of cpu
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, despair is probably released on anduin's despair death, because it makes more sense as such
--TODO, actually test all blasphemy stuff. Specifically using drop down and auto assignments.
--TODO, track https://ptr.wowhead.com/spell=365293/befouled-barrier somehow?
--TODO, adjust dark zeal count?
--TODO, add 10 second timer loop for https://ptr.wowhead.com/spell=362543/remorseless-winter with right events, not even gonna drycode it now in case it's wrong
--TODO, verify grim reflection auto marking, and number of spawns (still needs doing)
--TODO, dire hopelessness need repeat yell? it's not about partners finding each other this time, just a player walking into the light
local P1Info, P15Info, P2Info, P25Info, P3Info = DBM:EJ_GetSectionInfo(24462), DBM:EJ_GetSectionInfo(24494), DBM:EJ_GetSectionInfo(24478), DBM:EJ_GetSectionInfo(24172), DBM:EJ_GetSectionInfo(24417)
--Stage One: Kingsmourne Hungers
mod:AddOptionLine(P1Info, "announce")
local warnDespair								= mod:NewSpellAnnounce(365235, 4)
local warnBefouledBarrier						= mod:NewSpellAnnounce(365295, 3)
local warnWickedStar							= mod:NewTargetCountAnnounce(365021, 3, nil, nil, nil, nil, nil, nil, true)
local warnDominationWordPain					= mod:NewTargetNoFilterAnnounce(366849, 3, nil, "Healer")
--Intermission: Remnant of a Fallen King
mod:AddOptionLine(P15Info, "announce")
local warnArmyofDead							= mod:NewSpellAnnounce(362862, 3)
--Stage Three: A Moment of Clarity
mod:AddOptionLine(P3Info, "announce")
local warnBeaconofHope							= mod:NewCastAnnounce(365872, 1)

--Stage One: Kingsmourne Hungers
mod:AddOptionLine(P1Info, "specialannounce")
mod:AddOptionLine(P1Info, "yell")
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
--Intermission: Remnant of a Fallen King
mod:AddOptionLine(P15Info, "specialannounce")
local specWarnSoulReaper						= mod:NewSpecialWarningDefensive(362771, nil, nil, nil, 1, 2)
local specWarnSoulReaperTaunt					= mod:NewSpecialWarningTaunt(362771, nil, nil, nil, 1, 2)
----Monstrous Soul
local specWarnNecroticDetonation				= mod:NewSpecialWarningDefensive(363024, nil, nil, nil, 2, 2)--Aoe defensive, big damage followed by heal immunity
--Stage Two: Grim Reflections
mod:AddOptionLine(P2Info, "specialannounce")
local specWarnGrimReflections					= mod:NewSpecialWarningSwitch(365120, "-Healer", nil, nil, 1, 2)
local specWarnPsychicTerror						= mod:NewSpecialWarningInterruptCount(365008, "HasInterrupt", nil, nil, 1, 2)
--Intermission: March of the Damned
mod:AddOptionLine(P25Info, "specialannounce")
local specWarnMarchofDamned						= mod:NewSpecialWarningDodge(364020, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Stage Three: A Moment of Clarity
mod:AddOptionLine(P3Info, "specialannounce")
mod:AddOptionLine(P3Info, "yell")
local specWarnDireBlasphemy						= mod:NewSpecialWarningMoveAway(365958, nil, nil, nil, 3, 2)
local specWarnS3Hopelessness					= mod:NewSpecialWarningYou(365966, nil, nil, nil, 1, 2)
local yellHopelessness							= mod:NewYell(365966)
local yellHopelessnessRepeat					= mod:NewIconRepeatYell(365966, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnEmpoweredHopebreaker				= mod:NewSpecialWarningCount(365805, nil, nil, nil, 2, 2)

--Stage One: Kingsmourne Hungers
mod:AddTimerLine(P1Info)
local timerKingsmourneHungersCD					= mod:NewCDCountTimer(28.8, 362405, nil, nil, nil, 3)
local timerLostSoul								= mod:NewBuffFadesTimer(35, 362055, nil, nil, nil, 5)
--local timerDespairCD							= mod:NewAITimer(35, 362055, nil, nil, nil, 2)
local timerBlasphemyCD							= mod:NewCDCountTimer(28.8, 361989, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBefouledBarrierCD					= mod:NewCDCountTimer(28.8, 365295, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerWickedStarCD							= mod:NewCDCountTimer(28.8, 365030, nil, nil, nil, 3)
local timerWickedStar							= mod:NewTargetCountTimer(4, 365021, nil, nil, nil, 5)
local timerHopebreakerCD						= mod:NewCDCountTimer(28.8, 361815, nil, nil, nil, 2)
local timerDominationWordPainCD					= mod:NewCDCountTimer(28.8, 366849, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
--Intermission: Remnant of a Fallen King
mod:AddTimerLine(P15Info)
local timerSoulReaperCD							= mod:NewCDTimer(12, 362771, nil, "Healer|Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArmyofDeadCD							= mod:NewCDTimer(37.0, 362862, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--Stage Two: Grim Reflections
mod:AddTimerLine(P2Info)
local timerGrimReflectionsCD					= mod:NewCDCountTimer(28.8, 365120, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--Intermission: March of the Damned
mod:AddTimerLine(P25Info)
local timerMarchofDamnedCD						= mod:NewAITimer(28.8, 364020, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Three: A Moment of Clarity
local timerHopelessnessCD						= mod:NewAITimer(28.8, 365966, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 363020)
mod:AddInfoFrameOption(365966, true)
mod:AddIconLine(P1Info)
mod:AddSetIconOption("SetIconOnWickedStar", 365021, true, false, {1, 2, 3, 4, 5, 6})
mod:AddIconLine(P15Info)
mod:AddSetIconOption("SetIconOnMonstrousSoul", 363028, true, true, {8})
mod:AddIconLine(P2Info)
mod:AddSetIconOption("SetIconOnGrimReflection", 365120, true, true, {4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("PairingBehavior", {"Auto", "Generic", "None"}, "Generic", "misc")--Controls the yellBlasphemy/specWarnOverconfidence/specWarnHopelessness

mod.vb.hungersCount = 0
mod.vb.blastphemyCount = 0
mod.vb.befouledCount = 0
mod.vb.hopebreakerCount = 0
mod.vb.wickedCount = 0
mod.vb.domCount = 0
mod.vb.wickedIcon = 1
mod.vb.addIcon = 8
mod.vb.PairingBehavior = "Generic"
local playersSouled = {}
local playerName = UnitName("player")
local overconfidentTargets = {}
local hopelessnessTargets = {}
local totalDebuffs = 0
local hopelessnessName, overconfidenceName = DBM:GetSpellInfo(361993), DBM:GetSpellInfo(361992)
local castsPerGUID = {}
local difficultyName = "None"
local allTimers = {
	["lfr"] = {
		[1] = {
			--Befouled Barrier
			[365295] = {},
			--Blasphemy
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[2] = {
			--Befouled Barrier
			[365295] = {},
			--Grim Reflections (Replaces Blasphemy in Stage 2)
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[3] = {
			--Dire Blasphemy
			[365958] = {},
			--Empowered Hopebreaker
			[365805] = {},
			--Wicked Star
			[365030] = {},
		},
	},
	["normal"] = {
		[1] = {
			--Befouled Barrier
			[365295] = {},
			--Blasphemy
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[2] = {
			--Befouled Barrier
			[365295] = {},
			--Grim Reflections (Replaces Blasphemy in Stage 2)
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[3] = {
			--Dire Blasphemy
			[365958] = {},
			--Empowered Hopebreaker
			[365805] = {},
			--Wicked Star
			[365030] = {},
		},
	},
	["heroic"] = {
		[1] = {
			--Befouled Barrier
			[365295] = {17.0, 53.0, 40.0, 65.0, 65.0},
			--Blasphemy
			[361989] = {30.0, 50.0, 55.0, 65.0},
			--Hopebreaker
			[361815] = {5.0, 32.0, 28.0, 30.0, 30.0, 29.9, 35.1, 30.0},
			--Kingsmourne Hungers
			[362405] = {45.0, 60.0, 65.0, 65.0},
			--Wicked Star
			[365030] = {10.0, 45.0, 30.0, 35.0, 65.0},
			--Domination Word: Pain
			[366849] = {7.0, 13.0, 13.0, 12.0, 13.0, 14.0, 11.8, 12.9, 15.1, 10.9, 14.7, 11.2, 13.0, 15.0, 10.9, 14.8, 11.3, 13.5},
		},
		[2] = {
			--Befouled Barrier
			[365295] = {58.6, 55.0},
			--Grim Reflections (Replaces Blasphemy in Stage 2)
			[361989] = {8.6, 80.0},
			--Hopebreaker
			[361815] = {13.6, 25.0, 33.0, 27.0, 30.0, 30.0},
			--Kingsmourne Hungers
			[362405] = {48.6, 60.0},
			--Wicked Star
			[365030] = {18.6, 55.0, 50.1, 14.9},
			--Domination Word: Pain
			[366849] = {10.6, 13.0, 13.0, 15.9, 10.1, 13.0, 13.0, 12.9, 14.0, 12.0, 13.0, 13.0, 13.0},
		},
		[3] = {
			--Dire Blasphemy
			[365958] = {},
			--Empowered Hopebreaker
			[365805] = {},
			--Wicked Star
			[365030] = {},
		},
	},
	["mythic"] = {
		[1] = {
			--Befouled Barrier
			[365295] = {},
			--Blasphemy
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[2] = {
			--Befouled Barrier
			[365295] = {},
			--Grim Reflections (Replaces Blasphemy in Stage 2)
			[361989] = {},
			--Hopebreaker
			[361815] = {},
			--Kingsmourne Hungers
			[362405] = {},
			--Wicked Star
			[365030] = {},
			--Domination Word: Pain
			[366849] = {},
		},
		[3] = {
			--Dire Blasphemy
			[365958] = {},
			--Empowered Hopebreaker
			[365805] = {},
			--Dire Wicked Star
			[365030] = {},
		},
	},
}

local function updateTimerFades(self)
	if playersSouled[playerName] then
--		timerDespairCD:SetFade(false)
		timerBlasphemyCD:SetFade(true)
		timerBefouledBarrierCD:SetFade(true)
		timerWickedStarCD:SetFade(true)
		timerHopebreakerCD:SetFade(true)
		timerGrimReflectionsCD:SetFade(true)
	else
--		timerDespairCD:SetFade(true)
		timerBlasphemyCD:SetFade(false)
		timerBefouledBarrierCD:SetFade(false)
		timerWickedStarCD:SetFade(false)
		timerHopebreakerCD:SetFade(false)
		timerGrimReflectionsCD:SetFade(false)
	end
end

local function BlasphemyYellRepeater(self, text)
	yellBlasphemy:Yell(text)
	self:Schedule(1, BlasphemyYellRepeater, self, text)
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
	timerHopebreakerCD:Start(5-delay, 1)
	timerDominationWordPainCD:Start(7-delay, 1)
	timerWickedStarCD:Start(10-delay, 1)
	timerBefouledBarrierCD:Start(17-delay, 1)
	timerBlasphemyCD:Start(30-delay, 1)
	timerKingsmourneHungersCD:Start(45-delay, 1)
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"--Temp setting all diff to heroic until confirmed timers differ
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.PairingBehavior == "Auto" then
			self:SendSync("Auto")
		elseif self.Options.PairingBehavior == "Generic" then
			self:SendSync("Generic")
		elseif self.Options.PairingBehavior == "None" then
			self:SendSync("None")
		end
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
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
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:OnTimerRecovery()
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
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
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.hungersCount+1]
		if timer then
			timerKingsmourneHungersCD:Start(timer, self.vb.hungersCount+1)
		end
	elseif spellId == 361989 then
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1
		if not playersSouled[playerName] then
			specWarnBlasphemy:Show()
			specWarnBlasphemy:Play("scatter")
		end
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.blastphemyCount+1]
		if timer then
			timerBlasphemyCD:Start(timer, self.vb.blastphemyCount+1)
		end
		table.wipe(overconfidentTargets)
		table.wipe(hopelessnessTargets)
		totalDebuffs = 0
		--Schedule the no debuff yell here
		--It'll be unscheduled if you get one of them and replaced with a new one
		if self.vb.PairingBehavior ~= "None" then
			self:Schedule(3, BlasphemyYellRepeater, self, 0)
		end
	elseif spellId == 365958 then
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1
		specWarnDireBlasphemy:Show()
		specWarnDireBlasphemy:Play("scatter")
		--local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.blastphemyCount+1]
		--if timer then
		--	timerHopelessnessCD:Start(timer, self.vb.blastphemyCount+1)
		--end
		timerHopelessnessCD:Start()--Temp
	elseif spellId == 365295 then
		self.vb.befouledCount = self.vb.befouledCount + 1
		warnBefouledBarrier:Show(self.vb.befouledCount)
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.befouledCount+1]
		if timer then
			timerBefouledBarrierCD:Start(timer, self.vb.befouledCount+1)
		end
	elseif spellId == 361815 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		if not playersSouled[playerName] then
			specWarnHopebreaker:Show(self.vb.hopebreakerCount)
			specWarnHopebreaker:Play("aesoon")
		end
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.hopebreakerCount+1]
		if timer then
			timerHopebreakerCD:Start(timer, self.vb.hopebreakerCount+1)
		end
	elseif spellId == 365805 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		specWarnEmpoweredHopebreaker:Show(self.vb.hopebreakerCount)
		specWarnEmpoweredHopebreaker:Play("aesoon")
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.hopebreakerCount+1]
		if timer then
			timerHopebreakerCD:Start(timer, self.vb.hopebreakerCount+1)
		end
	elseif spellId == 362771 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss2 if confirmed remnant is always boss2, to save cpu
			specWarnSoulReaper:Show()
			specWarnSoulReaper:Play("defensive")
		end
		timerSoulReaperCD:Start()
	elseif spellId == 363024 then
		specWarnNecroticDetonation:Show()
		specWarnNecroticDetonation:Play("defensive")
	elseif spellId == 365120 then
		self.vb.addIcon = 8
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1--This ability replaces blasphomy in stage 2, so might as well use it's variable
		specWarnGrimReflections:Show()
		specWarnGrimReflections:Play("killmob")
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.blastphemyCount+1]
		if timer then
			timerGrimReflectionsCD:Start(timer, self.vb.blastphemyCount+1)
		end
	elseif spellId == 365008 then
		if not castsPerGUID[args.sourceGUID] then--This should have been set in summon event
			--But if that failed, do it again here and scan for mobs again here too
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnGrimReflection then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGrimReflection")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnPsychicTerror:Show(args.sourceName, count)
			if count == 1 then
				specWarnPsychicTerror:Play("kick1r")
			elseif count == 2 then
				specWarnPsychicTerror:Play("kick2r")
			elseif count == 3 then
				specWarnPsychicTerror:Play("kick3r")
			elseif count == 4 then
				specWarnPsychicTerror:Play("kick4r")
			elseif count == 5 then
				specWarnPsychicTerror:Play("kick5r")
			else
				specWarnPsychicTerror:Play("kickcast")
			end
		end
	elseif spellId == 365872 then
		warnBeaconofHope:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365235 or spellId == 365636 then
		if playersSouled[playerName] then
			warnDespair:Show()
		end
--		timerDespairCD:Start()
	elseif spellId == 365030 or spellId == 367631 then
		self.vb.wickedCount = self.vb.wickedCount + 1
		self.vb.wickedIcon = 1
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][365030][self.vb.wickedCount+1]
		if timer then
			timerWickedStarCD:Start(timer, self.vb.wickedCount+1)
		end
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
--		if self.vb.phase == 1 then--Despair add
--			timerDespairCD:Start(1)
--		end
	elseif spellId == 364031 and playersSouled[playerName] and self:CheckDispelFilter() then
		specWarnMalignantward:Show(args.destName)
		specWarnMalignantward:Play("helpdispel")
	elseif spellId == 361992 or spellId == 361993 then--361992 Overconfidence, 361993 Hopelessness
		totalDebuffs = totalDebuffs + 1
		local icon
		local count
		--Determin this debuff and assign icon based on dropdown setting and which debuff it is and construct tables
		if spellId == 361992 then--Overconfidence
			overconfidentTargets[#overconfidentTargets + 1] = args.destName
			icon = (self.vb.PairingBehavior == "Auto") and #overconfidentTargets or 1--Star
			count = #overconfidentTargets
		else--Hopelessness
			hopelessnessTargets[#hopelessnessTargets + 1] = args.destName
			icon = (self.vb.PairingBehavior == "Auto") and #hopelessnessTargets or 3--Diamond
			count = #hopelessnessTargets
		end
		--Determine if player is in either debuff table by matching current table with other table.
		--If no other table can be found yet, it'll actually not do anything until it has a pair
		local playerIsInPair = false
		if hopelessnessTargets[count] and overconfidentTargets[count] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnOverconfidence:Show(hopelessnessTargets[count])--Paired players name
			else
				specWarnOverconfidence:Show(hopelessnessName)--Just the name of debuff they need to pair with
			end
			specWarnOverconfidence:Play("gather")
			playerIsInPair = true
		elseif overconfidentTargets[count] and hopelessnessTargets[count] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnHopelessness:Show(overconfidentTargets[count])--Paired players name
			else
				specWarnHopelessness:Show(overconfidenceName)--Just the name of debuff they need to pair with
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
			self:Schedule(1, BlasphemyYellRepeater, self, icon)--Shorter repeater since 6 seconds won't trigger throttle.
			yellBlasphemy:Yell(icon)
		end
		--No debuff, assign the no debuff yell repeater (this code will be used instead of starting it in cast start, when we know affected # targets
		--if self.vb.PairingBehavior ~= "None" and totalDebuffs == DBM:GetGroupSize() and not DBM:UnitDebuff("player", 361992, 361993) then
		--	self:Schedule(1, BlasphemyYellRepeater, self, 0)
		--	yellBlasphemy:Yell(0)
		--end
	elseif spellId == 365966 then
		if args:IsPlayer() then
			specWarnS3Hopelessness:Show()
			specWarnS3Hopelessness:Play("targetyou")
			yellHopelessness:Yell()
			self:Unschedule(DireYellRepeater)
			self:Schedule(1.5, DireYellRepeater, self, 3)--Lasts longer, so slightly slower repeater to avoid throttling
		end
	elseif spellId == 365021 or spellId == 367632 then
		local icon = self.vb.wickedIcon
		if self.Options.SetIconOnWickedStar then
			self:SetIcon(args.destName, icon)
		end
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
		self.vb.wickedIcon = self.vb.wickedIcon + 1
	elseif spellId == 364248 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnDarkZeal:Show(amount)
				specWarnDarkZeal:Play("changemt")
			else
				specWarnDarkZealOther:Show(args.destName)
				specWarnDarkZealOther:Play("tauntboss")
			end
		end
	elseif (spellId == 362505 or spellId == 365216) and self:AntiSpam(10, 3) then--Both probably valid for same thing
		timerKingsmourneHungersCD:Stop()
		timerBlasphemyCD:Stop()
		timerBefouledBarrierCD:Stop()
		timerWickedStarCD:Stop()
		timerHopebreakerCD:Stop()
		timerDominationWordPainCD:Stop()
		if self.vb.phase == 1 then
			self:SetStage(1.5)
			timerArmyofDeadCD:Start(11.1)
			timerSoulReaperCD:Start(18.2)
			if self:IsMythic() then
				timerMarchofDamnedCD:Start(2)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			self:SetStage(2.5)
			timerArmyofDeadCD:Start(11.1)--NOT CONFIRMED, copied from 1.5
			timerSoulReaperCD:Start(18.2)--NOT CONFIRMED, copied from 1.5
			timerMarchofDamnedCD:Start(3)--Only used in second intermission
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 362774 and not args:IsPlayer() then
		specWarnSoulReaperTaunt:Show(args.destName)
		specWarnSoulReaperTaunt:Play("tauntboss")
	elseif spellId == 362862 then
		warnArmyofDead:Show()
		timerArmyofDeadCD:Start()
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
		totalDebuffs = totalDebuffs - 1
		if args:IsPlayer() then
			self:Unschedule(BlasphemyYellRepeater)
			if self.vb.PairingBehavior ~= "None" and totalDebuffs > 0 then--Schedule the no debuff yell repeater
				self:Schedule(1, BlasphemyYellRepeater, self, 0)
				yellBlasphemy:Yell(0)
			end
		end
		--Full stop, all debuffs gone
		if totalDebuffs == 0 then
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
		if self.Options.SetIconOnWickedStar then
			self:SetIcon(args.destName, 0)
		end
	elseif (spellId == 362505 or spellId == 365216) and self:AntiSpam(10, 3) then--Both probably valid for same thing
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
			timerGrimReflectionsCD:Start(8.6, 1)--Only new ability in stage 2, basically replaces Blasphemy
			timerDominationWordPainCD:Start(10.6, 1)
			timerHopebreakerCD:Start(13.6, 1)
			timerWickedStarCD:Start(18.6, 1)
			timerKingsmourneHungersCD:Start(48.6, 1)
			timerBefouledBarrierCD:Start(58.6, 1)
		else--end of 2.5
			self:SetStage(3)
			timerArmyofDeadCD:Stop()
			timerSoulReaperCD:Stop()
			timerMarchofDamnedCD:Stop()
--			timerKingsmourneHungersCD:Start(3, 1)
			timerHopelessnessCD:Start(3)--, 1 Dire Blasphemy replaced by hopelessness
--			timerBefouledBarrierCD:Start(3, 1)
--			timerWickedStarCD:Start(3, 1)
--			timerHopebreakerCD:Start(3, 1)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(365966))
				DBM.InfoFrame:Show(20, "playerdebuffremaining", 365966)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183033 then--Grim Reflection
		castsPerGUID[args.destGUID] = nil
--	elseif cid == 184585 then--Befouled Barrier

--	elseif cid == 184830 then--Beacon of Hope

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 5) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
--If this debuff was in combat log wouldn't have to waste cpu doing it this way.
function mod:UNIT_AURA_UNFILTERED(uId)
	local unitInSword = DBM:UnitDebuff(uId, 362055)
	local name = DBM:GetUnitFullName(uId)
	if not unitInSword and playersSouled[name] then--Not In Sword
		playersSouled[name] = false
		if name == playerName then
			updateTimerFades(self)
		end
	elseif unitInSword and not playersSouled[name] then--In Sword
		playersSouled[name] = true
		if #playersSouled == 1 then
			timerLostSoul:Start()
		end
		if name == playerName then
			updateTimerFades(self)
		end
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 363116 or spellId == 363133 or spellId == 363233) and self:AntiSpam(10, 4) then
		specWarnMarchofDamned:Show()
		specWarnMarchofDamned:Play("watchstep")--Farfromline if it's one of those things
	elseif spellId == 366849 then
		self.vb.domCount = self.vb.domCount + 1
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.domCount+1]
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
