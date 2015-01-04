local mod	= DBM:NewMod(1203, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77557, 77231, 77477)
mod:SetEncounterID(1695)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158695 158708 158707 158710 158692 158599 155794 158078 156626 158008",
	"SPELL_CAST_SUCCESS 158701 157854 157886 156109",
	"SPELL_AURA_APPLIED 158702 164271 156214 158315 158010 159724 156631 156601",
	"SPELL_AURA_REMOVED 159724",
	"SPELL_PERIODIC_DAMAGE 158683",
	"SPELL_PERIODIC_MISSED 158683",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, find out how many bombardments there are so timer doesn't start after last one.
--TODO, timer recovery when leaving boat back to main platform (how do we detect leaving boat? never gotten a log where people return.)
--TODO, find a way to detect BOSS returning from boat so timers for that boss can be started up again.
--TODO, figure out why boat filter isn't working correctly (might be fixed by most recent changes though, so needs reverification
--TODO, see if one of bosses hitting 20% before 3rd ship, cancels first ship (because ships are 10, 40 and 70 energy, but bosses skip to 100 energy if any of them hit 20%)
--TODO, add timers for deck abilities that need them.
--Ship
local warnShip							= mod:NewSpellAnnounce("ej10019", 3, 76204)
local warnBombardmentAlpha				= mod:NewSpellAnnounce(157854, 3)--From ship, but affects NON ship.
local warnBombardmentOmega				= mod:NewSpellAnnounce(157886, 4)--From ship, but affects NON ship.
----Blackrock Deckhand
local warnGrapeshotBlast				= mod:NewSpellAnnounce(158695, 3)--Could not verify
local warnEarthenBarrier				= mod:NewSpellAnnounce(158708, 3)
local warnProtectiveEarth				= mod:NewSpellAnnounce(158707, 3)--Could not verify
local warnChainLightning				= mod:NewSpellAnnounce(158710, 3)--Could not verify
----Shattered Hand Deckhand
local warnDeadlyThrow					= mod:NewSpellAnnounce(158692, 3)
local warnCallforReinforcements			= mod:NewSpellAnnounce(158701, 2)--Could not verify
local warnFixate						= mod:NewTargetAnnounce(158702, 3)
--Ground
----Admiral Gar'an
local warnRapidFire						= mod:NewTargetAnnounce(156631, 4)
local warnPenetratingShot				= mod:NewTargetAnnounce(164271, 3)--Could not verify
local warnDeployTurret					= mod:NewSpellAnnounce(158599, 3)--Could not verify
----Enforcer Sorka
local warnBladeDash						= mod:NewTargetAnnounce(155794, 3)
local warnConvulsiveShadows				= mod:NewTargetAnnounce(156214, 3)
local warnDarkHunt						= mod:NewTargetAnnounce(158315, 4)--Could not verify
----Marak the Blooded
local warnBloodRitual					= mod:NewTargetAnnounce(158078, 3)
local warnBloodsoakedHeartseeker		= mod:NewTargetAnnounce(158010, 4)
local warnSanguineStrikes				= mod:NewTargetAnnounce(156601, 3, nil, mod:IsHealer())

