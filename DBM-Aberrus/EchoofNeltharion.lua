local mod	= DBM:NewMod(2523, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(203133)
mod:SetEncounterID(2684)
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20230409000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 402902 407207 401480 409241 403272 406222 403057 401101 407790 407796 407936 407917 405436 405434 405433 404038 409313",
	"SPELL_CAST_SUCCESS 407917 410968",
	"SPELL_AURA_APPLIED 401998 408131 405484 407728 407919",--407182 410966
	"SPELL_AURA_APPLIED_DOSE 408131",
	"SPELL_AURA_REMOVED 405484 407088 407919",--407182 410966
	"SPELL_PERIODIC_DAMAGE 409058 404277 409183",
	"SPELL_PERIODIC_MISSED 409058 404277 409183",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 402902 or ability.id = 409313 or ability.id = 401480 or ability.id = 409241 or ability.id = 401480 or ability.id = 403272 or ability.id = 406222 or ability.id = 407790 or ability.id = 403057
 or ability.id = 401101 or ability.id = 405436 or ability.id = 405434 or ability.id = 405433 or ability.id = 405433 or ability.id = 404038 or ability.id = 403528 or ability.id = 407796
 or ability.id = 407936 or ability.id = 407917 or ability.id = 407207) and type = "begincast"
 or ability.id = 407088 and (type = "applybuff" or type = "removebuff")
 or ability.id = 405484 and type = "applydebuff"
--]]
--TODO, delete redundant/incorrect events when real events known
--TODO, Add shatter? https://www.wowhead.com/ptr/spell=401825/shatter
--TODO, revisit heroic timers since it was so bugged that normal is trusted more than heroic was, for now
--Stage One: The Earth Warder
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26192))
--local warnTwistedEarth						= mod:NewCountAnnounce(402902, 2)
--local warnVolcanicHeart							= mod:NewTargetCountAnnounce(410953, 2)
local warnRushingDarkness						= mod:NewCountAnnounce(407221, 2)
--local warnRushingDarkness						= mod:NewTargetCountAnnounce(407221, 2)

local specWarnVolcanicHeart							= mod:NewSpecialWarningIncomingCount(410953, nil, nil, nil, 1, 14)
--local specWarnVolcanicHeart						= mod:NewSpecialWarningMoveAway(410953, nil, nil, nil, 1, 2)
--local yellVolcanicHeart							= mod:NewShortPosYell(410953)
--local yellVolcanicHeartFades					= mod:NewIconFadesYell(410953)
local specWarnTwistedEarth						= mod:NewSpecialWarningDodgeCount(402902, nil, nil, nil, 2, 2)--Twisted earth spawn+Dodge for Volcanic Blast
local specWarnEchoingFissure					= mod:NewSpecialWarningDodgeCount(402116, nil, nil, nil, 2, 2)
local specWarnRushingDarkness					= mod:NewSpecialWarningDodgeCount(407221, nil, nil, nil, 2, 2)
--local yellRushingDarkness						= mod:NewShortPosYell(407221)
--local yellRushingDarknessFades					= mod:NewIconFadesYell(407221)
local specWarnCalamitousStrike					= mod:NewSpecialWarningDefensive(406222, nil, nil, nil, 1, 2)
local specWarnCalamitousStrikeSwap				= mod:NewSpecialWarningTaunt(406222, nil, nil, nil, 1, 2)
--local specWarnPyroBlast						= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerVolcanicHeartCD						= mod:NewCDCountTimer(26.2, 410953, nil, nil, nil, 3)
local timerTwistedEarthCD						= mod:NewCDCountTimer(26.2, 402902, nil, nil, nil, 3)
local timerEchoingFissureCD						= mod:NewCDCountTimer(33.6, 402116, nil, nil, nil, 2)
local timerRushingDarknessCD					= mod:NewCDCountTimer(33.6, 407221, nil, nil, nil, 3)
local timerCalamitousStrikeCD					= mod:NewCDCountTimer(33.6, 406222, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(5, 390715)
--mod:AddSetIconOption("SetIconOnVolcanicHeart", 410953, true, 0, {1, 2, 3})
--mod:AddSetIconOption("SetIconOnRushingDarkness", 407221, true, 0, {4, 5, 6})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)

