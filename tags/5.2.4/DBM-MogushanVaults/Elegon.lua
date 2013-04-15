local mod	= DBM:NewMod(726, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60410)--Energy Charge (60913), Emphyreal Focus (60776), Cosmic Spark (62618), Celestial Protector (60793)
mod:SetModelID(41399)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warnPhase1					= mod:NewPhaseAnnounce(1, 2)--117727 Charge Vortex
local warnBreath					= mod:NewSpellAnnounce(117960, 3)
local warnProtector					= mod:NewCountAnnounce(117954, 3)
local warnArcingEnergy				= mod:NewSpellAnnounce(117945, 2)--Cast randomly at 2 players, it is avoidable.
local warnClosedCircuit				= mod:NewTargetAnnounce(117949, 3, nil, mod:IsHealer())--what happens if you fail to avoid the above
local warnTotalAnnihilation			= mod:NewCastAnnounce(129711, 4)--Protector dying(exploding)
local warnStunned					= mod:NewTargetAnnounce(132222, 3, nil, mod:IsHealer())--Heroic / 132222 is stun debuff, 132226 is 2 min debuff. 
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)--124967 Draw Power
local warnDrawPower					= mod:NewCountAnnounce(119387, 4)
local warnPhase3					= mod:NewPhaseAnnounce(3, 3)--116994 Unstable Energy Starting
local warnRadiatingEnergies			= mod:NewSpellAnnounce(118310, 4)

local specWarnOvercharged			= mod:NewSpecialWarningStack(117878, nil, 6)
local specWarnTotalAnnihilation		= mod:NewSpecialWarningSpell(129711, nil, nil, nil, 2)
local specWarnProtector				= mod:NewSpecialWarningSwitch("ej6178", mod:IsDps() or mod:IsTank())
local specWarnDrawPower				= mod:NewSpecialWarningCount(119387)
local specWarnDespawnFloor			= mod:NewSpecialWarning("specWarnDespawnFloor", nil, nil, nil, 3)
local specWarnRadiatingEnergies		= mod:NewSpecialWarningSpell(118310, nil, nil, nil, 2)

local timerBreathCD					= mod:NewCDTimer(18, 117960)
local timerProtectorCD				= mod:NewCDTimer(41, 117954)
local timerArcingEnergyCD			= mod:NewCDTimer(11.5, 117945)
local timerTotalAnnihilation		= mod:NewCastTimer(4, 129711)
local timerDestabilized				= mod:NewBuffFadesTimer(120, 132226)
local timerFocusPower				= mod:NewCastTimer(16, 119358)
local timerDespawnFloor				= mod:NewTimer(6.5, "timerDespawnFloor", 116994)--6.5-7.5 variation. 6.5 is safed to use so you don't fall and die.

local berserkTimer					= mod:NewBerserkTimer(570)

mod:AddBoolOption("SetIconOnDestabilized", true)
mod:AddBoolOption("SetIconOnCreature", true)

local phase2Started = false
local protectorCount = 0
local powerCount = 0
local closedCircuitTargets = {}
local stunTargets = {}
local stunIcon = 8
local focusActivated = 0
local creatureIcons = {}
local creatureIcon = 8
local iconsSet = 6

local function warnClosedCircuitTargets()
	warnClosedCircuit:Show(table.concat(closedCircuitTargets, "<, >"))
	table.wipe(closedCircuitTargets)
end

local function warnStunnedTargets()
	warnStunned:Show(table.concat(stunTargets, "<, >"))
	table.wipe(stunTargets)
end

local function resetCreatureIconState()
	table.wipe(creatureIcons)
	creatureIcon = 8
	iconsSet = 0
end

