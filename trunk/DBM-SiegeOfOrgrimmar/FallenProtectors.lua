local mod	= DBM:NewMod(849, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71479, 71475, 71480)--He-Softfoot, Rook Stonetoe, Sun Tenderheart
mod:SetEncounterID(1598)
mod:SetZone()
mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 143958 143330 143446 143491 143961 143962 143497 144396",
	"SPELL_CAST_SUCCESS 143027 143423",
	"SPELL_AURA_APPLIED 143959 143301 143198 143840 143546 143955 143812 143423",
	"SPELL_AURA_REMOVED 143546 143955 143812",
	"SPELL_DAMAGE 144357 144367 143009",
	"SPELL_MISSED 144357 144367 143009",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3",
	"UNIT_HEALTH_FREQUENT boss1 boss2 boss3 boss4 boss5"
)

local Softfoot = EJ_GetSectionInfo(7889)
local Stonetoe = EJ_GetSectionInfo(7885)
local Tenderheart = EJ_GetSectionInfo(7904)

mod:SetBossHealthInfo(
	71479, Softfoot,
	71475, Stonetoe,
	71480, Tenderheart
)

--All
local warnBondGoldenLotus			= mod:NewCastAnnounce(143497, 4)
--Rook Stonetoe
local warnVengefulStrikes			= mod:NewSpellAnnounce(144396, 3, nil, mod:IsTank())
local warnCorruptedBrew				= mod:NewTargetAnnounce(143019, 2)--I do believe target scanning WILL work here, i just need more time to mess with it next round of testing
local warnClash						= mod:NewSpellAnnounce(143027, 3)--No target scanning, no emote, no warning of any kind that gave me a target :\
----Rook Stonetoe's Desperate Measures (66% and 33%)
local warnMiserySorrowGloom			= mod:NewSpellAnnounce(143955, 2)--Activation
local warnCorruptionShock			= mod:NewSpellAnnounce(143958, 3)--Embodied Gloom (spammy if you do it wrong, but very important everyone sees. SOMEONE needs to interrupt it if it keeps going off)
local warnDefiledGround				= mod:NewSpellAnnounce(143961, 3, nil, mod:IsTank())--Embodied Misery
local warnInfernoStrike				= mod:NewTargetAnnounce(143962, 3)
--He Softfoot
local warnGouge						= mod:NewCastAnnounce(143330, 4, nil, nil, mod:IsTank())--The cast, so you can react and turn back to it and avoid stun.
local warnGougeStun					= mod:NewTargetAnnounce(143301, 4, nil, mod:IsTank())--Failed, stunned. the success ID is 143331 (knockback)
local warnGarrote					= mod:NewTargetAnnounce(143198, 3, nil, mod:IsHealer())
----He Softfoot's Desperate Measures
local warnMarkOfAnguish				= mod:NewSpellAnnounce(143812, 2)--Activation
local warnMarked					= mod:NewTargetAnnounce(143840, 3)--Embodied Anguish			
--Sun Tenderheart
local warnShaShear					= mod:NewCastAnnounce(143423, 3, 5, nil, false)
local warnBane						= mod:NewCastAnnounce(143446, 4, nil, nil, mod:IsHealer())
local warnCalamity					= mod:NewAnnounce("warnCalamity", 4, 143491, nil, DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(143491))
----Sun Tenderheart's Desperate Measures
local warnDarkMeditation			= mod:NewSpellAnnounce(143546, 2)--Activation

