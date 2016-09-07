local mod	= DBM:NewMod(1762, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103685)
mod:SetEncounterID(1862)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Unknown carrions
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212997 213238 212794 208230 213531 206365 216034 216723",
	"SPELL_CAST_SUCCESS 212997 212794",
	"SPELL_AURA_APPLIED 206480 212794 208230 216040",
	"SPELL_AURA_APPLIED_DOSE 216024",
	"SPELL_AURA_REMOVED 212794 216040",
	"SPELL_PERIODIC_DAMAGE 216027",
	"SPELL_PERIODIC_MISSED 216027"
)

--TODO, possible hud options for brand of argus?
--TODO, more review on Feast of Blood
--TODO, voices similar to 184964a/b/c but for Brand of argus instead of torment. Or better. Maybe generic with no spell name just "break first" "break second" that works for similar spell in future
--TODO, determine how often tanks swap for 216024 (Volatile Wound), if at all
--TODO, figure out ring of shadow
--TODO, test HUD for Seeker. Improve boss location approximation if possible.
 --(ability.id = 212997 or ability.id = 213238 or ability.id = 208230 or ability.id = 213531 or ability.id = 206365) and type = "begincast"
local warnCarrionPlague				= mod:NewTargetAnnounce(206480, 3)
local warnBrandOfArgus				= mod:NewTargetAnnounce(212794, 4)
--Nightborne
local warnVolatileWound				= mod:NewStackAnnounce(216024, 3, nil, false, 2)
--The Legion
local warnBurningSoul				= mod:NewTargetAnnounce(216040, 4)
local warnRingOfShadow				= mod:NewSpellAnnounce(216723, 3)

local specWarnCarrionPlague			= mod:NewSpecialWarningMoveAway(206480, nil, nil, nil, 1, 2)
local specWarnSeekerSwarm			= mod:NewSpecialWarningDodge(213238, nil, nil, nil, 2, 6)
local yellSeekerSwarm				= mod:NewYell(213238)--Carrion plague targets yell when it's relevant. On seeker swarm cast
--local specWarnBreakMark			= mod:NewSpecialWarning("specWarnBreakMark", nil, nil, nil, 1)
local yellBrandOfArgus				= mod:NewPosYell(212794, 156225)--"Branded" short text
local specWarnFeastOfBlood			= mod:NewSpecialWarningRun(208230, nil, nil, nil, 1, 2)--Move away, or run? neither one really says "get 30 yards from boss"
local specWarnFeastOfBloodOther		= mod:NewSpecialWarningTaunt(208230, nil, nil, nil, 1, 2)
local specWarnEchoesOfVoid			= mod:NewSpecialWarningDodge(213531, nil, nil, nil, 3, 2)
--Nightborne
local specWarnBlastNova				= mod:NewSpecialWarningInterrupt(216034, "HasInterrupt", nil, nil, 2, 2)
local specWarnNetherZoneGTFO		= mod:NewSpecialWarningMove(216027, nil, nil, nil, 2, 2)
--The Legion
local specWarnBurningSoul			= mod:NewSpecialWarningMoveAway(216040, nil, nil, nil, 1, 2)
local yellBurningSoul				= mod:NewYell(216040)

local timerCarrionPlagueCD			= mod:NewNextCountTimer(25, 212997, nil, nil, nil, 3)
local timerSeekerSwarmCD			= mod:NewNextCountTimer(25, 213238, nil, nil, nil, 3)
local timerBrandOfArgusCD			= mod:NewNextCountTimer(25, 212794, nil, nil, nil, 3)--Concider short timer 156225
local timerFeastOfBloodCD			= mod:NewNextCountTimer(25, 208230, nil, "Tank", nil, 5)
local timerEchoesOfVoidCD			= mod:NewNextCountTimer(65, 213531, nil, nil, nil, 2)
local timerIllusionaryNightCD		= mod:NewNextCountTimer(125, 206365, nil, nil, nil, 6)
local timerIllusionaryNight			= mod:NewBuffActiveTimer(32, 206365, nil, nil, nil, 6)

local countdownSeekerSwarm			= mod:NewCountdown(25, 162185)
local countdownEchoesOfVoid			= mod:NewCountdown("Alt65", 213531)
local countdownFeastOfBlood			= mod:NewCountdown("AltTwo25", 208230, "Tank")
local countdownNightPhase			= mod:NewCountdown(32, 206365)

local voiceCarrionPlague			= mod:NewVoice(206480)--scatter
local voiceSeekerSwarm				= mod:NewVoice(213238)--targetyou/farfromline
local voiceFeastOfBlood				= mod:NewVoice(208230)--runout/tauntboss
local voiceEchoesOfVoid				= mod:NewVoice(213531)--findshelter
--Nightborne
local voiceBlastNova				= mod:NewVoice(216034)--kickcast
local voiceNetherZone				= mod:NewVoice(216027)--runaway
--The Legion
local voiceBurningSoul				= mod:NewVoice(216040)--runout

