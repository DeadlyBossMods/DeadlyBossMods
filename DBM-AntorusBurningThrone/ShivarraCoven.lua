local mod	= DBM:NewMod(1986, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122468, 122467, 122469)--122468 Noura, 122467 Asara, 122469 Diima, 125436 Thu'raya (mythic only)
mod:SetEncounterID(2073)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(16963)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245627 252861 253650 250648 250095",
	"SPELL_CAST_SUCCESS 244899 253520 245532 250335 250333 250334 249793 245518 246329",
	"SPELL_AURA_APPLIED 244899 253520 245518 245586 250757 249863",
	"SPELL_AURA_APPLIED_DOSE 244899 245518",
	"SPELL_AURA_REMOVED 253520 245586 249863 250757",
	"SPELL_PERIODIC_DAMAGE 245634 253020",
	"SPELL_PERIODIC_MISSED 245634 253020",
	"UNIT_DIED",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local Noura = DBM:EJ_GetSectionInfo(15967)
local Asara = DBM:EJ_GetSectionInfo(15968)
local Diima = DBM:EJ_GetSectionInfo(15969)
local Thuraya = DBM:EJ_GetSectionInfo(16398)
local torment = DBM:EJ_GetSectionInfo(16138)

--TODO, verify timerBossIncoming on all difficulties
--TODO, transcribe/video and tweak some timers for activation especially timerStormofDarknessCD which had some timer refreshed debug
--[[
(ability.id = 245627 or ability.id = 252861 or ability.id = 253650 or ability.id = 250095 or ability.id = 250648) and type = "begincast"
 or (ability.id = 244899 or ability.id = 245518 or ability.id = 253520 or ability.id = 245532 or ability.id = 250335 or ability.id = 250333 or ability.id = 250334 or ability.id = 249793 or ability.id = 250757 or ability.id = 246329) and type = "cast"
 or ability.id = 250757 and type = "applydebuff"
--]]
--All
local warnActivated						= mod:NewTargetAnnounce(118212, 3, 78740, nil, nil, nil, nil, nil, true)
--Noura, Mother of Flames
local warnFieryStrike					= mod:NewStackAnnounce(244899, 2, nil, "Tank")
local warnWhirlingSaber					= mod:NewSpellAnnounce(245627, 2)
local warnFulminatingPulse				= mod:NewTargetAnnounce(253520, 3)
--Asara, Mother of Night
--Diima, Mother of Gloom
local warnChilledBlood					= mod:NewTargetAnnounce(245586, 2)
local warnFlashFreeze					= mod:NewStackAnnounce(245518, 2, nil, "Tank")
--Thu'raya, Mother of the Cosmos (Mythic)
local warnCosmicGlare					= mod:NewTargetAnnounce(250757, 3)

--General
local specWarnGTFO						= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnActivated					= mod:NewSpecialWarningSwitchCount(118212, "Tank", nil, nil, 1, 2)
--Noura, Mother of Flames
local specWarnFieryStrike				= mod:NewSpecialWarningStack(244899, nil, 2, nil, nil, 1, 6)
local specWarnFieryStrikeOther			= mod:NewSpecialWarningTaunt(244899, nil, nil, nil, 1, 2)
local specWarnFulminatingPulse			= mod:NewSpecialWarningMoveAway(253520, nil, nil, nil, 1, 2)
local yellFulminatingPulse				= mod:NewFadesYell(253520)
--Asara, Mother of Night
local specWarnShadowBlades				= mod:NewSpecialWarningDodge(246329, nil, nil, nil, 2, 2)
local specWarnStormofDarkness			= mod:NewSpecialWarningCount(252861, nil, nil, nil, 2, 2)
--Diima, Mother of Gloom
local specWarnFlashfreeze				= mod:NewSpecialWarningStack(245518, nil, 2, nil, nil, 1, 6)
local specWarnFlashfreezeOther			= mod:NewSpecialWarningTaunt(245518, nil, nil, nil, 1, 2)
local yellFlashfreeze					= mod:NewYell(245518, nil, false)
local specWarnChilledBlood				= mod:NewSpecialWarningTarget(245586, "Healer", nil, nil, 1, 2)
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(253650, nil, nil, nil, 1, 2)
--Thu'raya, Mother of the Cosmos (Mythic)
local specWarnTouchoftheCosmos			= mod:NewSpecialWarningInterruptCount(250648, "HasInterrupt", nil, nil, 1, 2)
local specWarnCosmicGlare				= mod:NewSpecialWarningYou(250757, nil, nil, nil, 1, 2)
local yellCosmicGlare					= mod:NewYell(250757)
local yellCosmicGlareFades				= mod:NewShortFadesYell(250757)
--Torment of the Titans
local specWarnTormentofTitans			= mod:NewSpecialWarningSpell("ej16138", nil, nil, nil, 1, 7)

