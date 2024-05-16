local mod	= DBM:NewMod("DelveTrashCommon", "DBM-Delves-WarWithin")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)--Stays active in all zones for zone change handlers, but registers events based on dungeon ids

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"LOADING_SCREEN_DISABLED"
)

--TODO Add Void Bolt interrupt. it hits for 1.4 Million on level 2
local warnShadowsofStrife					= mod:NewCastAnnounce(449318, 3)--High Prio Interrupt
local warnWebbedAegis						= mod:NewCastAnnounce(450546, 3)--Can only be CCed

local specWarnFearfulShriek					= mod:NewSpecialWarningDodge(433410, nil, nil, nil, 2, 2)
local specWarnJaggedBarbs					= mod:NewSpecialWarningDodge(450714, nil, nil, nil, 2, 2)
local specWarnLavablast	    				= mod:NewSpecialWarningDodge(445781, nil, nil, nil, 2, 2)
local specWarnShadowsofStrife				= mod:NewSpecialWarningInterrupt(449318, "HasInterrupt", nil, nil, 1, 2)--High Prio Interrupt

local timerShadowsofStrifeCD				= mod:NewCDNPTimer(12.4, 449318, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--12.4-15.1
local timerWebbedAegisCD					= mod:NewCDNPTimer(23.1, 450546, nil, nil, nil, 5)
local timerLavablastCD					    = mod:NewCDNPTimer(15.8, 445781, nil, nil, nil, 3)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 off interrupt

do
	local validZones = {[2664] = true, [2679] = true, [2680] = true, [2681] = true, [2682] = true, [2683] = true, [2684] = true, [2685] = true, [2686] = true, [2687] = true, [2688] = true, [2689] = true, [2690] = true, [2767] = true, [2768] = true}
	local eventsRegistered = false
	function mod:DelayedZoneCheck(force)
		local currentZone = DBM:GetCurrentArea() or 0
		if not force and validZones[currentZone] and not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents(
                "SPELL_CAST_START 449318 450546 433410 450714 445781",
                --"SPELL_CAST_SUCCESS",
                --"SPELL_AURA_APPLIED",
                --"SPELL_AURA_REMOVED",
                --"SPELL_PERIODIC_DAMAGE",
                "UNIT_DIED"
			)
			DBM:Debug("Registering Delve events")
		elseif force or (not validZones[currentZone] and eventsRegistered) then
			eventsRegistered = false
			self:UnregisterShortTermEvents()
			self:Stop()
			DBM:Debug("Unregistering Delve events")
		end
	end
	function mod:LOADING_SCREEN_DISABLED()
		self:UnscheduleMethod("DelayedZoneCheck")
		--Checks Delayed 1 second after core checks to prevent race condition of checking before core did and updated cached ID
		self:ScheduleMethod(6, "DelayedZoneCheck")
	end
	mod.OnInitialize = mod.LOADING_SCREEN_DISABLED
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 449318 then
		timerShadowsofStrifeCD:Start(nil, args.sourceGUID)
		if self.Options.SpecWarn449318interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShadowsofStrife:Show(args.sourceName)
			specWarnShadowsofStrife:Play("kickcast")
		elseif self:AntiSpam(3, 7) then
			warnShadowsofStrife:Show()
		end
	elseif args.spellId == 450546 then
		timerWebbedAegisCD:Start(nil, args.sourceGUID)
		if self:AntiSpam(3, 6) then
			warnWebbedAegis:Show()
			warnWebbedAegis:Play("crowdcontrol")
		end
	elseif args.spellId == 433410 then
		if self:AntiSpam(3, 2) then
			specWarnFearfulShriek:Show()
			specWarnFearfulShriek:Play("watchstep")
		end
	elseif args.spellId == 450714 then
		if self:AntiSpam(3, 2) then
			specWarnJaggedBarbs:Show()
			specWarnJaggedBarbs:Play("shockwave")
		end
	elseif args.spellId == 445781 then
        timerLavablastCD:Start(nil, args.sourceGUID)
		if self:AntiSpam(3, 2) then
			specWarnLavablast:Show()
			specWarnLavablast:Play("shockwave")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138680 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138561 and destGUID == UnitGUID("player") and self:AntiSpam() then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 208242 then--Nerubian Darkcaster
		timerShadowsofStrifeCD:Stop(args.destGUID)
	elseif cid == 216584 then--Nerubian Captain
		timerWebbedAegisCD:Stop(args.destGUID)
    elseif cid == 223541 then--Stolen Loader
        timerLavablastCD:Stop(args.destGUID)
	end
end
