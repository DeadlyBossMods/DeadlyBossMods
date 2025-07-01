if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2685, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233816)
mod:SetEncounterID(3130)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20250630000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1225582 1227052 1241100 1223859 1242088 1225616",
	"SPELL_CAST_SUCCESS 1227848 1227276 1227048",
	"SPELL_AURA_APPLIED 1227049 1227049 1227276 1237607 1225626",
	"SPELL_AURA_APPLIED_DOSE 1237607",
	"SPELL_AURA_REMOVED 1227049 1227276 1225626",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, track Soulweave Chrysalis casts on nameplates? right now 3 cast spellids but only 2 summon ids
--TODO, detect adds releasing for initial nameplate timers
--TODO, add silk shield infoframe tracking all shield remaining?
--TODO, tanks wap stacks
--TODO, convergence icons when we know number of targets and what others are doing
--TODO, possible orb warnings for expiring convergence?
--General
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)
--Soul Calling
mod:AddTimerLine(DBM:EJ_GetSectionInfo(1225582))
local warnSoulCalling								= mod:NewCountAnnounce(1225582, 2)

local timerSoulCallingCD							= mod:NewNextCountTimer(150, 1225582, nil, nil, nil, 1)
----Assassins
local specWarnVoidbladeAmbush						= mod:NewSpecialWarningMoveAway(1227048, nil, nil, nil, 1, 2)
local yellVoidbladeAmbush							= mod:NewShortYell(1227048)
local yellVoidbladeAmbushFades						= mod:NewShortFadesYell(1227048)

local timerVoidbladeAmbushCD						= mod:NewCDNPTimer(12.1, 1227048, nil, nil, nil, 3)
----Mages
local specWarnVoidVolley							= mod:NewSpecialWarningInterruptCount(1227052, "HasInterrupt", nil, nil, 1, 2)
----Phaseblade (do stuff with em?)
--Boss
--local warnEssenceImplosion						= mod:NewCountAnnounce(1227848, 2)
local warnSoulfrayAnnihilation						= mod:NewTargetNoFilterAnnounce(1227276, 2)
local warnMysticLash								= mod:NewStackAnnounce(1241100, 2, nil, "Tank|Healer")
local warnSoulfireConvergence						= mod:NewTargetNoFilterAnnounce(1225616, 2)

local specWarnSoulfrayAnnihilation					= mod:NewSpecialWarningYouCount(1227276, nil, nil, nil, 1, 2)
local yellSoulfrayAnnihilation						= mod:NewShortPosYell(1227276)
local yellSoulfrayAnnihilationFades					= mod:NewIconFadesYell(1227276)
local specWarnMysticLash							= mod:NewSpecialWarningStack(1241100, nil, 10, nil, nil, 1, 6)
local specWarnMysticLashTaunt						= mod:NewSpecialWarningTaunt(1241100, nil, nil, nil, 1, 2)
local specWarnArcaneExpulsion						= mod:NewSpecialWarningCount(1223859, nil, nil, nil, 2, 2)--Is it a dodge or an aoe?
local specWarnSoulfireConvergence					= mod:NewSpecialWarningYou(1225616, nil, nil, nil, 1, 2)
local yellSoulfireConvergence						= mod:NewShortYell(1225616, DBM_COMMON_L.ORBS)
local yellSoulfireConvergenceFades					= mod:NewShortFadesYell(1225616)