--General
local timerBossIncoming					= mod:NewTimer(61, "timerBossIncoming", nil, nil, nil, 1)
--Noura, Mother of Flames
mod:AddTimerLine(Noura)
local timerFieryStrikeCD				= mod:NewCDTimer(10.5, 244899, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWhirlingSaberCD				= mod:NewNextTimer(35.1, 245627, nil, nil, nil, 3)--35-45
local timerFulminatingPulseCD			= mod:NewNextTimer(40.1, 253520, nil, nil, nil, 3)
--Asara, Mother of Night
mod:AddTimerLine(Asara)
local timerShadowBladesCD				= mod:NewCDTimer(27.6, 246329, nil, nil, nil, 3)
local timerStormofDarknessCD			= mod:NewNextCountTimer(56.8, 252861, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--57+
--Diima, Mother of Gloom
mod:AddTimerLine(Diima)
local timerFlashFreezeCD				= mod:NewCDTimer(10.1, 245518, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChilledBloodCD				= mod:NewNextTimer(25.4, 245586, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerOrbofFrostCD					= mod:NewNextTimer(30, 253650, nil, nil, nil, 3)
--Thu'raya, Mother of the Cosmos (Mythic)
mod:AddTimerLine(Thuraya)
local timerCosmicGlareCD				= mod:NewCDTimer(15.8, 250757, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Torment of the Titans
mod:AddTimerLine(torment)
----Activations timers
local timerMachinationsofAmanThulCD		= mod:NewCastTimer(85, 250335, nil, nil, nil, 6)
local timerFlamesofKhazgorothCD			= mod:NewCastTimer(85, 250333, nil, nil, nil, 6)
local timerSpectralArmyofNorgannonCD	= mod:NewCastTimer(85, 250334, nil, nil, nil, 6)
local timerFuryofGolgannethCD			= mod:NewCastTimer(85, 249793, nil, nil, nil, 6)
----Actual phase stuff
local timerMachinationsofAman			= mod:NewCastTimer(20, 250095, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Noura, Mother of Flames
local countdownTitans					= mod:NewCountdown(85, "ej16138")
local countdownFulminatingPulse			= mod:NewCountdown("Alt40", 253520, "Healer")
--Asara, Mother of Night
local countdownStormofDarkness			= mod:NewCountdown("AltTwo57", 252861)

mod:AddSetIconOption("SetIconOnFulminatingPulse2", 253520, false)
mod:AddSetIconOption("SetIconOnChilledBlood2", 245586, false)
mod:AddSetIconOption("SetIconOnCosmicGlare", 250757, true)
mod:AddInfoFrameOption(245586, true)
mod:AddNamePlateOption("NPAuraOnVisageofTitan", 249863)
mod:AddDropdownOption("TauntBehavior", {"TwoMythicThreeNon", "TwoAlways", "ThreeAlways"}, "TwoMythicThreeNon", "misc")

local titanCount = {}
mod.vb.stormCount = 0
mod.vb.chilledCount = 0
mod.vb.MachinationsLeft = 0
mod.vb.fpIcon = 6
mod.vb.chilledIcon = 1
mod.vb.glareIcon = 4
mod.vb.touchCosmosCast = 0
local CVAR1, CVAR2 = nil, nil

function mod:OnCombatStart(delay)
	self.vb.stormCount = 0
	self.vb.chilledCount = 0
	self.vb.MachinationsLeft = 0
	self.vb.fpIcon = 4
	self.vb.chilledIcon = 1
	self.vb.glareIcon = 4
	self.vb.touchCosmosCast = 0
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
	--Diima, Mother of Gloom is first one to go inactive
	timerWhirlingSaberCD:Start(8-delay)
	timerFieryStrikeCD:Start(11-delay)
	timerShadowBladesCD:Start(10.9-delay)
	if not self:IsEasy() then
		timerFulminatingPulseCD:Start(20.3-delay)
		countdownFulminatingPulse:Start(20.3-delay)
		timerStormofDarknessCD:Start(26-delay, 1)
		countdownStormofDarkness:Start(26-delay)
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.SetLighting and not IsMacClient() then--Mac client doesn't support low (1) setting for lighting (and not InCombatLockdown() needed?)
		CVAR1, CVAR2 = GetCVarBool("graphicsLightingQuality") or 3, GetCVarBool("raidGraphicsLightingQuality") or 2--Non raid cvar is nil if 3 (default) and raid one is nil if 2 (default)
		SetCVar("graphicsLightingQuality", 1)
		SetCVar("raidGraphicsLightingQuality", 1)
	end
end

function mod:OnCombatEnd()
	table.wipe(titanCount)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if CVAR1 or CVAR2 then
		CVAR1, CVAR2 = nil, nil
		SetCVar("graphicsLightingQuality", CVAR1)
		SetCVar("raidGraphicsLightingQuality", CVAR2)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 245627 then
		warnWhirlingSaber:Show()
		timerWhirlingSaberCD:Start()
	elseif spellId == 252861 then
		self.vb.stormCount = self.vb.stormCount + 1
		specWarnStormofDarkness:Show(self.vb.stormCount)
		specWarnStormofDarkness:Play("findshelter")
		timerStormofDarknessCD:Start(56.8, self.vb.stormCount+1)
		countdownStormofDarkness:Start(56.8)
	elseif spellId == 253650 then
		specWarnOrbofFrost:Show()
		specWarnOrbofFrost:Play("161411")
		timerOrbofFrostCD:Start()
	elseif spellId == 250095 and self:AntiSpam(3, 1) then
		timerMachinationsofAman:Start()
	elseif spellId == 250648 then
		self.vb.touchCosmosCast = self.vb.touchCosmosCast + 1
		if self.vb.touchCosmosCast == 4 then
			self.vb.touchCosmosCast = 1
		end
		local kickCount = self.vb.touchCosmosCast
		specWarnTouchoftheCosmos:Show(args.sourceName, kickCount)
		specWarnTouchoftheCosmos:Play("kick"..kickCount.."r")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244899 then
		timerFieryStrikeCD:Start()
	elseif spellId == 245518 then
		timerFlashFreezeCD:Start()
	elseif spellId == 253520 and self:AntiSpam(3, 3) then
		timerFulminatingPulseCD:Start()
		countdownFulminatingPulse:Start(40.1)
	elseif spellId == 245532 and self:AntiSpam(3, 2) then
		timerChilledBloodCD:Start()
		specWarnChilledBlood:Play("healall")
	elseif (spellId == 250335 or spellId == 250333 or spellId == 250334 or spellId == 249793) and self:IsInCombat() then--Torment selections
		countdownTitans:Start()
		if spellId == 250335 then--Machinations of Aman'Thul
			timerMachinationsofAmanThulCD:Start()
		elseif spellId == 250333 then--Flames of Khaz'goroth
			timerFlamesofKhazgorothCD:Start()
		elseif spellId == 250334 then--Spectral Army of Norgannon
			timerSpectralArmyofNorgannonCD:Start()
		elseif spellId == 249793 then--Fury of Golganneth
			timerFuryofGolgannethCD:Start()
		end
	elseif spellId == 246329 then--Shadow Blades
		specWarnShadowBlades:Show()
		specWarnShadowBlades:Play("watchwave")
		timerShadowBladesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244899 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local tauntStack = 3
			if self:IsMythic() and self.Options.TauntBehavior == "TwoMythicThreeNon" or self.Options.TauntBehavior == "TwoAlways" then
				tauntStack = 2
			end
			if amount >= tauntStack then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFieryStrike:Show(amount)
					specWarnFieryStrike:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 10) then
						specWarnFieryStrikeOther:Show(args.destName)
						specWarnFieryStrikeOther:Play("tauntboss")
					else
						warnFieryStrike:Show(args.destName, amount)
					end
				end
			else
				warnFieryStrike:Show(args.destName, amount)
			end
		end
	elseif spellId == 253520 then
		warnFulminatingPulse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFulminatingPulse:Show()
			specWarnFulminatingPulse:Play("runout")
			yellFulminatingPulse:Countdown(10)
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, self.vb.fpIcon)
		end
		self.vb.fpIcon = self.vb.fpIcon + 1
		if self.vb.fpIcon == 9 then
			self.vb.fpIcon = 6
		end
	elseif spellId == 245518 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFlashfreeze:Show(amount)
					specWarnFlashfreeze:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9.6) then
						specWarnFlashfreezeOther:Show(args.destName)
						specWarnFlashfreezeOther:Play("tauntboss")
					else
						warnFlashFreeze:Show(args.destName, amount)
					end
				end
			else
				warnFlashFreeze:Show(args.destName, amount)
			end
		end
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount + 1
		if self.Options.specwarn245586target then
			specWarnChilledBlood:CombinedShow(0.3, args.destName)
		else
			warnChilledBlood:CombinedShow(0.3, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", args.spellName, select(17, UnitDebuff(args.destName, args.spellName)))
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, self.vb.chilledIcon)
		end
		self.vb.chilledIcon = self.vb.chilledIcon + 1
		if self.vb.chilledIcon == 3 then
			self.vb.chilledIcon = 5
		elseif self.vb.chilledIcon == 6 then
			self.vb.chilledIcon = 1
		end
	elseif spellId == 250757 then
		warnCosmicGlare:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCosmicGlare:Show()
			specWarnCosmicGlare:Play("targetyou")
			yellCosmicGlare:Yell()
			yellCosmicGlareFades:Countdown(4)
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, self.vb.glareIcon)
		end
		self.vb.glareIcon = self.vb.glareIcon + 1
		if self.vb.glareIcon == 6 then
			self.vb.glareIcon = 4
		end
	elseif spellId == 249863 then
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 30)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 253520 then
		if args:IsPlayer() then
			yellFulminatingPulse:Cancel()
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount - 1
		if self.Options.InfoFrame and self.vb.chilledCount == 0 then
			DBM.InfoFrame:Hide()
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 249863 then--Bonecage Armor
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250757 then
		if args:IsPlayer() then
			yellCosmicGlareFades:Cancel()
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 245634 or spellId == 253020) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 125837 then--Torment of Amanthul
		self.vb.MachinationsLeft = self.vb.MachinationsLeft - 1
		if self.vb.MachinationsLeft == 0 then
			timerMachinationsofAman:Stop()
		end
	end
