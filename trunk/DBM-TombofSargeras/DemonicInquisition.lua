local mod	= DBM:NewMod(1867, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116691, 116689)--Belac (116691), Atrigan (116689)
mod:SetEncounterID(2048)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233426 234015 239401",
	"SPELL_CAST_SUCCES 233431 233983 233894",
	"SPELL_AURA_APPLIED 233430 233441 235230 233983 233894 233431",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 233441 235230 233983 233431 235230"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
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
local specWarnScytheSweep			= mod:NewSpecialWarningDodge(233426, nil, nil, nil, 1, 2)
local specWarnCalcifiedQuills		= mod:NewSpecialWarningRun(233431, nil, nil, nil, 1, 2)
local yellCalcifiedQuills			= mod:NewYell(233431)
local specWarnBoneSaw				= mod:NewSpecialWarningRun(233441, nil, nil, nil, 4, 2)
--Belac
local specWarnPangsofGuilt			= mod:NewSpecialWarningInterruptCount(239401, "HasInterrupt", nil, nil, 1, 3)
local specWarnEchoingAnguish		= mod:NewSpecialWarningMoveAway(233983, nil, nil, nil, 1, 2)
local yellEchoingAnguish			= mod:NewYell(233983)
local specWarnFelSquall				= mod:NewSpecialWarningRun(235230, nil, nil, nil, 4, 2)
local specWarnTormentingBurst		= mod:NewSpecialWarningCount(234015, nil, nil, nil, 2, 2)

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
local voiceScytheSweep				= mod:NewVoice(233426)--shockwave
local voiceCalcifiedQuills			= mod:NewVoice(233431)--runout/keepmove
local voiceBoneSaw					= mod:NewVoice(233441)--runout/keepmove
--Belac
local voicePangsofGuilt				= mod:NewVoice(239401, "HasInterrupt")--kickcast
local voiceEchoingAnguish			= mod:NewVoice(233983)--runout
local voiceFelSquall				= mod:NewVoice(235230)--runout/keepmove
local voiceTormentingBurst			= mod:NewVoice(234015)--aesoon

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(233104, true)
mod:AddRangeFrameOption(8, 233983)

mod.vb.burstCount = 0
mod.vb.scytheCount = 0
mod.vb.pangCount = 0

function mod:OnCombatStart(delay)
	self.vb.burstCount = 0
	self.vb.scytheCount = 0
	self.vb.pangCount = 0
	timerScytheSweepCD:Start(5.5-delay)
	timerCalcifiedQuillsCD:Start(8.5-delay)--8.5-11
	timerBoneSawCD:Start(60.5-delay)
	countdownBoneSaw:Start(60.5-delay)
--	timerEchoingAnguishCD:Start(1-delay)--6-20
--	timerSuffocatingDarkCD:Start(1-delay)--13-48
--	timerTormentingBurstCD:Start(1-delay)--8-20
	timerFelSquallCD:Start(30-delay)--Always same, at least
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(233104))
		DBM.InfoFrame:Show(8, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	if not self:IsLFR() then
		DBM:AddMsg("In normal/heroic/Mythc tests, Belac had erratic timers so most Belac timers are disabled")
	end
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
		local remaining = timerBoneSawCD:GetRemaining()
		if remaining > 23 then
			timerScytheSweepCD:Start(23)--23 unless affected by something
		else
			timerScytheSweepCD:Start(remaining+22)--7 seconds after bone saw ends
		end
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
		local remaining = timerBoneSawCD:GetRemaining()
		if remaining > 20 then
			timerCalcifiedQuillsCD:Start()
		else
			timerCalcifiedQuillsCD:Start(remaining+16)--1 second after bone saw ends
		end
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
		specWarnBoneSaw:Show()
		voiceBoneSaw:Play("runout")
		timerBoneSaw:Start()
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				voiceBoneSaw:Schedule(1, "keepmove")--The active tank doesn't just run out, they keep kiting
				break
			end
		end
	elseif spellId == 235230 then
		specWarnFelSquall:Show()
		voiceFelSquall:Play("runout")
		timerFelSquall:Start()
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				voiceFelSquall:Schedule(1, "keepmove")--The active tank doesn't just run out, they keep kiting
				break
			end
		end
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
			voiceScytheSweep:Play("runout")
			voiceScytheSweep:Schedule(1, "keepmove")
			yellCalcifiedQuills:Yell()
		else
			warnQuills:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
