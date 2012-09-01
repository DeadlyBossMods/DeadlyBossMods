local mod	= DBM:NewMod(726, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7765 $"):sub(12, -3))
mod:SetCreatureID(60410)--Energy Charge (60913), Emphyreal Focus (60776), Cosmic Spark (62618), Celestial Protector (60793)
mod:SetModelID(41399)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

--[[
spellid = 116994 or spell = "Icy Touch"  and targetname = "Elegon" and sourcename = "Shiramune" and fulltype = SPELL_CAST_SUCCESS or spellid = 117960 and fulltype = SPELL_CAST_START or spellid = 117954 or spellid = 129711 or spell = "Draw Power" or spellid = 117204 or spellid = 117945 and not (fulltype = SPELL_DAMAGE) or spellid = 117949
--]]

local warnPhase1					= mod:NewPhaseAnnounce(1, 2)--117727 Charge Vortex
local warnBreath					= mod:NewSpellAnnounce(117960, 3)
local warnProtector					= mod:NewSpellAnnounce(117954, 3)
local warnArcingEnergy				= mod:NewSpellAnnounce(117945, 2)--Cast randomly at 2 players, it is avoidable.
local warnClosedCircuit				= mod:NewTargetAnnounce(117949, 3, nil, mod:IsHealer())--what happens if you fail to avoid the above
local warnTotalAnnihilation			= mod:NewCastAnnounce(129711, 4)--Protector dying(exploding)
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)--124967 Draw Power
local warnPhase3					= mod:NewPhaseAnnounce(3, 3)--116994 Unstable Energy Starting
local warnRadiatingEnergies			= mod:NewSpellAnnounce(118310, 4)

local specWarnOvercharged			= mod:NewSpecialWarningStack(117878, nil, 6)
local specWarnTotalAnnihilation		= mod:NewSpecialWarningSpell(129711, nil, nil, nil, true)
local specWarnProtector				= mod:NewSpecialWarningSwitch("ej6178", mod:IsDps() or mod:IsTank())
local specWarnClosedCircuit			= mod:NewSpecialWarningDispel(117949, false)--Probably a spammy mess if this hits a few at once. But here in case someone likes spam.
local specWarnDespawnFloor			= mod:NewSpecialWarning("specWarnDespawnFloor", nil, nil, nil, true)
local specWarnRadiatingEnergies		= mod:NewSpecialWarningSpell(118310, nil, nil, nil, true)

local timerBreathCD					= mod:NewCDTimer(18, 117960)
local timerProtectorCD				= mod:NewCDTimer(35.5, 117954)
local timerArcingEnergyCD			= mod:NewCDTimer(11.5, 117945)
local timerDespawnFloor				= mod:NewTimer(5, "timerDespawnFloor", 116994)
--Some timer work needs to be added for the adds spawning and reaching outer bubble
--(ie similar to yorsahj oozes reach, only for how long you have to kill adds before you fail and phase 2 ends)

local berserkTimer					= mod:NewBerserkTimer(570)

local phase2Started = false
local closedCircuitTargets = {}

local function warnClosedCircuitTargets()
	warnClosedCircuit:Show(table.concat(closedCircuitTargets, "<, >"))
	table.wipe(closedCircuitTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(closedCircuitTargets)
	timerBreathCD:Start(8-delay)
	timerProtectorCD:Start(14-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(124967) and not phase2Started then--Phase 2 begin/Phase 1 end
		phase2Started = true--because if you aren't fucking up, you should get more then one draw power.
		warnPhase2:Show()
		timerBreathCD:Cancel()
		timerProtectorCD:Cancel()	
	elseif args:IsSpellID(116994) then--Phase 3 begin/Phase 2 end
		phase2Started = false
		warnPhase3:Show()
		specWarnDespawnFloor:Show()
		timerDespawnFloor:Start()--Should be pretty accurate, may need minor tweak
	elseif args:IsSpellID(117878) and args:IsPlayer() then
		if (args.amount or 1) >= 6 and args.amount % 3 == 0 then--Warn every 3 stacks at 6 and above.
			specWarnOvercharged:Show(args.amount)
		end
	elseif args:IsSpellID(118310) then--Below 50% health
		warnRadiatingEnergies:Show()
		specWarnRadiatingEnergies:Show()--Give a good warning so people standing outside barrior don't die.
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(116994) then--phase 3 end
		warnPhase1:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(117960) then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args:IsSpellID(117954) then
		warnProtector:Show()
		specWarnProtector:Show()
		timerProtectorCD:Start()
	elseif args:IsSpellID(117945) then
		warnArcingEnergy:Show()
		timerArcingEnergyCD:Start(args.sourceGUID)
	elseif args:IsSpellID(129711) then
		warnTotalAnnihilation:Show()
		specWarnTotalAnnihilation:Show()
		timerArcingEnergyCD:Cancel(args.sourceGUID)--add is dying, so this add is done casting arcing Energy
	elseif args:IsSpellID(117949) then
		closedCircuitTargets[#closedCircuitTargets + 1] = args.destName
		specWarnClosedCircuit:Show(args.destName)
		self:Unschedule(warnClosedCircuitTargets)
		self:Schedule(0.3, warnClosedCircuitTargets)
	end
end
