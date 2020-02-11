local mod	= DBM:NewMod(2083, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(122963)
mod:SetEncounterID(2086)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257407",
	"SPELL_CAST_START 255371 257407 260683",
	"SPELL_CAST_SUCCESS 255434",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPursuit				= mod:NewTargetAnnounce(257407, 2)

local specWarnTeeth				= mod:NewSpecialWarningDefensive(255434, "Tank", nil, nil, 1, 2)
local specWarnFear				= mod:NewSpecialWarningMoveTo(255371, nil, nil, nil, 3, 2)--Dodge warning on purpose, you dodge it by LOS behind pillar
local yellPursuit				= mod:NewYell(257407)
local specWarnPursuit			= mod:NewSpecialWarningRun(257407, nil, nil, nil, 4, 2)
local specWarnBoneQuake			= mod:NewSpecialWarningSpell(260683, nil, nil, nil, 2, 2)

local timerTeethCD				= mod:NewCDTimer(38, 255434, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--38-43.7?
local timerFearCD				= mod:NewCDTimer(40.9, 255371, nil, nil, nil, 2)
local timerPursuitCD			= mod:NewNextTimer(41.2, 257407, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerTeethCD:Start(6-delay)
	timerFearCD:Start(12.4-delay)
	timerPursuitCD:Start(21.8-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257407 and self:AntiSpam(5, args.destName) then--Backup if CHAT_MSG_RAID_BOSS_EMOTE doesn't work
		if args:IsPlayer() then
			specWarnPursuit:Show()
			specWarnPursuit:Play("justrun")
			yellPursuit:Yell()
		else
			warnPursuit:Show(args.destName)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 255371 then
		specWarnFear:Show(DBM_CORE_BREAK_LOS)
		specWarnFear:Play("findshelter")
		timerFearCD:Start()
	elseif spellId == 257407 then
		timerPursuitCD:Start()
	elseif spellId == 260683 then
		specWarnBoneQuake:Show()
		specWarnBoneQuake:Play("mobsoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 255434 then
		specWarnTeeth:Show()
		specWarnTeeth:Play("defensive")
		timerTeethCD:Start()
	end
end

--Same time as SPELL_CAST_START but has target information on normal
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:255421") then
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnPursuit:Show()
				specWarnPursuit:Play("justrun")
				yellPursuit:Yell()
			else
				warnPursuit:Show(targetname)
			end
		end
	end
end
