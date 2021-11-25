local mod	= DBM:NewMod(2391, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(163157)--162692?
mod:SetEncounterID(2388)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 320012",
	"SPELL_CAST_START 322493 321247 320170 333488",
	"SPELL_CAST_SUCCESS 321226 320012",
	"SPELL_SUMMON 333627"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, which interrupt is priority?
--[[
(ability.id = 321247 or ability.id = 333488) and type = "begincast"
 or (ability.id = 321226 or ability.id = 320012) and type = "cast"
 or (ability.id = 322493 or ability.id = 320170) and type = "begincast"
--]]
local specWarnLandoftheDead			= mod:NewSpecialWarningSwitch(321226, "-Healer", nil, nil, 1, 2)
local specWarnFinalHarvest			= mod:NewSpecialWarningDodge(321247, nil, nil, nil, 2, 2)
local specWarnNecroticBreath		= mod:NewSpecialWarningDodge(333493, nil, nil, nil, 2, 2)
--local yellNecroticBreath			= mod:NewYell(333493)
local specWarnNecroticBolt			= mod:NewSpecialWarningInterrupt(320170, false, nil, 2, 1, 2)--Every 5 seconds, so off by default
local specWarnUnholyFrenzy			= mod:NewSpecialWarningDispel(320012, "RemoveEnrage", nil, nil, 1, 2)
local specWarnUnholyFrenzyTank		= mod:NewSpecialWarningDefensive(320012, "Tank", nil, nil, 1, 2)
--Reanimated Mage
local specWarnFrostboltVolley		= mod:NewSpecialWarningInterrupt(322493, "HasInterrupt", nil, nil, 1, 2)--Mythic and above, normal/heroic uses regular frostbolts
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerLandoftheDeadCD			= mod:NewCDTimer(41.2, 321226, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--41.2-48.4
local timerFinalHarvestCD			= mod:NewCDTimer(41.2, 321247, nil, nil, nil, 2)--41.2-48.4
local timerNecroticBreathCD			= mod:NewCDTimer(41.2, 333493, nil, nil, nil, 3)--41.2-48.4
local timerUnholyFrenzyCD			= mod:NewCDTimer(41.2, 320012, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON..DBM_COMMON_L.TANK_ICON)--41.2-48.4

mod:AddSetIconOption("SetIconOnAdds", 321226, true, true, {1, 2, 3, 4, 5, 6, 7, 8})

mod.vb.iconCount = 8

function mod:OnCombatStart(delay)
	--TODO, fine tune start times, started from first melee swing not ENCOUNTER_START
	self.vb.iconCount = 8
	timerUnholyFrenzyCD:Start(6-delay)--SUCCESS
	timerLandoftheDeadCD:Start(8.6-delay)--SUCCESS
	timerNecroticBreathCD:Start(29.4-delay)
	timerFinalHarvestCD:Start(38.6-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322493 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostboltVolley:Show(args.sourceName)
		specWarnFrostboltVolley:Play("kickcast")
	elseif spellId == 320170 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNecroticBolt:Show(args.sourceName)
		specWarnNecroticBolt:Play("kickcast")
	elseif spellId == 321247 then
		specWarnFinalHarvest:Show()
		specWarnFinalHarvest:Play("watchstep")
		timerFinalHarvestCD:Start()
	elseif spellId == 333488 then
		specWarnNecroticBreath:Show()
		specWarnNecroticBreath:Play("breathsoon")
		timerNecroticBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 321226 then
		specWarnLandoftheDead:Show()
		specWarnLandoftheDead:Play("killmob")
		timerLandoftheDeadCD:Start()
	elseif spellId == 320012 then
		timerUnholyFrenzyCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 333627 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 164414 then--Auto mark mages
			if self.Options.SetIconOnAdds then--Only use up to 5 icons
				self:ScanForMobs(args.destGUID, 2, self.vb.iconCount, 1, nil, 12, "SetIconOnAdds")
			end
			self.vb.iconCount = self.vb.iconCount - 1
			if self.vb.iconCount == 0 then
				self.vb.iconCount = 8
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320012 then
		if self.Options.SpecWarn320012dispel then
			specWarnUnholyFrenzy:Show(args.destName)
			specWarnUnholyFrenzy:Play("enrage")
		else
			specWarnUnholyFrenzyTank:Show()
			specWarnUnholyFrenzyTank:Play("defensive")
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
