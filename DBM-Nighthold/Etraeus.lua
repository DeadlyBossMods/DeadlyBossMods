local mod	= DBM:NewMod(1732, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103758)
mod:SetEncounterID(1863)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205408 205486 206921 206949 206517 214486 207720 207439 216909",
	"SPELL_CAST_SUCCESS 206464 206464 206936 205649 207143",
	"SPELL_AURA_APPLIED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143",
	"SPELL_AURA_REMOVED 205429 216344 216345 205445 205984 214335 214167 206585 206936 207143",
	"SPELL_SUMMON 207813",
--	"SPELL_PERIODIC_DAMAGE 206399",
--	"SPELL_PERIODIC_MISSED 206399",
	"UNIT_DIED"
)

--TODO, if everyone doesn't get the debuffs, handle cancelNotMine differently
--TODO, change hunter/dragon icon/color to official icon when blizzard fixes oversight.
--TODO, evalulate hud size for conjunction for range check/hud. 5 yards guessed.
--TODO, Coronal Ejection is probably a debuff
--TODO, range frame for tanks during ice phase when phase detection is done, because of Iceburst
--TODO, timers/warnings for the bolt/bursts on tanks?
--TODO, felburst stacks/swapping?
--TODO, add felflame GTFO
--TODO, verify spell summon event. might only fire SUCCESS or UNIT_SPELLCAST
--TODO, does void nova even merit a special warning, or regular?
--Base abilities
local warnStarSignCrab				= mod:NewTargetAnnounce(205429, 2)--Yellow
local warnStarSignDragon			= mod:NewTargetAnnounce(216344, 2)--Blue
local warnStarSignHunter			= mod:NewTargetAnnounce(216345, 2, "Interface\\Icons\\boss_odunrunes_green")--Green (well, debuff is also blue but I am making it green)
local warnStarSignWolf				= mod:NewTargetAnnounce(205445, 2)--Red
local warnGravitationalPull			= mod:NewTargetAnnounce(205984, 4)
--Stage One: The Dome of Observation
local warnStarburst					= mod:NewSpellAnnounce(205486, 2, nil, false)--Probably spammy so off by default
local warnCoronalEjection			= mod:NewTargetAnnounce(206464, 2)
--Stage Two: Absolute Zero
local warnIceburst					= mod:NewSpellAnnounce(206921, 2, nil, false)--Probably spammy so off by default
local warnIcyEjection				= mod:NewTargetAnnounce(206936, 2)
--Stage Three: A Shattered World
local warnFelEjection				= mod:NewTargetAnnounce(205649, 2)
--Stage Four: Inevitable Fate
local warnVoidburst					= mod:NewSpellAnnounce(214486, 2, nil, false)
local warnVoidEjection				= mod:NewTargetAnnounce(207143, 2)

local specWarnConjunction			= mod:NewSpecialWarningMoveAway(205408, nil, nil, nil, 3, 2)
local specWarnConjunctionSign		= mod:NewSpecialWarningYouPos(205408, nil, nil, nil, 1, 6)
local specWarnGravitationalPull		= mod:NewSpecialWarningYou(205984, nil, nil, nil, 3, 2)
local specWarnGravitationalPullOther= mod:NewSpecialWarningTaunt(205984, nil, nil, nil, 1, 2)
local yellGravitationalPull			= mod:NewFadesYell(205984)
--Stage One: The Dome of Observation
local specWarnCoronalEjection		= mod:NewSpecialWarningMoveAway(206464, nil, nil, nil, 1, 2)
--Stage Two: Absolute Zero
local specWarnIcyEjection			= mod:NewSpecialWarningMoveAway(206936, nil, nil, nil, 1, 2)
local yellIcyEjection				= mod:NewFadesYell(206936)
local specWarnFrigidNova			= mod:NewSpecialWarningSpell(206949, nil, nil, nil, 2, 2)--maybe change to MoveTo warning
--Stage Three: A Shattered World
local specWarnFelEjection			= mod:NewSpecialWarningMoveAway(205649, nil, nil, nil, 1, 2)
local specWarnFelNova				= mod:NewSpecialWarningRun(206517, nil, nil, nil, 4, 2)
--Stage Four: Inevitable Fate
local specWarnThing					= mod:NewSpecialWarningSwitch("ej13057", "-Healer", nil, nil, 1, 2)
local specWarnWitnessVoid			= mod:NewSpecialWarningSpell(207720, nil, nil, nil, 1, 2)
local specWarnVoidEjection			= mod:NewSpecialWarningMoveAway(207143, nil, nil, nil, 1, 2)--Should this be a move away, does void burst do any damage?
local specWarnVoidNova				= mod:NewSpecialWarningSpell(207439, nil, nil, nil, 2, 2)
local specWarnWorldDevouringForce	= mod:NewSpecialWarningDodge(216909, nil, nil, nil, 3, 2)


