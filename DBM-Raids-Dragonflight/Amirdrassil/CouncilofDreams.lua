local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2555, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(208363, 208365, 208367)--Urctos, Aerwynn, Pip
mod:SetEncounterID(2728)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 418187 420525 420947 421020 421292 420937 420671 420856 421029 421032 418591 421024",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 420948 423420 421022 425114 421298 418755 420858 421236 418720",
	"SPELL_AURA_APPLIED_DOSE 421022 420858",
	"SPELL_AURA_REMOVED 420948 421298 418755 420858 421236 418720",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 426390",
	"SPELL_PERIODIC_MISSED 426390"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO: see how Dream Tactics on mythic decides which two of the bosses will sync up so timers can be updated/synced when it happens.
--TODO, use cast start event or success/applied event for barreling charge timer?
--TODO, fine tune audio and text alerts for specials when they can be seen better
--TODO, maybe absorb infoframe for https://www.wowhead.com/ptr-2/spell=421031/song-of-the-dragon
--TODO, figure out polybomb, it seems like a private and non private at same time
--TODO, maybe do more with Polymorph Bomb stuff like slippery tracking. Again it might be infoframe stuff. But if people make WAs for it probably won't
--TODO, GUID based timers once real timers, for full nameplate aura support
--T
--General
local warnRebirth									= mod:NewCastAnnounce(418187, 4)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(426390, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Urctos
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27300))
local warnBarrelingCharge							= mod:NewTargetCountAnnounce(420948, 3, nil, nil, nil, nil, nil, nil, true)
local warnAgonizingClaws							= mod:NewStackAnnounce(421020, 2, nil, "Tank|Healer")
local warnUrsineRage								= mod:NewSpellAnnounce(425114, 4)--You done fucked up

local specWarnBlindingRage							= mod:NewSpecialWarningCount(420525, nil, nil, nil, 2, 2)
local specWarnBarrelingCharge						= mod:NewSpecialWarningYouCount(420948, nil, nil, nil, 1, 2)
local yellBarrelingCharge							= mod:NewShortYell(420948)
local yellBarrelingChargeFades						= mod:NewShortFadesYell(420948)
local specWarnTrampled								= mod:NewSpecialWarningTaunt(423420, nil, nil, nil, 1, 2)--Not grouped on purpose, so that it stays on diff WA key in GUI
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

