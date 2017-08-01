local mod	= DBM:NewMod(1984, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(124691)
mod:SetEncounterID(2063)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244693 245458 245463 245301",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 245990 245994 244688 244894 244903 247091 245923",
	"SPELL_AURA_APPLIED_DOSE 245990",
	"SPELL_AURA_REMOVED 244688 244894 244903 247091",
	"SPELL_PERIODIC_DAMAGE 247135",
	"SPELL_PERIODIC_MISSED 247135",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Verify stack count for Tank debuff, if boss swing timer slowre, can swap lower stack.
--TODO, seeif melee safe from scorching Blaze.
--TODO, foe breaker, if tank doesn't have to soak it, just tell everyone to dodge. if tank does have to soak it, decide between taunt and defensive
--TODO, meteor swarm for intermission, right now it has no clear cast ID, 4 different script IDs and 0 debuff IDs
--TODO, if ember energy gains are detectable with ease, use hostile nameplates to show power circle over them all fancy like
--TODO, like fallen avatar in lat PTR, flare has two entirely different mechanics between journal and spellId toolipss, so it needs reviewing at testing.
--TODO, empowered flare has same issue as flare. Figure out all the shit
--Stage One: Wrath of Aggramar
local warnTaeshalachReach				= mod:NewStackAnnounce(245990, 2, nil, "Tank")
local warnScorchingBlaze				= mod:NewTargetAnnounce(245994, 2)
local warnTaeshalachTech				= mod:NewSpellAnnounce(244688, 3)
--Stage Two: Stuff
local warnPhase2						= mod:NewPhaseAnnounce(2, 2)
local warnFlare							= mod:NewTargetAnnounce(245923, 3)
--Stage Three: More stuff
local warnPhase3						= mod:NewPhaseAnnounce(3, 2)

--Stage One: Wrath of Aggramar
local specWarnTaeshalachReach			= mod:NewSpecialWarningStack(245990, nil, 8, nil, nil, 1, 2)
local specWarnTaeshalachReachOther		= mod:NewSpecialWarningTaunt(245990, nil, nil, nil, 1, 2)
local specWarnWakeofFlame				= mod:NewSpecialWarningDodge(244693, nil, nil, nil, 2, 2)
local specWarnFoeBreaker				= mod:NewSpecialWarningDodge(245458, nil, nil, nil, 3, 2)
local specWarnFoeBreakerTaunt			= mod:NewSpecialWarningTaunt(245458, nil, nil, nil, 3, 2)
local specWarnFoeBreakerDefensive		= mod:NewSpecialWarningDefensive(245458, nil, nil, nil, 3, 2)
local specWarnFlameRend					= mod:NewSpecialWarningCount(245463, nil, nil, nil, 1, 2)
local specWarnSearingTempest			= mod:NewSpecialWarningDodge(245301, nil, nil, nil, 1, 2)
--Intermission
--local specWarnMeteorSwarm				= mod:NewSpecialWarningDodge(245920, nil, nil, nil, 1, 2)
--Stage Two: Champion of Sargeras


--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
local specWarnGTFO						= mod:NewSpecialWarningGTFO(247135, nil, nil, nil, 1, 2)

--Stage One: Wrath of Aggramar
--local timerFelclawsCD					= mod:NewAITimer(25, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerScorchingBlazeCD				= mod:NewAITimer(61, 245994, nil, nil, nil, 3)
local timerWakeofFlameCD				= mod:NewAITimer(61, 244693, nil, nil, nil, 3)
--Stage Two: Champion of Sargeras
--local timerFlareCD						= mod:NewAITimer(61, 245923, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stages One: Wrath of Aggramar
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--Stage One: Wrath of Aggramar
local voiceTaeshalachReach				= mod:NewVoice(245990)--tauntboss/stackhigh
local voiceWakeofFlame					= mod:NewVoice(244693)--watchwave
local voiceFoeBreaker					= mod:NewVoice(245458)--shockwave/tauntboss/defensive
local voiceFlameRend					= mod:NewVoice(245463)--gathershare/shareone/sharetwo
local voiceSearingTempest				= mod:NewVoice(245301)--watchstep
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
local voiceGTFO							= mod:NewVoice(247135, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("6")
mod:AddNamePlateOption("NPAuraOnPresence", 244903)

mod.vb.phase = 1
mod.vb.foeCount = 0
mod.vb.rendCount = 0
mod.vb.setCount = 0
mod.vb.wakeOfFlameCount = 0

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

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.foeCount = 0
	self.vb.rendCount = 0
	self.vb.setCount = 1
	self.vb.wakeOfFlameCount = 0
	timerScorchingBlazeCD:Start(1-delay)
	timerWakeofFlameCD:Start(1-delay)
	--Everyone should lose spead except tanks which should stay stacked. Maybe melee are safe too?
	if self.Options.RangeFrame and not self:IsTank() then
		DBM.RangeCheck:Show(6)
	end
	if self.Options.NPAuraOnPresence then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnPresence then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244693 then
		self.vb.wakeOfFlameCount = self.vb.wakeOfFlameCount + 1
		specWarnWakeofFlame:Show()
		voiceWakeofFlame:Play("watchwave")
		timerWakeofFlameCD:Start()
	elseif spellId == 245458 then
		self.vb.foeCount = self.vb.foeCount + 1
		if (self.vb.foeCount + self.vb.rendCount) % 2 == 0 then
			self.vb.setCount = self.vb.setCount + 1
		end
		if self:IsTank() then
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then--Player is current target
				specWarnFoeBreakerDefensive:Show()
				--voiceFoeBreaker:Play("faceaway")
				voiceFoeBreaker:Play("defensive")
			elseif not UnitDebuff("player", args.spellName) then
				specWarnFoeBreakerTaunt:Show(BOSS)
				voiceFoeBreaker:Play("tauntboss")
			end
		else
			specWarnFoeBreaker:Show()
			voiceFoeBreaker:Play("shockwave")
		end
	elseif spellId == 245463 then
		self.vb.rendCount = self.vb.rendCount + 1
		if (self.vb.foeCount + self.vb.rendCount) % 2 == 0 then
			self.vb.setCount = self.vb.setCount + 1
		end
		specWarnFlameRend:Show(self.vb.rendCount)
		if self:IsMythic() then
			if self.vb.rendCount == 1 then
				voiceFlameRend:Play("shareone")
			else
				voiceFlameRend:Play("sharetwo")
			end
		else
			voiceFlameRend:Play("gathershare")
		end
	elseif spellId == 245301 then
		specWarnSearingTempest:Show()
		voiceSearingTempest:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236378 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 245990 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 8 then--Lasts 12 seconds, asuming 1.5sec swing timer makes 8 stack swap
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnTaeshalachReach:Show(amount)
					voiceTaeshalachReach:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnTaeshalachReachOther:Show(args.destName)
						voiceTaeshalachReach:Play("tauntboss")
					else
						warnTaeshalachReach:Show(args.destName, amount)
					end
				end
			else
				if amount >= 4 and amount % 2 == 0 then
					warnTaeshalachReach:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 245994 then
		warnScorchingBlaze:CombinedShow(0.3, args.destName)
	elseif spellId == 244688 then--Taeshalach Technique Begin
		self.vb.foeCount = 0
		self.vb.rendCount = 0
		self.vb.setCount = 1
		timerScorchingBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		warnTaeshalachTech:Show()
	elseif spellId == 244894 then--Corrupt Aegis
		self.vb.phase = self.vb.phase + 0.5
		self.vb.wakeOfFlameCount = 0
		timerScorchingBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		if self.vb.phase == 2.5 then
			timerWakeofFlameCD:Start(3)
		end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 245923 then--Debuff version of flare
		warnFlare:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244688 then--Taeshalach Technique End
		timerScorchingBlazeCD:Start(2)
		timerWakeofFlameCD:Start(2)
	elseif spellId == 244894 then--Corrupt Aegis
		self.vb.phase = self.vb.phase + 0.5
		self.vb.wakeOfFlameCount = 0
		timerScorchingBlazeCD:Start(3)
		if self.vb.phase == 2 then
			warnPhase2:Show()
			--timerFlareCD:Start(2)
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			timerWakeofFlameCD:Start(4)
			--timerFlareCD:Start(3)
		end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 247135 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

--http://ptr.wowhead.com/npc=121985/flame-of-taeshalach
--http://ptr.wowhead.com/npc=122532/ember-of-taeshalach
--http://ptr.wowhead.com/npc=123531/blazing-ember-of-taeshalach
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 245993 then--Scorching Blaze
		timerScorchingBlazeCD:Start()
	end
end
