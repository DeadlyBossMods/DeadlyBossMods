local mod	= DBM:NewMod(2469, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181954)
mod:SetEncounterID(2546)
mod:SetUsedIcons(1, 2, 3, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29
mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362405 361989 365295 361815 362771 363024 365120 365872 365958 365805",
	"SPELL_CAST_SUCCESS 365235 365636 366849",
	"SPELL_SUMMON 365039",
	"SPELL_AURA_APPLIED 362055 364031 361992 361993 365021 362505 365216 362862 365966 366849",
	"SPELL_AURA_APPLIED_DOSE 364248",
	"SPELL_AURA_REMOVED 362055 361992 361993 365021 362505 365216 365966",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, improve timer fading and alert filtering for spells based on playersSouled status
--TODO, despair is probably released on anduin's despair death, because it makes more sense as such
--TODO, actually test all blasphemy stuff. Specifically using drop down and auto assignments.
--TODO, track https://ptr.wowhead.com/spell=365293/befouled-barrier somehow?
--TODO, adjust dark zeal count?
--TODO, detect intermissions using https://ptr.wowhead.com/spell=362505/grasp-of-domination on anduin, or https://ptr.wowhead.com/spell=365216/grasp-of-domination on arthas?
--TODO, add 10 second timer loop for https://ptr.wowhead.com/spell=362543/remorseless-winter with right events, not even gonna drycode it now in case it's wrong
--TODO, more than one necrotic detonation possible at a time? Seems unlikely, at least if doing fight smart.
--TODO, track https://ptr.wowhead.com/spell=363028/unraveling-frenzy ? seems pretty passive
--TODO, verify grim reflection auto marking, and number of spawns
--TODO, dire hopelessness need repeat yell? it's not about partners finding each other this time, just a player walking into the light
local P1Info, P15Info, P2Info, P25Info, P3Info = DBM:EJ_GetSectionInfo(24462), DBM:EJ_GetSectionInfo(24494), DBM:EJ_GetSectionInfo(24478), DBM:EJ_GetSectionInfo(24172), DBM:EJ_GetSectionInfo(24417)
--Stage One: Kingsmourne Hungers
mod:AddOptionLine(P1Info, "announce")
local warnDespair								= mod:NewSpellAnnounce(365235, 4)
local warnBefouledBarrier						= mod:NewSpellAnnounce(365295, 3)
local warnWickedStar							= mod:NewTargetCountAnnounce(348064, 3, nil, nil, nil, nil, nil, nil, true)
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
local specWarnDireHopelessness					= mod:NewSpecialWarningYou(365966, nil, nil, nil, 1, 2)
local yellDireHoppelessness						= mod:NewYell(365966)--Repeat yell?
local specWarnEmpoweredHopebreaker				= mod:NewSpecialWarningCount(365805, nil, nil, nil, 2, 2)

--Stage One: Kingsmourne Hungers
mod:AddTimerLine(P1Info)
local timerKingsmourneHungersCD					= mod:NewAITimer(28.8, 362405, nil, nil, nil, 3)
local timerLostSoul								= mod:NewBuffFadesTimer(35, 362055, nil, nil, nil, 5)
--local timerDespairCD							= mod:NewAITimer(35, 362055, nil, nil, nil, 2)
local timerBlasphemyCD							= mod:NewAITimer(28.8, 361989, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBefouledBarrierCD					= mod:NewAITimer(28.8, 365295, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerWickedStarCD							= mod:NewAITimer(28.8, 365030, nil, nil, nil, 3)
local timerWickedStar							= mod:NewTargetCountTimer(4, 365021, nil, nil, nil, 5)
local timerHopebreakerCD						= mod:NewAITimer(28.8, 361815, nil, nil, nil, 2)
local timerDominationWordPainCD					= mod:NewAITimer(28.8, 366849, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
--Intermission: Remnant of a Fallen King
mod:AddTimerLine(P15Info)
local timerSoulReaperCD							= mod:NewAITimer(28.8, 362771, nil, "Healer|Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArmyofDeadCD							= mod:NewAITimer(28.8, 362862, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--Stage Two: Grim Reflections
mod:AddTimerLine(P2Info)
local timerGrimReflectionsCD					= mod:NewAITimer(28.8, 365120, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--Intermission: March of the Damned
mod:AddTimerLine(P25Info)
local timerMarchofDamnedCD						= mod:NewAITimer(28.8, 364020, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Three: A Moment of Clarity
---In case I decide to split any of timers after all for hopebreaker and dire blasphemy

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 363020)
mod:AddInfoFrameOption(365966, true)
mod:AddIconLine(P1Info)
mod:AddSetIconOption("SetIconOnWickedStar", 365021, true, false, {1, 2, 3})
mod:AddIconLine(P2Info)
mod:AddSetIconOption("SetIconOnGrimReflection", 365120, true, true, {6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("PairingBehavior", {"Auto", "Generic", "None"}, "Generic", "misc")--Controls the yellBlasphemy/specWarnOverconfidence/specWarnHopelessness

mod.vb.hungersCount = 0
mod.vb.blastphemyCount = 0
mod.vb.befouledCount = 0
mod.vb.hopebreakerCount = 0
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
	self:Schedule(2, BlasphemyYellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.hungersCount = 0
	self.vb.blastphemyCount = 0
	self.vb.befouledCount = 0
	self.vb.hopebreakerCount = 0
	self.vb.PairingBehavior = self.Options.PairingBehavior--Default it to whatever user has it set to, until group leader overrides it
	table.wipe(playersSouled)
	updateTimerFades(self)--Reset to normal status
	timerKingsmourneHungersCD:Start(1-delay)
	timerBlasphemyCD:Start(1-delay)
	timerBefouledBarrierCD:Start(1-delay)
	timerWickedStarCD:Start(1-delay)
	timerHopebreakerCD:Start(1-delay)
	timerDominationWordPainCD:Start(1-delay)
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
		timerKingsmourneHungersCD:Start()
	elseif spellId == 361989 then
		self.vb.blastphemyCount = self.vb.blastphemyCount + 1
		if not playersSouled[playerName] then
			specWarnBlasphemy:Show()
			specWarnBlasphemy:Play("scatter")
		end
		timerBlasphemyCD:Start()
		table.wipe(overconfidentTargets)
		table.wipe(hopelessnessTargets)
		totalDebuffs = 0
		--Schedule the no debuff yell here
		--It'll be unscheduled if you get one of them and replaced with a new one
		if self.vb.PairingBehavior ~= "None" then
			self:Schedule(3, BlasphemyYellRepeater, self, 0)
		end
	elseif spellId == 365958 then
		specWarnDireBlasphemy:Show()
		specWarnDireBlasphemy:Play("scatter")
		timerBlasphemyCD:Start()
	elseif spellId == 365295 then
		self.vb.befouledCount = self.vb.befouledCount + 1
		warnBefouledBarrier:Show(self.vb.befouledCount)
		timerBefouledBarrierCD:Start()
	elseif spellId == 361815 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		if not playersSouled[playerName] then
			specWarnHopebreaker:Show(self.vb.hopebreakerCount)
			specWarnHopebreaker:Play("aesoon")
		end
		timerHopebreakerCD:Start()
	elseif spellId == 365805 then
		self.vb.hopebreakerCount = self.vb.hopebreakerCount + 1
		specWarnEmpoweredHopebreaker:Show(self.vb.hopebreakerCount)
		specWarnEmpoweredHopebreaker:Play("aesoon")
		timerHopebreakerCD:Start()
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
		specWarnGrimReflections:Show()
		specWarnGrimReflections:Play("killmob")
		timerGrimReflectionsCD:Start()
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
	elseif spellId == 366849 then
		timerDominationWordPainCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 365039 then
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
	if spellId == 362055 then
		playersSouled[args.destName] = true
		if #playersSouled == 1 then
			timerLostSoul:Start()
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
		--Determin this debuff and assign icon based on dropdown setting and which debuff it is and construct tables
		if spellId == 361992 then--Overconfidence
			overconfidentTargets[#overconfidentTargets + 1] = args.destName
			icon = (self.vb.PairingBehavior == "Auto") and #overconfidentTargets or 7
		else--Hopelessness
			hopelessnessTargets[#hopelessnessTargets + 1] = args.destName
			icon = (self.vb.PairingBehavior == "Auto") and #hopelessnessTargets or 6
		end
		--Determine if player is in either debuff table by matching current table with other table.
		--If no other table can be found yet, it'll actually not do anything until it has a pair
		local playerIsInPair = false
		if hopelessnessTargets[icon] and overconfidentTargets[icon] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnOverconfidence:Show(hopelessnessTargets[icon])--Paired players name
			else
				specWarnOverconfidence:Show(hopelessnessName)--Just the name of debuff they need to pair with
			end
			specWarnOverconfidence:Play("gather")
			playerIsInPair = true
		elseif overconfidentTargets[icon] and hopelessnessTargets[icon] == playerName then
			if self.vb.PairingBehavior == "Auto" then
				specWarnHopelessness:Show(overconfidentTargets[icon])--Paired players name
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
			self:Schedule(2, BlasphemyYellRepeater, self, icon)
			yellBlasphemy:Yell(icon)
		end
		--No debuff, assign the no debuff yell repeater (this code will be used instead of starting it in cast start, when we know affected # targets
		--if self.vb.PairingBehavior ~= "None" and totalDebuffs == DBM:GetGroupSize() and not DBM:UnitDebuff("player", 361992, 361993) then
		--	self:Schedule(2, BlasphemyYellRepeater, self, 0)
		--	yellBlasphemy:Yell(0)
		--end
	elseif spellId == 365966 then
		if args:IsPlayer() then
			specWarnDireHopelessness:Show()
			specWarnDireHopelessness:Play("targetyou")
			yellDireHoppelessness:Yell()
		end
	elseif spellId == 365021 then
		if self:AntiSpam(15, 1) then
			self.vb.wickedIcon = 1
			timerWickedStarCD:Start()
		end
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
			timerSoulReaperCD:Start(2)
			timerArmyofDeadCD:Start(2)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			self:SetStage(2.5)
			timerSoulReaperCD:Start(3)
			timerArmyofDeadCD:Start(3)
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
		timerArmyofDeadCD:Start()--I doubt it's cast more than once
	elseif spellId == 366849 then
		warnDominationWordPain:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 362055 then
		playersSouled[args.destName] = nil
		if #playersSouled == 0 then
			timerLostSoul:Stop()
		end
		if args:IsPlayer() then
			updateTimerFades(self)
		end
	elseif spellId == 361992 or spellId == 361993 then--361992 Overconfidence, 361993 Hopelessness
		totalDebuffs = totalDebuffs - 1
		if args:IsPlayer() then
			self:Unschedule(BlasphemyYellRepeater)
			if self.vb.PairingBehavior ~= "None" and totalDebuffs > 0 then--Schedule the no debuff yell repeater
				self:Schedule(2, BlasphemyYellRepeater, self, 0)
				yellBlasphemy:Yell(0)
			end
		end
		--Full stop, all debuffs gone
		if totalDebuffs == 0 then
			self:Unschedule(BlasphemyYellRepeater)
		end
	elseif (spellId == 362505 or spellId == 365216) and self:AntiSpam(10, 3) then--Both probably valid for same thing
		self.vb.hungersCount = 0
		self.vb.blastphemyCount = 0
		self.vb.befouledCount = 0
		self.vb.hopebreakerCount = 0
		if self.vb.phase == 1.5 then
			self:SetStage(2)
			timerKingsmourneHungersCD:Start(2)
			timerBlasphemyCD:Start(2)
			timerBefouledBarrierCD:Start(2)
			timerWickedStarCD:Start(2)
			timerHopebreakerCD:Start(2)
			timerDominationWordPainCD:Start(2)
			timerGrimReflectionsCD:Start(2)--Only new ability in stage 2
		else--end of 2.5
			self:SetStage(3)
			timerKingsmourneHungersCD:Start(3)
			timerBlasphemyCD:Start(3)--Dire Blasphemy just reuses Blasphemy timer
			timerBefouledBarrierCD:Start(3)
			timerWickedStarCD:Start(3)
			timerHopebreakerCD:Start(3)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 363116 or spellId == 363133 or spellId == 363233) and self:AntiSpam(10, 4) then
		specWarnMarchofDamned:Show()
		specWarnMarchofDamned:Play("watchstep")--Farfromline if it's one of those things
	end
end


function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Auto" then
		self.vb.PairingBehavior = "Auto"
	elseif msg == "Generic" then
		self.vb.PairingBehavior = "Generic"
	elseif msg == "None" then
		self.vb.PairingBehavior = "None"
	end
end
