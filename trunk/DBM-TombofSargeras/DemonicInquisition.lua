local mod	= DBM:NewMod(1867, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116691, 116689)--Belac (116691), Atrigan (116689)
mod:SetEncounterID(2048)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(16282)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233426 234015 239401",
	"SPELL_CAST_SUCCESS 233431 233983 233894",
	"SPELL_AURA_APPLIED 233430 233441 235230 233983 233894 233431 236283",
	"SPELL_AURA_APPLIED_DOSE 248713",
	"SPELL_AURA_REMOVED 233441 235230 233983 236283",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
	"UNIT_POWER_FREQUENT player"
)

--TODO, Handling of Confess and Cage?
--TODO, target scan Scythe Sweep? or is it always on tank and should only be tank warning?
--TODO, countdown options for relevant timers. If balac doesn't get reliable timers just put countdowns on all 3 of Atrigans spells?
--[[
(ability.id = 233426 or ability.id = 234015 or ability.id = 239401) and type = "begincast"or
(ability.id = 233431 or ability.id = 233983 or ability.id = 233894) and type = "cast" or
(ability.id = 233441) and type = "applydebuff" or
(ability.id = 235230 or ability.id = 233441) and (type = "removebuff" or type = "applybuff")
--]]
--Atrigan
local warnQuills					= mod:NewTargetAnnounce(233431, 2)
--Belac
local warnEchoingAnguish			= mod:NewTargetAnnounce(233983, 3)
local warnSuffocatingDark			= mod:NewTargetAnnounce(233894, 3, nil, false)--Affects a LOT of targets
--local warnTormentingBurst			= mod:NewCountAnnounce(234015, 2)

--Atrigan
local specWarnUnbearableTorment		= mod:NewSpecialWarningYou(233430, nil, nil, nil, 1, 2)
local specWarnUnbearableTormentTank	= mod:NewSpecialWarningTaunt(233430, nil, nil, nil, 1, 2)
local specWarnScytheSweep			= mod:NewSpecialWarningSpell(233426, "Tank", nil, 2, 1, 2)
local specWarnCalcifiedQuills		= mod:NewSpecialWarningRun(233431, nil, nil, nil, 1, 2)
local yellCalcifiedQuills			= mod:NewYell(233431)
local specWarnBoneSawMelee			= mod:NewSpecialWarningRun(233441, "Melee", nil, 2, 4, 2)
local specWarnBoneSawEveryoneElse	= mod:NewSpecialWarningReflect(233441, "-Melee", nil, nil, 1, 2)
--Belac
local specWarnPangsofGuilt			= mod:NewSpecialWarningInterruptCount(239401, "HasInterrupt", nil, nil, 1, 3)
local specWarnEchoingAnguish		= mod:NewSpecialWarningMoveAway(233983, nil, nil, nil, 1, 2)
local yellEchoingAnguish			= mod:NewYell(233983)
local specWarnFelSquallMelee		= mod:NewSpecialWarningRun(235230, "Melee", nil, 2, 4, 2)
local specWarnFelSquallEveryoneElse	= mod:NewSpecialWarningReflect(235230, "-Melee", nil, nil, 1, 2)
local specWarnTormentingBurst		= mod:NewSpecialWarningCount(234015, nil, nil, nil, 2, 2)
local specWarnPrison				= mod:NewSpecialWarningYou(236283, nil, nil, nil, 1)
--local specWarnPrisonTank			= mod:NewSpecialWarningTaunt(236283, nil, nil, nil, 1, 2)
--Phase
local specWarnSoulCorruption		= mod:NewSpecialWarningStack(248713, nil, 10, nil, nil, 1, 6)--stack guessed
local specWarnTorment				= mod:NewSpecialWarningStack(233104, nil, 75, nil, nil, 1, 6)