mod:AddRangeFrameOption(8, 216040)
mod:AddSetIconOption("SetIconOnBrandOfArgus", 212794, true)
mod:AddInfoFrameOption(212794)
mod:AddHudMapOption("HudMapOnSeeker", 213238)
mod:AddBoolOption("HUDSeekerLines", true)--On by default for beta testing. Actual defaults for live subject to accuracy review.

local sharedCastTimers = {0, 25, 35, 25}--Carrion Plague, feast of blood, Seeker Swarm, brand of argus
local sharedCastTimersFaster = {0, 15, 25, 14.5}--Carrion Plague, feast of blood, Seeker Swarm, brand of argus (faster on normal/LFR since no brand of argus)
local carrionTargets = {}
local argusTargets = {}
local carrionDebuff = GetSpellInfo(206480)
mod.vb.phase = 1
mod.vb.carrionPlagueCast = 0
mod.vb.feastOfBloodCast = 0
mod.vb.seekerSwarmCast = 0
mod.vb.brandOfArgusCast = 0
mod.vb.echoesOfVoidCast = 0

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
	self.vb.carrionPlagueCast = 0
	self.vb.feastOfBloodCast = 0
	self.vb.seekerSwarmCast = 0
	self.vb.brandOfArgusCast = 0
	self.vb.echoesOfVoidCast = 0
	table.wipe(carrionTargets)
	table.wipe(argusTargets)
	timerCarrionPlagueCD:Start(7-delay, 1)--Cast end
	if not self:IsEasy() then
		timerBrandOfArgusCD:Start(17-delay, 1)--Cast end
		timerFeastOfBloodCD:Start(20-delay, 1)
		timerSeekerSwarmCD:Start(25-delay, 1)
		countdownSeekerSwarm:Start(25-delay)
		timerEchoesOfVoidCD:Start(55-delay, 1)
		timerIllusionaryNightCD:Start(130-delay, 1)
	else
		timerFeastOfBloodCD:Start(10-delay, 1)
		timerSeekerSwarmCD:Start(15-delay, 1)
		countdownSeekerSwarm:Start(15-delay)
		timerEchoesOfVoidCD:Start(35-delay, 1)
		timerIllusionaryNightCD:Start(90-delay, 1)
	end
end

