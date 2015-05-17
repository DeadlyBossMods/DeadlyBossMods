local mod	= DBM:NewMod(1447, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(94521)--Or 93068
mod:SetEncounterID(1800)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 186271 186453 186292 186783 186546 186490",
	"SPELL_CAST_SUCCESS 186407 186333 187204",
	"SPELL_AURA_APPLIED 186073 186063 186134 186135 188092 186407 186333 186500",
	"SPELL_AURA_APPLIED_DOSE 186073 186063",
--	"SPELL_AURA_REMOVED 186500",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, custom voice for void surge (186333) maybe. Void touched person needs to run into fire on purpose (while making sure not to have any other players nearby), the debuff puts out the fire on ground. So maybe "run into the fire?"
--Fire Phase
----Boss
local warnFelPortal					= mod:NewSpellAnnounce(187003, 2)
local warnFelSurge					= mod:NewTargetAnnounce(186407, 3)
----Adds
local warnFelChains					= mod:NewTargetAnnounce(186490, 3)
--Void Phase
----Boss
local warnVoidPortal				= mod:NewSpellAnnounce(187006, 2)
local warnVoidSurge					= mod:NewTargetAnnounce(186333, 3)
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
----Adds
local specWarnFelBlazeFlurry		= mod:NewSpecialWarningSpell(186453, "Tank")
local specWarnFelChains				= mod:NewSpecialWarningYou(186490)
local yellFelChains					= mod:NewYell(186490)
--Void Phase
----Boss
local specWarnVoidStrike			= mod:NewSpecialWarningSpell(186292, "Tank")
local specWarnVoidSurge				= mod:NewSpecialWarningYou(186333)
local yellVoidSurge					= mod:NewYell(186333)
----Adds
local specWarnWitheringGaze			= mod:NewSpecialWarningSpell(186783, "Tank")
local specWarnBlackHole				= mod:NewSpecialWarningSpell(186546, nil, nil, nil, 2)

--Fire Phase
----Boss
local timerFelStrikeCD				= mod:NewCDTimer(24.5, 186271, nil, "Tank")
local timerFelSurgeCD				= mod:NewCDTimer(30, 186407)
----Big Add
local timerFelBlazeFlurryCD			= mod:NewCDTimer(15.9, 186453, nil, "Tank")
local timerFelChainsCD				= mod:NewCDTimer(15.9, 186490, nil, "-Tank" )
--Void Phase
----Boss
local timerVoidStrikeCD				= mod:NewCDTimer(14.6, 186292, nil, "Tank")--14.6-17
local timerVoidSurgeCD				= mod:NewCDTimer(30.5, 186333)
----Big Add
local timerWitheringGazeCD			= mod:NewCDTimer(14.5, 186783)
local timerBlackHoleCD				= mod:NewCDTimer(29.5, 186546)
--End Phase
local timerOverwhelmingChaosCD		= mod:NewAITimer(10, 187204)--Dungeon journal says every 10 seconds, but lets let the smart timer decide until I can confirm this

--local berserkTimer					= mod:NewBerserkTimer(360)

--local countdownInfernoSlice			= mod:NewCountdown(12, 155080, "Tank")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceFelsinged				= mod:NewVoice(186073)	--run away
local voiceFelSurge					= mod:NewVoice(186407)	--run out (because need to tell difference from run away GTFOs)
local voiceWastingVoid				= mod:NewVoice(186063)  --run away

--Warning behavior choices for Chains.
--Cast only gives original target, not all targets, but does so 3 seconds faster. It allows the person to move early and change other players they affect with chains by pre moving.
--Applied gives all targets, this is the easier strat for most users, where they wait until everyone has it, then run in different directions.
--Both, gives users ALL the information for everything so they can decide on their own. This will be default until I can see what becomes more popular. Maybe both will be what everyone ends up preferring.
mod:AddDropdownOption("ChainsBehavior", {"Cast", "Applied", "Both"}, "Both", "misc")

mod.vb.ChaosCount = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local AddsSeen = {}

function mod:FelChains(targetname, uId)
	if targetname == UnitName("player") then
		specWarnFelChains:Show()
		yellFelChains:Yell()
	else
		warnFelChains:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.ChaosCount = 0
	table.wipe(AddsSeen)
	timerFelStrikeCD:Start(-delay)
	timerFelSurgeCD:Start(21.8-delay)
end

function mod:OnCombatEnd()

end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 186271 then
		timerFelStrikeCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnFelStrike:Show()--So show tank warning
				break
			end
		end
	elseif spellId == 186292 then
		timerVoidStrikeCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnVoidStrike:Show()--So show tank warning
				break
			end
		end
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
	elseif spellId == 186490 then
		if self.Options.ChainsBehavior ~= "Applied" then--Start timer and scanner if method is Both or Cast. Both prefers cast over applied, for the timer.
			timerFelChainsCD:Start()
			self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "FelChains", 0.1, 16)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 186407 then
		timerFelSurgeCD:Start()
	elseif spellId == 186333 then
		timerVoidSurgeCD:Start()
	elseif spellId == 187204 then
		self.vb.ChaosCount = self.vb.ChaosCount + 1
		warnOverwhelmingChaos:Show(self.vb.ChaosCount)
		timerOverwhelmingChaosCD:Start()
	elseif spellId == 186490 then
		if self.Options.ChainsBehavior == "Applied" then--Start timer here if method is set to only applied
			timerFelChainsCD:Start()
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
	elseif spellId == 188092 and not args:IsPlayer() then
		specWarnEmpoweredFelStrike:Show(args.destName)
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
		end
	elseif spellId == 186500 and self.Options.ChainsBehavior ~= "Cast" then--Chains! (show warning if type is applied or both)
		warnFelChains:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelChains:Show()
			yellFelChains:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186500 then

	end
end--]]

--187196 is usuable with UNIT_SPELLCAST_SUCCEEDED, but it doesn't have which add is coming out, so it'd require a counting variable
--187039 combat log event is usuable for second add but first add doesn't have combat log event
--I just trust INSTANCE_ENCOUNTER_ENGAGE_UNIT more, especially if blizzard screws with hidden events some more
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 94185 then--Vanguard Akkelion
				if self.Options.ChainsBehavior == "Applied" then--Sync timer up with applied
					timerFelChainsCD:Start(15)
				else--Sync tiner up with cast
					timerFelChainsCD:Start(12)
				end
				timerFelBlazeFlurryCD:Start(6)
			elseif cid == 94239 then--Omnus
				timerWitheringGazeCD:Start(9)
				timerBlackHoleCD:Start(18)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 94185 then--Vanguard Akkelion
		timerFelBlazeFlurryCD:Cancel()
		timerFelChainsCD:Cancel()
	elseif cid == 94239 then--Omnus
		timerWitheringGazeCD:Cancel()
		timerBlackHoleCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 187006 then--Activate Void Portal
		warnVoidPortal:Show()
	elseif spellId == 187003 then--Activate Fel Portal
		warnFelPortal:Show()
	--Phase events trigger slightly after portal events.
	--Included because until the PHASE events happen, timers do not change
	elseif spellId == 187225 then--Phase 2 (Purple Mode)
		voicePhaseChange:Play("phasechange")
		timerFelStrikeCD:Cancel()
		timerFelSurgeCD:Cancel()
		timerVoidStrikeCD:Start(8.5)
		timerVoidSurgeCD:Start(19)
	elseif spellId == 189047 then--Phase 3 (Shadowfel Phasing)
		voicePhaseChange:Play("phasechange")
		timerFelSurgeCD:Start(7)
		timerFelStrikeCD:Start(8)
	end
end