end

--"<94.13 21:56:15> [UNIT_SPELLCAST_SUCCEEDED] Diima, Mother of Gloom(??) [[boss3:Torment of Khaz'goroth::3-3779-1712-25990-259066-00119F734F:259066]]", -- [1126]
--"<94.33 21:56:15> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\ABILITY_MONK_BREATHOFFIRE:20|tThe Coven prepares to unleash the  |cFFFF0000|Hspell:245671|h[Flames of Khaz'goroth]|h|r!#Diima, Mother of Gloom###
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 259068 or spellId == 259066 or spellId == 259069 or spellId == 259070 then
		local name = UnitName(uId)
		name = string.split(",", name)--Strip title
		specWarnTormentofTitans:Show()
		if spellId == 259068 then--Torment of Aman'Thul
			self.vb.MachinationsLeft = 4
			specWarnTormentofTitans:Play("killmob")
		elseif spellId == 259066 then--Torment of Khaz'goroth
			specWarnTormentofTitans:Play("runtoedge")
			specWarnTormentofTitans:ScheduleVoice(1, "killmob")
		elseif spellId == 259069 then--Torment of Norgannon
			specWarnTormentofTitans:Play("watchstep")
		elseif spellId == 259070 then--Torment of Golganneth
			specWarnTormentofTitans:Play("scatter")
			specWarnTormentofTitans:ScheduleVoice(1, "killmob")
		end
		if not titanCount[name] then
			titanCount[name] = 1
		elseif titanCount[name] then
			titanCount[name] = titanCount[name] + 1
		end
		if titanCount[name] == 2 then
			titanCount[name] = 0
			timerBossIncoming:Start(8.7, name)
		end
		DBM:Debug("UNIT_SPELLCAST_SUCCEEDED fired with: "..name, 2)
	elseif spellId == 250752 then--Cosmic Glare
		timerCosmicGlareCD:Start()
	end
