local mod	= DBM:NewMod(866, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72276)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--Amalgam of Corruption
local warnUnleashedAnger				= mod:NewSpellAnnounce(145216, 2, nil, mod:IsTank())
local warnBlindHatred					= mod:NewSpellAnnounce(145226, 3)
--Test of Serenity (DPS)
local warnTearReality					= mod:NewCastAnnounce(144482, 3)
--local warnExpelCorruptionDPS			= mod:NewCastAnnounce(144479, 3)--spellid probably wrong. there are 3 of them (and for a fact two diff versions of spell, dps and healer)
--Test of Reliance (Healer)
--local warnStrikeBehind				= mod:NewSpellAnnounce(144512, 3)--Spellid is VERY likely wrong.
local warnLingeringCorruption			= mod:NewTargetAnnounce(144514, 3)
local warnBurstOfCorruption				= mod:NewSpellAnnounce(144654, 3)--Spammy? Also, same version as tank, or do tanks use 144507?
--Test of Confidence (tank)
local warnTitanicSmash					= mod:NewSpellAnnounce(144628, 4)
local warnHurlCorruption				= mod:NewSpellAnnounce(144649, 4)
local warnPiercingCorruption			= mod:NewSpellAnnounce(144657, 4)

--Amalgam of Corruption
--local specWarnBlindHatred				= mod:NewSpecialWarningMove(145227)
--All tests
--Test of Serenity (DPS)
local specWarnTearReality				= mod:NewSpecialWarningSpell(144482)
--local specWarnExpelCorruptionDPS		= mod:NewSpecialWarningSpell(144479)
--Test of Reliance (Healer)
local specWarnLingeringCorruption		= mod:NewSpecialWarningDispel(144514)
--local specWarnExpelCorruptionHealer	= mod:NewSpecialWarningSpell(144479)
--Test of Confidence (tank)
local specWarnTitanicSmash				= mod:NewSpecialWarningMove(144628)
local specWarnHurlCorruption			= mod:NewSpecialWarningInterrupt(144649)
local specWarnPiercingCorruption		= mod:NewSpecialWarningSpell(144657)

--Amalgam of Corruption
--local timerUnleashedAngerCD			= mod:NewCDTimer(10, 145216, mod:IsTank())
--local timerBlindHatredCD				= mod:NewCDTimer(70, 145226)
--local timerDespairCD					= mod:NewCDTimer(70, 145725)
--Test of Serenity (DPS)
--local timerTearRealityCD				= mod:NewCDTimer(10, 144482)
--local timerTearExpelCorruptionDPSCD	= mod:NewCDTimer(10, 144479)
--Test of Reliance (Healer)
--local timerStrikeBehindCD				= mod:NewCDTimer(10, 144512)
--local timerLingeringCorruptionCD		= mod:NewCDTimer(10, 144514)
--local timerLingeringCorruptionHealerCD= mod:NewCDTimer(10, 144514)
--Test of Confidence (tank)
--local timerTitanicSmashCD				= mod:NewCDTimer(25, 144628)
--local timerHurlCorruptionCD			= mod:NewCDTimer(25, 144649)

local berserkTimer						= mod:NewBerserkTimer(420)--EJ says fight has a 7 min berserk (how convinient).

mod:AddBoolOption("InfoFrame")

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader("Corruption")--Will localize later, just want this in before test in a few min
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 145216 then
		warnUnleashedAnger:Show()
--		timerUnleashedAngerCD:Start()
	elseif args.spellId == 145226 then
		warnBlindHatred:Show()
--		timerBlindHatredCD:Start()
	elseif args.spellId == 144482 then
		warnTearReality:Show()
		specWarnTearReality:Show()
--		timerTearRealityCD:Start()
	elseif args.spellId == 144479 or args.spellId == 144548 or args.spellId == 145064 then
		print("DBM DEBUG: Expel corruption cast. Tell dbm guy if you're dps, tank or healer and give them this ID: ", args.spellId)
--		warnExpelCorruption:Show()
--		specWarnExpelCorruption:Show()

--		timerTearExpelCorruptionCD:Start()
	elseif args.spellId == 144654 then
		warnBurstOfCorruption:Show()
	elseif args.spellId == 144628 then
		warnTitanicSmash:Show()
		specWarnTitanicSmash:Show()
--		timerTitanicSmashCD:Start()
	elseif args.spellId == 144649 then
		warnHurlCorruption:Show()
		specWarnHurlCorruption:Show()
--		timerHurlCorruptionCD:Start()
	elseif args.spellId == 144657 then
		warnPiercingCorruption:Show()
		specWarnPiercingCorruption:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144514 then
		warnLingeringCorruption:Show(args.destName)
		specWarnLingeringCorruption:Show(args.destName)
--		timerLingeringCorruptionCD:Start()
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 145725 then
		timerDespair:Cancel(args.destName)
	elseif args.spellId == 144728 and args:IsPlayer() then
		timerDespairActive:Cancel()
		countdownDespair:Cancel()
	end
end--]]
