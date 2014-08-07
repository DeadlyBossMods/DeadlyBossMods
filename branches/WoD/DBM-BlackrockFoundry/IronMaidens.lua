local mod	= DBM:NewMod(1203, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77557, 77231, 77477)
mod:SetEncounterID(1695)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158849 158695 158708 158707 158710 158692 156683 158599 155794 158078 156366",
	"SPELL_CAST_SUCCESS 158701",
	"SPELL_AURA_APPLIED 158702 156631 164271 156214 156007 158315 170405 157950",
	"SPELL_AURA_APPLIED_DOSE 170405",
	"SPELL_AURA_REMOVED 156631",
	"SPELL_PERIODIC_DAMAGE 158683",
	"SPELL_PERIODIC_MISSED 158683"
)

--TODO, find a way, either by map or unit power to filter ship deck from ground warnings
--TODO, See if bosses need filtering by location too. Otherwise this mod is going to be a SPAM FEST
--TODO, tweak option defaults as much as possible to reduce spam once abilities and their threat are more known.
--Ship
local warnWarmingUp						= mod:NewCastAnnounce(158849, 3)
----Blackrock Deckhand
local warnGrapeshotBlast				= mod:NewSpellAnnounce(158695, 3)
local warnEarthenBarrier				= mod:NewSpellAnnounce(158708, 3)
local warnProtectiveEarth				= mod:NewSpellAnnounce(158707, 3)
local warnChainLightning				= mod:NewSpellAnnounce(158710, 3)
----Shattered Hand Deckhand
local warnDeadlyThrow					= mod:NewSpellAnnounce(158692, 3)
local warnCallforReinforcements			= mod:NewSpellAnnounce(158701, 2)
local warnFixate						= mod:NewTargetAnnounce(158702, 3)
--Ground
----Admiral Gar'an
local warnRapidFire						= mod:NewTargetAnnounce(156631, 3)
local warnIncendiaryDevice				= mod:NewSpellAnnounce(156683, 4)--Mythic. How do you determine target, must find that out!
local warnPenetratingShot				= mod:NewTargetAnnounce(164271, 3)
local warnDeployTurret					= mod:NewSpellAnnounce(158599, 3)
----Enforcer Sorka
local warnBladeDash						= mod:NewSpellAnnounce(155794, 3)
local warnConvulsiveShadows				= mod:NewTargetAnnounce(156214, 4)
local warnImpale						= mod:NewTargetAnnounce(156007, 3)
local warnDarkHunt						= mod:NewTargetAnnounce(158315, 4)
----Marak the Blooded
local warnBloodRitual					= mod:NewCastAnnounce(158078, 3, nil, mod:IsTank())
local warnMaraksBloodcalling			= mod:NewStackAnnounce(170405, 2, nil, mod:IsTank())
local warnWhirlOfBlood					= mod:NewSpellAnnounce(156366, 3)--Mythic
local warnBloodsoakedHeartseeker		= mod:NewTargetAnnounce(157950, 3)--Probably hidden from combatlog, will need alternate detection i'm sure. Blizzard likes pointless extra work.

--Ship
local specWarnWarmingUp					= mod:NewSpecialWarningSpell(158849, false)
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
local specWarnBladeDash					= mod:NewSpecialWarningSpell(155794, nil, nil, nil, 2)
local specWarnConvulsiveShadows			= mod:NewSpecialWarningMoveAway(156214)--Mythic
local yellConvulsiveShadows				= mod:NewYell(156214)--Mythic
local specWarnDarkHunt					= mod:NewSpecialWarningTarget(158315, false)--Healer may want this, or raid leader
----Marak the Blooded
local specWarnBloodRitual				= mod:NewSpecialWarningSpell(158078, mod:IsTank())
local specWarnMaraksBloodcalling		= mod:NewSpecialWarningStack(170405, nil, 2)--stack guessed
local specWarnMaraksBloodcallingOther	= mod:NewSpecialWarningTaunt(170405)
local specWarnWhirlOfBlood				= mod:NewSpecialWarningSpell(156366, nil, nil, nil, 2)--Mythic
local specWarnBloodsoakedHeartseeker	= mod:NewSpecialWarningYou(157950)
local yellBloodsoakedHeartseeker		= mod:NewYell(157950)

--Ship
local timerWarmingUp					= mod:NewCastTimer(90, 158849)
----Blackrock Deckhand
----Shattered Hand Deckhand
----Bleeding Hollow Deckhand
--Ground
----Admiral Gar'an
----Enforcer Sorka

mod:AddRangeFrameOption("?/5")--Various things

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156683 then
		warnIncendiaryDevice:Show()
		specWarnIncendiaryDevice:Show()
	elseif spellId == 158599 then
		warnDeployTurret:Show()
		specWarnDeployTurret:Show()
	elseif spellId == 155794 then
		warnBladeDash:Show()
		specWarnBladeDash:Show()
	elseif spellId == 158078 then
		warnBloodRitual:Show()
		specWarnBloodRitual:Show()
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
	--Begin Deck Abilities
	if spellId == 158701 then
		warnCallforReinforcements:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156631 then
		warnRapidFire:Show(args.destName)
		if args:IsPlayer() then
			specWarnRapidFire:Show()
			yellRapidFire:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 164271 then
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
	elseif spellId == 170405 then
		local amount = args.amount or 1
		warnMaraksBloodcalling:Show(args.destName, amount)
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnMaraksBloodcalling:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(170405)) and not UnitIsDeadOrGhost("player") then
					specWarnMaraksBloodcallingOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 157950 then
		warnBloodsoakedHeartseeker:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBloodsoakedHeartseeker:Show()
			yellBloodsoakedHeartseeker:Yell()
		end
	--Begin Deck Abilities
	elseif spellId == 158702 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156631 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 158683 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnCorruptedBlood:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
