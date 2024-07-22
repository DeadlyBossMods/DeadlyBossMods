local mod	= DBM:NewMod(2555, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(208363, 208365, 208367)--Urctos, Aerwynn, Pip
mod:SetEncounterID(2728)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20240223000000)
mod:SetMinSyncRevision(20240223000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 418187 420525 420947 421020 421292 420937 420671 420856 421029 418591 421024",
	"SPELL_CAST_SUCCESS 418757",
	"SPELL_AURA_APPLIED 420948 421022 425114 421298 418755 420858 421236 418720 421032 421031 421029",
	"SPELL_AURA_APPLIED_DOSE 421022 420858",
	"SPELL_AURA_REMOVED 420948 421298 418755 420858 421236 418720 421292 421029 420525 421031",
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
local warnAgonizingClaws							= mod:NewStackAnnounce(421022, 2, nil, "Tank|Healer")
local warnUrsineRage								= mod:NewSpellAnnounce(425114, 4)--You done fucked up

local specWarnBlindingRage							= mod:NewSpecialWarningCount(420525, nil, nil, nil, 2, 2)
local specWarnBarrelingCharge						= mod:NewSpecialWarningCount(420948, nil, nil, nil, 1, 14)
local specWarnBarrelingChargeSpecial				= mod:NewSpecialWarningMoveTo(420948, nil, nil, nil, 3, 14)
local yellBarrelingCharge							= mod:NewShortYell(420948, 100, nil, nil, "YELL")
local yellBarrelingChargeFades						= mod:NewShortFadesYell(420948, nil, nil, nil, "YELL")
local specWarnAgonizingClaws						= mod:NewSpecialWarningTaunt(421022, nil, nil, 2, 1, 2)
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
--local warnPolymorphBombTargets						= mod:NewTargetCountAnnounce(418720, 3, nil, nil, nil, nil, nil, nil, true)--Blizzard finally fixed RBW detection, but maybe they'll unprivate in season 4?
local warnSongFaded									= mod:NewFadesAnnounce(421029, 1)

local specWarnSongoftheDragon						= mod:NewSpecialWarningMoveTo(421029, nil, nil, nil, 2, 2)
local specWarnCaptivatingFinale						= mod:NewSpecialWarningYou(421032, nil, nil, nil, 1, 2)
local yellCaptivatingFinale							= mod:NewShortYell(421032)
local specWarnPolymorphBomb							= mod:NewSpecialWarningYou(418720, nil, nil, nil, 1, 2)
local yellPolymorphBombFades						= mod:NewIconFadesYell(418720)
local specWarnEmeraldWinds							= mod:NewSpecialWarningCount(421024, nil, nil, nil, 2, 13)

local timerSongoftheDragonCD						= mod:NewNextCountTimer(200, 421029, nil, nil, nil, 2)
local timerSongoftheDragon							= mod:NewBuffActiveTimer(20, 421029, nil, nil, nil, 5)
local timerPolymorphBombCD							= mod:NewCDCountTimer(18.9, 418720, L.Ducks, nil, nil, 3)--Ducks already has count in mod localization
local timerEmeraldWindsCD							= mod:NewCDCountTimer(11.8, 421024, DBM_COMMON_L.PUSHBACK.." (%s)", nil, nil, 2)

mod:AddPrivateAuraSoundOption(418589, true, 418720, 1)--Polymorph Bomb
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnPoly", 418720, true, 0, {1, 2, 3, 4})

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
local playerSong = false

---@param self DBMMod
local function castBeforeSpecial(self, cooldown)
	if (nextSpecial - GetTime()) > cooldown then
		return true
	end
	return false
end

---@param self DBMMod
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
			timerPolymorphBombCD:Start(15.3, self.vb.polyCount+1)
			timerEmeraldWindsCD:Start(43, self.vb.windsCount+1)
		elseif self:IsNormal() then
			--Urctos
			timerAgonizingClawsCD:Start(8, 1)
			timerBarrelingChargeCD:Stop()
			timerBarrelingChargeCD:Start(29, self.vb.chargeCount+1)
			--Aerwynn
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(10.3, self.vb.blossomCount+1)--Even though this one can be cast during specials, it restarts when specials end
			timerPoisonousJavelinCD:Start(20, self.vb.javCount+1)
			--Pip
			timerPolymorphBombCD:Stop()
			timerPolymorphBombCD:Start(16, self.vb.polyCount+1)
			timerEmeraldWindsCD:Start(45.5, self.vb.windsCount+1)
		else--LFR
			--Urctos
			timerAgonizingClawsCD:Start(10.6, 1)
			timerBarrelingChargeCD:Stop()
			timerBarrelingChargeCD:Start(38.6, self.vb.chargeCount+1)
			--Aerwynn
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(14.6, self.vb.blossomCount+1)--Even though this one can be cast during specials, it restarts when specials end
			timerPoisonousJavelinCD:Start(26.6, self.vb.javCount+1)
			--Pip
			timerPolymorphBombCD:Stop()
			timerPolymorphBombCD:Start(21.3, self.vb.polyCount+1)
			timerEmeraldWindsCD:Start(60.1, self.vb.windsCount+1)
		end
		DBM:Debug("All specials have ended, restarting all non special timers")

		local specialTimer = self:IsLFR() and 74.6 or 56
		nextSpecial = GetTime() + specialTimer
		if self:IsMythic() then
			--Hard coded rotation for mythic
			if self.vb.nextSpecial % 3 == 2 or self.vb.nextSpecial % 3 == 1 then -- 1, 2
				timerConstrictingThicketCD:Start(specialTimer, self.vb.vinesCount+1)
				self.vb.vinesNext = true
			end
			if self.vb.nextSpecial % 3 == 2 or self.vb.nextSpecial % 3 == 0 then -- 2, 3
				timerSongoftheDragonCD:Start(specialTimer, self.vb.songCount+1)
				self.vb.songNext = true
			end
			if self.vb.nextSpecial % 3 == 0 or self.vb.nextSpecial % 3 == 1 then -- 1, 3
				timerBlindingRageCD:Start(specialTimer, self.vb.rageCount+1)
				self.vb.rageNext = true
			end
		else
			--Standard order rotation for non mythic
			if spellId == 418757 then--blinding rage interrupted
				self.vb.vinesNext = true
				timerConstrictingThicketCD:Start(specialTimer, self.vb.vinesCount+1)
			elseif spellId == 421292 then--Constricting Thicket interrupted
				timerSongoftheDragonCD:Start(specialTimer, self.vb.songCount+1)
				self.vb.songNext = true
			else--Song of dragon interrupted
				timerBlindingRageCD:Start(specialTimer, self.vb.rageCount+1)
				self.vb.rageNext = true
			end
		end
	end
end

local function checkSong()
	if playerSong and not DBM:UnitDebuff("player", 418720) then--Still have it, warn again
		specWarnSongoftheDragon:Show(DBM_COMMON_L.POOL)
		specWarnSongoftheDragon:Play("takedamage")
	end
end

function mod:OnCombatStart(delay)
	self.vb.specialsActive = 0
	--Urctos
	self.vb.clawsCount = 0
	self.vb.rageCount = 0
	self.vb.rageNext = true
	self.vb.chargeCount = 0
	self.vb.nextSpecial = 1
	if self:IsHard() then
		--Urctos
		timerAgonizingClawsCD:Start(4.9-delay, 1)
		timerBarrelingChargeCD:Start(12.9-delay, 1)
		timerBlindingRageCD:Start(55.8-delay, 1)
		--Aerwynn
		timerNoxiousBlossomCD:Start(4.9-delay, 1)
		timerPoisonousJavelinCD:Start(21-delay, 1)
		if self:IsMythic() then
			timerConstrictingThicketCD:Start(55.8, 1)
		end
		--Pip
		timerPolymorphBombCD:Start(36-delay, 1)
		timerEmeraldWindsCD:Start(42.9-delay, 1)
	elseif self:IsNormal() then
		--Urctos
		timerAgonizingClawsCD:Start(7.9-delay, 1)
		timerBarrelingChargeCD:Start(28.9-delay, 1)
		timerBlindingRageCD:Start(55.8-delay, 1)
		--Aerwynn
		timerNoxiousBlossomCD:Start(10.9-delay, 1)
		timerPoisonousJavelinCD:Start(19.9, 1)
		--Pip
		timerPolymorphBombCD:Start(34.9-delay, 1)
		timerEmeraldWindsCD:Start(45-delay, 1)
	else--LFR has to be a special snowflake
		--Urctos
		timerAgonizingClawsCD:Start(10.6-delay, 1)
		timerBarrelingChargeCD:Start(38.6-delay, 1)
		timerBlindingRageCD:Start(74.6-delay, 1)
		--Aerwynn
		timerNoxiousBlossomCD:Start(14.6-delay, 1)
		timerPoisonousJavelinCD:Start(26.6, 1)
		--Pip
		timerPolymorphBombCD:Start(46.6-delay, 1)
		timerEmeraldWindsCD:Start(60-delay, 1)
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
	nextSpecial = GetTime() + (self:IsLFR() and 74.6 or 55.8)
end

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
		elseif self:IsNormal() then
			timerNoxiousBlossomCD:Start(7, self.vb.blossomCount+1)
			timerPolymorphBombCD:Start(9, self.vb.polyCount+1)--Technically it's for the 2nd cast, first cast one event before this cast
		else--LFR
			timerPolymorphBombCD:Start(7.9, self.vb.polyCount+1)--Technically it's for the 2nd cast, first cast one event before this cast
		end
		DBM:Debug("Starting second polymorph blinding rage timer, in case first happened before blinding rage")
	elseif spellId == 420947 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		--No specials active, normal behavior
		if self.vb.specialsActive == 0 then
			if not self:IsEasy() and castBeforeSpecial(self, 25) then--Only cast twice per cycle on heroic and mythic
				timerBarrelingChargeCD:Start(20, self.vb.chargeCount+1)
			elseif self.vb.vinesNext then--If next special is soon, and it is vines, schedule a 2nd (easy) or 3rd (hard) charge timer that overlaps with vines
				timerBarrelingChargeCD:Start(self:IsLFR() and 39.9 or self:IsNormal() and 30 or 26, self.vb.chargeCount+1)
			end
		else
			--Cast during a special, it has to be constricting and it'll loop in 8 seconds
			timerBarrelingChargeCD:Start(8, self.vb.chargeCount+1)
		end
	elseif spellId == 421020 then
		self.vb.clawsCount = self.vb.clawsCount + 1
		--8, 6, 25, 6 (normal)
		--5, 4, 16, 4 (heroic and mythic)
		--10.6, 8, 33.3, 8 (LFR)
		if self.vb.clawsCount % 2 == 1 then--1 and 3
			timerAgonizingClawsCD:Start(self:IsLFR() and 8 or self:IsNormal() and 6 or 4, self.vb.clawsCount+1)
		elseif self.vb.clawsCount == 2 then
			timerAgonizingClawsCD:Start(self:IsLFR() and 33.3 or self:IsNormal() and 25 or 16, self.vb.clawsCount+1)
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
				timerNoxiousBlossomCD:Start(self:IsLFR() and 29.3 or self:IsNormal() and 22 or 20, self.vb.blossomCount+1)
			elseif self.vb.rageNext and castBeforeSpecial(self, 20) then
				if self:IsMythic() then
					if self.vb.vinesNext then
						timerNoxiousBlossomCD:Start(27, self.vb.blossomCount+1)
					end
				elseif not self:IsLFR() then--Doesn't happen in LFR?
					timerNoxiousBlossomCD:Start(21, self.vb.blossomCount+1)
				end
			end
		else
			if self.vb.songNext then--technically active not next
				timerNoxiousBlossomCD:Start(10, self.vb.blossomCount+1)
			end
		end
	elseif spellId == 420856 then
		self.vb.javCount = self.vb.javCount + 1
		if castBeforeSpecial(self, 25) then
			timerPoisonousJavelinCD:Start(self:IsLFR() and 33.3 or 25, self.vb.javCount+1)
		end
	elseif spellId == 421029 then
		self.vb.songCount = self.vb.songCount + 1
		--Timers that specifically reset on song begin
		if not self:IsMythic() then--Review further. It definitely still happens on normal though
			timerNoxiousBlossomCD:Stop()
			timerNoxiousBlossomCD:Start(self:IsLFR() and 3.9 or 2.9, self.vb.blossomCount+1)
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
			if castBeforeSpecial(self, self:IsLFR() and 30 or 25) then
				--Normal cd behavior, no specials locking it out, start it's reg cd
				timerPolymorphBombCD:Start(self:IsLFR() and 25 or 20, self.vb.polyCount+1)
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
			if self.vb.chargeSpecial then--Special activate that needs interrupting by charge
				specWarnBarrelingChargeSpecial:Show(Aerwynn)
				specWarnBarrelingChargeSpecial:Play("movetoboss")
			else
				specWarnBarrelingCharge:Show(self.vb.chargeCount)
				specWarnBarrelingCharge:Play("targetyou")
			end
			yellBarrelingCharge:Yell()
			yellBarrelingChargeFades:Countdown(spellId)
		else
			specWarnBarrelingCharge:Show(self.vb.chargeCount)
			if DBM:UnitDebuff("player", 423420) then--Can't soak, need to avoid
				specWarnBarrelingCharge:Play("chargemove")
			elseif not self:IsEasy() then--Alternating soaks on heroic/mythic
				if self.vb.chargeCount % 2 == 0 then
					specWarnBarrelingCharge:Play("sharetwo")
				else
					specWarnBarrelingCharge:Play("shareone")
				end
			else--LFR/Normal (single soak group)
				specWarnBarrelingCharge:Play("helpsoak")
			end
		end
	elseif spellId == 421022 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if self.Options.SpecWarn421022taunt2 and not args:IsPlayer() then
				if self.vb.clawsCount % 2 == 1 then--1 and 3
					specWarnAgonizingClaws:Show(args.destName)
					specWarnAgonizingClaws:Play("tauntboss")
				else--Claws 2 and 4 need additional safety check to avoid getting hit by extra damage charge
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", 423420)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					--Don't taunt if charge is incoming and you can't take it cause you'll still have debuff
					local timerLeft = timerBarrelingChargeCD:GetRemaining(self.vb.chargeCount+1) or 20
					if (not remaining or remaining and remaining < timerLeft) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
						specWarnAgonizingClaws:Show(args.destName)
						specWarnAgonizingClaws:Play("tauntboss")
					else
						warnAgonizingClaws:Show(args.destName, amount)
					end
				end
			else
				warnAgonizingClaws:Show(args.destName, amount)
			end
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
	elseif spellId == 421031 and args:IsPlayer() then
		playerSong = true
		if not DBM:UnitDebuff("player", 418720) then
			specWarnSongoftheDragon:Show(DBM_COMMON_L.POOL)
			specWarnSongoftheDragon:Play("takedamage")
		end
		self:Schedule(6, checkSong, self)--Schedule 2nd warning half way through debuff
	elseif spellId == 421029 then
		--Song isn't active until buff goes up, so if you interrupt bear SUPER fast, you can early terminate a combo on mythic
		--Log referencing bug behavior if
		--https://www.warcraftlogs.com/reports/MV98mgGfX4yPYQHr#fight=last&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20418187%20or%20ability.id%20%3D%20420525%20or%20ability.id%20%3D%20420947%20or%20ability.id%20%3D%20421020%20or%20ability.id%20%3D%20421292%20or%20ability.id%20%3D%20420937%20or%20ability.id%20%3D%20420671%20or%20ability.id%20%3D%20420856%20or%20ability.id%20%3D%20421029%20or%20ability.id%20%3D%20418591%20or%20ability.id%20%3D%20421024)%20and%20type%20%3D%20%22begincast%22%20%20or%20ability.id%20%3D%20418755%20or%20ability.id%20%3D%20421292%20or%20ability.id%20%3D%20421029%20or%20ability.id%20%3D%20420525%20or%20ability.id%20%3D%20418757%20and%20type%20%3D%20%22cast%22&view=events
		--So don't intecfremnt specials active count if we recently ended a special phase early due to above bug
		--Song is never cast first, specials active should always be 1 unless SUPER early bear interrupt
		if self:IsMythic() and self.vb.specialsActive == 0 and castBeforeSpecial(self, 50) then
			DBM:ShowTestSpecialWarning("Special phase terminated early due to blizzard bug!", 3, nil, true)
		else
			self.vb.specialsActive = self.vb.specialsActive + 1
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
		else
			--Only show taunt warning after charge, if the tank who took charge would die to claws 3
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local _, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 421022)--Claws debuff
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				local timerLeft = timerAgonizingClawsCD:GetRemaining(self.vb.clawsCount+1) or 20
				--Claws debuff wont' be gone yet off other tank, so you need to take it
				if (remaining and remaining > timerLeft) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnAgonizingClaws:Show(args.destName)
					specWarnAgonizingClaws:Play("tauntboss")
				end
			end
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
	elseif spellId == 421031 and args:IsPlayer() then
		playerSong = false
		warnSongFaded:Show()
		self:Unschedule(checkSong)
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 426390 and destGUID == UnitGUID("player") and not playerSong and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
