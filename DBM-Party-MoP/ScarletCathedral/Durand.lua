local mod	= DBM:NewMod(674, "DBM-Party-MoP", 9, 316)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60040)--3977 is High Inquisitor Whitemane and 60040 is Commander Durand, we don't really need to add her ID, because we don't ever engage her, and he true death is at same time as her.
--mod:SetModelID(41220) -- 41220=Durand | 2043=Whitemane

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS"
)

local warnRes					= mod:NewCastAnnounce(111216, 4)
local warnMassRes				= mod:NewCastAnnounce(111216, 4)
local warnDeepSleep				= mod:NewSpellAnnounce(9256, 2)

local specWarnRes				= mod:NewSpecialWarningInterrupt(111670, true)--Trash mobs before this boss have a res spell that needs warnings too, especially if you screw up and let her rez them with mass rez and join the boss fight after the fact.
local specWarnMassRes			= mod:NewSpecialWarningInterrupt(111216, true)

local timerMassResCD			= mod:NewCDTimer(14, 111216)--every 14-17 seconds
local timerDeepSleep			= mod:NewBuffFadesTimer(10, 111216)

function mod:OnCombatStart(delay)
	--Only need these in phase 1 so no sense in wasting cpu in phase 2 and 3.
	self:RegisterShortTermEvents(
		"SPELL_DAMAGE",
		"SWING_DAMAGE",
		"SPELL_PERIODIC_DAMAGE",
		"RANGE_DAMAGE"
	)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(113134) then
		warnRes:Show()
		specWarnRes:Show(args.sourceName)
	elseif args:IsSpellID(113134) then
		warnMassRes:Show()
		specWarnMassRes:Show(args.sourceName)
		timerMassResCD:Start()
	end
end

--Could also use damage overkill like phase 1 but it's only .8 sec faster so no need.
--3/28 16:22:43.001  SWING_DAMAGE,0x0100000000009810,"Omegal",0x511,0x0,0xF1300F8900000065,"High Inquisitor Whitemane",0x10a48,0x0,10172,-1,1,0,0,410,1,nil,nil
--3/28 16:22:43.810  SPELL_CAST_SUCCESS,0xF1300F8900000065,"High Inquisitor Whitemane",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,9256,"Deep Sleep",0x20
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(9232) then--Phase 3
		warnDeepSleep:Show()
		timerDeepSleep:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 60040 then--Phase 1 ends when he dies first time, but he doesn't UNIT_DIE first time, there is no other usuable event.
			self:UnregisterShortTermEvents()
			timerMassResCD:Start()
		end
	end
end
mod.SWING_DAMAGE = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE
