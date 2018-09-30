local mod	= DBM:NewMod(2332, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(138967)
mod:SetEncounterID(2273)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Stage One: The Forces of Blood
--local warnPoolofDarkness				= mod:NewCountAnnounce(273361, 4)
--local warnActiveDecay					= mod:NewTargetNoFilterAnnounce(276434, 1)
--local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")

--local specWarnDarkRevolation			= mod:NewSpecialWarningYouPos(273365, nil, nil, nil, 1, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
--local yellDarkRevolationFades			= mod:NewIconFadesYell(273365)
--local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, false, nil, 4, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--local timerDarkRevolationCD			= mod:NewCDCountTimer(55, 273365, nil, nil, nil, 3)
--local timerBloodyCleaveCD				= mod:NewCDTimer(14.1, 273316, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddInfoFrameOption(258040, true)
--mod:AddNamePlateOption("NPAuraOnPresence", 276093)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

--mod.vb.phase = 1

function mod:OnCombatStart(delay)
--	if self.Options.NPAuraOnPresence then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnPresence then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273316 then

--	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnBloodshard:Show(args.sourceName)
--		specWarnBloodshard:Play("kickcast")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274358 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274358 then
		--[[local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnRupturingBlood:Show(amount)
					specWarnRupturingBlood:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnRupturingBloodTaunt:Show(args.destName)
						specWarnRupturingBloodTaunt:Play("tauntboss")
					else
						warnRupturingBlood:Show(args.destName, amount)
					end
				end
			else
				warnRupturingBlood:Show(args.destName, amount)
			end
		end--]]
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 273365 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 139185 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then

	end
end
--]]
