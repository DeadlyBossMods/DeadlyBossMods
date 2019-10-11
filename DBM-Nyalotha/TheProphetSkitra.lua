local mod	= DBM:NewMod(2369, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157620)
mod:SetEncounterID(2334)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307977 309687",
	"SPELL_CAST_SUCCESS 307445 313239 307937 313276",
	"SPELL_AURA_APPLIED 307784 307785 313208 308065 307950",
	"SPELL_AURA_APPLIED_DOSE 307977",
	"SPELL_AURA_REMOVED 313208 308065 307950",--307784 307785
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, if tanks each get a diff mind debuff, mark them, and they can be designated callers
--TODO, Shadow shocks spellIds and durations still a bit unclear from wowhead data. Add taunt warnings/etc when it becomes more clear
--TODO, there are likely mechanics missing from this encounter, that or the fight really is more simple than even most 5 man dungeon bosses
--TODO, update timers on Projection phases?
local warnShadowShock						= mod:NewStackAnnounce(307977, 2, nil, "Tank")
local warnImagesofAbsolution				= mod:NewCountAnnounce(313239, 3)--Spawn, not when killable
local warnShredPsyche						= mod:NewTargetAnnounce(307937, 2)
local warnPsychicOutburst					= mod:NewCastAnnounce(309687, 4)

local specWarnCloudedMind					= mod:NewSpecialWarningYouPos(307784, nil, nil, nil, 1, 2)--voice not yet decided
local specWarnTwistedMind					= mod:NewSpecialWarningYouPos(307785, nil, nil, nil, 1, 2)--voice not yet decided
local yellMark								= mod:NewPosYell(307784, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, true, 2)
local specWarnImagesofAbsolutionSwitch		= mod:NewSpecialWarningSwitch(313239, "dps", nil, nil, 1, 2)--30 seconds after spawn, when killable
--local specWarnShadowShock					= mod:NewSpecialWarningStack(307977, nil, 9, nil, nil, 1, 6)
local specWarnShredPsyche					= mod:NewSpecialWarningMoveAway(307937, nil, nil, nil, 1, 2)
local yellShredPsyche						= mod:NewYell(307937)
local yellShredPsycheFades					= mod:NewShortFadesYell(307937)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerShadowShockCD					= mod:NewAITimer(5.3, 307977, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerIllusionaryProjectionCD			= mod:NewAITimer(84, 307445, nil, nil, nil, 6, nil, DBM_CORE_IMPORTANT_ICON, nil, 1, 5)
local timerImagesofAbsolutionCD				= mod:NewAITimer(84, 313239, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
local timerShredPsycheCD					= mod:NewAITimer(30.1, 307937, nil, nil, nil, 3)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnIntangibleIllusion", 313208)

mod.vb.ImagesOfAbsolutionCast = 0

function mod:OnCombatStart(delay)
	self.vb.ImagesOfAbsolutionCast = 0
	timerIllusionaryProjectionCD:Start(1-delay)
	timerShadowShockCD:Start(1-delay)--START
	timerShredPsycheCD:Start(1-delay)
	if self:IsHard() then
		timerImagesofAbsolutionCD:Start(1-delay)
	end
	if self.Options.NPAuraOnIntangibleIllusion then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnIntangibleIllusion then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307977 then
		timerShadowShockCD:Start()
	elseif spellId == 309687 and self:AntiSpam(5, 3) then
		warnPsychicOutburst:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307445 and self:AntiSpam(8, 1) then
		timerIllusionaryProjectionCD:Start()
	elseif spellId == 313239 then
		self.vb.ImagesOfAbsolutionCast = self.vb.ImagesOfAbsolutionCast + 1
		warnImagesofAbsolution:Show(self.vb.ImagesOfAbsolutionCast)
		timerImagesofAbsolutionCD:Start()
	elseif spellId == 307937 or spellId == 313276 then--Non Mythic/Mythic
		timerShredPsycheCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307784 then--Clouded Mind
		if args:IsPlayer() then
			specWarnCloudedMind:Show()
			specWarnCloudedMind:Play("targetyou")
			yellMark:Yell(2, "")--Circle
		end
	elseif spellId == 307785 then--Twisted Mind
		if args:IsPlayer() then
			specWarnTwistedMind:Show()
			specWarnTwistedMind:Play("targetyou")
			yellMark:Yell(3, "")--Diamond
		end
	elseif spellId == 307977 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--[[if amount >= 2 then
				if args:IsPlayer() then
					specWarnSearingArmorStack:Show(amount)
					specWarnSearingArmorStack:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnSearingArmor:Show(args.destName)
						specWarnSearingArmor:Play("tauntboss")
					else
						warnSearingArmor:Show(args.destName, amount)
					end
				end
			else--]]
				warnShadowShock:Show(args.destName, amount)
			--end
		end
	elseif spellId == 313208 then
		if self.Options.NPAuraOnIntangibleIllusion then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 308065 or spellId == 307950 then
		warnShredPsyche:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShredPsyche:Show()
			specWarnShredPsyche:Play("runout")
			yellShredPsyche:Yell()
			yellShredPsycheFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313208 then
		if self.Options.NPAuraOnIntangibleIllusion then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
		if self:AntiSpam(10, 2) then
			specWarnImagesofAbsolutionSwitch:Show()
			specWarnImagesofAbsolutionSwitch:Play("killmob")
		end
	elseif spellId == 308065 or spellId == 307950 then
		if args:IsPlayer() then
			yellShredPsycheFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152311 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 307445 and self:AntiSpam(8, 1) then--Illusionary Projection (or 313349 or 307861)
		timerIllusionaryProjectionCD:Start()
	end
end
