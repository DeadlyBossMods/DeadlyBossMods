local mod	= DBM:NewMod(1984, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(121975)
mod:SetEncounterID(2063)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(16964)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244693 245458 245463 245301 255058 255061 255059",
	"SPELL_AURA_APPLIED 245990 245994 244894 244903 247091 254452",
	"SPELL_AURA_APPLIED_DOSE 245990",
	"SPELL_AURA_REMOVED 244894 244903 247091 254452",
--	"SPELL_PERIODIC_DAMAGE 247135",
--	"SPELL_PERIODIC_MISSED 247135",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Verify stack count for Tank debuff, if boss swing timer slowre, can swap lower stack. Seems mostly inconsiquencial anyways since you plan swaps around foes, not this
--TODO, meteor swarm for intermission, right now it has no clear cast ID, 4 different script IDs and 0 debuff IDs
--TODO, if ember energy gains are detectable with ease, use hostile nameplates to show power circle over them all fancy like
--TODO, like fallen avatar in lat PTR, flare has two entirely different mechanics between journal and spellId toolipss, so it needs reviewing at testing.
--TODO, empowered flare has same issue as flare. Figure out all the shit
--[[
(ability.id = 244693 or ability.id = 245458 or ability.id = 245463 or ability.id = 245301 or ability.id = 255058 or ability.id = 255061 or ability.id = 255059) and type = "begincast"
 or ability.id = 244894 and (type = "applybuff" or type = "removebuff")
 or (ability.id = 245994 or ability.id = 254452) and type = "applydebuff"
--]]
--Stage One: Wrath of Aggramar
local warnTaeshalachReach				= mod:NewStackAnnounce(245990, 2, nil, "Tank")
local warnScorchingBlaze				= mod:NewTargetAnnounce(245994, 2)
local warnRavenousBlaze					= mod:NewTargetAnnounce(254452, 2)
local warnRavenousBlazeCount			= mod:NewCountAnnounce(254452, 4)
local warnTaeshalachTech				= mod:NewCountAnnounce(244688, 3)
--Stage Two: Stuff
local warnPhase2						= mod:NewPhaseAnnounce(2, 2)
--Stage Three: More stuff
local warnPhase3						= mod:NewPhaseAnnounce(3, 2)

--Stage One: Wrath of Aggramar
local specWarnTaeshalachReach			= mod:NewSpecialWarningStack(245990, nil, 8, nil, nil, 1, 6)
local specWarnTaeshalachReachOther		= mod:NewSpecialWarningTaunt(245990, nil, nil, nil, 1, 2)
local specWarnScorchingBlaze			= mod:NewSpecialWarningMoveAway(245994, nil, nil, nil, 1, 2)
local yellScorchingBlaze				= mod:NewYell(245994)
local specWarnRavenousBlaze				= mod:NewSpecialWarningMoveAway(254452, nil, nil, nil, 1, 2)
local yellRavenousBlaze					= mod:NewYell(254452, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local specWarnWakeofFlame				= mod:NewSpecialWarningDodge(244693, nil, nil, nil, 2, 2)
local yellWakeofFlame					= mod:NewYell(244693)
--local specWarnFoeBreaker				= mod:NewSpecialWarningDodge(245458, nil, nil, nil, 3, 2)
local specWarnFoeBreakerTaunt			= mod:NewSpecialWarningTaunt(245458, nil, nil, nil, 3, 2)
local specWarnFoeBreakerDefensive		= mod:NewSpecialWarningDefensive(245458, nil, nil, nil, 3, 2)
local specWarnFlameRend					= mod:NewSpecialWarningCount(245463, nil, nil, nil, 1, 2)
local specWarnSearingTempest			= mod:NewSpecialWarningRun(245301, nil, nil, nil, 4, 2)
--Intermission
--local specWarnMeteorSwarm				= mod:NewSpecialWarningDodge(245920, nil, nil, nil, 1, 2)
--Stage Two: Champion of Sargeras
local specWarnFlare						= mod:NewSpecialWarningDodge(245983, nil, nil, nil, 2, 2)

--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(247135, nil, nil, nil, 1, 2)

--Stage One: Wrath of Aggramar
local timerTaeshalachTechCD				= mod:NewNextCountTimer(61, 244688, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFoeBreakerCD					= mod:NewNextCountTimer(6.1, 245458, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFlameRendCD					= mod:NewNextCountTimer(6.1, 245463, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerTempestCD					= mod:NewNextTimer(6.1, 245301, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerScorchingBlazeCD				= mod:NewCDTimer(6.5, 245994, nil, nil, nil, 3)--6.5-8
local timerRavenousBlazeCD				= mod:NewCDTimer(23.2, 254452, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerWakeofFlameCD				= mod:NewCDTimer(24.3, 244693, nil, nil, nil, 3)
--Stage Two: Champion of Sargeras
local timerFlareCD						= mod:NewCDTimer(15, 245983, nil, nil, nil, 3)

local berserkTimer						= mod:NewBerserkTimer(600)

--Stages One: Wrath of Aggramar
local countdownTaeshalachTech			= mod:NewCountdown(61, 244688)
local countdownWakeofFlame				= mod:NewCountdown("AltTwo24", 244693, "-Tank")

--Stage One: Wrath of Aggramar
local voicePhaseChange					= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceTaeshalachReach				= mod:NewVoice(245990)--tauntboss/stackhigh
local voiceScorchingBlaze				= mod:NewVoice(245994)--scatter
local voiceRavenousBlaze				= mod:NewVoice(254452)--scatter
local voiceWakeofFlame					= mod:NewVoice(244693)--watchwave
local voiceFoeBreaker					= mod:NewVoice(245458)--shockwave/tauntboss/defensive
local voiceFlameRend					= mod:NewVoice(245463)--gathershare/shareone/sharetwo
local voiceSearingTempest				= mod:NewVoice(245301)--watchstep
--Stage Two: Champion of Sargeras
local voiceFlare						= mod:NewVoice(245983)--watchstep
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO							= mod:NewVoice(247135, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

mod:AddSetIconOption("SetIconOnBlaze2", 254452, false)--Both off by default, both conflit with one another
mod:AddSetIconOption("SetIconOnAdds", 244903, false, true)--Both off by default, both conflit with one another
mod:AddInfoFrameOption(244688, true)
mod:AddRangeFrameOption("6")
mod:AddNamePlateOption("NPAuraOnPresence", 244903)

mod.vb.phase = 1
mod.vb.techCount = 0
mod.vb.foeCount = 0
mod.vb.rendCount = 0
mod.vb.wakeOfFlameCount = 0
mod.vb.blazeIcon = 1
mod.vb.techActive = false
mod.vb.firstCombo = nil
mod.vb.secondCombo = nil
mod.vb.comboCount = 0

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		if mod:IsMythic() then
			if mod.vb.comboCount == 1 and mod.vb.firstCombo then
				if mod.vb.firstCombo == "Foe" then--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend or L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON..L.Rend.."/"..DBM_CORE_DEADLY_ICON..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON..L.Rend.."/"..DBM_CORE_DEADLY_ICON..L.Tempest)
				elseif mod.vb.firstCombo == "Rend" then----L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend or L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe.."/"..DBM_CORE_DEADLY_ICON..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON..L.Foe.."/"..DBM_CORE_DEADLY_ICON..L.Tempest)
				end
				addLine(mod.vb.comboCount+3, DBM_CORE_TANK_ICON..L.Foe.."(2)/"..DBM_CORE_DEADLY_ICON..L.Tempest)
				addLine(mod.vb.comboCount+4, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
			elseif mod.vb.comboCount == 2 and mod.vb.secondCombo then
					if mod.vb.secondCombo == "Tempest" then
				if mod.vb.firstCombo == "Foe" then--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend
						addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON..L.Rend)
					elseif mod.vb.firstCombo == "Rend" then--L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend
						addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe)
					end
					--Same in both combos
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON..L.Foe.."(2)")
				elseif mod.vb.secondCombo == "Foe" then--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON..L.Tempest)
				elseif mod.vb.secondCombo == "Rend" then--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON..L.Foe.."(2)")
				end
				--Rend always last
				addLine(mod.vb.comboCount+3, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
			elseif mod.vb.comboCount == 3 and mod.vb.secondCombo then
				if mod.vb.secondCombo == "Tempest" then
					--Same in both combos
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				elseif mod.vb.secondCombo == "Foe" then--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				elseif mod.vb.secondCombo == "Rend" then--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				end
			elseif mod.vb.comboCount == 4 then
				--rend always last
				addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
			else
				DBM.InfoFrame:Hide()
			end
		else--Not Mythic
			if mod.vb.comboCount == 1 then
				addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON..L.Rend)
				addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON..L.Foe.."(2)")
				addLine(mod.vb.comboCount+3, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				addLine(mod.vb.comboCount+4, DBM_CORE_DEADLY_ICON..L.Tempest)
			elseif mod.vb.comboCount == 2 then
				addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON..L.Foe.."(2)")
				addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				addLine(mod.vb.comboCount+3, DBM_CORE_DEADLY_ICON..L.Tempest)
			elseif mod.vb.comboCount == 3 then
				addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON..L.Rend.."(2)")
				addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON..L.Tempest)
			elseif mod.vb.comboCount == 4 then
				addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON..L.Tempest)
			else
				DBM.InfoFrame:Hide()
			end
		end
		return lines, sortedLines
	end
