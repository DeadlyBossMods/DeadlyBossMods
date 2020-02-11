local mod	= DBM:NewMod(2171, "DBM-Party-BfA", 3, 1041)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134993)
mod:SetEncounterID(2142)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267618 267702",
	"SPELL_AURA_REMOVED 267702",
	"SPELL_CAST_START 267639 267763 267702",
	"SPELL_CAST_SUCCESS 267618",
	"SPELL_PERIODIC_DAMAGE 267874",
	"SPELL_PERIODIC_MISSED 267874",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local specWarnBurnCorruption		= mod:NewSpecialWarningRun(267639, "Melee", nil, nil, 4, 2)
local specWarnDrainFluids			= mod:NewSpecialWarningYou(267618, nil, nil, 2, 1, 2)
local specWarnDrainFluidsTarget		= mod:NewSpecialWarningTarget(267618, "Healer", nil, nil, 1, 2)
local specWarnEntomb				= mod:NewSpecialWarningYou(267702, nil, nil, nil, 1, 2)
local yellEntomb					= mod:NewYell(267702)
local specWarnEntombOther			= mod:NewSpecialWarningSwitch(267702, nil, nil, nil, 1, 2)
local specWarnWretchedDischarge		= mod:NewSpecialWarningInterrupt(267763, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(267874, nil, nil, nil, 1, 8)

local timerBurnCorruptionCD			= mod:NewCDTimer(15.8, 267639, nil, "Melee", nil, 2, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local timerDrainFluidsCD			= mod:NewCDTimer(17, 267618, nil, nil, nil, 3)
local timerEntombCD					= mod:NewCDTimer(60, 267702, nil, nil, nil, 3)


function mod:OnCombatStart(delay)
	timerBurnCorruptionCD:Start(10.8-delay)
	timerDrainFluidsCD:Start(17.6-delay)--SUCCESS
	timerEntombCD:Start(26.5-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267618 then
		if args:IsPlayer() then
			specWarnDrainFluids:Show()
			specWarnDrainFluids:Play("targetyou")
		else
			specWarnDrainFluidsTarget:Show(args.destName)
			specWarnDrainFluidsTarget:Play("healfull")
		end
	elseif spellId == 267702 then
		--Boss stops casting stuff and opens tombs until phase ends
		timerBurnCorruptionCD:Stop()
		timerDrainFluidsCD:Stop()
		timerEntombCD:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 267702 then
		--Resume normal boss behavior
		timerBurnCorruptionCD:Start(10)
		timerDrainFluidsCD:Start(17)--SUCCESS
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267639 then
		specWarnBurnCorruption:Show()
		specWarnBurnCorruption:Play("justrun")
		timerBurnCorruptionCD:Start()
	elseif spellId == 267763 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWretchedDischarge:Show(args.sourceName)
		specWarnWretchedDischarge:Play("kickcast")
	elseif spellId == 267702 then
		timerEntombCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267618 and self:AntiSpam(3, 1) then
		timerDrainFluidsCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 267874 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:267702") then
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnEntomb:Show()
				specWarnEntomb:Play("targetyou")
				yellEntomb:Yell()
			else
				specWarnEntombOther:Show()
				specWarnEntombOther:Play("targetchange")
			end
		end
	end
end
