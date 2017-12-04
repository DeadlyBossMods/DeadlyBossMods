local mod	= DBM:NewMod(2025, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124445)
mod:SetEncounterID(2075)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 249121 250701 250048",
	"SPELL_CAST_SUCCESS 246753 254769",
	"SPELL_AURA_APPLIED 248333 250074 250555 249016 249017 249014 249015 248332 250073",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 248333 250074 250555 249016 249017 249014 249015 248332",
--	"SPELL_DAMAGE 248329",
--	"SPELL_MISSED 248329",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_STOP boss1 boss2 boss3 boss4 boss5"
)

--TODO, verify Meteor Storm in LFR
--TODO, verify interrupt for Final Doom
--TODO, scan for cloak & High Alert to directly announce those adds?
--TODO, add rest of mythic stuff
--TODO, adds more reliable and specific waves timers
--TODO, rework range frame if more debuffs become detectable and activate updaterangeFinder function
--TODO, rework warp in timers to include cloak and high alert for waves that don't fire warp in, if blizzard doesn't fix the warpin events
--[[
(ability.id = 249121 or ability.id = 250048) and type = "begincast"
 or (ability.id = 246753 or ability.id = 254769) and type = "cast"
 or (ability.id = 248332) and type = "applydebuff"
 or (ability.id = 250073) and type = "applybuff"
--]]
--The Paraxis
local warnMeteorStorm					= mod:NewEndAnnounce(248333, 1)
--local warnSpearofDoom					= mod:NewTargetAnnounce(248789, 3)
local warnRainofFel						= mod:NewTargetCountAnnounce(248332, 2)
local warnWarpIn						= mod:NewTargetAnnounce(246888, 3)
local warnLifeForce						= mod:NewCountAnnounce(250048, 1)

