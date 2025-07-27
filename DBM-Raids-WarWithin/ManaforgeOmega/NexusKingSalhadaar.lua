if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2690, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237763)
mod:SetEncounterID(3134)
mod:SetHotfixNoticeRev(20250627000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1224731 1224787 1224812 1227529 1224906 1225099 1225010 1225016 1228065 1230302 1232399 1228075 1230263 1227734 1228115 1228163 1234529 1228265 1225319 1226024",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1224737 1224767 1224776 1227549 1237105 1234529 1228265 1226413",
	"SPELL_AURA_APPLIED_DOSE 1224737 1226413",
	"SPELL_AURA_REMOVED 1224737 1227549 1237105 1228284",
	"SPELL_AURA_REMOVED_DOSE 1224737",
	"SPELL_PERIODIC_DAMAGE 1231097",
	"SPELL_PERIODIC_MISSED 1231097",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, lots of nameplate timers vs reg timers debait on intermissions
--TODO, target scan reap?
--TODO, better netherbreaker private aura sound?
--TODO, verify which dimension breath Id is cast
--TODO, what comes first, breath or maw? need right one to increment combo count
--TODO, correct event to start smash timer (and other timers for that matter)
--TODO, better voice lines for starkiller swing and galactic smash?
--TODO, swap every Starshattered or every 2?
--Stage One: Oath-Breakers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31573))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))

local warnDecreeOathBound							= mod:NewCastAnnounce(1224731, 2)
local warnKingsThrall								= mod:NewTargetAnnounce(1224767, 2)--Could be spammy

local specWarnConquer								= mod:NewSpecialWarningSoakCount(1224787, nil, nil, nil, 2, 2)
local specWarnVanquish								= mod:NewSpecialWarningSoakCount(1224812, nil, nil, nil, 2, 2)
local specWarnBanishment							= mod:NewSpecialWarningMoveAway(1227529, nil, nil, nil, 1, 2)
local yellBanishmentFades							= mod:NewShortFadesYell(1227529)
local specWarnInvokeTheOath							= mod:NewSpecialWarningSpell(1224906, nil, nil, nil, 2, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1231097, nil, nil, nil, 1, 8)

local timerSubjugationRuleCD						= mod:NewAITimer(97.3, 1224776, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--DBM_COMMON_L.TANKCOMBO.." (%s)"
local timerBanishmentCD								= mod:NewAITimer(97.3, 1227529, nil, nil, nil, 3)

mod:AddInfoFrameOption(1224731, true)
----Royal Voidwing
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32228))
local warnFractalImages								= mod:NewCountAnnounce(1225099, 2)

local specWarnBesiege								= mod:NewSpecialWarningDodgeCount(1225016, nil, nil, nil, 2, 2)

local timerFractalImagesCD							= mod:NewAITimer(97.3, 1225099, nil, nil, nil, 1)
local timerBeheadCD									= mod:NewAITimer(97.3, 1225010, nil, nil, nil, 3)
local timerBesiegeCD								= mod:NewAITimer(97.3, 1225016, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1224855, true, 1225010, 1)--Behead
--Intermission One: Nexus Descent
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32631))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))
local specWarnRallytheShadowguard					= mod:NewSpecialWarningSwitch(1228065, nil, nil, nil, 1, 2)
----Manaforged Titan
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32639))
local warnSelfDestruct								= mod:NewCastAnnounce(1230302, 4)

local specWarnDreadMortar							= mod:NewSpecialWarningDodge(1232399, nil, nil, nil, 2, 2)

local timerSelfDestruct								= mod:NewCastNPTimer(10, 1230302, nil, nil, nil, 2)
--local timerDreadMortarCD							= mod:NewAITimer(10, 1232399, nil, nil, nil, 3)--one normal timer or multiple nameplate timers?
----Nexus-Prince Ky'vor + Nexus-Prince Xevvos
mod:AddTimerLine(DBM:EJ_GetSectionInfo(33469))
local specWarnNexusBeam								= mod:NewSpecialWarningDodge(1228075, nil, nil, nil, 2, 2)
local specWarnNetherblast							= mod:NewSpecialWarningInterruptCount(1230263, nil, nil, nil, 1, 2)

--local timerNexusBeamCD							= mod:NewAITimer(97.3, 1228075, nil, nil, nil, 3)--one normal timer or multiple nameplate timers?

mod:AddNamePlateOption("NPAuraOnTwilightBarrier", 1237105)
----Shadowguard Reaper
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32645))

