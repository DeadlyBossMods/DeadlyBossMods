local mod	= DBM:NewMod(1904, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(119542)--119883 Fel Portal Guardian 118834
mod:SetEncounterID(2053)
mod:SetZone()
--mod:SetHotfixNoticeRev(15186)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 236543 234107 241622",
	"SPELL_CAST_SUCCESS 234107",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, other warnings? portal spawns/phases?
--TODO, announce portal guardians, they fire UNIT_TARGETABLE_CHANGED (maybe other things?)
local warnApproachingDoom			= mod:NewCastAnnounce(241622, 2)

local specWarnFelsoulCleave			= mod:NewSpecialWarningDodge(236543, "Tank", nil, nil, 1, 2)
local specWarnChaoticEnergy			= mod:NewSpecialWarningMoveTo(234107, nil, nil, nil, 2, 2)
local specWarnAdds					= mod:NewSpecialWarningAdds(200597, "-Healer", nil, nil, 1, 2)

local timerFelsoulCleaveCD			= mod:NewCDTimer(20, 236543, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChaoticEnergyCD			= mod:NewCDTimer(30, 234107, nil, nil, nil, 2)
local timerApproachingDoom			= mod:NewCastTimer(20, 241622, nil, nil, nil, 1)

local countdownChaosEnergy			= mod:NewCountdown(5, 234107)

local voiceFelsoulCleave			= mod:NewVoice(236543)--shockwave (review)
local voiceChaoticEnergy			= mod:NewVoice(234107)--findshield
local voiceAdds						= mod:NewVoice(200597, "-Healer", DBM_CORE_AUTO_VOICE3_OPTION_TEXT)--killmob

mod:AddInfoFrameOption(238410, true)

local shield = GetSpellInfo(238410)

function mod:OnCombatStart(delay)
	timerFelsoulCleaveCD:Start(8.2-delay)
	timerChaoticEnergyCD:Start(32.5-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(shield)
		DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 236543 then
		specWarnFelsoulCleave:Show()
		voiceFelsoulCleave:Play("shockwave")
		timerFelsoulCleaveCD:Start()
	elseif spellId == 234107 then
		specWarnChaoticEnergy:Show(shield)
		voiceChaoticEnergy:Play("findshield")
		countdownChaosEnergy:Start()
	elseif spellId == 241622 then
		if self:AntiSpam(2, 1) then
			warnApproachingDoom:Show()
		end
		timerApproachingDoom:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 234107 then
		timerChaoticEnergyCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 118834 or cid == 119883 then--Portal Guardians
		timerApproachingDoom:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 235822 or spellId == 235862 then--Start Wave 01/Start Wave 02
		specWarnAdds:Show()
		voiceAdds:Play("killmob")
	end
end
