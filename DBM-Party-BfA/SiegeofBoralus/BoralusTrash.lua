local mod	= DBM:NewMod("BoralusTrash", "DBM-Party-BfA", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 275826 256627 256957 256709 257170 272546 257169 272713 274569 272571 272888",
	"SPELL_AURA_APPLIED 256957 257168 272421 272571",
--	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_START"
)

--TODO, heavy slash, non boss version? it's not in combat log since blizz sucks
--TODO, target scan Ricochet (272542)?
local warnBananaRampage				= mod:NewSpellAnnounce(272546, 2)
local warnBolsteringShout			= mod:NewSpellAnnounce(275826, 2)
local warnFerocity					= mod:NewCastAnnounce(272888, 3)

local specWarnSlobberKnocker		= mod:NewSpecialWarningDodge(256627, "Tank", nil, nil, 1, 2)
local specWarnSingingSteel			= mod:NewSpecialWarningDodge(256709, "Tank", nil, nil, 1, 2)
local specWarnCrushingSlam			= mod:NewSpecialWarningDodge(272711, "Tank", nil, nil, 1, 2)
local specWarnTrample				= mod:NewSpecialWarningDodge(272874, nil, nil, nil, 2, 2)
local specWarnBroadside				= mod:NewSpecialWarningDodge(268260, nil, nil, nil, 2, 2)
local specWarnSavageTempest			= mod:NewSpecialWarningRun(257170, nil, nil, nil, 4, 2)--can tank run out too? or does it follow tank
local specWarnSightedArt			= mod:NewSpecialWarningYou(272421, nil, nil, nil, 1, 2)
local yellSightedArt				= mod:NewYell(272421)
local specWarnWatertightShell		= mod:NewSpecialWarningInterrupt(256957, "HasInterrupt", nil, nil, 1, 2)
local specWarnRevitalizingMist		= mod:NewSpecialWarningInterrupt(274569, "HasInterrupt", nil, nil, 1, 2)
local specWarnChokingWaters			= mod:NewSpecialWarningInterrupt(272571, false, nil, nil, 1, 2)--Because it's on same mob as mist, off by default
local specWarnWatertightShellDispel	= mod:NewSpecialWarningDispel(256957, "MagicDispeller", nil, nil, 1, 2)
local specWarnCursedSlash			= mod:NewSpecialWarningDispel(257168, "RemoveCurse", nil, nil, 1, 2)
local specWarnFerocity				= mod:NewSpecialWarningDispel(272888, "RemoveEnrage", nil, 2, 1, 2)
local specWarnChokingWatersDispel	= mod:NewSpecialWarningDispel(272571, "Healer", nil, nil, 1, 2)
local specWarnFear					= mod:NewSpecialWarningSpell(257169, nil, nil, nil, 2, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 275826 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 1) then
		warnBolsteringShout:Show()
	elseif spellId == 256627 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(2.5, 2) then
		specWarnSlobberKnocker:Show()
		specWarnSlobberKnocker:Play("shockwave")
	elseif spellId == 256709 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(2.5, 2) then
		specWarnSingingSteel:Show()
		specWarnSingingSteel:Play("shockwave")
	elseif spellId == 257170 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 4) then
		specWarnSavageTempest:Show()
		specWarnSavageTempest:Play("whirlwind")
	elseif spellId == 272546 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 5) then
		warnBananaRampage:Show()
	elseif spellId == 257169 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 6) then
		specWarnFear:Show()
		specWarnFear:Play("fearsoon")
	elseif spellId == 256957 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWatertightShell:Show(args.sourceName)
		specWarnWatertightShell:Play("kickcast")
	elseif spellId == 274569 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRevitalizingMist:Show(args.sourceName)
		specWarnRevitalizingMist:Play("kickcast")
	elseif spellId == 272571 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChokingWaters:Show(args.sourceName)
		specWarnChokingWaters:Play("kickcast")
	elseif spellId == 272888 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 7) then
		warnFerocity:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 256957 and self:IsValidWarning(args.sourceGUID) and not args:IsDestTypePlayer() then
		specWarnWatertightShellDispel:CombinedShow(1, args.destName)
		specWarnWatertightShellDispel:ScheduleVoice(1, "helpdispel")
	elseif spellId == 257168 and self:IsValidWarning(args.sourceGUID) and self:CheckDispelFilter() then
		specWarnCursedSlash:Show(args.destName)
		specWarnCursedSlash:Play("helpdispel")
	elseif spellId == 272421 and args:IsPlayer() then
		specWarnSightedArt:Show()
		specWarnSightedArt:Play("targetyou")
		yellSightedArt:Yell()
	elseif spellId == 272571 and args:IsDestTypePlayer() and self:CheckDispelFilter() then
		specWarnChokingWatersDispel:Show(args.destName)
		specWarnChokingWatersDispel:Play("helpdispel")
	elseif spellId == 272888 and self:IsValidWarning(args.sourceGUID) then
		specWarnFerocity:Show(args.destName)
		specWarnFerocity:Play("helpdispel")

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

--Spells not in combat log what so ever, so this relies on unit event off a users target or nameplate unit IDs, then syncing to group
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 272874 then
		local guid = UnitGUID(uId)
		if self:IsValidWarning(guid, uId) then
			self:SendSync("Trample")
		end
	elseif spellId == 272711 then
		local guid = UnitGUID(uId)
		if self:IsValidWarning(guid, uId) then
			self:SendSync("CrushingSlam")
		end
	elseif spellId == 268260 then
		local guid = UnitGUID(uId)
		if self:IsValidWarning(guid, uId) then
			self:SendSync("Broadside")
		end
	end
end

function mod:OnSync(msg)
	if msg == "Trample" and self:AntiSpam(4, 10) then
		specWarnTrample:Show()
		specWarnTrample:Play("chargemove")
	elseif msg == "CrushingSlam" and self:AntiSpam(2.5, 2) then
		specWarnCrushingSlam:Show()
		specWarnCrushingSlam:Play("shockwave")
	elseif msg == "Broadside" then
		specWarnBroadside:Show()
		specWarnBroadside:Play("watchstep")
	end
end