--Ship
local specWarnBombardmentAlpha			= mod:NewSpecialWarningSpell(157854, nil, nil, nil, 2)--From ship, but affects NON ship.
local specWarnBombardmentOmega			= mod:NewSpecialWarningSpell(157886, nil, nil, nil, 3)--From ship, but affects NON ship.
----Blackrock Deckhand
local specWarnEarthenbarrier			= mod:NewSpecialWarningInterrupt(158708)
----Shattered Hand Deckhand
local specWarnDeadlyThrow				= mod:NewSpecialWarningSpell(158692, mod:IsTank())
local specWarnFixate					= mod:NewSpecialWarningYou(158702)
----Bleeding Hollow Deckhand
local specWarnCorruptedBlood			= mod:NewSpecialWarningMove(158683)
--Ground
----Admiral Gar'an
local specWarnRapidFire					= mod:NewSpecialWarningRun(156631, nil, nil, nil, 4)
local yellRapidFire						= mod:NewYell(156631)
local specWarnPenetratingShot			= mod:NewSpecialWarningYou(164271)
local yellPenetratingShot				= mod:NewYell(164271)
local specWarnDeployTurret				= mod:NewSpecialWarningSwitch(158599, nil, nil, nil, 2)--Switch warning since most need to switch and kill, but on for EVERYONE because tanks/healers need to avoid it while it's up
----Enforcer Sorka
local specWarnBladeDash					= mod:NewSpecialWarningYou(155794)
local specWarnBladeDashOther			= mod:NewSpecialWarningTarget(155794, nil, nil, nil, 2)
local specWarnConvulsiveShadows			= mod:NewSpecialWarningMoveAway(156214)--Does this still drop lingering shadows, if not moveaway is not appropriate
local yellConvulsiveShadows				= mod:NewYell(156214, nil, false)
local specWarnDarkHunt					= mod:NewSpecialWarningTarget(158315, false)--Healer may want this, or raid leader
----Marak the Blooded
local specWarnBloodRitual				= mod:NewSpecialWarningYou(158078)
local specWarnBloodRitualOther			= mod:NewSpecialWarningTarget(158078, mod:IsTank())
local yellBloodRitual					= mod:NewYell(158078)
local specWarnBloodsoakedHeartseeker	= mod:NewSpecialWarningRun(158010, nil, nil, nil, 4)
local yellHeartseeker					= mod:NewYell(158010, nil, false)
local specWarnSanguineStrikes			= mod:NewSpecialWarningTarget(156601, mod:IsHealer())

--Ship
local timerShipCD						= mod:NewNextTimer(198, "ej10019", nil, nil, nil, 76204)
local timerBombardmentAlphaCD			= mod:NewNextTimer(18, 157854)--How many times cast?
--local timerWarmingUp					= mod:NewCastTimer(90, 158849)--Could not verify
----Blackrock Deckhand
----Shattered Hand Deckhand
----Bleeding Hollow Deckhand
--Ground
----Admiral Gar'an
local timerRapidFireCD					= mod:NewNextTimer(30, 156626)
local timerDarkHuntCD					= mod:NewCDTimer(13.5, 158315)--Needs more data. it was only cast twice in entirety of my log, so space between is based off a single sample.
local timerPenetratingShotCD			= mod:NewCDTimer(22, 164271)--22-30 at least. maybe larger variation. Just small LFR sample size.
----Enforcer Sorka
local timerBloodRitualCD				= mod:NewNextTimer(12, 158078)
local timerConvulsiveShadowsCD			= mod:NewNextTimer(46.5, 156214)
----Marak the Blooded
local timerBladeDashCD					= mod:NewNextTimer(20, 155794)
local timerHeartSeekerCD				= mod:NewNextTimer(51, 158010)

mod:AddSetIconOption("SetIconOnRapidFire", 156626, true)
mod:AddSetIconOption("SetIconOnBloodRitual", 158078, true)
mod:AddSetIconOption("SetIconOnHeartSeeker", 158010, true)

local Marak = EJ_GetSectionInfo(10033)
local Sorka = EJ_GetSectionInfo(10030)
local Garan = EJ_GetSectionInfo(10025)
mod.vb.ship = 0

local GetPlayerMapPosition = GetPlayerMapPosition
local function isPlayerOnBoat()
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then
		SetMapToCurrentZone()
		x, y = GetPlayerMapPosition("player")
	end
	if x >= 0.75 then
		return false
	else
		return true
	end
end

