local mod	= DBM:NewMod(1203, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77557, 77231, 77477)
mod:SetEncounterID(1695)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetModelSound("sound\\creature\\marak\\vo_60_ironmaidens_marak_08.ogg", "sound\\creature\\marak\\vo_60_ironmaidens_marak_08.ogg")
mod:SetHotfixNoticeRev(13439)
mod.respawnTime = 29.5

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158708 158707 158692 158599 155794 158078 156626 158008 156109",
	"SPELL_CAST_SUCCESS 157854 157886 156109 155794",
	"SPELL_AURA_APPLIED 158702 164271 156214 158315 158010 159724 156631 156601",
	"SPELL_AURA_REMOVED 159724 156631 158010",
	"SPELL_PERIODIC_DAMAGE 158683",
	"SPELL_ABSORBED 158683",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_ADDON",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

mod:SetBossHealthInfo(77557, 77231, 77477)

local Ship	= EJ_GetSectionInfo(10019)
local Marak = EJ_GetSectionInfo(10033)
local Sorka = EJ_GetSectionInfo(10030)
local Garan = EJ_GetSectionInfo(10025)

--Ship
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnShip							= mod:NewTargetAnnounce("ej10019", 3, 76204)
local warnBombardmentAlpha				= mod:NewCountAnnounce(157854, 3)--From ship, but affects NON ship.
----Blackrock Deckhand
local warnProtectiveEarth				= mod:NewSpellAnnounce("OptionVersion2", 158707, 3, nil, false)--Could not verify
----Shattered Hand Deckhand
local warnFixate						= mod:NewTargetAnnounce("OptionVersion2", 158702, 3, nil, false)--extremely spammy
--Ground
----Admiral Gar'an
local warnRapidFire						= mod:NewTargetCountAnnounce(156631, 4)
local warnPenetratingShot				= mod:NewTargetCountAnnounce(164271, 3)
----Enforcer Sorka
local warnBladeDash						= mod:NewTargetCountAnnounce(155794, 3, nil, "Ranged|Tank")
local warnConvulsiveShadows				= mod:NewTargetCountAnnounce(156214, 3, nil, "Healer")
local warnDarkHunt						= mod:NewTargetCountAnnounce(158315, 4, nil, "Healer")
----Marak the Blooded
local warnBloodRitual					= mod:NewTargetCountAnnounce(158078, 3)
local warnBloodsoakedHeartseeker		= mod:NewTargetCountAnnounce(158010, 4, nil, "Healer")
local warnSanguineStrikes				= mod:NewTargetAnnounce(156601, 3, nil, "Healer")

