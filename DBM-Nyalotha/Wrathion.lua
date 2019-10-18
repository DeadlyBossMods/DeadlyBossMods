local mod	= DBM:NewMod(2368, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156818)
mod:SetEncounterID(2329)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)--Unknown number of burning targets, guessed for now
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 313973 306289 306735 306995",
	"SPELL_CAST_SUCCESS 306111 306289 313253",
	"SPELL_AURA_APPLIED 306015 306163 313250 313175 307013 309733 314347",
	"SPELL_AURA_APPLIED_DOSE 306015 313250",
	"SPELL_AURA_REMOVED 306163 313175 307013 309733 306995",
	"SPELL_PERIODIC_DAMAGE 306824 307053",
	"SPELL_PERIODIC_MISSED 306824 307053",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, update tank stacks if 2 isn't right. Also to do, if the 3 tank check is overkill or not, for now, might as well go all in
--TODO, does range check always need to be up or just show it during gale blast?
--TODO, best boss phase detection
--TODO, more stuff with Stage 2 adds, maybe timers for their spawns, and spawn announces? Warnings for their ambushes?
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: The Black Emperor
local warnSearingArmor						= mod:NewStackAnnounce(306015, 2, nil, "Tank")
local warnIncineration						= mod:NewTargetAnnounce(306111, 3)
local warnCreepingMadness					= mod:NewTargetAnnounce(313250, 2)
--Stage Two: Smoke and Mirrors
local warnBurningMadness					= mod:NewTargetNoFilterAnnounce(307013, 1)
local warnSap								= mod:NewTargetNoFilterAnnounce(314347, 3, nil, false)--off by default, assumed it'll be spammy

--Stage One: The Black Emperor
local specWarnSearingArmorStack				= mod:NewSpecialWarningStack(306015, nil, 2, nil, nil, 1, 6)
local specWarnSearingArmor					= mod:NewSpecialWarningTaunt(306015, nil, nil, nil, 1, 2)
local specWarnIncineration					= mod:NewSpecialWarningMoveAway(306111, nil, nil, nil, 1, 2)
local yellIncineration						= mod:NewYell(306111)
local yellIncinerationFades					= mod:NewShortFadesYell(306111)
local specWarnGaleBlast						= mod:NewSpecialWarningDodge(306289, nil, nil, nil, 2, 2)
local specWarnBurningCataclysm				= mod:NewSpecialWarningCount(306735, nil, nil, nil, 2, 2)
local specWarnCreepingMadness				= mod:NewSpecialWarningStopMove(313250, nil, nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(306824, nil, nil, nil, 1, 8)
--Stage Two: Smoke and Mirrors
local specWarnScalesofWrathion				= mod:NewSpecialWarningSoak(308682, nil, nil, nil, 2, 2)

--Stage One: The Black Emperor
--mod:AddTimerLine(BOSS)
local timerSearingBreathCD					= mod:NewCDTimer(8.5, 313973, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerIncinerationCD					= mod:NewCDCountTimer(30.1, 306111, nil, nil, nil, 3)
local timerGaleBlastCD						= mod:NewNextTimer(91.2, 306289, nil, nil, nil, 2)
local timerBurningCataclysmCD				= mod:NewNextTimer(91.2, 306735, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
local timerBurningCataclysm					= mod:NewCastTimer(8, 306735, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerCreepingMadnessCD				= mod:NewAITimer(30.1, 313253, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON)
--Stage Two: Smoke and Mirrors

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 306289)
mod:AddInfoFrameOption(307013, true)
mod:AddSetIconOption("SetIconBurningMadness", 309733, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnHardenedCore", 313175)

mod.vb.cataCast = 0
mod.vb.incinerateCount = 0
mod.vb.phase = 1
local burningMadnessTargets = {}

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
					local _, _, count, _, _, burningExpireTime = DBM:UnitDebuff("player", 307013, 309733)
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
	self.vb.incinerateCount = 0
	self.vb.phase = 1
	table.wipe(burningMadnessTargets)
	timerSearingBreathCD:Start(8.1-delay)
	timerIncinerationCD:Start(33.2-delay)--SUCCESS
	timerGaleBlastCD:Start(55.7-delay)--START
	timerBurningCataclysmCD:Start(70.3-delay)--START
	if self:IsMythic() then
		timerCreepingMadnessCD:Start(1-delay)--SUCCESS
	end
	if self.Options.NPAuraOnHardenedCore then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
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
	if spellId == 313973 then
		timerSearingBreathCD:Start()
	elseif spellId == 306289 and self:AntiSpam(5, 1) then
		specWarnGaleBlast:Show()
		specWarnGaleBlast:Play("watchstep")
		timerGaleBlastCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 306735 then
		self.vb.cataCast = self.vb.cataCast + 1
		specWarnBurningCataclysm:Show(self.vb.cataCast)
		specWarnBurningCataclysm:Play("specialsoon")
		timerBurningCataclysm:Start()
		timerBurningCataclysmCD:Start()
	elseif spellId == 306995 and self.vb.phase == 1 then--P2
		self.vb.phase = 2
		timerSearingBreathCD:Stop()
		timerIncinerationCD:Stop()
		timerGaleBlastCD:Stop()
		timerBurningCataclysmCD:Stop()
		timerCreepingMadnessCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 306111 then
		self.vb.incinerateCount = self.vb.incinerateCount + 1
		local timer = self.vb.incinerateCount == 1 and 55 or self.vb.incinerateCount == 2 and 47.5
		if timer then
			timerIncinerationCD:Start(timer, self.vb.incinerateCount+1)
		end
	elseif spellId == 306289 and self:AntiSpam(5, 2) then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 313253 then
		timerCreepingMadnessCD:Start()
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
		warnIncineration:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnIncineration:Show()
			specWarnIncineration:Play("runout")
			yellIncineration:Yell()
			yellIncinerationFades:Countdown(spellId)
		end
	elseif spellId == 313250 then
		local amount = args.amount or 1
		if amount == 1 then--Initial applications
			warnCreepingMadness:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() and amount == 1 or (amount % 10 == 0) then--Warn on apply and every 10 stacks
			specWarnCreepingMadness:Show()
			specWarnCreepingMadness:Play("stopmove")
		end
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
		warnPhase:Show()
		warnPhase:Play("phasechange")
		timerSearingBreathCD:Start(2)
		timerIncinerationCD:Start(2)
		timerGaleBlastCD:Start(2)
		timerBurningCataclysmCD:Start(2)
		if self:IsMythic() then
			timerCreepingMadnessCD:Start(2)
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
function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 160291 then--ashwalker-assassin

	elseif cid == 158327--crackling-shard

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 308797 and self.vb.phase == 1 then--Scales of Wrathion (or maybe 306998/energy-recharge-phase-b)
		specWarnScalesofWrathion:Show()
		specWarnScalesofWrathion:Play("helpsoak")
	elseif spellId == 312389 then--Create Assassins

	end
end
