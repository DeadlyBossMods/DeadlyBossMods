local mod	= DBM:NewMod(1987, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(122477, 122135)--122477 F'harg, 122135 Shatug
mod:SetEncounterID(2074)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244057 244056",
	"SPELL_CAST_SUCCESS 244072 251445 245098 251356",
	"SPELL_AURA_APPLIED 244768 248815 244069 248819 244054 244055",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 244768 248815 244069 248819",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, work the breath warnings to special warnings i we can get a pre warning instead of a "happening NOW"
--TODO, figure out molten touch targetting ID, right now it's not safe to guess and might resultin spammy broken warnings so omitted
--TODO, rework enflamed Corruption/enflamed when more is understood how it works
--TODO, more work on siphon targetting, it too may need icons/assignments. Same with Enflamed
--TODO, update all timers on Focused power, probably pause them all for 15 seconds
--F'harg
local warnBurningMaw					= mod:NewSpellAnnounce(251445, 2, nil, "Tank")
local warnMoltenTouch					= mod:NewSpellAnnounce(244072, 2)
local warnDesolateGaze					= mod:NewTargetAnnounce(244768, 3)
local warnEnflamedCorruption			= mod:NewSpellAnnounce(244057, 3)
local warnEnflamed						= mod:NewTargetAnnounce(248815, 3)
--Shatug
local warnCorruptingMaw					= mod:NewSpellAnnounce(245098, 2, nil, "Tank")
local warnWeightofDarkness				= mod:NewTargetAnnounce(244069, 3)
local warnSiphonCorruption				= mod:NewSpellAnnounce(244056, 3)
local warnSiphoned						= mod:NewTargetAnnounce(248819, 3)
--General/Mythic
local warnFocusingPower					= mod:NewSpellAnnounce(251356, 2)

--F'harg
local specWarnDesolateGaze				= mod:NewSpecialWarningYou(244768, nil, nil, nil, 1, 2)
local yellDesolateGaze					= mod:NewYell(244768)
local specWarnEnflamed					= mod:NewSpecialWarningYou(248815, nil, nil, nil, 1, 2)
local yellEnflamed						= mod:NewYell(248815)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Shatug
local specWarnComsumingSphere			= mod:NewSpecialWarningDodge(244131, nil, nil, nil, 2, 2)
local specWarnWeightOfDarkness			= mod:NewSpecialWarningYou(244069, nil, nil, nil, 1, 2)
local yellWeightOfDarkness				= mod:NewPoSYell(244069, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local specWarnSiphoned					= mod:NewSpecialWarningYou(248819, nil, nil, nil, 1, 2)
local yellSiphoned						= mod:NewYell(248819)
--Mythic
local specWarnFlameTouched				= mod:NewSpecialWarningYou(244054, nil, nil, nil, 3, 8)
local specWarnShadowtouched				= mod:NewSpecialWarningYou(244055, nil, nil, nil, 3, 8)

--F'harg
local timerBurningMawCD					= mod:NewAITimer(25, 251445, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerMoltenTouchCD				= mod:NewAITimer(61, 244072, nil, nil, nil, 3)
local timerEnflamedCorruptionCD			= mod:NewAITimer(61, 244057, nil, nil, nil, 3)
--Shatug
local timerCorruptingMawCD				= mod:NewAITimer(25, 245098, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerComsumingSphereCD			= mod:NewAITimer(25, 244131, nil, nil, nil, 3)
local timerWeightOfDarknessCD			= mod:NewAITimer(25, 244069, nil, nil, nil, 3)
local timerSiphonCorruptionCD			= mod:NewAITimer(61, 244056, nil, nil, nil, 3)
--General/Mythic
local timerFocusingPower				= mod:NewCastTimer(15, 251356, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--F'harg
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--F'harg
local voiceDesolateGaze					= mod:NewVoice(244768)--runout?
local voiceEnflamed						= mod:NewVoice(248815)--scatter
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Shatug
local voiceConsumingSphere				= mod:NewVoice(244131)--watchorb
local voiceWeightOfDarkness				= mod:NewVoice(244069)--targetyou
local voiceSiphoned						= mod:NewVoice(248819)--gathershare?/killmob on mythic?
--Mythic
local voiceFlameTouched					= mod:NewVoice(244054)--flameonyou
local voiceShadowtouched				= mod:NewVoice(244055)--shadowonyou


mod:AddSetIconOption("SetIconOnWeightofDarkness", 244069, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("5/8")

mod.vb.WeightDarkIcon = 1

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
	self.vb.WeightDarkIcon = 1
	--Fire doggo
	timerBurningMawCD:Start(1-delay)
	timerMoltenTouchCD:Start(1-delay)
	timerEnflamedCorruptionCD:Start(1-delay)
	--Shadow doggo
	timerCorruptingMawCD:Start(1-delay)
	timerComsumingSphereCD:Start(1-delay)
	timerWeightOfDarknessCD:Start(1-delay)
	timerSiphonCorruptionCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)--Molten Touch (assumed)
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
	if spellId == 244057 then
		warnEnflamedCorruption:Show()
		timerEnflamedCorruptionCD:Start()
	elseif spellId == 244056 then
		warnSiphonCorruption:Show()
		timerSiphonCorruptionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244072 then--Molten Touch (probably wrong ID, but it's only one that has energy cost)
		warnMoltenTouch:Show()
		timerMoltenTouchCD:Start()
	elseif spellId == 251445 then
		warnBurningMaw:Show()
		timerBurningMawCD:Start()
	elseif spellId == 245098 then
		warnCorruptingMaw:Show()
		timerCorruptingMawCD:Start()
	elseif spellId == 251356 then
		warnFocusingPower:Show()
		timerFocusingPower:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244768 then
		if args:IsPlayer() then
			specWarnDesolateGaze:Show()
			voiceDesolateGaze:Play("runout")
			yellDesolateGaze:Yell()
		else
			warnDesolateGaze:Show(args.destName)
		end
	elseif spellId == 248815 then--Enflamed
		warnEnflamed:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEnflamed:Show()
			voiceEnflamed:Play("scatter")
			yellEnflamed:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 248819 then--Siphoned
		warnSiphoned:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSiphoned:Show()
			voiceSiphoned:Play("gathershare")
			yellSiphoned:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 244069 then
		if self:AntiSpam(5, 1) then
			self.vb.WeightDarkIcon = 1
			timerWeightOfDarknessCD:Start()
		end
		warnWeightofDarkness:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWeightOfDarkness:Show()
			voiceWeightOfDarkness:Play("targetyou")
			yellWeightOfDarkness:Yell(self.vb.WeightDarkIcon, args.spellName, self.vb.WeightDarkIcon)
		end
		if self.Options.SetIconOnWeightofDarkness then
			self:SetIcon(args.destName, self.vb.WeightDarkIcon)
		end
		self.vb.WeightDarkIcon = self.vb.WeightDarkIcon + 1
	elseif spellId == 244054 then--Flametouched
		if args:IsPlayer() then
			specWarnFlameTouched:Show()
			voiceFlameTouched:Play("flameonyou")
		end
	elseif spellId == 244055 then--Shadowtouched
		if args:IsPlayer() then
			specWarnShadowtouched:Show()
			voiceShadowtouched:Play("flameonyou")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 248815 then--Enflamed
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 248819 then--Siphoned
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 244069 then
		if self.Options.SetIconOnWeightofDarkness then
			self:SetIcon(args.destName, 0)
		end
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
	if spellId == 244159 then--Consuming Sphere
		specWarnComsumingSphere:Show()
		voiceConsumingSphere:Play("watchorb")
		timerComsumingSphereCD:Start()
	end
end
