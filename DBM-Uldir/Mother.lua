local mod	= DBM:NewMod(2167, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135452)
mod:SetEncounterID(2141)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267787 268198",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 267787 274205",
	"SPELL_AURA_APPLIED_DOSE 267787",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, cleansing purge timer/countdown
--TODO, Review Depleted Energy
--TODO, add flame vents, wind tunnels, and surgical beams. They have too many spellIds/scripts and adding wrong ones could be spammy nightmare
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnSunderingScalpel				= mod:NewStackAnnounce(267787, 2, nil, "Tank")
local warnDepletedEnergy				= mod:NewSpellAnnounce(274205, 1)

local specWarnSunderingScalpel			= mod:NewSpecialWarningStack(267787, nil, 2, nil, nil, 1, 6)
local specWarnSunderingScalpelOther		= mod:NewSpecialWarningTaunt(267787, nil, nil, nil, 1, 2)
local specWarnClingingCorruption		= mod:NewSpecialWarningInterrupt(268198, "HasInterrupt", nil, nil, 1, 2)
--local yellFelSilkWrap					= mod:NewYell(244949)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(Nexus)
local timerSunderingScalpelCD			= mod:NewAITimer(12.1, 267787, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownSunderingScalpel				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
--mod:AddInfoFrameOption(258040, true)

function mod:OnCombatStart(delay)
	timerSunderingScalpelCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267787 then
		timerSunderingScalpelCD:Start()
	elseif spellId == 268198 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnClingingCorruption:Show(args.sourceName)
		specWarnClingingCorruption:Play("kickcast")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245050 then--Delusions

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267787 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnSunderingScalpel:Show(amount)
					specWarnSunderingScalpel:Play("stackhigh")
				else
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 30) then--30 is placeholder until CD is known
						specWarnSunderingScalpelOther:Show(args.destName)
						specWarnSunderingScalpelOther:Play("tauntboss")
					else
						warnSunderingScalpel:Show(args.destName, amount)
					end
				end
			else
				warnSunderingScalpel:Show(args.destName, amount)
			end
		end
	elseif spellId == 274205 then
		warnDepletedEnergy:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244383 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 136315 then--Remnant of Corruption

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then

	end
end
--]]