--All
local specWarnMeasures				= mod:NewSpecialWarning("specWarnMeasures", nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon:format("ej7956"))
--Rook Stonetoe
local specWarnVengefulStrikes		= mod:NewSpecialWarningSpell(144396, mod:IsTank())
local specWarnClash					= mod:NewSpecialWarningYou(143027)
local specWarnKick					= mod:NewSpecialWarningMove(143007, not mod:IsTank())
local specWarnCorruptedBrew			= mod:NewSpecialWarningYou(143019)
local yellCorruptedBrew				= mod:NewYell(143019)
local specWarnCorruptedBrewNear		= mod:NewSpecialWarningClose(143019)
----Rook Stonetoe's Desperate Measures
local specWarnMiserySorrowGloom		= mod:NewSpecialWarningSpell(143955)
local specWarnCorruptionShock		= mod:NewSpecialWarningInterrupt(143958, mod:IsMelee())
local specWarnDefiledGround			= mod:NewSpecialWarningMove(143959)
local specWarnInfernoStrike			= mod:NewSpecialWarningYou(143962)
local yellInfernoStrike				= mod:NewYell(143962)
--He Softfoot
local specWarnGouge					= mod:NewSpecialWarningMove(143330, mod:IsTank(), nil, nil, 3)--Maybe localize it as a "turn away" warning.
local specWarnGougeStunOther		= mod:NewSpecialWarningTarget(143301, mod:IsTank())--Tank is stunned, other tank must taunt or he'll start killing people
local specWarnNoxiousPoison			= mod:NewSpecialWarningMove(144367)
----He Softfoot's Desperate measures
local specWarnMarkOfAnquish			= mod:NewSpecialWarningSpell(143812)
local specWarnMarked				= mod:NewSpecialWarningYou(143840)
local yellMarked					= mod:NewYell(143840, nil, false)
--Sun Tenderheart
local specWarnShaShear				= mod:NewSpecialWarningInterrupt(143423, false)
local specWarnShaShearYou			= mod:NewSpecialWarningMoveAway(143423)--some heroic player request. Warning to move away from group so Sha shear not hit everyone.
local yellShaShear					= mod:NewYell(143423)
local specWarnCalamity				= mod:NewSpecialWarning("specWarnCalamity", nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(143491), nil, 2)
----Sun Tenderheart's Desperate Measures
local specWarnDarkMeditation		= mod:NewSpecialWarningSpell(143546)

--Rook Stonetoe
local timerVengefulStrikesCD		= mod:NewCDTimer(21, 144396, nil, mod:IsTank())
local timerCorruptedBrewCD			= mod:NewCDTimer(11, 143019)--11-27
local timerClashCD					= mod:NewCDTimer(46, 143027)--46 second next timer IF none of bosses enter a special between casts, otherwise always delayed by specials (and usually cast within 5 seconds after special ends)
----Rook Stonetoe's Desperate Measures
local timerDefiledGroundCD			= mod:NewCDTimer(10.5, 143961, nil, mod:IsTank())
local timerInfernoStrikeCD			= mod:NewNextTimer(9.5, 143962)
local timerInfernoStrike			= mod:NewBuffFadesTimer(7.7, 143962)
--He Softfoot
local timerGougeCD					= mod:NewCDTimer(30, 143330, nil, mod:IsTank())--30-41
local timerGarroteCD				= mod:NewCDTimer(29, 143198, nil, mod:IsHealer())--30-46 (heroic 20-26)
--Sun Tenderheart
local timerBaneCD					= mod:NewCDTimer(17, 143446, nil, mod:IsHealer())--17-25 (heroic 13-20)
local timerCalamity					= mod:NewCastTimer(5, 143491, nil, mod:IsHealer())
local timerCalamityCD				= mod:NewCDTimer(40, 143491, nil, mod:IsHealer())--40-50 (when two can be cast in a row) Also affected by boss specials

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnStrike", 143962, false)
mod:AddRangeFrameOption(5, 143423, false)--For heroic. Need to chage smart range frame?

--Upvales, don't need variables
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local calamitySpellText = GetSpellInfo(143491)

--Not important, don't need to recover
local isInfernoTarget = false
--Important, needs recover
mod.vb.sorrowActive = false
mod.vb.calamityCount = 0
mod.vb.warned71475 = 0
mod.vb.warned71479 = 0
mod.vb.warned71480 = 0