--Stage Two: Corruption Takes Hold
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26421))
local warnSurrendertoCorruption					= mod:NewSpellAnnounce(403057, 2)
----Voice From Beyond
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(26456))
local warnRupturedVeil							= mod:NewCountAnnounce(408131, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(408131))
local warnCorruption							= mod:NewTargetCountAnnounce(401010, 3)--Class Call Parent
local warnShadowShadowStrike					= mod:NewCastAnnounce(407796, 2, nil, nil, "Tank|Healer")

local specWarnRazetheEarth						= mod:NewSpecialWarningDodge(409313, nil, nil, nil, 2, 2)
local specWarnCorruption						= mod:NewSpecialWarningYou(401010, nil, nil, nil, 1, 2)
local yellCorruption							= mod:NewShortYell(401010)
local specWarnUmbralAnnihilation				= mod:NewSpecialWarningCount(404038, nil, nil, nil, 2, 2)
local specWarnSweepingShadows					= mod:NewSpecialWarningDodgeCount(403846, nil, nil, nil, 2, 2)
local specWarnSunderShadow						= mod:NewSpecialWarningDefensive(407790, nil, nil, nil, 1, 2)
local specWarnSunderShadowSwap					= mod:NewSpecialWarningTaunt(407790, nil, nil, nil, 1, 2)

local timerCorruptionCD							= mod:NewCDCountTimer(43.4, 401010, nil, nil, nil, 5)--Parent
local timerUmbralAnnihilationCD					= mod:NewCDCountTimer(29.2, 404038, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSunderShadowCD						= mod:NewCDCountTimer(28.2, 407790, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--Stage Three: Reality Fractures
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26422))
local warnSunderReality							= mod:NewCastAnnounce(407936, 2)

local specWarnEbonDestruction					= mod:NewSpecialWarningCount(407917, nil, nil, nil, 2, 2)
local specWarnEbonDestructionMove				= mod:NewSpecialWarningMoveTo(407917, nil, nil, nil, 3, 2)

