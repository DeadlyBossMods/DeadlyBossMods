local mod	= DBM:NewMod(1196, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78491)
mod:SetEncounterID(1720)
mod:SetZone()
--Has no audio files

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
local warnInfestingSpores			= mod:NewCountAnnounce(159996, 3)
local warnDecay						= mod:NewCountAnnounce(160013, 4, nil, not mod:IsHealer())
local warnNecroticBreath			= mod:NewSpellAnnounce(159219, 4)--Warn everyone, so they know where not to be.
local warnRot						= mod:NewStackAnnounce(163241, 2, nil, mod:IsTank())
--Adds/Mushrooms
local warnSporeShooter				= mod:NewSpellAnnounce("OptionVersion2", 163594, 3, nil, mod:IsRangedDps())
local warnFungalFlesheater			= mod:NewCountAnnounce("ej9995", 4, 163142)--Using ej name because it doesn't match spell name at all like others
local warnMindFungus				= mod:NewSpellAnnounce(163141, 2, nil, mod:IsMelee() and not mod:IsTank())
local warnLivingMushroom			= mod:NewCountAnnounce(160022, 1)--Good shroom! (mana/haste)
local warnRejuvMushroom				= mod:NewCountAnnounce(160021, 1)--Other good shroom (healing)
local warnExplodingFungus			= mod:NewSpellAnnounce(163794, 4)--Mythic Shroom
local warnWaves						= mod:NewSpellAnnounce(160425, 4)--Mythic Waves

local specWarnCreepingMoss			= mod:NewSpecialWarningMove(163590, mod:IsTank())
local specWarnInfestingSpores		= mod:NewSpecialWarningCount(159996, nil, nil, nil, 2, nil, true)
local specWarnDecay					= mod:NewSpecialWarningInterrupt(160013, not mod:IsHealer(), nil, nil, nil, nil, true)
local specWarnNecroticBreath		= mod:NewSpecialWarningSpell(159219, mod:IsTank(), nil, nil, 3)
local specWarnRot					= mod:NewSpecialWarningStack(163241, nil, 3)
local specWarnRotOther				= mod:NewSpecialWarningTaunt(163241, nil, nil, nil, nil, nil, true)
local specWarnExplodingFungus		= mod:NewSpecialWarningSpell(163794, nil, nil, nil, 2, nil, true)--Change warning type/sound? need to know more about spawn.
local specWarnWaves					= mod:NewSpecialWarningSpell(160425, nil, nil, nil, 2, nil, true)
--Adds
local specWarnSporeShooter			= mod:NewSpecialWarningSwitch("OptionVersion2", 163594, mod:IsRangedDps(), nil, nil, nil, nil, true)
local specWarnFungalFlesheater		= mod:NewSpecialWarningSwitch("ej9995", not mod:IsHealer(), nil, nil, nil, nil, true)
local specWarnMindFungus			= mod:NewSpecialWarningSwitch(163141, mod:IsDps(), nil, nil, nil, nil, true)

