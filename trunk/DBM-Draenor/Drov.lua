local mod	= DBM:NewMod(1291, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81252)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 175791 175953",
	"SPELL_AURA_APPLIED 175827"
)

--TODO, timers
--TODO, add warnings for Acid Breath or Crushing Charge?
--TODO, Slam improvements
local warnGigaSmash				= mod:NewSpellAnnounce(175953, 3)
local warnColossalSlam			= mod:NewTargetAnnounce(175791, 4)
local warnCallofEarth			= mod:NewSpellAnnounce(175827, 2)

local specWarnGigaSmash			= mod:NewSpecialWarningSpell(175953, nil, nil, nil, 2)
local specWarnColossalSlam		= mod:NewSpecialWarningYou(175791)
local specWarnColossalSlamOther	= mod:NewSpecialWarningTarget(175791)
local yellColossalSlam			= mod:NewYell(175791)
local specWarnCallofEarth		= mod:NewSpecialWarningSpell(175827)

--local timerGigaSmashCD		= mod:NewCDTimer(53, 175953)
--local timerColossalSlamCD		= mod:NewCDTimer(32, 175791)
--local timerCallofEarthCD		= mod:NewCDTimer(32, 175827)

--mod:AddReadyCheckOption(37460, false)

function mod:SmashTarget(targetname, uId)
	if not targetname then return end
	warnColossalSlam:Show(targetname)
	if targetname == UnitName("player") then
		specWarnColossalSlam:Show()
		yellColossalSlam:Yell()
	else
		specWarnColossalSlamOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
--[[	if yellTriggered then

	end--]]
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175791 then
		self:BossTargetScanner(81252, "SmashTarget", 0.02, 16)
		--timerColossalSlamCD:Start()
	elseif spellId == 175953 then
		warnGigaSmash:Show()
		specWarnGigaSmash:Show()
		--timerGigaSmashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 119622 then
		warnCallofEarth:Show()
		specWarnCallofEarth:Show()
		--timerCallofEarthCD:Start()
	end
end