function mod:BrewTarget(targetname, uId)
	if not targetname then return end
	warnCorruptedBrew:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCorruptedBrew:Show()
		yellCorruptedBrew:Yell()
	elseif self:CheckNearby(6, targetname) then
		specWarnCorruptedBrewNear:Show(targetname)
	end
end

function mod:InfernoStrikeTarget(targetname, uId)
	if not targetname then return end
	warnInfernoStrike:Show(targetname)
	if self.Options.SetIconOnStrike then
		self:SetIcon(targetname, 7, 5)
	end
	if targetname == UnitName("player") then
		isInfernoTarget = true
		specWarnInfernoStrike:Show()
		yellInfernoStrike:Yell()
		timerInfernoStrike:Start()
	else
		isInfernoTarget = false
	end
end

function mod:OnCombatStart(delay)
	isInfernoTarget = false
	self.vb.calamityCount = 0
	self.vb.warned71475 = 0
	self.vb.warned71479 = 0
	self.vb.warned71480 = 0
	timerVengefulStrikesCD:Start(7-delay)
	timerGarroteCD:Start(15-delay)
	timerBaneCD:Start(15-delay)
	timerCorruptedBrewCD:Start(18-delay)
	timerGougeCD:Start(23-delay)
	timerCalamityCD:Start(31-delay)
	timerClashCD:Start(45-delay)
	if self:IsHeroic() then
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(900-delay)--15min confirmed in LFR, flex, normal
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 143958 then
		local source = args.sourceName
		warnCorruptionShock:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnCorruptionShock:Show(source)
		end
	elseif spellId == 143330 then
		warnGouge:Show()
		timerGougeCD:Start()
	elseif spellId == 143446 then
		warnBane:Show()
		if self:IsHeroic() then
			timerBaneCD:Start(13)--TODO, verify normal to see if it was changed too
		else
			timerBaneCD:Start()
		end
	elseif spellId == 143491 then
		local perText = ""
		if self:IsHeroic() then
			self.vb.calamityCount = self.vb.calamityCount + 1
			perText = " ("..((self.vb.calamityCount + 2) * 10).."%)"
		end
		local displayText = calamitySpellText..perText
		warnCalamity:Show(displayText)
		specWarnCalamity:Show(displayText.."!")
		timerCalamity:Start()
		timerCalamityCD:Start()
	elseif spellId == 143961 then
		warnDefiledGround:Show()
		timerDefiledGroundCD:Start()
	elseif spellId == 143962 then
		timerInfernoStrikeCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "InfernoStrikeTarget")
	elseif spellId == 143497 then
		warnBondGoldenLotus:Show()
	elseif spellId == 144396 then
		warnVengefulStrikes:Show()
		timerVengefulStrikesCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnVengefulStrikes:Show()--So show tank warning
				break
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 143027 then
		warnClash:Show()
		timerClashCD:Start()
		if args:IsPlayer() then
			specWarnClash:Show()
		end
	elseif spellId == 143423 then
		local source = args.sourceName
		if source == UnitName("target") or source == UnitName("focus") then--Only warn if your target or focus, period, because if you aren't actually dpsing her, you just stay out of melee range and ignore this
			warnShaShear:Show()
			specWarnShaShear:Show(source)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 143959 and args:IsPlayer() and self:AntiSpam(1.5, 2) then
		specWarnDefiledGround:Show()
	elseif spellId == 143301 then--Stun debuff spellid
		warnGougeStun:Show(args.destName)
		if not args:IsPlayer() then
			specWarnGougeStunOther:Show(args.destName)
		end
	elseif spellId == 143198 then
		warnGarrote:CombinedShow(1, args.destName)
		if self:IsHeroic() then
			timerGarroteCD:DelayedStart(1, 20)--TODO, see if it's cast more often on heroic only, or if normal was also changed to 20
		else
			timerGarroteCD:DelayedStart(1)
		end
	elseif spellId == 143840 then
		warnMarked:Show(args.destName)
		if args:IsPlayer() then
			specWarnMarked:Show(args.destName)
			yellMarked:Yell()
		end
	--Special phases
	elseif spellId == 143546 then--Dark Meditation
		self.vb.calamityCount = 0
		warnDarkMeditation:Show()
		specWarnDarkMeditation:Show()
		timerBaneCD:Cancel()
		timerCalamity:Cancel()
		timerCalamityCD:Cancel()
	elseif spellId == 143955 then--Misery, Sorrow, and Gloom
		self.vb.sorrowActive = true
		warnMiserySorrowGloom:Show()
		specWarnMiserySorrowGloom:Show()
		timerVengefulStrikesCD:Cancel()
		timerClashCD:Cancel()
		timerCorruptedBrewCD:Cancel()
		timerInfernoStrikeCD:Start(8)
		timerDefiledGroundCD:Start(10)
		self:RegisterShortTermEvents(
			"UNIT_DIED"--We register here to make sure we wipe variables on pull
		)
	elseif spellId == 143812 then--Mark of Anguish
		warnMarkOfAnguish:Show()
		specWarnMarkOfAnquish:Show()
		timerGougeCD:Cancel()
		timerGarroteCD:Cancel()
		timerCalamityCD:Cancel()--Can't be cast during THIS special
	elseif spellId == 143423 and args:IsPlayer() and self.vb.sorrowActive and not self:IsDifficulty("lfr25") and not isInfernoTarget then
		specWarnShaShearYou:Show()
		yellShaShear:Yell()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 143546 then--Dark Meditation
		timerBaneCD:Start(10)
		timerCalamityCD:Start(23)--Now back to not cast right away again.
	elseif spellId == 143955 then--Misery, Sorrow, and Gloom
		self.vb.sorrowActive = false--Just in case UNIT_DIED doesn't fire.
		timerDefiledGroundCD:Cancel()
		timerInfernoStrikeCD:Cancel()
		timerInfernoStrike:Cancel()
		timerCorruptedBrewCD:Start(12)
		timerVengefulStrikesCD:Start(18)
		timerClashCD:Start(46)
		self:UnregisterShortTermEvents()
	elseif spellId == 143812 then--Mark of Anguish
		timerGarroteCD:Start(12)--TODO, verify consistency in all difficulties
		timerGougeCD:Start(23)--Seems to be either be exactly 23 or exactly 35. Not sure what causes it to switch.
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 144357 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 3) then
		specWarnDefiledGround:Show()
	elseif spellId == 144367 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 4) then
		specWarnNoxiousPoison:Show()
	elseif spellId == 143009 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 5) then
		specWarnKick:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71481 then--Sorrow
		self.vb.sorrowActive = false
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:143330") then--Emote giving ONLY to the person tanking boss. Better than scanning boss 1-5 for this one which fails from time to time
		specWarnGouge:Show()--So show tank warning
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143019 then--Does not show in combat log on normal
		self:BossTargetScanner(71475, "BrewTarget", 0.025)
		timerCorruptedBrewCD:Start()
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	if self.vb.warned71475 == 2 and self.vb.warned71479 == 2 and self.vb.warned71480 == 2 then return end
	local cId = self:GetUnitCreatureId(uId)
	if cId == 71475 or cId == 71479 or cId == 71480 then
		local hp = UnitHealth(uId) / UnitHealthMax(uId)
		if hp < 0.71 and self.vb["warned"..cId] == 0 then
			local bossName = UnitName(uId)
			specWarnMeasures:Show(bossName)
			self.vb["warned"..cId] = 1
		elseif hp < 0.37 and self.vb["warned"..cId] == 1 then
			local bossName = UnitName(uId)
			specWarnMeasures:Show(bossName)
			self.vb["warned"..cId] = 2
		end
	end
end
