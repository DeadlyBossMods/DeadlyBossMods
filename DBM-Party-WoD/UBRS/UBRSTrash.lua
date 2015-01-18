local mod	= DBM:NewMod("UBRSTrash", "DBM-Party-WoD", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 155586 155498",
	"SPELL_CAST_START 155505 169088 169151 155572 155586 155588 154039 155037",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnDebilitatingRay				= mod:NewCastAnnounce(155505, 4)
local warnEarthPounder					= mod:NewSpellAnnounce(154749, 4, nil, "Melee")

local specWarnRejuvSerumDispel			= mod:NewSpecialWarningDispel(155498, "MagicDispeller")
local specWarnDebilitatingRay			= mod:NewSpecialWarningInterrupt(155505, "-Healer")
local specWarnSummonBlackIronDread		= mod:NewSpecialWarningInterrupt(169088, "-Healer")
local specWarnSummonBlackIronVet		= mod:NewSpecialWarningInterrupt(169151, "-Healer")
local specWarnVeilofShadow				= mod:NewSpecialWarningInterrupt(155586, "-Healer")--Challenge mode only(little spammy for mage)
local specWarnVeilofShadowDispel		= mod:NewSpecialWarningDispel(155586, "RemoveCurse")
local specWarnShadowBoltVolley			= mod:NewSpecialWarningInterrupt(155588, "-Healer")
local specWarnSmash						= mod:NewSpecialWarningDodge(155572, "Tank")
local specWarnFranticMauling			= mod:NewSpecialWarningDodge(154039, "Tank")
local specWarnEruption					= mod:NewSpecialWarningDodge(155037, "Tank")

local timerSmashCD						= mod:NewCDTimer(13, 155572)
local timerEruptionCD					= mod:NewCDTimer(10, 155037, nil, false)--10-15 sec variation. May be distracting or spammy since two of them

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 155586 then
		specWarnVeilofShadowDispel:Show(args.destName)
	elseif spellId == 155498 and not args:IsDestTypePlayer() then
		specWarnRejuvSerumDispel:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 155505 then
		local sourceGUID = args.sourceGUID
		warnDebilitatingRay:Show()
		if sourceGUID == UnitGUID("target") or sourceGUID == UnitGUID("focus") then 
			specWarnDebilitatingRay:Show(args.sourceName)
		end
	elseif spellId == 169088 then
		specWarnSummonBlackIronDread:Show(args.sourceName)
	elseif spellId == 169151 then
		specWarnSummonBlackIronVet:Show(args.sourceName)
	elseif spellId == 155586 and self:IsDifficulty("challenge5") then
		warnVeilofShadow:Show()
		specWarnVeilofShadow:Show(args.sourceName)
	elseif spellId == 155588 then
		specWarnShadowBoltVolley:Show(args.sourceName)
	elseif spellId == 155572 then
		if self:AntiSpam(2, 1) then
			specWarnSmash:Show()
		end
		timerSmashCD:Start(nil, args.sourceGUID)
	elseif spellId == 154039 and self:AntiSpam(2, 2) then
		specWarnFranticMauling:Show()
	elseif spellId == 155037 then
		specWarnEruption:Show()
		timerEruptionCD:Start(nil, args.sourceGUID)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 77033 then
		timerSmashCD:Cancel(args.destGUID)
	elseif cid == 82556 then
		timerEruptionCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 154749 and self:AntiSpam(2, 3) then
		warnEarthPounder:Show()
	end
end