end

function mod:WakeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellWakeofFlame:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.techCount = 0
	self.vb.foeCount = 0
	self.vb.rendCount = 0
	self.vb.wakeOfFlameCount = 0
	self.vb.blazeIcon = 1
	self.vb.techActive = false
	if self:IsMythic() then
		timerRavenousBlazeCD:Start(4.4-delay)
		timerWakeofFlameCD:Start(10.7-delay)--Health based?
		countdownWakeofFlame:Start(10.7-delay)
		timerTaeshalachTechCD:Start(14.3-delay, 1)--Health based?
		countdownTaeshalachTech:Start(14.3-delay)
		berserkTimer:Start(540-delay)
	else
		timerScorchingBlazeCD:Start(4.8-delay)
		timerWakeofFlameCD:Start(5.9-delay)
		countdownWakeofFlame:Start(5.9-delay)
		timerTaeshalachTechCD:Start(35-delay, 1)
		countdownTaeshalachTech:Start(35-delay)
	end
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
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244693 and self:AntiSpam(4, 1) then--Antispam because boss recasts itif target dies while casting
		self.vb.wakeOfFlameCount = self.vb.wakeOfFlameCount + 1
		specWarnWakeofFlame:Show()
		voiceWakeofFlame:Play("watchwave")
		local techTimer = timerTaeshalachTechCD:GetRemaining(self.vb.techCount+1)
		if techTimer == 0 or techTimer > 24 then
			timerWakeofFlameCD:Start()
			countdownWakeofFlame:Start(24.3)
		end
		self:BossTargetScanner(args.sourceGUID, "WakeTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 245458 or spellId == 255059 then
		if self:IsMythic() then
			self.vb.comboCount = self.vb.comboCount + 1
			if not self.vb.firstCombo then
				self.vb.firstCombo = "Foe"
			elseif not self.vb.secondCombo then
				self.vb.secondCombo = "Foe"
			end
		end
		self.vb.foeCount = self.vb.foeCount + 1
		if self:IsTank() then
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then--Player is current target
				specWarnFoeBreakerDefensive:Show()
				--voiceFoeBreaker:Play("faceaway")
				voiceFoeBreaker:Play("defensive")
			elseif not UnitDebuff("player", args.spellName) and self.vb.foeCount == 2 then--Second cast and you didn't take first
				specWarnFoeBreakerTaunt:Show(BOSS)
				voiceFoeBreaker:Play("tauntboss")
			end
		end
		if self.vb.foeCount == 1 and not self:IsMythic() then
			if self:IsEasy() then
				timerFoeBreakerCD:Start(10, 2)
			else
				timerFoeBreakerCD:Start(7.5, 2)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 245463 or spellId == 255058 then
		if self:IsMythic() then
			self.vb.comboCount = self.vb.comboCount + 1
			if not self.vb.firstCombo then
				self.vb.firstCombo = "Rend"
			elseif not self.vb.secondCombo then
				self.vb.secondCombo = "Rend"
			end
		end
		self.vb.rendCount = self.vb.rendCount + 1
		specWarnFlameRend:Show(self.vb.rendCount)
		if spellId == 255058 then--Empowered/Mythic Version
			if self.vb.rendCount == 1 then
				voiceFlameRend:Play("shareone")
			else
				voiceFlameRend:Play("sharetwo")
			end
		else
			voiceFlameRend:Play("gathershare")
		end
		if self.vb.rendCount == 1 and not self:IsMythic() then
			if self:IsEasy() then
				timerFlameRendCD:Start(10, 2)
			else
				timerFlameRendCD:Start(7.5, 2)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 245301 or spellId == 255061 then
		if self:IsMythic() then
			self.vb.comboCount = self.vb.comboCount + 1
			if not self.vb.secondCombo then
				self.vb.secondCombo = "Tempest"
			end
		end
		specWarnSearingTempest:Show()
		voiceSearingTempest:Play("runout")
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236378 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 245990 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 8 and self:AntiSpam(3, 2) then--Lasts 12 seconds, asuming 1.5sec swing timer makes 8 stack swap
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
				if amount % 4 == 0 then
					warnTaeshalachReach:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 245994 then
		warnScorchingBlaze:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnScorchingBlaze:Show()
			voiceScorchingBlaze:Play("scatter")
			yellScorchingBlaze:Yell()
		end
	elseif spellId == 254452 then
		warnRavenousBlaze:CombinedShow(0.3, args.destName)
		local icon = self.vb.blazeIcon
		if args:IsPlayer() then
			specWarnRavenousBlaze:Show(self:IconNumToTexture(icon))
			voiceRavenousBlaze:Play("scatter")
			yellRavenousBlaze:Yell(icon, args.spellName, icon)
			warnRavenousBlazeCount:Schedule(2, 5)
			warnRavenousBlazeCount:Schedule(4, 10)
			warnRavenousBlazeCount:Schedule(6, 15)
			warnRavenousBlazeCount:Schedule(8, 20)
		end
		if self.Options.SetIconOnBlaze2 then
			self:SetIcon(args.destName, icon)
		end
		self.vb.blazeIcon = self.vb.blazeIcon + 1
	elseif spellId == 244894 then--Corrupt Aegis
		voicePhaseChange:Play("phasechange")
		self.vb.wakeOfFlameCount = 0
		self.vb.techActive = false
		timerScorchingBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		timerFlareCD:Stop()
		countdownWakeofFlame:Cancel()
		timerTaeshalachTechCD:Stop()
		countdownTaeshalachTech:Cancel()
		timerFoeBreakerCD:Stop()
		timerFlameRendCD:Stop()
		timerTempestCD:Stop()
		if self.Options.SetIconOnAdds then
			self:ScheduleMethod(2, "ScanForMobs", 122532, 1, 1, 5, 0.1, 12, "SetIconOnAdds", nil, nil, true)
		end
	if self.Options.RangeFrame and not self:IsTank() then
		DBM.RangeCheck:Hide()
	end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
--	elseif spellId == 245923 then--Debuff version of flare
--		warnFlare:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244894 then--Corrupt Aegis
		self.vb.phase = self.vb.phase + 1
		self.vb.wakeOfFlameCount = 0
		--timerScorchingBlazeCD:Start(3)--Unknown
		timerTaeshalachTechCD:Start(37, self.vb.techCount+1)
		countdownTaeshalachTech:Start(37)
		if self:IsMythic() then
			timerRavenousBlazeCD:Start(23)
		else
			timerScorchingBlazeCD:Start(5.9)
		end
		if self.vb.phase == 2 then
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
			timerFlareCD:Start(10)
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
			timerFlareCD:Start(10)
		end
		if self.Options.RangeFrame and not self:IsTank() then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 254452 then
		if args:IsPlayer() then
			warnRavenousBlazeCount:Cancel()
		end
		if self.Options.SetIconOnBlaze2 then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 247135 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

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
	elseif spellId == 254451 then--Ravenous Blaze (mythic replacement for Scorching Blaze)
		self.vb.blazeIcon = 1
		timerRavenousBlazeCD:Start()--Unknown at this time
	elseif spellId == 244688 then--Taeshalach Technique
		self.vb.comboCount = 0
		self.vb.firstCombo = nil
		self.vb.secondCombo = nil
		self.vb.techActive = true
		self.vb.foeCount = 0
		self.vb.rendCount = 0
		self.vb.techCount = self.vb.techCount + 1
		timerScorchingBlazeCD:Stop()
		timerRavenousBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		timerFlareCD:Stop()
		countdownWakeofFlame:Cancel()
		warnTaeshalachTech:Show(self.vb.techCount)
		timerTaeshalachTechCD:Start(nil, self.vb.techCount+1)
		countdownTaeshalachTech:Start()
		if self:IsMythic() then
			--Nothing special!
		else
			--Set sequence
			--Foebreaker instantly so no need for timer
			if self:IsEasy() then
				timerFlameRendCD:Start(5, 1)
				timerTempestCD:Start(20)
			else
				timerFlameRendCD:Start(4, 1)
				timerTempestCD:Start(15)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(244688))
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false, true)
		end
	elseif spellId == 244792 and self.vb.techActive then--Burning Will of Taeshalach (technique ended)
		self.vb.techActive = false
		if self:IsMythic() then
			timerRavenousBlazeCD:Start(4.2)
		else
			timerScorchingBlazeCD:Start(4.2)
		end
		if self.vb.phase == 1 then
			if self:IsMythic() then
				timerWakeofFlameCD:Start(10.3)
				countdownWakeofFlame:Start(10.3)
			else
				timerWakeofFlameCD:Start(7)
				countdownWakeofFlame:Start(7)
			end
		elseif self.vb.phase == 2 then
			timerFlareCD:Start(8.6)--Might be wrong here
		else--Stage 3
			timerFlareCD:Start(10)--Might be wrong here
		end
	elseif spellId == 245983 or spellId == 246037 then--Flare
		specWarnFlare:Show()
		voiceFlare:Play("watchstep")
		timerFlareCD:Start()
	end
end
