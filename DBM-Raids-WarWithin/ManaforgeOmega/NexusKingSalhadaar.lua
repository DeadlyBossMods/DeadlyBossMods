local mod	= DBM:NewMod(2690, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237763)
mod:SetEncounterID(3134)
mod:SetHotfixNoticeRev(20250731000000)
mod:SetMinSyncRevision(20250731000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1224731 1224787 1224812 1227529 1224906 1225010 1225016 1228065 1230302 1232399 1228075 1230263 1227734 1228115 1228163 1234529 1228265 1225319 1234904 1228053 1237106",
	"SPELL_CAST_SUCCESS 1234904 1226442",
	"SPELL_AURA_APPLIED 1224737 1224767 1224776 1227549 1237105 1234529 1228265 1226413",
	"SPELL_AURA_APPLIED_DOSE 1224737 1226413",
	"SPELL_AURA_REMOVED 1224737 1227549 1237105 1228284 1228265",
	"SPELL_AURA_REMOVED_DOSE 1224737",
	"SPELL_PERIODIC_DAMAGE 1231097",
	"SPELL_PERIODIC_MISSED 1231097",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, better netherbreaker private aura sound?
--TODO, verify which dimension breath Id is cast
--TODO, correct event to start smash timer (and other timers for that matter)
--TODO, better voice lines for starkiller swing and galactic smash?
--[[
(ability.id = 1228065 or ability.id = 1227734 or ability.id = 1228265) and type = "begincast"
or (ability.id = 1228265 or ability.id = 1228284) and type = "removebuff" and target.id = 233823
--]]
--Stage One: Oath-Breakers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31573))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))

local warnDecreeOathBound							= mod:NewCastAnnounce(1224731, 2)
local warnKingsThrall								= mod:NewTargetNoFilterAnnounce(1224767, 2)--Could be spammy

local specWarnConquer								= mod:NewSpecialWarningSoakCount(1224787, nil, nil, nil, 2, 2)
local specWarnVanquish								= mod:NewSpecialWarningSpell(1224812, nil, nil, nil, 2, 15)
local specWarnBanishment							= mod:NewSpecialWarningMoveAway(1227549, nil, nil, nil, 1, 2)
local yellBanishmentFades							= mod:NewShortFadesYell(1227549)
local specWarnInvokeTheOath							= mod:NewSpecialWarningSpell(1224906, nil, nil, nil, 2, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1231097, nil, nil, nil, 1, 8)

local timerSubjugationRuleCD						= mod:NewCDCountTimer(40, 1224776, DBM_COMMON_L.TANKCOMBO.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBanishmentCD								= mod:NewCDCountTimer(97.3, 1227549, nil, nil, nil, 3)
local timerInvokeTheOathCD							= mod:NewNextTimer(117, 1224906, nil, nil, nil, 2)

mod:AddInfoFrameOption(1224731, true)
----Royal Voidwing
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32228))
local specWarnBesiege								= mod:NewSpecialWarningDodgeCount(1227470, nil, nil, nil, 2, 2)

local timerBeheadCD									= mod:NewCDCountTimer(40, 1224827, nil, nil, nil, 3)
local timerBesiegeCD								= mod:NewCDCountTimer(40, 1227470, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1224855, true, 1224827, 1)--Behead
--Intermission One: Nexus Descent
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32631))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))
local specWarnRallytheShadowguard					= mod:NewSpecialWarningSwitch(1228065, nil, nil, nil, 1, 2)

local timerRallytheShadowguardCD					= mod:NewNextTimer(10, 1228065, nil, nil, nil, 6)
----Manaforged Titan
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32639))
local warnSelfDestruct								= mod:NewCastAnnounce(1230302, 4)

local specWarnDreadMortar							= mod:NewSpecialWarningDodge(1232399, nil, nil, nil, 2, 2)

