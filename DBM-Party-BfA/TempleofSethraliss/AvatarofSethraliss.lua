local mod	= DBM:NewMod(2145, "DBM-Party-BfA", 6, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(133392)
mod:SetEncounterID(2127)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod.noBossDeathKill = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 268008 269686 268024 268008",
	"SPELL_AURA_REMOVED 268008 269686 274149",
	"SPELL_CAST_START 268061",
	"SPELL_CAST_SUCCESS 273677 274149",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, work on Cds if adds long enough for more than 1 cast each wave
local warnTaint						= mod:NewSpellAnnounce(273677, 2)
local warnPlague					= mod:NewTargetAnnounce(269686, 2)
local warnPulse						= mod:NewSpellAnnounce(268024, 3)
local warnLifeForce					= mod:NewSpellAnnounce(274149, 1)

local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(268061, nil, nil, nil, 1, 2)
local specWarnRainofToads			= mod:NewSpecialWarningSpell(269688, nil, nil, nil, 2, 2)
local specWarnPlague				= mod:NewSpecialWarningDispel(269686, "RemoveDisease", nil, nil, 1, 2)
local specWarnSnakeCharm			= mod:NewSpecialWarningDispel(268008, "Healer", nil, nil, 1, 2)

--local timerRainofToadsCD			= mod:NewAITimer(20, 269688, nil, nil, nil, 1)--More work needed
local timerPlague					= mod:NewTargetTimer(10, 269686, nil, "RemoveDisease", nil, 5, nil, DBM_CORE_DISEASE_ICON)
local timerPulseCD					= mod:NewCDTimer(15, 268024, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
--local timerLifeForce				= mod:NewBuffActiveTimer(20, 274149, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON)

mod:AddNamePlateOption("NPAuraOnSnakeCharm", 268008)

function mod:OnCombatStart(delay)
	timerPulseCD:Start(10-delay)
	--timerRainofToadsCD:Start(1-delay)
	if self.Options.NPAuraOnSnakeCharm then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnSnakeCharm then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 268008 then
		if self.Options.NPAuraOnSnakeCharm then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 15)
		end
	elseif spellId == 269686 and self:CheckDispelFilter() then
		specWarnPlague:Show(args.destName)
		specWarnPlague:Play("helpdispel")
		timerPlague:Start(args.destName)
	elseif spellId == 268024 and self:AntiSpam(3, 1) then
		warnPulse:Show()
		timerPulseCD:Start()
	elseif spellId == 268008 and self:AntiSpam(3, 3) and self:CheckDispelFilter() then
		specWarnSnakeCharm:Show(args.destName)
		specWarnSnakeCharm:Play("helpdispel")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 268008 then
		if self.Options.NPAuraOnSnakeCharm then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 269686 then
		timerPlague:Stop(args.destName)
	elseif spellId == 274149 then--Life Force Ending
		timerPulseCD:Start(11)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 268061 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChainLightning:Show(args.sourceName)
		specWarnChainLightning:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 273677 and self:AntiSpam(3, 2) then
		warnTaint:Show()
	elseif spellId == 274149 then
		timerPulseCD:Stop()
		warnLifeForce:Show()
		--timerLifeForce:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:269688") and self:AntiSpam(5, 4) then
		specWarnRainofToads:Show()
		specWarnRainofToads:Play("mobsoon")
		--timerRainofToadsCD:Start()
	end
end
