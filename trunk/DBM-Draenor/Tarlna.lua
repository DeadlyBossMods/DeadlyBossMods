local mod	= DBM:NewMod(1211, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81535)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.Pull)


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 175973 175979",
	"SPELL_CAST_SUCCESS 176013",
	"SPELL_AURA_APPLIED 176004"
)

--Oh look, someone designed a world boss that's a copy and paste of Yalnu with tweaks.
--TODO, do dps siwtch to Untamed Mand, or just tanks.
--TODO, add Noxious Spit warnings
local warnColossalBlow				= mod:NewSpellAnnounce(175973, 3)
local warnGenesis					= mod:NewSpellAnnounce(175979, 4)
local warnSavageVines				= mod:NewTargetAnnounce(175979, 3)
local warnGrowUntamedMandragora		= mod:NewSpellAnnounce(176013, 3)

local specWarnColossalBlow			= mod:NewSpecialWarningSpell(175973, nil, nil, nil, 2)
local specWarnGenesis				= mod:NewSpecialWarningSwitch(175979)--Everyone. "Switch" is closest generic to "run around stomping flowers". Might need custom message
local specWarnSavageVines			= mod:NewSpecialWarningYou(176004)
local yellSavageVines				= mod:NewYell(176004)
local specWarnSavageVinesNear		= mod:NewSpecialWarningClose(176004)
local specWarnGrowUntamedMandragora	= mod:NewSpecialWarningSwitch(176013, not mod:IsHealer())

--local timerColossalBlowCD			= mod:NewNextTimer(60, 175973)
local timerGenesisCD				= mod:NewCDTimer(45, 169613)--45-60 variation
local timerGrowUntamedMandragoraCD	= mod:NewCDTimer(30, 176013)

--mod:AddReadyCheckOption(32518, false)
mod:AddRangeFrameOption(8, 175979)

local UnitDebuff = UnitDebuff
local debuffName = GetSpellInfo(176004)
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, debuffName)
	end
end

local function hideRangeFrame()
	DBM.RangeCheck:Hide()
end

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175973 then
		warnColossalBlow:Show()
		specWarnColossalBlow:Show()
		--timerColossalBlow:Start()
	elseif spellId == 175979 then
		warnGenesis:Show()
		specWarnGenesis:Show()
		timerGenesisCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 176013 then
		warnGrowUntamedMandragora:Show()
		specWarnGrowUntamedMandragora:Show()
		timerGrowUntamedMandragoraCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 176004 then
		local targetName = args.destName
		warnSavageVines:CombinedShow(0.5, targetName)
		if args:IsPlayer() then
			specWarnSavageVines:Show()
			yellSavageVines:Yell()
		else
			if self:CheckNearby(8, targetName) then
				specWarnSavageVinesNear:Show(targetName)
			end
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", debuffName) then
				DBM.RangeCheck:Show(8, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter)
			end
			self:Schedule(8, hideRangeFrame)
		end
	end
end
