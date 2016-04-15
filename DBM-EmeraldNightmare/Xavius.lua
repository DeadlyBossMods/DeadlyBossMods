local mod	= DBM:NewMod(1726, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103769)----TODO, verify
mod:SetEncounterID(1864)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 207830 206308 209443",
	"SPELL_CAST_SUCCESS 206878 206651 209158",
	"SPELL_AURA_APPLIED 208431 206651 205771 209158",
	"SPELL_AURA_REMOVED 208431",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out creatures of corruption stuff
--TODO, see mechanics to apply appropriate voices. too many assumptions right now on some spells
--TODO, interrupt count/helper when CD is known and rotation is confirmed to be 2 or 3 or 4 person
--TODO, if fixate isn't multiple targets, hide target warning if on player and removed CombinedShow
--TODO, across the board detect who doesn't gain corruption and assign them to tasks like meteor soaking, taunting boss, being nearest target to adds, etc
--Nightmare Corruption
local warnUnfathomableReality			= mod:NewTargetAnnounce(206879, 3)
local warnDescentIntoMadness			= mod:NewTargetAnnounce(208431, 4)
--Stage One: The Decent Into Madness
local warnDarkeningSoul					= mod:NewTargetAnnounce(206651, 3, nil, "Healer")
local warnTormentingFixation			= mod:NewTargetAnnounce(205771, 4)
--Stage Two: From the Shadows
local warnBlackeningSoul				= mod:NewTargetAnnounce(209158, 3, nil, "Healer")
local warnNightmareInfusion				= mod:NewSpellAnnounce(209443, 3, nil, "Tank")

local specWarnUnfathomableReality		= mod:NewSpecialWarningYou(206879)
local yellUnfathomableReality			= mod:NewYell(206879)
local specWarnUnfathomableRealityNear	= mod:NewSpecialWarningClose(206879)
local specWarnDescentIntoMadness		= mod:NewSpecialWarningYou(208431)
local yellDescentIntoMadness			= mod:NewFadesYell(208431)
--Stage One: The Decent Into Madness
local specWarnNightmareBlades			= mod:NewSpecialWarningDodge(206656, nil, nil, nil, 2, 2)
local specWarnCorruptionHorror			= mod:NewSpecialWarningSwitch("ej12973", "-Healer", nil, nil, 1, 2)
local specWarnCorruptingNova			= mod:NewSpecialWarningInterrupt(207830, "HasInterrupt", nil, nil, 1, 2)
local specWarnDarkeningSoul				= mod:NewSpecialWarningDispel(206651, "Healer", nil, nil, 1, 2)
local specWarnTormentingFixation		= mod:NewSpecialWarningRun(205771, nil, nil, nil, 4, 2)
--Stage Two: From the Shadows
local specWarnCorruptionMeteorAway		= mod:NewSpecialWarninDodge(206308, nil, nil, nil, 2, 2)
local specWarnCorruptionMeteorTo		= mod:NewSpecialWarningMoveTo(206308, nil, nil, nil, 1, 2)
local specWarnBlackeningSoul			= mod:NewSpecialWarningDispel(209158, "Healer", nil, nil, 1, 2)

