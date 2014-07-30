local mod	= DBM:NewMod(1225, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77734)
mod:SetEncounterID(1714)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 156965 156842 156854 156921",
	"SPELL_AURA_REMOVED 156921",
	"SPELL_CAST_START 157039 157001 156975 156857",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, get timers for other forms besides demonic, form chosen is RNG based so may take a few logs.
--Basic Abilities
local warnCorruption			= mod:NewTargetAnnounce(156842, 3, nil, mod:IsHealer())
local warnDrainLife				= mod:NewSpellAnnounce(156854, 4)--Spellid not verified. Likely correct
local warnRainOfFire			= mod:NewSpellAnnounce(156857, 2)
--Affliction Abilities
local warnSeedOfcorruption		= mod:NewTargetAnnounce(156921, 3)--Spellid not verified. Likely correct
--Destruction Abilities
local warnChaosBolt				= mod:NewSpellAnnounce(156975, 4)--Spellid not verified. Likely correct
--Demonic Abilities
local warnDemonForm				= mod:NewSpellAnnounce(156919, 3)
local warnDemonicLeap			= mod:NewTargetAnnounce(157039, 3)
local warnChaosWave				= mod:NewTargetAnnounce(157001, 3)
local warnDoom					= mod:NewTargetAnnounce(156965, 3, nil, mod:IsHealer())

--Basic Abilities
local specWarnCorruption		= mod:NewSpecialWarningDispel(156842, mod:IsHealer())
local specWarnDrainLife			= mod:NewSpecialWarningInterrupt(156854, not mod:IsHealer())
--Affliction Abilities
local specWarnSeedOfCorruption	= mod:NewSpecialWarningMoveAway(156921)
--Destruction Abilities
local specWarnChaosBolt			= mod:NewSpecialWarningInterrupt(156975, not mod:IsHealer())
--Demonic Abilities
local specWarnDemonicLeap		= mod:NewSpecialWarningYou(157039)
local yellDemonicLeap			= mod:NewYell(157039)
local specWarnChaosWave			= mod:NewSpecialWarningYou(157001)
local specWarnDoom				= mod:NewSpecialWarningTarget(156965, false)

--Demonic Abilities
local timerChaosWaveCD			= mod:NewCDTimer(13, 157001)--13-17 variation
local timerDemonicLeapCD		= mod:NewCDTimer(20, 157039)

mod:AddRangeFrameOption(10, 156921)

function mod:LeapTarget(targetname, uId)
	if not targetname then return end
	warnDemonicLeap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDemonicLeap:Show()
		yellDemonicLeap:Yell()
	end
end

function mod:ChaosWaveTarget(targetname, uId)
	if not targetname then return end
	warnChaosWave:Show(targetname)
	if targetname == UnitName("player") then
		specWarnChaosWave:Show()
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156965 then
		warnDoom:Show(args.destName)
		specWarnDoom:Show(args.destName)
	elseif spellId == 156842 then
		warnCorruption:Show(args.destName)
		specWarnCorruption:Show(args.destName)
	elseif spellId == 156854 then
		warnDrainLife:Show()
		specWarnDrainLife:Show(args.sourceName)
	elseif spellId == 156921 then
		warnSeedOfcorruption:Show(args.destName)
		if args:IsPlayer() then
			specWarnSeedOfCorruption:Show()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156921 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 157039 then
		timerDemonicLeapCD:Start()
		self:BossTargetScanner(77734, "LeapTarget", 0.1, 16)--Timing not verified, but Boss DOES look at leap target
	elseif spellId == 157001 then
		timerChaosWaveCD:Start()
		self:BossTargetScanner(77734, "ChaosWaveTarget", 0.1, 16)--Timing not verified, but Boss DOES look at leap target
	elseif spellId == 156975 then
		warnChaosBolt:Show()
		specWarnChaosBolt:Show(args.sourceName)
	elseif spellId == 156857 then
		warnRainOfFire:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156919 and self:AntiSpam(2, 1) then--Demonology Transformation
		self:SendSync("DemonForm")--Syncing because IEEU is broken on fight and so there is no "boss1"
	end
end

function mod:OnSync(event, arg)
	if event == "DemonForm" then
		timerChaosWaveCD:Start(10)
		timerDemonicLeapCD:Start(23)
	end
end
