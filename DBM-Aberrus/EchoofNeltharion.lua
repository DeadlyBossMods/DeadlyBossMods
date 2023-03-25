local mod	= DBM:NewMod(2523, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(203133)
mod:SetEncounterID(2684)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230324000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 402902 407207 401480 409241 403272 406222 403057 401101 402814 403528 407790 407796 407936 407917 405436 405434 405433 404038",
	"SPELL_CAST_SUCCESS 401125 401360 407917",
	"SPELL_AURA_APPLIED 407182 401998 408131 405484 407728 407919",--401123 401126 404565 401128 401130 401133 401134 401135
	"SPELL_AURA_APPLIED_DOSE 408131",
	"SPELL_AURA_REMOVED 407182 405484 407088 407919",
	"SPELL_PERIODIC_DAMAGE 409058 404277 409183",
	"SPELL_PERIODIC_MISSED 409058 404277 409183"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 402902 or ability.id = 401480 or ability.id = 409241 or ability.id = 401480 or ability.id = 403272 or ability.id = 406222 or ability.id = 407790 or ability.id = 403057
 or ability.id = 401101 or ability.id = 405436 or ability.id = 405434 or ability.id = 405433 or ability.id = 405433 or ability.id = 404038 or ability.id = 403528 or ability.id = 407796
 or ability.id = 407936 or ability.id = 407917 or ability.id = 407207) and type = "begincast"
 or ability.id = 407088 and (type = "applybuff" or type = "removebuff")
 or ability.id = 405484 and type = "applydebuff"
--]]
--TODO, delete redundant/incorrect events when real events known
--TODO, phase 3 was unreachable due to fight being bugged in first test, so P3 needs updating
--TODO, Add shatter? https://www.wowhead.com/ptr/spell=401825/shatter
--TODO, shadowstep targets?
--TODO, fix class call timers?
--TODO, Target scan sweeping shadows?
--Stage One: The Earth Warder
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26192))
--local warnTwistedEarth						= mod:NewCountAnnounce(402902, 2)
local warnRushingShadows						= mod:NewTargetCountAnnounce(407221, 2)

local specWarnTwistedEarth						= mod:NewSpecialWarningDodgeCount(402902, nil, nil, nil, 2, 2)--Twisted earth spawn+Dodge for Volcanic Blast
local specWarnEchoingFissure					= mod:NewSpecialWarningDodgeCount(402116, nil, nil, nil, 2, 2)
local specWarnRushingShadows					= mod:NewSpecialWarningDodgeCount(402116, nil, nil, nil, 2, 2)
local yellRushingShadows						= mod:NewShortPosYell(402116)
local yellRushingShadowsFades					= mod:NewIconFadesYell(402116)
local specWarnCalamitousStrike					= mod:NewSpecialWarningDefensive(406222, nil, nil, nil, 1, 2)
local specWarnCalamitousStrikeSwap				= mod:NewSpecialWarningTaunt(406222, nil, nil, nil, 1, 2)
--local specWarnPyroBlast						= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerTwistedEarthCD						= mod:NewCDCountTimer(26.2, 402902, nil, nil, nil, 3)
local timerEchoingFissureCD						= mod:NewCDCountTimer(29.2, 402116, nil, nil, nil, 2)
local timerRushingShadowsCD						= mod:NewCDCountTimer(29.3, 407221, nil, nil, nil, 3)
local timerCalamitousStrikeCD					= mod:NewCDCountTimer(19.6, 406222, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnRushingShadows", 407221, true, 0, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)

--Stage Two: Corruption Takes Hold
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26421))
local warnSurrendertoCorruption					= mod:NewSpellAnnounce(403057, 2)
----Voice From Beyond
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(26456))
local warnRupturedVeil							= mod:NewCountAnnounce(408131, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(408131))
----Class Calls
local warnCorruption							= mod:NewTargetCountAnnounce(401010, 3)--Class Call Parent
local warnDesperateScream						= mod:NewTargetNoFilterAnnounce(404565, 3, nil, "RemoveMagic")--Priest secondary (not parent)
local warnCorruptedbeasts						= mod:NewSpellAnnounce(401125, 3, nil, false)--Hunter secondary and primary
local warnShadowStep							= mod:NewSpellAnnounce(401360, 3)--Effect of Wild Treachery (Rogue)
local warnShadowElementalTotem					= mod:NewCastAnnounce(402814, 2, nil, nil, false)
local warnShadowShadowStrike					= mod:NewCastAnnounce(407796, 2, nil, nil, "Tank|Healer")

