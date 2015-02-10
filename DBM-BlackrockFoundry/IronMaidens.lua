local mod	= DBM:NewMod(1203, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77557, 77231, 77477)
mod:SetEncounterID(1695)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetModelSound("sound\\creature\\marak\\vo_60_ironmaidens_marak_08.ogg", "sound\\creature\\marak\\vo_60_ironmaidens_marak_08.ogg")

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158708 158707 158692 158599 155794 158078 156626 158008",
	"SPELL_CAST_SUCCESS 157854 157886 156109",
	"SPELL_AURA_APPLIED 158702 164271 156214 158315 158010 159724 156631 156601",
	"SPELL_AURA_REMOVED 159724",
	"SPELL_PERIODIC_DAMAGE 158683",
	"SPELL_PERIODIC_MISSED 158683",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

mod:SetBossHealthInfo(77557, 77231, 77477)

--TODO, find out how many bombardments there are so timer doesn't start after last one.
--TODO, add timers for deck abilities that need them?
--TODO, use x, y values from UnitPosition and remove map crap. Map stuff was only used because that could be coded without going into zone (just open map and mouse over shit)
local Ship	= EJ_GetSectionInfo(10019)
local Marak = EJ_GetSectionInfo(10033)
local Sorka = EJ_GetSectionInfo(10030)
local Garan = EJ_GetSectionInfo(10025)

--Ship
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnPhase2p						= mod:NewPrePhaseAnnounce(2)
local warnShip							= mod:NewSpellAnnounce("ej10019", 3, 76204)
----Blackrock Deckhand
local warnProtectiveEarth				= mod:NewSpellAnnounce("OptionVersion2", 158707, 3, nil, false)--Could not verify
----Shattered Hand Deckhand
local warnDeadlyThrow					= mod:NewSpellAnnounce(158692, 3)
local warnFixate						= mod:NewTargetAnnounce(158702, 3)
--Ground
----Admiral Gar'an
local warnRapidFire						= mod:NewTargetAnnounce(156631, 4)
local warnPenetratingShot				= mod:NewTargetAnnounce(164271, 3)
----Enforcer Sorka
local warnBladeDash						= mod:NewTargetAnnounce("OptionVersion2", 155794, 3, nil, "Ranged")--No longer targets melee, ever.
local warnConvulsiveShadows				= mod:NewTargetAnnounce(156214, 3, nil, "Healer")
local warnDarkHunt						= mod:NewTargetAnnounce(158315, 4, nil, "Healer")
----Marak the Blooded
local warnBloodRitual					= mod:NewTargetAnnounce(158078, 3)
local warnBloodsoakedHeartseeker		= mod:NewTargetAnnounce(158010, 4, nil, "Healer")
local warnSanguineStrikes				= mod:NewTargetAnnounce(156601, 3, nil, "Healer")

