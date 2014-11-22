local mod	= DBM:NewMod(959, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77325)
mod:SetEncounterID(1704)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155992 159142 156928 158054",
	"SPELL_AURA_APPLIED 156096 157000 156667 156401",
	"SPELL_AURA_REMOVED 156096 157000 156667",
	"SPELL_PERIODIC_DAMAGE 156401",
	"SPELL_PERIODIC_MISSED 156401",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Phase 2
--TODO, get damage ID for fire on ground created by Mortar
--TODO, figure out how to track who Siegemaker is fixating on, doesn't seem to be in combat log (what else is new)
--Phase 3
--TODO, Verify everything works.
--TODO, figure out what you aim the impaling throw at
--TODO, Update timers for phase 3.
--Stage One: The Blackrock Forge
local warnDemolition				= mod:NewSpellAnnounce(156425, 3)--Probably doesn't show in combat log. Assume it has a UNIT_SPELLCAST_SUCCEEDED event.
local warnMarkedforDeath			= mod:NewTargetAnnounce(156096, 4)--If not in combat log, find a RAID_BOSS_WHISPER event.
local warnThrowSlagBombs			= mod:NewSpellAnnounce(156030, 3)--Probably doesn't show in combat log. Assume it has a UNIT_SPELLCAST_SUCCEEDED event.
local warnShatteringSmash			= mod:NewSpellAnnounce(155992, 3)
--Stage Two: Storage Warehouse
local warnSiegemaker				= mod:NewSpellAnnounce("ej9571", 3, 156667)
--Stage Three: Iron Crucible
local warnSlagEruption				= mod:NewSpellAnnounce(156928, 3)
local warnAttachSlagBombs			= mod:NewTargetAnnounce(157000, 4)
local warnMassiveShatteringSmash	= mod:NewTargetAnnounce(158054, 3)

--Stage One: The Blackrock Forge
local specWarnDemolition			= mod:NewSpecialWarningSpell(156425, nil, nil, nil, 2)
local specWarnMarkedforDeath		= mod:NewSpecialWarningYou(156096, nil, nil, nil, 3)
local yellMarkedforDeath			= mod:NewYell(156096)
local specWarnThrowSlagBombs		= mod:NewSpecialWarningMove(156030)
local specWarnShatteringSmash		= mod:NewSpecialWarningSpell(155992, mod:IsMelee())
local specWarnMoltenSlag			= mod:NewSpecialWarningMove(156401)
--Stage Two: Storage Warehouse
local specWarnSiegemaker			= mod:NewSpecialWarningSwitch("ej9571", mod:IsDps())
--Stage Three: Iron Crucible
local specWarnSlagEruption			= mod:NewSpecialWarningSpell(156928, nil, nil, nil, 2)
local specWarnAttachSlagBombs		= mod:NewSpecialWarningYou(157000)--May change to sound 3, but I don't want it confused with the even more threatening marked for death, so for now will try 1
local yellAttachSlagBombs			= mod:NewYell(157000, nil, false)
local specWarnMassiveShatteringSmash= mod:NewSpecialWarningSpell(158054, nil, nil, nil, 2)

--Stage One: The Blackrock Forge
local timerDemolitionCD				= mod:NewNextTimer(45, 156425)
local timerMarkedforDeathCD			= mod:NewNextTimer(15.5, 156096)
local timerThrowSlagBombsCD			= mod:NewCDTimer(25, 156030)--It's a next timer, but sometimes delayed by Shattering Smash
local timerShatteringSmashCD		= mod:NewCDTimer(30, 155992)--Next timer, but sometimes delayed by throw slag bombs.
local timerImpalingThrow			= mod:NewCastTimer(5, 156111)--How long marked target has to aim throw at Debris Pile or Siegemaker
--Stage Two: Storage Warehouse
local timerSiegemakerCD				= mod:NewNextTimer(50, "ej9571", nil, nil, nil, 156667)
--Stage Three: Iron Crucible
--local timerSlagEruptionCD			= mod:NewNextTimer(30, 156928)
--local timerAttachSlagBombsCD		= mod:NewNextTimer(30, 157000)
local timerSlagBomb					= mod:NewCastTimer(5, 157015)
--local timerMassiveShatteringSmashCD	= mod:NewNextTimer(30, 158054)


function mod:OnCombatStart(delay)
	timerThrowSlagBombsCD:Start(6-delay)
	timerDemolitionCD:Start(15-delay)
	timerShatteringSmashCD:Start(20-delay)
	timerMarkedforDeathCD:Start(36-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155992 or spellId == 159142 then--Phase 1 and then phase 2 version. They don't really need two diff warnings, complicated anyways since auto generated with same spellname is wonky
		warnShatteringSmash:Show()
		specWarnShatteringSmash:Show()
		timerShatteringSmashCD:Start()
	elseif spellId == 156928 then
		warnSlagEruption:Show()
		specWarnSlagEruption:Show()
	elseif spellId == 158054 then
		warnMassiveShatteringSmash:Show()
		specWarnMassiveShatteringSmash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		warnMarkedforDeath:CombinedShow(0.5, args.destName)
		timerMarkedforDeathCD:Start()
		timerImpalingThrow:Start()
		if args:IsPlayer() then
			specWarnMarkedforDeath:Show()
			yellMarkedforDeath:Yell()
		end
	elseif spellId == 157000 then
		warnAttachSlagBombs:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnAttachSlagBombs:Show()
			yellAttachSlagBombs:Yell()
			timerSlagBomb:Start()
		end
	elseif spellId == 156667 then
		warnSiegemaker:Show()
		timerSiegemakerCD:Start()
	elseif spellId == 156401 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnMoltenSlag:Show()
	end
end


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156096 and args:IsPlayer() then
		timerImpalingThrow:Cancel()
	elseif spellId == 157000 and args:IsPlayer() then
		timerSlagBomb:Cancel()
	elseif spellId == 156667 then
		specWarnSiegemaker:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156401 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMoltenSlag:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156031 or spellId == 156991 then--Need phase 3 ID if it's not in combat log either.
		warnThrowSlagBombs:Show()
		specWarnThrowSlagBombs:Show()
		timerThrowSlagBombsCD:Start()
	elseif spellId == 156425 then
		warnDemolition:Show()
		specWarnDemolition:Show()
		timerDemolitionCD:Start()
	elseif spellId == 161347 then--Phase 2 Trigger
		timerDemolitionCD:Cancel()
		timerThrowSlagBombsCD:Start(11)
		timerShatteringSmashCD:Start(15)
		timerSiegemakerCD:Start(15)
		timerMarkedforDeathCD:Start(25)
	elseif spellId == 161348 then--Phase 3 Trigger
		timerSiegemakerCD:Cancel()
		timerThrowSlagBombsCD:Cancel()
		timerShatteringSmashCD:Cancel()
	end
end
