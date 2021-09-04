local mod	= DBM:NewMod(2405, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164517)
mod:SetEncounterID(2393)
mod:SetUsedIcons(1, 2, 3, 4, 5)--Probably doesn't use all 5, unsure number of mind link targets at max inteligence/energy

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 322550 322614 337235 337249 337255",
	"SPELL_CAST_SUCCESS 322614 322654",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED 322527 331172 322648 322563",
	"SPELL_AURA_REMOVED 322450 322527 331172 322648",
	"SPELL_PERIODIC_DAMAGE 326309",
	"SPELL_PERIODIC_MISSED 326309"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Timers can't be fixed until numerous transcriptor logs, without boss energy can't start mark prey timer up mid fight or update CD on other abilities cast more often at higher energy
--[[
ability.id = 322550 and type = "begincast"
 or (ability.id = 322614 or ability.id = 322654 or ability.id = 322563) and type = "cast"
 or (ability.id = 322527 or ability.id = 322450) and (type = "applybuff" or type = "removebuff" or type = "applydebuff" or type = "removedebuff")
 or (ability.id = 337235 or ability.id = 337249 or ability.id = 337255) and type = "begincast"
--]]
local warnMarkthePrey				= mod:NewTargetNoFilterAnnounce(322563, 3)
local warnInvestor					= mod:NewAnnounce("warnInvestor", 4, 337235)

local specWarnConsumption			= mod:NewSpecialWarningDodge(322450, nil, nil, nil, 2, 2)
local specWarnConsumptionKick		= mod:NewSpecialWarningInterrupt(322450, "HasInterrupt", nil, 2, 1, 2)
local specWarnAcceleratedIncubation	= mod:NewSpecialWarningSwitch(322550, "Dps", nil, nil, 1, 2)
local specWarnMindLink				= mod:NewSpecialWarningMoveAway(322648, nil, nil, nil, 1, 11)
local yellMindLink					= mod:NewYell(322648)
local specWarnMarkthePrey			= mod:NewSpecialWarningYou(322563, nil, nil, nil, 1, 2)
local specWarnAcidExpulsion			= mod:NewSpecialWarningDodge(322654, nil, nil, nil, 2, 2)
local specWarnParasiticInfester		= mod:NewSpecialWarning("specWarnParasiticInfester", nil, nil, nil, 1, 2, 4, 337235)
local specWarnParasiticInfesterKick	= mod:NewSpecialWarning("specWarnParasiticInfesterKick", nil, nil, nil, 1, 2, 4, 337235)
local yellParasiticInfester			= mod:NewYell(337235, L.Infester, true, "yellParasiticInfester")
local specWarnGTFO					= mod:NewSpecialWarningGTFO(326309, nil, nil, nil, 1, 8)

local timerAcceleratedIncubationCD	= mod:NewCDTimer(34, 322550, nil, nil, nil, 1, nil, nil, true)--34-43?
local timerMindLinkCD				= mod:NewCDTimer(15.4, 322614, nil, nil, nil, 3, nil, nil, true)--15-19, still not cast if everyone already affected by it.
local timerAcidExpulsionCD			= mod:NewCDTimer(19.4, 322654, nil, nil, nil, 3, nil, nil, true)--19-26
local timerParasiticInfesterCD		= mod:NewTimer(23, "timerParasiticInfesterCD", 337235, nil, nil, 4, DBM_CORE_L.MYTHIC_ICON..DBM_CORE_L.INTERRUPT_ICON, true)--23-26.3

mod:AddInfoFrameOption(322527, true)
mod:AddSetIconOption("SetIconOnMindLink", 296944, true, false, {1, 2, 3, 4, 5})

mod.vb.mindLinkIcon = 1
mod.vb.firstPray = false

function mod:InfesterTarget(targetname, uId)
	if not targetname then return end
	warnInvestor:Show(targetname)
	if targetname == UnitName("player") then
		yellParasiticInfester:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.mindLinkIcon = 1
	self.vb.firstPray = false
	timerAcidExpulsionCD:Start(7.1-delay)
	timerMindLinkCD:Start(18.1-delay)
	timerAcceleratedIncubationCD:Start(45.2-delay)
	if self:IsMythic() then
		timerParasiticInfesterCD:Start(12-delay)
	end
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
	elseif spellId == 337235 or spellId == 337249 or spellId == 337255 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "InfesterTarget", 0.1, 8)
		timerParasiticInfesterCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnParasiticInfesterKick:Show(args.sourceName)
			specWarnParasiticInfesterKick:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322614 then
		self.vb.mindLinkIcon = 2
		timerMindLinkCD:Start()
	elseif spellId == 322654 and self:AntiSpam(3, 1) then
		specWarnAcidExpulsion:Show()
		specWarnAcidExpulsion:Play("watchstep")
		timerAcidExpulsionCD:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 337235 or args.extraSpellId == 337249 or args.extraSpellId == 337255) then
		self:UnscheduleMethod("BossTargetScanner")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322527 then--Gorging Shield (Consumption starting)
		timerMindLinkCD:Stop()
		timerAcidExpulsionCD:Stop()
--		timerMarkthePreyCD:Stop()
		timerAcceleratedIncubationCD:Stop()
		if and self:AntiSpam(3, 1) then
			specWarnConsumption:Show()
			specWarnConsumption:Play("watchstep")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 331172 or spellId == 322648 then
		if self.Options.SetIconOnMindLink then
			--Always set Star on parent link
			self:SetIcon(args.destName, spellId == 322648 and 1 or self.vb.mindLinkIcon)
		end
		if args:IsPlayer() then
			specWarnMindLink:Show()
			specWarnMindLink:Play("lineapart")
			yellMindLink:Yell()
		end
		if spellId == 331172 then
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
	if spellId == 322450 then--Consumption ended
		--TODO, maybe update timers that are all spell queued at this point, which will
	elseif spellId == 322527 then--Gorging Shield
		specWarnConsumptionKick:Show(args.destName)
		specWarnConsumptionKick:Play("kickcast")
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