--Ship
local specWarnBombardmentAlpha			= mod:NewSpecialWarningCount(157854, nil, nil, nil, 2)--From ship, but affects NON ship.
local specWarnBombardmentOmega			= mod:NewSpecialWarningCount(157886, nil, nil, nil, 3)--From ship, but affects NON ship.
----Blackrock Deckhand
local specWarnEarthenbarrier			= mod:NewSpecialWarningInterrupt("OptionVersion2", 158708, "-Healer", nil, nil, nil, nil, 2)
----Shattered Hand Deckhand
local specWarnDeadlyThrow				= mod:NewSpecialWarningSpell(158692, "Tank")
local specWarnFixate					= mod:NewSpecialWarningYou(158702)
----Bleeding Hollow Deckhand
local specWarnCorruptedBlood			= mod:NewSpecialWarningMove(158683)
--Ground
----Admiral Gar'an
local specWarnRapidFire					= mod:NewSpecialWarningRun(156631, nil, nil, nil, 4, nil, 2)
local yellRapidFire						= mod:NewYell(156631)
local specWarnPenetratingShot			= mod:NewSpecialWarningYou(164271)
local yellPenetratingShot				= mod:NewYell(164271)
local specWarnDeployTurret				= mod:NewSpecialWarningSwitch("OptionVersion2", 158599, "Dps", nil, nil, 2, nil, 2)--Switch warning since most need to switch and kill, but on for EVERYONE because tanks/healers need to avoid it while it's up
----Enforcer Sorka
local specWarnBladeDash					= mod:NewSpecialWarningYou(155794)
local specWarnBladeDashOther			= mod:NewSpecialWarningClose(155794)
local specWarnConvulsiveShadows			= mod:NewSpecialWarningMoveAway(156214, nil, nil, nil, nil, nil, 2)--Does this still drop lingering shadows, if not moveaway is not appropriate
local yellConvulsiveShadows				= mod:NewYell(156214, nil, false)
local specWarnDarkHunt					= mod:NewSpecialWarningTarget(158315, false, nil, nil, nil, nil, 2)--Healer may want this, or raid leader
----Marak the Blooded
local specWarnBloodRitual				= mod:NewSpecialWarningYou(158078)
local specWarnBloodRitualOther			= mod:NewSpecialWarningTarget("OptionVersion2", 158078, "Tank")
local yellBloodRitual					= mod:NewYell(158078)
local specWarnBloodsoakedHeartseeker	= mod:NewSpecialWarningRun(158010, nil, nil, nil, 4, nil, 2)
local yellHeartseeker					= mod:NewYell(158010, nil, false)

--Ship
mod:AddTimerLine(Ship)
local timerShipCD						= mod:NewNextTimer(198, "ej10019", nil, nil, nil, 76204)
local timerBombardmentAlphaCD			= mod:NewNextTimer(18, 157854)
local timerWarmingUp					= mod:NewCastTimer(90, 158849)--Word is not good.
--Ground
----Admiral Gar'an
mod:AddTimerLine(Garan)
local timerRapidFireCD					= mod:NewCDTimer(30.5, 156626)
local timerDarkHuntCD					= mod:NewCDTimer("OptionVersion2", 13.5, 158315, nil, false)--Important to know you have it, not very important to know it's coming soon.
local timerPenetratingShotCD			= mod:NewCDTimer(30, 164271)--22-30 at least. maybe larger variation. Just small LFR sample size.
----Enforcer Sorka
mod:AddTimerLine(Sorka)
local timerBloodRitualCD				= mod:NewNextTimer(21, 158078)
local timerConvulsiveShadowsCD			= mod:NewNextTimer(56.5, 156214)--Timer only enabled on mythicOn non mythic, it's just an unimportant dot. On mythic, MUCH more important because user has to run out of raid and get dispelled.
----Marak the Blooded
mod:AddTimerLine(Marak)
local timerBladeDashCD					= mod:NewNextTimer("OptionVersion2", 21.5, 155794, nil, "Ranged")
local timerHeartSeekerCD				= mod:NewNextTimer("OptionVersion2", 74, 158010, nil, "Ranged")--Seriously a 74 second cd?

local voiceRapidFire					= mod:NewVoice(156631) --runout
local voiceBloodRitual					= mod:NewVoice(158078, "Melee") --158078.ogg, farawayfromline
local voiceHeartSeeker					= mod:NewVoice(158010) --spread
local voiceShip							= mod:NewVoice("ej10019") --1695uktar, 1695gorak, 1695ukurogg
local voiceEarthenbarrier				= mod:NewVoice(158708)  --int
--local voiceSanguineStrikes			= mod:NewVoice(156601, "Healer")) --healteam
local voiceDeployTurret					= mod:NewVoice(158599, "Dps") --158599.ogg attack turret
local voiceConvulsiveShadows			= mod:NewVoice(156214) --runaway, target
local voiceDarkHunt						= mod:NewVoice(158315) --defensive, target

