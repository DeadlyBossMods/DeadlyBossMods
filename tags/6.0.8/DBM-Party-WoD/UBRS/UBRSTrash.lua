local mod	= DBM:NewMod("UBRSTrash", "DBM-Party-WoD", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 155586",
	"SPELL_CAST_START 155505 169151 155572 155586 155588 154039 155037",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnDebilitatingRay				= mod:NewCastAnnounce(155505, 4)
local warnSummonBlackIronVet			= mod:NewCastAnnounce(169151, 4)
local warnVeilofShadow					= mod:NewCastAnnounce(155586, 4)--Challenge mode only
local warnShadowBoltVolley				= mod:NewCastAnnounce(155588, 3)
local warnEarthPounder					= mod:NewSpellAnnounce(154749, 4, nil, mod:IsMelee())
local warnSmash							= mod:NewSpellAnnounce(155572, 4, nil, mod:IsTank())
local warnFranticMauling				= mod:NewSpellAnnounce(154039, 4, nil, mod:IsMelee())
local warnEruption						= mod:NewSpellAnnounce(155037, 4, nil, mod:IsTank())

local specWarnDebilitatingRay			= mod:NewSpecialWarningInterrupt(155505, not mod:IsHealer())
local specWarnSummonBlackIronVet		= mod:NewSpecialWarningInterrupt(169151, not mod:IsHealer())
local specWarnVeilofShadow				= mod:NewSpecialWarningInterrupt(155586, not mod:IsHealer())--Challenge mode only
local specWarnVeilofShadowDispel		= mod:NewSpecialWarningDispel(155586, mod:CanRemoveCurse())
local specWarnShadowBoltVolley			= mod:NewSpecialWarningInterrupt(155588, not mod:IsHealer())
local specWarnSmash						= mod:NewSpecialWarningMove(155572, mod:IsTank())
local specWarnFranticMauling			= mod:NewSpecialWarningMove(154039, mod:IsTank())
local specWarnEruption					= mod:NewSpecialWarningMove(155037, mod:IsTank())

local timerSmashCD						= mod:NewCDTimer(13, 155572)
local timerEruptionCD					= mod:NewCDTimer(10, 155037, nil, false)--10-15 sec variation. May be distracting or spammy since two of them

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 155586 then
		specWarnVeilofShadowDispel:Show(args.destName)
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
	elseif spellId == 169151 then
		warnSummonBlackIronVet:Show()
		specWarnSummonBlackIronVet:Show(args.sourceName)
	elseif spellId == 155586 then
		warnVeilofShadow:Show()
		specWarnVeilofShadow:Show(args.sourceName)
	elseif spellId == 155588 then
		warnShadowBoltVolley:Show()
		specWarnShadowBoltVolley:Show(args.sourceName)
	elseif spellId == 155572 then
		if self:AntiSpam(2, 1) then
			warnSmash:Show()
			specWarnSmash:Show()
		end
		timerSmashCD:Start(nil, args.sourceGUID)
	elseif spellId == 154039 and self:AntiSpam(2, 2) then
		warnFranticMauling:Show()
		specWarnFranticMauling:Show()
	elseif spellId == 155037 then
		warnEruption:Show()
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
