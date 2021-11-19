local mod	= DBM:NewMod(2469, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(175730)
mod:SetEncounterID(2546)
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--local warnGrimPortent							= mod:NewTargetNoFilterAnnounce(354365, 4)--Mythic

--local specWarnInvokeDestiny					= mod:NewSpecialWarningMoveAway(351680, nil, nil, nil, 1, 2)
--local yellInvokeDestiny						= mod:NewYell(351680)
--local yellInvokeDestinyFades					= mod:NewShortFadesYell(351680)
--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Scrying Fate
--local timerGrimPortentCD						= mod:NewAITimer(28.8, 354365, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
--mod:AddSetIconOption("SetIconOnCallofEternity", 350554, true, false, {1, 2, 3, 4, 5})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

function mod:OnCombatStart(delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351680 then

	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353931 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354365 then
--[[local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnUnendingStrike:Show(amount)
				specWarnUnendingStrike:Play("stackhigh")
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 6.7) and not UnitIsDeadOrGhost("player") then
					specWarnUnendingStrikeTaunt:Show(args.destName)
					specWarnUnendingStrikeTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end--]]
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 354365 then

	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 180323 then

	end
end
-]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