mod:AddSetIconOption("SetIconOnRapidFire", 156626, true)
mod:AddSetIconOption("SetIconOnBloodRitual", 158078, true)
mod:AddSetIconOption("SetIconOnHeartSeeker", 158010, true)

mod.vb.phase = 1
mod.vb.ship = 0
mod.vb.alphaOmega = 0

local UnitPosition, GetTime =  UnitPosition, GetTime
local savedAbilityTime = {}
local below25 = false
local playerOnBoat = false

local function isPlayerOnBoat()
	local x, y = GetPlayerMapPosition("player")
	local _, y = UnitPosition("player")
	if y < 3196 then
		return false
	else
		return true
	end
end

local function checkBoatPlayer(self)
	for uId in DBM:GetGroupMembers() do 
		local _, y, _, playerMapId = UnitPosition(uId)
		if playerMapId == 1205 then
			local x, y = GetPlayerMapPosition(uId)
			if y > 3196 then--found player on boat
				self:Schedule(1, checkBoatPlayer, self)
				return
			end
		end
	end
	timerBombardmentAlphaCD:Cancel()
	timerWarmingUp:Cancel()
end

local function recoverTimers()
	timerBombardmentAlphaCD:Cancel()
	timerWarmingUp:Cancel()
	if savedAbilityTime["BloodRitual"] and (GetTime() - savedAbilityTime["BloodRitual"]) < 21 then
		timerBloodRitualCD:Update(GetTime() - savedAbilityTime["BloodRitual"], 21)
	end
	if savedAbilityTime["RapidFire"] and (GetTime() - savedAbilityTime["RapidFire"]) < 30.5 then
		timerRapidFireCD:Update(GetTime() - savedAbilityTime["RapidFire"], 30.5)
	end
	if savedAbilityTime["BladeDash"] and (GetTime() - savedAbilityTime["BladeDash"]) < 21.5 then
		timerBladeDashCD:Update(GetTime() - savedAbilityTime["BladeDash"], 21.5)
	end
	if savedAbilityTime["HeartSeeker"] and (GetTime() - savedAbilityTime["HeartSeeker"]) < 74 then
		timerHeartSeekerCD:Update(GetTime() - savedAbilityTime["HeartSeeker"], 74)
	end
	if savedAbilityTime["ConvulsiveShadows"] and (GetTime() - savedAbilityTime["ConvulsiveShadows"]) < 56.5 then
		timerConvulsiveShadowsCD:Update(GetTime() - savedAbilityTime["ConvulsiveShadows"], 56.5)
	end
	if savedAbilityTime["PenetratingShot"] and (GetTime() - savedAbilityTime["PenetratingShot"]) < 30 then
		timerPenetratingShotCD:Update(GetTime() - savedAbilityTime["PenetratingShot"], 30)
	end
end

