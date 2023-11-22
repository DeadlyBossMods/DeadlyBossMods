local mod	= DBM:NewMod(2555, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(208363, 208365, 208367)--Urctos, Aerwynn, Pip
mod:SetEncounterID(2728)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20231122000000)
mod:SetMinSyncRevision(20231122000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 418187 420525 420947 421020 421292 420937 420671 420856 421029 418591 421024",
	"SPELL_CAST_SUCCESS 418757",
	"SPELL_AURA_APPLIED 420948 423420 421022 425114 421298 418755 420858 421236 418720 421032",
	"SPELL_AURA_APPLIED_DOSE 421022 420858",
	"SPELL_AURA_REMOVED 420948 421298 418755 420858 421236 418720 421292 421029 420525",
	"SPELL_PERIODIC_DAMAGE 426390",
	"SPELL_PERIODIC_MISSED 426390"
)

--[[
(ability.id = 418187 or ability.id = 420525 or ability.id = 420947 or ability.id = 421020 or ability.id = 421292 or ability.id = 420937 or ability.id = 420671 or ability.id = 420856 or ability.id = 421029 or ability.id = 418591 or ability.id = 421024) and type = "begincast"
 or ability.id = 418755 or ability.id = 421292 or ability.id = 421029 or ability.id = 420525 or ability.id = 418757 and type = "cast"
--]]
--TODO, fine tune audio and text alerts for specials when they can be seen better
--TODO, maybe absorb infoframe for https://www.wowhead.com/ptr-2/spell=421031/song-of-the-dragon
--TODO, maybe do more with Polymorph Bomb stuff like slippery tracking. Again it might be infoframe stuff. But if people make WAs for it probably won't
--TODO, GUID based timers once real timers, for full nameplate aura support
--General
local warnRebirth									= mod:NewCastAnnounce(418187, 4)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(426390, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Urctos
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27300))
local warnBarrelingCharge							= mod:NewTargetCountAnnounce(420948, 3, nil, nil, 100, nil, nil, nil, true)--Shortname "Charge"
local warnAgonizingClaws							= mod:NewStackAnnounce(421022, 2, nil, "Tank|Healer")
local warnUrsineRage								= mod:NewSpellAnnounce(425114, 4)--You done fucked up

local specWarnBlindingRage							= mod:NewSpecialWarningCount(420525, nil, nil, nil, 2, 2)
local specWarnBarrelingCharge						= mod:NewSpecialWarningYouCount(420948, nil, nil, nil, 1, 2)
local specWarnBarrelingChargeSpecial				= mod:NewSpecialWarningMoveTo(420948, nil, nil, nil, 3, 14)
local yellBarrelingCharge							= mod:NewShortYell(420948, 100)
local yellBarrelingChargeFades						= mod:NewShortFadesYell(420948)
local specWarnTrampled								= mod:NewSpecialWarningTaunt(423420, nil, nil, nil, 1, 2)--Not grouped on purpose, so that it stays on diff WA key in GUI
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

