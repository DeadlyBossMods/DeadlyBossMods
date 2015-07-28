local mod	= DBM:NewMod(966, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76141)
mod:SetEncounterID(1699)--Verify, name doesn't match
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154110 154113 154135",
	"SPELL_AURA_APPLIED 154159"
)


--Add smash? it's a 1 sec cast, can it be dodged?
local warnEnergize		= mod:NewSpellAnnounce(154159, 3)

local specWarnBurst		= mod:NewSpecialWarningCount(154135, nil, nil, nil, 2)
local specWarnSmash		= mod:NewSpecialWarningDodge(154110, "Tank", nil, 2)

local timerEnergozeCD	= mod:NewNextTimer(20, 154159, nil, nil, nil, 5)
local timerBurstCD		= mod:NewCDCountTimer(23, 154135, nil, nil, nil, 2)

mod.vb.burstCount = 0
local skyTrashMod = DBM:GetModByName("SkyreachTrash")

function mod:OnCombatStart(delay)
	self.vb.burstCount = 0
	timerBurstCD:Start(20-delay, 1)
	if skyTrashMod.Options.RangeFrame and skyTrashMod.vb.debuffCount ~= 0 then--In case of bug where range frame gets stuck open from trash pulls before this boss.
		skyTrashMod.vb.debuffCount = 0--Fix variable
		DBM.RangeCheck:Hide()--Close range frame.
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 154135 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnBurst:Show(self.vb.burstCount)
		timerBurstCD:Start(nil, self.vb.burstCount+1)
	elseif args:IsSpellID(154110, 154113) then
		specWarnSmash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 154159 and self:AntiSpam(2, 1) then
		warnEnergize:Show()
		timerEnergozeCD:Start()
	end
end