function mod:BladeDashTarget(targetname, uId)
	warnBladeDash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBladeDash:Show()
	elseif self:CheckNearby(8, targetname) then
		specWarnBladeDashOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.ship = 0
	self.vb.alphaOmega = 1
	below25 = false
	playerOnBoat = false
	timerBloodRitualCD:Start(5-delay)
	timerBladeDashCD:Start(11-delay)
	timerRapidFireCD:Start(16-delay)
	timerShipCD:Start(60-delay)
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT boss1 boss2 boss3",
		"UNIT_POWER_FREQUENT player"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 158078 then
		savedAbilityTime["BloodRitual"] = GetTime()
		if noFilter or not isPlayerOnBoat() then--Blood Ritual. Still safest way to start timer, in case no sync
			timerBloodRitualCD:Start()
		end
	elseif spellId == 156626 then--Rapid Fire. Still safest way to start timer, in case no sync
		savedAbilityTime["RapidFire"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			timerRapidFireCD:Start()
		end
	elseif spellId == 158599 and (noFilter or not isPlayerOnBoat()) then
		specWarnDeployTurret:Show()
		voiceDeployTurret:Play("158599")
	elseif spellId == 155794 then
		savedAbilityTime["BladeDash"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			self:BossTargetScanner(77231, "BladeDashTarget", 0.1, 16)
			timerBladeDashCD:Start()
		end
	elseif spellId == 158008 then
		savedAbilityTime["HeartSeeker"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			timerHeartSeekerCD:Start()
		end
	--Begin Deck Abilities
	elseif spellId == 158708 and (noFilter or isPlayerOnBoat()) then
		specWarnEarthenbarrier:Show(args.sourceName)
		voiceEarthenbarrier:Play("kickcast")
	elseif spellId == 158707 and (noFilter or isPlayerOnBoat()) then
		warnProtectiveEarth:Show()
	elseif spellId == 158692 and (noFilter or isPlayerOnBoat()) then
		warnDeadlyThrow:Show()
		specWarnDeadlyThrow:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 157854 then
		savedAbilityTime["BombardmentAlpha"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			specWarnBombardmentAlpha:Show(self.vb.alphaOmega)
			timerBombardmentAlphaCD:Start()
		end
	elseif spellId == 157886 and (noFilter or not isPlayerOnBoat()) then
		specWarnBombardmentOmega:Show(self.vb.alphaOmega)
		self.vb.alphaOmega = self.vb.alphaOmega + 1
	elseif spellId == 156109 and self:IsMythic() then
		savedAbilityTime["ConvulsiveShadows"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			timerConvulsiveShadowsCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 164271 then
		savedAbilityTime["PenetratingShot"] = GetTime()
		if noFilter or not isPlayerOnBoat() then
			warnPenetratingShot:Show(args.destName)
			timerPenetratingShotCD:Start()
			if args:IsPlayer() then
				specWarnPenetratingShot:Show()
				yellPenetratingShot:Yell()
			end
		end
	elseif spellId == 156214 and (noFilter or not isPlayerOnBoat()) then
		warnConvulsiveShadows:CombinedShow(0.5, args.destName)--Combined because a bad lingeringshadows drop may have multiple.
		if args:IsPlayer() and self:IsMythic() then
			specWarnConvulsiveShadows:Show()
			yellConvulsiveShadows:Yell()
			voiceConvulsiveShadows:Play("runaway")
		end
	elseif spellId == 158315 and (noFilter or not isPlayerOnBoat()) then
		warnDarkHunt:Show(args.destName)
		specWarnDarkHunt:Show(args.destName)
		timerDarkHuntCD:Start() --8s
		if args:IsPlayer() then
			voiceDarkHunt:Schedule(3, "defensive") --if a countdown is added for this spell, change schedule time to 1.5s
		end
	elseif spellId == 158010 and (noFilter or not isPlayerOnBoat()) then
		warnBloodsoakedHeartseeker:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBloodsoakedHeartseeker:Show()
			yellHeartseeker:Yell()
			voiceHeartSeeker:Play("scatter")
		end
		if self.Options.SetIconOnHeartSeeker then
			self:SetSortedIcon(1, args.destName, 3, 3)
		end
	elseif spellId == 159724 and (noFilter or not isPlayerOnBoat()) then
		warnBloodRitual:Show(args.destName)
		specWarnBloodRitualOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnBloodRitual:Show()
			yellBloodRitual:Yell()
			voiceBloodRitual:Play("158078")
		end
		if self.Options.SetIconOnBloodRitual then
			self:SetIcon(args.destName, 2)
		end
	elseif spellId == 156631 and (noFilter or not isPlayerOnBoat()) then
		if self:AntiSpam(5, args.destName) then--check antispam so we don't warn if we got a user sync 3 seconds ago.
			warnRapidFire:Show(args.destName)
			if self.Options.SetIconOnRapidFire then
				self:SetIcon(args.destName, 1, 7)
			end
		end
	elseif spellId == 156601 then
		warnSanguineStrikes:Show(args.destName)
		--voiceSanguineStrikes:Play("healall")
	--Begin Deck Abilities
	elseif spellId == 158702 and (noFilter or isPlayerOnBoat()) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then--it spams sometimes
			specWarnFixate:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159724 and self.Options.SetIconOnBloodRitual then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 158683 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnCorruptedBlood:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 77477 then--Marak
		timerBloodRitualCD:Cancel()
		timerHeartSeekerCD:Cancel()
	elseif cid == 77557 then--Gar'an
		timerRapidFireCD:Cancel()
		timerPenetratingShotCD:Cancel()
	elseif cid == 77231 then--Sorka
		timerBladeDashCD:Cancel()
		timerConvulsiveShadowsCD:Cancel()
		timerDarkHuntCD:Cancel()
	end
end

--Rapid fire is still 3 seconds faster to use emote instead of debuff.
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:156626") then
		specWarnRapidFire:Show()
		yellRapidFire:Yell()
		voiceRapidFire:Play("runout")
		self:SendSync("RapidFireTarget", UnitGUID("player"))
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc)
	if msg:find(L.shipMessage) then
		self:SendSync("Ship", npc)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 158849 then
		timerWarmingUp:Start()
		self:Schedule(25, checkBoatPlayer, self)
	end
end

function mod:OnSync(msg, guid)
	if not self:IsInCombat() then return end
	if (not DBM.Options.DontShowFarWarnings or isPlayerOnBoat()) then return end--Anything below this line doesn't concern people on boat
	if msg == "RapidFireTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		if self:AntiSpam(5, targetName) then--Set antispam if we got a sync, to block 3 second late SPELL_AURA_APPLIED if we got the early warning
			warnRapidFire:Show(targetName)
			if self.Options.SetIconOnRapidFire then
				self:SetIcon(targetName, 1, 10)
			end
		end
	elseif msg == "Ship" and guid then--technically not guid but it's fine.
		self.vb.ship = self.vb.ship + 1
		self.vb.alphaOmega = 1
		warnShip:Show()
		if self.vb.ship < 3 then
			timerShipCD:Start()
		end
		timerBombardmentAlphaCD:Start(15)
		if guid == Marak then
			timerBloodRitualCD:Cancel()
			timerHeartSeekerCD:Cancel()
			voiceShip:Play("1695ukurogg")
		elseif guid == Sorka then
			timerBladeDashCD:Cancel()
			timerConvulsiveShadowsCD:Cancel()
			timerDarkHuntCD:Cancel()
			voiceShip:Play("1695gorak")
		elseif guid == Garan then
			timerRapidFireCD:Cancel()
			timerPenetratingShotCD:Cancel()
			voiceShip:Play("1695uktar")
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	local hp = UnitHealth(uId) / UnitHealthMax(uId)
	if hp < 0.25 and not below25 then
		below25 = true
		timerShipCD:Cancel()
		warnPhase2p:Show()
	elseif hp < 0.20 and not self.vb.phase == 2 then
		self.vb.phase = 2
		warnPhase2:Show()
		self:UnregisterShortTermEvents()
	end
end

function mod:UNIT_POWER_FREQUENT(_, powerType)
	if powerType ~= "ALTERNATE" then return end
	local power = UnitPower("player", 10)
	if power == 1 and not playerOnBoat then -- on boat
		playerOnBoat = true
		timerBloodRitualCD:Cancel()
		timerRapidFireCD:Cancel()
		timerBladeDashCD:Cancel()
		timerHeartSeekerCD:Cancel()
		timerConvulsiveShadowsCD:Cancel()
		timerPenetratingShotCD:Cancel()
	elseif power == 0 and playerOnBoat then -- leave boat
		playerOnBoat = false
		recoverTimers()
	end
end
