local mod	= DBM:NewMod(2369, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157620)
mod:SetEncounterID(2334)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()--Must set boss HP to highest, since boss health will get screwed up during images phase
mod.noBossDeathKill = true--Killing an image in image phase fires unit Died for boss creature ID, so must filter this
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
mod:SetMinSyncRevision(20190918000000)--2019, 9, 18
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 309687 307937 307725",
	"SPELL_CAST_SUCCESS 313239 307937 313276",
	"SPELL_AURA_APPLIED 307784 307785 313208 308065 307950",
	"SPELL_AURA_APPLIED_DOSE 308059",
	"SPELL_AURA_REMOVED 313208 308065 307950",--307784 307785
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 309687 or ability.id = 307725) and type = "begincast"
 or (ability.id = 313239 or ability.id = 307937 or ability.id = 313276) and type = "cast"
--]]
local warnShadowShock						= mod:NewStackAnnounce(308059, 2, nil, "Tank")
local warnImagesofAbsolution				= mod:NewCountAnnounce(313239, 3)--Spawn, not when killable
local warnShredPsyche						= mod:NewTargetNoFilterAnnounce(307937, 2)
local warnPsychicOutburst					= mod:NewCastAnnounce(309687, 4)
local warnProjections						= mod:NewSpellAnnounce(307725, 2)
local warnProjectionsOver					= mod:NewEndAnnounce(307725, 2)

local specWarnCloudedMind					= mod:NewSpecialWarningYou(307784, nil, nil, nil, 1, 2)--voice not yet decided
local specWarnTwistedMind					= mod:NewSpecialWarningYou(307785, nil, nil, nil, 1, 2)--voice not yet decided
local yellMark								= mod:NewPosYell(307784, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, false)
local specWarnImagesofAbsolutionSwitch		= mod:NewSpecialWarningSwitch(313239, "dps", 127876, nil, 1, 2, 3)--30 seconds after spawn, when killable
local specWarnShadowShock					= mod:NewSpecialWarningStack(308059, nil, 7, nil, nil, 1, 6)
local specWarnShadowShockTaunt				= mod:NewSpecialWarningTaunt(308059, nil, nil, nil, 1, 2)
local specWarnShredPsyche					= mod:NewSpecialWarningMoveAway(307937, nil, nil, nil, 1, 2)
local yellShredPsyche						= mod:NewPosYell(307937, DBM_CORE_AUTO_YELL_CUSTOM_POSITION2)
local yellShredPsycheFades					= mod:NewIconFadesYell(307937)
local specWarnShredPsycheSwitch				= mod:NewSpecialWarningSwitch(307937, "dps", nil, nil, 1, 2)

local timerImagesofAbsolutionCD				= mod:NewCDTimer(84.9, 313239, 127876, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
local timerShredPsycheCD					= mod:NewCDTimer(37.7, 307937, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON, nil, 1, 4)

local berserkTimer							= mod:NewBerserkTimer(600)--He only gains a 300% damage increase on his berserk, and that's surviable since he doesn't melee and his adds don't gain it

mod:AddSetIconOption("SetIconOnAdds", 307937, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnIntangibleIllusion", 313208)

mod.vb.ImagesOfAbsolutionCast = 0
mod.vb.shredIcon = 1

function mod:OnCombatStart(delay)
	self.vb.ImagesOfAbsolutionCast = 0
	self.vb.shredIcon = 1
	timerShredPsycheCD:Start(12.8-delay)--SUCCESS
	if self:IsHard() then
		timerImagesofAbsolutionCD:Start(30.5-delay)
	end
	if self.Options.NPAuraOnIntangibleIllusion then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	berserkTimer:Start(480-delay)--Confirmed on heroic and normal
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.NPAuraOnIntangibleIllusion then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 309687 and self:AntiSpam(5, 3) then
		warnPsychicOutburst:Show()
	elseif spellId == 307937 then
		self.vb.shredIcon = 1
	elseif spellId == 307725 then
		warnProjections:Show()
		timerShredPsycheCD:Stop()
		timerImagesofAbsolutionCD:Stop()
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 313239 then
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
	elseif spellId == 308059 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if (amount >= 3) and amount % 2 == 1 then
				if amount >= 7 then
					if args:IsPlayer() then
						specWarnShadowShock:Show(amount)
						specWarnShadowShock:Play("stackhigh")
					else
						--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
						--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
						--Can't taunt less you've dropped yours off, period
						if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
							specWarnShadowShockTaunt:Show(args.destName)
							specWarnShadowShockTaunt:Play("tauntboss")
						else
							warnShadowShock:Show(args.destName, amount)
						end
					end
				end
			end
		end
	elseif spellId == 313208 then
		if self.Options.NPAuraOnIntangibleIllusion then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 30)
		end
	elseif spellId == 308065 or spellId == 307950 then
		--Assign icon based on debuff player has, so it can be clearly seen which add they will be spawning on mythic
		local icon
		if self:IsMythic() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if DBM:UnitDebuff(uId, 307784) then--Clouded Mind
				icon = 2--Orange Circle for clouded mind
			elseif DBM:UnitDebuff(uId, 307785) then--Twisted Mind
				icon = 3--Purple Diamond for Twisted Mind
			end
		end
		--Non mythic will assign just ordered icon, or if mythic icon debuff scan fails acts as fallback
		if not icon then
			icon = self.vb.shredIcon--Starting with 1 (star). if it's still 2 adds at once at 20+ players, it'll also use circle, if blizzard fixed that shit, it'll always be star
		else--We have an icon from mythic assignments, prep the switch warning for phased players
			if (DBM:UnitDebuff("player", 307784) and icon == 2) or (DBM:UnitDebuff("player", 307785) and icon == 3) then
				specWarnShredPsycheSwitch:Schedule(5)
				specWarnShredPsycheSwitch:ScheduleVoice(5, "killmob")
			end
		end
		warnShredPsyche:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShredPsyche:Show()
			specWarnShredPsyche:Play("runout")
			yellShredPsyche:Yell(icon, args.spellName, icon)
			yellShredPsycheFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnAdds then
			self:SetIcon(args.destName, icon)
		end
		self.vb.shredIcon = self.vb.shredIcon + 1
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
		if self.Options.SetIconOnAdds then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	if UnitCanAttack("player", "boss1") then--Returning from Illusions
		warnProjectionsOver:Show()
		self:UnregisterShortTermEvents()
		timerShredPsycheCD:Start(15.2)--SUCCESS
		if self:IsHard() then
			timerImagesofAbsolutionCD:Start(33.9)
		end
	end
end
