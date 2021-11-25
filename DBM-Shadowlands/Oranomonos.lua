local mod	= DBM:NewMod(2432, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167527)
mod:SetEncounterID(2409)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 338852 338857 338856 338855",
	"SPELL_CAST_SUCCESS 339040 338853",
	"SPELL_AURA_APPLIED 338852 338853",
	"SPELL_AURA_APPLIED_DOSE 338852",
	"SPELL_AURA_REMOVED 338856"
)

--Assuming withered winds isn't in combat log, and unit events not worth using outdoors unless it's important
--TODO adjust stack counts
local warnStoneStomp						= mod:NewSpellAnnounce(339040, 3)
local warnImplant							= mod:NewStackAnnounce(338852, 2, nil, "Tank")
local warnRapidGrowth						= mod:NewTargetNoFilterAnnounce(338853, 3, nil, "RemoveMagic")

local specWarnImplant						= mod:NewSpecialWarningStack(338852, nil, 18, nil, nil, 1, 6)
local specWarnImplantTaunt					= mod:NewSpecialWarningTaunt(338852, nil, nil, nil, 1, 2)
local specWarnRegrowth						= mod:NewSpecialWarningInterrupt(338857, "HasInterrupt", nil, nil, 1, 2)
local specWarnDirgeoftheFallenSanctum		= mod:NewSpecialWarningSpell(338856, nil, nil, nil, 2, 2)
local specWarnSeedsofSorrow					= mod:NewSpecialWarningRun(338855, nil, nil, nil, 4, 2)

--local timerWitheredWindsCD					= mod:NewCDTimer(24.7, 339040, nil, nil, nil, 3)
local timerImplantCD						= mod:NewCDTimer(12.3, 338852, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRegrowthCD						= mod:NewCDTimer(82.0, 339040, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerRapidGrowthCD					= mod:NewCDTimer(15.9, 338853, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerSeedsofSorrowCD					= mod:NewCDTimer(59.9, 338855, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerWitheredWindsCD:Start(1)
		--timerImplantCD:Start(1)
		--timerRapidGrowthCD:Start(1)--SUCCESS
		--timerSeedsofSorrowCD:Start(1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 338852 then
		timerImplantCD:Start()
	elseif spellId == 338857 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnRegrowth:Show(args.sourceName)
			specWarnRegrowth:Play("kickcast")
		end
	elseif spellId == 338856 then
		specWarnDirgeoftheFallenSanctum:Show()
		specWarnDirgeoftheFallenSanctum:Play("aesoon")
		timerImplantCD:Stop()
		timerRapidGrowthCD:Stop()
	elseif spellId == 338855 then
		specWarnSeedsofSorrow:Show()
		specWarnSeedsofSorrow:Play("justrun")
		timerSeedsofSorrowCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 339040 then
--		timerWitheredWindsCD:Start()
	elseif spellId == 338853 then
		timerRapidGrowthCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 338852 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			if amount >= 18 then--FIXME
				if args:IsPlayer() then
					specWarnImplant:Show(amount)
					specWarnImplant:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
						specWarnImplantTaunt:Show(args.destName)
						specWarnImplantTaunt:Play("tauntboss")
					else
						warnImplant:Show(args.destName, amount)
					end
				end
			else
				warnImplant:Show(args.destName, amount)
			end
		end
	elseif spellId == 338853 then
		warnRapidGrowth:CombinedShow(0.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 338856 then
		timerRegrowthCD:Start(4)
		--timerSeedsofSorrowCD:Start(9.2)--Could be this, instead of a 60-67 second timer from last cast
		timerRapidGrowthCD:Start(19.5)
		timerImplantCD:Start(29.5)
	end
end
