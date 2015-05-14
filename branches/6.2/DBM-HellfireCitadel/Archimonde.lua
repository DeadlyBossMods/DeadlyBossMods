local mod	= DBM:NewMod(1438, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91331)--Doomfire Spirit (92208), Hellfire Deathcaller (92740), Felborne Overfiend (93615), Dreadstalker (93616), Infernal doombringer (94412)
mod:SetEncounterID(1799)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183254 182826 183817 183828 185590 184931 184265 186562 187180",
	"SPELL_CAST_SUCCESS 183865",
	"SPELL_AURA_APPLIED 182879 183634 183865 184964 186574 187180 186961 189895",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 186123 185014 187180 186961",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Verify target scanning for fel burst
--TODO, verify how long after death brand add spawns, if far enough after, give it a spawn announce. if it's only like 2 seconds, death brand IS the spawn announce
--TODO, figure out how the debuffs jumping around really work in phase 2 (chaos debuffs)
--TODO, figure out what to do with consume magic. First I need to see if add is tanked, and how it's fixate works to determine how to detect if you are within 8 yards of it
--TODO, phase triggers
--TODO< figure out rain of chaos (182225). periodic trigger of every 12 seconds. but how to detect?
--Phase 1: The Defiler
local warnDoomfireFixate			= mod:NewTargetAnnounce(182879, 3)
local warnFelBurst					= mod:NewTargetAnnounce(183817, 4)
local warnDeathBrand				= mod:NewSpellAnnounce(183817, 2)
local warnDemonicHavoc				= mod:NewTargetAnnounce(183865, 3)--Mythic
local warnDesecrate					= mod:NewSpellAnnounce(185590, 2)
--Phase 2: Hand of the Legion
local warnShackledTorment			= mod:NewTargetAnnounce(184964, 3)
local warnWroughtChaos				= mod:NewTargetAnnounce(184265, 4)--Combined both targets into one warning under primary spell name
local warnDreadFixate				= mod:NewTargetAnnounce(186574, 2, nil, false)--No idea. 3 second fixate?
local warnConsumeMagic				= mod:NewCastAnnounce(186562, 2)
--Phase 3: The Twisting Nether
local warnDemonicFeedback			= mod:NewTargetAnnounce(187180, 3)
local warnNetherBanish				= mod:NewTargetAnnounce(186961, 2)
----The Nether
local warnVoidStarFixate			= mod:NewTargetAnnounce(189895, 2)

--Phase 1: The Defiler
local specWarnDoomfireFixate		= mod:NewSpecialWarningYou(182879, nil, nil, nil, 4)
local yellDoomfireFixate			= mod:NewYell(182826)--Use short name for yell
local specWarnAllureofFlames		= mod:NewSpecialWarningSpell(183254, nil, nil, nil, 2)
local specWarnFelBurst				= mod:NewSpecialWarningYou(183817)
local yellFelBurst					= mod:NewYell(183817)--Change yell to countdown mayeb when better understood
local specWarnFelBurstNear			= mod:NewSpecialWarningClose(183817)
local specWarnDeathBrand			= mod:NewSpecialWarningSpell(183828, "Tank")
--Phase 2: Hand of the Legion
local specWarnShackledTorment		= mod:NewSpecialWarningYou(184964)
local yellShackledTorment			= mod:NewYell(184964)
local specWarnWroughtChaos			= mod:NewSpecialWarningMoveAway(186123, nil, nil, nil, 3)
local yellWroughtChaos				= mod:NewYell(186123)
local specWarnFocusedChaos			= mod:NewSpecialWarningMoveAway(185014, nil, nil, nil, 3)
local yellFocusedChaos				= mod:NewYell(185014)
local specWarnDreadFixate			= mod:NewSpecialWarningYou(186574, false)--Do you run from a 3 second fixate?
--Phase 3: The Twisting Nether
local specWarnDemonicFeedback		= mod:NewSpecialWarningYou(187180)
local yellDemonicFeedback			= mod:NewYell(187180, nil, false)
local specWarnDemonicFeedbackOther	= mod:NewSpecialWarningTarget(187180, "Healer")
local specWarnNetherBanish			= mod:NewSpecialWarningYou(186961)
local yellNetherBanish				= mod:NewFadesYell(186961)
----The Nether
local specWarnVoidStarFixate		= mod:NewSpecialWarningYou(189895)--Maybe move away? depends how often it changes fixate targets
local yellVoidStarFixate			= mod:NewYell(189895, nil, false)

--Phase 1: The Defiler
local timerDoomfireCD				= mod:NewAITimer(107, 182826)--182826 cast, 182879 fixate
local timerAllureofFlamesCD			= mod:NewAITimer(107, 183254)
local timerFelBurstCD				= mod:NewAITimer(107, 183817)
local timerDeathbrandCD				= mod:NewAITimer(107, 183817)
local timerDemonicHavocCD			= mod:NewAITimer(107, 183865)
--Phase 2: Hand of the Legion
local timerShackledTormentCD		= mod:NewAITimer(107, 184931)
local timerWroughtChaosCD			= mod:NewAITimer(107, 184265)
--Phase 3: The Twisting Nether
local timerDemonicFeedbackCD		= mod:NewAITimer(107, 187180)
local timerNetherBanishCD			= mod:NewAITimer(107, 186961)
----The Nether

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownWroughtChaos			= mod:NewCountdownFades(5, 184265)

--local voiceInfernoSlice				= mod:NewVoice(155080)