--local timerSinseekerCD							= mod:NewAITimer(49, 335114, nil, nil, nil, 3)
local timerBlindingRageCD							= mod:NewAITimer(11.8, 420525, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBlindingRage								= mod:NewBuffActiveTimer(15, 420525, nil, nil, nil, 5)
local timerBarrelingChargeCD						= mod:NewAITimer(11.8, 420948, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tank focused, but soaked by everyone so it's on for everyone
local timerAgonizingClawsCD							= mod:NewAITimer(11.8, 421020, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Aerwynn
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27301))
local warnRelentlessBarrage							= mod:NewSpellAnnounce(420937, 4)--You done fucked up
local warnNoxiousBlossom							= mod:NewCountAnnounce(420937, 3)
local warnPoisonousJavelin							= mod:NewTargetCountAnnounce(420856, 3)--, nil, nil, nil, nil, nil, nil, true

local specWarnConstrictingThicket					= mod:NewSpecialWarningCount(421292, nil, nil, nil, 2, 2)
local specWarnPoisonousJavelin						= mod:NewSpecialWarningMoveAway(420856, nil, nil, nil, 1, 2)
local yellPoisonousJavelin							= mod:NewShortYell(420856, nil, false)
local yellPoisonousJavelinFades						= mod:NewShortFadesYell(420856)--For unstable Venom

local timerConstrictingThicketCD					= mod:NewAITimer(11.8, 421292, nil, nil, nil, 2)
local timerConstrictingThicket						= mod:NewBuffActiveTimer(15, 421292, nil, nil, nil, 5)
local timerNoxiousBlossomCD							= mod:NewAITimer(11.8, 420671, nil, nil, nil, 3)
local timerPoisonousJavelinCD						= mod:NewAITimer(11.8, 420856, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)

--Pip
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27302))
local warnCaptivatingFinale							= mod:NewSpellAnnounce(421029, 4)--You done fucked up
local warnPolymorphBomb								= mod:NewIncomingCountAnnounce(418591, 2)
local warnPolymorphBombTargets						= mod:NewTargetCountAnnounce(418591, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnSongoftheDragon						= mod:NewSpecialWarningCount(421029, nil, nil, nil, 2, 2)
local specWarnPolymorphBomb							= mod:NewSpecialWarningYou(418591, nil, nil, nil, 1, 2)
local yellPolymorphBomb								= mod:NewShortPosYell(418591)
local yellPolymorphBombFades						= mod:NewIconFadesYell(418591)
local specWarnEmeraldWinds							= mod:NewSpecialWarningCount(421024, nil, nil, nil, 2, 13)

local timerSongoftheDragonCD						= mod:NewAITimer(11.8, 421029, nil, nil, nil, 2)
local timerSongoftheDragon							= mod:NewBuffActiveTimer(20, 421029, nil, nil, nil, 5)
local timerPolymorphBombCD							= mod:NewAITimer(11.8, 418591, nil, nil, nil, 3)
local timerEmeraldWindsCD							= mod:NewAITimer(11.8, 421024, nil, nil, nil, 2)

mod:AddPrivateAuraSoundOption(418589, true, 418591, 1)--Polymorph Bomb
--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnPoly", 418720, true, false, {1, 2, 3, 4})

--Urctos
mod.vb.rageCount = 0
mod.vb.chargeCount = 0
--Aerwynn
mod.vb.vinesCount = 0
mod.vb.blossomCount = 0
mod.vb.javCount = 0
--Pip
mod.vb.songCount = 0
mod.vb.polyCount = 0
mod.vb.polyIcon = 1
mod.vb.windsCount = 0

function mod:OnCombatStart(delay)
	--Urctos
	self.vb.rageCount = 0
	self.vb.chargeCount = 0
	timerBlindingRageCD:Start(1-delay)
	timerBarrelingChargeCD:Start(1-delay)
	timerAgonizingClawsCD:Start(1-delay)
	--Aerwynn
	self.vb.vinesCount = 0
	self.vb.blossomCount = 0
	self.vb.javCount = 0
	timerConstrictingThicketCD:Start(1-delay)
	timerNoxiousBlossomCD:Start(1-delay)
	timerPoisonousJavelinCD:Start(1-delay)
	--Pip
	self.vb.songCount = 0
	self.vb.polyCount = 0
	self.vb.polyIcon = 1
	self.vb.windsCount = 0
	timerSongoftheDragonCD:Start(1-delay)
	timerPolymorphBombCD:Start(1-delay)
	timerEmeraldWindsCD:Start(1-delay)
	self:EnablePrivateAuraSound(418589, "bombyou", 2)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 418187 and self:AntiSpam(3, 1) then
		warnRebirth:Show()
	elseif spellId == 420525 then
		self.vb.rageCount = self.vb.rageCount + 1
		specWarnBlindingRage:Show(self.vb.rageCount)
		specWarnBlindingRage:Play("aesoon")
		timerBlindingRageCD:Start()
	elseif spellId == 420947 then
		timerBarrelingChargeCD:Start()
	elseif spellId == 421020 then
		timerAgonizingClawsCD:Start()
	elseif spellId == 421292 then
		self.vb.vinesCount = self.vb.vinesCount + 1
		specWarnConstrictingThicket:Show(self.vb.vinesCount)
		specWarnConstrictingThicket:Play("aesoon")
		timerConstrictingThicketCD:Start()
	elseif spellId == 420937 then
		warnRelentlessBarrage:Show()
	elseif spellId == 420671 then
		self.vb.blossomCount = self.vb.blossomCount + 1
		warnNoxiousBlossom:Show(self.vb.blossomCount)
		timerNoxiousBlossomCD:Start()
	elseif spellId == 420856 then
		self.vb.javCount = self.vb.javCount + 1
		timerPoisonousJavelinCD:Start()
	elseif spellId == 421029 then
		self.vb.songCount = self.vb.songCount + 1
		specWarnSongoftheDragon:Show(self.vb.songCount)
		specWarnSongoftheDragon:Play("takedamage")
		timerSongoftheDragonCD:Start()
	elseif spellId == 421032 then
		warnCaptivatingFinale:Show()
	elseif spellId == 418591 then
		self.vb.polyIcon = 1
		self.vb.polyCount = self.vb.polyCount + 1
		warnPolymorphBomb:Show(self.vb.polyCount)
		timerPolymorphBombCD:Start()
	elseif spellId == 421024 then
		self.vb.windsCount = self.vb.windsCount + 1
		specWarnEmeraldWinds:Show(self.vb.windsCount)
		specWarnEmeraldWinds:Play("pushbackincoming")
		timerEmeraldWindsCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420948 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		if args:IsPlayer() then
			specWarnBarrelingCharge:Show(self.vb.chargeCount)
			specWarnBarrelingCharge:Play("chargemove")
			yellBarrelingCharge:Yell()
			yellBarrelingChargeFades:Countdown(spellId)
		else
			warnBarrelingCharge:Show(self.vb.chargeCount, args.destName)
		end
	elseif spellId == 423420 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--May be unnessesary, but precaution for a drycode, remove later
				specWarnTrampled:Show(args.destName)
				specWarnTrampled:Play("tauntboss")
			end
		end
	elseif spellId == 421022 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
--			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--			local remaining
--			if expireTime then
--				remaining = expireTime-GetTime()
--			end
--			local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 376279, self.vb.slamCount+1) or 17.9) - 5
--			if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--				specWarnConcussiveSlamTaunt:Show(args.destName)
--				specWarnConcussiveSlamTaunt:Play("tauntboss")
--			else
				warnAgonizingClaws:Show(args.destName, amount)
