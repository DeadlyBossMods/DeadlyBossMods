local mod	= DBM:NewMod(2405, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164517)
mod:SetEncounterID(2393)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5)--Probably doesn't use all 5, unsure number of mind link targets at max inteligence

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 322550 322614 322558 322563",
	"SPELL_CAST_SUCCESS 322614",
	"SPELL_AURA_APPLIED 322527 331172 322648 322563",
	"SPELL_AURA_REMOVED 322450 322527 331172 322648",
	"SPELL_PERIODIC_DAMAGE 326309",
	"SPELL_PERIODIC_MISSED 326309"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do you need to manually interrupt Consumption on shield breaking, or does breaking shield interrupt it?
--TODO, do timers reset on 70 and 40% transitions or just pause/delay but resume from previous timing?
--TODO, possibly rework mind link icons if current method is a problem for groups that don't break them before next set go out
--TODO, target scan Acid Spittle?
--TODO, is acid explulsion spammed? Not gonna add until I know 322651
local warnAcidSpittle				= mod:NewCastAnnounce(322558, 3)
local warnMarkthePrey				= mod:NewTargetNoFilterAnnounce(322563, 3)

local specWarnConsumption			= mod:NewSpecialWarningSpell(322450, nil, nil, nil, 2, 2)
local specWarnAcceleratedIncubation	= mod:NewSpecialWarningSwitch(322550, "Dps", nil, nil, 1, 2)
local specWarnMindLink				= mod:NewSpecialWarningMoveAway(322648, nil, nil, nil, 1, 11)
local yellMindLink					= mod:NewYell(322648)
local specWarnMarkthePrey			= mod:NewSpecialWarningYou(322563, nil, nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(326309, nil, nil, nil, 1, 8)

local timerAcceleratedIncubationCD	= mod:NewAITimer(13, 322550, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerMindLinkCD				= mod:NewAITimer(15.8, 322614, nil, nil, nil, 3)
local timerAcidSpittleCD			= mod:NewAITimer(15.8, 322558, nil, nil, nil, 3)
local timerMarkthePreyCD			= mod:NewAITimer(15.8, 322563, nil, nil, nil, 3)

mod:AddInfoFrameOption(296650, true)
mod:AddSetIconOption("SetIconOnMindLink", 296944, true, false, {1, 2, 3, 4, 5})

mod.vb.mindLinkIcon = 1

function mod:OnCombatStart(delay)
	self.vb.mindLinkIcon = 1
	timerAcceleratedIncubationCD:Start(1-delay)
	timerMindLinkCD:Start(1-delay)
	timerAcidSpittleCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322550 then
		specWarnAcceleratedIncubation:Show()
		specWarnAcceleratedIncubation:Play("killmob")
		timerAcceleratedIncubationCD:Start()
	elseif spellId == 322614 then
		self.vb.mindLinkIcon = 2
	elseif spellId == 322558 then
		warnAcidSpittle:Show()
		timerAcidSpittleCD:Start()
	elseif spellId == 322563 then
		timerMarkthePreyCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322614 then
		self.vb.mindLinkIcon = 2
		timerMindLinkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322527 then
		timerAcceleratedIncubationCD:Stop()
		timerMindLinkCD:Stop()
		timerAcidSpittleCD:Stop()
		specWarnConsumption:Show()
		specWarnConsumption:Play("phasechange")
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 331172 or spellId == 322648 then
		if args:IsPlayer() then
			specWarnMindLink:Show()
			specWarnMindLink:Play("lineapart")
			yellMindLink:Yell()
		end
		if self.Options.SetIconOnMindLink then
			--Always set Star on parent link
			self:SetIcon(args.destName, spellId == 322648 and 1 or self.vb.mindLinkIcon)
		end
		if spellId == 331172 then
			--Non parents use icons 2-5
			self.vb.mindLinkIcon = self.vb.mindLinkIcon + 1
			--if self.vb.mindLinkIcon == 6 then
			--	self.vb.mindLinkIcon = 2
			--end
		end
	elseif spellId == 322563 then
		if args:IsPlayer() then
			specWarnMarkthePrey:Show()
			specWarnMarkthePrey:Play("targetyou")
		else
			warnMarkthePrey:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322450 then--Consumption
		timerAcceleratedIncubationCD:Start(2)
		timerMindLinkCD:Start(2)
		--If stuff then--Start the advanced version of timer if inteligence high enough (alternate power?)
			--timerMarkthePreyCD:Start(2)
		--elsei--Start normal version
			timerAcidSpittleCD:Start(2)
		--end
	elseif spellId == 322527 then--Gorging Shield
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 326309 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
