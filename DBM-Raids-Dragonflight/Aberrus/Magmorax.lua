local mod	= DBM:NewMod(2527, "DBM-Raids-Dragonflight", 2, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201579)
mod:SetEncounterID(2683)
mod:SetUsedIcons(1, 2, 3, 8)
mod:SetHotfixNoticeRev(20230619000000)
--mod:SetMinSyncRevision(20221215000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 408358 402989 403740 403671 409093 402344 404846",
	"SPELL_AURA_APPLIED 408839 407879 408955 402994 411633 406712 411149",
	"SPELL_AURA_APPLIED_DOSE 408839 408955",
	"SPELL_AURA_REMOVED 408839 407879 402994 411149",
	"SPELL_PERIODIC_DAMAGE 411633 406712",
	"SPELL_PERIODIC_MISSED 411633 406712",
	"UNIT_POWER_UPDATE boss1"
)

--[[
(ability.id = 408358 or ability.id = 402989 or ability.id = 403740 or ability.id = 403671 or ability.id = 409093 or ability.id = 402344 or ability.id = 404846) and type = "begincast"
 or ability.id = 407879 and (type = "applybuff" or type = "removebuff")
--]]
--TODO, dynamic energy calculation for accurate Catastrophic timer needs verification
--TODO, the way timers are sequenced assumes doing fight with no mistakes. If tantrums are triggered, it can make timers wrong rest of fight.
--However, doing timers the way they are done is most accurate if people don't do fight wrong., so may just tell users "do fight correctly 5head" that complain instead of using complicated updateAllTimers methods just to work around player mistakes
--TODO, fine tune personal stack alerts
local warnHeatStacks								= mod:NewCountAnnounce(408839, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(408839))
local warnMoltenSpittle								= mod:NewTargetCountAnnounce(402994, 2, nil, nil, 307031)
local warnIncineratingMaws							= mod:NewStackAnnounce(404846, 2, nil, "Tank|Healer")

