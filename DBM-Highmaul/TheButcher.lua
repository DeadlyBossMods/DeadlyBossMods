local mod	= DBM:NewMod(971, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77404)
mod:SetEncounterID(1706)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156157 156293",
	"SPELL_AURA_APPLIED 156152 156151 156598",
	"SPELL_AURA_APPLIED_DOSE 156152 156151",
	"SPELL_AURA_REMOVED 156152",
	"SPELL_CAST_SUCCESS 156143 156172",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Probably fix the update bar if it lua errors or doesn't work right.
local warnCleave					= mod:NewCountAnnounce(156157, 2, nil, false)
local warnBoundingCleave			= mod:NewCountAnnounce(156160, 3)
local warnTenderizer				= mod:NewStackAnnounce(156151, 2, nil, mod:IsTank())
local warnCleaver					= mod:NewSpellAnnounce(156143, 3, nil, mod:IsTank())--Saberlash
local warnFrenzy					= mod:NewTargetAnnounce(156598, 4)

local specWarnTenderizer			= mod:NewSpecialWarningStack(156151, nil, 2)
local specWarnTenderizerOther		= mod:NewSpecialWarningTaunt(156151, nil, nil, nil, nil, true)
local specWarnGushingWounds			= mod:NewSpecialWarningStack(156152, nil, 2, nil, nil, nil, true)
local specWarnBoundingCleave		= mod:NewSpecialWarningCount(156160, nil, nil, nil, 2, true)
local specWarnBoundingCleaveEnded	= mod:NewSpecialWarningEnd(156160)
local specWarnPaleVitriol			= mod:NewSpecialWarningMove(163046, nil, nil, nil, nil, true)--Mythic

local timerCleaveCD					= mod:NewCDTimer(6, 156157, nil, false)
local timerTenderizerCD				= mod:NewCDTimer(17, 156151, nil, mod:IsTank())
local timerCleaverCD				= mod:NewCDTimer(8.5, 156143, nil, mod:IsTank())--Maybe change to off by default if i get a general consensus from other tanks if this is useful.
local timerGushingWounds			= mod:NewBuffFadesTimer(15, 156152)
local timerBoundingCleaveCD			= mod:NewNextCountTimer(60, 156160)
local timerBoundingCleave			= mod:NewCastTimer(15, 156160)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownCleaver				= mod:NewCountdown("Alt8.5", 156143, mod:IsTank())
local countdownBoundingCleave		= mod:NewCountdown(60, 156160)

local voiceCleave					= mod:NewVoice(156157, mod:IsMelee())
local voiceTenderizer				= mod:NewVoice(156151, mod:IsTank())
local voiceGushingWound				= mod:NewVoice(156152, false)--off by default because only one person needs to run out in most strats, not everyone. Only that person should enable option
local voiceFrenzy					= mod:NewVoice(156598)
local voiceBoundingCleaveSoon		= mod:NewVoice(156160)
local voicePaleVitriol				= mod:NewVoice(163046) --Mythic only

mod.vb.cleaveCount = 0
mod.vb.boundingCleave = 0
mod.vb.isFrenzied = false

function mod:OnCombatStart(delay)
	self.vb.cleaveCount = 0
	self.vb.boundingCleave = 0
	self.vb.isFrenzied = false
	timerTenderizerCD:Start(6-delay)
	timerCleaveCD:Start(10-delay)--Verify this wasn't caused by cleave bug.
	timerCleaverCD:Start(12-delay)
	countdownCleaver:Start(12-delay)
	timerBoundingCleaveCD:Start(-delay, 1)
	voiceBoundingCleaveSoon:Schedule(53.5-delay, "156160")
	countdownBoundingCleave:Start(-delay)
	if self:IsMythic() then
		berserkTimer:Start(240-delay)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 163046",
			"SPELL_PERIODIC_MISSED 163046"
		)
	elseif self:IsHeroic() then
		berserkTimer:Start(-delay)
	else
		--Find berserk for LFR & Normal
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156157 or spellId == 156293 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		warnCleave:Show(self.vb.cleaveCount)
		timerCleaveCD:Start()
		if not self:IsLFR() then --never play this in LFR
			voiceCleave:Play("156157")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGushingWounds:Start()
		if (self:IsMythic() and amount > 1) or (self:IsHeroic() and amount > 2) or (self:IsNormal() and amount > 3) then--Mythic max stack 4, heroic 5, normal 6. Common Strats re generally out at 2, 3, 4
			specWarnGushingWounds:Show(amount)
			voiceGushingWound:Play("runout")
		end
	elseif spellId == 156151 then
		local amount = args.amount or 1
		warnTenderizer:Show(args.destName, amount)
		timerTenderizerCD:Start()
		if amount >= 2 then
			voiceTenderizer:Play("changemt")
			if args:IsPlayer() then
				specWarnTenderizer:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(156151)) and not UnitIsDeadOrGhost("player") then
					specWarnTenderizerOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 156598 then
		self.vb.isFrenzied = true
		warnFrenzy:Show(args.destName)
		voiceFrenzy:Play("frenzy")
		--Update bounding cleave timer
		local bossPower = UnitPower("boss1")
		local bossProgress = bossPower * 0.3--Under frenzy he gains energy twice as fast. So about 3.33 energy per seocnd, 30 seconds to full power.
		timerBoundingCleaveCD:Update(bossProgress, 30, self.vb.boundingCleave+1)--Will bar update work correctly on a count bar? Looking at code I don't think it will, it doesn't accept/pass on extra args in Update call.
		countdownBoundingCleave:Cancel()
		voiceBoundingCleaveSoon:Cancel()
		local newTime = 30-bossProgress
		if newTime >= 3 then--Don't start countdown if only 2 seconds left
			countdownBoundingCleave:Start(newTime)
		end
		if newTime >= 8.5 then--Prevent a number lower than 2
			voiceBoundingCleaveSoon:Schedule(30-bossProgress-6.5, "156160")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		timerGushingWounds:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156143 then
		warnCleaver:Show()
		timerCleaverCD:Start()
		countdownCleaver:Start()
	elseif spellId == 156172 then--The cleave finisher of Bounding Cleave. NOT to be confused with other cleave.
		specWarnBoundingCleaveEnded:Show()
		--Timer for when regular cleave resumes
		if self.vb.isFrenzied then
			timerCleaveCD:Start(5)
		else
			timerCleaveCD:Start(11)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 163046 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnPaleVitriol:Show()
		voicePaleVitriol:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156197 or spellId == 156257 then
		self.vb.cleaveCount = 0
		self.vb.boundingCleave = self.vb.boundingCleave + 1
		timerCleaveCD:Cancel()
		warnBoundingCleave:Show(self.vb.boundingCleave)
		specWarnBoundingCleave:Show(self.vb.boundingCleave)
		timerTenderizerCD:Start(15)
		timerCleaverCD:Start(21)
		countdownCleaver:Cancel()
		countdownCleaver:Start(21)
		if self.vb.isFrenzied then
			timerBoundingCleave:Start(5)
			timerBoundingCleaveCD:Start(30, self.vb.boundingCleave+1)
			countdownBoundingCleave:Start(30)
			voiceBoundingCleaveSoon:Schedule(23.5, "156160")
		else
			timerBoundingCleave:Start(9)
			timerBoundingCleaveCD:Start(nil, self.vb.boundingCleave+1)
			countdownBoundingCleave:Start(60)
			voiceBoundingCleaveSoon:Schedule(53.5, "156160")
		end
	end
end