local timerSelfDestructCD							= mod:NewCDTimer(64, 1230302, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSelfDestruct								= mod:NewCastNPTimer(10, 1230302, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDreadMortarCD							= mod:NewCDNPTimer(24.3, 1232399, nil, nil, nil, 3)
----Nexus-Prince Ky'vor + Nexus-Prince Xevvos
mod:AddTimerLine(DBM:EJ_GetSectionInfo(33469))
local specWarnNexusBeam								= mod:NewSpecialWarningDodge(1228075, nil, nil, nil, 2, 2)
local specWarnNetherblast							= mod:NewSpecialWarningInterruptCount(1230263, nil, nil, nil, 1, 2)

local timerNexusBeamCD								= mod:NewCDNPTimer(20.6, 1228075, nil, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnTwilightBarrier", 1237105)
----Shadowguard Reaper
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32645))
local timerTwilightMassacreCD						= mod:NewCDNPTimer(99, 1237106, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerReapCD									= mod:NewCDNPTimer(12.2, 1228053, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1237108, true, 1237106, 1)--Twilight Massacre
--Stage Two: Rider of the Dark
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31574))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))
local specWarnCoalesceVoidwing					= mod:NewSpecialWarningDodge(1227734, nil, nil, nil, 3, 2)

local timerCoalesceVoidwing						= mod:NewCastTimer(6.2, 1227734, 28405, nil, nil, 2)--Shorttext Knockback
local timerNetherbreakerCD						= mod:NewCDCountTimer(10, 1228115, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1228114, true, 1228115, 1)--Netherbreaker
----Royal Voidwing
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32228))
local specWarnDimensionBreath					= mod:NewSpecialWarningCount(1228163, nil, nil, nil, 2, 2)
local specWarnCosmicMaw							= mod:NewSpecialWarningDefensive(1234529, nil, nil, nil, 1, 2)
local specWarnCosmicMawTaunt					= mod:NewSpecialWarningTaunt(1234529, nil, nil, nil, 1, 2)

local timerDimensionBreathCD					= mod:NewCDCountTimer(97.3, 1228163, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmicMawCD							= mod:NewCDCountTimer(97.3, 1234529, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Intermission Two: King's Hunger
local specWarnKingsHunger						= mod:NewSpecialWarningSwitchCustom(1228265, "-Healer", nil, nil, 1, 2)

local timerKingsHunger							= mod:NewBuffActiveTimer(30, 1228265, nil, nil, nil, 3)
--Stage Three: World in Twilight
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31575))
--local warnStarshattered							= mod:NewStackAnnounce(1226413, 2, nil, "Tank|Healer")

local specWarnStarshattered						= mod:NewSpecialWarningYou(1226413, nil, nil, nil, 1, 6)
local specWarnStarshatteredTaunt				= mod:NewSpecialWarningTaunt(1226413, nil, nil, nil, 1, 2)

local timerGalacticSmashCD						= mod:NewCDCountTimer(55, 1226648, nil, nil, nil, 3)
local timerStarkillerSwingCD					= mod:NewCDCountTimer(97.3, 1226442, nil, nil, nil, 3)
local timerWorldInTwilightCD					= mod:NewNextTimer(185, 1225634, nil, nil, nil, 6)--172.5+12.5ish

mod:AddPrivateAuraSoundOption(1225316, true, 1226648, 1)--Galactic Smash
mod:AddPrivateAuraSoundOption(1226018, true, 1226442, 1)--Starkiller Swing

