local mod	= DBM:NewMod(1425, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90284)
mod:SetEncounterID(1785)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 182020 179889 182066 186449 181999 182668",
	"SPELL_CAST_SUCCESS 187172 185250 185248",
	"SPELL_AURA_APPLIED 182280 182534 186652 186667 186676",
	"SPELL_AURA_REMOVED 182280 182534 186652 186667 186676"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"--For quick enable if not SPELL_AURA_APPLIED
)

--TODO, check debuff duration for artillery
--TODO, check target scanning for unstable orb target (or if target is in SUCCESS event)
--TODO, verify orb cast ID
--TODO, check target scanning for blitz target
--TODO, check falling slam for target scanning.
--TODO, see if one of the instance cast spellids are earlier than channeled casts for falling slam
--TODO, check Firebomb CAST for target scanning
--TODO, verify bombs use SPELL_AURA_APPLIED/SPELL_AURA_REMOVED as I suspect
local warnArtillery					= mod:NewTargetAnnounce(182280, 4)
local warnUnstableOrb				= mod:NewSpellAnnounce(182001, 3)--What's cast ID? 182001, 187172, 185250, 185248. My money is on 185248
local warnFirebomb					= mod:NewCastAnnounce(181999, 4)--Firebomb Cast
local warnFuelStreak				= mod:NewCastAnnounce(182668, 2)

local specWarnArtillery				= mod:NewSpecialWarningMoveAway(182280, nil, nil, nil, 3, nil, 2)
local yellArtillery					= mod:NewYell(182108)
--local specWarnUnstableOrbGTFO		= mod:NewSpecialWarningMove(182001, nil, nil, nil, nil, nil, 2)--Damage ID for sure, only one on wowhead that shows damage
local specWarnPounding				= mod:NewSpecialWarningSpell(182020, nil, nil, nil, 2, nil, 2)--182020 begincast, 182022 castsuccess according to wowhead
local specWarnBlitz					= mod:NewSpecialWarningDodge(179889, nil, nil, nil, 2, nil, 2)
local specWarnFallingSlam			= mod:NewSpecialWarningSpell(182066, nil, nil, nil, 2, nil, 2)
local specWarnVolatileFirebomb		= mod:NewSpecialWarningSwitch(182534, "Dps")
local specWarnQuickFuseFirebomb		= mod:NewSpecialWarningSwitch(186652, "Dps")--Mythic
local specWarnBurningFirebomb		= mod:NewSpecialWarningSwitch(186667, "Dps")--Mythic
local specWarnReactiveFirebomb		= mod:NewSpecialWarningSwitch(186676, "Tank")--Mythic

--local timerArtilleryCD			= mod:NewCDTimer(107, 182108)--CD not known
--local timerUnstableOrbCD			= mod:NewCDTimer(107, 182001)--CD not known
--local timerPoundingCD				= mod:NewCDTimer(107, 182020)--CD not known
--local timerBlitzCD				= mod:NewCDTimer(107, 179889)--CD not known
--local timerFallingSlamCD			= mod:NewCDTimer(107, 182066)--CD not known
--local timerFirebombCD				= mod:NewCDTimer(107, 181999)--CD not known
local timerVolatileBomb				= mod:NewCastTimer(45, 182534)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerQuickFuseBomb			= mod:NewCastTimer(20, 186652)
local timerBurningBomb				= mod:NewCastTimer(40, 186667)
local timerReactiveBomb				= mod:NewCastTimer(30, 186676)

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownFireBombExplodes		= mod:NewCountdown(45, 181999)--One countdown option for all types
local countdownArtillery			= mod:NewCountdownFades("Alt13", 182280)--Duration not in spell tooltip, countdown add when duration discovered from testing

local voiceArtillery				= mod:NewVoice(182280)--generic "justrun"? This is basically mark of chaos, but on anyone not just tank. Custom voice needed if justrun not informative enough?
local voicePounding					= mod:NewVoice(182020)--aesoon
local voiceBlitz					= mod:NewVoice(179889)--chargemove
--local voiceUnstableOrbGTFO			= mod:NewVoice(182001)

