local mod	= DBM:NewMod(2140, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(120553)
mod:SetEncounterID(2100)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 270624 275014",
	"SPELL_CAST_START 270185 269266",
	"SPELL_CAST_SUCCESS 274991",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local warnPutridWaters				= mod:NewTargetAnnounce(275014, 2)

local specWarnCalloftheDeep			= mod:NewSpecialWarningDodge(270185, nil, nil, nil, 2, 2)
local yellCrushingEmbrace			= mod:NewYell(270624)
local specWarnPutridWaters			= mod:NewSpecialWarningMoveAway(275014, nil, nil, nil, 1, 2)
local yellPutridWaters				= mod:NewYell(275014)
local specWarnSlam					= mod:NewSpecialWarningDodge(269266, "Tank", nil, 2, 2, 2)

--local timerCalloftheDeepCD			= mod:NewAITimer(13, 270185, nil, nil, nil, 3)--6.4, 15.1, 19.0, 11.9, 12.1, 12.3, 15.6, 12.1, 12.9, 7.0, 8.6, 7.5, 7.2, 7.4, 7.0, 7.0, 7.3, 7.2
local timerPutridWatersCD			= mod:NewCDTimer(19.9, 275014, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON)
local timerSlamCD					= mod:NewCDTimer(7.3, 269266, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDemolisherTerrorCD		= mod:NewCDTimer(20, 270605, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON)

mod:AddRangeFrameOption(5, 275014)

mod.vb.phase = 1
local seenAdds = {}

function mod:OnCombatStart(delay)
	table.wipe(seenAdds)
	self.vb.phase = 1
	timerPutridWatersCD:Start(3.4-delay)
	--timerCalloftheDeepCD:Start(6.4-delay)
	--timerDemolisherTerrorCD:Start(19.9-delay)--Should be started by IEEU event
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	table.wipe(seenAdds)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 270624 and args:IsPlayer() then
		yellCrushingEmbrace:Yell()
	elseif spellId == 275014 then
		if args:IsPlayer() then
			specWarnPutridWaters:Show()
			specWarnPutridWaters:Play("range5")
			yellPutridWaters:Yell()
		else
			warnPutridWaters:CombinedShow(0.3, args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 270185 then
		specWarnCalloftheDeep:Show()
		specWarnCalloftheDeep:Play("watchstep")
		--timerCalloftheDeepCD:Start()
	elseif spellId == 269266 and self:AntiSpam(2.5, 1) then
		specWarnSlam:Show()
		specWarnSlam:Play("shockwave")
		timerSlamCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274991 then
		timerPutridWatersCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 137614 or cid == 137625 or cid == 137626 or cid == 140447 then--Demolishing Terror
		timerSlamCD:Stop(args.destGUID)
	elseif cid == 137405 then--Gripping Terror
		timerDemolisherTerrorCD:Stop()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 137405 then--Gripping Terror
				timerDemolisherTerrorCD:Start(19.9)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 270605 then--Summon Demolisher
		timerDemolisherTerrorCD:Start(20)
	elseif spellId == 269984 then--Damage Boss 35% (can use SPELL_CAST_START of 269456 alternatively)
		--Might actually be at Repair event instead (269366)
		if self.vb.phase < 3 then
			self.vb.phase = self.vb.phase + 1
		end
	end
end