end

--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss3#true#true#true#Diima, Mother of Gloom#Creature-0-2083-1712-12288-122469-0000111E27#elite#2150947263", -- [1436]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] nameplate2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1437]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1438]
--"<198.19 00:02:36> [UNIT_SPELLCAST_SUCCEEDED] Noura, Mother of Flames(??) [[boss2:Spectral Army of Norgannon::3-2083-1712-12288-250334-000B1120DC:250334]]", -- [1456]
function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetUnitCreatureId(uId)
	if cid == 122468 then--Noura
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerWhirlingSaberCD:Start(9)
			timerFieryStrikeCD:Start(11.8)
			if not self:IsEasy() then
				timerFulminatingPulseCD:Start(20.6)
				countdownFulminatingPulse:Start(20.6)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFieryStrikeCD:Stop()
			timerWhirlingSaberCD:Stop()
			timerFulminatingPulseCD:Stop()
			countdownFulminatingPulse:Cancel()
		end
	elseif cid == 122467 then--Asara
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			--TODO, timers, never saw her leave so never saw her return
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerShadowBladesCD:Stop()
			timerStormofDarknessCD:Stop()
			countdownStormofDarkness:Cancel()
		end
	elseif cid == 122469 then--Diima
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerChilledBloodCD:Start(6.5)
			timerFlashFreezeCD:Start(10.1)
			if not self:IsEasy() then
				timerOrbofFrostCD:Start(30)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFlashFreezeCD:Stop()
			timerChilledBloodCD:Stop()
			timerOrbofFrostCD:Stop()
		end
	elseif cid == 125436 then--Thu'raya (mythic only)
		if UnitExists(uId) then
			self.vb.touchCosmosCast = 0
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerCosmicGlareCD:Start(5)
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerCosmicGlareCD:Stop()
		end
	end
end	
