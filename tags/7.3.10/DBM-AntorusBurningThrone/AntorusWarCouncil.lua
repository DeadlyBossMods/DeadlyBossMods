local mod	= DBM:NewMod(1997, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122369, 122333, 122367)--Chief Engineer Ishkar, General Erodus, Admiral Svirax
mod:SetEncounterID(2070)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(7, 8)
mod:SetHotfixNoticeRev(16744)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244625 246505 253040 245227 244821",
	"SPELL_CAST_SUCCESS 245292 244722 244892 245227 253037 245174",
	"SPELL_SUMMON 245174",
	"SPELL_AURA_APPLIED 244737 244892 253015",
	"SPELL_AURA_APPLIED_DOSE 244892",
	"SPELL_AURA_REMOVED 244737 253015",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, Shock Grenade doesn't existin combat log? or maybe doesn't exist at all on heroic?
--TODO, Figure out mine spawns which aren't in combat log either, but DO exist
--TODO, figure out warp field which wasn't in combat log at all
--TODO, figure out how to detect/announce correct versions of withering Fire
--TODO, track players pods and those casts?
--TODO, boss health was reporting unknown in streams, verify/fix boss CIDs
--[[
(ability.id = 244625 or ability.id = 253040 or ability.id = 245227 or ability.id = 125012 or ability.id = 125014 or ability.id = 126258 or ability.id = 244821) and type = "begincast"
 or (ability.id = 245292 or ability.id = 244722 or ability.id = 244892) and type = "cast" or (ability.id = 245174 or ability.id = 244947) and type = "summon"
 or ability.id = 253015
--]]
--General
local warnInPod							= mod:NewTargetAnnounce("ej16099", 2, 244141)
local warnOutofPod						= mod:NewTargetAnnounce("ej16098", 2, 244141)
local warnExploitWeakness				= mod:NewStackAnnounce(244892, 2, nil, "Tank")
local warnPsychicAssault				= mod:NewTargetAnnounce(244172, 4)
--In Pod
----Admiral Svirax
--local warnWitheringFire				= mod:NewSpellAnnounce(245292, 2)
----Chief Engineer Ishkar
local warnEntropicMine					= mod:NewSpellAnnounce(245161, 2)
----General Erodus
local warnSummonReinforcements			= mod:NewSpellAnnounce(245546, 2, nil, false, 2)
local warnDemonicCharge					= mod:NewTargetAnnounce(253040, 2, nil, false, 2)
--Out of Pod
----Admiral Svirax
local warnShockGrenade					= mod:NewTargetAnnounce(244737, 3)
----Chief Engineer Ishkar

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnExploitWeakness			= mod:NewSpecialWarningTaunt(244892, nil, nil, nil, 1, 2)
local specWarnPsychicAssault			= mod:NewSpecialWarningYou(244172, nil, nil, nil, 3, 2)
--In Pod
----Admiral Svirax
local specWarnFusillade					= mod:NewSpecialWarningMoveTo(244625, nil, nil, nil, 1, 2)
----Chief Engineer Ishkar
--local specWarnEntropicMine				= mod:NewSpecialWarningDodge(245161, nil, nil, nil, 1, 2)
----General Erodus
local specWarnSummonReinforcements		= mod:NewSpecialWarningSwitch(245546, nil, nil, nil, 1, 2)
-------Adds
local specWarnPyroblast					= mod:NewSpecialWarningInterrupt(246505, "HasInterrupt", nil, nil, 1, 2)
local specWarnDemonicChargeYou			= mod:NewSpecialWarningYou(253040, nil, nil, nil, 1, 2)
local specWarnDemonicCharge				= mod:NewSpecialWarningClose(253040, nil, nil, nil, 1, 2)
local yellDemonicCharge					= mod:NewYell(253040)
--Out of Pod
----Admiral Svirax
local specWarnShockGrenade				= mod:NewSpecialWarningMoveAway(253040, nil, nil, nil, 1, 2)
local yellShockGrenade					= mod:NewShortYell(244737)
local yellShockGrenadeFades				= mod:NewFadesYell(244737)
----Chief Engineer Ishkar
local specWarnWarpField					= mod:NewSpecialWarningRun(244821, nil, nil, nil, 4, 2)
----General Erodus

