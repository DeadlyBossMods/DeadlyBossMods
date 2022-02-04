local mod	= DBM:NewMod(2403, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164967)
mod:SetEncounterID(2384)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 329110 332617 321406",
	"SPELL_CAST_SUCCESS 329217",
	"SPELL_AURA_APPLIED 322410 319070 329110",
	"SPELL_AURA_APPLIED_DOSE 329110"
--	"SPELL_AURA_REMOVED 331967 328175 322410"
--	"SPELL_PERIODIC_DAMAGE 322356",
--	"SPELL_PERIODIC_MISSED 322356"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe warn when oozes spawn after the dispel
--TODO, optimize witchering filt range finder to only be visible of oozes that cast it are up
--TODO, determine if more than tank need to step on the Slithering Oozes and if it deserves a warning or not
--TODO, maybe nameplate icon for https://shadowlands.wowhead.com/spell=320103/metamorphosis Or bar if DBM ever catches up to BW in that regard
--TODO, https://shadowlands.wowhead.com/spell=328662/slime-coated GTFO, get right event
--TODO, https://shadowlands.wowhead.com/spell=321521/congealed-bile infoframe during virulent explosion?
--[[
(ability.id = 329110 or ability.id = 332617 or ability.id = 321406) and type = "begincast"
 or ability.id = 329217 and type = "cast"
--]]
local warnSlimeInjection			= mod:NewStackAnnounce(329110, 2, nil, "Tank|Healer")
local warnSlimeLunge				= mod:NewCountAnnounce(329217, 3)
--Oozes
local warnCorrosiveGunk				= mod:NewTargetAnnounce(319070, 3)
local warnWitheringFilth			= mod:NewTargetNoFilterAnnounce(322410, 3, nil, "Healer", 2)--Not special warning, because it's not as urgent to remove as tank debuff (same dispel type)

--General
local specWarnSlimeLunge			= mod:NewSpecialWarningSpell(321406, nil, nil, nil, 2, 2)
local specWarnSlimeInjection		= mod:NewSpecialWarningDispel(329110, "Healer", nil, 2, 1, 2)
--local specWarnSlitheringOoze		= mod:NewSpecialWarningMoveTo(334579, nil, nil, nil, 1, 2)
local specWarnVirulentExplosion		= mod:NewSpecialWarningSpell(321406, nil, nil, nil, 2, 2)--Change to MoveTo warning for Congealed Bile?
local specWarnPestilenceSurge		= mod:NewSpecialWarningSwitch(332617, "Dps", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(322356, nil, nil, nil, 1, 8)
--Ooze
local specWarnCorrosiveGunk			= mod:NewSpecialWarningDispel(319070, "RemoveDisease", nil, nil, 1, 2)

local timerSlimeLungeCD				= mod:NewCDTimer(37.4, 329217, nil, nil, nil, 3)
local timerSlimeInjectionCD			= mod:NewCDTimer(17, 329110, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--usually massively delayed by slime lunge
--local timerPestilenceSurgeCD		= mod:NewCDTimer(38.1, 332617, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--Too unreliable, 30-80, sometimes not even cast at all
--local timerVirulentExplosion		= mod:NewCastTimer(30, 321406, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--no CD, health based trigger

mod:AddRangeFrameOption(5, 322410)

mod.vb.lungeCount = 0

function mod:OnCombatStart(delay)
	self.vb.lungeCount = 0
	--TODO, fine tune start timers, they are approximations using first MELEE swing of boss since WCL lacked proper start event for encounter
	timerSlimeInjectionCD:Start(9.7-delay)--Too much variation on initial timer, if it acts up again it's being deleted
	timerSlimeLungeCD:Start(33.2-delay)
--	timerPestilenceSurgeCD:Start(40-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
--	if self.Options.NPAuraOnRapidInfection or self.Options.NPAuraOnCongealing then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.NPAuraOnRapidInfection or self.Options.NPAuraOnCongealing then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 329110 then
		timerSlimeInjectionCD:Start()
	elseif spellId == 332617 then
		specWarnPestilenceSurge:Show()
		specWarnPestilenceSurge:Play("killmob")
--		timerPestilenceSurgeCD:Start()
	elseif spellId == 321406 then
		specWarnVirulentExplosion:Show()
		specWarnVirulentExplosion:Play("aesoon")
--		timerVirulentExplosion:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 329217 then
		self.vb.lungeCount = self.vb.lungeCount + 1
		--Comes in sets of 3, special warn for sequence beginning but general announce lunge 2 and 3
		if self.vb.lungeCount == 1 then
			specWarnSlimeLunge:Show()
			specWarnSlimeLunge:Play("watchstep")
			timerSlimeLungeCD:Start(37.6)
		else
			warnSlimeLunge:Show(self.vb.lungeCount)
			if self.vb.lungeCount == 3 then self.vb.lungeCount = 0 end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322410 and self:CheckDispelFilter() then
		warnWitheringFilth:CombinedShow(0.3, args.destName)
	elseif spellId == 319070 then
		if self.Options.SpecWarn319070dispel and self:CheckDispelFilter() then
			specWarnCorrosiveGunk:Show(args.destName)
			specWarnCorrosiveGunk:Play(args.destName)
		else
			warnCorrosiveGunk:Show(args.destName)
		end
	elseif spellId == 329110 then
		if self.Options.SpecWarn329110dispel then
			specWarnSlimeInjection:Show(args.destName)
			specWarnSlimeInjection:Play("helpdispel")
		else
			warnSlimeInjection:Show(args.destName, args.amount or 1)
		end
--	elseif spellId == 331967 then--Rapid Infection Contagion
--		if self.Options.NPAuraOnRapidInfection then
--			DBM.Nameplate:Show(true, args.destGUID, spellId)
--		end
--	elseif spellId == 328175 then--Congealed Contagion
--		if self.Options.NPAuraOnCongealing then
--			DBM.Nameplate:Show(true, args.destGUID, spellId)
--		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 331967 then--Rapid Infection Contagion
--		if self.Options.NPAuraOnRapidInfection then
--			DBM.Nameplate:Hide(true, args.destGUID, spellId)
--		end
	elseif spellId == 328175 then--Congealed Contagion
--		if self.Options.NPAuraOnCongealing then
--			DBM.Nameplate:Hide(true, args.destGUID, spellId)
--		end
--	elseif spellId == 329110 then
--		specWarnSlitheringOoze:Show()
--		specWarnSlitheringOoze:Play("")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 322356 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
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
