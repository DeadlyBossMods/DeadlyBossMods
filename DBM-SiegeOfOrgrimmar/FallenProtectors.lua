local mod	= DBM:NewMod(849, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71479)--he-softfoot
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

--Rook Stonetoe
local warnVengefulStrikes			= mod:NewSpellAnnounce(144396, 3, nil, mod:IsTank())
local warnCorruptedBrew				= mod:NewSpellAnnounce(143019, 2)--Target scanning? or emote? need more data
local warnClash						= mod:NewSpellAnnounce(143027, 3)--Again, see if we can find target to warn them to run away as soon as it goes off
----Rook Stonetoe's Desperate Measures (66% and 33%)
local warnCorruptionShock			= mod:NewSpellAnnounce(143958, 3)--Embodied Gloom
local warnDefiledGround				= mod:NewSpellAnnounce(143961, 3)--Embodied Misery
--He Softfoot
local warnGouge						= mod:NewCastAnnounce(143330, 3, nil, nil, mod:IsTank())--The cast, so you can react and turn back to it and avoid stun.
local warnGougeStun					= mod:NewTargetAnnounce(143301, 3, nil, mod:IsTank())--Failed, stunned. the success ID is 143331 (knockback)
----He Softfoot's Desperate measures
local warnMarked					= mod:NewTargetAnnounce(143840, 3)--Embodied Anguish			
--Sun Tenderheart
local warnShaShear					= mod:NewCastAnnounce(143423, 3, 5)
local warnBane						= mod:NewCastAnnounce(143446, 4, nil, nil, mod:IsHealer())
local warnCalamity					= mod:NewSpellAnnounce(143491, 4)

--Rook Stonetoe
local specWarnVengefulStrikes		= mod:NewSpecialWarningSpell(144396, mod:IsTank())
local specWarnClash					= mod:NewSpecialWarningYou(143027)
----Rook Stonetoe's Desperate Measures
local specWarnCorruptionShock		= mod:NewSpecialWarningInterrupt(143958, mod:IsMelee())
local specWarnDefiledGround			= mod:NewSpecialWarningMove(143959)
--He Softfoot
local specWarnGouge					= mod:NewSpecialWarningMove(143330, mod:IsTank())--Maybe localize it as a "turn away" warning.
local specWarnGougeStunOther		= mod:NewSpecialWarningTarget(143301, mod:IsTank())--Tank is stunned, other tank must taunt or he'll start killing people
----He Softfoot's Desperate measures
local specWarnMarked				= mod:NewSpecialWarningYou(143840)
local yellMarked					= mod:NewYell(143840, nil, false)
--Sun Tenderheart
local specWarnShaShear				= mod:NewSpecialWarningInterrupt(143423, mod:IsMelee())
local specWarnBane					= mod:NewSpecialWarningSpell(143446, mod:IsHealer())
local specWarnCalamity				= mod:NewSpecialWarningSpell(143491, nil, nil, nil, 2)

--Rook Stonetoe
--local timerVengefulStrikesCD		= mod:NewCDTimer(32.5, 144396)
--local timerCorruptedBrewCD		= mod:NewNextTimer(42, 143019)
--local timerClashCD				= mod:NewNextTimer(42, 143027)
--He Softfoot
--local timerGougeCD				= mod:NewCDTimer(25, 143330, nil, mod:IsTank())
--Sun Tenderheart
--local timerShaSheerCD				= mod:NewCDTimer(29, 143423)
--local timerBaneCD					= mod:NewNextTimer(15.5, 143446, nil, mod:IsHealer())
--local timerCalamityCD				= mod:NewNextTimer(38.5, 143491)

--local countdownLightningStorm		= mod:NewCountdown(42, 118077, false)
--local countdownExpelCorruption		= mod:NewCountdown(38.5, 117975)

local soundMarked					= mod:NewSound(143840)

--local berserkTimer					= mod:NewBerserkTimer(490)

function mod:OnCombatStart(delay)
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144396 then
		warnVengefulStrikes:Show()
--		timerVengefulStrikesCD:Start()
		if args.sourceName == UnitName("target") then--Todo, check the bosses target instead for more accurate detection of which tank is on which boss.
			specWarnVengefulStrikes:Show()
		end
	elseif args.spellId == 143958 then
		local source = args.sourceName
		warnCorruptionShock:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnCorruptionShock:Show(source)
		end
	elseif args.spellId == 143330 then
		warnGouge:Show()
--		timerGougeCD:Start()
		if args.sourceName == UnitName("target") then--Todo, check the bosses target instead for more accurate detection of which tank is on which boss.
			specWarnGouge:Show()
		end
	elseif args.spellId == 143423 then
		local source = args.sourceName
		warnShaShear:Show()
--		timerShaSheerCD:Start()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnShaShear:show(source)
		end
	elseif args.spellId == 143446 then
		warnBane:Show()
		specWarnBane:Show()
--		timerBaneCD:Start()
	elseif args.spellId == 143491 then
		warnCalamity:Show()
		specWarnCalamity:Show()
--		timerCalamityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143019 then
		warnCorruptedBrew:Show()
--		timerCorruptedBrewCD:Start()
	elseif args.spellId == 143027 then
		warnClash:Show()
--		timerClashCD:Start()
		if args:IsPlayer() then
			specWarnClash:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143959 and args:IsPlayer() then
		specWarnDefiledGround:Show()
	elseif args.spellId == 143301 then--Stun debuff spellid
		warnGougeStun:Show(args.destName)
		if not args:IsPlayer() then
			specWarnGougeStunOther:Show(args.destName)
		end
	elseif args.spellId == 143840 then
		warnMarked:Show(args.destName)
		if args:IsPlayer() then
			specWarnMarked:Show(args.destName)
			yellMarked:Yell()
		end
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138732 and args:IsPlayer() then
		timerIonization:Cancel()
		self:Unschedule(checkWaterIonization)
		if self.Options.RangeFrame and not UnitDebuff("player", GetSpellInfo(137422)) then--if you have 137422 we don't want to hide it either.
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