--Base abilities
local timerConjunctionCD			= mod:NewAITimer(16, 205408, nil, nil, nil, 3)
local timerGravPullCD				= mod:NewAITimer(16, 205984, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage One: The Dome of Observation
local timerCoronalEjectionCD		= mod:NewAITimer(16, 206464, nil, nil, nil, 3)
--Stage Two: Absolute Zero
local timerIcyEjectionCD			= mod:NewAITimer(16, 206936, nil, nil, nil, 3)
local timerFrigidNovaCD				= mod:NewAITimer(16, 206949, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Three: A Shattered World
local timerFelEjectionCD			= mod:NewAITimer(16, 205649, nil, nil, nil, 3)
local timerFelNovaCD				= mod:NewAITimer(16, 206517, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Four: Inevitable Fate
local timerWitnessVoidCD			= mod:NewAITimer(16, 207720, nil, nil, nil, 2)
local timerVoidEjectionCD			= mod:NewAITimer(16, 207143, nil, nil, nil, 3)
local timerVoidNovaCD				= mod:NewAITimer(16, 207439, nil, nil, nil, 2)
local timerWorldDevouringForceCD	= mod:NewAITimer(16, 216909, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--Base abilities
local countdownConjunction			= mod:NewCountdownFades("AltTwo15", 205408)
local countdownGravPull				= mod:NewCountdownFades("Alt10", 205984)--Maybe change to everyone if it works like I think
--Stage One: The Dome of Observation
--Stage Two: Absolute Zero
--Stage Three: A Shattered World
--Stage Four: Inevitable Fate

--Base abilities
local voiceConjunction				= mod:NewVoice(205408)--scatter/find <type>
local voiceGravPull					= mod:NewVoice(205984)--targetyou/tauntboss
--Stage One: The Dome of Observation
local voiceCoronalEjection			= mod:NewVoice(206464)--runout
--Stage Two: Absolute Zero
local voiceIcyEjection				= mod:NewVoice(206936)--runout
local voiceFrigidNova				= mod:NewVoice(206949)--gathershare
--Stage Three: A Shattered World
local voiceFelEjection				= mod:NewVoice(205649)--runout/keepmove
local voiceFelnova					= mod:NewVoice(206517)--justrun
--Stage Four: Inevitable Fate
local voiceThing					= mod:NewVoice("ej13057", "-Healer")--killmob
local voiceWitnessVoid				= mod:NewVoice(207720)--turnaway
local voiceVoidEjection				= mod:NewVoice(207143)--runout
local voiceVoidNova					= mod:NewVoice(207439)--aesoon
local voiceWorldDevouringForce		= mod:NewVoice(216909)--farfromline


mod:AddRangeFrameOption("5/8")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnConjunction", 205408)
mod:AddBoolOption("FilterOtherSigns", true)
mod:AddInfoFrameOption(205408)--really needs a "various" option

mod.vb.StarSigns = 0
mod.vb.phase = 1
local abZeroTargets = {}
local abZeroDebuff, chilledDebuff, gravPullDebuff = GetSpellInfo(206585), GetSpellInfo(182006), GetSpellInfo(205984)
local icyEjectionDebuff, coronalEjectionDebuff, voidEjectionDebuff = GetSpellInfo(206936), GetSpellInfo(206464), GetSpellInfo(207143)
local UnitDebuff = UnitDebuff
local chilledFilter
do
	chilledFilter = function(uId)
		if UnitDebuff(uId, chilledDebuff) then
			return true
		end
	end
end

local updateInfoFrame, sortInfoFrame
do
--	local playerName = UnitName("player")
	local crabDebuff, dragonDebuff, hunterDebuff, wolfDebuff = GetSpellInfo(205429), GetSpellInfo(216344), GetSpellInfo(216345), GetSpellInfo(205445)
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
		local total1, total2 = 0, 0
		local crabs, dragons, hunters, wolves = 0, 0, 0, 0
		--Star Signs Helper
		for i = 1, DBM:GetNumRealGroupMembers() do
			local unitID = 'raid'..i
			if UnitDebuff(unitID, crabDebuff) then
				crabs = crabs + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, dragonDebuff) then
				dragons = dragons + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, hunterDebuff) then
				hunters = hunters + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, wolfDebuff) then
				wolves = wolves + 1
				total1 = total1 + 1
			end
		end
		if total1 > 0 then
			lines["|cF2F200CD"..crabDebuff.."|r"] = crabs
			lines["|c69CCF0CD"..dragonDebuff.."|r"] = dragons
			lines["|c00FF00CD"..hunterDebuff.."|r"] = hunters
			lines["|cFF1A1ACD"..wolfDebuff.."|r"] = wolves
		end
		--Absolute Zero Helper
		for i = 1, #abZeroTargets do
			local name = abZeroTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local _, _, _, currentStack = UnitDebuff(uId, abZeroDebuff)
			if currentStack then
				total2 = total2 + 1
				lines[name] = currentStack
			end
		end
		if total2 > 0 then
			--Displays whether or not player has chilled. if YES in red or NO in green
			--Ths is displayed under the absolute zero name/stacks so they know there are still stacks to soak and if able.
			lines[chilledDebuff] = UnitDebuff("player", chilledDebuff) and "|cFF1A1ACD"..YES.."|r" or "|c69CCF0CD"..NO.."|r"
		end
		if total1 == 0 or total2 == 0 then--Nothing left, hide infoframe
			DBM.InfoFrame:Hide()
		end
		return lines
	end
end

local function updateRangeFrame(self, force)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", icyEjectionDebuff) or UnitDebuff("player", coronalEjectionDebuff) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.phase == 2 and self:IsTank() then--Spread for iceburst
		DBM.RangeCheck:Show(6)
	elseif UnitDebuff("Player", gravPullDebuff) or UnitDebuff("player", voidEjectionDebuff) or force or self.vb.StarSigns > 0 then
		DBM.RangeCheck:Show(5)
	elseif UnitDebuff("player", abZeroDebuff) then
		DBM.RangeCheck:Show(8, chilledFilter)
	else
		DBM.RangeCheck:Hide()
	end
end

local function cancelNotMine(self, spellId)
	--Idea behind this is you should only see all targets same sign as you
	if not self.Options.FilterOtherSigns then return end--Don't cancel anything.
	if spellId ~= 205429 then
		warnStarSignCrab:Cancel()
	end
	if spellId ~= 216344 then
		warnStarSignHunter:Cancel()
	end
	if spellId ~= 216345 then
		warnStarSignHunter:Cancel()
	end
	if spellId ~= 205445 then
		warnStarSignWolf:Cancel()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(abZeroTargets)
	self.vb.StarSigns = 0
	self.vb.phase = 1
	timerConjunctionCD:Start(1-delay)
	timerCoronalEjectionCD:Start(1-delay)
	timerGravPullCD:Start(1-delay)
	DBM:AddMsg("Auto learning AI timers on this fight will not be able to adapt to phase changes to cancel/update accordingly. They should work fairly well withina each phase however.")
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnConjunction then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205408 then
		specWarnConjunction:Show()
		voiceConjunction:Play("scatter")
		timerConjunctionCD:Start()
		updateRangeFrame(self, true)
		DBM:AddMsg("Sadly, all the fancy HUD features for this won't look right if 3rd party textures aren't loaded. HUD should color code the 4 star signs nicely")
	elseif spellId == 205486 then
		warnStarburst:Show()
	elseif spellId == 206921 then
		warnIceburst:Show()
	elseif spellId == 206949 then
		specWarnFrigidNova:Show()
		voiceFrigidNova:Play("gathershare")
		timerFrigidNovaCD:Start()
	elseif spellId == 206517 then
		specWarnFelNova:Show()
		voiceFelnova:Play("justrun")
		timerFelNovaCD:Start()
	elseif spellId == 214486 then
		warnVoidburst:Show()
	elseif spellId == 207720 then
		specWarnWitnessVoid:Show()
		voiceWitnessVoid:Play("turnaway")
		timerWitnessVoidCD:Start(nil, args.sourceGUID)
	elseif spellId == 207439 then
		specWarnVoidNova:Show()
		voiceVoidNova:Play("aesoon")
		timerVoidNovaCD:Start()
	elseif spellId == 216909 then
		specWarnWorldDevouringForce:Show()
		voiceWorldDevouringForce:Play("farfromline")
		timerWorldDevouringForceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206464 then
		timerCoronalEjectionCD:Start()
	elseif spellId == 206936 then
		timerIcyEjectionCD:Start()
	elseif spellId == 205649 then
		timerFelEjectionCD:Start()
	elseif spellId == 207143 then
		timerVoidEjectionCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 207813 then
		specWarnThing:Show()
		voiceThing:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns + 1
		if spellId == 205429 then--Crab
			warnStarSignCrab:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Yellow
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 17, 1, 1, 0, 0.5, nil, true):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408c")
				self:Schedule(1, cancelNotMine, self, spellId)
				countdownConjunction:Start()
			end
		elseif spellId == 216344 then--Dragon
			warnStarSignDragon:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Blue
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 17, 0, 0, 1, 0.5, nil, true):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408d")
				self:Schedule(1, cancelNotMine, self, spellId)
				countdownConjunction:Start()
			end
		elseif spellId == 216345 then--Hunter
			warnStarSignHunter:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Green
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 17, 0, 1, 0, 0.5, nil, true):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408h")
				self:Schedule(1, cancelNotMine, self, spellId)
				countdownConjunction:Start()
			end
		elseif spellId == 205445 then--Wolf
			warnStarSignWolf:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Red
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 17, 1, 0, 0, 0.5, nil, true):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408w")
				self:Schedule(1, cancelNotMine, self, spellId)
				countdownConjunction:Start()
			end
		end
		if self.vb.StarSigns == 1 then
			updateRangeFrame(self)
			if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Show(15, "function", updateInfoFrame, sortInfoFrame, true)
			end
		end
	elseif spellId == 206464 then
		warnCoronalEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCoronalEjection:Show()
			voiceCoronalEjection:Play("runout")
			updateRangeFrame(self)
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		timerGravPullCD:Start()
		if args:IsPlayer() then
			updateRangeFrame(self)
			specWarnGravitationalPull:Show()
			voiceGravPull:Play("targetyou")
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				countdownGravPull:Start(remaining)
				yellGravitationalPull:Schedule(remaining-1, 1)
				yellGravitationalPull:Schedule(remaining-2, 2)
				yellGravitationalPull:Schedule(remaining-3, 3)
				yellGravitationalPull:Schedule(remaining-5, 5)
			end
		elseif self:IsTank() then
			specWarnGravitationalPullOther:Show(args.destName)
			voiceGravPull:Play("tauntboss")
		else
			warnGravitationalPull:Show(args.destName)
		end
	elseif spellId == 206585 then
		if not tContains(abZeroTargets, args.destName) then
			table.insert(abZeroTargets, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Show(15, "function", updateInfoFrame, sortInfoFrame, true)
		end
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 206936 then
		warnIcyEjection:CombinedShow(0.5, args.destName)--If only one, move this to else rule to filter from player
		if args:IsPlayer() then
			specWarnIcyEjection:Show()
			voiceIcyEjection:Play("runout")
			updateRangeFrame(self)
			yellIcyEjection:Schedule(9, 1)
			yellIcyEjection:Schedule(8, 2)
			yellIcyEjection:Schedule(7, 3)
		end
	elseif spellId == 205649 then
		warnFelEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFelEjection:Show()
			voiceFelEjection:Play("runout")
			voiceFelEjection:Schedule(1, "keepmove")
		end
	elseif spellId == 207143 then
		warnVoidEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVoidEjection:Show()
			voiceVoidEjection:Play("runout")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns - 1
		if self.vb.StarSigns == 0 then
			updateRangeFrame(self)
		end
		if self.Options.HudMapOnConjunction then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if args:IsPlayer() then
			countdownConjunction:Cancel()
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			yellGravitationalPull:Cancel()
			countdownGravPull:Cancel()
			yellIcyEjection:Cancel()
		end
	elseif spellId == 206585 then
		tDeleteItem(abZeroTargets, args.destName)
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 206464 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 206936 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 207143 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104880 then--Thing That Should Not Be
		timerWitnessVoidCD:Cancel(args.destGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206399 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

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