function mod:OnCombatStart(delay)
	protectorCount = 0
	stunIcon = 8
	focusActivated = 0
	powerCount = 0
	creatureIcon = 8
	iconsSet = 6
	table.wipe(closedCircuitTargets)
	table.wipe(stunTargets)
	table.wipe(creatureIcons)
	timerBreathCD:Start(8-delay)
	timerProtectorCD:Start(10-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 124967 and not phase2Started then--Phase 2 begin/Phase 1 end
		phase2Started = true--because if you aren't fucking up, you should get more then one draw power.
		protectorCount = 0
		powerCount = 0
		warnPhase2:Show()
		timerBreathCD:Cancel()
		timerProtectorCD:Cancel()	
	elseif args.spellId == 116994 then--Phase 3 begin/Phase 2 end
		focusActivated = 0
		phase2Started = false
		warnPhase3:Show()
	elseif args.spellId == 117878 and args:IsPlayer() then
		if (args.amount or 1) >= 6 and args.amount % 3 == 0 then--Warn every 3 stacks at 6 and above.
			specWarnOvercharged:Show(args.amount)
		end
	elseif args.spellId == 119387 then -- do not add other spellids.
		powerCount = powerCount + 1
		warnDrawPower:Show(powerCount)
		specWarnDrawPower:Show(powerCount)
	elseif args.spellId == 118310 then--Below 50% health
		warnRadiatingEnergies:Show()
		specWarnRadiatingEnergies:Show()--Give a good warning so people standing outside barrior don't die.
	elseif args.spellId == 132226 then
		if args:IsPlayer() then
			timerDestabilized:Start()
		end
	elseif args.spellId == 132222 then
		stunTargets[#stunTargets + 1] = args.destName
		if self.Options.SetIconOnDestabilized then
			self:SetIcon(args.destName, stunIcon)
			stunIcon = stunIcon - 1
		end
		self:Unschedule(warnStunnedTargets)
		self:Schedule(0.3, warnStunnedTargets)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 116994 then--phase 3 end
		warnPhase1:Show()
	elseif args.spellId == 132226 then
		if args:IsPlayer() then
			timerDestabilized:Cancel()
		end
	elseif args.spellId == 132222 then
		if self.Options.SetIconOnDestabilized then
			self:SetIcon(args.destName, 0)
		end
	end
end

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnCreature and not DBM.Options.DontSetIcons and DBM:GetRaidRank() > 0 and not (iconsSet == 6) then
		for i = 1, DBM:GetNumGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if creatureIcons[guid] then
				SetRaidTarget(uId, creatureIcons[guid])
				iconsSet = iconsSet + 1
				creatureIcons[guid] = nil
			end
		end
	end
end, 1)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(116598, 132265) then--Cast when these are activated
		if focusActivated == 0 then
			resetCreatureIconState()
		end
		focusActivated = focusActivated + 1
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
		end
		if self.Options.SetIconOnCreature and not DBM.Options.DontSetIcons and not creatureIcons[args.sourceGUID] then
			creatureIcons[args.sourceGUID] = creatureIcon
			creatureIcon = creatureIcon - 1
		end
		if focusActivated == 6 then
			timerDespawnFloor:Start()
			specWarnDespawnFloor:Show()
		end
	elseif args.spellId == 116989 then--Cast when defeated (or rathor 1 HP)
		DBM.BossHealth:RemoveBoss(args.sourceGUID)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 117960 then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args.spellId == 117954 then
		protectorCount = protectorCount + 1
		warnProtector:Show(protectorCount)
		specWarnProtector:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerProtectorCD:Start(26)--26-28 variation on heroic
		else
			timerProtectorCD:Start()--35-37 on normal
		end
	elseif args.spellId == 117945 then
		warnArcingEnergy:Show()
		timerArcingEnergyCD:Start(args.sourceGUID)
	elseif args.spellId == 129711 then
		stunIcon = 8
		warnTotalAnnihilation:Show()
		specWarnTotalAnnihilation:Show()
		timerTotalAnnihilation:Start()
		timerArcingEnergyCD:Cancel(args.sourceGUID)--add is dying, so this add is done casting arcing Energy
	elseif args.spellId == 117949 then
		closedCircuitTargets[#closedCircuitTargets + 1] = args.destName
		self:Unschedule(warnClosedCircuitTargets)
		self:Schedule(0.3, warnClosedCircuitTargets)
	elseif args.spellId == 119358 then
		local _, _, _, _, startTime, endTime = UnitCastingInfo("boss1")
		local castTime
		if startTime and endTime then
			castTime = ((endTime or 0) - (startTime or 0)) / 1000
			timerFocusPower:Start(castTime)
		end
	end
end