local specWarnCatastrophicEruption					= mod:NewSpecialWarningSpell(408358, nil, nil, nil, 3, 2)
local specWarnHeatStacks							= mod:NewSpecialWarningStack(408839, nil, 35, nil, nil, 1, 6)
local specWarnBlazingTantrum						= mod:NewSpecialWarningMove(407879, "Tank", nil, nil, 1, 2)
local specWarnIgnitingRoar							= mod:NewSpecialWarningCount(403740, nil, 188832, nil, 2, 2)
local specWarnOverpoweringStomp						= mod:NewSpecialWarningCount(403671, nil, 149213, nil, 2, 2)
local specWarnMoltenSpittle							= mod:NewSpecialWarningYou(402994, nil, 80801, nil, 1, 2)
local yellMoltenSpittle								= mod:NewShortPosYell(402994, "%s", nil, nil, "YELL")
local yellMoltenSpittleFades						= mod:NewIconFadesYell(402994, nil, nil, nil, "YELL")
local specWarnBlazingBreath							= mod:NewSpecialWarningDodge(409093, nil, 18357, nil, 2, 2)
local specWarnIncineratingMaws						= mod:NewSpecialWarningStack(404846, nil, 2, nil, nil, 1, 6)
local specWarnIncineratingMawsSwap					= mod:NewSpecialWarningTaunt(404846, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(411633, nil, nil, nil, 1, 8)

local timerCatastrophicCD							= mod:NewCDTimer(28.9, 408358, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerMoltenSpittleCD							= mod:NewCDCountTimer(29.9, 402994, 307031, nil, nil, 3)--"Lava Pools"
local timerIngitingRoarCD							= mod:NewCDCountTimer(28.9, 403740, 188832, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--"Roar"
local timerOverpoweringStompCD						= mod:NewCDCountTimer(101.7, 403671, 149213, nil, nil, 2)--"Knockback"
local timerBlazingBreathCD							= mod:NewCDCountTimer(29.9, 409093, 18357, nil, nil, 3)
local timerIncineratingMawsCD						= mod:NewCDCountTimer(20, 404846, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(408839, true)
mod:AddSetIconOption("SetIconOnMoltenSpittle", 402994, true, 0, {1, 2, 3, 8})
mod:AddNamePlateOption("NPAuraOnTantrum", 407879)

local heatStacks = {}
mod.vb.spitCount = 0
mod.vb.roarCount = 0
mod.vb.stompCount = 0
mod.vb.breathCount = 0
mod.vb.mawCount = 0
mod.vb.spitIcon = 1

function mod:OnCombatStart(delay)
	table.wipe(heatStacks)
	self.vb.spitCount = 0
	self.vb.roarCount = 0
	self.vb.stompCount = 0
	self.vb.breathCount = 0
	self.vb.mawCount = 0
	self.vb.spitIcon = 1
	if self:IsEasy() then
		timerIngitingRoarCD:Start(8.8-delay, 1)
		timerMoltenSpittleCD:Start(16.6-delay, 1)
		timerIncineratingMawsCD:Start(22.2-delay, 1)
		timerBlazingBreathCD:Start(33.3-delay, 1)
		timerOverpoweringStompCD:Start(76.6,-delay, 1)
	elseif self:IsHeroic() then
		timerIngitingRoarCD:Start(6.2-delay, 1)
		timerMoltenSpittleCD:Start(16.2-delay, 1)
		timerIncineratingMawsCD:Start(24.9-delay, 1)
		timerBlazingBreathCD:Start(31.2-delay, 1)
		timerOverpoweringStompCD:Start(89.9-delay, 1)
	else--Mythic
		timerIngitingRoarCD:Start(5.5-delay, 1)
		timerMoltenSpittleCD:Start(14.4-delay, 1)
		timerIncineratingMawsCD:Start(22.2-delay, 1)
		timerBlazingBreathCD:Start(28-delay, 1)
		timerOverpoweringStompCD:Start(43-delay, 1)
	end
	timerCatastrophicCD:Start(335-delay)
	if self.Options.NPAuraOnTantrum then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(408839))
		DBM.InfoFrame:Show(30, "table", heatStacks, 1)
	end
end

function mod:OnCombatEnd()
	table.wipe(heatStacks)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnTantrum then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 408358 then
		specWarnCatastrophicEruption:Show()
		specWarnCatastrophicEruption:Play("stilldanger")
		timerIngitingRoarCD:Stop()
		timerMoltenSpittleCD:Stop()
		timerIncineratingMawsCD:Stop()
		timerBlazingBreathCD:Stop()
		timerOverpoweringStompCD:Stop()
	elseif spellId == 402989 then
		self.vb.spitCount = self.vb.spitCount + 1
		self.vb.spitIcon = 1
		--16.6, 40.0, 41.1, 32.2, 40.0, 41.1, 32.3, 40.0, 41.1
		if self:IsEasy() then
			if self.vb.spitCount % 3 == 1 then
				timerMoltenSpittleCD:Start(40, self.vb.spitCount+1)
			elseif self.vb.spitCount % 3 == 0 then
				timerMoltenSpittleCD:Start(32, self.vb.spitCount+1)
			else
				timerMoltenSpittleCD:Start(41, self.vb.spitCount+1)
			end
		elseif self:IsHeroic() then
			--16.2, 29.9, 32.4, 37.5, 29.9, 32.5, 37.5, 29.9, 32.4
			if self.vb.spitCount % 3 == 0 then
				timerMoltenSpittleCD:Start(37.5, self.vb.spitCount+1)
			elseif self.vb.spitCount % 3 == 1 then
				timerMoltenSpittleCD:Start(29.9, self.vb.spitCount+1)
			else--2/3
				timerMoltenSpittleCD:Start(32.4, self.vb.spitCount+1)
			end
		else--Mythic
			--14.4, 40.0, 26.6, 40.0, 26.6, 40, 26.7
			if self.vb.spitCount % 2 == 0 then
				timerMoltenSpittleCD:Start(26.6, self.vb.spitCount+1)
			else
				timerMoltenSpittleCD:Start(40, self.vb.spitCount+1)
			end
		end
	elseif spellId == 403740 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnIgnitingRoar:Show(self.vb.roarCount)
		specWarnIgnitingRoar:Play("aesoon")
		if self:IsEasy() then
			--8.8, 40.0, 44.4, 28.9, 40.0, 44.5, 28.9, 40.0, 44.4
			if self.vb.roarCount % 3 == 0 then
				timerIngitingRoarCD:Start(28.8, self.vb.roarCount+1)
			elseif self.vb.roarCount % 3 == 2 then
				timerIngitingRoarCD:Start(44.4, self.vb.roarCount+1)
			else--3 == 1
				timerIngitingRoarCD:Start(40, self.vb.roarCount+1)
			end
		elseif self:IsHeroic() then
			--6.2, 49.9, 49.9, 49.9, 49.9, 49.9, 49.9, 49.9
			timerIngitingRoarCD:Start(49.9, self.vb.roarCount+1)
		else--Mythic
			--5.0, 41.8, 24.8, 41.8, 24.8, 41.8, ...
			if self.vb.roarCount % 2 == 0 then
				timerIngitingRoarCD:Start(24.8, self.vb.roarCount+1)
			else
				timerIngitingRoarCD:Start(41.8, self.vb.roarCount+1)
			end
		end
	elseif spellId == 403671 then
		self.vb.stompCount = self.vb.stompCount + 1
		specWarnOverpoweringStomp:Show(self.vb.stompCount)
		specWarnOverpoweringStomp:Play("carefly")
		timerOverpoweringStompCD:Start(self:IsMythic() and 66.6 or self:IsEasy() and 113.3 or 100, self.vb.stompCount+1)
	elseif spellId == 409093 or spellId == 402344 then--409093 confirmed for heroic/normal, 402344 unknown
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnBlazingBreath:Show(self.vb.breathCount)
		specWarnBlazingBreath:Play("breathsoon")
		if self:IsEasy() then
			--33.3, 27.7, 42.2, 43.3, 27.8, 42.2, 43.4, 27.8, 42.2
			--33.3, 27.7, 42.2, 43.3, 27.7, 42.2
			if self.vb.breathCount % 3 == 0 then
				timerBlazingBreathCD:Start(43.3, self.vb.breathCount+1)
			elseif self.vb.breathCount % 3 == 2 then
				timerBlazingBreathCD:Start(42.2, self.vb.breathCount+1)
			else
				timerBlazingBreathCD:Start(27.7, self.vb.breathCount+1)
			end
		elseif self:IsHeroic() then
			--31.2, 35, 64.9, 34.9, 65, 34.9
			if self.vb.breathCount % 2 == 0 then
				timerBlazingBreathCD:Start(64.9, self.vb.breathCount+1)
			else
				timerBlazingBreathCD:Start(34.9, self.vb.breathCount+1)
			end
		else
			--28.8, 35.5, 31, 35.5, 31.1, ...
			if self.vb.breathCount % 2 == 0 then
				timerBlazingBreathCD:Start(31, self.vb.breathCount+1)
			else
				timerBlazingBreathCD:Start(35.5, self.vb.breathCount+1)
			end
		end
	elseif spellId == 404846 then
		self.vb.mawCount = self.vb.mawCount + 1
		if self:IsEasy() then
			--22.2, 22.3, 22.2, 22.2, 22.2, 24.8, 21.8, 22.3, 22.2, 22.2, 24.5, 22.2, 22.3, 22.2
			if self.vb.mawCount % 5 == 0 then
				timerIncineratingMawsCD:Start(24.4, self.vb.mawCount+1)
			else
				timerIncineratingMawsCD:Start(22.2, self.vb.mawCount+1)
			end
		elseif self:IsMythic() then
			--22.2, 14.4, 24.4, 27.8, 14.4, 24.4, 27.7, 14.4
			if self.vb.mawCount % 3 == 0 then
				timerIncineratingMawsCD:Start(27.8, self.vb.breathCount+1)
			elseif self.vb.mawCount % 3 == 2 then
				timerIncineratingMawsCD:Start(24.4, self.vb.breathCount+1)
			else
				timerIncineratingMawsCD:Start(14.4, self.vb.breathCount+1)
			end
		else--Heroic
			timerIncineratingMawsCD:Start(25, self.vb.mawCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 408839 then
		local amount = args.amount or 1
		heatStacks[args.destName] = amount
		if args:IsPlayer() then
			if amount >= 35 then--Emphasize at higher stacks
				specWarnHeatStacks:Show(amount)
				specWarnHeatStacks:Play("stackhigh")
			elseif amount % 4 == 0 then--(4, 8, 12, 16) Otherwise, don't spam elevated warning
				warnHeatStacks:Show(amount)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(heatStacks)
		end
	elseif spellId == 407879 then
		if self:AntiSpam(3, 1) then
			specWarnBlazingTantrum:Show()
			specWarnBlazingTantrum:Play("moveboss")
		end
		if self.Options.NPAuraOnTantrum then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 408955 then
		local amount = args.amount or 1
		if amount % 3 == 0 then--Boss applies 3 stacks per cast
			if args:IsPlayer() then
				if amount >= 6 then--Only big alert if other tank misses a swap
					specWarnIncineratingMaws:Show(amount)
					specWarnIncineratingMaws:Play("stackhigh")
				else
					warnIncineratingMaws:Show(args.destName, amount)
				end
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				local timerLeft = timerIncineratingMawsCD:GetRemaining(self.vb.mawCount+1) or 14.4
				if (not remaining or remaining and remaining < timerLeft) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnIncineratingMawsSwap:Show(args.destName)
					specWarnIncineratingMawsSwap:Play("tauntboss")
				else
					warnIncineratingMaws:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 402994 then
		local icon = self.vb.spitIcon
		if self.Options.SetIconOnMoltenSpittle then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMoltenSpittle:Show()
			specWarnMoltenSpittle:Play("targetyou")
			local text = L.pool:format(icon, icon)--<icon> Pool 1,2,3
			yellMoltenSpittle:Say(text)--Non soak uses white text per conventions
			yellMoltenSpittleFades:CountdownSay(spellId, nil, icon)--Non soak uses white text per conventions
		end
		warnMoltenSpittle:CombinedShow(0.3, self.vb.spitCount, args.destName)
		self.vb.spitIcon = self.vb.spitIcon + 1
	elseif spellId == 411149 then--Mythic specific extra id
		if self.Options.SetIconOnMoltenSpittle then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnMoltenSpittle:Show()
			specWarnMoltenSpittle:Play("gathershare")
			--Might need to be 4, 8, i forget arg order
			yellMoltenSpittle:Yell(L.soakpool)
			yellMoltenSpittleFades:Countdown(spellId, nil, 8)--Soak version uses red text per conventions
		end
		warnMoltenSpittle:CombinedShow(0.3, self.vb.spitCount, args.destName)
	elseif (spellId == 406712 or spellId == 411633) and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 408839 then
		heatStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(heatStacks)
		end
	elseif spellId == 407879 then
		if self.Options.NPAuraOnTantrum then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 402994 or spellId == 411149 then
		if self.Options.SetIconOnMoltenSpittle then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMoltenSpittleFades:Cancel()
		end
	end
end

do
	local lastPower = 0
	function mod:UNIT_POWER_UPDATE(uId)
		local bossPower = UnitPower(uId) --Get Boss Power
		if bossPower-lastPower > 2 then--Boss gained an energy spike, because he should only gain 1 energy per second
			--So update timer
			DBM:Debug("Power gain detected. Updating Cata timer.")
			timerCatastrophicCD:RemoveTime(17)
		end
		lastPower = bossPower
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 406712 or spellId == 411633) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
