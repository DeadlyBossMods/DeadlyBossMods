local mod	= DBM:NewMod(1196, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78491)
mod:SetEncounterID(1720)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 159996 160013 159219",
	"SPELL_CAST_SUCCESS 163594 163241",
	"SPELL_AURA_APPLIED 163241 164125",
	"SPELL_AURA_APPLIED_DOSE 163241",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify only one spore shooter spawns at a time
local warnCreepingMoss				= mod:NewTargetAnnounce(164125, 4, nil, mod:IsTank())--Persists whole fight, so just warn if boss gets it to move it
local warnInfestingSpores			= mod:NewSpellAnnounce(159996, 3)
local warnDecay						= mod:NewCountAnnounce(160013, 4, nil, not mod:IsHealer())
local warnNecroticBreath			= mod:NewSpellAnnounce(159219, 4)--Warn everyone, so they know where not to be.
local warnRot						= mod:NewStackAnnounce(163241, 2, nil, mod:IsTank())
--Adds/Mushrooms
local warnSporeShooter				= mod:NewSpellAnnounce("OptionVersion2", 163594, 3, nil, mod:IsRangedDps())
local warnFungalFlesheater			= mod:NewSpellAnnounce("ej9995", 4, 163142)--Using ej name because it doesn't match spell name at all like others
local warnMindFungus				= mod:NewSpellAnnounce(163141, 2, nil, mod:IsMelee() and not mod:IsTank())
local warnLivingMushroom			= mod:NewSpellAnnounce(160022, 1)--Good shroom! (mana/haste)
local warnRejuvMushroom				= mod:NewSpellAnnounce(160021, 1)--Other good shroom (healing)
local warnExplodingFungus			= mod:NewSpellAnnounce(163794, 4)--Mythic Shroom
local warnWaves						= mod:NewSpellAnnounce(160425, 4)--Mythic Waves

local specWarnCreepingMoss			= mod:NewSpecialWarningMove(163590, mod:IsTank())
local specWarnInfestingSpores		= mod:NewSpecialWarningSpell(159996, nil, nil, nil, 2)
local specWarnDecay					= mod:NewSpecialWarningInterrupt(160013, not mod:IsHealer())
local specWarnNecroticBreath		= mod:NewSpecialWarningSpell(159219, mod:IsTank(), nil, nil, 3)
local specWarnRot					= mod:NewSpecialWarningStack(163241, nil, 4)
local specWarnRotOther				= mod:NewSpecialWarningTaunt(163241)
local specWarnExplodingFungus		= mod:NewSpecialWarningSpell(163794, nil, nil, nil, 2)--Change warning type/sound? need to know more about spawn.
local specWarnWaves					= mod:NewSpecialWarningSpell(160425, nil, nil, nil, 2)
--Adds
local specWarnSporeShooter			= mod:NewSpecialWarningSwitch("OptionVersion2", 163594, mod:IsRangedDps())
local specWarnFungalFlesheater		= mod:NewSpecialWarningSwitch("ej9995", not mod:IsHealer())
local specWarnMindFungus			= mod:NewSpecialWarningSwitch(163141, mod:IsDps())

