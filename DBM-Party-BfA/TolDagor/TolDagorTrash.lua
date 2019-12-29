local mod	= DBM:NewMod("TolDagorTrash", "DBM-Party-BfA", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 259711 258128 258153 258317 258313 258634 258869 258917 258935",
	"SPELL_AURA_APPLIED 258153 265889 258133 259188"
--	"SPELL_CAST_SUCCESS"
)

--local warnRiotShield				= mod:NewSpellAnnounce(258317, 4)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnLockdown				= mod:NewSpecialWarningDodge(259711, nil, nil, nil, 2, 2)
local specWarnRighteousFlames		= mod:NewSpecialWarningDodge(258917, nil, nil, nil, 2, 2)
local specWarnRiotShieldMove		= mod:NewSpecialWarningMove(258317, nil, nil, nil, 1, 2)--Because it has a hard tank check, option default on for all
local specWarnHeavilyArmed			= mod:NewSpecialWarningRun(259188, "Tank", nil, nil, 4, 2)
local specWarnDebilitatingShout		= mod:NewSpecialWarningInterrupt(258128, "HasInterrupt", nil, nil, 1, 2)
local specWarnWateryDomeKick		= mod:NewSpecialWarningInterrupt(258153, "HasInterrupt", nil, nil, 1, 2)
local specWarnHandcuff				= mod:NewSpecialWarningInterrupt(258313, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlaze					= mod:NewSpecialWarningInterrupt(258869, "Tank", nil, nil, 1, 2)--Tank should hit this one
local specWarnFuselighter			= mod:NewSpecialWarningInterrupt(258634, "HasInterrupt", nil, nil, 1, 2)--Everyone else hit this one
local specWarnInnerFlames			= mod:NewSpecialWarningInterrupt(258935, "HasInterrupt", nil, nil, 1, 2)
local specWarnWateryDome			= mod:NewSpecialWarningDispel(258153, "MagicDispeller", nil, nil, 1, 2)
local specWarnDarkStep				= mod:NewSpecialWarningDispel(258133, "MagicDispeller", nil, nil, 1, 2)
local specWarnTorchStrike			= mod:NewSpecialWarningDispel(265889, "Healer", nil, nil, 1, 2)
local specWarnRiotShield			= mod:NewSpecialWarningReflect(258317, "CasterDps", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 259711 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 6) then
		specWarnLockdown:Show()
		specWarnLockdown:Play("watchstep")
	elseif spellId == 258917 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 6) then
		specWarnRighteousFlames:Show()
		specWarnRighteousFlames:Play("watchstep")
	elseif spellId == 258128 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDebilitatingShout:Show(args.sourceName)
		specWarnDebilitatingShout:Play("kickcast")
	elseif spellId == 258153 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWateryDomeKick:Show(args.sourceName)
		specWarnWateryDomeKick:Play("kickcast")
	elseif spellId == 258317 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(5, 3) then
		if self:IsTank() then
			specWarnRiotShieldMove:Show()
			specWarnRiotShieldMove:Play("moveboss")
		else
			specWarnRiotShield:Show(args.sourceName)
			specWarnRiotShield:Play("stopattack")
		end
	elseif spellId == 258153 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHandcuff:Show(args.sourceName)
		specWarnHandcuff:Play("kickcast")
	elseif spellId == 258634 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFuselighter:Show(args.sourceName)
		specWarnFuselighter:Play("kickcast")
	elseif spellId == 258869 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBlaze:Show(args.sourceName)
		specWarnBlaze:Play("kickcast")
	elseif spellId == 258935 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnInnerFlames:Show(args.sourceName)
		specWarnInnerFlames:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 258153 and not args:IsDestTypePlayer() and self:AntiSpam(5, 1) then
		specWarnWateryDome:Show(args.destName)
		specWarnWateryDome:Play("helpdispel")
	elseif spellId == 258133 and not args:IsDestTypePlayer() and self:AntiSpam(5, 1) then
		specWarnDarkStep:Show(args.destName)
		specWarnDarkStep:Play("helpdispel")
	elseif spellId == 265889 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(5, 2) then
		specWarnTorchStrike:Show(args.destName)
		specWarnTorchStrike:Play("helpdispel")
	elseif spellId == 259188 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(5, 4) then
		specWarnHeavilyArmed:Show()
		specWarnHeavilyArmed:Play("justrun")
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
