local mod	= DBM:NewMod(674, "DBM-Party-MoP", 9, 316)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60040, 99999)--3977 is High Inquisitor Whitemane and 60040 is Commander Durand, we don't really need to add her ID, because we don't ever engage her, and he true death is at same time as her.
mod:SetEncounterID(1425)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_DIED"
)

--local warnRes					= mod:NewCastAnnounce(111670, 4)--This spell seems to be only found in combatlog. Also, I didn't see any casting bar. (both trashes and bosses). Needs more review for this spell.
local warnFlashofSteel			= mod:NewSpellAnnounce(115627, 3)
local warnDashingStrike			= mod:NewSpellAnnounce(115676, 3)
local warnMassRes				= mod:NewCastAnnounce(113134, 4)
local warnDeepSleep				= mod:NewSpellAnnounce(9256, 2)
local warnHeal					= mod:NewCastAnnounce(12039, 3)
local warnMC					= mod:NewCastAnnounce(130857, 4)--Challenge mode only ability

local specWarnMassRes			= mod:NewSpecialWarningInterrupt(113134, true)
local specWarnHeal				= mod:NewSpecialWarningInterrupt(12039, true)
local specWarnMC				= mod:NewSpecialWarningInterrupt(130857, true)

local timerFlashofSteel			= mod:NewCDTimer(26, 115627)--not confirmed.
local timerDashingStrike		= mod:NewCDTimer(26, 115676)--not confirmed.
local timerMassResCD			= mod:NewCDTimer(21, 113134)--21-24sec variation. Earlier if phase transitions
local timerDeepSleep			= mod:NewBuffFadesTimer(10, 9256)
local timerMCCD					= mod:NewCDTimer(19, 130857)

local phase = 1

function mod:OnCombatStart(delay)
	phase = 1
	timerFlashofSteel:Start(9-delay)
	timerDashingStrike:Start(24-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 113134 then
		warnMassRes:Show()
		specWarnMassRes:Show(args.sourceName)
		timerMassResCD:Start()
	elseif args.spellId == 12039 then
		warnHeal:Show()
		specWarnHeal:Show(args.sourceName)
	elseif args.spellId == 130857 then
		warnMC:Show()
		specWarnMC:Show(args.sourceName)
	end
end

--Could also use damage overkill like phase 1 but it's only .8 sec faster so no need.
--3/28 16:22:43.001  SWING_DAMAGE,0x0100000000009810,"Omegal",0x511,0x0,0xF1300F8900000065,"High Inquisitor Whitemane",0x10a48,0x0,10172,-1,1,0,0,410,1,nil,nil
--3/28 16:22:43.810  SPELL_CAST_SUCCESS,0xF1300F8900000065,"High Inquisitor Whitemane",0xa48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,9256,"Deep Sleep",0x20
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 9256 then--Phase 3
		phase = 3
		warnDeepSleep:Show()
		timerDeepSleep:Start()
		timerMassResCD:Start(18)--Limited Sample size
		if self:IsDifficulty("challenge5") then
			timerMCCD:Start(19)--Pretty much immediately after first mas res, unless mass res isn't interrupted then it'll delay MC
		end
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 115627 and self:AntiSpam(2, 1) then
		warnFlashofSteel:Show()
		timerFlashofSteel:Start()
	elseif spellId == 115676 and self:AntiSpam(2, 2) then
		warnDashingStrike:Show()
		timerDashingStrike:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 60040 then
		if phase == 3 then--Fight is over on 2nd death
			DBM:EndCombat(self)
		else--it's first death, he's down and whiteman is taking over
			phase = 2
			timerMassResCD:Start(13)
			if self:IsDifficulty("challenge5") then
				timerMCCD:Start(14)
			end
			timerFlashofSteel:Cancel()
			timerDashingStrike:Cancel()
		end
	end
end
