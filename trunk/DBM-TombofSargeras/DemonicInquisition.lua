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
	"SPELL_CAST_START 233426",
	"SPELL_CAST_SUCCES 233431 233983 233894 234015",
	"SPELL_AURA_APPLIED 233430 233441 235230 233983 233894",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 233441 235230 233983",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Handling of Confess and Cage?
--TODO, target scan Scythe Sweep? or is it always on tank and should only be tank warning?
--TODO, correct event and who Calcified Quills actually targets. Current mod event is too late. Must have an invisible Unit event or warning is useless
--TODO, timer option default improvements to reduce timer clutter.
--TODO, countdown options for relevant timers.
--[[
ability.id = 233426 and type = "begincast"or
(ability.id = 233431 or ability.id = 233983 or ability.id = 233894 or ability.id = 234015) and type = "cast" or
(ability.id = 233441) and type = "applydebuff" or
(ability.id = 235230 or ability.id = 233441) and (type = "removebuff" or type = "applybuff")
--]]
--Belac
local warnEchoingAnguish			= mod:NewTargetAnnounce(233983, 3)
local warnSuffocatingDark			= mod:NewTargetAnnounce(233894, 3, nil, false)--Affects a LOT of targets
local warnTormentingBurst			= mod:NewCountAnnounce(234015, 2)

--Osseus/Atrigan
local specWarnUnbearableTorment		= mod:NewSpecialWarningYou(233430, nil, nil, nil, 1, 2)
local specWarnUnbearableTormentTank	= mod:NewSpecialWarningTaunt(233430, nil, nil, nil, 1, 2)
local specWarnScytheSweep			= mod:NewSpecialWarningDodge(233426, nil, nil, nil, 1, 2)
local specWarnCalcifiedQuills		= mod:NewSpecialWarningDodge(233431, nil, nil, nil, 2, 2)
local specWarnBoneSaw				= mod:NewSpecialWarningRun(233441, nil, nil, nil, 4, 2)
--Belac
local specWarnEchoingAnguish		= mod:NewSpecialWarningMoveAway(233983, nil, nil, nil, 1, 2)
local yellEchoingAnguish			= mod:NewYell(233983)
local specWarnFelSquall				= mod:NewSpecialWarningRun(235230, nil, nil, nil, 4, 2)

--Osseus/Atrigan
local timerScytheSweepCD			= mod:NewCDTimer(23, 233426, nil, nil, nil, 3)
local timerCalcifiedQuillsCD		= mod:NewCDTimer(20.5, 233431, nil, nil, nil, 3)--20.5 unless delayed by scythe, or bone saw
local timerBoneSawCD				= mod:NewCDTimer(45.4, 233441, nil, nil, nil, 2)
local timerBoneSaw					= mod:NewBuffActiveTimer(15, 233441, nil, nil, nil, 2)
--Belac
--local timerEchoingAnguishCD			= mod:NewAITimer(31, 233983, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--local timerSuffocatingDarkCD		= mod:NewAITimer(31, 233894, nil, nil, nil, 3)
--local timerTormentingBurstCD		= mod:NewAITimer(31, 234015, nil, nil, nil, 2)
--local timerFelSquallCD				= mod:NewAITimer(31, 235230, nil, nil, nil, 2)
local timerFelSquall				= mod:NewBuffActiveTimer(15, 235230, nil, nil, nil, 2)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Osseus/Atrigan
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Osseus/Atrigan
local voiceScytheSweep				= mod:NewVoice(233426)--shockwave
local voiceCalcifiedQuills			= mod:NewVoice(233431)--watchstep
local voiceBoneSaw					= mod:NewVoice(233441)--runout/keepmove
--Belac
local voiceEchoingAnguish			= mod:NewVoice(233983)--runout
local voiceFelSquall				= mod:NewVoice(235230)--runout/keepmove

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(233104, true)
mod:AddRangeFrameOption(8, 233983)

mod.vb.burstCount = 0
mod.vb.scytheCount = 0

function mod:OnCombatStart(delay)
	self.vb.burstCount = 0
	self.vb.scytheCount = 0
	timerScytheSweepCD:Start(5.5-delay)
	timerCalcifiedQuillsCD:Start(10.5-delay)
	timerBoneSawCD:Start(60.5-delay)
--	timerEchoingAnguishCD:Start(1-delay)
--	timerSuffocatingDarkCD:Start(1-delay)
--	timerTormentingBurstCD:Start(1-delay)
--	timerFelSquallCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(233104))
		DBM.InfoFrame:Show(8, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	DBM:AddMsg("In last normal/heroic tests, Belac had erratic and completely random timers so all Belac timers are disabled")
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
		timerScytheSweepCD:Start()
		--Every even cast is 32 seconds after last odd cast, except for first 1, else 23
		if self.vb.scytheCount ~= 1 and self.vb.scytheCount % 2 ~= 0 then
			timerScytheSweepCD:Start(32)--32-34
		else
			timerScytheSweepCD:Start(23)--always 23
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 233431 then
		--Useless to warn here, this fires on cast finish. there is no cast start event
		--Needs replacing with a UNIT event or something earlier such as chat message/emote
		specWarnCalcifiedQuills:Show()
		voiceScytheSweep:Play("watchstep")
		timerCalcifiedQuillsCD:Start()
	elseif spellId == 233983 then
		--timerEchoingAnguishCD:Start()
	elseif spellId == 233894 and self:AntiSpam(2, 2) then
		--timerSuffocatingDarkCD:Start()
	elseif spellId == 234015 then
		self.vb.burstCount = self.vb.burstCount + 1
		warnTormentingBurst:Show(self.vb.burstCount)
		--timerTormentingBurstCD:Start()
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
		--timerFelSquallCD:Start()--When changed to real timer, move to SPELL_AURA_REMOVED event
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
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233441 then--Bone Saw
		timerBoneSaw:Stop()
		timerBoneSawCD:Start()
	elseif spellId == 233983 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
