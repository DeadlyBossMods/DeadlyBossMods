local mod	= DBM:NewMod(859, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71954)
mod:SetMinSyncRevision(10162)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnHeadbutt				= mod:NewSpellAnnounce(144610, 3, nil, mod:IsTank())
local warnOxenFortitude			= mod:NewStackAnnounce(144606, 2)--144607 player version, but better to just track boss and announce stacks
local warnMassiveQuake			= mod:NewSpellAnnounce(144611, 3)
local warnCharge				= mod:NewSpellAnnounce(144609, 4)

local specWarnHeadbutt			= mod:NewSpecialWarningSpell(144610, mod:IsTank())
local specWarnMassiveQuake		= mod:NewSpecialWarningCast(144611, mod:IsHealer())
local specWarnCharge			= mod:NewSpecialWarningSpell(144609, nil, nil, nil, 2)--66 and 33%. Maybe add pre warns

local timerHeadbuttCD			= mod:NewCDTimer(47, 144610, nil, mod:IsTank())
local timerMassiveQuakeCD		= mod:NewCDTimer(48, 144611)

local yellTriggered = false

function mod:OnCombatStart(delay)
	if yellTriggered then
		timerHeadbuttCD:Start(16-delay)
		timerMassiveQuakeCD:Start(45-delay)
	end
end

function mod:OnCombatEnd()
	yellTriggered = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144610 then
		warnHeadbutt:Show()
		specWarnHeadbutt:Show()
		timerHeadbuttCD:Start()
	elseif args.spellId == 144611 then
		warnMassiveQuake:Show()
		specWarnMassiveQuake:Show()
		timerMassiveQuakeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144609 then
		warnCharge:Show()
		specWarnCharge:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144606 then
		warnOxenFortitude:Show(args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Victory or msg == L.VictoryDem then
		self:SendSync("Victory")
	elseif msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 71954 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 71954 then
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end
