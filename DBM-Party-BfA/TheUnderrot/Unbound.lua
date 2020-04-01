local mod	= DBM:NewMod(2158, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(133007)
mod:SetEncounterID(2123)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 269843 269310",
	"SPELL_PERIODIC_DAMAGE 269838",
	"SPELL_PERIODIC_MISSED 269838",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, target scanning cleansing light?
--TODO, verify GTFO
local warnVisage					= mod:NewAddsLeftAnnounce("ej18312", 2, 269692)

local specWarnBloodVisage			= mod:NewSpecialWarningSwitch("ej18312", "-Healer", nil, nil, 1, 2)
local specWarnVileExpulsion			= mod:NewSpecialWarningDodge(269843, nil, nil, nil, 2, 2)
local specWarnCleansingLight		= mod:NewSpecialWarningSpell(269310, nil, nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(269838, nil, nil, nil, 1, 8)

local timerBloodVisageCD			= mod:NewCDTimer(15.7, "ej18312", nil, nil, nil, 1, 269692)
local timerVileExpulsionCD			= mod:NewNextTimer(15.7, 269843, nil, nil, nil, 3)
local timerCleansingLightCD			= mod:NewCDTimer(23.7, 269310, nil, nil, nil, 5)--23-37

mod:AddInfoFrameOption(269301, "Healer")

mod.vb.remainingAdds = 6
local vileExpulsion = DBM:GetSpellInfo(269843)

function mod:OnCombatStart(delay)
	self.vb.remainingAdds = 6
	timerVileExpulsionCD:Start(8.2-delay)
	timerCleansingLightCD:Start(18.2-delay)
	timerBloodVisageCD:Start(22.3-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(269301))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 269301, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 269843 then
		specWarnVileExpulsion:Show()
		specWarnVileExpulsion:Play("watchwave")
		timerVileExpulsionCD:Start()
	elseif spellId == 269310 then
		specWarnCleansingLight:Show()
		specWarnCleansingLight:Play("gathershare")
		timerCleansingLightCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 269838 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 137103 then--Visage
		self.vb.remainingAdds = self.vb.remainingAdds - 1
		warnVisage:Show(self.vb.remainingAdds)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 272663 and self:AntiSpam(2, 1) then--Blood Clone Cosmetic
		specWarnBloodVisage:Show()
		specWarnBloodVisage:Play("killmob")
		timerBloodVisageCD:Start(31.5)
	end
end