--Ship
local specWarnBombardmentOmega			= mod:NewSpecialWarningCount(157886, nil, nil, nil, 3)--From ship, but affects NON ship.
local specWarnReturnBase				= mod:NewSpecialWarning("specWarnReturnBase")
local specWarnBoatEnded					= mod:NewSpecialWarningEnd("ej10019")
----Blackrock Deckhand
local specWarnEarthenbarrier			= mod:NewSpecialWarningInterrupt(158708, "-Healer", nil, 2, nil, 2)
----Shattered Hand Deckhand
local specWarnDeadlyThrow				= mod:NewSpecialWarningSpell(158692, "Tank")
local specWarnFixate					= mod:NewSpecialWarningYou(158702)
----Bleeding Hollow Deckhand
local specWarnCorruptedBlood			= mod:NewSpecialWarningMove(158683)
--Ground
----Admiral Gar'an
local specWarnRapidFire					= mod:NewSpecialWarningRun(156631, nil, nil, nil, 4, 2)
local yellRapidFire						= mod:NewYell(156631)
local specWarnRapidFireNear				= mod:NewSpecialWarningClose(156631, false)
local specWarnPenetratingShot			= mod:NewSpecialWarningYou(164271, nil, nil, nil, nil, 2)
local specWarnPenetratingShotOther		= mod:NewSpecialWarningTargetCount(164271, false)
local yellPenetratingShot				= mod:NewYell(164271)
local specWarnDeployTurret				= mod:NewSpecialWarningSwitch(158599, "RangedDps", nil, 3, 3, 2)--Switch warning since most need to switch and kill, but on for EVERYONE because tanks/healers need to avoid it while it's up
----Enforcer Sorka
local specWarnBladeDash					= mod:NewSpecialWarningYou(155794)
local specWarnBladeDashOther			= mod:NewSpecialWarningClose(155794)
local specWarnConvulsiveShadows			= mod:NewSpecialWarningMoveAway(156214, nil, nil, nil, nil, 2)--Does this still drop lingering shadows, if not moveaway is not appropriate
local specWarnConvulsiveShadowsOther	= mod:NewSpecialWarningTargetCount(156214, false)
local yellConvulsiveShadows				= mod:NewYell(156214, nil, false)
local specWarnDarkHunt					= mod:NewSpecialWarningYou(158315, nil, nil, nil, nil, 2)
local specWarnDarkHuntOther				= mod:NewSpecialWarningTarget(158315, false)--Healer may want this, or raid leader
----Marak the Blooded
local specWarnBloodRitual				= mod:NewSpecialWarningYou(158078)
local specWarnBloodRitualOther			= mod:NewSpecialWarningTargetCount(158078, "Tank")
local yellBloodRitual					= mod:NewYell(158078)
local specWarnBloodsoakedHeartseeker	= mod:NewSpecialWarningRun(158010, nil, nil, nil, 4, 2)
local yellHeartseeker					= mod:NewYell(158010, nil, false)

--Ship
mod:AddTimerLine(Ship)
local timerShipCD						= mod:NewNextCountTimer(198, "ej10019", nil, nil, nil, 76204)
local timerBombardmentAlphaCD			= mod:NewNextTimer(18, 157854)
local timerWarmingUp					= mod:NewCastTimer(90, 158849)
--Ground
----Admiral Gar'an
mod:AddTimerLine(Garan)
local timerRapidFireCD					= mod:NewCDTimer(30, 156626)
local timerDarkHuntCD					= mod:NewCDCountTimer(13.5, 158315, nil, false)--Important to know you have it, not very important to know it's coming soon.
local timerPenetratingShotCD			= mod:NewCDCountTimer(28.8, 164271)--22-30 at least. maybe larger variation.
local timerDeployTurretCD				= mod:NewCDCountTimer(20.2, 158599)--20.2-23.5
----Enforcer Sorka
mod:AddTimerLine(Sorka)
local timerBladeDashCD					= mod:NewCDCountTimer(20, 155794, nil, "Ranged|Tank")
local timerConvulsiveShadowsCD			= mod:NewNextCountTimer(56, 156214)--Timer only enabled on mythicOn non mythic, it's just an unimportant dot. On mythic, MUCH more important because user has to run out of raid and get dispelled.
----Marak the Blooded
mod:AddTimerLine(Marak)
local timerBloodRitualCD				= mod:NewCDCountTimer(20, 158078)
local timerHeartSeekerCD				= mod:NewCDCountTimer(70, 158010, nil, "Ranged")--Seriously a 74 second cd?

local countdownShip						= mod:NewCountdown(198, "ej10019")
local countdownWarmingUp				= mod:NewCountdown(90, 158849)
local countdownBloodRitual				= mod:NewCountdownFades("Alt5", 158078, "Tank")
local countdownBladeDash				= mod:NewCountdown("AltTwo20", 155794, "Tank")
local countdownDarkHunt					= mod:NewCountdownFades("AltTwo8", 158315)

local voiceRapidFire					= mod:NewVoice(156631) --runout
local voiceBloodRitual					= mod:NewVoice("OptionVersion2", 158078, "MeleeDps") --158078.ogg, farawayfromline
local voiceHeartSeeker					= mod:NewVoice(158010) --spread
local voiceShip							= mod:NewVoice("ej10019") --1695uktar, 1695gorak, 1695ukurogg
local voiceEarthenbarrier				= mod:NewVoice(158708)  --int
local voiceDeployTurret					= mod:NewVoice("OptionVersion2", 158599, "RangedDps") --158599.ogg attack turret
local voiceConvulsiveShadows			= mod:NewVoice(156214) --runaway, target
local voiceDarkHunt						= mod:NewVoice(158315) --defensive, target
local voicePenetratingShot				= mod:NewVoice(164271) --stack