--local timerTwilightMassacreCD						= mod:NewCDTimer(10, 1237108, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--local timerReapCD									= mod:NewCDTimer(10, 1228053, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1237108, true, 1237108, 1)--Twilight Massacre
--Stage Two: Rider of the Dark
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31574))
----Nexus-King Salhadaar
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32227))
local specWarnCoalesceVoidwing					= mod:NewSpecialWarningDodge(1227734, nil, nil, nil, 3, 2)

local timerNetherbreakerCD						= mod:NewAITimer(10, 1228115, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1228114, true, 1228115, 1)--Netherbreaker
----Royal Voidwing
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32228))
local specWarnDimensionBreath					= mod:NewSpecialWarningCount(1228163, nil, nil, nil, 2, 2)
local specWarnCosmicMaw							= mod:NewSpecialWarningDefensive(1234529, nil, nil, nil, 1, 2)
local specWarnCosmicMawTaunt					= mod:NewSpecialWarningTaunt(1234529, nil, nil, nil, 1, 2)

local timerDimensionBreathCD					= mod:NewAITimer(97.3, 1228163, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmicMawCD							= mod:NewAITimer(97.3, 1234529, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Intermission Two: King's Hunger
local specWarnKingsHunger						= mod:NewSpecialWarningSwitchCustom(1228265, "-Healer", nil, nil, 1, 2)
--Stage Three: World in Twilight
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31575))
local warnStarshattered							= mod:NewStackAnnounce(1226413, 2, nil, "Tank|Healer")

local specWarnStarshattered						= mod:NewSpecialWarningStack(1226413, nil, 2, nil, nil, 1, 6)
local specWarnStarshatteredTaunt				= mod:NewSpecialWarningTaunt(1226413, nil, nil, nil, 1, 2)

