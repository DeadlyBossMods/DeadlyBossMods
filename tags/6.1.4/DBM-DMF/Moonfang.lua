local mod	= DBM:NewMod("Moonfang", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71992)
--mod:SetModelID(328)
mod:SetZone()
mod:DisableWBEngageSync()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144546 144590 144602 144702",
	"SPELL_AURA_APPLIED 144590"
)

local warnLeap				= mod:NewTargetAnnounce(144546, 2)

local specWarnLeap			= mod:NewSpecialWarningYou(144546)
local yellLeap				= mod:NewYell(144546)
local specWarnCallPack		= mod:NewSpecialWarning("OptionVersion2", "specWarnCallPack", "Ranged|Tank", nil, nil, 4)--Summons add for every person within 40 yards of boss. Ranged should be able to avoid this. Tank in warning to pick ones up spawned by melee
local specWarnTears			= mod:NewSpecialWarningSpell(144702, nil, nil, nil, 2)
local specWarnMoonfangCurse	= mod:NewSpecialWarning("OptionVersion2", "specWarnMoonfangCurse", "Melee", nil, nil, 4)
local specWarnCurse			= mod:NewSpecialWarningYou(144590)--You failed to move away. Maybe change to localized warning explaining that you need to spam 1 to break MC, not yell at others for not attacking you because you failed mechanic in first place.

local timerLeapCD			= mod:NewCDTimer(12, 144546)
local timerMoonfangsTearCD	= mod:NewNextTimer(23, 144702)


function mod:LeapTarget(targetname, uId)
	if not targetname then return end
	warnLeap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnLeap:Show()
		yellLeap:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144546 then
		timerLeapCD:Start()
		self:BossTargetScanner(71992, "LeapTarget", 0.05, 16)
	elseif spellId == 144590 then
		specWarnMoonfangCurse:Show()
	elseif spellId == 144602 then
		specWarnCallPack:Show()
	elseif spellId == 144702 then
		specWarnTears:Show()
		timerMoonfangsTearCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144590 and args:IsPlayer() then
		specWarnCurse:Show()
	end
end