mod:AddSetIconOption("SetIconOnRapidFire", 156626, true)
mod:AddSetIconOption("SetIconOnBloodRitual", 158078, true)
mod:AddSetIconOption("SetIconOnHeartSeeker", 158010, true)
mod:AddHudMapOption("HudMapOnRapidFire", 156631)--Yellow markers
mod:AddHudMapOption("HudMapOnBloodRitual", 158078)--Red markers
mod:AddBoolOption("filterBladeDash3", false)
mod:AddBoolOption("filterBloodRitual3", false)

mod.vb.phase = 1
mod.vb.ship = 0
mod.vb.alphaOmega = 0
mod.vb.bloodRitual = 0
mod.vb.bladeDash = 1
mod.vb.penetratingShot = 0
mod.vb.convulsiveShadows = 0
mod.vb.heartseeker = 0
mod.vb.darkHunt = 0
mod.vb.turret = 0
mod.vb.rapidfire = 0
mod.vb.shadowsWarned = false

local UnitPosition, UnitIsConnected, UnitDebuff, GetTime =  UnitPosition, UnitIsConnected, UnitDebuff, GetTime
local playerOnBoat = false
local boatMissionDone = false
local DBMHudMap = DBMHudMap

local function isPlayerOnBoat()
	local _, y = UnitPosition("player")
	if y < 3196 then
		return false
	else
		return true
	end
end

local function boatReturnWarning()
	if boatMissionDone and isPlayerOnBoat() then
		specWarnReturnBase:Show()
	end
end

--(ability.id = 158078 or ability.id = 156626 or ability.id = 155794 or ability.id = 158008 or ability.id = 156109) and type = "begincast" or ability.id = 164271 and type = "cast" or ability.name = "Sabotage"
local function checkBoatPlayer(self, npc)
	DBM:Debug("checkBoatPlayer running", 3)
	for uId in DBM:GetGroupMembers() do 
		local _, y, _, playerMapId = UnitPosition(uId)
		if UnitIsConnected(uId) and playerMapId == 1205 then
			if y > 3196 then--found player on boat
				self:Schedule(1, checkBoatPlayer, self, npc)
				return
			end
		end
	end
	DBM:Debug("checkBoatPlayer finished")
	boatMissionDone = false
	self:Unschedule(boatReturnWarning)
	timerBombardmentAlphaCD:Cancel()
	timerWarmingUp:Cancel()
	countdownWarmingUp:Cancel()
	if playerOnBoat then -- leave boat
		playerOnBoat = false
	else
		specWarnBoatEnded:Show()
	end
	self.vb.bladeDash = 1
	self.vb.bloodRitual = 0
	local bossPower = UnitPower("boss1")--All bosses have same power, doesn't matter which one checked
	--These abilites resume after boat phase ends on mythic, on other difficulties, they still reset
	timerBladeDashCD:Cancel()
	timerBladeDashCD:Start(5, 1)--5-6
	countdownBladeDash:Cancel()
	countdownBladeDash:Start(5)
	timerBloodRitualCD:Cancel()
	timerBloodRitualCD:Start(8.5, 1)--Variation on this may be same as penetrating shot variation. when it's marak returning from boat may be when it's 9.7
	--These are altered by boar ending, even though boss continues casting it during boat phases.
	timerRapidFireCD:Cancel()
	timerRapidFireCD:Start(13, self.vb.rapidfire+1)
	if bossPower >= 30 then
		if npc == Garan then--When garan returning, penetrating is always 27-28
			timerPenetratingShotCD:Start(27, self.vb.penetratingShot+1)
		else--When not garan returning, it's 24
			timerPenetratingShotCD:Cancel()
			timerPenetratingShotCD:Start(24, self.vb.penetratingShot+1)
		end
		timerConvulsiveShadowsCD:Cancel()
		timerConvulsiveShadowsCD:Start(36.5, self.vb.convulsiveShadows+1)--36.5-38
		timerHeartSeekerCD:Cancel()
		timerHeartSeekerCD:Start(57, self.vb.heartseeker+1)
	end
