local mod	= DBM:NewMod(849, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71479, 71475, 71480)--He-Softfoot, Rook Stonetoe, Sun Tenderheart
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)


--All
local warnBondGoldenLotus			= mod:NewCastAnnounce(143497, 4)
--Rook Stonetoe
local warnVengefulStrikes			= mod:NewSpellAnnounce(144396, 3, nil, mod:IsTank())
local warnCorruptedBrew				= mod:NewSpellAnnounce(143019, 2)--I do believe target scanning WILL work here, i just need more time to mess with it next round of testing
local warnClash						= mod:NewSpellAnnounce(143027, 3)--No target scanning, no emote, no warning of any kind that gave me a target :\
----Rook Stonetoe's Desperate Measures (66% and 33%)
local warnMiserySorrowGloom			= mod:NewSpellAnnounce(143955, 2)--Activation
local warnCorruptionShock			= mod:NewSpellAnnounce(143958, 3)--Embodied Gloom (spammy if you do it wrong, but very important everyone sees. SOMEONE needs to interrupt it if it keeps going off)
local warnDefiledGround				= mod:NewSpellAnnounce(143961, 3, nil, mod:IsTank())--Embodied Misery
local warnInfernoStrike				= mod:NewSpellAnnounce(143962, 3)
--He Softfoot
local warnGouge						= mod:NewCastAnnounce(143330, 4, nil, nil, mod:IsTank())--The cast, so you can react and turn back to it and avoid stun.
local warnGougeStun					= mod:NewTargetAnnounce(143301, 4, nil, mod:IsTank())--Failed, stunned. the success ID is 143331 (knockback)
local warnGorrote					= mod:NewTargetAnnounce(143198, 3, nil, mod:IsHealer())
----He Softfoot's Desperate Measures
local warnMarkOfAnguish				= mod:NewSpellAnnounce(143812, 2)--Activation
local warnMarked					= mod:NewTargetAnnounce(143840, 3)--Embodied Anguish			
--Sun Tenderheart
local warnShaShear					= mod:NewCastAnnounce(143423, 3, 5)
local warnBane						= mod:NewCastAnnounce(143446, 4, nil, nil, mod:IsHealer())
local warnCalamity					= mod:NewSpellAnnounce(143491, 4)
----Sun Tenderheart's Desperate Measures
local warnDarkMeditation			= mod:NewSpellAnnounce(143546, 2)--Activation

--Rook Stonetoe
local specWarnVengefulStrikes		= mod:NewSpecialWarningSpell(144396, mod:IsTank())
local specWarnClash					= mod:NewSpecialWarningYou(143027)
----Rook Stonetoe's Desperate Measures
local specWarnMiserySorrowGloom		= mod:NewSpecialWarningSpell(143955)
local specWarnCorruptionShock		= mod:NewSpecialWarningInterrupt(143958, mod:IsMelee())
local specWarnDefiledGround			= mod:NewSpecialWarningMove(143959)
--He Softfoot
local specWarnGouge					= mod:NewSpecialWarningMove(143330, mod:IsTank())--Maybe localize it as a "turn away" warning.
local specWarnGougeStunOther		= mod:NewSpecialWarningTarget(143301, mod:IsTank())--Tank is stunned, other tank must taunt or he'll start killing people
local specWarnNoxiousPoison			= mod:NewSpecialWarningMove(144367)
----He Softfoot's Desperate measures
local specWarnMarkOfAnquish			= mod:NewSpecialWarningSpell(143812)
local specWarnMarked				= mod:NewSpecialWarningYou(143840)
local yellMarked					= mod:NewYell(143840, nil, false)
--Sun Tenderheart
local specWarnShaShear				= mod:NewSpecialWarningInterrupt(143423, mod:IsMelee())
local specWarnBane					= mod:NewSpecialWarningSpell(143446, mod:IsHealer())
local specWarnCalamity				= mod:NewSpecialWarningSpell(143491, nil, nil, nil, 2)
----Sun Tenderheart's Desperate Measures
local specWarnDarkMeditation		= mod:NewSpecialWarningSpell(143546)

--Rook Stonetoe
local timerVengefulStrikesCD		= mod:NewCDTimer(43, 144396)
local timerCorruptedBrewCD			= mod:NewCDTimer(11, 143019)
local timerClashCD					= mod:NewCDTimer(46, 143027)--45-54
----Rook Stonetoe's Desperate Measures
local timerDefiledGroundCD			= mod:NewCDTimer(11, 143961, nil, mod:IsTank())
local timerInfernoStrikeCD			= mod:NewCDTimer(11, 143962)
--He Softfoot
local timerGougeCD					= mod:NewCDTimer(30, 143330, nil, mod:IsTank())--30-41
local timerGorroteCD				= mod:NewCDTimer(30, 143198, nil, mod:IsHealer())--30-36
--Sun Tenderheart
local timerBaneCD					= mod:NewCDTimer(25, 143446, nil, mod:IsHealer())--25-30
local timerCalamityCD				= mod:NewNextTimer(29, 143491)--29-35

