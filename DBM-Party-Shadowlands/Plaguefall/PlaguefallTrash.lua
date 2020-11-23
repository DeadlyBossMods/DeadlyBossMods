local mod	= DBM:NewMod("PlaguefallTrash", "DBM-Party-Shadowlands", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 328016 328177 327584 327581 330403 327233 328986 318949 319070 328395 328338",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 328015 320072 320103",
	"SPELL_AURA_REMOVED 320103"
)

--TODO, maybe auto icon marking/tracking of slimes summoned via 327598
--Notable Globgrog Trash
local warnFungistorm					= mod:NewSpellAnnounce(328177, 3, nil, "Healer")
local warnBeckonSlime					= mod:NewCastAnnounce(327581, 2, 6)--Cast 3 seconds, plus 3 seconds til slime appears
--Notable Doctor Ickus Trash
local warnViolentDetonation				= mod:NewCastAnnounce(328986, 3)
--Notable Domina Venomblade
--local warnVenompiercer					= mod:NewCastAnnounce(328395, 3)

--General
local specWarnGTFO						= mod:NewSpecialWarningGTFO(320072, nil, nil, nil, 1, 8)
--Notable Globgrog Trash
local specWarnWingBuffet				= mod:NewSpecialWarningDodge(330403, "Tank", nil, nil, 1, 8)
local specWarnBelchPlague				= mod:NewSpecialWarningDodge(327233, nil, nil, nil, 1, 2)
--Notable Doctor Ickus Trash
local specWarnFesteringBelch			= mod:NewSpecialWarningDodge(318949, "Tank", nil, nil, 1, 2)
local specWarCorrosiveGunk				= mod:NewSpecialWarningInterrupt(319070, false, nil, nil, 1, 2)--Spam cast. Even with Cd filter this may annoy users, off by default
--Notable Domina Venomblade
local specWarnBulwarkofMaldraxxus		= mod:NewSpecialWarningMove(336451, "Tank", nil, nil, 1, 10)
--Notable Margrave Stradama Trash
local specWarnVenompiercer				= mod:NewSpecialWarningDodge(328395, "Tank", nil, nil, 1, 2)
local specWarnCallVenomfang				= mod:NewSpecialWarningInterrupt(328338, "HasInterrupt", nil, nil, 1, 2)
--Unknown
local specWarnWonderGrow				= mod:NewSpecialWarningInterrupt(328016, "HasInterrupt", nil, nil, 1, 2)
local specWarnWonderGrowDispel			= mod:NewSpecialWarningDispel(328015, "MagicDispeller", nil, nil, 1, 2)

local timerMetamorphosis				= mod:NewCastTimer(10, 322232, nil, nil, nil, 1)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

mod.vb.metaCast = 0--Disconnects or reloads or leaving/entering the zone when it's at a non 0 count will break timer accuracy

--function mod:RicochetingTarget(targetname, uId)
--	if not targetname then return end
--	warnRicochetingThrow:Show(targetname)
--	if targetname == UnitName("player") then
--		yellRicochetingThrow:Yell()
--	end
--end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 328016 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWonderGrow:Show(args.sourceName)
		specWarnWonderGrow:Play("kickcast")
	elseif spellId == 319070 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarCorrosiveGunk:Show(args.sourceName)
		specWarCorrosiveGunk:Play("kickcast")
	elseif spellId == 328338 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCallVenomfang:Show(args.sourceName)
		specWarnCallVenomfang:Play("kickcast")
	elseif spellId == 328177 and self:AntiSpam(3, 4) then
		warnFungistorm:Show()
	elseif (spellId == 327584 or spellId == 327581) and self:AntiSpam(3, 6) then
		warnBeckonSlime:Show()
	elseif spellId == 330403 and self:AntiSpam(3, 2) then
		specWarnWingBuffet:Show()
		specWarnWingBuffet:Play("shockwave")
	elseif spellId == 327233 and self:AntiSpam(3, 2) then
		specWarnBelchPlague:Show()
		specWarnBelchPlague:Play("shockwave")
	elseif spellId == 318949 and self:AntiSpam(3, 2) then
		specWarnFesteringBelch:Show()
		specWarnFesteringBelch:Play("shockwave")
	elseif spellId == 328986 and self:AntiSpam(3, 6) then
		warnViolentDetonation:Show()
	elseif spellId == 328395 and self:AntiSpam(3, 2) then
		specWarnVenompiercer:Show()
		specWarnVenompiercer:Play("shockwave")
--	elseif spellId == 272402 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 328015 then
		specWarnWonderGrowDispel:CombinedShow(1, args.destName)
		specWarnWonderGrowDispel:ScheduleVoice(1, "dispelboss")
	elseif spellId == 320072 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
--	elseif spellId == 328015 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
--		specWarnBestialWrath:Show(args.destName)
--		specWarnBestialWrath:Play("helpdispel")
	elseif spellId == 320103 then
		self.vb.metaCast = self.vb.metaCast + 1
		if self.vb.metaCast == 1 then
			timerMetamorphosis:Start()
		end
	elseif spellId == 336451 and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnBulwarkofMaldraxxus:Show()
		specWarnBulwarkofMaldraxxus:Play("mobout")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 320103 then
		self.vb.metaCast = self.vb.metaCast - 1
		if self.vb.metaCast == 0 then
			timerMetamorphosis:Stop()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