mod:AddRangeFrameOption("8/30")
mod:AddSetIconOption("SetIconOnDemonicFeedback", 187180)
mod:AddHudMapOption("HudMapOnWrought", 184265)--Yellow on caster (wrought chaos), red on target (focused chaos)

--mod.vb.wroughtWarned = 0--Just in case it's spammy and there needs to be some kind of filter
mod.vb.demonicFeedbacks = 0
mod.vb.netherPortals = 0

local UnitDebuff = UnitDebuff
local DemonicFeedback = GetSpellInfo(187180)
local NetherBanish = GetSpellInfo(186961)
local demonicFilter, netherFilter
do
	demonicFilter = function(uId)
		if UnitDebuff(uId, DemonicFeedback) then
			return true
		end
	end
	netherFilter = function(uId)
		if UnitDebuff(uId, NetherBanish) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.netherPortals > 0 then
		if UnitDebuff("player", NetherBanish) then
			DBM.RangeCheck:Show(30)
		else
			DBM.RangeCheck:Show(30, netherFilter)
		end
	elseif self.vb.demonicFeedbacks > 0 then
		if UnitDebuff("player", DemonicFeedback) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(8, demonicFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

--[[
function mod:FelBurstTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidBomb:Show()
		yellVoidBomb:Yell()
	else
		warnVoidBomb:Show(targetname)
	end
end--]]

function mod:OnCombatStart(delay)
	self.vb.demonicFeedbacks = 0
	self.vb.netherPortals = 0
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)
	timerDoomfireCD:Start(1-delay)
	timerAllureofFlamesCD:Start(1-delay)
	timerFelBurstCD:Start(1-delay)
	timerDeathbrandCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnWrought then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183254 then
		specWarnAllureofFlames:Show()
		timerAllureofFlamesCD:Start()
	elseif spellId == 182826 then
		timerDoomfireCD:Start()
	elseif spellId == 183817 then--In case debuff doesn't work, or this is faster
		timerFelBurstCD:Start()
--		self:ScheduleMethod(0.2, "BossTargetScanner", GUID, "FelBurstTarget", 0.05, 16)e
	elseif spellId == 183828 then
		timerDeathbrandCD:Start()
		if self.Options.SpecWarn183828spell then
			specWarnDeathBrand:Show()
		else
			warnDeathBrand:Show()
		end
		if self:IsMythic() then
			timerDemonicHavocCD:Start(1)
		end
	elseif spellId == 185590 then
		warnDesecrate:Show()
	elseif spellId == 184931 then--Move to correct iD for spell_cast_Success. I like timer lining up with debuffs not cast
		timerShackledTormentCD:Start()
	elseif spellId == 184265 then
--		self.vb.wroughtWarned = 0
		timerWroughtChaosCD:Start()
	elseif spellId == 186562 then
		warnConsumeMagic:Show()
	elseif spellId == 187180 then
		timerDemonicFeedbackCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 183865 then
		timerDemonicHavocCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182879 then
		warnDoomfireFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnDoomfireFixate:Show()
			yellDoomfireFixate:Yell()
		end
	elseif spellId == 183634 then--Verify spellid
		warnFelBurst:Show(args.destName)
		if args:IsPlayer() then
			specWarnFelBurst:Show()
			yellFelBurst:Yell()
		end
	elseif spellId == 183865 then
		warnDemonicHavoc:CombinedShow(0.3, args.destName)
	elseif spellId == 184964 then--Verify spellid
		warnShackledTorment:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShackledTorment:Show()
			yellShackledTorment:Yell()
		end
	elseif spellId == 186123 then--Wrought Chaos
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
		warnWroughtChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWroughtChaos:Show()
			yellWroughtChaos:Yell()
			countdownWroughtChaos:Start()
		end
		if self.Options.HudMapOnWrought then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
		end
	elseif spellId == 185014 then--Focused Chaos
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
		warnWroughtChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFocusedChaos:Show()
			yellFocusedChaos:Yell()
			countdownWroughtChaos:Start()
		end
		if self.Options.HudMapOnWrought then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Yellow
		end
	elseif spellId == 186574 then--Dreadstalker fixate
		warnDreadFixate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDreadFixate:Show()
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks + 1
		if self.Options.SpecWarn187180target then
			specWarnDemonicFeedbackOther:CombinedShow(0.3, args.destName)
		else
			warnDemonicFeedback:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() then
			specWarnDemonicFeedback:Show()
			yellDemonicFeedback:Yell()
		end
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetSortedIcon(0.7, args.destName, 1)
		end
		updateRangeFrame(self)
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals + 1
		timerNetherBanishCD:Start()
		if args:IsPlayer() then
			specWarnNetherBanish:Show()
			yellNetherBanish:Schedule(6, 1)
			yellNetherBanish:Schedule(5, 2)
			yellNetherBanish:Schedule(4, 3)
			yellNetherBanish:Schedule(3, 4)
			yellNetherBanish:Schedule(2, 5)
		else
			warnNetherBanish:Show(args.destName)
		end
		updateRangeFrame(self)
	elseif spellId == 189895 then
		warnVoidStarFixate:CombinedShow(0.3, args.destName)--More than one?
		if args:IsPlayer() then
			specWarnVoidStarFixate:Show()
			yellVoidStarFixate:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186123 or spellId == 185014 then--Wrought Chaos/Focused Chaos
		if self.Options.HudMapOnWrought then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks - 1
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals - 1
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92740 then--Hellfire Deathcaller
		timerDemonicHavocCD:Cancel()
	elseif cid == 93616 then--Dreadstalker
		
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