--local timerSinseekerCD							= mod:NewAITimer(49, 335114, nil, nil, nil, 3)
local timerBlindingRageCD							= mod:NewNextCountTimer(200, 420525, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBlindingRage								= mod:NewBuffActiveTimer(15, 420525, nil, nil, nil, 5)
local timerBarrelingChargeCD						= mod:NewCDCountTimer(11.8, 420948, 100, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tank focused, but soaked by everyone so it's on for everyone
local timerAgonizingClawsCD							= mod:NewCDCountTimer(6, 421022, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Aerwynn
local Aerwynn = DBM:EJ_GetSectionInfo(27301)
mod:AddTimerLine(Aerwynn)
local warnRelentlessBarrage							= mod:NewSpellAnnounce(420937, 4)--You done fucked up
local warnNoxiousBlossom							= mod:NewCountAnnounce(420671, 3)
local warnPoisonousJavelin							= mod:NewTargetCountAnnounce(420858, 3, nil, nil, 298110)--, nil, nil, nil, nil, nil, nil, true

local specWarnConstrictingThicket					= mod:NewSpecialWarningCount(421292, nil, nil, nil, 2, 2)
local specWarnPoisonousJavelin						= mod:NewSpecialWarningMoveAway(420858, nil, nil, nil, 1, 2)
local yellPoisonousJavelin							= mod:NewShortYell(420858, 298110, false)
local yellPoisonousJavelinFades						= mod:NewShortFadesYell(420858)--For unstable Venom

local timerConstrictingThicketCD					= mod:NewNextCountTimer(11.8, 421292, nil, nil, nil, 2)
local timerConstrictingThicket						= mod:NewBuffActiveTimer(15, 421292, nil, nil, nil, 5)
local timerNoxiousBlossomCD							= mod:NewCDCountTimer(21, 420671, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3)
local timerPoisonousJavelinCD						= mod:NewCDCountTimer(25, 420858, 298110, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)--Shortname "Javelin

--Pip
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27302))
local warnCaptivatingFinale							= mod:NewTargetNoFilterAnnounce(421032, 4)--You done fucked up
local warnPolymorphBomb								= mod:NewIncomingCountAnnounce(418720, 2)
--local warnPolymorphBombTargets						= mod:NewTargetCountAnnounce(418720, 3, nil, nil, nil, nil, nil, nil, true)--Possible to detect private aura with RAID_BOSS_WHISPER syncs, but yeah...

local specWarnSongoftheDragon						= mod:NewSpecialWarningCount(421029, nil, nil, nil, 2, 2)
local specWarnCaptivatingFinale						= mod:NewSpecialWarningYou(421032, nil, nil, nil, 1, 2)
local yellCaptivatingFinale							= mod:NewShortYell(421032)
local specWarnPolymorphBomb							= mod:NewSpecialWarningYou(418720, nil, nil, nil, 1, 2)
local yellPolymorphBombFades						= mod:NewIconFadesYell(418720)
local specWarnEmeraldWinds							= mod:NewSpecialWarningCount(421024, nil, nil, nil, 2, 13)

local timerSongoftheDragonCD						= mod:NewNextCountTimer(200, 421029, nil, nil, nil, 2)
local timerSongoftheDragon							= mod:NewBuffActiveTimer(20, 421029, nil, nil, nil, 5)
local timerPolymorphBombCD							= mod:NewCDCountTimer(18.9, 418720, L.Ducks, nil, nil, 3)--Ducks already has count in mod localization
local timerEmeraldWindsCD							= mod:NewCDCountTimer(11.8, 421024, DBM_COMMON_L.PUSHBACK.." (%s)", nil, nil, 2)

mod:AddPrivateAuraSoundOption(418589, true, 418591, 1)--Polymorph Bomb
--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnPoly", 418720, true, false, {1, 2, 3, 4})

mod.vb.specialsActive = 0
mod.vb.nextSpecial = 1
mod.vb.chargeSpecial = false
--Urctos
mod.vb.clawsCount = 0
mod.vb.rageCount = 0
mod.vb.rageNext = false
mod.vb.chargeCount = 0
--Aerwynn
mod.vb.vinesCount = 0
mod.vb.vinesNext = false
mod.vb.blossomCount = 0
mod.vb.javCount = 0
--Pip
mod.vb.songCount = 0
mod.vb.songNext = false
mod.vb.polyCount = 0
mod.vb.polyIcon = 1
mod.vb.windsCount = 0
local nextSpecial = 0

local function castBeforeSpecial(self, cooldown)
	--Check syncable timers first, that way this function has disconnect protection, if timers were enabled
	local remainingRage = timerBlindingRageCD:GetRemaining(self.vb.rageCount+1)
	local remainingVines = timerConstrictingThicketCD:GetRemaining(self.vb.vinesCount+1)
	local remainingSong = timerSongoftheDragonCD:GetRemaining(self.vb.songCount+1)
	if (remainingRage > 0) and (remainingRage < cooldown) then
		return false
	elseif (remainingVines > 0) and (remainingVines < cooldown) then
		return false
	elseif (remainingSong > 0) and (remainingSong < cooldown) then
		return false
	--Check local timer caching second in case user turned timers off
	elseif nextSpecial > 0 and (nextSpecial - GetTime() < cooldown) then
		return false
	end
	return true
end

local function specialInterrupted(self, spellId)
	self.vb.specialsActive = self.vb.specialsActive - 1
	--Timers that always reset on special end, regardless of who's special it is
	if self.vb.specialsActive == 0 then
		self.vb.nextSpecial = self.vb.nextSpecial + 1
		self.vb.clawsCount = 0
		self.vb.vinesNext = false
		self.vb.rageNext = false
		self.vb.songNext = false

		if self:IsHard() then
			--Urctos
			timerAgonizingClawsCD:Start(5, 1)
			timerBarrelingChargeCD:Stop()
			timerBarrelingChargeCD:Start(13, self.vb.chargeCount+1)
			--Aerwynn
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(5, self.vb.blossomCount+1)--Even though this one can be cast during specials, it restarts when specials end
			timerPoisonousJavelinCD:Start(21, self.vb.javCount+1)
			--Pip
			timerPolymorphBombCD:Stop()
			timerPolymorphBombCD:Start(16, self.vb.polyCount+1)
			timerEmeraldWindsCD:Start(43, self.vb.windsCount+1)
		else
			--Urctos
			timerAgonizingClawsCD:Start(8, 1)
			timerBarrelingChargeCD:Stop()
			timerBarrelingChargeCD:Start(29, self.vb.chargeCount+1)
			--Aerwynn
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(11, self.vb.blossomCount+1)--Even though this one can be cast during specials, it restarts when specials end
			timerPoisonousJavelinCD:Start(20, self.vb.javCount+1)
			--Pip
			timerPolymorphBombCD:Stop()
			timerPolymorphBombCD:Start(16, self.vb.polyCount+1)
			timerEmeraldWindsCD:Start(45.5, self.vb.windsCount+1)
		end
		DBM:Debug("All specials have ended, restarting all non special timers")

		nextSpecial = GetTime() + 56
		if self:IsMythic() then
			--Hard coded rotation for mythic
			if self.vb.nextSpecial % 3 == 2 or self.vb.nextSpecial % 3 == 1 then -- 1, 2
				timerConstrictingThicketCD:Start(56, self.vb.vinesCount+1)
				self.vb.vinesNext = true
			end
			if self.vb.nextSpecial % 3 == 2 or self.vb.nextSpecial % 3 == 0 then -- 2, 3
				timerSongoftheDragonCD:Start(56, self.vb.songCount+1)
				self.vb.songNext = true
			end
			if self.vb.nextSpecial % 3 == 0 or self.vb.nextSpecial % 3 == 1 then -- 1, 3
				timerBlindingRageCD:Start(56, self.vb.rageCount+1)
				self.vb.rageNext = true
			end
		else
			--Standard order rotation for non mythic
			if spellId == 418757 then--blinding rage interrupted
				self.vb.vinesNext = true
				timerConstrictingThicketCD:Start(56, self.vb.vinesCount+1)
			elseif spellId == 421292 then--Constricting Thicket interrupted
				timerSongoftheDragonCD:Start(56, self.vb.songCount+1)
				self.vb.songNext = true
			else--Song of dragon interrupted
				timerBlindingRageCD:Start(56, self.vb.rageCount+1)
				self.vb.rageNext = true
			end
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.specialsActive = 0
	--Urctos
	self.vb.clawsCount = 0
	self.vb.rageCount = 0
	self.vb.rageNext = true
	self.vb.chargeCount = 0
	if self:IsHard() then
		--Urctos
		timerAgonizingClawsCD:Start(4.9-delay, 1)
		timerBarrelingChargeCD:Start(12.9-delay, 1)
		timerBlindingRageCD:Start(55.8-delay, 1)
		--Aerwynn
		timerNoxiousBlossomCD:Start(4.9-delay, 1)
		timerPoisonousJavelinCD:Start(21-delay, 1)
		--Pip
		timerPolymorphBombCD:Start(36-delay, 1)
		timerEmeraldWindsCD:Start(42.9-delay, 1)
	else
		--Urctos
		timerAgonizingClawsCD:Start(7.9-delay, 1)
		timerBarrelingChargeCD:Start(28.9-delay, 1)
		timerBlindingRageCD:Start(55.8-delay, 1)
		--Aerwynn
		timerNoxiousBlossomCD:Start(10.9-delay, 1)
		timerPoisonousJavelinCD:Start(19.9)
		--Pip
		timerPolymorphBombCD:Start(34.9-delay, 1)
		timerEmeraldWindsCD:Start(45-delay, 1)
	end

	--Aerwynn
	self.vb.vinesCount = 0
	self.vb.vinesNext = self:IsMythic() and true or false
	self.vb.blossomCount = 0
	self.vb.javCount = 0
	--Pip
	self.vb.songCount = 0
	self.vb.songNext = false
	self.vb.polyCount = 0
	self.vb.polyIcon = 1
	self.vb.windsCount = 0
	self:EnablePrivateAuraSound(418589, "bombyou", 2)
	self:EnablePrivateAuraSound(429123, "bombyou", 2, 418589)--Register secondary private aura (different ID for differentn difficulty?)
	nextSpecial = GetTime() + 55.8
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
		self.vb.specialsActive = self.vb.specialsActive + 1
		self.vb.rageCount = self.vb.rageCount + 1
		specWarnBlindingRage:Show(self.vb.rageCount)
		specWarnBlindingRage:Play("aesoon")
		--Timers that specifically reset on blind rage begin
		timerNoxiousBlossomCD:Stop()
		timerPolymorphBombCD:Stop()
		if self:IsHard() then
			timerPolymorphBombCD:Start(7, self.vb.polyCount+1)--Technically it's for the 2nd cast, first cast one event before this cast
			timerNoxiousBlossomCD:Start(9, self.vb.blossomCount+1)
		else
			timerNoxiousBlossomCD:Start(7, self.vb.blossomCount+1)
			timerPolymorphBombCD:Start(9, self.vb.polyCount+1)--Technically it's for the 2nd cast, first cast one event before this cast
		end
		DBM:Debug("Starting second polymorph blinding rage timer, in case first happened before blinding rage")
	elseif spellId == 420947 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		--No specials active, normal behavior
		if self.vb.specialsActive == 0 then
			if castBeforeSpecial(self, 25) then
				timerBarrelingChargeCD:Start(20, self.vb.chargeCount+1)
			elseif self.vb.vinesNext then--If next special is soon, and it is vines, schedule a 3rd charge timer that overlaps with vines
				timerBarrelingChargeCD:Start(self:IsEasy() and 30 or 26, self.vb.chargeCount+1)
			end
		else
			--Cast during a special, it has to be constricting and it'll loop in 8 seconds
			timerBarrelingChargeCD:Start(8, self.vb.chargeCount+1)
		end
	elseif spellId == 421020 then
		self.vb.clawsCount = self.vb.clawsCount + 1
		--8, 6, 25, 6 (LFR and normal)
		--5, 4, 16, 4 (heroic and mythic)
		if self.vb.clawsCount % 2 == 1 then--1 and 3
			timerAgonizingClawsCD:Start(self:IsEasy() and 6 or 4, self.vb.clawsCount+1)
		elseif self.vb.clawsCount == 2 then
			timerAgonizingClawsCD:Start(self:IsEasy() and 25 or 16, self.vb.clawsCount+1)
		end
	elseif spellId == 421292 then
		self.vb.specialsActive = self.vb.specialsActive + 1
		self.vb.chargeSpecial = true
		self.vb.vinesCount = self.vb.vinesCount + 1
		specWarnConstrictingThicket:Show(self.vb.vinesCount)
		specWarnConstrictingThicket:Play("aesoon")
		--Timers that specifically reset on constricting begin
--		timerBarrelingChargeCD:Restart(3, self.vb.chargeCount+1)--Done somewhere else to start earlier, but this technically where it happens
	elseif spellId == 420937 then
		warnRelentlessBarrage:Show()
	elseif spellId == 420671 then
		self.vb.blossomCount = self.vb.blossomCount + 1
		warnNoxiousBlossom:Show(self.vb.blossomCount)
		if self.vb.specialsActive == 0 then
			--Is cast during specials, but Cd resets during them, twice, once on special begin and once again on special end
			if castBeforeSpecial(self, 35) then--Extra large used cause there is a large gap between 2nd cast and specials now.
				timerNoxiousBlossomCD:Start(self:IsEasy() and 22 or 20.7, self.vb.blossomCount+1)
			elseif self.vb.rageNext and castBeforeSpecial(self, 20) then
				if self:IsMythic() then
					if self.vb.vinesNext then
						timerNoxiousBlossomCD:Start(27, self.vb.blossomCount+1)
					end
				else
					timerNoxiousBlossomCD:Start(21, self.vb.blossomCount+1)
				end
			end
		end
	elseif spellId == 420856 then
		self.vb.javCount = self.vb.javCount + 1
		if castBeforeSpecial(self, 25) then
			timerPoisonousJavelinCD:Start(25, self.vb.javCount+1)
		end
	elseif spellId == 421029 then
		self.vb.specialsActive = self.vb.specialsActive + 1
		self.vb.songCount = self.vb.songCount + 1
		specWarnSongoftheDragon:Show(self.vb.songCount)
		specWarnSongoftheDragon:Play("takedamage")
		--Timers that specifically reset on song begin
		if not self:IsMythic() then--Review further. It definitely still happens on normal though
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(2.9, self.vb.blossomCount+1)
		end
	elseif spellId == 418591 then
		self.vb.polyIcon = 1
		self.vb.polyCount = self.vb.polyCount + 1
		warnPolymorphBomb:Show(self.vb.polyCount)
		--If cast during special, it's blinding rage and we need the 9 second loop
		if self.vb.specialsActive > 0 then
			timerPolymorphBombCD:Start(9, self.vb.polyCount+1)
			DBM:Debug("Starting during special polymorph CD")
		else
			if castBeforeSpecial(self, 25) then
				--Normal cd behavior, no specials locking it out, start it's reg cd
				timerPolymorphBombCD:Start(20, self.vb.polyCount+1)
				DBM:Debug("Starting Regular polymorph CD")
			else
				--Specials are soon, now we just need to see if that soon special is blind and if it is, create the "3rd bomb" timer that syncs to blind
				--But only if pip won't also be busy also casting their special (mythic)
				local remainingSpecial = nextSpecial - GetTime()
				if not self.vb.songNext and self.vb.rageNext and remainingSpecial < 25 then
					local adjust = self:IsMythic() and 1.5 or 0--Mythic seems to sync it but then roll it back 1.5
					timerPolymorphBombCD:Start(remainingSpecial-adjust, self.vb.polyCount+1)
					DBM:Debug("Starting Blinding rage synced polymorph CD")
				end
			end
		end
	elseif spellId == 421024 then
		self.vb.windsCount = self.vb.windsCount + 1
		specWarnEmeraldWinds:Show(self.vb.windsCount)
		specWarnEmeraldWinds:Play("pushbackincoming")
		--timerEmeraldWindsCD:Start(timer, self.vb.windsCount+1)--NEver started here
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 418757 then--PolyMorph Bomb Cast on Urctos
		timerBlindingRage:Stop()
		timerPolymorphBombCD:Stop()--cancel the recast timers
		timerNoxiousBlossomCD:Stop()--cancel the recast timers
		specialInterrupted(self, spellId)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420948 then
		if args:IsPlayer() then
			if self.vb.chargeSpecial then
				specWarnBarrelingChargeSpecial:Show(Aerwynn)
				specWarnBarrelingChargeSpecial:Play("movetoboss")
			else
				specWarnBarrelingCharge:Show(self.vb.chargeCount)
				specWarnBarrelingCharge:Play("chargemove")
			end
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
			if self:IsMythic() then
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
				yellPolymorphBombFades:Countdown(spellId, nil, icon)
			end
		end
		self.vb.polyIcon = self.vb.polyIcon + 1
	elseif spellId == 421032 then
		warnCaptivatingFinale:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCaptivatingFinale:Show()
			specWarnCaptivatingFinale:Play("targetyou")
			yellCaptivatingFinale:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


--ability.id = 418755 or ability.id = 421292 or ability.id = 421029
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 420948 then
		if args:IsPlayer() then
			yellBarrelingChargeFades:Cancel()
		end
	elseif spellId == 421298 then
		timerConstrictingThicket:Stop()
	elseif spellId == 421292 or spellId == 421029 then--Constricting Thicket, Song of the Dragon
		if spellId == 421292 then
			self.vb.chargeSpecial = false
			timerBarrelingChargeCD:Stop()--cancel the recast timers
		end
		specialInterrupted(self, spellId)
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