local specWarnCorruption						= mod:NewSpecialWarningYou(401010, nil, nil, nil, 1, 2)
local yellCorruption							= mod:NewShortYell(401010)
local specWarnAnnihilatingShadows				= mod:NewSpecialWarningCount(404038, nil, nil, nil, 2, 2)
local specWarnSweepingShadows					= mod:NewSpecialWarningDodgeCount(403846, nil, nil, nil, 2, 2)
local specWarnSunderShadow						= mod:NewSpecialWarningDefensive(407790, nil, nil, nil, 1, 2)
local specWarnSunderShadowSwap					= mod:NewSpecialWarningTaunt(407790, nil, nil, nil, 1, 2)

local timerCorruptionCD							= mod:NewCDCountTimer(29.4, 401010, nil, nil, nil, 5)--Parent
--local timerBladestormCD						= mod:NewCDCountTimer("d6", 401123, nil, nil, nil, 5)--Warrior
--local timerShadowStepCD						= mod:NewCDCountTimer("d10", 401360, nil, nil, nil, 5)--Rogue
--local timerWildGripCD							= mod:NewCDCountTimer("d10", 401128, nil, nil, nil, 5)--DK
--local timerWildMagicCD						= mod:NewCDCountTimer("d10", 401130, nil, nil, nil, 5)--Mage
--local timerWildShiftCD						= mod:NewCDCountTimer("d10", 401133, nil, nil, nil, 5)--Druid
--local timerChaosDanceCD						= mod:NewCDCountTimer("d6", 401134, nil, nil, nil, 5)--DH
--local timerWildBreathCD						= mod:NewCDCountTimer("d6", 401135, nil, nil, nil, 5)--Evoker
local timerAnnihilatingShadowsCD				= mod:NewCDCountTimer(29.4, 404038, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSweepingShadowsCD					= mod:NewCDCountTimer(29.4, 403846, nil, nil, nil, 3)
local timerSunderShadowCD						= mod:NewCDCountTimer(29.4, 407790, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:GroupSpells(401010, 401123, 401125, 401360, 404565, 401128, 402814, 401133, 401134, 401135, 401130)--Corruption with all sub class Ids
--Stage Three: Reality Fractures
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26422))
local warnShatterReality						= mod:NewCastAnnounce(407936, 2)

local specWarnEbonDestruction					= mod:NewSpecialWarningCount(407917, nil, nil, nil, 2, 2)
local specWarnEbonDestructionMove				= mod:NewSpecialWarningMoveTo(407917, nil, nil, nil, 3, 2)

