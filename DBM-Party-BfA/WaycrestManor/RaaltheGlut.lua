local mod	= DBM:NewMod(2127, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131863)
mod:SetEncounterID(2115)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 264931 264923 264694",
	"SPELL_DAMAGE 264698",
	"SPELL_MISSED 264698"
)

--TODO, run dungeon to get NEW tenderize timers post hotfix
local warnTenderize					= mod:NewCountAnnounce(264923, 2)

local specWarnServant				= mod:NewSpecialWarningSwitch(264931, nil, nil, nil, 1, 2)
local specWarnTenderize				= mod:NewSpecialWarningDodge(264923, nil, nil, nil, 1, 2)
local specWarnRottenExpulsion		= mod:NewSpecialWarningDodge(264694, nil, nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(264698, nil, nil, nil, 1, 8)

--local timerServantCD				= mod:NewNextTimer(13, 264931, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--local timerTenderizeCD				= mod:NewNextTimer(29.2, 264923, nil, nil, nil, 3)--Timer for first in each set of 3
local timerRottenExpulsionCD		= mod:NewCDTimer(14.6, 264694, nil, nil, nil, 3)--14.6--26 (health based?)

--mod:AddRangeFrameOption(5, 194966)

mod.vb.tenderizeCount = 0

function mod:OnCombatStart(delay)
	self.vb.tenderizeCount = 0
	--timerServantCD:Start(43.7-delay)--Verify not health based
	timerRottenExpulsionCD:Start(5-delay)
	--timerTenderizeCD:Start(-delay)--Also 29.2
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 264931 then
		local bossHealth = self:GetBossHP(args.sourceGUID)
		if bossHealth and bossHealth >= 10 then--Only warn to switch to add if boss above 10%, else ignore them
			specWarnServant:Show()
			specWarnServant:Play("killmob")
		end
		--timerServantCD:Start()
	elseif spellId == 264923 then
		self.vb.tenderizeCount = self.vb.tenderizeCount + 1
		if self.vb.tenderizeCount == 1 then
			specWarnTenderize:Show()
			specWarnTenderize:Play("shockwave")
			--timerTenderizeCD:Start()
		else
			warnTenderize:Show(self.vb.tenderizeCount)
		end
		if self.vb.tenderizeCount == 3 then
			self.vb.tenderizeCount = 0
		end
	elseif spellId == 264694 then
		specWarnRottenExpulsion:Show()
		specWarnRottenExpulsion:Play("watchstep")
		timerRottenExpulsionCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 264698 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