local timerGalacticSmashCD						= mod:NewAITimer(97.3, 1225319, nil, nil, nil, 3)
local timerStarkillerSwingCD					= mod:NewAITimer(97.3, 1226024, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(1225316, true, 1225319, 1)--Galactic Smash
mod:AddPrivateAuraSoundOption(1226018, true, 1226024, 1)--Starkiller Swing

local castsPerGUID = {}
local OathStacks = {}
mod.vb.tankComboCount = 0--Resused on Maw for now (maybe breath if it's wrong)
mod.vb.tankSubCount = 0
mod.vb.banishmentCount = 0
mod.vb.fractalImagesCount = 0
mod.vb.beheadCount = 0
mod.vb.besiegeCount = 0
mod.vb.netherbreakerCount = 0
mod.vb.dimensionBreathCount = 0
mod.vb.smashCount = 0
mod.vb.swingCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	table.wipe(OathStacks)
	self.vb.tankComboCount = 0
	self.vb.tankSubCount = 0
	self.vb.banishmentCount = 0
	self.vb.fractalImagesCount = 0
	self.vb.beheadCount = 0
	self.vb.besiegeCount = 0
	self.vb.netherbreakerCount = 0
	self.vb.dimensionBreathCount = 0
	self.vb.smashCount = 0
	self.vb.swingCount = 0
	--Boss
	timerSubjugationRuleCD:Start(1-delay)
	timerBanishmentCD:Start(1-delay)
	--Voidwing
	timerFractalImagesCD:Start(1-delay)
	timerBeheadCD:Start(1-delay)
	timerBesiegeCD:Start(1-delay)
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
		self.vb.tankSubCount = self.vb.tankSubCount + 1
		if self.vb.tankSubCount == 1 then
			specWarnConquer:Show(self.vb.tankSubCount)
			specWarnConquer:Play("shareone")
		else
			specWarnConquer:Show(self.vb.tankSubCount)
			specWarnConquer:Play("sharetwo")
		end
	elseif spellId == 1224812 then
		self.vb.tankSubCount = self.vb.tankSubCount + 1
		if self.vb.tankSubCount == 1 then
			specWarnVanquish:Show(self.vb.tankSubCount)
			specWarnVanquish:Play("shareone")
		else
			specWarnVanquish:Show(self.vb.tankSubCount)
			specWarnVanquish:Play("sharetwo")
		end
	elseif spellId == 1227529 then
		self.vb.banishmentCount = self.vb.banishmentCount + 1
		timerBanishmentCD:Start()--nil, self.vb.banishmentCount+1
	elseif spellId == 1224906 then
		specWarnInvokeTheOath:Show()
		specWarnInvokeTheOath:Play("aesoon")
	elseif spellId == 1225099 then
		self.vb.fractalImagesCount = self.vb.fractalImagesCount + 1
		warnFractalImages:Show(self.vb.fractalImagesCount)
		timerFractalImagesCD:Start()--nil, self.vb.fractalImagesCount+1
	elseif spellId == 1225010 then
		self.vb.beheadCount = self.vb.beheadCount + 1
		timerBeheadCD:Start()--nil, self.vb.beheadCount+1
	elseif spellId == 1225016 then
		self.vb.besiegeCount = self.vb.besiegeCount + 1
		specWarnBesiege:Show(self.vb.besiegeCount)
		specWarnBesiege:Play("breathsoon")
		timerBesiegeCD:Start()--nil, self.vb.besiegeCount+1
	elseif spellId == 1228065 then
		specWarnRallytheShadowguard:Show()
		specWarnRallytheShadowguard:Play("killmob")
		if self:GetStage(1) then
			self:SetStage(1.5)
			timerSubjugationRuleCD:Stop()
			timerBanishmentCD:Stop()
			timerFractalImagesCD:Stop()
			timerBeheadCD:Stop()
			timerBesiegeCD:Stop()
		end
	elseif spellId == 1230302 then
		warnSelfDestruct:Show()
		timerSelfDestruct:Start(nil, args.sourceGUID)
	elseif spellId == 1232399 then
		if self:AntiSpam(3, 2) then
			specWarnDreadMortar:Show()
			specWarnDreadMortar:Play("watchstep")
		end
		--timerDreadMortarCD:Start(nil, args.sourceGUID)
	elseif spellId == 1228075 then
		if self:AntiSpam(3, 1) then
			specWarnNexusBeam:Show()
			specWarnNexusBeam:Play("watchstep")
		end
		--timerNexusBeamCD:Start(nil, args.sourceGUID)
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
		specWarnCoalesceVoidwing:Play("watchstep")
	elseif spellId == 1228115 then
		self.vb.netherbreakerCount = self.vb.netherbreakerCount + 1
		timerNetherbreakerCD:Start()--nil, self.vb.netherbreakerCount+1
	elseif spellId == 1228163 then
		self.vb.dimensionBreathCount = self.vb.dimensionBreathCount + 1
		specWarnDimensionBreath:Show(self.vb.dimensionBreathCount)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnDimensionBreath:Play("defensive")
		else
			specWarnDimensionBreath:Play("breathsoon")
		end
		timerDimensionBreathCD:Start()--nil, self.vb.dimensionBreathCount+1
	elseif spellId == 1234529 then
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnCosmicMaw:Show()
			specWarnCosmicMaw:Play("defensive")
		end
		timerCosmicMawCD:Start()--nil, self.vb.tankComboCount+1
	elseif spellId == 1228265 then
		--Intermission Two: King's Hunger
		if self:GetStage(2) then
			self:SetStage(2.5)
			timerNetherbreakerCD:Stop()
			timerDimensionBreathCD:Stop()
			timerCosmicMawCD:Stop()
			timerBeheadCD:Stop()
		end
		timerBeheadCD:Start(3)--Behead returns one final time
	elseif spellId == 1225319 then
		self.vb.smashCount = self.vb.smashCount + 1
		timerGalacticSmashCD:Start()--nil, self.vb.smashCount+1
	elseif spellId == 1226024 then
		self.vb.swingCount = self.vb.swingCount + 1
		timerStarkillerSwingCD:Start()--nil, self.vb.swingCount+1
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

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
	elseif spellId == 1224776 then
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		self.vb.tankSubCount = 0
		timerSubjugationRuleCD:Start()--nil, self.vb.tankComboCount+1
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
	elseif spellId == 1226413 then
		local amount = args.amount or 1
		if amount >= 2 then--placeholder
			if args:IsPlayer() then
				specWarnStarshattered:Show(amount)
				specWarnStarshattered:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnStarshatteredTaunt:Show(args.destName)
					specWarnStarshatteredTaunt:Play("tauntboss")
				end
			end
		else
			warnStarshattered:Show(args.destName, amount)
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
	elseif spellId == 1228284 and args:GetDestCreatureID() == 237763 then
		--Main boss leaving intermission
		if self:GetStage(1.5) then
			self:SetStage(2)
			timerNetherbreakerCD:Start(2)
			timerDimensionBreathCD:Start(2)
			timerCosmicMawCD:Start(2)
			timerBeheadCD:Start(2)--Ability returns
		elseif self:GetStage(2.5) then
			self:SetStage(3)
			timerBeheadCD:Stop()
			timerGalacticSmashCD:Start(3)
			timerStarkillerSwingCD:Start(3)
		end
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
	if spellId == 1231097 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 241800 then--Manaforged Titan
		timerSelfDestruct:Stop(args.destGUID)
	elseif cid == 233823 or cid == 244170 then--Royal Voidwing
		timerDimensionBreathCD:Stop()
		timerCosmicMawCD:Stop()
		timerBeheadCD:Stop()
		timerBesiegeCD:Stop()
		timerFractalImagesCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
