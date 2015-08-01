local mod	= DBM:NewMod(1447, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(93068)
mod:SetEncounterID(1800)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(14078)
mod.respawnTime = 29

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 190223 186453 190224 186783 186546 186490 189775 189779",
	"SPELL_CAST_SUCCESS 186407 186333 186490 189775",
	"SPELL_AURA_APPLIED 186073 186063 186134 186135 186407 186333 186500 189777 186448 187204 186785",
	"SPELL_AURA_APPLIED_DOSE 186073 186063 186448 186785 187204",
	"SPELL_AURA_REMOVED 189777",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(target.id = 94185 or target.id =  94239) and type = "death" or (ability.id = 190223 or ability.id = 190224 or ability.id = 186453 or ability.id = 186783 or ability.id = 186546 or ability.id = 189779 or ability.id = 186490 or ability.id = 189775) and type = "begincast" or (ability.id = 186407 or ability.id = 186333) and type = "cast" or ability.id = 187204 and type = "applybuff"
--Fire Phase
----Boss
local warnFelPortal					= mod:NewSpellAnnounce(187003, 2)
local warnFelSurge					= mod:NewTargetAnnounce(186407, 3)
local warnFelStrike					= mod:NewSpellAnnounce(186271, 3, nil, "Tank")
----Adds
local warnFelChains					= mod:NewTargetAnnounce(186490, 3)
local warnEmpoweredFelChains		= mod:NewTargetAnnounce(189775, 3)--Mythic
--Void Phase
----Boss
local warnVoidPortal				= mod:NewSpellAnnounce(187006, 2)
local warnVoidSurge					= mod:NewTargetAnnounce(186333, 3)
local warnVoidStrike				= mod:NewSpellAnnounce(186292, 3, nil, "Tank")
local warnVoids						= mod:NewCountAnnounce("ej11714", 2, 697, "Ranged")
----
--End Phase
local warnOverwhelmingChaos			= mod:NewCountAnnounce(187204, 4)

--Fight Wide
local specWarnFelTouched			= mod:NewSpecialWarningYou(186134, false)
local specWarnFelsinged				= mod:NewSpecialWarningMove(186073, nil, nil, nil, 1, 2)--Fire GTFO
local specWarnVoidTouched			= mod:NewSpecialWarningYou(186135, false)
local specWarnWastingVoid			= mod:NewSpecialWarningMove(186063, nil, nil, nil, 1, 2)--Void GTFO
--Fire Phase
----Boss
local specWarnFelStrike				= mod:NewSpecialWarningSpell(186271, "Tank")
local specWarnEmpoweredFelStrike	= mod:NewSpecialWarningTaunt(188092, false)--Maybe redundant
local specWarnFelSurge				= mod:NewSpecialWarningYou(186407, nil, nil, nil, 1, 2)
local yellFelSurge					= mod:NewYell(186407)
local specWarnImps					= mod:NewSpecialWarningSwitchCount("ej11694", "Dps")
----Adds
local specWarnFelBlazeFlurry		= mod:NewSpecialWarningSpell(186453, "Tank")
local specWarnFelChains				= mod:NewSpecialWarningYou(186490)
local specWarnEmpoweredFelChains	= mod:NewSpecialWarningYou(189775)
local yellFelChains					= mod:NewYell(186490)
--Void Phase
----Boss
local specWarnVoidStrike			= mod:NewSpecialWarningSpell(186292, "Tank")
local specWarnVoidSurge				= mod:NewSpecialWarningYou(186333, nil, nil, nil, 1, 5)
local yellVoidSurge					= mod:NewYell(186333)
----Adds
local specWarnWitheringGaze			= mod:NewSpecialWarningSpell(186783, "Tank")
local specWarnBlackHole				= mod:NewSpecialWarningSpell(186546, nil, nil, nil, 2)
local specWarnEmpBlackHole			= mod:NewSpecialWarningSpell(189779, nil, nil, nil, 2)--Mythic

--Fire Phase
----Boss
local timerFelStrikeCD				= mod:NewCDTimer(15, 186271, nil, "Tank", nil, 5)--15.8-17
local timerFelSurgeCD				= mod:NewCDTimer(30, 186407, nil, nil, nil, 3)
local timerImpCD					= mod:NewNextTimer(25, "ej11694", nil, nil, nil, 1, 112866)
----Big Add
local timerFelBlazeFlurryCD			= mod:NewCDTimer(15.9, 186453, nil, "Tank", nil, 5)
local timerFelChainsCD				= mod:NewCDTimer(30, 186490, nil, "-Tank", nil, 3)--30-34. Often 34 but it can and will be 30 sometimes.
local timerEmpFelChainsCD			= mod:NewCDTimer(30, 189775, nil, "-Tank", nil, 3)--Merge with timerFelChainsCD?
--Void Phase
----Boss
local timerVoidStrikeCD				= mod:NewCDTimer(17, 186292, nil, "Tank", nil, 5)
local timerVoidSurgeCD				= mod:NewCDTimer(30, 186333, nil, nil, nil, 3)
local timerVoidsCD					= mod:NewNextTimer(30, "ej11714", nil, "Ranged", nil, 1, 697)
----Big Add
local timerWitheringGazeCD			= mod:NewCDTimer(14.5, 186783, nil, "Tank", 2, 5)
local timerBlackHoleCD				= mod:NewCDTimer(29.5, 186546, nil, nil, nil, 5)
local timerEmpBlackHoleCD			= mod:NewCDTimer(29.5, 189779, nil, nil, nil, 5)--Merge with timerBlackHoleCD?
--End Phase
local timerOverwhelmingChaosCD		= mod:NewNextCountTimer(10, 187204, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownFelSurge				= mod:NewCountdown(30, 186407, "-Tank")
local countdownVoidSurge			= mod:NewCountdown("Alt30", 186333, "-Tank")
local countdownImps					= mod:NewCountdown("AltTwo25", "ej11694", "Dps")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceFelsinged				= mod:NewVoice(186073)	--run away
local voiceFelSurge					= mod:NewVoice(186407)	--run out (because need to tell difference from run away GTFOs)
local voiceWastingVoid				= mod:NewVoice(186063)  --run away
local voiceVoidSurge				= mod:NewVoice(186333)	--new voice

--Warning behavior choices for Chains.
--Cast only gives original target, not all targets, but does so 3 seconds faster. It allows the person to move early and change other players they affect with chains by pre moving.
--Applied gives all targets, this is the easier strat for most users, where they wait until everyone has it, then run in different directions.
--Both, gives users ALL the information for everything so they can decide on their own. This will be default until I can see what becomes more popular. Maybe both will be what everyone ends up preferring.
mod:AddRangeFrameOption(5, 189775)--Mythic
mod:AddDropdownOption("ChainsBehavior", {"Cast", "Applied", "Both"}, "Both", "misc")

mod.vb.EmpFelChainCount = 0
mod.vb.phase = 1
mod.vb.impCount = 0
mod.vb.voidCount = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local AddsSeen = {}

local debuffFilter
local debuffName = GetSpellInfo(189775)
local UnitDebuff = UnitDebuff
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.EmpFelChainCount > 0 then
		if UnitDebuff("Player", debuffName) then
			DBM.RangeCheck:Show(5)
		else
			DBM.RangeCheck:Show(5, debuffFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

--You can use their first cast, but scheduling is more accurate from what i've tested
--First cast will break if imps are stunned/interrupted by gorefiends grip on spawn and don't begin their first cast
--not to mention their first cast is a good 1.5-2 seconds after spawn, if it isn't prevented
local function ImpRepeater(self)
	self.vb.impCount = self.vb.impCount + 1
	specWarnImps:Show(self.vb.impCount)
	timerImpCD:Start(nil, self.vb.impCount+1)
	countdownImps:Start()
	self:Schedule(25, ImpRepeater, self)
end

local function VoidsRepeater(self)
	self.vb.voidCount = self.vb.voidCount + 1
	warnVoids:Show(self.vb.voidCount)
	timerVoidsCD:Start(nil, self.vb.voidCount+1)
	self:Schedule(30, VoidsRepeater, self)
end

function mod:FelChains(targetname, uId)
	if targetname == UnitName("player") then
		if self:AntiSpam(5, 3) then
			specWarnFelChains:Show()
			yellFelChains:Yell()
		end
	else
		warnFelChains:Show(targetname)
	end
end

function mod:EmpoweredFelChains(targetname, uId)
	if targetname == UnitName("player") then
		specWarnEmpoweredFelChains:Show()
		yellFelChains:Yell()--Continue using shorter yell
	else
		warnEmpoweredFelChains:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.EmpFelChainCount = 0
	self.vb.phase = 1
	self.vb.impCount = 0
	self.vb.voidCount = 0
	table.wipe(AddsSeen)
	timerFelStrikeCD:Start(8-delay)
	timerFelSurgeCD:Start(21-delay)
	countdownFelSurge:Start(21-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 190223 then
		timerFelStrikeCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnFelStrike:Show()--So show tank warning
				return
			end
		end
		warnFelStrike:Show()--Should not show if specWarnFelStrike did
	elseif spellId == 190224 then
		if self.vb.phase >= 3 then
			timerVoidStrikeCD:Start(15)
		else
			timerVoidStrikeCD:Start()
		end
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnVoidStrike:Show()--So show tank warning
				return
			end
		end
		warnVoidStrike:Show()--Should not show if specWarnVoidStrike did
	elseif spellId == 186453 then
		timerFelBlazeFlurryCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnFelBlazeFlurry:Show()--So show tank warning
				break
			end
		end
	elseif spellId == 186783 then
		if self:IsNormal() then
			timerWitheringGazeCD:Start(24)
		else
			timerWitheringGazeCD:Start()
		end
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnWitheringGaze:Show()--So show tank warning
				break
			end
		end
	elseif spellId == 186546 then
		specWarnBlackHole:Show()
		timerBlackHoleCD:Start()
	elseif spellId == 189779 then
		specWarnEmpBlackHole:Show()
		timerEmpBlackHoleCD:Start()
	elseif spellId == 186490 then
		if self.Options.ChainsBehavior ~= "Applied" then--Start timer and scanner if method is Both or Cast. Both prefers cast over applied, for the timer.
			if self:IsNormal() then
				timerFelChainsCD:Start(30)
			else
				timerFelChainsCD:Start()
			end
			self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "FelChains", 0.1, 16)
		end
	elseif spellId == 189775 then
		if self.Options.ChainsBehavior ~= "Applied" then--Start timer and scanner if method is Both or Cast. Both prefers cast over applied, for the timer.
			timerEmpFelChainsCD:Start()
			self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "EmpoweredFelChains", 0.1, 16)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 186407 then
		timerFelSurgeCD:Start()
		countdownFelSurge:Start()
	elseif spellId == 186333 then
		timerVoidSurgeCD:Start()
		countdownVoidSurge:Start()
	elseif spellId == 186490 then
		if self.Options.ChainsBehavior == "Applied" then--Start timer here if method is set to only applied
			if self:IsNormal() then
				timerFelChainsCD:Start(30)
			else
				timerFelChainsCD:Start()
			end
		end
	elseif spellId == 189775 then
		if self.Options.ChainsBehavior == "Applied" then--Start timer here if method is set to only applied
			timerEmpFelChainsCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 186063 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnWastingVoid:Show()
		voiceWastingVoid:Play("runaway")
	elseif spellId == 186073 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnFelsinged:Show()
		voiceFelsinged:Play("runaway")
	elseif spellId == 186135 and args:IsPlayer() then
		specWarnVoidTouched:Show()
	elseif spellId == 186134 and args:IsPlayer() then
		specWarnFelTouched:Show()
	elseif spellId == 186407 then
		warnFelSurge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelSurge:Show()
			yellFelSurge:Yell()
			voiceFelSurge:Play("runout")
		end
	elseif spellId == 186333 then
		warnVoidSurge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVoidSurge:Show()
			yellVoidSurge:Yell()
			voiceVoidSurge:Play("186333")
		end
	elseif spellId == 186500 and self.Options.ChainsBehavior ~= "Cast" then--Chains! (show warning if type is applied or both)
		warnFelChains:CombinedShow(0.3, args.destName)
		if args:IsPlayer() and self:AntiSpam(5, 3) then
			specWarnFelChains:Show()
			yellFelChains:Yell()
		end
	elseif spellId == 189777 then--Mythic chains
		self.vb.EmpFelChainCount = self.vb.EmpFelChainCount + 1
		if self.Options.ChainsBehavior ~= "Cast" then
			warnEmpoweredFelChains:CombinedShow(0.3, args.destName)
			if args:IsPlayer() then
				specWarnEmpoweredFelChains:Show()
				yellFelChains:Yell()
			end	
		end
		updateRangeFrame(self)
	elseif spellId == 187204 then
		local amount = args.amount or 1
		warnOverwhelmingChaos:Show(amount)
		timerOverwhelmingChaosCD:Start(nil, amount+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 189777 then
		self.vb.EmpFelChainCount = self.vb.EmpFelChainCount - 1
		updateRangeFrame(self)
	end
end

--187196 is usuable with UNIT_SPELLCAST_SUCCEEDED, but it doesn't have which add is coming out, so it'd require a counting variable
--187039 combat log event is usuable for second add but first add doesn't have combat log event
--I just trust INSTANCE_ENCOUNTER_ENGAGE_UNIT more, especially if blizzard screws with hidden events some more
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local uId = "boss"..i
		local unitGUID = UnitGUID(uId)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 94185 then--Vanguard Akkelion
				if self.Options.ChainsBehavior == "Applied" then--Sync timer up with applied
					timerFelChainsCD:Start(15)
				else--Sync tiner up with cast
					timerFelChainsCD:Start(12)
				end
				timerFelBlazeFlurryCD:Start(5.5)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(cid, UnitName(uId))
				end
			elseif cid == 94239 then--Omnus
				timerWitheringGazeCD:Start(4)
				timerBlackHoleCD:Start(18)
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:AddBoss(cid, UnitName(uId))
				end
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 94185 then--Vanguard Akkelion
		timerFelBlazeFlurryCD:Cancel()
		timerFelChainsCD:Cancel()
		if self:IsMythic() then
			timerEmpFelChainsCD:Start(28)
		end
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(cid)
		end
	elseif cid == 94239 then--Omnus
		timerWitheringGazeCD:Cancel()
		timerBlackHoleCD:Cancel()
		if self:IsMythic() then
			timerEmpBlackHoleCD:Start(18)
		end
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(cid)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 187006 then--Activate Void Portal
		voicePhaseChange:Play("phasechange")
		warnVoidPortal:Show()
		if not self:IsLFR() then
			timerVoidsCD:Start(10.5)
			self:Schedule(10.5, VoidsRepeater, self)
		end
	elseif spellId == 187003 then--Activate Fel Portal
		voicePhaseChange:Play("phasechange")
		warnFelPortal:Show()
		if not self:IsLFR() then
			timerImpCD:Start(10)
			countdownImps:Start(10)
			self:Schedule(10, ImpRepeater, self)
		end
	elseif spellId == 187225 then--Phase 2 (Purple Mode)
		self.vb.phase = 2
		timerFelStrikeCD:Cancel()
		timerFelSurgeCD:Cancel()
		countdownFelSurge:Cancel()
		timerVoidStrikeCD:Start(8.5)
		timerVoidSurgeCD:Start(17.8)
		countdownVoidSurge:Start(17.8)
	elseif spellId == 189047 then--Phase 3 (Shadowfel Phasing)
		self.vb.phase = 3
		voicePhaseChange:Play("phasechange")
		timerVoidStrikeCD:Cancel()--Regardless of what was left on timer, he will use it immediately after shadowfel phasing
		timerVoidSurgeCD:Cancel()
		countdownVoidSurge:Cancel()
		timerFelSurgeCD:Start(7)
		countdownFelSurge:Start(7)
		timerFelStrikeCD:Start(8)
		timerVoidSurgeCD:Start(17)--Regardless of what was left on timer, this resets to 17
		countdownVoidSurge:Start(17)
	elseif spellId == 187209 then--Overwhelming Chaos (Activation)
		self.vb.phase = 4
		timerImpCD:Cancel()
		countdownImps:Cancel()
		self:Unschedule(ImpRepeater)
		timerOverwhelmingChaosCD:Start(nil, 1)
	end
end
