local mod	= DBM:NewMod(2157, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131318)
mod:SetEncounterID(2111)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 260879 260894 264757 264603"
)

--TODO, Blood mirror timer
local specWarnBloodBolt				= mod:NewSpecialWarningInterrupt(260879, "HasInterrupt", nil, nil, 1, 2)
local specWarnCreepingRot			= mod:NewSpecialWarningDodge(260894, nil, nil, nil, 2, 2)
local specWarnSanguineFeast			= mod:NewSpecialWarningDodge(264757, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--TODO: Use NewNextSourceTimer to split adds from boss
local timerBloodBoltCD				= mod:NewCDTimer(6.1, 260879, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerCreepingRotCD			= mod:NewNextTimer(15.8, 260894, nil, nil, nil, 3)
local timerSanguineFeastCD			= mod:NewNextTimer(30, 264757, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerBloodMirrorCD			= mod:NewCDTimer(47.4, 264603, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--47.4-49.8

mod:AddInfoFrameOption(260685, "Healer")

function mod:OnCombatStart(delay)
	--timerBloodBoltCD:Start(1-delay)--Instantly
	timerCreepingRotCD:Start(12.2-delay)
	timerBloodMirrorCD:Start(15.8-delay)
	if not self:IsNormal() then--Exclude normal, but allow heroic/mythic/mythic+
		timerSanguineFeastCD:Start(6.8-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(260685))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 260685, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260879 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBloodBolt:Show(args.sourceName)
		specWarnBloodBolt:Play("kickcast")
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 131318 then--Main boss
			timerBloodBoltCD:Start()
		else

		end
	elseif spellId == 260894 and self:AntiSpam(3, 1) then
		specWarnCreepingRot:Show()
		specWarnCreepingRot:Play("watchwave")
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 131318 then--Main boss
			timerCreepingRotCD:Start()
		else

		end
	elseif spellId == 264757 then
		specWarnSanguineFeast:Show()
		specWarnSanguineFeast:Play("watchstep")
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 131318 then--Main boss
			timerSanguineFeastCD:Start()
		else

		end
	elseif spellId == 264603 then
		timerBloodMirrorCD:Start()
	end
end