--			end
		end
	elseif spellId == 425114 then
		warnUrsineRage:Show()
	elseif spellId == 421298 then
		timerConstrictingThicket:Start()
	elseif spellId == 418755 then--Weakened Defenses
		timerBlindingRage:Start()
	elseif spellId == 420858 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount == 1 then--only warn on apply not on refresh
				specWarnPoisonousJavelin:Show()
				specWarnPoisonousJavelin:Play("scatter")
				yellPoisonousJavelin:Yell()
			end
			if self:IsHard() then
				yellPoisonousJavelinFades:Cancel()
				yellPoisonousJavelinFades:Countdown(spellId)
			end
		end
		if amount == 1 then
			warnPoisonousJavelin:CombinedShow(0.5, self.vb.javCount, args.destName)
		end
	elseif spellId == 421236 then
		timerSongoftheDragon:Start()
	elseif spellId == 418720 then
		local icon = self.vb.polyIcon
		if icon < 5 then--Only initial, not spreads
			if self.Options.SetIconOnPoly then
				self:SetIcon(args.destName, icon)
			end
			if args:IsPlayer() then
				specWarnPolymorphBomb:Show()
				specWarnPolymorphBomb:Play("targetyou")
				yellPolymorphBomb:Yell(icon, icon)
				yellPolymorphBombFades:Countdown(spellId, nil, icon)
			end
			warnPolymorphBombTargets:CombinedShow(0.5, self.vb.polyCount, args.destName)
		end
		self.vb.polyIcon = self.vb.polyIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 420948 then
		if args:IsPlayer() then
			yellBarrelingChargeFades:Cancel()
		end
	elseif spellId == 421298 then
		timerConstrictingThicket:Stop()
	elseif spellId == 418755 then--Weakened Defenses
		timerBlindingRage:Stop()
	elseif spellId == 420858 then
		if args:IsPlayer() then
			yellPoisonousJavelinFades:Cancel()
		end
	elseif spellId == 421236 then
		timerSongoftheDragon:Stop()
	elseif spellId == 418720 then
		if self.Options.SetIconOnPoly then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellPolymorphBombFades:Cancel()
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 426390 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 then

	end
end
--]]
