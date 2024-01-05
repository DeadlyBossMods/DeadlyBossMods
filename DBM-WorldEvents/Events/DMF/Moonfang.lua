local mod	= DBM:NewMod("Moonfang", "DBM-WorldEvents", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(71992)
--mod:SetModelID(328)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144546 144590 144602 144702",
	"SPELL_CAST_SUCCESS 144546",
	"SPELL_AURA_APPLIED 144590"
)

local warnLeap				= mod:NewTargetAnnounce(144546, 2)

local specWarnLeap			= mod:NewSpecialWarningYou(144546, nil, nil, nil, 1, 2)
--local yellLeap				= mod:NewYell(144546)
local specWarnCallPack		= mod:NewSpecialWarning("specWarnCallPack", "Ranged|Tank", nil, nil, 4, 2)--Summons add for every person within 40 yards of boss. Ranged should be able to avoid this. Tank in warning to pick ones up spawned by melee
local specWarnTears			= mod:NewSpecialWarningSpell(144702, nil, nil, nil, 2, 2)
local specWarnMoonfangCurse	= mod:NewSpecialWarning("specWarnMoonfangCurse", "Melee", nil, nil, 4, 2)
local specWarnCurse			= mod:NewSpecialWarningYou(144590, nil, nil, nil, 1, 2)--You failed to move away. Maybe change to localized warning explaining that you need to spam 1 to break MC, not yell at others for not attacking you because you failed mechanic in first place.

local timerLeapCD			= mod:NewCDTimer(12, 144546, nil, nil, nil, 3)
local timerMoonfangsTearCD	= mod:NewNextTimer(23, 144702, nil, nil, nil, 2)


function mod:LeapTarget(targetname)
	if not targetname then return end
	warnLeap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnLeap:Show()
		specWarnLeap:Play("targetyou")
--		yellLeap:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144546 then
		self:BossTargetScanner(71992, "LeapTarget", 0.05, 16)
	elseif spellId == 144590 then
		specWarnMoonfangCurse:Show()
		specWarnMoonfangCurse:Play("justrun")
	elseif spellId == 144602 then
		specWarnCallPack:Show()
		specWarnCallPack:Play("justrun")
	elseif spellId == 144702 then
		specWarnTears:Show()
		specWarnTears:Play("aesoon")
		timerMoonfangsTearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 144546 then
		timerLeapCD:Start(11)--12-1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144590 and args:IsPlayer() then
		specWarnCurse:Show()
		specWarnCurse:Play(nil, 15588)--"Sound\\Creature\\Kologarn\\UR_Kologarn_Slay02.ogg"
	end
end
