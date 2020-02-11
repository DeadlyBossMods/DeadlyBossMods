local mod	= DBM:NewMod(2125, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(135358, 135359, 135360, 131823, 131824, 131825)--All versions so we can pull boss
mod:SetEncounterID(2113)
mod:DisableESCombatDetection()--ES fires For entryway trash pull sometimes, for some reason.
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetBossHPInfoToHighest()
mod:SetMinSyncRevision(17703)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260805 260703 260741 260900",
	"SPELL_AURA_REMOVED 260805 268088",
	"SPELL_CAST_START 260773",
	"SPELL_CAST_SUCCESS 260741 260907 260703 268088",
	"UNIT_TARGET_UNFILTERED"
)

local warnActiveTriad				= mod:NewTargetNoFilterAnnounce(260805, 2)
local warnUnstableMark				= mod:NewTargetAnnounce(260703, 2)
local warnAuraofDreadOver			= mod:NewEndAnnounce(268088, 1)

local specWarnRitual				= mod:NewSpecialWarningSpell(260773, nil, nil, nil, 2, 2)
local specWarnUnstableMark			= mod:NewSpecialWarningMoveAway(260703, nil, nil, nil, 1, 2)
local yellUnstableMark				= mod:NewYell(260703)
local specWarnAuraofDread			= mod:NewSpecialWarningKeepMove(268088, nil, nil, nil, 1, 2)
local specWarnJaggedNettles			= mod:NewSpecialWarningTarget(260703, "Healer", nil, nil, 1, 2)
local specWarnSoulManipulation		= mod:NewSpecialWarningSwitch(260907, nil, nil, nil, 1, 2)

local timerJaggedNettlesCD			= mod:NewNextTimer(13.3, 260741, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerSoulManipulationCD		= mod:NewNextTimer(13.3, 260907, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)--Always tank? if not, remove tank icon
local timerUnstableRunicMarkCD		= mod:NewNextTimer(13.3, 260703, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)

mod:AddRangeFrameOption(6, 260703)
mod:AddInfoFrameOption(260773, true)
mod:AddSetIconOption("SetIconOnTriad", 260805, true, true, {8})

mod.vb.activeTriad = nil
local IrisBuff = DBM:GetSpellInfo(260805)

function mod:OnCombatStart(delay)
	self.vb.activeTriad = nil
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	--Hack so win detection and bosses remaining work with 6 CIDs
	self.vb.bossLeft = 3
	self.numBoss = 3
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 260805 then--Iris
		self.vb.activeTriad = args.destGUID
		warnActiveTriad:Show(args.destName)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 135360 or cid == 131825 then--Sister Briar
			timerJaggedNettlesCD:Start(7.8)--CAST SUCCESS
		elseif cid == 135358 or cid == 131823 then--Sister Malady
			timerSoulManipulationCD:Start(11.3)--CAST SUCCESS
		elseif cid == 135359 or cid == 131824 then--Sister Solena
			timerUnstableRunicMarkCD:Start(8.5)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
		end
	elseif spellId == 260703 then
		warnUnstableMark:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUnstableMark:Show()
			specWarnUnstableMark:Play("scatter")
			yellUnstableMark:Yell()
		end
	elseif spellId == 260741 then
		specWarnJaggedNettles:Show(args.destName)
		specWarnJaggedNettles:Play("healfull")
	elseif spellId == 260900 then
		if not args:IsPlayer() then
			specWarnSoulManipulation:Show()
			specWarnSoulManipulation:Play("findmc")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 260805 then--Iris
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 135360 or cid == 131825 then--Sister Briar
			timerJaggedNettlesCD:Stop()
		elseif cid == 135358 or cid == 131823 then--Sister Malady
			timerSoulManipulationCD:Stop()
		elseif cid == 135359 or cid == 131824 then--Sister Solena
			timerUnstableRunicMarkCD:Stop()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 268088 then
		warnAuraofDreadOver:Show()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260773 then
		specWarnRitual:Show()
		specWarnRitual:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260741 then
		--Prevent timer from starting if Cast start started before transfer of power, but Iris sister changed by time fast finished
		local bossUnitID = self:GetUnitIdFromGUID(args.sourceGUID)
		if bossUnitID and not DBM:UnitBuff(bossUnitID, IrisBuff) and not DBM:UnitDebuff(bossUnitID, IrisBuff) then
			timerJaggedNettlesCD:Start()
		end
	--[[elseif spellId == 260907 then
		--Prevent timer from starting if Cast start started before transfer of power, but Iris sister changed by time fast finished
		local bossUnitID = self:GetUnitIdFromGUID(args.sourceGUID)
		if bossUnitID and not DBM:UnitBuff(bossUnitID, IrisBuff) and not DBM:UnitDebuff(bossUnitID, IrisBuff) then
			timerSoulManipulationCD:Start()
		end--]]
	elseif spellId == 260703 then
		--Prevent timer from starting if Cast start started before transfer of power, but Iris sister changed by time fast finished
		local bossUnitID = self:GetUnitIdFromGUID(args.sourceGUID)
		if bossUnitID and not DBM:UnitBuff(bossUnitID, IrisBuff) and not DBM:UnitDebuff(bossUnitID, IrisBuff) then
			timerJaggedNettlesCD:Start()
		end
	elseif spellId == 268088 then
		specWarnAuraofDread:Show()
		specWarnAuraofDread:Play("keepmove")
	end
end

do
	local function TrySetTarget(self)
		if DBM:GetRaidRank() >= 1 then
			for uId in DBM:GetGroupMembers() do
				if UnitGUID(uId.."target") == self.vb.activeTriad then
					self.vb.activeTriad = nil
					local icon = GetRaidTargetIndex(uId)
					if not icon then
						SetRaidTarget(uId.."target", 8)
						break
					end
				end
				if not (self.vb.activeTriad) then
					break
				end
			end
		end
	end

	function mod:UNIT_TARGET_UNFILTERED()
		if self.Options.SetIconOnTriad and self.vb.activeTriad then
			TrySetTarget(self)
		end
	end
end
