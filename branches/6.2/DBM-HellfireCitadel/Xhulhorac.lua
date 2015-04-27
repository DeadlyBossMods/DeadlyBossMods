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
	"SPELL_CAST_START 186271 186453 186292 186783 186546",
	"SPELL_CAST_SUCCESS 186407 186490 186333 187204",
	"SPELL_AURA_APPLIED 186073 186063 186134 186135 188092 186407 186333",
	"SPELL_AURA_APPLIED_DOSE 186073 186063 186490",
--	"SPELL_AURA_REMOVED 186490",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe a custom info frame that shows up to 3 players of each debuff "Feltouched" and "voidtouched". 6 total is enough. Players that are fire will be orange, players void will be purple.
--TODO, do fel/void timers combine for surge and strike?
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
local specWarnFelsinged				= mod:NewSpecialWarningMove(186073)
local specWarnVoidTouched			= mod:NewSpecialWarningYou(186135, false)
local specWarnWastingVoid			= mod:NewSpecialWarningMove(186063)
--Fire Phase
----Boss
local specWarnFelStrike				= mod:NewSpecialWarningSpell(186271, "Tank")
local specWarnEmpoweredFelStrike	= mod:NewSpecialWarningTaunt(188092, false)--Maybe redundant
local specWarnFelSurge				= mod:NewSpecialWarningYou(186407)
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
local timerFelStrikeCD				= mod:NewAITimer(107, 186271, nil, "Tank")
local timerFelSurgeCD				= mod:NewAITimer(107, 186407)
----Adds
local timerFelBlazeFlurryCD			= mod:NewAITimer(107, 186453, nil, "Tank")
local timerFelChainsCD				= mod:NewAITimer(107, 186490 )--Exlude tank?
--Void Phase
----Boss
local timerVoidStrikeCD				= mod:NewAITimer(107, 186292, nil, "Tank")
local timerVoidSurgeCD				= mod:NewAITimer(107, 186333)
----Adds
local timerWitheringGazeCD			= mod:NewAITimer(107, 186783)
local timerBlackHoleCD				= mod:NewAITimer(107, 186546)
--End Phase
local timerOverwhelmingChaosCD		= mod:NewAITimer(10, 187204)--Dungeon journal says every 10 seconds, but lets let the smart timer decide until I can confirm this

--local berserkTimer					= mod:NewBerserkTimer(360)

--local countdownInfernoSlice			= mod:NewCountdown(12, 155080, "Tank")

--local voiceInfernoSlice				= mod:NewVoice(155080)

--mod:AddRangeFrameOption(8, 155530)

mod.vb.ChaosCount = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local AddsSeen = {}

--[[
local debuffFilter
do
	local debuffName = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end--]]

function mod:OnCombatStart(delay)
	self.vb.ChaosCount = 0
	table.wipe(AddsSeen)
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)
	timerFelStrikeCD:Start(1-delay)
	timerFelSurgeCD:Start(1-delay)
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 186407 then
		timerFelSurgeCD:Start()
	elseif spellId == 186490 then
		timerFelChainsCD:Start()
	elseif spellId == 186333 then
		timerVoidSurgeCD:Start()
	elseif spellId == 187204 then
		self.vb.ChaosCount = self.vb.ChaosCount + 1
		warnOverwhelmingChaos:Show(self.vb.ChaosCount)
		timerOverwhelmingChaosCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 186063 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnWastingVoid:Show()
	elseif spellId == 186073 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnFelsinged:Show()
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
		end
	elseif spellId == 186333 then
		warnVoidSurge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVoidSurge:Show()
			yellVoidSurge:Yell()
		end
	elseif spellId == 186490 then--Chains!
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
	if spellId == 186490 then

	end
end--]]

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 94185 then--Vanguard Akkelion
				timerFelBlazeFlurryCD:Start(1)
				timerFelChainsCD:Start(1)
			elseif cid == 94239 then--Omnus
				timerWitheringGazeCD:Start(1)
				timerBlackHoleCD:Start(1)
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
	if spellId == 187006 then--Activate Void Portal (guessed)
		warnVoidPortal:Show()
		timerFelStrikeCD:Cancel()
		timerFelSurgeCD:Cancel()
		timerVoidStrikeCD:Start(1)
		timerVoidSurgeCD:Start(1)
	elseif spellId == 187013 then--Void Portal Active
		
	elseif spellId == 187003 then--Activate Fel Portal
		warnFelPortal:Show()
		--Mayte start fel strike timer here instead?
	elseif spellId == 187012 then--Fel Portal Active
		
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