--General
local timerExploitWeaknessCD			= mod:NewCDTimer(8.5, 244892, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerShockGrenadeCD				= mod:NewCDTimer(14.7, 244722, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerAssumeCommandCD				= mod:NewNextTimer(90, 245227, nil, nil, nil, 6)
--In Pod
----Admiral Svirax
local timerFusilladeCD					= mod:NewCDCountTimer(29.6, 244625, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--local timerWitheringFireCD			= mod:NewAITimer(61, 245292, nil, nil, nil, 3)
----Chief Engineer Ishkar
local timerEntropicMineCD				= mod:NewCDTimer(10, 245161, nil, nil, nil, 3)
----General Erodus
local timerSummonReinforcementsCD		= mod:NewCDTimer(8.4, 245546, nil, nil, nil, 1)
--local timerPyroblastCD				= mod:NewAITimer(61, 246505, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Out of Pod
----Admiral Svirax
----Chief Engineer Ishkar
local timerWarpFieldCD					= mod:NewAITimer(61, 244821, nil, nil, nil, 2)
----General Erodus

--local berserkTimer					= mod:NewBerserkTimer(600)

--General
local countdownAssumeCommand			= mod:NewCountdown("Alt50", 245227)
local countdownExploitWeakness			= mod:NewCountdown("Alt8", 244892, "Tank", nil, 3)
--In Pod
----Admiral Svirax
local countdownFusillade				= mod:NewCountdown("AltTwo30", 244625)
----General Erodus
local countdownReinforcements			= mod:NewCountdown(25, 245546)

--General
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
local voicePsychicAssault				= mod:NewVoice(244172)--otherout ("player out")
local voiceExploitWeakness				= mod:NewVoice(244892)--Tauntboss
--In Pod
----Admiral Svirax
local voiceFusillade					= mod:NewVoice(244625)--findshelter
----Chief Engineer Ishkar
local voiceEntropicMine					= mod:NewVoice(245161)--watchstep
----General Erodus
local voiceSummonReinforcements			= mod:NewVoice(245546)--killmob
local voicePyroblast					= mod:NewVoice(246505, "HasInterrupt")--kickcast
local voiceDemonicCharge				= mod:NewVoice(253040)--watchstep/runaway
--Out of Pod
----Admiral Svirax
local voiceShockGrenade					= mod:NewVoice(244722)--runout
----Chief Engineer Ishkar
local voiceWarpField					= mod:NewVoice(244821)--justrun/keepmove?
----General Erodus


--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
mod:AddSetIconOption("SetIconOnAdds", 245546, true, true)
--mod:AddInfoFrameOption(244910, true)
mod:AddRangeFrameOption("8")

local felShield = GetSpellInfo(244910)
mod.vb.FusilladeCount = 0
mod.vb.lastIcon = 8

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

function mod:DemonicChargeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDemonicChargeYou:Show()
		voiceDemonicCharge:Play("runaway")
		yellDemonicCharge:Yell()
	elseif self:CheckNearby(10, targetname) and self:AntiSpam(3, 2) then
		specWarnDemonicCharge:Show(targetname)
		voiceDemonicCharge:Play("watchstep")
	else
		warnDemonicCharge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.FusilladeCount = 0
	self.vb.lastIcon = 8
	--In pod
	timerEntropicMineCD:Start(5.1-delay)
	--Out of Pod
	timerSummonReinforcementsCD:Start(8-delay)
	countdownReinforcements:Start(8-delay)
	timerAssumeCommandCD:Start(90-delay)
	countdownAssumeCommand:Start(90-delay)
	if self:IsMythic() then
		timerShockGrenadeCD:Start(15)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244625 then
		self.vb.FusilladeCount = self.vb.FusilladeCount + 1
		specWarnFusillade:Show(felShield)
		voiceFusillade:Play("findshelter")
		timerFusilladeCD:Start(nil, self.vb.FusilladeCount+1)
		if not self:IsLFR() then
			countdownFusillade:Start(29.6)
		end
	elseif spellId == 246505 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnPyroblast:Show(args.sourceName)
			voicePyroblast:Play("kickcast")
		end
	elseif spellId == 253040 then
		self:BossTargetScanner(args.sourceGUID, "DemonicChargeTarget", 0.2, 9)
	elseif spellId == 245227 then--Assume Command (entering pod)
		timerShockGrenadeCD:Stop()
		timerExploitWeaknessCD:Stop()
		countdownExploitWeakness:Cancel()
		timerExploitWeaknessCD:Start(12)--12-14
		countdownExploitWeakness:Start(12)
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 122369 then--Chief Engineer Ishkar
			timerWarpFieldCD:Stop()
			timerEntropicMineCD:Start(8)
			timerFusilladeCD:Stop()--Seems this timer resets too
			countdownFusillade:Cancel()
			timerFusilladeCD:Start(15.9, 1)--Start Updated Fusillade
			countdownFusillade:Start(15.9)
			--TODO, reinforcements fix
		elseif cid == 122333 then--General Erodus
			timerSummonReinforcementsCD:Stop()--Stops fodder ones
			timerSummonReinforcementsCD:Start(11)--Starts elite ones
			countdownReinforcements:Start(11)
		elseif cid == 122367 then--Admiral Svirax
			self.vb.FusilladeCount = 0
			timerFusilladeCD:Start(15, 1)
			countdownFusillade:Start(15)
			timerSummonReinforcementsCD:Stop()--Seems this timer resets too
			countdownReinforcements:Cancel()
			timerSummonReinforcementsCD:Start(16)--Start updated reinforcements timer
			countdownReinforcements:Start(16)
			--timerWitheringFireCD:Start(2)
		end
		if self:IsMythic() then
			timerShockGrenadeCD:Start(9.7)
		end
	elseif spellId == 244821 then
		specWarnWarpField:Show()
		voiceWarpField:Play("justrun")
		--voiceWarpField:Schedule(1, "keepmove")
		timerWarpFieldCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245292 then
		--warnWitheringFire:Show()
		--timerWitheringFireCD:Start()
	elseif spellId == 244722 then
		timerShockGrenadeCD:Start()--21
	elseif spellId == 244892 then
		timerExploitWeaknessCD:Start()
		countdownExploitWeakness:Start(8.5)
	elseif spellId == 245227 then--Assume Command
		warnInPod:Show(args.sourceName)
		timerAssumeCommandCD:Start(90)
		countdownAssumeCommand:Start(90)
	elseif spellId == 253037 then
		if args:IsPlayer() then
			specWarnDemonicChargeYou:Show()
			voiceDemonicCharge:Play("runaway")
			yellDemonicCharge:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnDemonicCharge:Show(args.destName)
			voiceDemonicCharge:Play("watchstep")
		else
			warnDemonicCharge:Show(args.destName)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 245174 then--Minor adds
		warnSummonReinforcements:Show()
		timerSummonReinforcementsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244737 then
		warnShockGrenade:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShockGrenade:Show()
			voiceShockGrenade:Play("runout")
			yellShockGrenade:Yell()
			yellShockGrenadeFades:Countdown(5)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 244892 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 8) then
					specWarnExploitWeakness:Show(args.destName)
					voiceExploitWeakness:Play("tauntboss")
				else
					warnExploitWeakness:Show(args.destName, amount)
				end
			else
				warnExploitWeakness:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244737 then
		if args:IsPlayer() then
			yellShockGrenadeFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	--elseif spellId == 253015 then--Commanders Presence
		--warnInPod:Show(args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("244172") then
		specWarnPsychicAssault:Show()
		voicePsychicAssault:Play("otherout")
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("244172") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			warnPsychicAssault:Show(targetName)
		end
	end
end

--"<14.68 23:07:26> [UNIT_SPELLCAST_SUCCEEDED] General Erodus(??) [[boss3:Summon Reinforcements::3-2083-1712-2166-245546-00015E79FE:245546]]", -- [121]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 245161 or spellId == 245304) and self:AntiSpam(5, 1) then
		warnEntropicMine:Show()
		voiceEntropicMine:Play("watchstep")
		timerEntropicMineCD:Start()
	elseif spellId == 245785 then--Pod Spawn Transition Cosmetic Missile
		local name = UnitName(uId)
		local GUID = UnitGUID(uId)
		warnOutofPod:Show(name)
		local cid = self:GetCIDFromGUID(GUID)
		if cid == 122369 then--Chief Engineer Ishkar
			timerEntropicMineCD:Stop()
			timerWarpFieldCD:Start(2)
		elseif cid == 122333 then--General Erodus
			timerSummonReinforcementsCD:Stop()--Elite ones
			countdownReinforcements:Cancel()
			if not self:IsEasy() then
				timerSummonReinforcementsCD:Start(9)--Fodder ones
			end
		elseif cid == 122367 then--Admiral Svirax
			timerFusilladeCD:Stop()
			countdownFusillade:Cancel()
			--timerWitheringFireCD:Stop()
		end
	elseif spellId == 245546 then--Summon Reinforcements (major adds)
		specWarnSummonReinforcements:Show()
		voiceSummonReinforcements:Play("killmob")
		timerSummonReinforcementsCD:Start(35)
		countdownReinforcements:Start(35)
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(122890, 0, self.vb.lastIcon, 1, 0.1, 12, "SetIconOnAdds")
		end
		if self.vb.lastIcon == 8 then
			self.vb.lastIcon = 7
		else
			self.vb.lastIcon = 8
		end
	end
end
