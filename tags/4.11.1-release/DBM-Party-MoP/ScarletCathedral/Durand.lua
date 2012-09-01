local mod	= DBM:NewMod(674, "DBM-Party-MoP", 9, 316)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7617 $"):sub(12, -3))
mod:SetCreatureID(60040)--3977 is High Inquisitor Whitemane and 60040 is Commander Durand, we don't really need to add her ID, because we don't ever engage her, and he true death is at same time as her.
mod:SetModelID(2043) -- 41220=Durand | 2043=Whitemane

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--local warnRes					= mod:NewCastAnnounce(111670, 4)--This spell seems to be only found in combatlog. Also, I didn't see any casting bar. (both trashes and bosses). Needs more review for this spell.
local warnFlashofSteel			= mod:NewSpellAnnounce(115627, 3)
local warnDashingStrike			= mod:NewSpellAnnounce(115676, 3)
local warnMassRes				= mod:NewCastAnnounce(113134, 4)
local warnDeepSleep				= mod:NewSpellAnnounce(9256, 2)
local warnHeal					= mod:NewCastAnnounce(12039, 4)

local specWarnMassRes			= mod:NewSpecialWarningInterrupt(113134, true)
local specWarnHeal				= mod:NewSpecialWarningInterrupt(12039, true)

local timerFlashofSteel			= mod:NewCDTimer(26, 115627)--not confirmed.
local timerDashingStrike		= mod:NewCDTimer(26, 115676)--not confirmed.
-- At 15799 build, Whitemaine seems to be do not cast Mass Res.
local timerMassResCD			= mod:NewCDTimer(14, 113134)--every 14-17 seconds? (new heroic log doesn't show it cast this often, but i'll leave it for now)
local timerDeepSleep			= mod:NewBuffFadesTimer(10, 9256)

function mod:OnCombatStart(delay)
	timerFlashofSteel:Start(9-delay)
	timerDashingStrike:Start(24-delay)
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
		warnMassRes:Show()
		specWarnMassRes:Show(args.sourceName)
		timerMassResCD:Start()
	elseif args:IsSpellID(12039) then
		warnHeal:Show()
		specWarnHeal:Show(args.sourceName)
	end
end

--Could also use damage overkill like phase 1 but it's only .8 sec faster so no need.
--3/28 16:22:43.001  SWING_DAMAGE,0x0100000000009810,"Omegal",0x511,0x0,0xF1300F8900000065,"High Inquisitor Whitemane",0x10a48,0x0,10172,-1,1,0,0,410,1,nil,nil
--3/28 16:22:43.810  SPELL_CAST_SUCCESS,0xF1300F8900000065,"High Inquisitor Whitemane",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,9256,"Deep Sleep",0x20
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(9256) then--Phase 3
		warnDeepSleep:Show()
		timerDeepSleep:Start()
	end
end

-- this hack also seems to be not working.
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 60040 then--Phase 1 ends when he dies first time, but he doesn't UNIT_DIED first time, there is no other usuable event.
			self:UnregisterShortTermEvents()
			timerMassResCD:Start()
			timerFlashofSteel:Cancel()
			timerDashingStrike:Cancel()
		end
	end
end
mod.SWING_DAMAGE = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 115627 and self:AntiSpam(2, 1) then
		warnFlashofSteel:Show()
		timerFlashofSteel:Start()
	elseif spellId == 115676 and self:AntiSpam(2, 2) then
		warnDashingStrike:Show()
		timerDashingStrike:Start()
	end
end