function mod:BladeDashTarget(targetname, uId)
	warnBladeDash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBladeDash:Show()
	else
		specWarnBladeDashOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.ship = 0
	timerBloodRitualCD:Start(5-delay)
	timerBladeDashCD:Start(11-delay)
	timerRapidFireCD:Start(16-delay)
	timerShipCD:Start(60-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 158078 and (noFilter or not isPlayerOnBoat()) then--Blood Ritual. Still safest way to start timer, in case no sync
		timerBloodRitualCD:Start()
	elseif spellId == 156626 and (noFilter or not isPlayerOnBoat()) then--Rapid Fire. Still safest way to start timer, in case no sync
		timerRapidFireCD:Start()
	elseif spellId == 158599 and (noFilter or not isPlayerOnBoat()) then
		warnDeployTurret:Show()
		specWarnDeployTurret:Show()
	elseif spellId == 155794 and (noFilter or not isPlayerOnBoat()) then
		self:BossTargetScanner(77231, "BladeDashTarget", 0.1, 16)
		timerBladeDashCD:Start()
	elseif spellId == 158008 and (noFilter or not isPlayerOnBoat()) then
		timerHeartSeekerCD:Start()
	--Begin Deck Abilities
	if (noFilter or not isPlayerOnBoat()) then return end--Anything below this line doesn't concern people not on boat
	elseif spellId == 158695 then
		warnGrapeshotBlast:Show()
	elseif spellId == 158708 then
		warnEarthenBarrier:Show()
		specWarnEarthenbarrier:Show(args.sourceName)
	elseif spellId == 158707 then
		warnProtectiveEarth:Show()
	elseif spellId == 158710 then
		warnChainLightning:Show()
	elseif spellId == 158692 then
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
	if spellId == 157854 and (noFilter or not isPlayerOnBoat()) then
		warnBombardmentAlpha:Show()
		specWarnBombardmentAlpha:Show()
		timerBombardmentAlphaCD:Start()
	elseif spellId == 157886 and (noFilter or not isPlayerOnBoat()) then
		warnBombardmentOmega:Show()
		specWarnBombardmentOmega:Show()
	elseif spellId == 156109 and (noFilter or not isPlayerOnBoat()) then
		timerConvulsiveShadowsCD:Start()
	--Begin Deck Abilities
	elseif spellId == 158701 and (noFilter or isPlayerOnBoat()) then
		warnCallforReinforcements:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	local noFilter = false
	if not DBM.Options.DontShowFarWarnings then
		noFilter = true
	end
	if spellId == 164271 and (noFilter or not isPlayerOnBoat()) then
		warnPenetratingShot:Show(args.destName)
		timerPenetratingShotCD:Start()
		if args:IsPlayer() then
			specWarnPenetratingShot:Show()
			yellPenetratingShot:Yell()
		end
	elseif spellId == 156214 and (noFilter or not isPlayerOnBoat()) then
		warnConvulsiveShadows:CombinedShow(0.5, args.destName)--Combined because a bad lingeringshadows drop may have multiple.
		if args:IsPlayer() then
			specWarnConvulsiveShadows:Show()
			yellConvulsiveShadows:Yell()
		end
	elseif spellId == 158315 and (noFilter or not isPlayerOnBoat()) then
		warnDarkHunt:Show(args.destName)
		specWarnDarkHunt:Show(args.destName)
		timerDarkHuntCD:Start()
	elseif spellId == 158010 and (noFilter or not isPlayerOnBoat()) then
		warnBloodsoakedHeartseeker:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBloodsoakedHeartseeker:Show()
			yellHeartseeker:Yell()
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
		specWarnSanguineStrikes:Show(args.destName)
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
		self:SendSync("RapidFireTarget", UnitGUID("player"))
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc)
	if msg:find(L.shipMessage) then
		self:SendSync("Ship", npc)
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
		warnShip:Show()
		if self.vb.ship < 3 then
			timerShipCD:Start()
		end
		timerBombardmentAlphaCD:Start(15)
		if guid == Marak then
			timerBloodRitualCD:Cancel()
			timerHeartSeekerCD:Cancel()
		elseif guid == Sorka then
			timerBladeDashCD:Cancel()
			timerConvulsiveShadowsCD:Cancel()
			timerDarkHuntCD:Cancel()
		elseif guid == Garan then
			timerRapidFireCD:Cancel()
			timerPenetratingShotCD:Cancel()
		end
	end
end
