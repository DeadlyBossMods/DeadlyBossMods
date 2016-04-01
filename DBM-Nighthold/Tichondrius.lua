local mod	= DBM:NewMod(1762, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103685)
mod:SetEncounterID(1862)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown carrions
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212997 213238 212794 208230 213531 206365 216034 216723",
	"SPELL_CAST_SUCCESS 212997 212794",
	"SPELL_AURA_APPLIED 206480 212794 208230 216040",
	"SPELL_AURA_APPLIED_DOSE 216024",
	"SPELL_AURA_REMOVED 206480 212794 216040",
	"SPELL_PERIODIC_DAMAGE 216027",
	"SPELL_PERIODIC_MISSED 216027"
)

--TODO, need final counts. Can possibly use icons for both if total is 8 or less
--TODO, possible hud options for brand of argus?
--TODO, more review on Feast of Blood
--TODO, voices similar to 184964a/b/c but for Brand of argus instead of torment. Or better. Maybe generic with no spell name just "break first" "break second" that works for similar spell in future
--TODO, figure out what to do with Carrion Nightmare (http://legion.wowhead.com/spell=215988/carrion-nightmare). if it's anything like garrosh phase. it's just a spammy shockwave. Add warning based on frequency of cast
--TODO, determine how often tanks swap for 216024 (Volatile Wound), if at all
--TODO, figure out ring of shadow
--TODO, phase detection stuff and better timers
local warnCarrionPlague				= mod:NewTargetAnnounce(206480, 3)
local warnBrandOfArgus				= mod:NewTargetAnnounce(212794, 4)
--Nightborne
local warnVolatileWound				= mod:NewStackAnnounce(216024, 3, nil, false, 2)
--The Legion
local warnBurningSoul				= mod:NewTargetAnnounce(216040, 4)
local warnRingOfShadow				= mod:NewSpellAnnounce(216723, 3)

local specWarnCarrionPlague			= mod:NewSpecialWarningMoveAway(206480, nil, nil, nil, 1, 2)
--local yellCarrionPlague			= mod:NewPosYell(206480, nil, false)
local specWarnSeekerSwarm			= mod:NewSpecialWarningSpell(213238, nil, nil, nil, 2, 5)
local yellSeekerSwarm				= mod:NewYell(213238)--Carrion plague targets yell again to remind raid where targets are.
--local specWarnBreakMark			= mod:NewSpecialWarning("specWarnBreakMark", nil, nil, nil, 1)
local yellBrandOfArgus				= mod:NewPosYell(212794, 156225)--"Branded" short text
local specWarnFeastOfBlood			= mod:NewSpecialWarningRun(208230, nil, nil, nil, 3, 2)--Move away, or run? neither one really says "get 30 yards from boss"
local specWarnFeastOfBloodOther		= mod:NewSpecialWarningTaunt(208230, nil, nil, nil, 3, 2)
--local yellCarrionPlague			= mod:NewPosYell(206480, nil, false)
local specWarnEchoesOfVoid			= mod:NewSpecialWarningDodge(213531, nil, nil, nil, 2, 2)
--Nightborne
local specWarnBlastNova				= mod:NewSpecialWarningInterrupt(216034, "HasInterrupt", nil, nil, 2, 2)
local specWarnNetherZoneGTFO		= mod:NewSpecialWarningMove(216027, nil, nil, nil, 2, 2)
--The Legion
local specWarnBurningSoul			= mod:NewSpecialWarningMoveAway(216040, nil, nil, nil, 1, 2)
local yellBurningSoul				= mod:NewYell(216040)

local timerCarrionPlagueCD			= mod:NewCDTimer(16, 212997, nil, nil, nil, 3)
local timerSeekerSwarmCD			= mod:NewCDTimer(16, 213238, nil, nil, nil, 3)
local timerBrandOfArgusCD			= mod:NewCDTimer(16, 212794, nil, nil, nil, 3)
local timerFeastOfBloodCD			= mod:NewCDTimer(16, 208230, nil, "Tank", nil, 5)
local timerEchoesOfVoidCD			= mod:NewCDTimer(16, 213531, nil, nil, nil, 2)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voiceCarrionPlague			= mod:NewVoice(206480)--scatter
local voiceSeekerSwarm				= mod:NewVoice(213238)--targetyou/158078(farawayfromline)
local voiceFeastOfBlood				= mod:NewVoice(208230)--runout/tauntboss
local voiceEchoesOfVoid				= mod:NewVoice(213531)--findshelter
--Nightborne
local voiceBlastNova				= mod:NewVoice(216034)--kickcast
local voiceNetherZone				= mod:NewVoice(216027)--runaway
--The Legion
local voiceBurningSoul				= mod:NewVoice(216040)--runout

mod:AddRangeFrameOption(8, 216040)
--mod:AddSetIconOption("SetIconOnCarrionPlague", 206480, false)
mod:AddSetIconOption("SetIconOnBrandOfArgus", 212794, true)
mod:AddInfoFrameOption(212794)
--mod:AddHudMapOption("HudMapOnMC", 163472)

local carrionTargets = {}
local argusTargets = {}
local carrionDebuff = GetSpellInfo(206480)
mod.vb.phase = 1

local updateInfoFrame, sortInfoFrame, breakMarks
do
	local argusDebuff = GetSpellInfo(212794)
	local playerName = UnitName("player")
	local lines = {}
	sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a < b then return true else return false end
	end
	updateInfoFrame = function()
		table.wipe(lines)
		local total = 0
		for i = 1, #argusTargets do
			local name = argusTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if uId and UnitDebuff(uId, argusDebuff) then
				total = total + 1
				lines[name] = i
			end
		end
		if total == 0 then--None found, hide infoframe because all broke
			DBM.InfoFrame:Hide()
		end
		return lines
	end
	breakMarks = function (self, spellName)
		table.sort(argusTargets)
		warnBrandOfArgus:Show(table.concat(argusTargets, "<, >"))
		for i = 1, #argusTargets do
			local name = argusTargets[i]
			if not name then break end
			if not DBM:GetRaidUnitId(name) then break end
			if name == playerName then
				yellBrandOfArgus:Yell(i, i, i)
				if i == 1 then
--					specWarnBreakMark:Show(L.First)
--					voiceBrandOfArgus:Play("184964a")
				elseif i == 2 then
--					specWarnBreakMark:Show(L.Second)
--					voiceBrandOfArgus:Play("184964b")
				elseif i == 3 then
--					specWarnBreakMark:Show(L.Third)
--					voiceBrandOfArgus:Play("184964c")
				end
			end
			if self.Options.SetIconOnBrandOfArgus then
				self:SetIcon(name, i)
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(argusDebuff)
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame, true)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	table.wipe(carrionTargets)
	table.wipe(argusTargets)
	timerCarrionPlagueCD:Start(1-delay)
	timerSeekerSwarmCD:Start(1-delay)
	timerBrandOfArgusCD:Start(1-delay)
	timerFeastOfBloodCD:Start(1-delay)
	timerEchoesOfVoidCD:Start(1-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212997 then
		table.wipe(carrionTargets)
	elseif spellId == 213238 then
		specWarnSeekerSwarm:Show()
		timerSeekerSwarmCD:Start()
		if UnitDebuff("player", carrionDebuff) then
			yellSeekerSwarm:Yell()
			voiceSeekerSwarm:Play("targetyou")
		else
			voiceSeekerSwarm:Play("158078")
		end
	elseif spellId == 212794 then
		table.wipe(argusTargets)
	elseif spellId == 208230 then
		timerFeastOfBloodCD:Start()
	elseif spellId == 213531 then
		specWarnEchoesOfVoid:Show()
		voiceEchoesOfVoid:Play("findshelter")
		timerEchoesOfVoidCD:Start()
	elseif spellId == 206365 then--Phase Change
		timerCarrionPlagueCD:Stop()
		timerSeekerSwarmCD:Stop()
		timerBrandOfArgusCD:Stop()
		timerFeastOfBloodCD:Stop()
		timerEchoesOfVoidCD:Stop()
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	elseif spellId == 216034 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBlastNova:Show(args.sourceName)
		voiceBlastNova:Play("kickcast")
	elseif spellId == 216723 then
		warnRingOfShadow:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 212997 then
		timerCarrionPlagueCD:Start()
	elseif spellId == 212794 then
		timerBrandOfArgusCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206480 then
		local name = args.destName
		if not tContains(carrionTargets, name) then
			carrionTargets[#carrionTargets+1] = name
		end
		local count = #carrionTargets
		warnCarrionPlague:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCarrionPlague:Show()
			voiceCarrionPlague:Play("scatter")
--			yellCarrionPlague:Yell(count, count, count)
		end
--		if self.Options.SetIconOnCarrionPlague then
--			self:SetIcon(name, count)
--		end
	elseif spellId == 212794 then
		argusTargets[#argusTargets+1] = args.destName
		self:Unschedule(breakMarks)
		if #argusTargets == 3 then
			breakMarks(self, args.spellName)
		else
			self:Schedule(0.5, breakMarks, self, args.spellName)
		end
	elseif spellId == 208230 then
		if args:IsPlayer() then
			specWarnFeastOfBlood:Show()
			voiceFeastOfBlood:Play("runout")
		else
			specWarnFeastOfBloodOther:Show(args.destName)
			voiceFeastOfBlood:Play("tauntboss")
		end
	elseif spellId == 216040 then
		if args:IsPlayer() then
			specWarnBurningSoul:Show()
			yellBurningSoul:Yell()
			voiceBurningSoul:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			warnBurningSoul:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 216024 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount > 6 then
			warnVolatileWound:Show(args.destName, amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206480 then
		if self.Options.SetIconOnCarrionPlague then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 212794 then
		if self.Options.SetIconOnBrandOfArgus then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 216040 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--Maybe INSTANCE_ENCOUNTER_ENGAGE_UNIT instead
function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if (cid == 103685) and UnitExists(uId) then--Tichondrius Returning
		DBM:Debug("UNIT_TARGETABLE_CHANGED, Tichondrius returning", 2)
		timerCarrionPlagueCD:Start(2)
		timerSeekerSwarmCD:Start(2)
		timerBrandOfArgusCD:Start(2)
		timerFeastOfBloodCD:Start(2)
		timerEchoesOfVoidCD:Start(2)
		self:UnregisterShortTermEvents()
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then--The Nightborne
		
		elseif self.vb.phase == 3 then--The Legion
		
		end
	end
end	

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 216027 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNetherZoneGTFO:Show()
		voiceNetherZone:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