--local countdownLightningStorm		= mod:NewCountdown(42, 118077, false)
--local countdownExpelCorruption		= mod:NewCountdown(38.5, 117975)

--local berserkTimer					= mod:NewBerserkTimer(490)

function mod:OnCombatStart(delay)
	timerVengefulStrikesCD:Start(8-delay)
	timerGorroteCD:Start(11-delay)
	timerBaneCD:Start(15-delay)
	timerCorruptedBrewCD:Start(18-delay)
	timerGougeCD:Start(20-delay)
	timerCalamityCD:Start(-delay)
	timerClashCD:Start(-delay)
--	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143958 then
		local source = args.sourceName
		warnCorruptionShock:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnCorruptionShock:Show(source)
		end
	elseif args.spellId == 143330 then
		warnGouge:Show()
		timerGougeCD:Start()
		if args.sourceGUID == UnitGUID("target") then--Todo, check the bosses target instead for more accurate detection of which tank is on which boss.
			specWarnGouge:Show()
		end
	elseif args.spellId == 143446 then
		warnBane:Show()
		specWarnBane:Show()
		timerBaneCD:Start()
	elseif args.spellId == 143491 then
		warnCalamity:Show()
		specWarnCalamity:Show()
		timerCalamityCD:Start()
	elseif args.spellId == 143961 then
		warnDefiledGround:Show()
		timerDefiledGroundCD:Start()
	elseif args.spellId == 143962 then
		warnInfernoStrike:Show()
		timerInfernoStrikeCD:Start()
	elseif args.spellId == 143497 then
		warnBondGoldenLotus:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143027 then
		warnClash:Show()
		timerClashCD:Start()
		if args:IsPlayer() then
			specWarnClash:Show()
		end
	elseif args.spellId == 143423 then
		local source = args.sourceName
		if source == UnitName("target") or source == UnitName("focus") then--Only warn if your target or focus, period, because if you aren't actually dpsing her, you just stay out of melee range and ignore this
			warnShaShear:Show()
			specWarnShaShear:Show(source)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144396 then
		warnVengefulStrikes:Show()
		timerVengefulStrikesCD:Start()
		if args.sourceName == UnitName("target") then--Todo, check the bosses target instead for more accurate detection of which tank is on which boss.
			specWarnVengefulStrikes:Show()
		end
	elseif args.spellId == 143959 and args:IsPlayer() and self:AntiSpam() then
		specWarnDefiledGround:Show()
	elseif args.spellId == 143301 then--Stun debuff spellid
		warnGougeStun:Show(args.destName)
		if not args:IsPlayer() then
			specWarnGougeStunOther:Show(args.destName)
		end
	elseif args.spellId == 143198 then
		warnGorrote:Show(args.destName)
		timerGorroteCD:Start()
	elseif args.spellId == 143840 then
		warnMarked:Show(args.destName)
		if args:IsPlayer() then
			specWarnMarked:Show(args.destName)
			yellMarked:Yell()
		end
	--Special phases
	elseif args.spellId == 143546 then--Dark Meditation
		warnDarkMeditation:Show()
		specWarnDarkMeditation:Show()
		timerBaneCD:Cancel()
		timerCalamityCD:Cancel()
	elseif args.spellId == 143955 then--Misery, Sorrow, and Gloom
		warnMiserySorrowGloom:Show()
		specWarnMiserySorrowGloom:Show()
		timerVengefulStrikesCD:Cancel()
		timerClashCD:Cancel()
		timerCorruptedBrewCD:Cancel()
		timerInfernoStrikeCD:Start(7)
		timerDefiledGroundCD:Start(9)
	elseif args.spellId == 143812 then--Mark of Anguish
		warnMarkOfAnguish:Show()
		specWarnMarkOfAnquish:Show()
		timerGougeCD:Cancel()
		timerGorroteCD:Cancel()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	--Special phases
	if args.spellId == 143546 then--Dark Meditation
		timerBaneCD:Start(12)
		timerCalamityCD:Start()
	elseif args.spellId == 143955 then--Misery, Sorrow, and Gloom
		timerDefiledGroundCD:Cancel()
		timerInfernoStrikeCD:Cancel()
		timerVengefulStrikesCD:Start(7.5)
		timerCorruptedBrewCD:Start(17)
		timerClashCD:Start(42)
	elseif args.spellId == 143812 then--Mark of Anguish
		timerGorroteCD:Start(11)
		timerGougeCD:Start(26)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 144357 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnDefiledGround:Show()
	elseif spellId == 144367 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnNoxiousPoison:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143019 then--Does not show in combat log
		warnCorruptedBrew:Show()
		timerCorruptedBrewCD:Start()
	end
end
