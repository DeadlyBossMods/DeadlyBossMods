local mod	= DBM:NewMod(686, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7726 $"):sub(12, -3))
mod:SetCreatureID(56884)
mod:SetModelID(41121)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnRingofMalice		= mod:NewSpellAnnounce(131521, 3)
local warnGrippingHatred	= mod:NewSpellAnnounce(115002, 2)
local warnHazeofHate		= mod:NewTargetAnnounce(107087, 4)

local specWarnGrippingHatred= mod:NewSpecialWarningSwitch("ej5817")
local specWarnHazeofHate	= mod:NewSpecialWarningYou(107087)

local timerRingofMalice		= mod:NewBuffActiveTimer(15, 131521)

-- info frame stuff not confirmed
mod:AddBoolOption("InfoFrame", true)

local Hate = EJ_GetSectionInfo(5827)

function mod:OnCombatStart(delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(Hate)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(131521) then
		warnRingofMalice:Show()
		timerRingofMalice:Start()
	elseif args:IsSpellID(107087) then
		warnHazeofHate:Show(args.destName)
		if args:IsPlayer() then
			specWarnHazeofHate:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(115002) then
		warnGrippingHatred:Show()
		specWarnGrippingHatred:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125891 and self:AntiSpam(2) then
		DBM:EndCombat(self)
	end
end