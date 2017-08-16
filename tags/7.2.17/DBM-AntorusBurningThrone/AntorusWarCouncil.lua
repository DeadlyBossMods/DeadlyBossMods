local mod	= DBM:NewMod(1997, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(125012, 125014, 126258)--Chief Engineer Ishkar, General Erodus, Admiral Svirax
mod:SetEncounterID(2070)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244625 246505 253040 245227 244821",
	"SPELL_CAST_SUCCESS 245292 244722 244892 245227 253037",
	"SPELL_SUMMON 245174",
	"SPELL_AURA_APPLIED 244737 244892 253015",
	"SPELL_AURA_APPLIED_DOSE 244892",
	"SPELL_AURA_REMOVED 244737 253015",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
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
 or (ability.id = 245292 or ability.id = 244722 or ability.id = 244892) and type = "cast"
 or ability.id = 245174 and type = "summon" or ability.id = 253015
--]]
--General
local warnInPod							= mod:NewTargetAnnounce("ej16099", 2)
local warnOutofPod						= mod:NewTargetAnnounce("ej16098", 2)
local warnSunderingClaws				= mod:NewStackAnnounce(244892, 2, nil, "Tank")
--In Pod
----Admiral Svirax
--local warnWitheringFire				= mod:NewSpellAnnounce(245292, 2)
----Chief Engineer Ishkar
----General Erodus
local warnDemonicCharge					= mod:NewTargetAnnounce(253040, 2, nil, false, 2)
--Out of Pod
----Admiral Svirax
local warnShockGrenade					= mod:NewTargetAnnounce(244737, 3)
----Chief Engineer Ishkar

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnSunderingClaws			= mod:NewSpecialWarningTaunt(244892, nil, nil, nil, 1, 2)
--In Pod
----Admiral Svirax
local specWarnFusillade					= mod:NewSpecialWarningMoveTo(244625, nil, nil, nil, 1, 2)
----Chief Engineer Ishkar
local specWarnEntropicMine				= mod:NewSpecialWarningDodge(245161, nil, nil, nil, 1, 2)
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
local timerSunderingClawsCD				= mod:NewCDTimer(8.5, 244892, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerAssumeCommandCD				= mod:NewNextTimer(90, 245227, nil, nil, nil, 6)
--In Pod
----Admiral Svirax
local timerFusilladeCD					= mod:NewCDTimer(29.6, 244625, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--local timerWitheringFireCD				= mod:NewAITimer(61, 245292, nil, nil, nil, 3)
----Chief Engineer Ishkar
local timerEntropicMineCD				= mod:NewAITimer(61, 245161, nil, nil, nil, 3)
----General Erodus
local timerSummonReinforcementsCD		= mod:NewCDTimer(25, 245546, nil, nil, nil, 1)
--local timerPyroblastCD					= mod:NewAITimer(61, 246505, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Out of Pod
----Admiral Svirax
local timerShockGrenadeCD				= mod:NewAITimer(61, 244722, nil, nil, nil, 3)
----Chief Engineer Ishkar
local timerWarpFieldCD					= mod:NewAITimer(61, 244821, nil, nil, nil, 2)
----General Erodus

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownSingularity			= mod:NewCountdown(50, 235059)

--General
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
local voiceSunderingClaws				= mod:NewVoice(244892)--Tauntboss
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
--mod:AddInfoFrameOption(244910, true)
mod:AddRangeFrameOption("8")

local felShield = GetSpellInfo(244910)

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
	elseif self:CheckNearby(10, targetname) then
		specWarnDemonicCharge:Show(targetname)
		voiceDemonicCharge:Play("watchstep")
	else
		warnDemonicCharge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	--In pod
	timerEntropicMineCD:Start(1)
	timerSummonReinforcementsCD:Start(8)
	--Out of Pod
	--timerShockGrenadeCD:Start(1)
	timerAssumeCommandCD:Start(90-delay)
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
		specWarnFusillade:Show(felShield)
		voiceFusillade:Play("findshelter")
		timerFusilladeCD:Start()
	elseif spellId == 246505 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnPyroblast:Show(args.sourceName)
			voicePyroblast:Play("kickcast")
		end
	elseif spellId == 253040 then
		self:BossTargetScanner(args.sourceGUID, "DemonicChargeTarget", 0.2, 9)
	elseif spellId == 245227 then--Assume Command (entering pod)
		timerSunderingClawsCD:Stop()
		timerSunderingClawsCD:Start(13)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 125012 then--Chief Engineer Ishkar
			timerWarpFieldCD:Stop()
			timerEntropicMineCD:Start(2)
		elseif cid == 125014 then--General Erodus
			timerSunderingClawsCD:Stop()
			--timerSummonReinforcementsCD:Start(2)
		elseif cid == 126258 then--Admiral Svirax
			timerShockGrenadeCD:Stop()
			timerFusilladeCD:Start(18)
			--timerWitheringFireCD:Start(2)
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
		timerShockGrenadeCD:Start()
	elseif spellId == 244892 then
		timerSunderingClawsCD:Start()
	elseif spellId == 245227 then--Assume Command
		timerAssumeCommandCD:Start(90)
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
	if spellId == 245174 then
		specWarnSummonReinforcements:Show()
		voiceSummonReinforcements:Play("killmob")
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
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnSunderingClaws:Show(args.destName)
					voiceSunderingClaws:Play("tauntboss")
				else
					warnSunderingClaws:Show(args.destName, amount)
				end
			else
				warnSunderingClaws:Show(args.destName, amount)
			end
		end
	elseif spellId == 253015 then--Commander's Presence
		warnOutofPod:Show(args.destName)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 125012 then--Chief Engineer Ishkar
			timerEntropicMineCD:Stop()
			timerWarpFieldCD:Start(2)
		elseif cid == 125014 then--General Erodus
			timerSummonReinforcementsCD:Stop()
		elseif cid == 126258 then--Admiral Svirax
			timerFusilladeCD:Stop()
			--timerWitheringFireCD:Stop()
			timerShockGrenadeCD:Start(2)
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
	elseif spellId == 253015 then--Commanders Presence
		warnInPod:Show(args.destName)
--[[		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 125012 then--Chief Engineer Ishkar
			timerWarpFieldCD:Stop()
			timerEntropicMineCD:Start(2)
		elseif cid == 125014 then--General Erodus
			timerSunderingClawsCD:Stop()
			timerSummonReinforcementsCD:Start(2)
		elseif cid == 126258 then--Admiral Svirax
			timerShockGrenadeCD:Stop()
			timerFusilladeCD:Start(15)
			--timerWitheringFireCD:Start(2)
		end--]]
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 245161 and self:AntiSpam(2, 1) then
		specWarnEntropicMine:Show()
		voiceEntropicMine:Play("watchstep")
		timerEntropicMineCD:Start()
	end
end