--The Paraxis
local specWarnMeteorStorm				= mod:NewSpecialWarningDodge(248333, nil, nil, nil, 2, 2)
local specWarnSpearofDoom				= mod:NewSpecialWarningDodge(248789, nil, nil, nil, 2, 2)
--local yellSpearofDoom					= mod:NewYell(248789)
local specWarnRainofFel					= mod:NewSpecialWarningMoveAway(248332, nil, nil, nil, 1, 2)
local yellRainofFel						= mod:NewYell(248332)
local yellRainofFelFades				= mod:NewShortFadesYell(248332)
--Adds
local specWarnSwing						= mod:NewSpecialWarningDefensive(250701, "Tank", nil, nil, 1, 2)
--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--The Paraxis
local timerMeteorStormCD				= mod:NewAITimer(61, 248333, nil, nil, nil, 3)
local timerSpearofDoomCD				= mod:NewCDCountTimer(55, 248789, nil, nil, nil, 3)--55-69
local timerRainofFelCD					= mod:NewCDCountTimer(61, 248332, nil, nil, nil, 3)
local timerFinalDoom					= mod:NewCastTimer(50, 249121, nil, nil, nil, 2)
local timerDestructorCD					= mod:NewCDCountTimer(90, "ej16501", nil, nil, nil, 1, 254769)
local timerObfuscatorCD					= mod:NewCDCountTimer(90, "ej16502", nil, nil, nil, 1, 246753)
local timerPurifierCD					= mod:NewCDCountTimer(90, "ej16500", nil, nil, nil, 1)
--Mythic
local timerFinalDoomCD					= mod:NewCDCountTimer(90, 249121, nil, nil, nil, 4, nil, DBM_CORE_HEROIC_ICON)
--local timerFelclawsCD					= mod:NewAITimer(25, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--The Paraxis
--local countdownRainofFel				= mod:NewCountdown("Alt60", 248332)--Not accurate enough yet. not until timer correction is added to handle speed of raids dps affecting sequence
--Mythic
local countdownFinalDoom				= mod:NewCountdown("AltTwo90", 249121)

--The Paraxis
local voiceMeteorStorm					= mod:NewVoice(248333)--watchstep
local voiceSpearofDoom					= mod:NewVoice(248789)--watchstep
local voiceRainofFel					= mod:NewVoice(248332)--scatter
--Adds
local voiceSwing						= mod:NewVoice(250701)--defensive
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

mod:AddSetIconOption("SetIconOnFeedbackTargeted", 249016, true)
mod:AddSetIconOption("SetIconOnFeedbackArcane", 249017, true)
mod:AddSetIconOption("SetIconOnFeedbackFoul", 249014, false)
mod:AddSetIconOption("SetIconOnFeedbackBurning", 249015, true)
mod:AddInfoFrameOption(250030, true)
mod:AddNamePlateOption("NPAuraOnPurification", 250074)
mod:AddNamePlateOption("NPAuraOnFelShielding", 250555)
mod:AddRangeFrameOption("8/10")

mod.vb.rainOfFelCount = 0
mod.vb.lifeForceCast = 0
mod.vb.lifeRequired = 5
mod.vb.spearCast = 0
mod.vb.finalDoomCast = 0
mod.vb.destructors = 0
mod.vb.obfuscators = 0
mod.vb.purifiers = 0
--Timers combine multi sets,counts above do not combine cause for info frame
mod.vb.destructorCast = 0
mod.vb.obfuscatorCast = 0
mod.vb.purifierCast = 0
--local normalWarpTimers = {5.1, 16.0}
--local heroicWarpTimers = {5.3, 10.0, 23.9, 20.7, 24.0, 19.0}
--local mythicWarpTimers = {5.3, 9.8, 35.3, 44.8, 34.9}--Excludes the waves that don't fire warp in (obfuscators and purifiers)
local normalRainOfFelTimers = {}--PTR, recheck
local heroicRainOfFelTimers = {9.3, 44, 10, 43, 35, 19, 20, 30, 45, 35, 99}--Live, Nov 29
local mythicRainOfFelTimers = {}--PTR, recheck
--local mythicSpearofDoomTimers = {}
local heroicSpearofDoomTimers = {35, 59.2, 64.3, 40, 85.6, 34.1, 65.2}--Live, Nov 29
local finalDoomTimers = {60, 125, 100}--PTR, recheck
local normalDestructors = {17, 39.4, 28, 44.2, 92.4, 41.3, 50, 53.4, 48.1}
local heroicDestructors = {15.7, 35.3, 40.6, 104.6, 134.7, 99.6}
local normalObfuscators = {174}
local heroicObfuscators = {81.8, 149.2, 94.7, 99.9}
local heroicPurifiers = {125, 66.1, 30.6}
local warnedAdds = {}
local addCountToLocationMythic = {
	["Dest"] = {DBM_CORE_MIDDLE},
	["Obfu"] = {},
	["Pur"] = {}
}
local addCountToLocationHeroic = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP},
	["Obfu"] = {DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM},
	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE}
}
local addCountToLocationNormal = {
	["Dest"] = {DBM_CORE_MIDDLE},
	["Obfu"] = {}
}
--[[
Old Data from PTR
Mythic Adds
destructor 22, 96.3, 40, 
Obfuscator: 39.8, 157.9
Obfuscator: 81.8, 149.2, 94.7, 99.9
LFR Adds
destructor: 17, 48.3, 41.4, 65.3, 43.13, 23.4, 50, 43.4
--]]