local timerInfestingSporesCD		= mod:NewCDTimer(57, 159996)--57-63 variation
local timerRotCD					= mod:NewCDTimer(10, 163241, nil, false)--it's a useful timer, but not mandatory and this fight has A LOT of timers so off by default for clutter reduction
local timerNecroticBreathCD			= mod:NewCDTimer(32, 159219, nil, mod:IsTank() or mod:IsHealer())
--Adds (all adds are actually NEXT timers however they get dleayed by infesting spores and necrotic breath sometimes so i'm leaving as CD for now)
local timerSporeShooterCD			= mod:NewCDTimer("OptionVersion2", 57, 163594, nil, mod:IsRangedDps())
local timerFungalFleshEaterCD		= mod:NewCDTimer(120, "ej9995", nil, not mod:IsHealer(), nil, 163142)
local timerDecayCD					= mod:NewCDTimer(9.5, 160013, nil, mod:IsMelee())
local timerMindFungusCD				= mod:NewCDTimer(30, 163141, nil, mod:IsMelee() and not mod:IsTank())
local timerLivingMushroomCD			= mod:NewCDTimer(55.5, 160022, nil, mod:IsHealer())
local timerRejuvMushroomCD			= mod:NewCDTimer(150, 160021, nil, mod:IsHealer())
--local timerExplodingFungusCD		= mod:NewCDTimer(32, 163794)--Blizzard hotfixed timer so many times during testing, that I have no idea what final timer ended up being.
local timerWavesCD					= mod:NewCDTimer(33, 160425)--Blizzard hotfixed timer so many times during testing, that I have no idea what final timer ended up being.

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownInfestingSpores		= mod:NewCountdown(57, 159996)--The variation on this annoys me, may move countdown to something more reliable if possible
local countdownFungalFleshEater		= mod:NewCountdown("Alt120", "ej9995", not mod:IsHealer())

local voiceInfestingSpores			= mod:NewVoice(159996)
local voiceNecroticBreath			= mod:NewVoice(159219, mod:IsTank() or mod:IsHealer())
local voiceLivingMushroom			= mod:NewVoice(160022)
local voiceRejuvMushroom			= mod:NewVoice(160021, mod:IsHealer())
local voiceMindFungus				= mod:NewVoice(163141, mod:IsDps())
local voiceFungalFlesheater			= mod:NewVoice("ej9995", not mod:IsHealer())
local voiceSporeShooter				= mod:NewVoice(163594, mod:IsRangedDps())
local voiceDecay					= mod:NewVoice(160013, not mod:IsHealer())

mod:AddRangeFrameOption(8, 160254, false)

mod.vb.sporesAlive = 0
mod.vb.decayCounter = 0

function mod:OnCombatStart(delay)
	self.vb.sporesAlive = 0
	self.vb.decayCounter = 0
	timerMindFungusCD:Start(10-delay)
	timerLivingMushroomCD:Start(18-delay)--16-18
	timerSporeShooterCD:Start(20-delay)--20-26
	timerNecroticBreathCD:Start(30-delay)
	timerFungalFleshEaterCD:Start(32-delay)
	countdownFungalFleshEater:Start(32-delay)
	timerInfestingSporesCD:Start(45-delay)
	countdownInfestingSpores:Start(45-delay)
	voiceInfestingSpores:Schedule(38.5-delay, "aesoon")
	timerRejuvMushroomCD:Start(80-delay)--Todo, verify 80 in all modes and not still 75 in mythic
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE",
			"SPELL_PERIODIC_DAMAGE",
			"RANGE_DAMAGE",
			"SWING_DAMAGE"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 159996 then
		warnInfestingSpores:Show()
		specWarnInfestingSpores:Show()
		timerInfestingSporesCD:Start()
		countdownInfestingSpores:Start()
		voiceInfestingSpores:Schedule(50.5, "aesoon")
	elseif spellId == 160013 then
		if self.vb.decayCounter == 2 then
			self.vb.decayCounter = 0
		end	
		self.vb.decayCounter = self.vb.decayCounter + 1
		warnDecay:Show(self.vb.decayCounter)
		local guid = args.souceGUID
		if guid == UnitGUID("target") or guid == UnitGUID("focus") then
			specWarnDecay:Show(args.sourceName)
			timerDecayCD:Start(args.sourceGUID)
			if self.vb.decayCounter == 1 then
				voiceDecay:Play("kick1r")
			elseif self.vb.decayCounter == 2 then
				voiceDecay:Play("kick2r")
			end
		end
	elseif spellId == 159219 then
		warnNecroticBreath:Show()
		specWarnNecroticBreath:Show()
		timerNecroticBreathCD:Start()
		voiceNecroticBreath:Play("changemt")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 163594 then
		self.vb.sporesAlive = self.vb.sporesAlive + 1
		warnSporeShooter:Show()
		specWarnSporeShooter:Show()
		timerSporeShooterCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		voiceSporeShooter:Play("163594k")
	elseif spellId == 163241 then
		timerRotCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 163241 then
		local amount = args.amount or 1
		warnRot:Show(args.destName, amount)
		if amount >= 4 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRot:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163241)) and not UnitIsDeadOrGhost("player") then
					specWarnRotOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 164125 and args:GetDestCreatureID() == 78491 then
		warnCreepingMoss:Show(args.destName)
		specWarnCreepingMoss:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 79183 then--Spore Shooter
		self.vb.sporesAlive = self.vb.sporesAlive - 1
		if self.Options.RangeFrame and self.vb.sporesAlive == 0 then
			DBM.RangeCheck:Hide()
		end
		DBM:Debug("Blizzard fixed UNIT_DIED for Spore Shooter, remove high cpu waste")
	elseif cid == 79092 then--Fungal Flesh Eater
		timerDecayCD:Cancel(args.destGUID)
	end
end

--here is where we waste massive amounts of cpu because one mob doesn't fire UNIT_DIED
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 79183 then--Spore Shooter don't fire UNIT_DIED
			self.vb.sporesAlive = self.vb.sporesAlive - 1
			if self.Options.RangeFrame and self.vb.sporesAlive == 0 then
				DBM.RangeCheck:Hide()
			end
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 79183 then--Spore Shooter don't fire UNIT_DIED
			self.vb.sporesAlive = self.vb.sporesAlive - 1
			if self.Options.RangeFrame and self.vb.sporesAlive == 0 then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 163141 then
		warnMindFungus:Show()
		specWarnMindFungus:Show()
		timerMindFungusCD:Start()
		voiceMindFungus:Play("163141k")
	elseif spellId == 163142 then
		warnFungalFlesheater:Show()
		specWarnFungalFlesheater:Show()
		timerFungalFleshEaterCD:Start()
		countdownFungalFleshEater:Start()
		voiceFungalFleshEater:Play("163142k")
	elseif spellId == 160022 then
		warnLivingMushroom:Show()
		timerLivingMushroomCD:Start()
		voiceLivingMushroom("160022s") --green one
	elseif spellId == 160021 or spellId == 177820 then--Seems diff ID in mythic vs non mythic?
		warnRejuvMushroom:Show()
		timerRejuvMushroomCD:Start()
		voiceRejuvMushroom("160021s") --blue one
	elseif spellId == 163794 then
		warnExplodingFungus:Show()
		specWarnExplodingFungus:Show()
--		timerExplodingFungusCD:Start()
	elseif spellId == 160425 then
		warnWaves:Show()
		specWarnWaves:Show()
		timerWavesCD:Start()
	end
end
