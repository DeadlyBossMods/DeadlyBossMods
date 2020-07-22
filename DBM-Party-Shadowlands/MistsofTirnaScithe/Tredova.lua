local mod	= DBM:NewMod(2405, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164517)
mod:SetEncounterID(2393)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5)--Probably doesn't use all 5, unsure number of mind link targets at max inteligence/energy

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 322550 322614 337235 337249 337255",
	"SPELL_CAST_SUCCESS 322614 322654 322563",
	"SPELL_AURA_APPLIED 322527 331172 322648 322563",
	"SPELL_AURA_REMOVED 322450 322527 331172 322648",
	"SPELL_PERIODIC_DAMAGE 326309",
	"SPELL_PERIODIC_MISSED 326309"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Timers can't be fixed until transcriptor log, without boss energy can't start mark prey timer up mid fight or update CD on other abilities cast more often at higher energy
--[[
ability.id = 322550 and type = "begincast"
 or (ability.id = 322614 or ability.id = 322654 or ability.id = 322563) and type = "cast"
 or (ability.id = 322527 or ability.id = 322450) and (type = "applybuff" or type = "removebuff" or type = "applydebuff" or type = "removedebuff")
 or (ability.id = 337235 or ability.id = 337249 or ability.id = 337255) and type = "begincast"
--]]
local warnMarkthePrey				= mod:NewTargetNoFilterAnnounce(322563, 3)

local specWarnConsumption			= mod:NewSpecialWarningDodge(322450, nil, nil, nil, 2, 2)
local specWarnConsumptionKick		= mod:NewSpecialWarningInterrupt(322450, "HasInterrupt", nil, nil, 2, 2)
local specWarnAcceleratedIncubation	= mod:NewSpecialWarningSwitch(322550, "Dps", nil, nil, 1, 2)
local specWarnMindLink				= mod:NewSpecialWarningMoveAway(322648, nil, nil, nil, 1, 11)
local yellMindLink					= mod:NewYell(322648)
local specWarnMarkthePrey			= mod:NewSpecialWarningYou(322563, nil, nil, nil, 1, 2)
local specWarnAcidExpulsion			= mod:NewSpecialWarningDodge(322654, nil, nil, nil, 2, 2)
local specWarnParasiticInfester		= mod:NewSpecialWarning("specWarnParasiticInfester", nil, nil, nil, 1, 2, 4, 337235)
local yellParasiticInfester			= mod:NewYell(337235, L.Infester, true, "yellParasiticInfester")
local specWarnGTFO					= mod:NewSpecialWarningGTFO(326309, nil, nil, nil, 1, 8)

local timerAcceleratedIncubationCD	= mod:NewCDTimer(25.5, 322550, nil, nil, nil, 1, nil, nil, true)--25 unless spell queued
local timerMindLinkCD				= mod:NewCDTimer(18, 322614, nil, nil, nil, 3, nil, nil, true)--18 unless spell queued, will also not be cast at all if previous link isn't gone
local timerMarkthePreyCD			= mod:NewCDTimer(25, 322563, nil, nil, nil, 3, nil, nil, true)--25 unless spell queued, doesn't start until boss is above certain energy threshold
local timerAcidExpulsionCD			= mod:NewCDTimer(15, 322654, nil, nil, nil, 3, nil, nil, true)--15 unless spell queued
local timerParasiticInfesterCD		= mod:NewTimer(21.9, "timerParasiticInfesterCD", 337235, nil, nil, 1, DBM_CORE_L.MYTHIC_ICON, true)

mod:AddInfoFrameOption(322527, true)
mod:AddSetIconOption("SetIconOnMindLink", 296944, true, false, {1, 2, 3, 4, 5})

mod.vb.mindLinkIcon = 1
mod.vb.firstPray = false

function mod:InfesterTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnParasiticInfester:Show()
		specWarnParasiticInfester:Play("targetyou")
		yellParasiticInfester:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.mindLinkIcon = 1
	self.vb.firstPray = false
	timerMindLinkCD:Start(15-delay)
	timerAcidExpulsionCD:Start(10-delay)
	timerAcceleratedIncubationCD:Start(20.7-delay)
	if self:IsMythic() then
		timerParasiticInfesterCD:Start(26.3-delay)
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
	elseif spellId == 322563 then
		timerMarkthePreyCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322527 then
		timerMindLinkCD:Stop()
		timerAcidExpulsionCD:Stop()
		timerMarkthePreyCD:Stop()
		specWarnConsumption:Show()
		specWarnConsumption:Play("watchstep")
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
