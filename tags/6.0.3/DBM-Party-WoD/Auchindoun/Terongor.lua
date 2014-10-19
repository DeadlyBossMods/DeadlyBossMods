local mod	= DBM:NewMod(1225, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77734)
mod:SetEncounterID(1714)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 156965 156842 156921 157168 164841",
	"SPELL_AURA_REMOVED 156921",
	"SPELL_CAST_SUCCESS 156854",
	"SPELL_CAST_START 157039 157001 156975 156857",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, get timers for other forms besides demonic, form chosen is RNG based so may take a few logs.
--Basic Abilities
local warnDrainLife				= mod:NewTargetAnnounce(156854, 4)
local warnCorruption			= mod:NewTargetAnnounce(156842, 3, nil, mod:IsHealer())--Seems 1 phase only spell.
local warnRainOfFire			= mod:NewSpellAnnounce(156857, 2)--Seems 1 phase only spell.
--Unknown Abilities
--local warnInferno // no trigger, impossible now. Affliction only?
local warnFixate				= mod:NewTargetAnnounce(157168, 2, nil, false)--Seems spammy if kite it.
--Affliction Abilities
local warnSeedOfcorruption		= mod:NewTargetAnnounce(156921, 3)
local warnExhaustion			= mod:NewTargetAnnounce(164841, 3, nil, mod:CanRemoveCurse())
--Destruction Abilities
local warnChaosBolt				= mod:NewSpellAnnounce(156975, 4)--Spellid not verified. Likely correct
--Demonic Abilities
local warnDemonForm				= mod:NewSpellAnnounce(156919, 3)
local warnDemonicLeap			= mod:NewTargetAnnounce(157039, 3)
local warnChaosWave				= mod:NewTargetAnnounce(157001, 3)
local warnDoom					= mod:NewTargetAnnounce(156965, 3, nil, mod:IsHealer())

--Basic Abilities
local specWarnDrainLife			= mod:NewSpecialWarningInterrupt(156854, not mod:IsHealer())
local specWarnCorruption		= mod:NewSpecialWarningDispel(156842, mod:IsHealer())
local spceWarnRainOfFire		= mod:NewSpecialWarningSpell(156857, nil, nil, nil, 2)
--Unknown Abilities
local specWarnFixate			= mod:NewSpecialWarningRun(157168)
--Affliction Abilities
--TODO : Maybe need shit warning.
local specWarnSeedOfCorruption	= mod:NewSpecialWarningMoveAway(156921)
local specWarnExhaustion		= mod:NewSpecialWarningDispel(164841, mod:CanRemoveCurse())
--Destruction Abilities
local specWarnChaosBolt			= mod:NewSpecialWarningInterrupt(156975, not mod:IsHealer())
--Demonic Abilities
local specWarnDemonicLeap		= mod:NewSpecialWarningYou(157039)
local yellDemonicLeap			= mod:NewYell(157039)
local specWarnChaosWave			= mod:NewSpecialWarningYou(157001)
local yellWarnChaosWave			= mod:NewYell(157001)
local specWarnDoom				= mod:NewSpecialWarningTarget(156965, false)

--Basic Abilities
local timerDrainLifeCD			= mod:NewCDTimer(15, 156854)--15~18 variation
--Unknown Abilities
local timerFixate				= mod:NewBuffFadesTimer(12, 157168)--No CD timer for this spell. can be spammy and useless.
--Affliction Abilities
local timerSeedOfcorruption		= mod:NewBuffFadesTimer(15, 156921)
--local timerSeedOfcorruptionCD	= mod:NewCDTimer(12, 156921)--12-20 varitation. Large variation, seems useless.
--local timerExhaustionCD			= mod:NewCDTimer(14, 164841)--14~24 variation. Large variation, seems useless.
--Demonic Abilities
local timerChaosWaveCD			= mod:NewCDTimer(13, 157001)--13-17 variation
local timerDemonicLeapCD		= mod:NewCDTimer(20, 157039)

--Affliction Abilities
local countdownSeedOfcorruption	= mod:NewCountdownFades(15, 156921)

mod:AddRangeFrameOption(10, 156921)

local seedDebuff = GetSpellInfo(156921)
local DebuffFilter
do
	DebuffFilter = function(uId)
		return UnitDebuff(uId, seedDebuff)
	end
end

--Important, needs recover
mod.vb.seedCount = 0

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
		yellWarnChaosWave:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.seedCount = 0
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
	elseif spellId == 156921 and args:IsDestTypePlayer() then--This debuff can be spread to the boss. bugged?
		self.vb.seedCount = self.vb.seedCount + 1
		warnSeedOfcorruption:Show(args.destName)
		--timerSeedOfcorruptionCD:Start()
		if args:IsPlayer() then
			specWarnSeedOfCorruption:Show()
			timerSeedOfcorruption:Start()
			countdownSeedOfcorruption:Start()
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", seedDebuff) then--You have debuff, show everyone
				DBM.RangeCheck:Show(10, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(10, DebuffFilter)
			end
		end
	elseif spellId == 157168 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			timerFixate:Start(args.sourceGUID)--Show multiple timer.
		end
	elseif spellId == 164841 then
		warnExhaustion:Show(args.destName)
		specWarnExhaustion:Show(args.destName)
		--timerExhaustionCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156921 and args:IsDestTypePlayer() then
		self.vb.seedCount = self.vb.seedCount - 1
		if args:IsPlayer() then
			timerSeedOfcorruption:Cancel()
			countdownSeedOfcorruption:Cancel()
		end
		if self.Options.RangeFrame and self.vb.seedCount == 0 then
			DBM.RangeCheck:Hide()
		end
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
		spceWarnRainOfFire:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156854 then
		warnDrainLife:Show(args.destName)
		specWarnDrainLife:Show(args.sourceName)
		timerDrainLifeCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156919 and self:AntiSpam(2, 1) then--Demonology Transformation
		self:SendSync("DemonForm")--Syncing because IEEU is broken on fight and so there is no "boss1"
	elseif spellId == 156863 and self:AntiSpam(2, 1) then--Affliction Transformation
		self:SendSync("AfflictionForm")
	end
end

function mod:OnSync(event, arg)
	if event == "DemonForm" then
		timerChaosWaveCD:Start(10)
		timerDemonicLeapCD:Start(23)
	elseif event == "AfflictionForm" then
		--no timer or warning yet. need more logs to confirm. maybe add phase 2 warning?
	end
end