local timerShatterRealityCD						= mod:NewAITimer(28.9, 407936, nil, nil, nil, 5)
local timerEbonDestructionCD					= mod:NewAITimer(28.9, 407917, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddInfoFrameOption(407919, true)

--General
mod.vb.tankCount = 0
--P1
mod.vb.twistedEarthCount = 0
mod.vb.fissureCount = 0
mod.vb.rushingShadowsCount = 0
mod.vb.shadowsIcon = 1
--P2
mod.vb.corruptionCount = 0
mod.vb.annihilatingCount = 0
mod.vb.sweepingCount = 0
--P3
local realityName = DBM:GetSpellInfo(407919)
local playerReality = false
mod.vb.ebonCount = 0

local function checkRealityOnSelf(self)
	if not playerReality then
		specWarnEbonDestructionMove:Show(realityName)
		specWarnEbonDestructionMove:Play("findshelter")
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.tankCount = 0
	self.vb.twistedEarthCount = 0
	self.vb.fissureCount = 0
	self.vb.rushingShadowsCount = 0
	self.vb.corruptionCount = 0
	self.vb.annihilatingCount = 0
	self.vb.sweepingCount = 0
	self.vb.ebonCount = 0
	playerReality = false
--	timerTwistedEarthCD:Start(1-delay)--Used 2 sec into pull
	timerRushingShadowsCD:Start(10.8-delay, 1)
	timerCalamitousStrikeCD:Start(22.1-delay, 1)
	timerEchoingFissureCD:Start(24.6-delay, 1)
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
		if spellId == 401480 then--first cast
			timerTwistedEarthCD:Start(30, 2)
		else
			if self.vb.twistedEarthCount % 2 == 0 then
				timerTwistedEarthCD:Start(35, self.vb.twistedEarthCount+1)
			else
				timerTwistedEarthCD:Start(26.2, self.vb.twistedEarthCount+1)
			end
		end
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
		timerCalamitousStrikeCD:Start(nil, self.vb.tankCount+1)
	elseif spellId == 407790 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSunderShadow:Show()
			specWarnSunderShadow:Play("defensive")
		end
		timerSunderShadowCD:Start(nil, self.vb.tankCount+1)
	elseif spellId == 403057 then--Surrender To Corruption
		warnSurrendertoCorruption:Show()
		self:SetStage(2)
		timerTwistedEarthCD:Stop()
		timerEchoingFissureCD:Stop()
		timerRushingShadowsCD:Stop()
		timerCalamitousStrikeCD:Stop()
		timerSweepingShadowsCD:Start(17.6, 1)
		timerAnnihilatingShadowsCD:Start(26.2, 1)
		timerSunderShadowCD:Start(34.8, 1)
		timerCorruptionCD:Start(40, 2)
	elseif spellId == 401101 then--Basically second and later corruptions
		self.vb.corruptionCount = self.vb.corruptionCount + 1
		timerCorruptionCD:Start(nil, self.vb.corruptionCount+1)
	elseif spellId == 402814 and self:AntiSpam(5, 3) then
		warnShadowElementalTotem:Show()
	elseif args:IsSpellID(405436, 405434, 405433, 404038) then--10, 7.5, 5, 2.5
		self.vb.annihilatingCount = self.vb.annihilatingCount + 1
		specWarnAnnihilatingShadows:Show(self.vb.annihilatingCount)
		specWarnAnnihilatingShadows:Play("aesoon")
		if self.vb.annihilatingCount >= 5 then
			timerAnnihilatingShadowsCD:Start(10.9, self.vb.annihilatingCount+1)
		else
			timerAnnihilatingShadowsCD:Start(29.4, self.vb.annihilatingCount+1)
		end
	elseif spellId == 403528 then
		self.vb.sweepingCount = self.vb.sweepingCount + 1
		specWarnSweepingShadows:Show(self.vb.sweepingCount)
		specWarnSweepingShadows:Play("shockwave")
		timerSweepingShadowsCD:Start(nil, self.vb.sweepingCount+1)
	elseif spellId == 407796 then
		warnShadowShadowStrike:Show()
	elseif spellId == 407936 then
		warnShatterReality:Show()
		timerShatterRealityCD:Start()
		if self.vb.phase == 2 then
			self:SetStage(3)
			self.vb.tankCount = 0
			timerCorruptionCD:Stop()
			timerAnnihilatingShadowsCD:Stop()
			timerSweepingShadowsCD:Stop()
			timerSunderShadowCD:Stop()
--			timerCalamitousStrikeCD:Start(3, 1)
--			timerRushingShadowsCD:Start(3)
			timerEbonDestructionCD:Start(3)
		end
	elseif spellId == 407917 then
		self.vb.ebonCount = self.vb.ebonCount + 1
		specWarnEbonDestruction:Show(self.vb.ebonCount)
		specWarnEbonDestruction:Play("findshelter")
		timerEbonDestructionCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_COMMON_L.NO_DEBUFF:format(realityName))
			DBM.InfoFrame:Show(5, "playerrealityName", 407919)
		end
	elseif spellId == 407207 then
		self.vb.rushingShadowsCount = self.vb.rushingShadowsCount + 1
		self.vb.shadowsIcon = 1
		if self.vb.rushingShadowsCount % 2 == 0 then
			timerRushingShadowsCD:Start(29.3, self.vb.rushingShadowsCount+1)
		else
			timerRushingShadowsCD:Start(32.5, self.vb.rushingShadowsCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 401125 and self:AntiSpam(5, 3) then
		warnCorruptedbeasts:Show()
	elseif spellId == 401360 and self:AntiSpam(5, 3) then
		warnShadowStep:Show()
	elseif spellId == 407917 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 407182 then
		local icon = self.vb.shadowsIcon
		if self.Options.SetIconOnRushingShadows then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRushingShadows:Show()
			specWarnRushingShadows:Play("targetyou")
			yellRushingShadows:Yell(icon, icon)
			yellRushingShadowsFades:Countdown(spellId, nil, icon)
		end
		warnRushingShadows:CombinedShow(0.3, self.vb.rushingShadowsCount, args.destName)
		self.vb.shadowsIcon = self.vb.shadowsIcon + 1
	elseif spellId == 401998 and not args:IsPlayer() then
		specWarnCalamitousStrikeSwap:Show(args.destName)
		specWarnCalamitousStrikeSwap:Play("tauntboss")
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
--	elseif spellId == 401123 and args:IsPlayer() then
		--timerBladestormCD:Start(6, 1)--TODO verify first one happens after 6 seconds and not immediately
		--timerBladestormCD:Start(12, 2)
		--timerBladestormCD:Start(18, 3)
		--timerBladestormCD:Start(24, 4)
		--timerBladestormCD:Start(30, 5)
--	elseif spellId == 401126 and self:AntiSpam(5, 3) then
		--timerShadowStepCD:Start(10, 1)--TODO verify first one happens after 10 seconds and not immediately
		--timerShadowStepCD:Start(20, 2)
		--timerShadowStepCD:Start(30, 3)
--	elseif spellId == 401128 and self:AntiSpam(5, 3) then
		--timerWildGripCD:Start(10, 1)--TODO verify first one happens after 10 seconds and not immediately
		--timerWildGripCD:Start(20, 2)
		--timerWildGripCD:Start(30, 3)
--	elseif spellId == 401130 and args:IsPlayer() then
		--timerWildMagicCD:Start(10, 1)--TODO verify first one happens after 10 seconds and not immediately
		--timerWildMagicCD:Start(20, 2)
		--timerWildMagicCD:Start(30, 3)
--	elseif spellId == 401133 and args:IsPlayer() then
		--timerWildShiftCD:Start(10, 1)--TODO verify first one happens after 10 seconds and not immediately
		--timerWildShiftCD:Start(20, 2)
		--timerWildShiftCD:Start(30, 3)
--	elseif spellId == 401134 and args:IsPlayer() then
		--timerChaosDanceCD:Start(6, 1)--TODO verify first one happens after 6 seconds and not immediately
		--timerChaosDanceCD:Start(12, 2)
		--timerChaosDanceCD:Start(18, 3)
		--timerChaosDanceCD:Start(24, 4)
		--timerChaosDanceCD:Start(30, 5)
--	elseif spellId == 401135 and args:IsPlayer() then
		--timerWildBreathCD:Start(6, 1)--TODO verify first one happens after 6 seconds and not immediately
		--timerWildBreathCD:Start(12, 2)
		--timerWildBreathCD:Start(18, 3)
		--timerWildBreathCD:Start(24, 4)
		--timerWildBreathCD:Start(30, 5)
	elseif spellId == 404565 and args:IsDestTypePlayer() then
		warnDesperateScream:CombinedShow(0.3, args.destName)
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
	if spellId == 407182 then
		if self.Options.SetIconOnRushingShadows then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRushingShadowsFades:Cancel()
		end
	elseif spellId == 407088 and self.vb.phase == 2 then
		self:SetStage(3)
		timerCorruptionCD:Stop()
		timerAnnihilatingShadowsCD:Stop()
		timerSweepingShadowsCD:Stop()
		timerSunderShadowCD:Stop()
--		timerCalamitousStrikeCD:Start(3)
--		timerRushingShadowsCD:Start(3)
		timerEbonDestructionCD:Start(3)
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

--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
