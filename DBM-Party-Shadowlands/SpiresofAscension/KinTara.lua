local mod	= DBM:NewMod(2399, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162059, 163077, 163061)--162059 Kin-Tara, 163077 Azules, 163061 Janari
mod:SetEncounterID(2357)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 320965 317667",
	"SPELL_CAST_START 320866 317665 317661",
--	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE 317626",
	"SPELL_PERIODIC_MISSED 317626",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, does fight need all 3 to die, or just Kin-Tara?
--TODO, change special warning for sweeping strike to fire few seconds before (based on timer/scheduling) when timer is known
--TODO, Flight detection
--TODO, verify/fix charged spear detection
--TODO, verify/fix crash down detection
--TODO, verify/fix savage charge
--TODO, https://shadowlands.wowhead.com/spell=324369/attenuated-barrage ?
--TODO, just review everything again when dungeon opens up, it's had some changes
--Kin-Tara
local warnDeepWound					= mod:NewTargetNoFilterAnnounce(320965, 4, nil, "Tank|Healer")
local warnChargedSpear				= mod:NewTargetNoFilterAnnounce(321009, 4)
local warnRavage					= mod:NewTargetNoFilterAnnounce(317667, 3, nil, "Healer")

--Kin-Tara
local specWarnSweepingStrike		= mod:NewSpecialWarningSoak(320866, "Tank", nil, nil, 1, 2)
local specWarnChargedSpear			= mod:NewSpecialWarningMoveAway(321009, nil, nil, nil, 1, 2)
local yellChargedSpear				= mod:NewYell(321009)
local specWarnChargedSpearNear		= mod:NewSpecialWarningClose(321009, nil, nil, nil, 1, 2)
local specWarnCrashDown				= mod:NewSpecialWarningSoakPos(321035, nil, nil, nil, 2, 2)
local yellCrashDown					= mod:NewYell(321035)
--Janari
local specWarnSavageCharge			= mod:NewSpecialWarningYou(317665, nil, nil, nil, 1, 2)
local yellSavageCharge				= mod:NewYell(317665)
--Azules
local specWarnGTFO					= mod:NewSpecialWarningGTFO(317626, nil, nil, nil, 1, 8)
--local specWarnInsidiousVenom		= mod:NewSpecialWarningInterrupt(317661, "HasInterrupt", nil, nil, 1, 2)

--Kin-Tara
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21637))
local timerSweepingStrikeCD			= mod:NewAITimer(13, 320866, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFlightCD					= mod:NewAITimer(13, 313606, nil, nil, nil, 6)
local timerChargedSpearCD			= mod:NewAITimer(15.8, 321009, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
--Janari removed?
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(21638))
local timerSavageChargeCD			= mod:NewAITimer(15.8, 317665, nil, nil, nil, 3)--Removed?
--Azules
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21639))
local timerInsidiousVenomCD			= mod:NewAITimer(15.8, 317661, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)

mod:AddSetIconOption("SetIconOnCrashDown", 321035, true, false, {1})

function mod:ChargeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSavageCharge:Show()
		specWarnSavageCharge:Play("targetyou")
		yellSavageCharge:Yell()
	end
	DBM:AddMsg("ChargeTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

function mod:OnCombatStart(delay)
	--Kin-Tara
	timerSweepingStrikeCD:Start(1-delay)
	timerFlightCD:Start(1-delay)
	timerChargedSpearCD:Start(1-delay)--TODO, Move to flight event
	--Janari?
	timerSavageChargeCD:Start(1-delay)
	--Azules
	timerInsidiousVenomCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320866 then
		specWarnSweepingStrike:Show()--Will be moved to fire earlier with timers
		specWarnSweepingStrike:Play("gathershare")
		timerSweepingStrikeCD:Start()
	elseif spellId == 317665 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "ChargeTarget", 0.1, 6)
	elseif spellId == 317661 then
		timerInsidiousVenomCD:Start()
--		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
--			specWarnInsidiousVenom:Show(args.sourceName)
--			specWarnInsidiousVenom:Play("kickcast")
--		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320965 then
		warnDeepWound:Show(args.destName)
	elseif spellId == 317667 then
		warnRavage:CombinedShow(0.3, args.destName)
	end
end

--Total guesswork, but I neither have any debuff ID
--the entire premise of these mechanics is to actually know who it's on, so they have to have emotes
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, targetname)
	if msg:find("spell:321009") then
		timerChargedSpearCD:Start()
		if targetname == UnitName("player") then
			specWarnChargedSpear:Show()
			specWarnChargedSpear:Play("runout")
			yellChargedSpear:Yell()
		elseif self:CheckNearby(5, targetname) then
			specWarnChargedSpearNear:Show(targetname)
			specWarnChargedSpearNear:Play("runaway")
		else
			warnChargedSpear:Show(targetname)
		end
	elseif msg:find("spell:321035") then
		specWarnCrashDown:Show(targetname or "UNKNOWN")
		if targetname then
			if targetname == UnitName("player") then
				yellCrashDown:Yell()
			end
			if self.Options.SetIconOnCrashDown then
				self:SetIcon(targetname, 1, 5)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 317626 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 163077 then--Azules
		timerInsidiousVenomCD:Stop()
	elseif cid == 163061 then--Janari?
		timerSavageChargeCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 313606 then--Total guesswork
		timerFlightCD:Start()
	end
end
