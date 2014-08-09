local mod	= DBM:NewMod(1203, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77557, 77231, 77477)
mod:SetEncounterID(1695)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158849 158695 158708 158707 158710 158692 156683 158599 155794 156366 158078 156626",
	"SPELL_CAST_SUCCESS 158701 157854 157886",
	"SPELL_AURA_APPLIED 158702 164271 156214 156007 158315 157950",
	"SPELL_PERIODIC_DAMAGE 158683",
	"SPELL_PERIODIC_MISSED 158683",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, find a way, either by map or unit power to filter ship deck from ground warnings
--TODO, find out how many bombardments there are so timer doesn't start after last one.
--TODO, get longer log to verify all missing drycoded abilities.
--Ship
local warnShip							= mod:NewSpellAnnounce("ej10019", 3)
local warnBombardmentAlpha				= mod:NewSpellAnnounce(157854, 3)--From ship, but affects NON ship.
local warnBombardmentOmega				= mod:NewSpellAnnounce(157886, 4)--From ship, but affects NON ship.
local warnWarmingUp						= mod:NewCastAnnounce(158849, 3)--Could not verify
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
local warnRapidFire						= mod:NewTargetAnnounce(156631, 3)
local warnIncendiaryDevice				= mod:NewSpellAnnounce(156683, 4)--Mythic. How do you determine target, must find that out!
local warnPenetratingShot				= mod:NewTargetAnnounce(164271, 3)--Could not verify
local warnDeployTurret					= mod:NewSpellAnnounce(158599, 3)--Could not verify
----Enforcer Sorka
local warnBladeDash						= mod:NewTargetAnnounce(155794, 3)
local warnConvulsiveShadows				= mod:NewTargetAnnounce(156214, 4)
local warnImpale						= mod:NewTargetAnnounce(156007, 3)--Could not verify
local warnDarkHunt						= mod:NewTargetAnnounce(158315, 4)--Could not verify
----Marak the Blooded
local warnBloodRitual					= mod:NewTargetAnnounce(158078, 3)
local warnWhirlOfBlood					= mod:NewSpellAnnounce(156366, 3)--Mythic
local warnBloodsoakedHeartseeker		= mod:NewTargetAnnounce(157950, 3)--Probably hidden from combatlog, will need alternate detection i'm sure. Blizzard likes pointless extra work.

--Ship
local specWarnWarmingUp					= mod:NewSpecialWarningSpell(158849, false)
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
local specWarnRapidFire					= mod:NewSpecialWarningYou(156631)
local yellRapidFire						= mod:NewYell(156631)
local specWarnIncendiaryDevice			= mod:NewSpecialWarningSpell(156683, nil, nil, nil, 3)
local specWarnPenetratingShot			= mod:NewSpecialWarningYou(164271)
local yellPenetratingShot				= mod:NewYell(164271)
local specWarnDeployTurret				= mod:NewSpecialWarningSpell(158599, nil, nil, nil, 2)
----Enforcer Sorka
local specWarnBladeDash					= mod:NewSpecialWarningYou(155794)
local specWarnBladeDashOther			= mod:NewSpecialWarningTarget(155794, false, nil, nil, 2)
local specWarnConvulsiveShadows			= mod:NewSpecialWarningMoveAway(156214)--Mythic
local yellConvulsiveShadows				= mod:NewYell(156214)--Mythic
local specWarnDarkHunt					= mod:NewSpecialWarningTarget(158315, false)--Healer may want this, or raid leader
----Marak the Blooded
local specWarnBloodRitual				= mod:NewSpecialWarningYou(158078)
local specWarnBloodRitualOther			= mod:NewSpecialWarningOther(158078, mod:IsTank())
local yellBloodRitual					= mod:NewYell(158078)
local specWarnWhirlOfBlood				= mod:NewSpecialWarningSpell(156366, nil, nil, nil, 2)--Mythic
local specWarnBloodsoakedHeartseeker	= mod:NewSpecialWarningYou(157950)
local yellBloodsoakedHeartseeker		= mod:NewYell(157950)

