local mod	= DBM:NewMod(2368, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156818)
mod:SetEncounterID(2329)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)--Unknown number of burning targets, guessed for now
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 306289 306735 306995 305978",
	"SPELL_CAST_SUCCESS 306111 306289 313253",
	"SPELL_AURA_APPLIED 306015 306163 313175 307013 314347 309733",
	"SPELL_AURA_APPLIED_DOSE 306015",
	"SPELL_AURA_REMOVED 306163 313175 307013 306995 309733",
	"SPELL_PERIODIC_DAMAGE 306824 307053",
	"SPELL_PERIODIC_MISSED 306824 307053",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, update tank stacks if 2 isn't right. Also to do, if the 3 tank check is overkill or not, for now, might as well go all in
--TODO, does range check always need to be up or just show it during gale blast?
--TODO, more stuff with Stage 2 adds, maybe timers for their spawns, and spawn announces? Warnings for their ambushes?
--[[
(ability.id = 305978 or ability.id = 306289 or ability.id = 306735 or ability.id = 306995) and type = "begincast"
 or (ability.id = 306111) and type = "cast"
 or ability.id = 306995
 --]]
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: The Black Emperor
local warnSearingArmor						= mod:NewStackAnnounce(306015, 2, nil, "Tank")
local warnIncineration						= mod:NewTargetAnnounce(306111, 3)
--Stage Two: Smoke and Mirrors
local warnScales							= mod:NewSpellAnnounce(308682, 2)
local warnBurningMadness					= mod:NewTargetNoFilterAnnounce(307013, 1)
local warnSap								= mod:NewTargetNoFilterAnnounce(314347, 3, nil, false)--off by default, assumed it'll be spammy

--Stage One: The Black Emperor
local specWarnSearingArmorStack				= mod:NewSpecialWarningStack(306015, nil, 2, nil, nil, 1, 6)
local specWarnSearingArmor					= mod:NewSpecialWarningTaunt(306015, nil, nil, nil, 1, 2)
local specWarnIncineration					= mod:NewSpecialWarningMoveAway(306111, nil, nil, nil, 1, 2)
local yellIncineration						= mod:NewYell(306111)
local yellIncinerationFades					= mod:NewShortFadesYell(306111)
local specWarnGaleBlast						= mod:NewSpecialWarningDodgeCount(306289, nil, nil, nil, 2, 2)
local specWarnBurningCataclysm				= mod:NewSpecialWarningCount(306735, nil, 138565, nil, 2, 2)
--local specWarnCreepingMadness				= mod:NewSpecialWarningStack(313250, nil, 32, nil, nil, 1, 2, 4)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(306824, nil, nil, nil, 1, 8)
--Stage Two: Smoke and Mirrors
local warnSpawnAdds							= mod:NewSpellAnnounce(312389, 2)