end

local function checkBoatOn(self, count)
	if isPlayerOnBoat() then
		playerOnBoat = true
		timerBloodRitualCD:Cancel()
		timerRapidFireCD:Cancel()
		timerBladeDashCD:Cancel()
		countdownBladeDash:Cancel()
		timerHeartSeekerCD:Cancel()
		timerConvulsiveShadowsCD:Cancel()
		timerPenetratingShotCD:Cancel()
		timerBombardmentAlphaCD:Cancel()
		DBM:Debug("Player Entering Boat")
	elseif count < 20 then
		self:Schedule(1, checkBoatOn, self, count + 1)
	end
end

function mod:ConvulsiveTarget(targetname, uId)
	if not targetname then return end
	self.vb.shadowsWarned = true
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if (noFilter or not isPlayerOnBoat()) then
		if self.Options.SpecWarn156214target then
			specWarnConvulsiveShadowsOther:Show(self.vb.convulsiveShadows, targetname)
		else
			warnConvulsiveShadows:Show(self.vb.convulsiveShadows, targetname)--Combined because a bad lingeringshadows drop may have multiple.
		end
		if self:IsMythic() and targetname == UnitName("player") then
			specWarnConvulsiveShadows:Show()
			yellConvulsiveShadows:Yell()
			voiceConvulsiveShadows:Play("runaway")
		end
	end
end