local timerInfestingSporesCD		= mod:NewCDCountTimer(57, 159996)--57-63 variation
local timerRotCD					= mod:NewCDTimer(10, 163241, nil, false)--it's a useful timer, but not mandatory and this fight has A LOT of timers so off by default for clutter reduction
local timerNecroticBreathCD			= mod:NewCDTimer(32, 159219, nil, mod:IsTank() or mod:IsHealer())
--Adds (all adds are actually NEXT timers however they get dleayed by infesting spores and necrotic breath sometimes so i'm leaving as CD for now)
local timerSporeShooterCD			= mod:NewCDTimer("OptionVersion2", 57, 163594, nil, mod:IsRangedDps())
local timerFungalFleshEaterCD		= mod:NewCDCountTimer(120, "ej9995", nil, not mod:IsHealer(), nil, 163142)
local timerDecayCD					= mod:NewCDTimer(9.5, 160013, nil, mod:IsMelee())
local timerMindFungusCD				= mod:NewCDTimer(30, 163141, nil, mod:IsMelee() and not mod:IsTank())
local timerLivingMushroomCD			= mod:NewCDCountTimer(55.5, 160022, nil, mod:IsHealer())
local timerRejuvMushroomCD			= mod:NewCDCountTimer(150, 160021, nil, mod:IsHealer())
local timerSpecialCD				= mod:NewCDSpecialTimer(20)--Mythic Specials. Shared cd, which special he uses is random. 20-25 second variation, unless delayed by spores. then 20-25+10

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownInfestingSpores		= mod:NewCountdown(57, 159996)--The variation on this annoys me, may move countdown to something more reliable if possible
local countdownFungalFleshEater		= mod:NewCountdown("Alt120", "ej9995", not mod:IsHealer())

local voiceInfestingSpores			= mod:NewVoice(159996)
local voiceRot						= mod:NewVoice("OptionVersion2", 163241)
local voiceLivingMushroom			= mod:NewVoice(160022)
local voiceRejuvMushroom			= mod:NewVoice(160021)
local voiceMindFungus				= mod:NewVoice(163141, mod:IsDps())
local voiceFungalFlesheater			= mod:NewVoice("ej9995", not mod:IsHealer())
local voiceSporeShooter				= mod:NewVoice(163594, mod:IsRangedDps())
local voiceDecay					= mod:NewVoice(160013, not mod:IsHealer())
local voiceExplodingFungus			= mod:NewVoice(163794)
local voiceWaves					= mod:NewVoice(160425)
local voiceCreepingMoss				= mod:NewVoice(163590, mod:IsTank())

mod:AddRangeFrameOption(8, 160254, false)
mod:AddDropdownOption("InterruptCounter", {"Two", "Three", "Four"}, "Two", "misc")

mod.vb.sporesAlive = 0
mod.vb.decayCounter = 0
mod.vb.greenShroom = 0
mod.vb.blueShroom = 0
mod.vb.sporesCount = 0
mod.vb.fleshEaterCount = 0

function mod:OnCombatStart(delay)
	self.vb.sporesAlive = 0
	self.vb.decayCounter = 0
	self.vb.greenShroom = 0
	self.vb.blueShroom = 0
	self.vb.sporesCount = 0
	self.vb.fleshEaterCount = 0
	timerMindFungusCD:Start(10-delay)
	timerLivingMushroomCD:Start(18-delay, 1)--16-18
	timerSporeShooterCD:Start(20-delay)--20-26
	timerNecroticBreathCD:Start(30-delay)
	timerFungalFleshEaterCD:Start(32-delay, 1)
	countdownFungalFleshEater:Start(32-delay)
	timerInfestingSporesCD:Start(45-delay, 1)
	countdownInfestingSpores:Start(45-delay)
	voiceInfestingSpores:Schedule(38.5-delay, "aesoon")
	timerRejuvMushroomCD:Start(80-delay, 1)--Todo, verify 80 in all modes and not still 75 in mythic
	berserkTimer:Start(-delay)
	if self:IsMythic() then
		timerSpecialCD:Start(-delay)--standard 20-25
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
		self.vb.sporesCount = self.vb.sporesCount + 1
		warnInfestingSpores:Show(self.vb.sporesCount)
		specWarnInfestingSpores:Show(self.vb.sporesCount)
		timerInfestingSporesCD:Start(nil, self.vb.sporesCount+1)
		countdownInfestingSpores:Start()
		voiceInfestingSpores:Schedule(50.5, "aesoon")
	elseif spellId == 160013 then
		if (self.Options.InterruptCounter == "Two" and self.vb.decayCounter == 2) or (self.Options.InterruptCounter == "Three" and self.vb.decayCounter == 3) or self.vb.decayCounter == 4 then
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
			elseif self.vb.decayCounter == 3 then
				voiceDecay:Play("kick3r")
			elseif self.vb.decayCounter == 4 then
				voiceDecay:Play("kick4r")
			end
		end
	elseif spellId == 159219 then
		warnNecroticBreath:Show()
		specWarnNecroticBreath:Show()
		timerNecroticBreathCD:Start()
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
		if amount >= 3 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRot:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163241)) and not UnitIsDeadOrGhost("player") then
					specWarnRotOther:Show(args.destName)
					voiceRot:Play("changemt")
				end
			end
		end
	elseif spellId == 164125 and args:GetDestCreatureID() == 78491 then
		warnCreepingMoss:Show(args.destName)
		specWarnCreepingMoss:Show()
		voiceCreepingMoss:Play("bossout")
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
	elseif cid == 79092 then--Fungal Flesh Eater
		self.vb.decayCounter = 0
		timerDecayCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 163141 then
		warnMindFungus:Show()
		specWarnMindFungus:Show()
		timerMindFungusCD:Start()
		voiceMindFungus:Play("163141k")
	elseif spellId == 163142 then
		self.vb.fleshEaterCount = self.vb.fleshEaterCount + 1
		warnFungalFlesheater:Show(self.vb.fleshEaterCount)
		specWarnFungalFlesheater:Show()
		timerFungalFleshEaterCD:Start(nil, self.vb.fleshEaterCount+1)
		countdownFungalFleshEater:Start()
		voiceFungalFlesheater:Play("163142k")
	elseif spellId == 160022 then
		self.vb.greenShroom = self.vb.greenShroom + 1
		warnLivingMushroom:Show(self.vb.greenShroom)
		timerLivingMushroomCD:Start(nil, self.vb.greenShroom+1)
		voiceLivingMushroom:Play("160022s") --green one
	elseif spellId == 160021 or spellId == 177820 then--Seems diff ID in mythic vs non mythic?
		self.vb.blueShroom = self.vb.blueShroom + 1
		warnRejuvMushroom:Show(self.vb.blueShroom)
		timerRejuvMushroomCD:Start(nil, self.vb.blueShroom+1)
		voiceRejuvMushroom:Play("160021s") --blue one
	elseif spellId == 163794 then
		warnExplodingFungus:Show()
		specWarnExplodingFungus:Show()
		timerSpecialCD:Start()
		voiceExplodingFungus:Play("watchstep")
	elseif spellId == 160425 then
		warnWaves:Show()
		specWarnWaves:Show()
		timerSpecialCD:Start()
		voiceWaves:Play("watchwave")
	end
end