--Atrigan
local timerScytheSweepCD			= mod:NewCDTimer(23, 233426, nil, nil, nil, 3)
local timerCalcifiedQuillsCD		= mod:NewCDTimer(20.2, 233431, nil, nil, nil, 3)--20.2-20.5 unless delayed by scythe, or bone saw
local timerBoneSawCD				= mod:NewCDTimer(45.4, 233441, nil, nil, nil, 2)
local timerBoneSaw					= mod:NewBuffActiveTimer(15, 233441, nil, nil, nil, 2)
--Belac
--local timerEchoingAnguishCD		= mod:NewAITimer(31, 233983, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--local timerSuffocatingDarkCD		= mod:NewAITimer(30, 233894, nil, nil, nil, 3)
--local timerTormentingBurstCD		= mod:NewAITimer(31, 234015, nil, nil, nil, 2)
local timerFelSquallCD				= mod:NewCDTimer(45.7, 235230, nil, nil, nil, 2)
local timerFelSquall				= mod:NewBuffActiveTimer(15, 235230, nil, nil, nil, 2)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Atrigan
local countdownBoneSaw				= mod:NewCountdown(45, 233441)

--Atrigan
local voiceScytheSweep				= mod:NewVoice(233426, "Tank", nil, 2)--shockwave
local voiceCalcifiedQuills			= mod:NewVoice(233431)--runout/keepmove
local voiceBoneSaw					= mod:NewVoice(233441)--runout/keepmove
--Belac
local voicePangsofGuilt				= mod:NewVoice(239401, "HasInterrupt")--kickcast
local voiceEchoingAnguish			= mod:NewVoice(233983)--runout
local voiceFelSquall				= mod:NewVoice(235230)--runout/stopattack
local voiceTormentingBurst			= mod:NewVoice(234015)--aesoon
--local voicePrison					= mod:NewVoice(236283)--switchphase
--Phase
local voiceSoulCorruption			= mod:NewVoice(248713)--stackhigh
local voiceTorment					= mod:NewVoice(233104)--stackhigh

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(233104, true)
mod:AddRangeFrameOption(8, 233983)

mod.vb.burstCount = 0
mod.vb.scytheCount = 0
mod.vb.pangCount = 0

local function updateAllTimers(self, ICD)
--	if not DBM.Options.DebugMode then return end
	DBM:Debug("updateAllTimers running", 3)
	if timerScytheSweepCD:GetRemaining() < ICD then--4
		local elapsed, total = timerScytheSweepCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerScytheSweepCD extended by: "..extend, 2)
		timerScytheSweepCD:Stop()
		timerScytheSweepCD:Update(elapsed, total+extend)
	end
	if timerCalcifiedQuillsCD:GetRemaining() < ICD then--3
		local elapsed, total = timerCalcifiedQuillsCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCalcifiedQuillsCD extended by: "..extend, 2)
		timerCalcifiedQuillsCD:Stop()
		timerCalcifiedQuillsCD:Update(elapsed, total+extend)
	end
	if timerBoneSawCD:GetRemaining() < ICD then--16
		local elapsed, total = timerBoneSawCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerBoneSawCD extended by: "..extend, 2)
		timerBoneSawCD:Stop()
		timerBoneSawCD:Update(elapsed, total+extend)
		countdownBoneSaw:Cancel()
		countdownBoneSaw:Start(ICD)
	end
end

function mod:OnCombatStart(delay)
	self.vb.burstCount = 0
	self.vb.scytheCount = 0
	self.vb.pangCount = 0
	timerScytheSweepCD:Start(5.2-delay)
	if not self:IsEasy() then
		timerCalcifiedQuillsCD:Start(8.5-delay)--8.5-11
	end
	timerBoneSawCD:Start(64.5-delay)
	countdownBoneSaw:Start(64.5-delay)
--	timerEchoingAnguishCD:Start(1-delay)--6-20
--	timerSuffocatingDarkCD:Start(1-delay)--13-48
--	timerTormentingBurstCD:Start(1-delay)--8-20
	timerFelSquallCD:Start(35-delay)--Always same, at least
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(233104))
		DBM.InfoFrame:Show(8, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	--if not self:IsLFR() then
	--	DBM:AddMsg("In all tests, Belac had erratic timers so most Belac timers are disabled")
	--end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233426 then
		self.vb.scytheCount = self.vb.scytheCount + 1
		specWarnScytheSweep:Show()
		voiceScytheSweep:Play("shockwave")
		timerScytheSweepCD:Start()--23 unless affected by something
		updateAllTimers(self, 4)
	elseif spellId == 234015 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnTormentingBurst:Show(self.vb.burstCount)
		voiceTormentingBurst:Play("aesoon")
		--timerTormentingBurstCD:Start()
	elseif spellId == 239401 then
		self.vb.pangCount = self.vb.pangCount + 1
		if self.vb.pangCount == 4 then
			self.vb.pangCount = 1
		end
		local kickCount = self.vb.pangCount
		specWarnPangsofGuilt:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			voicePangsofGuilt:Play("kick1r")
		elseif kickCount == 2 then
			voicePangsofGuilt:Play("kick2r")
		elseif kickCount == 3 then
			voicePangsofGuilt:Play("kick3r")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 233431 then
		timerCalcifiedQuillsCD:Start()
		updateAllTimers(self, 3)
	elseif spellId == 233983 then
		--timerEchoingAnguishCD:Start()
	elseif spellId == 233894 and self:AntiSpam(2, 2) then
		--timerSuffocatingDarkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 233430 then
		if args:IsPlayer() then
			specWarnUnbearableTorment:Show()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnUnbearableTorment:Show(args.destName)
			end
		end
	elseif spellId == 233441 then
		specWarnBoneSawMelee:Show()
		specWarnBoneSawEveryoneElse:Show(args.sourceName)
		if self:IsMelee() then
			voiceBoneSaw:Play("runout")
		end
		voiceBoneSaw:Schedule(1, "stopattack")
		timerBoneSaw:Start()
		updateAllTimers(self, 16)
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				voiceBoneSaw:Schedule(2, "keepmove")--The active tank doesn't just run out, they keep kiting
				break
			end
		end
	elseif spellId == 235230 then
		specWarnFelSquallMelee:Show(args.sourceName)
		specWarnFelSquallEveryoneElse:Show()
		if self:IsMelee() then
			voiceFelSquall:Play("runout")
		end
		voiceFelSquall:Schedule(1, "stopattack")
		timerFelSquall:Start()
	elseif spellId == 233983 then
		warnEchoingAnguish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEchoingAnguish:Show()
			voiceEchoingAnguish:Play("runout")
			yellEchoingAnguish:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 233894 then
		warnSuffocatingDark:CombinedShow(1, args.destName)
	elseif spellId == 233431 then
		if args:IsPlayer() then
			specWarnCalcifiedQuills:Show()
			voiceCalcifiedQuills:Play("runout")
			voiceCalcifiedQuills:Schedule(1, "keepmove")
			yellCalcifiedQuills:Yell()
		else
			warnQuills:Show(args.destName)
		end
	elseif spellId == 208802 then
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 10 then
			specWarnSoulCorruption:Show(amount)
			voiceSoulCorruption:Play("stackhigh")
		end
	elseif spellId == 236283 then
		if args:IsPlayer() then
			specWarnPrison:Show()
			--voicePrison:Play("switchphase")
		else
			--[[local uId = DBM:GetRaidUnitId(args.destName)
			if uId and self:IsTanking(uId) and not UnitDebuff("player", args.spellName) then
				specWarnPrisonTank:Show(args.destName)
				voicePrison:Play("tauntboss")
			end--]]
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233441 then--Bone Saw
		timerBoneSaw:Stop()
		timerBoneSawCD:Start()
		countdownBoneSaw:Start()
	elseif spellId == 233983 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 235230 then
		timerFelSquallCD:Start()
	end
end

do
	local warned = false
	function mod:UNIT_POWER_FREQUENT(uId, type)
		if type == "ALTERNATE" then
			local playerPower = UnitPower("player", 10)
			if not warned and playerPower >= 75 then
				warned = true
				specWarnTorment:Show(playerPower)
				voiceTorment:Play("stackhigh")
			elseif warned and playerPower < 30 then
				warned = false
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