local updateInfoFrame
do
	local lifeForceName = GetSpellInfo(250048)
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
		--Boss Powers first
		if UnitExists("boss1") then
			local currentPower = UnitPower("boss1", 10) or 0
			addLine(UnitName("boss1"), currentPower)
		end
		addLine(lifeForceName, mod.vb.lifeForceCast.."/"..mod.vb.lifeRequired)
		if mod.vb.obfuscators > 0 then
			addLine(L.Obfuscators, mod.vb.obfuscators)
		end
		if mod.vb.destructors > 0 then
			addLine(L.Destructors, mod.vb.destructors)
		end
		if mod.vb.purifiers > 0 then
			addLine(L.Purifiers, mod.vb.purifiers)
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.rainOfFelCount = 0
	self.vb.destructors = 0
	self.vb.obfuscators = 0
	self.vb.purifiers = 0
	self.vb.destructorCast = 0
	self.vb.obfuscatorCast = 0
	self.vb.purifierCast = 0
	self.vb.lifeForceCast = 0
	self.vb.spearCast = 0
	self.vb.finalDoomCast = 0
	--timerWarpInCD:Start(5.1, 1)
	--countdownWarpIn:Start(5.1)
	if not self:IsLFR() then
		if self:IsMythic() then
			self.vb.lifeRequired = 5
			--timerRainofFelCD:Start(6-delay, 1)
			--countdownRainofFel:Start(6-delay)
			--timerSpearofDoomCD:Start(35-delay, 1)
			timerFinalDoomCD:Start(60-delay, 1)
			countdownFinalDoom:Start(60-delay)
		elseif self:IsHeroic() then
			self.vb.lifeRequired = 4
			timerRainofFelCD:Start(9.3-delay, 1)
			--countdownRainofFel:Start(9.3-delay)
			timerDestructorCD:Start(8, DBM_CORE_MIDDLE)
			timerSpearofDoomCD:Start(34.4-delay, 1)
			timerObfuscatorCD:Start(81.8, DBM_CORE_TOP)
			timerPurifierCD:Start(125, 1)
		else--Normal
			self.vb.lifeRequired = 4
			timerDestructorCD:Start(8, DBM_CORE_MIDDLE)
			timerObfuscatorCD:Start(174, 1)
			--timerRainofFelCD:Start(30-delay, 1)
			--countdownRainofFel:Start(30-delay)
		end
	else
		self.vb.lifeRequired = 3
		timerMeteorStormCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(250030))
		--DBM.InfoFrame:Show(2, "enemypower", 2)
		DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	table.wipe(warnedAdds)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self:IsMythic() then
		DBM:AddMsg(DBM_CORE_NEED_LOGS)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249121 then
		self.vb.finalDoomCast = self.vb.finalDoomCast + 1
		timerFinalDoom:Start()
		local timer = finalDoomTimers[self.vb.finalDoomCast+1]
		if timer then
			timerFinalDoomCD:Start(timer, self.vb.finalDoomCast+1)
			countdownFinalDoom:Start(timer)
		end
	elseif spellId == 250701 then
		specWarnSwing:Show()
		voiceSwing:Play("defensive")
	elseif spellId == 250048 then
		self.vb.lifeForceCast = self.vb.lifeForceCast + 1
		warnLifeForce:Show(self.vb.lifeForceCast)
