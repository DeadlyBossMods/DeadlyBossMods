local mod	= DBM:NewMod("Moonfang", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71992)
--mod:SetModelID(328)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnLeap				= mod:NewTargetAnnounce(144546, 2)
local warnCallPack			= mod:NewSpellAnnounce(144602, 3)
local warnMoonfangTears		= mod:NewSpellAnnounce(144702, 3)
local warnMoonfangCurse		= mod:NewSpellAnnounce(144590, 4)

local specWarnLeap			= mod:NewSpecialWarningYou(144546)
local yellLeap				= mod:NewYell(144546)
local specWarnLeapNear		= mod:NewSpecialWarningClose(144546)
local specWarnCallPack		= mod:NewSpecialWarningSwitch(144602, mod:IsTank())
local specWarnTears			= mod:NewSpecialWarningSpell(144702, nil, nil, nil, 2)
local specWarnMoonfangCurse	= mod:NewSpecialWarningRun(144590, mod:IsMelee())
local specWarnCurse			= mod:NewSpecialWarningYou(144590)--You failed to move away. Maybe change to localized warning explaining that you need to spam 1 to break MC, not yell at others for not attacking you because you failed mechanic in first place.

local timerLeapCD			= mod:NewCDTimer(12, 144546)
local timerMoonfangsTearCD	= mod:NewNextTimer(23, 144702)

local soundMoonfangCurse	= mod:NewSound(144590, nil, mod:IsMelee())


function mod:LeapTarget(targetname, uId)
	if not targetname then return end
	warnLeap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnLeap:Show()
		yellLeap:Yell()
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 8 then--Range guesswork
				specWarnLeapNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144546 then
		timerLeapCD:Start()
		self:BossTargetScanner(71992, "LeapTarget", 0.05, 16)
	elseif args.spellId == 144590 then
		warnMoonfangCurse:Show()
		specWarnMoonfangCurse:Show()
		soundMoonfangCurse:Play()
	elseif args.spellId == 144602 then
		warnCallPack:Show()
		specWarnCallPack:Show()
	elseif args.spellId == 144702 then
		warnMoonfangTears:Show()
		specWarnTears:Show()
		timerMoonfangsTearCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144590 and args:IsPlayer() then
		specWarnCurse:Show()
	end
end