--Stage One: The Decent Into Madness
local timerDarkeningSoulCD				= mod:NewAITimer(16, 206651, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)
local timerNightmareBladesCD			= mod:NewAITimer(16, 206656, nil, nil, nil, 3)
local timerCorruptingNovaCD				= mod:NewAITimer(16, 207830, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage Two: From the Shadows
local timerCorruptionMeteorCD			= mod:NewAITimer(16, 206308, nil, nil, nil, 3)
local timerBlackeningSoulCD				= mod:NewAITimer(16, 209158, nil, "Healer", nil, 5, nil, DBM_CORE_MAGIC_ICON)
local timerNightmareInfusionCD			= mod:NewAITimer(16, 209443, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--Stage One: The Decent Into Madness
--local countdownMagicFire				= mod:NewCountdownFades(11.5, 162185)

--Nightmare Corruption
--local voiceUnfathomableReality		= mod:NewVoice(206879)
--local voiceDescentIntoMadness			= mod:NewVoice(208431)
--Stage One: The Decent Into Madness
local voiceNightmareBlades				= mod:NewVoice(206656)--watchstep (or shockwave)
local voiceCorruptionHorror				= mod:NewVoice("ej12973", "-Healer")--bigmob
local voiceCorruptingNova				= mod:NewVoice(207830, "HasInterrupt")--kickcast
local voiceDarkeningSoul				= mod:NewVoice(206651, "Healer")--helpdispel
local voiceTormentingFixation			= mod:NewVoice(205771)--targetyou (iffy, is there no voice that says fixate, run?)
--Stage Two: From the Shadows
local voiceCorruptionMeteor				= mod:NewVoice(206308)--gathershare/watchstep
local voiceBlackeningSoul				= mod:NewVoice(209158, "Healer")--helpdispel

mod:AddInfoFrameOption("ej12970")
--mod:AddRangeFrameOption("8")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

local corruptionName = EJ_GetSectionInfo(12970)
local dreamSimulacrum = GetSpellInfo(206005)

local function isPlayerImmune()
	if UnitBuff("player", dreamSimulacrum) or UnitDebuff("player", dreamSimulacrum) then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	timerDarkeningSoulCD:Start(1-delay)
	timerNightmareBladesCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(corruptionName)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 207830 then
		timerCorruptingNovaCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnCorruptingNova:Show(args.sourceName)
			voiceCorruptingNova:Play("kickcast")
		end
	elseif spellId == 206308 then
		if isPlayerImmune() then
			specWarnCorruptionMeteorTo:Show(TARGET)
			voiceCorruptionMeteor:Play("gathershare")
		else
			specWarnCorruptionMeteorAway:Show()
			voiceCorruptionMeteor:Play("watchstep")
		end
		timerCorruptionMeteorCD:Start()
	elseif spellId == 209443 then
		warnNightmareInfusion:Show()
		timerNightmareInfusionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206878 then--Guessed trigger spell. May not be in combat log
		for uId in DBM:GetGroupMembers() do
			local maxPower = UnitPowerMax(uId, ALTERNATE_POWER_INDEX)
			if maxPower ~= 0 and not UnitIsDeadOrGhost(uId) then--PTR work around mainly, div by 0 crap
				local unitsPower = UnitPower(uId, ALTERNATE_POWER_INDEX) / maxPower * 100
				if unitsPower >= 66 then--Valid Unfathomable Reality
					local targetName = DBM:GetUnitFullName(uId)
					warnUnfathomableReality:CombinedShow(0.5, targetName)
					if targetName == UnitName("player") then
						specWarnUnfathomableReality:Show()
						yellUnfathomableReality:Yell()
					elseif self:CheckNearby(8, targetName) and self:AntiSpam(3, 1) then
						specWarnUnfathomableRealityNear:Show(targetName)
					end
				end
			end
		end
	elseif spellId == 206651 then
		timerDarkeningSoulCD:Start()
	elseif spellId == 209158 then
		timerBlackeningSoulCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 208431 then
		warnDescentIntoMadness:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnDescentIntoMadness:Show()
			yellDescentIntoMadness:Schedule(19, 1)
			yellDescentIntoMadness:Schedule(18, 2)
			yellDescentIntoMadness:Schedule(17, 3)
		end
	elseif spellId == 206651 then
		if isPlayerImmune() then
			specWarnDarkeningSoul:CombinedShow(0.5, args.destName)
			if self:AntiSpam(3, 2) then
				voiceDarkeningSoul:Play("helpdispel")
			end
		else
			warnDarkeningSoul:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 209158 then
		if isPlayerImmune() then
			specWarnBlackeningSoul:CombinedShow(0.5, args.destName)
			if self:AntiSpam(3, 2) then
				voiceBlackeningSoul:Play("helpdispel")
			end
		else
			warnBlackeningSoul:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 205771 then
		warnTormentingFixation:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnTormentingFixation:Show()
			voiceTormentingFixation:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 208431 and args:IsPlayer() then
		yellDescentIntoMadness:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then--Corruption Horror
		timerCorruptingNovaCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 206653 then--Nightmare Blades (only version that has cast time
		specWarnNightmareBlades:Show()
		voiceNightmareBlades:Play("watchstep")
		timerNightmareBladesCD:Start()
	elseif spellId == 213345 then--Corruption Horror Birth
		specWarnCorruptionHorror:Show()
		voiceCorruptionHorror:Play("bigadd")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
