local mod	= DBM:NewMod(1655, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103344)
mod:SetEncounterID(1837)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 204666 204646 204574 204667"
)

local warnShatteredEarth			= mod:NewSpellAnnounce(204666, 2)
local warnThrowTarget				= mod:NewTargetAnnounce(204646, 2)--This is target the tank is THROWN at.

local specWarnRoots					= mod:NewSpecialWarningDodge(204574, nil, nil, nil, 2, 2)
local yellThrow						= mod:NewYell(204646)--yell so others can avoid splash damage. I don't think target can avoid
local specWarnBreath				= mod:NewSpecialWarningSpell(204667, "Tank", nil, nil, 1, 2)

local timerShatteredEarthCD			= mod:NewCDTimer(46, 204666, nil, nil, nil, 2)--Not enough sample size
local timerThrowCD					= mod:NewCDTimer(28, 204646, nil, nil, nil, 3)--29-31
local timerRootsCD					= mod:NewCDTimer(23, 204574, nil, nil, nil, 3)--23-31
local timerBreathCD					= mod:NewCDTimer(26.5, 204667, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local voiceRoots					= mod:NewVoice(204574)--watchstep
local voiceBreath					= mod:NewVoice(204574, "Tank")--Defensive

--mod:AddRangeFrameOption(5, 153396)

function mod:ThrowTarget(targetname, uId)
	if not targetname then
		return
	end
	if targetname == UnitName("player") then
		--Can this be dodged? personal warning?
		yellThrow:Yell()
	else
		warnThrowTarget:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerShatteredEarthCD:Start(7-delay)
	timerRootsCD:Start(11-delay)
	timerBreathCD:Start(18-delay)
	timerThrowCD:Start(29-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 204646 then
		timerThrowCD:Start()
		self:BossTargetScanner(103344, "ThrowTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 204666 then
		warnShatteredEarth:Show()
		timerShatteredEarthCD:Start()
	elseif spellId == 204574 then
		specWarnRoots:Show()
		voiceRoots:Play("watchstep")
		timerRootsCD:Start()
	elseif spellId == 204667 then
		specWarnBreath:Show()
		voiceBreath:Play("defensive")
		timerBreathCD:Start()
	end
end
