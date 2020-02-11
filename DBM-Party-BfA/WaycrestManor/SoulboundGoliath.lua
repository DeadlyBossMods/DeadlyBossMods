local mod	= DBM:NewMod(2126, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(260551)
mod:SetEncounterID(2114)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267907",
	"SPELL_CAST_START 260508",
	"SPELL_CAST_SUCCESS 260551 260508",
	"RAID_BOSS_WHISPER"
)

--ability.id = 260508 and type = "begincast" or ability.id = 260551 and type = "cast" or ability.id = 260541
--TODO, review wildfire/burning bush stuff for heroic+ to see if blizzards warning is good enough.
--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnCrush					= mod:NewSpecialWarningDefensive(260508, "Tank", nil, nil, 1, 2)
local specWarnThorns				= mod:NewSpecialWarningSwitch(267907, "Dps", nil, nil, 1, 2)
local yellThorns					= mod:NewYell(267907)
local specWarnSoulHarvest			= mod:NewSpecialWarningMoveTo(260512, "Tank", nil, nil, 3, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Timers subject to delays if boss gets stunned by fire
local timerCrushCD					= mod:NewCDTimer(15, 260508, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--15 after last cast FINISHES
local timerThornsCD					= mod:NewCDTimer(21.8, 267907, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)

mod.vb.crushCount = 0

local wildfire = DBM:GetSpellInfo(260569)

function mod:OnCombatStart(delay)
	self.vb.crushCount = 0
	timerCrushCD:Start(5.7-delay)
	timerThornsCD:Start(8.1-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267907 then
		if args:IsPlayer() then
			yellThorns:Yell()
		else
			specWarnThorns:Show()
			specWarnThorns:Play("targetchange")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260508 then
		self.vb.crushCount = self.vb.crushCount + 1
		specWarnCrush:Show()
		specWarnCrush:Play("defensive")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260551 then
		timerThornsCD:Start()
	elseif spellId == 260508 then
		timerCrushCD:Start(15)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("260512") then
		specWarnSoulHarvest:Show(wildfire)
		specWarnSoulHarvest:Play("moveboss")
	end
end
