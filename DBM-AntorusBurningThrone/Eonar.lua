local mod	= DBM:NewMod(2025, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(124445)
mod:SetEncounterID(2075)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 249121 250701 250048",
	"SPELL_CAST_SUCCESS 246888 246896 246753 254769",
	"SPELL_AURA_APPLIED 248333 250074 250555",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 248333 250074 250555",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
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
--The Paraxis
local warnMeteorStorm					= mod:NewEndAnnounce(248333, 1)
--local warnSpearofDoom					= mod:NewTargetAnnounce(248789, 3)
local warnWarpIn						= mod:NewCountAnnounce(246888, 3)
local warnLifeForce						= mod:NewCountAnnounce(250048, 1)

--The Paraxis
local specWarnMeteorStorm				= mod:NewSpecialWarningDodge(248333, nil, nil, nil, 2, 2)
local specWarnSpearofDoom				= mod:NewSpecialWarningDodge(248789, nil, nil, nil, 2, 2)
--local yellSpearofDoom					= mod:NewYell(248789)
local specWarnRainofFel					= mod:NewSpecialWarningCount(248332, nil, nil, nil, 1, 2)
--Adds
local specWarnSwing						= mod:NewSpecialWarningDefensive(250701, "Tank", nil, nil, 1, 2)
--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--The Paraxis
local timerWarpInCD						= mod:NewCDTimer(30, 246888, nil, nil, nil, 1)
local timerMeteorStormCD				= mod:NewAITimer(61, 248333, nil, nil, nil, 3)
local timerSpearofDoomCD				= mod:NewAITimer(61, 248789, nil, nil, nil, 3)
local timerRainofFelCD					= mod:NewCDTimer(61, 248332, nil, nil, nil, 3)
local timerFinalDoom					= mod:NewCastTimer(70, 249121, nil, nil, nil, 2)
--Mythic
local timerFinalDoomCD					= mod:NewAITimer(61, 249121, nil, nil, nil, 4, nil, DBM_CORE_HEROIC_ICON)
--local timerFelclawsCD					= mod:NewAITimer(25, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--The Paraxis
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--The Paraxis
local voiceMeteorStorm					= mod:NewVoice(248333)--watchstep
local voiceSpearofDoom					= mod:NewVoice(248789)--watchstep
local voiceRainofFel					= mod:NewVoice(248332)--scatter
--Adds
local voiceSwing						= mod:NewVoice(250701)--shockwave/defensive?
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

--mod:AddSetIconOption("SetIconOnSpearofDoom", 248789, true)
mod:AddInfoFrameOption(250030, true)
mod:AddNamePlateOption("NPAuraOnPurification", 250074)
mod:AddNamePlateOption("NPAuraOnFelShielding", 250555)
mod:AddRangeFrameOption("8")

mod.vb.rainOfFelCount = 0
mod.vb.warpCount = 0
mod.vb.lifeForceCast = 0
local normalWarpTimers = {5.1, 16.0}
local heroicWarpTimers = {5.3, 10.0, 23.9, 20.7, 24.0, 19.0}--Sequence timer, but stll altered by Life Force?
local normalRainOfFelTimers = {21.1, 24.1, 23.9, 24.1, 24.0, 96.0, 12.0, 36.0, 12.0, 36.0}
local heroicRainOfFelTimers = {15.0, 24.1, 8.9, 24.2, 11.9, 19.0, 12.1}

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
		--Boss Powers first
		if UnitExists("boss1") then
			local currentPower = UnitPower("boss1") or 0
			addLine(UnitName("boss1"), currentPower)
		end
		--Probably some "active adds" count type stuff second
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.rainOfFelCount = 0
	self.vb.warpCount = 0
	self.vb.lifeForceCast = 0
	timerWarpInCD:Start(5.1)
	timerSpearofDoomCD:Start(1-delay)
	if not self:IsLFR() then
		timerRainofFelCD:Start(15-delay)
		if self:IsMythic() then
			timerFinalDoomCD:Start(1-delay)
		end
	else
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
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249121 then
		timerFinalDoom:Start()
		timerFinalDoomCD:Start()--Move to stop event or power event if cleaner
	elseif spellId == 250701 then
		specWarnSwing:Show()
		voiceSwing:Play("shockwave")
	elseif spellId == 250048 then
		self.vb.lifeForceCast = self.vb.lifeForceCast + 1
		warnLifeForce:Show(self.vb.lifeForceCast)
		if self:IsEasy() then
			--local warpElapsed, warpTotal = timerWarpInCD:GetTime()
			local felElapsed, felTotal = timerRainofFelCD:GetTime()
			--timerWarpInCD:Update(warpElapsed, warpTotal+24)
			timerRainofFelCD:Update(felElapsed, felTotal+24)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 246888 or spellId == 246896) and self:AntiSpam(6, 1) then--At east 5 second antispam needed, maybe more
		self.vb.warpCount = self.vb.warpCount + 1
		warnWarpIn:Show(self.vb.warpCount)
		local timer = self:IsHeroic() and heroicWarpTimers[self.vb.warpCount+1] or self:IsEasy() and (normalWarpTimers[self.vb.warpCount+1] or 23.7)--(always 24ish on normal)
		if timer then
			timerWarpInCD:Start(timer)
		end
	elseif spellId == 246753 then--Cloak
	
	elseif spellId == 254769 then--High Alert
		
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248333 then
		specWarnMeteorStorm:Show()
		voiceMeteorStorm:Play("watchstep")
		timerMeteorStormCD:Start()
	elseif spellId == 250074 then--Purification
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
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
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:248861") then
		specWarnSpearofDoom:Show()
		voiceSpearofDoom:Play("watchstep")
		timerSpearofDoomCD:Start()
	end
end

--[[
--http://ptr.wowhead.com/npc=123726/fel-powered-purifier
--http://ptr.wowhead.com/npc=123760/fel-infused-destructor
--http://ptr.wowhead.com/npc=124207/fel-charged-obfuscator
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 248332 then--Rain of Fel
		self.vb.rainOfFelCount = self.vb.rainOfFelCount + 1
		specWarnRainofFel:Show(self.vb.rainOfFelCount)
		voiceRainofFel:Play("scatter")
		local timer = self:IsHeroic() and heroicRainOfFelTimers[self.vb.rainOfFelCount+1] or self:IsNormal() and normalRainOfFelTimers[self.vb.rainOfFelCount+1]
		if timer then
			timerRainofFelCD:Start(timer)
		end
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, _, spellId)
	if spellId == 249121 then
		timerFinalDoom:Stop()
	end
end
mod.UNIT_SPELLCAST_STOP = mod.UNIT_SPELLCAST_CHANNEL_STOP
