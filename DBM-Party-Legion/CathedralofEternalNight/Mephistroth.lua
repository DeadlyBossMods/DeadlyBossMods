local mod	= DBM:NewMod(1878, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(120793)
mod:SetEncounterID(2039)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233155 233206",
	"SPELL_AURA_APPLIED 233963"
)

--TODO: Can tank dodge swarm once cast starts?
--TODO, shadowfade ending and initial timers post shadow phase
--TODO, verify if more debuff spellids for Demonic Upheavel than one. determine if best place to do timer
--TODO< shadow of mephistro spawn warnings, probably 234034
--[[
phases for mephisto
announce who grabs shield on mephisto
announce circles spawning on ground (watch step) on mephisto
Fix demonic Upheavel
basic range frame for dark solitude?
--]]
local warnShadowFade				= mod:NewSpellAnnounce(233206, 2)
local warnDemonicUpheaval			= mod:NewTargetAnnounce(233963, 3)

local specWarnCarrionSwarm			= mod:NewSpecialWarningSpell(233155, "Tank", nil, nil, 1, 2)
local specWarnDemonicUpheaval		= mod:NewSpecialWarningMoveAway(233963, nil, nil, nil, 1, 2)
local yellDemonicUpheaval			= mod:NewYell(233963)

local timerCarrionSwarmCD			= mod:NewCDTimer(18, 233155, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDemonicUpheavalCD		= mod:NewAITimer(24.2, 233963, nil, nil, nil, 3)

local voiceCarrionSwarm				= mod:NewVoice(233155, "Tank")--shockwave
local voiceDemonicUpheaval			= mod:NewVoice(233963)--runout

function mod:OnCombatStart(delay)
	timerCarrionSwarmCD:Start(15-delay)
	timerDemonicUpheavalCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233155 then
		specWarnCarrionSwarm:Show()
		voiceCarrionSwarm:Play("shockwave")
		timerCarrionSwarmCD:Start()
	elseif spellId == 233206 then--Shadow Fade
		warnShadowFade:Show()
		timerCarrionSwarmCD:Stop()
		timerDemonicUpheavalCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 233963 then
		timerDemonicUpheavalCD:Start()
		if args:IsPlayer() then
			specWarnDemonicUpheaval:Show()
			voiceDemonicUpheaval:Play("runout")
			yellDemonicUpheaval:Yell()
		else
			warnDemonicUpheaval:Show(args.destName)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnGas:Show()
		voiceGas:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
