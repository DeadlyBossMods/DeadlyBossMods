local mod	= DBM:NewMod(2443, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176523)
mod:SetEncounterID(2430)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(20211012000000)--2021-10-12
mod:SetMinSyncRevision(20211213000000)--2021-12-13
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 357735",
	"SPELL_CAST_SUCCESS 348508 355568 355778 355504",
	"SPELL_SUMMON 355536",
	"SPELL_AURA_APPLIED 348508 355568 355778 348456 355505 355525 352052",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 348508 355568 355778 348456 355505 355506 355525",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO,
--https://ptr.wowhead.com/spells/uncategorized/name:spike?filter=21;2;90100
--[[
ability.id = 357735 and type = "begincast"
 or (ability.id = 348508 or ability.id = 355568 or ability.id = 355778 or ability.id = 348456 or ability.id = 355504 or ability.id = 355534) and type = "cast"
 or ability.id = 355525 or ability.id = 352052
 or (ability.id = 348456) and type = "applydebuff"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
mod:AddTimerLine(BOSS)
local warnAxe									= mod:NewTargetCountAnnounce(355568, 1, nil, nil, 184055, nil, nil, nil, true)
local warnHammer								= mod:NewTargetCountAnnounce(348508, 1, nil, nil, 175798, nil, nil, nil, true)
local warnScythe								= mod:NewTargetCountAnnounce(355778, 1, nil, nil, 327953, nil, nil, nil, true)
local warnShadowsteelChains						= mod:NewTargetNoFilterAnnounce(355505, 2, nil, nil, 246367)
local warnFlameclaspTrap						= mod:NewTargetNoFilterAnnounce(348456, 2, nil, nil, 8312)

local specWarnCruciformAxe						= mod:NewSpecialWarningMoveAway(355568, nil, 184055, nil, 1, 2)
local yellCruciformAxe							= mod:NewShortYell(355568, 184055)
local yellCruciformAxeFades						= mod:NewShortFadesYell(355568, 184055)
local specWarnCruciformAxeTaunt					= mod:NewSpecialWarningTaunt(355568, nil, 184055, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnReverberatingHammer				= mod:NewSpecialWarningMoveAway(348508, nil, 175798, nil, 1, 2)
local yellReverberatingHammer					= mod:NewShortYell(348508, 175798)
local yellReverberatingHammerFades				= mod:NewShortFadesYell(348508, 175798)
local specWarnReverberatingHammerTaunt			= mod:NewSpecialWarningTaunt(348508, nil, 175798, nil, 1, 2)
local specWarnDualbladeScythe					= mod:NewSpecialWarningMoveAway(355778, nil, 327953, nil, 1, 2)
local yellDualbladeScythe						= mod:NewShortYell(355778, 327953)
local yellDualbladeScytheFades					= mod:NewShortFadesYell(355778, 327953)
local specWarnDualbladeScytheTaunt				= mod:NewSpecialWarningTaunt(355778, nil, 327953, nil, 1, 2)--This might never target tanks, remove if it doesn't
local specWarnSpikedBalls						= mod:NewSpecialWarningSwitchCount(352052, nil, nil, nil, 1, 2)
local specWarnFlameclaspTrap					= mod:NewSpecialWarningYouPos(348456, nil, 8312, nil, 1, 2)
local yellFlameclaspTrap						= mod:NewShortPosYell(348456, 8312)
local yellFlameclaspTrapFades					= mod:NewIconFadesYell(348456, 8312)
local specWarnShadowsteelChains					= mod:NewSpecialWarningYouPos(355505, nil, 246367, nil, 1, 2)
local yellShadowsteelChains						= mod:NewShortPosYell(355505, 246367)
local yellShadowsteelChainsFades				= mod:NewIconFadesYell(355505, 246367)
--local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerCruciformAxeCD						= mod:NewCDCountTimer(19.4, 355568, 184055, nil, 2, 5, nil, DBM_COMMON_L.TANK_ICON)--"Axe"
local timerCruciformAxe							= mod:NewTargetTimer(6, 355568, 184055, nil, 2, 5)--"Axe"
local timerReverberatingHammerCD				= mod:NewCDCountTimer(19.4, 348508, 175798, nil, 2, 5, nil, DBM_COMMON_L.TANK_ICON)--"Hammer"
local timerReverberatingHammer					= mod:NewTargetTimer(6, 348508, 175798, nil, 2, 5)--"Hammer"
local timerDualbladeScytheCD					= mod:NewCDCountTimer(19.4, 355778, 327953, nil, 2, 5, nil, DBM_COMMON_L.TANK_ICON)--"Scythe"
local timerDualbladeScythe						= mod:NewTargetTimer(19.4, 355778, 327953, nil, 2, 5)--"Scythe"
local timerSpikedBallsCD						= mod:NewCDCountTimer(40, 352052, nil, nil, 2, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerFlameclaspTrapCD						= mod:NewCDCountTimer(47.9, 348456, 8312, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--"Trap"
local timerShadowsteelChainsCD					= mod:NewCDCountTimer(40.1, 355505, 246367, nil, nil, 3)--"Chains"

mod:AddTimerLine(DBM_COMMON_L.INTERMISSION)
--Intermission
local warnEmbers								= mod:NewCountAnnounce(355534, 2, nil, nil, 264364)
local warnAddsRemaining							= mod:NewAddsLeftAnnounce(355534, 1)

local timerForgeWeapon							= mod:NewCastTimer(48, 355525, nil, nil, nil, 6)
local timerEmbersCD								= mod:NewNextCountTimer(5, 355534, 264364, nil, nil, 3)--"Embers"
local timerAddsCD								= mod:NewAddsTimer(120, 357755, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerFinalScream							= mod:NewCastTimer(15, 357735, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddSetIconOption("SetIconOnChains", 355505, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnTraps", 348456, true, false, {4, 5, 6, 7})
mod:AddNamePlateOption("NPAuraOnFinalScream", 357735)

mod.vb.ChainsIcon = 1
mod.vb.trapsIcon = 4
mod.vb.weaponCount = 0
mod.vb.ballsCount = 0
mod.vb.trapCount = 0
mod.vb.chainCount = 0
mod.vb.emberCount = 0
mod.vb.addsRemaining = 0

local function repeatEmbers(self, expected)
	self.vb.emberCount = self.vb.emberCount + 1
	warnEmbers:Show(self.vb.emberCount)
	if self.vb.emberCount < expected then
		timerEmbersCD:Start(5, self.vb.emberCount+1)
		self:Schedule(5, repeatEmbers, self, expected)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ChainsIcon = 1
	self.vb.weaponCount = 0
	self.vb.ballsCount = 0
	self.vb.trapCount = 0
	self.vb.chainCount = 0
	if self:IsMythic() then
		timerShadowsteelChainsCD:Start(8.1-delay, 1)
		timerCruciformAxeCD:Start(10.7-delay, 1)
		timerSpikedBallsCD:Start(16-delay, 1)
		timerFlameclaspTrapCD:Start(39-delay, 1)
	else
		timerShadowsteelChainsCD:Start(10.8-delay, 1)
		timerCruciformAxeCD:Start(16-delay, 1)
		timerSpikedBallsCD:Start(20-delay, 1)
		if self:IsHeroic() then
			timerFlameclaspTrapCD:Start(45-delay, 1)
		end
	end
--	berserkTimer:Start(-delay)
	if self.Options.NPAuraOnFinalScream then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnFinalScream then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 357735 then
		if self.Options.NPAuraOnFinalScream then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 15)
		end
		if self:AntiSpam(5, 1) then
			timerFinalScream:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 348508 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerReverberatingHammerCD:Start(self:IsMythic() and 20.1 or 24.2, self.vb.weaponCount+1)
	elseif spellId == 355568 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerCruciformAxeCD:Start(self:IsMythic() and 20.1 or 19.3, self.vb.weaponCount+1)
	elseif spellId == 355778 then
		self.vb.weaponCount = self.vb.weaponCount + 1
		timerDualbladeScytheCD:Start(self:IsMythic() and 20.1 or 24.2, self.vb.weaponCount+1)
	elseif spellId == 355504 then
		self.vb.ChainsIcon = 1
		self.vb.chainCount = self.vb.chainCount + 1
		--They apply custom rule to only heroic in phase 2 and 3
		local timer = (not self:IsMythic() and self.vb.phase > 1 and 48.5) or 40.1
		timerShadowsteelChainsCD:Start(timer, self.vb.chainCount+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 355536 then
		self.vb.addsRemaining = self.vb.addsRemaining + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 355505 then
		local icon = self.vb.ChainsIcon
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnShadowsteelChains:Show(self:IconNumToTexture(icon))
			local audio = self:IsMythic() and "mm"..icon or "runout"
			specWarnShadowsteelChains:Play(audio)
			yellShadowsteelChains:Yell(icon, icon)
			yellShadowsteelChainsFades:Countdown(spellId, nil, icon)
		end
		warnShadowsteelChains:CombinedShow(0.5, args.destName)
		self.vb.ChainsIcon = self.vb.ChainsIcon + 1
	elseif spellId == 348508 then
		if args:IsPlayer() then
			specWarnReverberatingHammer:Show()
			specWarnReverberatingHammer:Play("runout")
			yellReverberatingHammer:Yell()
			yellReverberatingHammerFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnReverberatingHammerTaunt:Show(args.destName)
			specWarnReverberatingHammerTaunt:Play("tauntboss")
		else
			warnHammer:Show(self.vb.weaponCount, args.destName)
		end
		timerReverberatingHammer:Start(args.destName)
	elseif spellId == 355568 then
		if args:IsPlayer() then
			specWarnCruciformAxe:Show()
			specWarnCruciformAxe:Play("runout")
			yellCruciformAxe:Yell()
			yellCruciformAxeFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnCruciformAxeTaunt:Show(args.destName)
			specWarnCruciformAxeTaunt:Play("tauntboss")
		else
			warnAxe:Show(self.vb.weaponCount, args.destName)
		end
		timerCruciformAxe:Start(args.destName)
	elseif spellId == 355778 then
		if args:IsPlayer() then
			specWarnDualbladeScythe:Show()
			specWarnDualbladeScythe:Play("runout")
			yellDualbladeScythe:Yell()
			yellDualbladeScytheFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnDualbladeScytheTaunt:Show(args.destName)
			specWarnDualbladeScytheTaunt:Play("tauntboss")
		else
			warnScythe:Show(self.vb.weaponCount, args.destName)
		end
		timerDualbladeScythe:Start(args.destName)
	elseif spellId == 348456 then
		if self:AntiSpam(5, 2) then
			self.vb.trapsIcon = 4
			self.vb.trapCount = self.vb.trapCount + 1
			local timer = (self:IsHeroic() and self.vb.phase > 1 and 47.9) or (self:IsMythic() and self.vb.phase == 1 and 53.9 or self.vb.phase == 2 and 37.9 or 39.9) or 40
			timerFlameclaspTrapCD:Start(timer, self.vb.trapCount+1)
		end
		local icon = self.vb.trapsIcon
		if self.Options.SetIconOnTraps then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFlameclaspTrap:Show(self:IconNumToTexture(icon))
			specWarnFlameclaspTrap:Play("mm"..icon)
			yellFlameclaspTrap:Yell(icon, icon)
			yellFlameclaspTrapFades:Countdown(spellId, nil, icon)
		end
		warnFlameclaspTrap:CombinedShow(0.5, args.destName)
		self.vb.trapsIcon = self.vb.trapsIcon + 1
	elseif spellId == 352052 then
		self.vb.ballsCount = self.vb.ballsCount + 1
		specWarnSpikedBalls:Show(self.vb.ballsCount)
		specWarnSpikedBalls:Play("targetchange")
		local timer = (not self:IsMythic() and self.vb.phase > 1 and 47.9) or 40.1
		timerSpikedBallsCD:Start(timer, self.vb.ballsCount+1)
	elseif spellId == 355525 then
		self:Unschedule(repeatEmbers)
		repeatEmbers(self, self:IsMythic() and 9 or 8)
		timerForgeWeapon:Start()
		if self:IsMythic() then--Based on vods, may be off slightly
			timerAddsCD:Start(47)
		end
		if self:IsFated() then
			self:AffixEvent(0)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 355505 then
		if args:IsPlayer() then
			yellShadowsteelChainsFades:Cancel()
		end
	elseif spellId == 355506 then
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 348508 then
		if args:IsPlayer() then
			yellReverberatingHammerFades:Cancel()
		end
		timerReverberatingHammer:Stop(args.destName)
	elseif spellId == 355568 then
		if args:IsPlayer() then
			yellCruciformAxeFades:Cancel()
		end
		timerCruciformAxe:Stop(args.destName)
	elseif spellId == 355778 then
		if args:IsPlayer() then
			yellDualbladeScytheFades:Cancel()
		end
		timerDualbladeScythe:Stop(args.destName)
	elseif spellId == 348456 then
		if self.Options.SetIconOnTraps then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellFlameclaspTrapFades:Cancel()
		end
	elseif spellId == 355525 then--Forge Weapon ending, boss returning
		self:Unschedule(repeatEmbers)--For good measure, maybe down the line when people soloing, intermission will break/shorten
		timerForgeWeapon:Stop()
		if self.vb.phase == 1.5 then
			self:SetStage(2)
			if self:IsFated() then
				self:AffixEvent(1, 2)
			end
		else
			self:SetStage(3)
			if self:IsFated() then
				self:AffixEvent(1, 3)
			end
		end
		self.vb.weaponCount = 0
		self.vb.ballsCount = 0
		self.vb.trapCount = 0
		self.vb.chainCount = 0
		--Technically timers between stage 2 and 3 are same (minus weapon type change)
		--But I like having knobs to adjust in place if fight recieves adjustments down the line
		if self.vb.phase == 2 then
			if self:IsMythic() then--Timers from video, might be slightly off
				timerShadowsteelChainsCD:Start(10.8, 1)
				timerReverberatingHammerCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(19.9, 1)
				timerFlameclaspTrapCD:Start(38.1, 1)
			else--Blizz finally synced up all difficulties to be same for non mythic
				timerShadowsteelChainsCD:Start(14.7, 1)
				timerReverberatingHammerCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(26, 1)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(48.1, 1)
				end
			end
		else--phase 3
			if self:IsMythic() then--Timers taken from P2, might not be right at all, could't find any clean P3 pulls in vods
				timerShadowsteelChainsCD:Start(10.8, 1)
				timerDualbladeScytheCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(19.9, 1)
				timerFlameclaspTrapCD:Start(38.1, 1)
			else--Blizz finally synced up all difficulties to be same for non mythic
				timerShadowsteelChainsCD:Start(14.6, 1)
				timerDualbladeScytheCD:Start(16.9, 1)
				timerSpikedBallsCD:Start(26, 1)
				if self:IsHeroic() then
					timerFlameclaspTrapCD:Start(48.1, 1)
				end
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 179847 then--Shadowsteel Horror
		self.vb.addsRemaining = self.vb.addsRemaining - 1
		if self.vb.addsRemaining == 0 then
			warnAddsRemaining:Show(0)
			timerFinalScream:Stop()
		end
		if self.Options.NPAuraOnFinalScream then
			DBM.Nameplate:Hide(true, args.destGUID, 357735)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--"<67.84 22:36:16> [UNIT_SPELLCAST_SUCCEEDED] Painsmith Raznal(Andybruwu) -[DNT] Upstairs- [[boss1:Cast-3-2012-2450-9254-355555-003A1D8DC1:355555]]", -- [1092]
--"<70.30 22:36:19> [CLEU] SPELL_AURA_APPLIED#Creature-0-2012-2450-9254-176523-00001D8D02#Painsmith Raznal#Creature-0-2012-2450-9254-176523-00001D8D02#Painsmith Raznal#355525#Forge Weapon#BUFF#nil", -- [1138]
--"<115.44 11:06:19> [UNIT_SPELLCAST_SUCCEEDED] Painsmith Raznal(Lonecrusader) -[DNT] Upstairs- [[boss1:Cast-3-4253-2450-3280-355555-002F6FFA8B:355555]]", -- [4266]
--"<119.12 11:06:23> [CLEU] SPELL_AURA_APPLIED#Creature-0-4253-2450-3280-176523-00006FF9BD#Painsmith Raznal#Creature-0-4253-2450-3280-176523-00006FF9BD#Painsmith Raznal#359033#Forge's Flames#BUFF#nil",
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 355555 then--Upstairs (Boss leaving, faster to stop timers than Forge Weapon which happens ~2-4 sec later)
		self.vb.emberCount = 0
		self.vb.addsRemaining = 0
		if self.vb.phase == 1 then
			self:SetStage(1.5)
		else
			self:SetStage(2.5)
		end
		timerReverberatingHammerCD:Stop()
		timerCruciformAxeCD:Stop()
		timerDualbladeScytheCD:Stop()
		timerSpikedBallsCD:Stop()
		timerFlameclaspTrapCD:Stop()
		timerShadowsteelChainsCD:Stop()
		--Timers started at forge weapon do to variation that can be observed between upstairs and forge weapon start
	end
end