function mod:OnCombatEnd()
--	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMapOnSeeker then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212997 then
		table.wipe(carrionTargets)
		if self.vb.darkPhase then--He casts it immediately after a Night phase ends
			self.vb.darkPhase = false
			self.vb.carrionPlagueCast = 0
			self.vb.feastOfBloodCast = 0
			self.vb.seekerSwarmCast = 0
			self.vb.brandOfArgusCast = 0
			self.vb.echoesOfVoidCast = 0
			DBM:Debug("First carrion Swarm after dark phase, Tichondrius returning", 2)
			--Timers same as combat start - 5
			if not self:IsEasy() then
				timerBrandOfArgusCD:Start(12, 1)--Cast end
				timerFeastOfBloodCD:Start(25, 1)
				timerSeekerSwarmCD:Start(20, 1)
				countdownSeekerSwarm:Start(20)
				timerEchoesOfVoidCD:Start(50, 1)
				timerIllusionaryNightCD:Start(125, 1)
			else
				timerFeastOfBloodCD:Start(5, 1)
				timerSeekerSwarmCD:Start(10, 1)
				countdownSeekerSwarm:Start(10)
				timerEchoesOfVoidCD:Start(30, 1)
				timerIllusionaryNightCD:Start(85, 1)
			end
			self.vb.phase = self.vb.phase + 1
			if self.vb.phase == 2 then--The Nightborne
		
			elseif self.vb.phase == 3 then--The Legion
		
			end
			--Restore argus tracker if for some reason you let people have it this long
			if self.Options.InfoFrame and self:IsMythic() then
				DBM.InfoFrame:SetHeader(GetSpellInfo(212794))
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame, true)
			end
		end
	elseif spellId == 213238 then
		self.vb.seekerSwarmCast = self.vb.seekerSwarmCast + 1
		specWarnSeekerSwarm:Show(self.vb.seekerSwarmCast)
		local timer = self:IsEasy() and sharedCastTimersFaster[self.vb.seekerSwarmCast+1] or sharedCastTimers[self.vb.seekerSwarmCast+1]
		if timer then
			timerSeekerSwarmCD:Start(timer, self.vb.seekerSwarmCast+1)
			countdownSeekerSwarm:Start(timer)
		end
		if UnitDebuff("player", carrionDebuff) then
			yellSeekerSwarm:Yell()
			voiceSeekerSwarm:Play("targetyou")
		else
			voiceSeekerSwarm:Play("farfromline")
		end
		--begin WIP experimental HUD stuff
		if DBM.Options.EnablePatchRestrictions or not self.Options.HudMapOnSeeker then return end--Hud disabled, ignore rest of this code
		DBMHudMap:RegisterRangeMarkerOnPartyMember(213238, "party", UnitName("player"), 0.7, 3, nil, nil, nil, 1, nil, false):Appear()--Create Player Dot
		--Find boss tank if seeker lines enabled to determine approx boss location
		--TODO, add drop down in options to let user select direction boss facing, then offset this dot
		--TODO: Alternative, scan position of all melee in raid and find intersect point and assume that's boss location
		local currentTank = self.Options.HUDSeekerLines and self:GetCurrentTank() or false
		for uId in DBM:GetGroupMembers() do
			if UnitDebuff(uId, carrionDebuff) then
				local name = DBM:GetUnitFullName(uId)
				if UnitIsUnit(uId, "player") then
					--Player dot already created
					if currentTank then--Create Line from current tank to seeker targets.
						DBMHudMap:AddEdge(0, 1, 0, 0.5, 3, currentTank, name, nil, nil, nil, nil, 125)
					end
				else
					DBMHudMap:RegisterRangeMarkerOnPartyMember(213238, "party", name, 0.35, 3, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(name, nil, nil, nil, nil, nil, 0.8, nil, -13, 8, nil)
					if currentTank then--Create Line from current tank to seeker targets.
						DBMHudMap:AddEdge(1, 0, 0, 0.5, 3, currentTank, name, nil, nil, nil, nil, 125)
					end
				end
			end
		end
	elseif spellId == 212794 then
--		table.wipe(argusTargets)
	elseif spellId == 208230 then
		self.vb.feastOfBloodCast = self.vb.feastOfBloodCast + 1
		local timer = self:IsEasy() and sharedCastTimersFaster[self.vb.feastOfBloodCast+1] or sharedCastTimers[self.vb.feastOfBloodCast+1]
		if timer then
			timerFeastOfBloodCD:Start(nil, self.vb.feastOfBloodCast+1)
		end
	elseif spellId == 213531 then
		self.vb.echoesOfVoidCast = self.vb.echoesOfVoidCast + 1
		specWarnEchoesOfVoid:Show(self.vb.echoesOfVoidCast)
		voiceEchoesOfVoid:Play("findshelter")
		if self.vb.echoesOfVoidCast == 1 then
			--Only cast twice per cycle
			timerEchoesOfVoidCD:Start(nil, 2)
		end
	elseif spellId == 206365 then--Phase Change
		--stops may not be needed if sharedTimer Table works
		timerCarrionPlagueCD:Stop()
		timerSeekerSwarmCD:Stop()
		countdownSeekerSwarm:Cancel()
		timerBrandOfArgusCD:Stop()
		timerFeastOfBloodCD:Stop()
		timerEchoesOfVoidCD:Stop()
		self.vb.darkPhase = true
		timerIllusionaryNight:Start()
		countdownNightPhase:Start()
		--Switch to debuff tracking on mythic.
		if self.Options.InfoFrame and self:IsMythic() then
			local essenceOfNightDebuff = GetSpellInfo(206466)
			DBM.InfoFrame:SetHeader(essenceOfNightDebuff)
			DBM.InfoFrame:Show(10, "playerbaddebuff", essenceOfNightDebuff, nil, true)
		end
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
		self.vb.carrionPlagueCast = self.vb.carrionPlagueCast + 1
		local timer = self:IsEasy() and sharedCastTimersFaster[self.vb.carrionPlagueCast+1] or sharedCastTimers[self.vb.carrionPlagueCast+1]
		if timer then
			timerCarrionPlagueCD:Start(timer, self.vb.carrionPlagueCast+1)
		end
	elseif spellId == 212794 then
		self.vb.brandOfArgusCast = self.vb.brandOfArgusCast + 1
		local timer = sharedCastTimers[self.vb.brandOfArgusCast+1]
		if timer then 
			timerBrandOfArgusCD:Start(timer, self.vb.brandOfArgusCast+1)
		end
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
		end
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
	if spellId == 212794 then
		tDeleteItem(argusTargets, args.destName)
		if self.Options.SetIconOnBrandOfArgus then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 216040 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--[[
Unused for now, maybe need to do this way on mythic/LFR/etc if carrion method isn't reliable
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if UnitExists("boss1") then--Tichondrius Returning
		DBM:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT, Tichondrius returning", 2)
		timerBrandOfArgusCD:Start(9.5, 1)--Cast end
		timerFeastOfBloodCD:Start(22.5, 1)
		timerSeekerSwarmCD:Start(17.5, 1)
		countdownSeekerSwarm:Start(17.5)
		timerEchoesOfVoidCD:Start(47.5, 1)
		timerIllusionaryNightCD:Start(122.5, 1)
		self:UnregisterShortTermEvents()
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then--The Nightborne
		
		elseif self.vb.phase == 3 then--The Legion
		
		end
	end
end--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 216027 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNetherZoneGTFO:Show()
		voiceNetherZone:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