--Stage One: The Black Emperor
local timerSearingBreathCD					= mod:NewCDTimer(8.5, 305978, 18620, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerIncinerationCD					= mod:NewCDCountTimer(19.4, 306111, nil, nil, nil, 3)--19-24 variation even when not delayed by other casts
local timerGaleBlastCD						= mod:NewCDCountTimer(90.9, 306289, nil, nil, nil, 2)
local timerBurningCataclysmCD				= mod:NewCDCountTimer(90.9, 306735, 138565, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
local timerBurningCataclysm					= mod:NewCastTimer(8, 306735, 138565, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Two: Smoke and Mirrors
local timerSmokeandMirrorsCD				= mod:NewNextTimer(155, 306995, nil, nil, nil, 6)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 306289)
mod:AddInfoFrameOption(307013, true)
mod:AddSetIconOption("SetIconBurningMadness", 307013, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnHardenedCore", 313175)

mod.vb.cataCast = 0
mod.vb.incinerateCount = 0
mod.vb.galeCount = 0
mod.vb.phase = 1
local burningMadnessTargets = {}
local incinerateTimers = {9.1, 19.5, 44.8, 19.4, 21.9}--Lowest in the variations
local mythicincinerateTimers = {28.6, 71.6}
--[[
--Pull incinerate Timers
14, 24.7, 44.8, 19.5, 22
9.4, 20.7, 53.7, 19.5, 21.9
9.2, 19.5, 56.1, 19.4, 21.9

--After Smoke and MIrrors incinerate Timers
13.3, 24.4, 46.2
9.7, 23.8, 52.4, 19.4, 21.8
9.1, 24.4,
--]]

local updateInfoFrame
do
	local burningMadness = DBM:GetSpellInfo(307013)
	local floor = math.floor
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Wrathion Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--BurningMadness
		if #burningMadnessTargets > 0 then
			addLine("---"..burningMadness.."---")
			for i=1, #burningMadnessTargets do
				local name = burningMadnessTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, count, _, _, burningExpireTime = DBM:UnitDebuff(uId, 307013)
					if burningExpireTime then
						local remaining = burningExpireTime-GetTime()
						if count then--Cleanup this nil check if count actually returns
							addLine(i.."*"..name, count.."-"..floor(remaining))
						else
							addLine(i.."*"..name, floor(remaining))
						end
					end
				end
			end
		end
		--TODO, 311362/rising-heat tracker?
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.cataCast = 0
	self.vb.galeCount = 0
	self.vb.incinerateCount = 0
	self.vb.phase = 1
	table.wipe(burningMadnessTargets)
	timerSearingBreathCD:Start(7-delay)--7-13
	if self:IsMythic() then
		timerIncinerationCD:Start(28.6-delay, 1)--SUCCESS
	else
		timerIncinerationCD:Start(9.1-delay, 1)--SUCCESS
	end
	timerGaleBlastCD:Start(45-delay, 1)--45-50 START
	timerBurningCataclysmCD:Start(59.7-delay, 1)--START
	timerSmokeandMirrorsCD:Start(155-delay)
	if self.Options.NPAuraOnHardenedCore then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame and self:IsMythic() then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(313255))
		DBM.InfoFrame:Show(6, "playerdebuffstacks", 313255)--Sorted lowest first (highest first is default of arg not given)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnHardenedCore then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 305978 then
		timerSearingBreathCD:Start()
	elseif spellId == 306289 and self:AntiSpam(5, 1) then
		self.vb.galeCount = self.vb.galeCount + 1
		specWarnGaleBlast:Show(self.vb.galeCount)
		specWarnGaleBlast:Play("watchstep")
		if self.vb.galeCount == 1 then
			timerGaleBlastCD:Start(74.3, 2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 306735 then
		self.vb.cataCast = self.vb.cataCast + 1
		specWarnBurningCataclysm:Show(self.vb.cataCast)
		specWarnBurningCataclysm:Play("specialsoon")
		timerBurningCataclysm:Start()
		if self.vb.cataCast == 1 then
			timerBurningCataclysmCD:Start(75.6, 2)--75-77.32
		end
	elseif spellId == 306995 and self.vb.phase == 1 then--P2 Smoke and Mirrors
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerSearingBreathCD:Stop()
		timerIncinerationCD:Stop()
		timerGaleBlastCD:Stop()
		timerBurningCataclysmCD:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 306111 then
		self.vb.incinerateCount = self.vb.incinerateCount + 1
		local timer = self:IsMythic() and mythicincinerateTimers[self.vb.incinerateCount+1] or not self:IsMythic() and incinerateTimers[self.vb.incinerateCount+1]
		if timer then
			timerIncinerationCD:Start(timer, self.vb.incinerateCount+1)
		end
	elseif spellId == 306289 and self:AntiSpam(5, 2) then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 306015 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
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
			else
				warnSearingArmor:Show(args.destName, amount)
			end
		end
	elseif spellId == 306163 then
		warnIncineration:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnIncineration:Show()
			specWarnIncineration:Play("runout")
			yellIncineration:Yell()
			yellIncinerationFades:Countdown(spellId)
		end
	--[[elseif spellId == 313250 then
		local amount = args.amount or 1
		if args:IsPlayer() and (amount == 30 or amount >= 40) and self:AntiSpam(4, 3) then
			specWarnCreepingMadness:Show(amount)
			specWarnCreepingMadness:Play("stackhigh")
		end--]]
	elseif spellId == 313175 then
		if self.Options.NPAuraOnHardenedCore then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 307013 or spellId == 309733 then
		warnBurningMadness:CombinedShow(1, args.destName)
		if not tContains(burningMadnessTargets, args.destName) then
			table.insert(burningMadnessTargets, args.destName)
		end
		if self.Options.SetIconBurningMadness then
			self:SetIcon(args.destName, #burningMadnessTargets)
		end
	elseif spellId == 314347 then
		warnSap:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 306163 then
		if args:IsPlayer() then
			yellIncinerationFades:Cancel()
		end
	elseif spellId == 313175 then
		if self.Options.NPAuraOnHardenedCore then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 307013 or spellId == 309733 then
		tDeleteItem(burningMadnessTargets, args.destName)
		if self.Options.SetIconBurningMadness then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 306995 then
		self.vb.phase = 1
		self.vb.cataCast = 0
		self.vb.galeCount = 0
		self.vb.incinerateCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerSearingBreathCD:Start(7.3)
		if self:IsMythic() then
			timerIncinerationCD:Start(28.6, 1)
		else
			timerIncinerationCD:Start(9.1, 1)--SUCCESS 9.1-14
		end
		timerGaleBlastCD:Start(45, 1)
		timerBurningCataclysmCD:Start(59.7, 1)
		timerSmokeandMirrorsCD:Start(155)
		if self.Options.InfoFrame then
			if self:IsMythic() then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(313255))
				DBM.InfoFrame:Show(6, "playerdebuffstacks", 313255)
			else
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 306824 or spellId == 307053) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 160291 then--ashwalker-assassin

	elseif cid == 158327--crackling-shard

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 308797 then--Scales of Wrathion
		warnScales:Show()
	elseif spellId == 312389 then--Create Assassins
		warnSpawnAdds:Show()
	end
end
