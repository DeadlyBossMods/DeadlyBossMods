local mod	= DBM:NewMod("z2680", "DBM-Delves-WarWithin")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

mod:RegisterCombat("scenario", 2680)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 448443 448444 449568",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"UNIT_DIED",
	"ENCOUNTER_START",
	"ENCOUNTER_END",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnCurseOfAgony						= mod:NewSpellAnnounce(448443, 2)
local warnRunicShackles						= mod:NewSpellAnnounce(448444, 2)

local specWarnBurningCart					= mod:NewSpecialWarningDodge(448412, nil, nil, nil, 2, 2)

local timerCurseOfAgonyCD					= mod:NewCDTimer(23.8, 448443, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON)
local timerRunicShacklesCD					= mod:NewCDTimer(35.2, 448444, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON)--Poor Sample size
local timerWebBoltCD						= mod:NewCDTimer(6, 448443, nil, false, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerBurningCartCD					= mod:NewCDTimer(35.2, 448412, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 off interrupt

function mod:SPELL_CAST_START(args)
	if args.spellId == 448443 then
		warnCurseOfAgony:Show()
		timerCurseOfAgonyCD:Start()
	elseif args.spellId == 448444 then
		--22.1, 37.2
		warnRunicShackles:Show()
		timerRunicShacklesCD:Start()
	elseif args.spellId == 449568 then
		timerWebBoltCD:Start()
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

--[[
function mod:UNIT_DIED(args)
	--if args.destGUID == UnitGUID("player") then--Solo scenario, a player death is a wipe

	--end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 208242 then
	end
end
--]]

function mod:ENCOUNTER_START(eID)
	if eID == 2877 then--Web General Ab'enar
		--Start some timers
		timerWebBoltCD:Start(2.2)
		timerCurseOfAgonyCD:Start(7.5)
		timerBurningCartCD:Start(12.3)
		timerRunicShacklesCD:Start(20.8)
	elseif eID == 3005 then--Maklin Drillstab
		DBM:AddMsg("Boss alerts/timers not yet implemented for Maklin Drillstab")
	end
end

function mod:ENCOUNTER_END(eID, _, _, _, success)
	if eID == 2877 then--Web General Ab'enar
		if success then
			DBM:EndCombat(self)
		else
			timerWebBoltCD:Stop()
			timerCurseOfAgonyCD:Stop()
			timerBurningCartCD:Stop()
			timerRunicShacklesCD:Stop()
		end
	elseif eID == 3005 then--Maklin Drillstab
		if success then
			DBM:EndCombat(self)
		else
			--Timers
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 448348 then
		self:SendSync("Cart")
	end
end

function mod:OnSync(msg)
	if msg == "Cart" then
		specWarnBurningCart:Show()
		specWarnBurningCart:Play("watchstep")
		timerBurningCartCD:Start()
	end
end