mod:AddRangeFrameOption(8, 182001)--TODO, make it show only when unstable orb is usuable, instead of entire fight. Only show it for those it can target, probably ranged?
mod:AddSetIconOption("SetIconOnArtillery", 182280, true)
mod:AddHudMapOption("HudMapOnArt", 182108)

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnArt then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 182020 then
		specWarnPounding:Show()
		voicePounding:Play("aesoon")
	elseif spellId == 179889 then
		specWarnBlitz:Show()
		voiceBlitz:Play("chargemove")
	elseif spellId == 182066 or spellId == 186449 then
		DBM:Debug("Falling Slam is using spellid: "..spellId, 2)
		specWarnFallingSlam:Show()
	elseif spellId == 181999 then
		if not self:IsMythic() then--Only one type of firebomb, give switch special warning now
			specWarnVolatileFirebomb:Show()
		else
			warnFirebomb:Show()--Announce cast, but we can't announce type until it lands and gains one of the 3 mythic buffs
		end
	elseif spellId == 182668 then
		warnFuelStreak:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	--182001 187172 185250 185248
	if spellId == 187172 or spellId == 185250 or spellId == 185248 then--I REALLY doubt it's 182001, so excluding to avoid spammy situation where sometimes fire on ground fires SPELL_CAST_SUCCESS every time someone runs through it
		DBM:Debug("Unstable orb is using spellid: "..spellId, 2)
		warnUnstableOrb:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182280 then
		warnArtillery:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnArtillery:Show()
			yellArtillery:Yell()
			voiceArtillery:Play("justrun")
			countdownArtillery:Start()
		end
		if self.Options.SetIconOnArtillery then
			self:SetSortedIcon(0.5, args.destName, 2, 3)
		end
		if self.Options.HudMapOnArt then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 13, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
		end
	elseif spellId == 182534 then--Volatile
		timerVolatileBomb:Start()
		countdownFireBombExplodes:Start()
	elseif spellId == 186652 then--Quickfuse
		specWarnQuickFuseFirebomb:Show()
		timerQuickFuseBomb:Start()
		countdownFireBombExplodes:Start(20)
	elseif spellId == 186667 then--Burning
		specWarnBurningFirebomb:Show()
		timerBurningBomb:Start()
		countdownFireBombExplodes:Start(40)
	elseif spellId == 186676 then--Reactive	
		specWarnReactiveFirebomb:Show()
		timerReactiveBomb:Start()
		countdownFireBombExplodes:Start(30)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 182280 then
		if args:IsPlayer() then
			countdownArtillery:Cancel()
		end
		if self.Options.SetIconOnArtillery then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapOnArt then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 182534 then--Volatile
		timerVolatileBomb:Cancel()
		countdownFireBombExplodes:Cancel()
	elseif spellId == 186652 then--Quickfuse
		timerQuickFuseBomb:Cancel()
		countdownFireBombExplodes:Cancel()
	elseif spellId == 186667 then--Burning
		timerBurningBomb:Cancel()
		countdownFireBombExplodes:Cancel()
	elseif spellId == 186676 then--Reactive	
		timerReactiveBomb:Cancel()
		countdownFireBombExplodes:Cancel()
	end
end

--In case this isn't in combat log
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 182534 then--Volatile
		timerVolatileBomb:Start()
		countdownFireBombExplodes:Start()
	elseif spellId == 186652 then--Quickfuse
		specWarnQuickFuseFirebomb:Show()
		timerQuickFuseBomb:Start()
		countdownFireBombExplodes:Start(20)
	elseif spellId == 186667 then--Burning
		specWarnBurningFirebomb:Show()
		timerBurningBomb:Start()
		countdownFireBombExplodes:Start(40)
	elseif spellId == 186676 then--Reactive	
		specWarnReactiveFirebomb:Show()
		timerReactiveBomb:Start()
		countdownFireBombExplodes:Start(30)
	end
end