--[[		if self:IsEasy() then
			local felElapsed, felTotal = timerRainofFelCD:GetTime(self.vb.rainOfFelCount+1)
			local felRemaining = felTotal - felElapsed
			--timerWarpInCD:Update(warpElapsed, warpTotal+24)
			countdownRainofFel:Cancel()
			timerRainofFelCD:Update(felElapsed, felTotal+24, self.vb.rainOfFelCount+1)
			countdownRainofFel:Start(felRemaining+24)
		end--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246753 and not warnedAdds[args.sourceGUID] then--Cloak
		warnedAdds[args.sourceGUID] = true
		self.vb.obfuscators = self.vb.obfuscators + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(args.sourceName)
			self.vb.obfuscatorCast = self.vb.obfuscatorCast + 1
			local timer = self:IsHeroic() and heroicObfuscators[self.vb.obfuscatorCast+1] or self:IsNormal() and normalObfuscators[self.vb.obfuscatorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Obfu"][self.vb.obfuscatorCast+1] or self:IsNormal() and addCountToLocationNormal["Obfu"][self.vb.obfuscatorCast+1] or self:IsMythic() and addCountToLocationMythic["Obfu"][self.vb.obfuscatorCast+1] or self.vb.obfuscatorCast+1
				timerObfuscatorCD:Start(timer, text)
			end
		end
	elseif spellId == 254769 and args:GetSrcCreatureID() == 123760 and not warnedAdds[args.sourceGUID] then--High Alert
		warnedAdds[args.sourceGUID] = true
		self.vb.destructors = self.vb.destructors + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(args.sourceName)
			self.vb.destructorCast = self.vb.destructorCast + 1
			local timer = self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
				timerDestructorCD:Start(timer-9, text)--High alert fires about 9 seconds after spawn so using it as a trigger has a -9 adjustment
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248333 then
		specWarnMeteorStorm:Show()
		voiceMeteorStorm:Play("watchstep")
		timerMeteorStormCD:Start()
	elseif spellId == 250073 and not warnedAdds[args.sourceGUID] then--Purification (buff on purifier)
		warnedAdds[args.sourceGUID] = true
		self.vb.purifiers = self.vb.purifiers + 1
		if self:AntiSpam(5, 2) then
			warnWarpIn:Show(args.sourceName)
			self.vb.purifierCast = self.vb.purifierCast + 1
			local timer = self:IsHeroic() and heroicPurifiers[self.vb.purifierCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Pur"][self.vb.purifierCast+1] or self:IsNormal() and addCountToLocationNormal["Pur"][self.vb.purifierCast+1] or self:IsMythic() and addCountToLocationMythic["Pur"][self.vb.purifierCast+1] or self.vb.purifierCast+1
				timerPurifierCD:Start(timer, text)
			end
		end
	elseif spellId == 250074 then--Purification (buff on enemies near purifier)
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted then
			self:SetIcon(args.destName, 1)--Yellow Star for focused
		end
	elseif spellId == 249017 then
		if self.Options.SetIconOnFeedbackArcane then
			self:SetIcon(args.destName, 3)--Purple diamond for arcane
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 249014 then
		if self.Options.SetIconOnFeedbackFoul then
			self:SetIcon(args.destName, 4)--Green triangle for foul
		end
	elseif spellId == 249015 then
		if self.Options.SetIconOnFeedbackBurning then
			self:SetIcon(args.destName, 2)--Orange circle for fire
		end
	elseif spellId == 248332 then--Rain of Fel
		warnRainofFel:CombinedShow(1, self.vb.rainOfFelCount, args.destName)
		if self:AntiSpam(5, 4) then
			self.vb.rainOfFelCount = self.vb.rainOfFelCount + 1
			local timer = self:IsMythic() and mythicRainOfFelTimers[self.vb.rainOfFelCount+1] or self:IsHeroic() and heroicRainOfFelTimers[self.vb.rainOfFelCount+1] or self:IsNormal() and normalRainOfFelTimers[self.vb.rainOfFelCount+1]
			if timer then
				timerRainofFelCD:Start(timer, self.vb.rainOfFelCount+1)
				--countdownRainofFel:Start(timer)
			end
		end
		if args:IsPlayer() then
			specWarnRainofFel:Show()
			voiceRainofFel:Play("scatter")
			yellRainofFel:Yell()
			yellRainofFelFades:Countdown(5)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 248333 then
		warnMeteorStorm:Show()
	elseif spellId == 250074 then--Purification
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 249017 then
		if self.Options.SetIconOnFeedbackArcane then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 249014 then
		if self.Options.SetIconOnFeedbackFoul then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 249015 then
		if self.Options.SetIconOnFeedbackBurning then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 248332 then--Rain of Fel
		if args:IsPlayer() then
			yellRainofFelFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124207 and self.vb.obfuscators > 0 then--Fel-Charged Obfuscator
		self.vb.obfuscators = self.vb.obfuscators - 1
	elseif cid == 123760 and self.vb.destructors > 0 then--Fel-Infused Destructor
		self.vb.destructors = self.vb.destructors - 1
	elseif cid == 123726 and self.vb.purifiers > 0 then--Fel-Infused Purifier
		self.vb.purifiers = self.vb.purifiers - 1
	end
end

--[[
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:248861") or msg:find("spell:248789") then
		specWarnSpearofDoom:Show()
		voiceSpearofDoom:Play("runout")
		yellSpearofDoom:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:248861") or msg:find("spell:248789") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			local icon = self.vb.bladesIcon
			warnSpearofDoom:CombinedShow(0.5, targetName)
			if self.Options.SetIconOnSpearofDoom then
				--self:SetIcon(targetName, icon, 5)
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 248329 and self:AntiSpam(5, 4) then

	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:248861") then
		self.vb.spearCast = self.vb.spearCast + 1
		specWarnSpearofDoom:Show()
		voiceSpearofDoom:Play("watchstep")
		local timer = self:IsHeroic() and heroicSpearofDoomTimers[self.vb.spearCast+1]
		if timer then
			timerSpearofDoomCD:Start(timer, self.vb.spearCast+1)
		end
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, _, spellId)
	if spellId == 249121 then
		timerFinalDoom:Stop()
	end
end
mod.UNIT_SPELLCAST_STOP = mod.UNIT_SPELLCAST_CHANNEL_STOP