local castsPerGUID = {}
local OathStacks = {}
local stage2StartTime = 0--Because GetTime() is machine based, it can't be a syncable variable
--local intermissionOneStartTime = nil
mod.vb.tankComboCount = 0--Resused on Cosmic Maw for now (maybe breath if it's wrong)
mod.vb.conquerCount = 0
mod.vb.banishmentCount = 0
mod.vb.beheadCount = 0
mod.vb.besiegeCount = 0
mod.vb.netherbreakerCount = 0
mod.vb.dimensionBreathCount = 0
mod.vb.smashCount = 0
mod.vb.swingCount = 0
mod.vb.manaRemaining = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	table.wipe(OathStacks)
	self.vb.tankComboCount = 0
	self.vb.conquerCount = 0
	self.vb.banishmentCount = 0
	self.vb.beheadCount = 0
	self.vb.besiegeCount = 0
	self.vb.netherbreakerCount = 0
	self.vb.dimensionBreathCount = 0
	self.vb.smashCount = 0
	self.vb.swingCount = 0
	--Boss
	timerSubjugationRuleCD:Start(self:IsEasy() and 12.5 or 14.5-delay, 1)
	timerBanishmentCD:Start(30-delay, 1)
	timerInvokeTheOathCD:Start(117-delay)--Until cast finish (not cast start)
	--Voidwing
	timerBeheadCD:Start(32.4-delay, 1)
	timerBesiegeCD:Start(self:IsMythic() and 9 or self:IsEasy() and 46 or 49-delay, 1)
	self:EnablePrivateAuraSound(1224855, "lineyou", 17)--Behead
	self:EnablePrivateAuraSound(1224857, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1224858, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1224859, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1224864, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225060, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1224860, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225055, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225056, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225057, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225059, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1224828, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1225058, "lineyou", 17, 1224855)--Behead
	self:EnablePrivateAuraSound(1237108, "behindmob", 2)--Twilight Massacre
	self:EnablePrivateAuraSound(1228114, "lineyou", 17)--Netherbreaker
	self:EnablePrivateAuraSound(1225316, "runout", 2)--Galactic Smash
	self:EnablePrivateAuraSound(1248128, "runout", 2, 1225316)--Galactic Smash
	self:EnablePrivateAuraSound(1226601, "runout", 2, 1225316)--Galactic Smash
	self:EnablePrivateAuraSound(1226602, "runout", 2, 1225316)--Galactic Smash
	self:EnablePrivateAuraSound(1226018, "runout", 2)--Starkiller Swing
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellName(1224737))
		DBM.InfoFrame:Show(self:IsHard() and 30 or 10, "table", OathStacks, 1)--Show everyone on heroic+, filter down to 10 on normal/lfr
	end
	if self.Options.NPAuraOnTwilightBarrier then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnTwilightBarrier then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1224731 then
		warnDecreeOathBound:Show()
	elseif spellId == 1224787 then
		self.vb.conquerCount = self.vb.conquerCount + 1
		if self.vb.conquerCount % 2 == 1 then
			specWarnConquer:Show(self.vb.conquerCount)
			specWarnConquer:Play("shareone")
		else
			specWarnConquer:Show(self.vb.conquerCount)
			specWarnConquer:Play("sharetwo")
		end
	elseif spellId == 1224812 then
		specWarnVanquish:Show()
		specWarnVanquish:Play("frontal")
	elseif spellId == 1227529 then
		self.vb.banishmentCount = self.vb.banishmentCount + 1
		if self.vb.banishmentCount < 4 then
			local timer = self.vb.banishmentCount % 2 == 0 and 24.1 or 15.9
			timerBanishmentCD:Start(timer, self.vb.banishmentCount+1)
		end
	elseif spellId == 1224906 then
		specWarnInvokeTheOath:Show()
		specWarnInvokeTheOath:Play("findmc")
	elseif spellId == 1225010 then--Stage 1
		self.vb.beheadCount = self.vb.beheadCount + 1
		timerBeheadCD:Start(40, self.vb.beheadCount+1)
	elseif spellId == 1225016 then
		self.vb.besiegeCount = self.vb.besiegeCount + 1
		specWarnBesiege:Show(self.vb.besiegeCount)
		specWarnBesiege:Play("breathsoon")
		timerBesiegeCD:Start(nil, self.vb.besiegeCount+1)
	elseif spellId == 1228065 then
		--Intermission One: Nexus Descent
		--Timers for adds start on phase start, but their GUIDS aren't known until they spawn, so we can't start them here
		--intermissionOneStartTime = GetTime()
		self.vb.manaRemaining = 2--manaforge titan
		--self:RegisterShortTermEvents(
		--	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		--)
		specWarnRallytheShadowguard:Show()
		specWarnRallytheShadowguard:Play("killmob")
		self:SetStage(1.5)
		timerNetherbreakerCD:Stop()
		timerCosmicMawCD:Stop()
		timerDimensionBreathCD:Stop()
		timerBeheadCD:Stop()
		--Stop intermission bar (when created)
		timerSelfDestructCD:Start(64)--Basically the stage's "berserk" timer
		self:RegisterZoneCombat(2810)
	elseif spellId == 1230302 then
		if self:AntiSpam(5, 1) then
			warnSelfDestruct:Show()
		end
		timerSelfDestruct:Start(nil, args.sourceGUID)
	elseif spellId == 1232399 then
		if self:CheckBossDistance(args.sourceGUID, false, 32698, 48) then
			specWarnDreadMortar:Show()
			specWarnDreadMortar:Play("watchstep")
		end
		timerDreadMortarCD:Start(nil, args.sourceGUID)
	elseif spellId == 1228075 then
		if self:CheckBossDistance(args.sourceGUID, false, 32698, 48) then
			specWarnNexusBeam:Show()
			specWarnNexusBeam:Play("watchstep")
		end
		timerNexusBeamCD:Start(nil, args.sourceGUID)
	elseif spellId == 1230263 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnNetherblast:Show(args.sourceName, count)
			if count < 6 then
				specWarnNetherblast:Play("kick"..count.."r")
			else
				specWarnNetherblast:Play("kickcast")
			end
		end
	elseif spellId == 1227734 then
		specWarnCoalesceVoidwing:Show()
		specWarnCoalesceVoidwing:Play("carefly")
		timerCoalesceVoidwing:Start()
		self:SetStage(2)
		stage2StartTime = GetTime()
		--Reset reused Counts
		self.vb.tankComboCount = 0
		self.vb.beheadCount = 0
		self.vb.netherbreakerCount = 0
		self.vb.dimensionBreathCount = 0
		--Stop Stage 1 timers
		timerSubjugationRuleCD:Stop()
		timerBanishmentCD:Stop()
		timerInvokeTheOathCD:Stop()
		timerBeheadCD:Stop()
		timerBesiegeCD:Stop()
		--Start Stage 2 timers
		if self:IsMythic() then
			timerNetherbreakerCD:Start(7.1, 1)
			--timerBeheadCD:Start(20.5, 1)--Unknown not seen yet
			timerCosmicMawCD:Start(15.5, 1)
			timerDimensionBreathCD:Start(20.5, 1)
		else
			timerNetherbreakerCD:Start(11.5, 1)
			timerBeheadCD:Start(20.5, 1)
			timerCosmicMawCD:Start(22.5, 1)
			timerDimensionBreathCD:Start(28.5, 1)
		end
		timerRallytheShadowguardCD:Start(38.4)--Same on all for now
		--Other stage 2 timers start here as well BUT we delay their start until after the random intermission in middle of stage 2
	elseif spellId == 1228115 then
		self.vb.netherbreakerCount = self.vb.netherbreakerCount + 1
		--timerNetherbreakerCD:Start(nil, self.vb.netherbreakerCount+1)
	elseif spellId == 1228163 then
		self.vb.dimensionBreathCount = self.vb.dimensionBreathCount + 1
		specWarnDimensionBreath:Show(self.vb.dimensionBreathCount)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnDimensionBreath:Play("defensive")
		else
			specWarnDimensionBreath:Play("breathsoon")
		end
		--timerDimensionBreathCD:Start(nil, self.vb.dimensionBreathCount+1)--Unknown recast
	elseif spellId == 1234529 then
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnCosmicMaw:Show()
			specWarnCosmicMaw:Play("defensive")
		end
		--timerCosmicMawCD:Start(nil, self.vb.tankComboCount+1)--Unknown recast
	elseif spellId == 1228265 then
		--Intermission Two: King's Hunger
		self:SetStage(2.5)
		timerNetherbreakerCD:Stop()
		timerDimensionBreathCD:Stop()
		timerCosmicMawCD:Stop()
		timerBeheadCD:Stop()
		timerBanishmentCD:Stop()
		timerBesiegeCD:Stop()
	elseif spellId == 1225319 then
		self.vb.smashCount = self.vb.smashCount + 1
		timerGalacticSmashCD:Start(nil, self.vb.smashCount+1)
	elseif spellId == 1228053 then
		timerReapCD:Start(nil, args.sourceGUID)
	elseif spellId == 1237106 then
		timerTwilightMassacreCD:Stop(args.sourceGUID)--Just to clear initial timer for now
		--timerTwilightMassacreCD:Start(nil, args.sourceGUID)--repeat cast timer not known yet
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1234904 then--Stage 2
		self.vb.beheadCount = self.vb.beheadCount + 1
		--timerBeheadCD:Start(100, self.vb.beheadCount+1)--Unknown recast time, if there is a recast time at all
	elseif spellId == 1226442 then
		self.vb.swingCount = self.vb.swingCount + 1
		local timer = self.vb.swingCount % 2 == 0 and 40 or 15
		timerStarkillerSwingCD:Start(self:IsEasy() and 55 or timer, self.vb.swingCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1224737 then
		local amount = args.amount or 3
		OathStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(OathStacks, 0.2)
		end
	elseif spellId == 1224767 then
		warnKingsThrall:CombinedShow(0.3, args.destName)
	elseif spellId == 1227549 then
		if args:IsPlayer() then
			specWarnBanishment:Show()
			specWarnBanishment:Play("scatter")
			yellBanishmentFades:Countdown(spellId)
		end
	elseif spellId == 1237105 then
		if self.Options.NPAuraOnTwilightBarrier then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 1234529 and not args:IsPlayer() then
		specWarnCosmicMawTaunt:Show(args.destName)
		specWarnCosmicMawTaunt:Play("tauntboss")
	elseif spellId == 1228265 then
		specWarnKingsHunger:Show(args.destName)
		specWarnKingsHunger:Play("targetchange")
		timerKingsHunger:Start()
	elseif spellId == 1226413 then
		if args:IsPlayer() then
			specWarnStarshattered:Show()
			specWarnStarshattered:Play("targetyou")
		else
			if not UnitIsDeadOrGhost("player") then
				specWarnStarshatteredTaunt:Show(args.destName)
				specWarnStarshatteredTaunt:Play("tauntboss")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1224737 then
		OathStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(OathStacks, 0.2)
		end
	elseif spellId == 1227549 then
		if args:IsPlayer() then
			yellBanishmentFades:Cancel()
		end
	elseif spellId == 1237105 then
		if self.Options.NPAuraOnTwilightBarrier then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 1228284 and args:GetDestCreatureID() == 233823 then
		--self:UnregisterShortTermEvents()
		self:UnregisterZoneCombat(2810)
		--intermissionOneStartTime = nil
		--Main boss leaving intermission and returning back to stage 2
		self:SetStage(2)
		--Timers need auto correction from stage 2 true start
		local timeSinceStage2Start = GetTime() - stage2StartTime
		timerNetherbreakerCD:Start(113.4 - timeSinceStage2Start, self.vb.netherbreakerCount+1)
		timerBeheadCD:Start(120.4 - timeSinceStage2Start, self.vb.beheadCount+1)
		timerCosmicMawCD:Start(122.4 - timeSinceStage2Start, self.vb.tankComboCount+1)
		timerDimensionBreathCD:Start(128.4 - timeSinceStage2Start, self.vb.dimensionBreathCount+1)
	elseif spellId == 1228265 then
		self:SetStage(3)
		timerKingsHunger:Stop()
		timerGalacticSmashCD:Start(self:IsEasy() and 6.2 or 9, 1)
		timerStarkillerSwingCD:Start(self:IsEasy() and 46.8 or 36.8, 1)
		timerWorldInTwilightCD:Start(185)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 1224737 then
		OathStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(OathStacks, 0.2)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1231097 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 241800 then--Manaforged Titan
		self.vb.manaRemaining = self.vb.manaRemaining - 1
		if self.vb.manaRemaining == 0 then
			timerSelfDestructCD:Stop()
		end
		timerSelfDestruct:Stop(args.destGUID)
		timerDreadMortarCD:Stop(args.destGUID)
	elseif cid == 241798 or cid == 241803 then--Both Nexus Princes
		timerNexusBeamCD:Stop(args.destGUID)
	elseif cid == 241801 then--Shadowguard Reaper
		timerReapCD:Stop(args.destGUID)
		timerTwilightMassacreCD:Stop(args.destGUID)
	elseif cid == 233823 or cid == 244170 then--Royal Voidwing
		timerDimensionBreathCD:Stop()
		timerCosmicMawCD:Stop()
		timerBeheadCD:Stop()
		timerBesiegeCD:Stop()
		--timerFractalImagesCD:Stop()
	end
end

--All timers subject to a ~0.5 second clipping due to ScanEngagedUnits
--These will need extra tweaking when I get better debug on live with DBM. BW combat scanner and debug isn't as detailed
function mod:StartEngageTimers(guid, cid, delay)
	if cid == 241800 then--Manaforged Titan
		timerDreadMortarCD:Start(6.5-delay, guid)
	elseif cid == 241798 or cid == 241803 then--Both Nexus Princes
		timerNexusBeamCD:Start(16.5-delay, guid)
	elseif cid == 241801 then--Shadowguard Reaper
		timerReapCD:Start(7-delay, guid)
		if self:IsMythic() then
			timerTwilightMassacreCD:Start(9.5-delay, guid)
		end
	end
end

--[[
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not castsPerGUID[GUID] then
			castsPerGUID[GUID] = 0
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 241800 then--Manaforged Titan
				--local phaseAdjustment = GetTime() - intermissionOneStartTime
				timerDreadMortarCD:Start(6.5, GUID)--15.6 - phaseAdjustment
			elseif cid == 241798 or cid == 241803 then--Both Nexus Princes
				timerNexusBeamCD:Start(16.5, GUID)
			end
		end
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 1224776 then
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		timerSubjugationRuleCD:Start(nil, self.vb.tankComboCount+1)
	end
end