--Ship
local timerShipCD						= mod:NewNextTimer(60, "ej10019")--Only know time for first one. not time between first and second.
local timerBombardmentAlphaCD			= mod:NewNextTimer(18, 157854)--How many times cast?
local timerWarmingUp					= mod:NewCastTimer(90, 158849)--Could not verify
----Blackrock Deckhand
----Shattered Hand Deckhand
----Bleeding Hollow Deckhand
--Ground
----Admiral Gar'an
local timerRapidFireCD					= mod:NewNextTimer(30, 156626)
----Enforcer Sorka
local timerBloodRitualCD				= mod:NewNextTimer(12, 158078)
----Marak the Blooded
local timerBladeDashCD					= mod:NewNextTimer(20, 155794)

local Marak = EJ_GetSectionInfo(10033)
local Sorka = EJ_GetSectionInfo(10030)
local Garan = EJ_GetSectionInfo(10025)

function mod:BladeDashTarget(targetname, uId)
	warnBladeDash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBladeDash:Show()
	else
		specWarnBladeDashOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerBloodRitualCD:Start(6-delay)
	timerBladeDashCD:Start(11-delay)
	timerRapidFireCD:Start(16-delay)
	timerShipCD:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156683 then
		warnIncendiaryDevice:Show()
		specWarnIncendiaryDevice:Show()
	elseif spellId == 158078 then--Blood Ritual. Still safest way to start timer, in case no sync
		timerBloodRitualCD:Start()
	elseif spellId == 156626 then--Rapid Fire. Still safest way to start timer, in case no sync
		timerRapidFireCD:Start()
	elseif spellId == 158599 then
		warnDeployTurret:Show()
		specWarnDeployTurret:Show()
	elseif spellId == 155794 then
		self:BossTargetScanner(77231, "BladeDashTarget", 0.1, 16)
		timerBladeDashCD:Start()
	elseif spellId == 156366 then
		warnWhirlOfBlood:Show()
		specWarnWhirlOfBlood:Show()
	--Begin Deck Abilities
	elseif spellId == 158849 then
		warnWarmingUp:Show()
		specWarnWarmingUp:Show()
		timerWarmingUp:Start()
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
	if spellId == 157854 then
		warnBombardmentAlpha:Show()
		specWarnBombardmentAlpha:Show()
		timerBombardmentAlphaCD:Start()
	elseif spellId == 157886 then
		warnBombardmentOmega:Show()
		specWarnBombardmentOmega:Show()
	--Begin Deck Abilities
	elseif spellId == 158701 then
		warnCallforReinforcements:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 164271 then
		warnPenetratingShot:Show(args.destName)
		if args:IsPlayer() then
			specWarnPenetratingShot:Show()
			yellPenetratingShot:Yell()
		end
	elseif spellId == 156214 then
		warnConvulsiveShadows:Show(args.destName)
		if args:IsPlayer() then
			specWarnConvulsiveShadows:Show()
			yellConvulsiveShadows:Yell()
		end
	elseif spellId == 156007 then
		warnImpale:Show(args.destName)
	elseif spellId == 158315 then
		warnDarkHunt:Show(args.destName)
		specWarnDarkHunt:Show()
	elseif spellId == 157950 then
		warnBloodsoakedHeartseeker:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBloodsoakedHeartseeker:Show()
			yellBloodsoakedHeartseeker:Yell()
		end
	--Begin Deck Abilities
	elseif spellId == 158702 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then--it spams sometimes
			specWarnFixate:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 158683 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnCorruptedBlood:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Neither one of these show in combat log at all. What else is new
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:158079") then
		specWarnBloodRitual:Show()
		yellBloodRitual:Yell()
		self:SendSync("BloodRitualTarget", UnitGUID("player"))
	elseif msg:find("spell:156626") then
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
	if msg == "BloodRitualTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnBloodRitual:Show(targetName)
		specWarnBloodRitualOther:Show(targetName)
	elseif msg == "RapidFireTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnRapidFire:Show(targetName)
	elseif msg == "Ship" and guid then--Techbucakkt not guid but it's fine.
		warnShip:Show()
		timerBombardmentAlphaCD:Start(15)
		if guid == Marak then
			timerBloodRitualCD:Cancel()
		elseif guid == Sorka then
			timerBladeDashCD:Cancel()
		elseif guid == Garan then
			timerRapidFireCD:Cancel()
		end
	end
end
