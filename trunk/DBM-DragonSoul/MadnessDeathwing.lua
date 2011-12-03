local mod	= DBM:NewMod(333, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56173)--Will this work? does he die?
mod:SetModelID(40087)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("yell", L.Pull)
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
)

local warnImpale				= mod:NewStackAnnounce(106400, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElementiumBolt		= mod:NewSpellAnnounce(105651, 4)
local warnTentacle				= mod:NewSpellAnnounce(105551, 3)
local warnHemorrhage			= mod:NewSpellAnnounce(105863, 3)
local warnCataclysm				= mod:NewCastAnnounce(106523, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2, 3)
local warnFragments				= mod:NewSpellAnnounce(109568, 4)--Fairly sure this is fragment summon spell, but could be wrong, will know next time i do fight and if timing matches.
local warnTerror				= mod:NewSpellAnnounce(106765, 4)

local specWarnImpale			= mod:NewSpecialWarningYou(106400)
local specWarnImpaleOther		= mod:NewSpecialWarningTarget(106400, mod:IsTank())
local specWarnElementiumBolt	= mod:NewSpecialWarningSpell(105651, nil, nil, nil, true)
local specWarnTentacle			= mod:NewSpecialWarning("SpecWarnTentacle", mod:IsDps())--Maybe add healer to defaults too?
local specWarnHemorrhage		= mod:NewSpecialWarningSpell(105863, mod:IsDps())
--local specWarnFragments		= mod:NewSpecialWarningSpell(109568, mod:IsDps())--If this is fragments summon spell, will uncommeont, for now not sure so won't spam needlessly just in case.
local specWarnTerror			= mod:NewSpecialWarningSpell(106765, mod:IsTank())

local timerImpale				= mod:NewTargetTimer(49.5, 106400, nil, mod:IsTank() or mod:IsHealer())--45 plus 4 second cast plus .5 delay between debuff ID swap.
local timerImpaleCD				= mod:NewCDTimer(35, 106400, nil, mod:IsTank() or mod:IsHealer())
local timerElementiumBlast		= mod:NewCastTimer(10, 109600)--Variable depending on nozdormu
local timerElementiumBoltCD		= mod:NewNextTimer(56, 105651)
local timerHemorrhageCD			= mod:NewNextTimer(100, 105863)
local timerCataclysm			= mod:NewCastTimer(60, 106523)
local timerCataclysmCD			= mod:NewNextTimer(130, 106523)
local timerFragmentsCD			= mod:NewNextTimer(90, 109568)
local timerTerrorCD				= mod:NewNextTimer(90, 106765)

local firstAspect = true
local phaseTwo = false
local engageCount = 0

function mod:OnCombatStart(delay)
	firstAspect = true
	phaseTwo = false
	engageCount = 0
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107018) then
		if firstAspect then--The abilities all come 15seconds earlier for first one only
			firstAspect = false
			timerImpaleCD:Start(22)
			timerElementiumBoltCD:Start(40)
			timerHemorrhageCD:Start(85)
			timerCataclysmCD:Start(115)
		else
			timerImpaleCD:Start(37)
			timerElementiumBoltCD:Start()
			timerHemorrhageCD:Start()
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(106523, 110042, 110043, 110044) then
		timerCataclysmCD:Cancel()--Just in case it comes early from another minor change like firstAspect change which wasn't on PTR, don't want to confuse peope with two cata bars.
		warnCataclysm:Show()
		timerCataclysm:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105651) then
		warnElementiumBolt:Show()
		specWarnElementiumBolt:Show()
		if not UnitBuff("player", GetSpellInfo(109624)) and not UnitIsDeadOrGhost("player") then--Check for Nozdormu's Presence
			timerElementiumBlast:Start()--Not up, explosion in 10 seconds
		else	
			timerElementiumBlast:Start(20)--Slowed by Nozdormu, explosion in 20 seconds
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(106400) then--106444, 109631, 109632, 109633 are debuff IDs, no reason to use them though cause that'd be a diff function with diff timing
		warnImpale:Show(args.destName, args.amount or 1)
		timerImpale:Start(args.destName)--May need to add anti spam for heroic. On heroic impale hits everyone near the tenticle not just the tank? But maybe this ID only hits tank so we'll be fine, don't know yet.
		timerImpaleCD:Start()
		if args:IsPlayer() then
			specWarnImpale:Show()
		else
			specWarnImpaleOther:Show(args.destName)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106444, 109631, 109632, 109633) then--Over here, we do use the secondary spellids to cancel the debuff target timer.
		timerImpale:Cancel(args.destName)
	end
end


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56167 or cid == 56168 or cid == 56846 then--Wings and Arms. Why only 3 IDs? 1 missing?
		timerElementiumBoltCD:Cancel()
		timerHemorrhageCD:Cancel()--Does this one cancel in event you super overgear this and stomp his ass this fast?
		timerCataclysm:Cancel()
		timerCataclysmCD:Cancel()
	elseif cid == 56262 then--Elementium Bolt/Meteor
		timerElementiumBlast:Cancel()--Cancel blast if it dies before hitting ground.
	elseif cid == 56471 then--Mutated Corruption
		timerImpaleCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if not (uId == "boss1" or uId == "boss2") then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if spellName == GetSpellInfo(105853) then
		warnHemorrhage:Show()
		specWarnHemorrhage:Show()
	elseif spellName == GetSpellInfo(105551) then--Spawn Blistering Tentacles
		if not UnitBuff("player", GetSpellInfo(106028)) and not UnitIsDeadOrGhost("player") then--Check for Alexstrasza's Presence
			warnTentacle:Show()
			specWarnTentacle:Show()--It's not up so give special warning for these Tentacles.
		end
	elseif spellName == GetSpellInfo(106708) then--Slump (Phase 2 start)
		phaseTwo = true
		warnPhase2:Show()
		timerFragmentsCD:Start(11)
		timerTerrorCD:Start(36)
	elseif spellName == GetSpellInfo(109568) then--Summon Impaling Tentacle (Fragments summon?)
		warnFragments:Show()
		timerFragmentsCD:Start()
	elseif spellName == GetSpellInfo(106765) then--Summon Elementium Terror (Big angry add)
		warnTerror:Show()
		specWarnTerror:Show()
		timerTerrorCD:Start()
	end
end

--He doesn't fire UNIT_DIED so begin kill detection hack that doesn't require localizing some RP dialog that fires several seconds after him dying and you leaving combat.
--this hack works invaild. Currently, this hack works at phase 2 start. so commented it until works.
--[[function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if phaseTwo and self:IsInCombat() then
		engageCount = engageCount + 1
		if engageCount == 2 then
			DBM:EndCombat(self)
		end
	end
end]]