function mod:BladeDashTarget(targetname, uId)
	if self:IsMythic() and self:AntiSpam(5, 3) then
		if targetname == UnitName("player") then
			if UnitDebuff("player", GetSpellInfo(170395)) and self.Options.filterBladeDash3 then return end
			specWarnBladeDash:Show()
		elseif self:CheckNearby(8, targetname) then
			specWarnBladeDashOther:Show(targetname)
		else
			warnBladeDash:Show(self.vb.bladeDash, targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.ship = 0
	self.vb.alphaOmega = 1
	self.vb.bloodRitual = 0
	self.vb.bladeDash = 1
	self.vb.penetratingShot = 0
	self.vb.convulsiveShadows = 0
	self.vb.heartseeker = 0
	self.vb.darkHunt = 0
	self.vb.turret = 0
	self.vb.rapidfire = 0
	boatMissionDone = false
	playerOnBoat = false
	timerBladeDashCD:Start(8-delay, 1)
	if self:IsMythic() then
		countdownBladeDash:Start(8-delay)
	end
	timerBloodRitualCD:Start(12.4-delay, 1)
	timerRapidFireCD:Start(15.5-delay, 1)
	timerShipCD:Start(59.5-delay, 1)
	countdownShip:Start(59.5-delay)
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT boss1 boss2 boss3"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.HudMapOnRapidFire or self.Options.HudMapOnBloodRitual then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 158078 then
		self.vb.bloodRitual = self.vb.bloodRitual + 1
		if noFilter or not isPlayerOnBoat() then--Blood Ritual. Still safest way to start timer, in case no sync
			timerBloodRitualCD:Start(nil, self.vb.bloodRitual+1)
		end
	elseif spellId == 156626 then--Rapid Fire. Still safest way to start timer, in case no sync
		self.vb.rapidfire = self.vb.rapidfire + 1
		if noFilter or not isPlayerOnBoat() then
			timerRapidFireCD:Start(nil, self.vb.rapidfire+1)
		end
	elseif spellId == 158599 then
		self.vb.turret = self.vb.turret + 1
		if (noFilter or not isPlayerOnBoat()) then
			specWarnDeployTurret:Show()
			voiceDeployTurret:Play("158599")
			timerDeployTurretCD:Start(nil, self.vb.turret+1)
		end
	elseif spellId == 155794 then
		if noFilter or not isPlayerOnBoat() then
			self:ScheduleMethod(0.1, "BossTargetScanner", 77231, "BladeDashTarget", 0.1, 16)
			timerBladeDashCD:Cancel()
			timerBladeDashCD:Start(nil, self.vb.bladeDash+1)
			if self:IsMythic() then
				countdownBladeDash:Cancel()
				countdownBladeDash:Start()
			end
		end
	elseif spellId == 158008 then
		self.vb.heartseeker = self.vb.heartseeker + 1
		if noFilter or not isPlayerOnBoat() then
			timerHeartSeekerCD:Start(nil, self.vb.heartseeker+1)
		end
	--Begin Deck Abilities
	elseif spellId == 158708 and (noFilter or isPlayerOnBoat()) then
		specWarnEarthenbarrier:Show(args.sourceName)
		voiceEarthenbarrier:Play("kickcast")
	elseif spellId == 158707 and (noFilter or isPlayerOnBoat()) then
		warnProtectiveEarth:Show()
	elseif spellId == 158692 and (noFilter or isPlayerOnBoat()) then
		specWarnDeadlyThrow:Show()
	elseif spellId == 156109 then
		self.vb.shadowsWarned = false
		--This count will be off if target dies during cast and boss recasts.
		--However, unlike blade dash, it cannot be moved to success do to spread mechanic
		self.vb.convulsiveShadows = self.vb.convulsiveShadows + 1
		self:ScheduleMethod(0.1, "BossTargetScanner", 77231, "ConvulsiveTarget", 0.1, 13, true, nil, nil, nil, true)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 157854 then
		self:Schedule(12.5, boatReturnWarning)
		if noFilter or not isPlayerOnBoat() then
			warnBombardmentAlpha:Show(self.vb.alphaOmega)
			timerBombardmentAlphaCD:Start()
		end
	elseif spellId == 157886 and (noFilter or not isPlayerOnBoat()) then
		specWarnBombardmentOmega:Show(self.vb.alphaOmega)
		self.vb.alphaOmega = self.vb.alphaOmega + 1
	elseif spellId == 156109 and self:IsMythic() then
		if noFilter or not isPlayerOnBoat() then
			timerConvulsiveShadowsCD:Start(nil, self.vb.convulsiveShadows+1)
		end
	elseif spellId == 155794 then
		self.vb.bladeDash = self.vb.bladeDash + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 164271 then
		self.vb.penetratingShot = self.vb.penetratingShot + 1
		if noFilter or not isPlayerOnBoat() then
			if self.Options.SpecWarn164271target then
				specWarnPenetratingShotOther:Show(self.vb.penetratingShot, args.destName)
			else
				warnPenetratingShot:Show(self.vb.penetratingShot, args.destName)
			end
			timerPenetratingShotCD:Start(nil, self.vb.penetratingShot+1)
			if args:IsPlayer() then
				specWarnPenetratingShot:Show()
				yellPenetratingShot:Yell()
				voicePenetratingShot:Play("gathershare")
			end
		end
	elseif spellId == 156214 and not self.vb.shadowsWarned and (noFilter or not isPlayerOnBoat()) then
		--Count not showed here because spreads aren't counted
		warnConvulsiveShadows:CombinedShow(0.5, args.destName)--Combined because a bad lingeringshadows drop may have multiple.
		if args:IsPlayer() and self:IsMythic() then
			specWarnConvulsiveShadows:Show()
			yellConvulsiveShadows:Yell()
			voiceConvulsiveShadows:Play("runaway")
		end
	elseif spellId == 158315 then
		self.vb.darkHunt = self.vb.darkHunt + 1
		if (noFilter or not isPlayerOnBoat()) then
			if args:IsPlayer() then
				voiceDarkHunt:Schedule(1.5, "defensive")
				countdownDarkHunt:Start()
				specWarnDarkHunt:Show()
			else
				if self.Options.SpecWarn158315target then
					specWarnDarkHuntOther:Show(self.vb.darkHunt, args.destName)
				else
					warnDarkHunt:Show(self.vb.darkHunt, args.destName)
				end
			end
			timerDarkHuntCD:Start(nil, self.vb.darkHunt+1)
		end
	elseif spellId == 158010 then
		if self.Options.SetIconOnHeartSeeker and not self:IsLFR() then
			self:SetSortedIcon(1, args.destName, 3, 3)
		end
		if (noFilter or not isPlayerOnBoat()) then
			warnBloodsoakedHeartseeker:CombinedShow(0.5, self.vb.heartseeker, args.destName)
			if args:IsPlayer() then
				specWarnBloodsoakedHeartseeker:Show()
				yellHeartseeker:Yell()
				voiceHeartSeeker:Play("scatter")
			end
		end
	elseif spellId == 159724 then
		if self.Options.SetIconOnBloodRitual and not self:IsLFR() then
			self:SetIcon(args.destName, 2)
		end
		if (noFilter or not isPlayerOnBoat()) then
			countdownBloodRitual:Start()
			if self.Options.SpecWarn158078targetcount then
				specWarnBloodRitualOther:Show(self.vb.bloodRitual, args.destName)
			else
				warnBloodRitual:Show(self.vb.bloodRitual, args.destName)
			end
			if self.Options.HudMapOnBloodRitual then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 7, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)
			end
			if args:IsPlayer() then
				yellBloodRitual:Yell()
				if UnitDebuff("player", GetSpellInfo(170405)) and self.Options.filterBloodRitual3 then return end
				specWarnBloodRitual:Show()
				--voiceBloodRitual:Play("???")--Player needs a different warning than "far away from lines". player IS the line so they can't be far away from lines
			else
				voiceBloodRitual:Play("158078")--Good sound fit for everyone ELSE
			end
		end
	elseif spellId == 156631 then
		if self:AntiSpam(5, args.destName) then--check antispam so we don't warn if we got a user sync 3 seconds ago.
			if self.Options.SetIconOnRapidFire and not self:IsLFR() then
				self:SetIcon(args.destName, 1, 7)
			end
			if (noFilter or not isPlayerOnBoat()) then
				if self:CheckNearby(5, args.destName) and self.Options.SpecWarn156631close then
					specWarnRapidFireNear:Show(args.destName)
				else
					warnRapidFire:Show(self.vb.rapidfire, args.destName)
				end
				if self.Options.HudMapOnRapidFire then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 9, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
				end
			end
		end
	elseif spellId == 156601 then
		warnSanguineStrikes:Show(args.destName)
		--voiceSanguineStrikes:Play("healall")
	--Begin Deck Abilities
	elseif spellId == 158702 and (noFilter or isPlayerOnBoat()) then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then--it spams sometimes
			specWarnFixate:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159724 and self.Options.SetIconOnBloodRitual and not self:IsLFR() then
		self:SetIcon(args.destName, 0)
		if self.Options.HudMapOnBloodRitual then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 158010 and self.Options.SetIconOnHeartSeeker and not self:IsLFR() then
		self:SetIcon(args.destName, 0)
	elseif spellId == 156631 and self.Options.HudMapOnRapidFire then
		DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 158683 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnCorruptedBlood:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 77477 then--Marak
		timerBloodRitualCD:Cancel()
		timerHeartSeekerCD:Cancel()
	elseif cid == 77557 then--Gar'an
		timerRapidFireCD:Cancel()
		timerPenetratingShotCD:Cancel()
		timerDeployTurretCD:Cancel()
	elseif cid == 77231 then--Sorka
		timerBladeDashCD:Cancel()
		countdownBladeDash:Cancel()
		timerConvulsiveShadowsCD:Cancel()
		timerDarkHuntCD:Cancel()
	elseif cid == 78351 or cid == 78341 or cid == 78343 then--boat bosses
		self:Schedule(1, function()--wait 1s boat player ready to return.
			boatMissionDone = true
		end)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 158849 then
		timerWarmingUp:Start()
		countdownWarmingUp:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc)
	if msg:find(L.shipMessage) then
		self:Schedule(1, checkBoatOn, self, 1)
		self:Schedule(25, checkBoatPlayer, self, npc)
		boatMissionDone = false
		self.vb.ship = self.vb.ship + 1
		self.vb.alphaOmega = 1
		warnShip:Show(npc)
		if self.vb.ship < 3 then
			timerShipCD:Start(nil, self.vb.ship+1)
			countdownShip:Start()
		end
		--Timers that always cancel on mythic, regardless of boss going up
		if self:IsMythic() then
			self:Schedule(3, function()
				timerBladeDashCD:Cancel()
				countdownBladeDash:Cancel()
				timerBloodRitualCD:Cancel()
				timerHeartSeekerCD:Cancel()
			end)
		else--This cancels in all modes
			self:Schedule(3, function()
				timerHeartSeekerCD:Cancel()
			end)
		end
		--Timers that always cancel on mythic, regardless of boss going up
		timerBombardmentAlphaCD:Start(14.5)
		if npc == Marak then
			self:Schedule(3, function()
				timerBloodRitualCD:Cancel()
			end)
			voiceShip:Play("1695ukurogg")
		elseif npc == Sorka then
			self:Schedule(3, function()
				timerBladeDashCD:Cancel()
				countdownBladeDash:Cancel()
				timerConvulsiveShadowsCD:Cancel()
				timerDarkHuntCD:Cancel()
			end)
			voiceShip:Play("1695gorak")
		elseif npc == Garan then
			self:Schedule(3, function()
				timerRapidFireCD:Cancel()
				timerPenetratingShotCD:Cancel()
				timerDeployTurretCD:Cancel()
			end)
			voiceShip:Play("1695uktar")
		end
	end