local timerSunderRealityCD						= mod:NewCDCountTimer(29.1, 407936, nil, nil, nil, 5)
local timerEbonDestructionCD					= mod:NewCDCountTimer(29.2, 407917, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddInfoFrameOption(407919, true)

--General
mod.vb.tankCount = 0
--P1
mod.vb.volcanicCount = 0
mod.vb.twistedEarthCount = 0
mod.vb.fissureCount = 0
mod.vb.RushingDarknessCount = 0
--mod.vb.volcIcon = 1
--mod.vb.rushingIcon = 4
--P2
mod.vb.corruptionCount = 0
mod.vb.annihilatingCount = 0
--P3
mod.vb.sunderRealityCount = 0
mod.vb.ebonCount = 0
local realityName = DBM:GetSpellInfo(407919)
local playerReality = false


local function checkRealityOnSelf(self)
	if not playerReality then
		specWarnEbonDestructionMove:Show(realityName)
		specWarnEbonDestructionMove:Play("findshelter")
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.tankCount = 0
	self.vb.volcanicCount = 0
	self.vb.twistedEarthCount = 0
	self.vb.fissureCount = 0
	self.vb.RushingDarknessCount = 0
	self.vb.corruptionCount = 0
	self.vb.annihilatingCount = 0
	self.vb.sunderRealityCount = 0
	self.vb.ebonCount = 0
	playerReality = false
--	timerTwistedEarthCD:Start(1-delay)--Used 2 sec into pull
	timerVolcanicHeartCD:Start(16-delay, 1)
	timerRushingDarknessCD:Start(10.8-delay, 1)
	timerCalamitousStrikeCD:Start(24.3-delay, 1)
	timerEchoingFissureCD:Start(30.4-delay, 1)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(402902, 401480, 409241) and self:AntiSpam(5, 1) then--2 and 3 confirmed, 1 unknown
		self.vb.twistedEarthCount = self.vb.twistedEarthCount + 1
		specWarnTwistedEarth:Show(self.vb.twistedEarthCount)
		specWarnTwistedEarth:Play("watchstep")
		--if spellId == 401480 then--first cast
		--	timerTwistedEarthCD:Start(30, 2)
		--else
		--	if self.vb.twistedEarthCount % 2 == 0 then
		--		timerTwistedEarthCD:Start(35, self.vb.twistedEarthCount+1)
		--	else
		--		timerTwistedEarthCD:Start(26.2, self.vb.twistedEarthCount+1)
		--	end
		--end
	elseif spellId == 403272 then
		self.vb.fissureCount = self.vb.fissureCount + 1
		specWarnEchoingFissure:Show(self.vb.fissureCount)
		specWarnEchoingFissure:Play("justrun")
		timerEchoingFissureCD:Start(nil, self.vb.fissureCount+1)
	elseif spellId == 406222 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnCalamitousStrike:Show()
			specWarnCalamitousStrike:Play("defensive")
		end
		timerCalamitousStrikeCD:Start(self:GetStage(1) and 33.6 or 29.2, self.vb.tankCount+1)
	elseif spellId == 407790 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSunderShadow:Show()
			specWarnSunderShadow:Play("defensive")
		end
		timerSunderShadowCD:Start(nil, self.vb.tankCount+1)
	elseif spellId == 401101 and self:AntiSpam(5, 2) then--Basically second and later corruptions
		self.vb.corruptionCount = self.vb.corruptionCount + 1
		timerCorruptionCD:Start(nil, self.vb.corruptionCount+1)
	elseif args:IsSpellID(405436, 405434, 405433, 404038) then--10, 7.5, 5, 2.5 (405433 used on heroic AND normal, others used?)
		self.vb.annihilatingCount = self.vb.annihilatingCount + 1
		specWarnUmbralAnnihilation:Show(self.vb.annihilatingCount)
		specWarnUmbralAnnihilation:Play("aesoon")
		if self.vb.annihilatingCount >= 5 then
			timerUmbralAnnihilationCD:Start(10.9, self.vb.annihilatingCount+1)
		else
			timerUmbralAnnihilationCD:Start(29.2, self.vb.annihilatingCount+1)
		end
	elseif spellId == 407796 then
		warnShadowShadowStrike:Show()
	elseif spellId == 407936 then
		self.vb.sunderRealityCount = self.vb.sunderRealityCount + 1
		warnSunderReality:Show()
		timerSunderRealityCD:Start(nil, self.vb.sunderRealityCount+1)
	elseif spellId == 407917 then
		self.vb.ebonCount = self.vb.ebonCount + 1
		specWarnEbonDestruction:Show(self.vb.ebonCount)
		specWarnEbonDestruction:Play("findshelter")
		timerEbonDestructionCD:Start(nil, self.vb.ebonCount+1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_COMMON_L.NO_DEBUFF:format(realityName))
			DBM.InfoFrame:Show(5, "playerrealityName", 407919)
		end
	elseif spellId == 407207 then
		self.vb.RushingDarknessCount = self.vb.RushingDarknessCount + 1
		warnRushingDarkness:Show(self.vb.RushingDarknessCount)
--		self.vb.rushingIcon = 4
		timerRushingDarknessCD:Start(self:GetStage(1) and 33.6 or 28, self.vb.RushingDarknessCount+1)
	elseif spellId == 409313 then--Intermission 1.5
		specWarnRazetheEarth:Show()
		specWarnRazetheEarth:Play("watchstep")
		timerTwistedEarthCD:Stop()
		timerEchoingFissureCD:Stop()
		timerRushingDarknessCD:Stop()
		timerCalamitousStrikeCD:Stop()
		timerVolcanicHeartCD:Stop()
		timerCorruptionCD:Start(6.9, 1)--Time to p2 surrender to corruption cast
	elseif spellId == 403057 then--Surrender To Corruption
		self.vb.corruptionCount = self.vb.corruptionCount + 1--Counts as first corruption cast
		warnSurrendertoCorruption:Show()
		self:SetStage(2)
		self.vb.volcanicCount = 0
		self.vb.RushingDarknessCount = 0
		timerSunderShadowCD:Start(14.8, 1)
		timerVolcanicHeartCD:Start(20.7, 1)
		timerUmbralAnnihilationCD:Start(25.8, 1)
		timerRushingDarknessCD:Start(31.9, 1)
		timerCorruptionCD:Start(44.3, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 407917 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 410968 then
--		self.vb.volcIcon = 1
		self.vb.volcanicCount = self.vb.volcanicCount + 1
		specWarnVolcanicHeart:Show(self.vb.volcanicCount
		specWarnVolcanicHeart:Play("incomingdebuff")
		timerVolcanicHeartCD:Start(self:GetStage(1) and 33.6 or 16.3, self.vb.volcanicCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401998 and not args:IsPlayer() then
		specWarnCalamitousStrikeSwap:Show(args.destName)
		specWarnCalamitousStrikeSwap:Play("tauntboss")
	--elseif spellId == 407182 then
	--	local icon = self.vb.rushingIcon
	--	if self.Options.SetIconOnRushingDarkness then
	--		self:SetIcon(args.destName, icon)
	--	end
	--	if args:IsPlayer() then
	--		specWarnRushingDarkness:Show()
	--		specWarnRushingDarkness:Play("targetyou")
	--		yellRushingDarkness:Yell(icon, icon)
	--		yellRushingDarknessFades:Countdown(spellId, nil, icon)
	--	end
	--	warnRushingDarkness:CombinedShow(0.3, self.vb.RushingDarknessCount, args.destName)
	--	self.vb.rushingIcon = self.vb.rushingIcon + 1
	--elseif spellId == 410966 then
	--	local icon = self.vb.volcIcon
	--	if self.Options.SetIconOnVolcanicHeart then
	--		self:SetIcon(args.destName, icon)
	--	end
	--	if args:IsPlayer() then
	--		specWarnVolcanicHeart:Show()--DBM_COMMON_L.BREAK_LOS
	--		if self:IsMythic() then
	--			--Raid wide, must break LOS
	--			specWarnVolcanicHeart:Play("breaklos")
	--		else
	--			--5 yard range, just spread
	--			specWarnVolcanicHeart:Play("range5")
	--		end
	--		yellVolcanicHeart:Yell(icon, icon)
	--		yellVolcanicHeartFades:Countdown(spellId, nil, icon)
	--	end
	--	warnVolcanicHeart:CombinedShow(0.3, self.vb.volcanicCount, args.destName)
	--	self.vb.volcIcon = self.vb.volcIcon + 1
	elseif spellId == 408131 and args:IsPlayer() then
		warnRupturedVeil:Cancel()
		warnRupturedVeil:Schedule(1, args.amount or 1)
	elseif spellId == 405484 then
		warnCorruption:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCorruption:Show()
			specWarnCorruption:Play("targetyou")
			yellCorruption:Yell()
		end
	elseif spellId == 407728 and not args:IsPlayer() then
		specWarnSunderShadowSwap:Show(args.destName)
		specWarnSunderShadowSwap:Play("tauntboss")
	elseif spellId == 407919 and args:IsPlayer() then
		playerReality = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 407088 and self:GetStage(2, 1) then
		self:SetStage(3)
		self.vb.RushingDarknessCount = 0
		self.vb.tankCount = 0
		timerCorruptionCD:Stop()
		timerUmbralAnnihilationCD:Stop()
		timerSunderShadowCD:Stop()
		timerRushingDarknessCD:Stop()
		timerVolcanicHeartCD:Stop()
		timerSunderRealityCD:Start(19.9, 1)
		timerRushingDarknessCD:Start(26, 1)
		timerCalamitousStrikeCD:Start(34.5, 1)
		timerEbonDestructionCD:Start(40.5, 1)
	--elseif spellId == 407182 then
	--	if self.Options.SetIconOnRushingDarkness then
	--		self:SetIcon(args.destName, 0)
	--	end
	--	if args:IsPlayer() then
	--		yellRushingDarknessFades:Cancel()
	--	end
	--elseif spellId == 410966 then
	--	if self.Options.SetIconOnVolcanicHeart then
	--		self:SetIcon(args.destName, 0)
	--	end
	--	if args:IsPlayer() then
	--		yellVolcanicHeartFades:Cancel()
	--	end
	elseif spellId == 407919 and args:IsPlayer() then
		playerReality = false
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 409058 or spellId == 404277 or spellId == 409183) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 410977 and self:AntiSpam(5, 2) then
		self.vb.corruptionCount = self.vb.corruptionCount + 1
		timerCorruptionCD:Start(nil, self.vb.corruptionCount+1)
	end
end