--local timerEssenceImplosionCD						= mod:NewAITimer(97.3, 1227848, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerSoulfrayAnnihilationCD					= mod:NewNextCountTimer(97.3, 1227276, nil, nil, nil, 3)
local timerMysticLashCD								= mod:NewNextCountTimer(97.3, 1241100, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArcaneExpulsionCD						= mod:NewNextCountTimer(97.3, 1223859, nil, nil, nil, 2)
local timerSoulfireConvergenceCD					= mod:NewNextCountTimer(97.3, 1225616, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnSoulfrayAnnihilation", 1227276, true, 0, {1, 2})

local castsPerGUID = {}
mod.vb.callingCount = 0
--mod.vb.implosionCount = 0
mod.vb.soulfrayCount = 0
mod.vb.soulfrayIcon = 1
mod.vb.mysticLashCount = 0
mod.vb.arcaneExpulsionCount = 0
mod.vb.convergenceCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.callingCount = 0
--	self.vb.implosionCount = 0
	self.vb.soulfrayCount = 0
	self.vb.soulfrayIcon = 1
	self.vb.mysticLashCount = 0
	self.vb.arcaneExpulsionCount = 0
	self.vb.convergenceCount = 0
	--timerEssenceImplosionCD:Start(1-delay)
	timerMysticLashCD:Start(6-delay, 1)
	timerSoulCallingCD:Start(14-delay, 1)
	timerSoulfrayAnnihilationCD:Start(20-delay, 1)
	timerSoulfireConvergenceCD:Start(30-delay, 1)
	timerArcaneExpulsionCD:Start(42-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1225582 then
		self.vb.callingCount = self.vb.callingCount + 1
		warnSoulCalling:Show(self.vb.callingCount)
		warnSoulCalling:Play("mobsoon")
		timerSoulCallingCD:Start(nil, self.vb.callingCount+1)
	elseif spellId == 1227052 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then--CD still checked since spell is spammed
			specWarnVoidVolley:Show(args.sourceName, count)
			if count < 6 then
				specWarnVoidVolley:Play("kick"..count.."r")
			else
				specWarnVoidVolley:Play("kickcast")
			end
		end
	elseif spellId == 1241100 then
		self.vb.mysticLashCount = self.vb.mysticLashCount + 1
		--"Mystic Lash-1241100-npc:233816-00005FC4A9 = pull:6.0, 40.1, 40.0, 37.9, 32.1, 40.1, 39.9, 38.0, 32.1, 40.1, 40.0, 37.9, 32.1, 40.0, 40.0, 37.9, 32.0",
		local timer = self.vb.mysticLashCount % 4 == 0 and 32.1 or self.vb.mysticLashCount % 4 == 3 and 37.9 or 39.9
		timerMysticLashCD:Start(timer, self.vb.mysticLashCount+1)
	elseif spellId == 1223859 or spellId == 1242088 then--Regular, Mythic
		self.vb.arcaneExpulsionCount = self.vb.arcaneExpulsionCount + 1
		specWarnArcaneExpulsion:Show(self.vb.arcaneExpulsionCount)
		specWarnArcaneExpulsion:Play("carefly")
		--"Arcane Expulsion-1223859-npc:233816-00005FC4A9 = pull:42.0, 40.0, 64.0, 46.1, 40.0, 64.0, 46.1, 40.0, 64.0, 46.1, 40.0, 64.0",
		local timer = self.vb.arcaneExpulsionCount % 3 == 0 and 46.1 or self.vb.arcaneExpulsionCount % 3 == 2 and 64 or 40
		timerArcaneExpulsionCD:Start(timer, self.vb.arcaneExpulsionCount+1)
	elseif spellId == 1225616 then
		self.vb.convergenceCount = self.vb.convergenceCount + 1
		--"Soulfire Convergence-1225616-npc:233816-00005FC4A9 = pull:30.0, 40.0, 65.0, 45.1, 40.0, 65.0, 45.0, 40.0, 65.0, 45.0, 40.0, 65.0",
		local timer = self.vb.convergenceCount % 3 == 0 and 45 or self.vb.convergenceCount % 3 == 2 and 65 or 40
		timerSoulfireConvergenceCD:Start(timer, self.vb.convergenceCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1227276 then
		self.vb.soulfrayCount = self.vb.soulfrayCount + 1
		self.vb.soulfrayIcon = 1
		--"Soulfray Annihilation-1227276-npc:233816-00005FC4A9 = pull:20.0, 40.0, 40.0, 70.1, 40.0, 40.0, 70.1, 40.0, 40.0, 70.0, 40.0, 40.0",
		local timer = self.vb.soulfrayCount % 3 == 0 and 70 or 40
		timerSoulfrayAnnihilationCD:Start(timer, self.vb.soulfrayCount+1)
	elseif spellId == 1227048 then
		timerVoidbladeAmbushCD:Start(nil, args.sourceGUID)
	--elseif spellId == 1227848 then
	--	self.vb.implosionCount = self.vb.implosionCount + 1
	--	warnEssenceImplosion:Show(self.vb.implosionCount)
	--	timerEssenceImplosionCD:Start(nil, self.vb.implosionCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1227049 then
		if args:IsPlayer() then
			specWarnVoidbladeAmbush:Show()
			specWarnVoidbladeAmbush:Play("runout")
			yellVoidbladeAmbush:Yell()
			yellVoidbladeAmbushFades:Countdown(spellId)
		end
	elseif spellId == 1227276 then
		local icon = self.vb.soulfrayIcon
		if self.Options.SetIconOnSoulfrayAnnihilation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnSoulfrayAnnihilation:Show(self.vb.soulfrayCount)--self:IconNumToTexture(icon)
			specWarnSoulfrayAnnihilation:Play("targetyou")
			yellSoulfrayAnnihilation:Yell(icon, icon)
			yellSoulfrayAnnihilationFades:Countdown(spellId, nil, icon)
		end
		warnSoulfrayAnnihilation:CombinedShow(0.3, self.vb.soulfrayCount, args.destName)
		self.vb.soulfrayIcon = self.vb.soulfrayIcon + 1
	elseif spellId == 1225626 then
		warnSoulfireConvergence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSoulfireConvergence:Show()
			specWarnSoulfireConvergence:Play("targetyou")
			yellSoulfireConvergence:Yell()
			yellSoulfireConvergenceFades:Countdown(spellId)
		end
	elseif spellId == 1237607 then
		local amount = args.amount or 1
		if amount >= 10 then--placeholder
			if args:IsPlayer() then
				specWarnMysticLash:Show(amount)
				specWarnMysticLash:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnMysticLashTaunt:Show(args.destName)
					specWarnMysticLashTaunt:Play("tauntboss")
				end
			end
		else
			warnMysticLash:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1227049 then
		if args:IsPlayer() then
			yellVoidbladeAmbushFades:Cancel()
		end
	elseif spellId == 1227276 then
		if self.Options.SetIconOnSoulfrayAnnihilation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellSoulfrayAnnihilationFades:Cancel()
		end
	elseif spellId == 1225626 then
		if args:IsPlayer() then
			yellSoulfireConvergenceFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--https://www.wowhead.com/ptr-2/npc=237871/unbound-assassin
--https://www.wowhead.com/ptr-2/npc=237897/shadowguard-assassin

--https://www.wowhead.com/ptr-2/npc=237872/unbound-mage
--https://www.wowhead.com/ptr-2/npc=237981/shadowguard-mage

--https://www.wowhead.com/ptr-2/npc=245008/unbound-phaseblade
--https://www.wowhead.com/ptr-2/npc=235808/shadowguard-phaseblade
--https://www.wowhead.com/ptr-2/npc=244922/shadowguard-phaseblade
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 237897 then--Assasssin
		timerVoidbladeAmbushCD:Stop(args.destGUID)
	elseif cid == 237981 then--Mage
		if castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = nil
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