end

--"<9.87 23:50:29> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Too slow!#Enforcer Sorka###Etsi
--"<10.92 23:50:30> [DBM_Announce] DBM_Announce#Blade Dash on |r|cff9382c9Etsi|r|cffffb200 near you", -- [691]
function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, targetname)
	if msg:find(L.EarlyBladeDash) then
		if self:IsMythic() and self:AntiSpam(5, 3) then
			if targetname == UnitName("player") then
				if UnitDebuff("player", GetSpellInfo(170395)) and self.Options.filterBladeDash3 then return end
				specWarnBladeDash:Show()
			elseif self:CheckNearby(8, targetname) then
				specWarnBladeDashOther:Show(targetname)
			else
				warnBladeDash:Show(self.vb.bladeDash, targetname)
			end
		end
	end
end

--Rapid fire is still 3 seconds faster to use emote instead of debuff.
--Bigwigs doesn't sync Rapid Fire like DBM does, but they do sync ALL RAID_BOSS_WHISPER events.
--So we can this for rapidfire targets sent by both bigwigs and DBM
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:156626") then--Rapid fire
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Set antispam if we got a sync, to block 3 second late SPELL_AURA_APPLIED if we got the early warning
			if self.Options.SetIconOnRapidFire and not self:IsLFR() then
				self:SetIcon(targetName, 1, 10)
			end
			if DBM.Options.DontShowFarWarnings and isPlayerOnBoat() then return end--Anything below this line doesn't concern people on boat
			if self:CheckNearby(5, targetName) and self.Options.SpecWarn156631close then
				specWarnRapidFireNear:Show(targetName)
			else
				warnRapidFire:Show(self.vb.rapidfire, targetName)
			end
			if self.Options.HudMapOnRapidFire then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(156631, "highlight", targetName, 5, 12, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
			end
		end
	end
end


--Rapid fire is still 3 seconds faster to use emote instead of debuff.
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:156626") then
		specWarnRapidFire:Show()
		yellRapidFire:Yell()
		voiceRapidFire:Play("runout")
		voiceRapidFire:Schedule(2, "keepmove")
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	local hp = UnitHealth(uId) / UnitHealthMax(uId)
	if hp < 0.20 and self.vb.phase ~= 2 then
		timerShipCD:Cancel()
		countdownShip:Cancel()
		self.vb.phase = 2
		warnPhase2:Show()
		self:UnregisterShortTermEvents()
	end
end
