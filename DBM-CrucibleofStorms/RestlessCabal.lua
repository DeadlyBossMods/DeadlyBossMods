local mod	= DBM:NewMod(2328, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144755, 144754)--144755 Zaxasj, 144754 Fa'thuul
mod:SetEncounterID(2269)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)--Refine when max number of doubt targets is known
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282675 282589 282515 282517 282617 283540 282621 285154",
	"SPELL_CAST_SUCCESS 282561 282384 282407 285416 283066",
	"SPELL_AURA_APPLIED 282741 282742 282914 283524 282386 282540 282561 282384 282432 287876 282621 282566",
	"SPELL_AURA_APPLIED_DOSE 282384 282566 282386",
	"SPELL_AURA_REFRESH 282384 282386",
	"SPELL_AURA_REMOVED 282741 282742 282386 282561 282432 282741 282621 282566",
	"SPELL_SUMMON 282515",
--	"SPELL_PERIODIC_DAMAGE 287876",
--	"SPELL_PERIODIC_MISSED 287876",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Relics assumed, if not boss unitIDs, remove boss3-5
)

--TODO: add general announce for embrace of the void? it seems pretty given, it's more of a healer track on raid frames thing than a DBM thing
--TODO, refine AbyssalCollapse for situations like do we cancel bar if shield gets completely depleted, etc
--TODO, see if relics hard reset boss cd timers or if they just get paused, or if nothing affects them at all
--TODO, fine tune tank swap stacks (changed to 3, but many strats may favor doing 2-5 to reduce add spawn complexity and tank damage. Probably will just add a drop down)
--TODO, detect void crash bounces, use general announce for cast and first bounce, special warning for one that needs soaking?
--[[
(ability.id = 282675 or ability.id = 282589 or ability.id = 282515 or ability.id = 282617 or ability.id = 282517 or ability.id = 283540 or ability.id = 282621 or ability.id = 282818 or ability.id = 285154) and type = "begincast"
 or (ability.id = 282561 or ability.id = 282384 or ability.id = 282407 or ability.id = 285416 or ability.id = 283066 or ability.id = 282742) and type = "cast"
 or (ability.id = 282817 or ability.id = 282432) and type = "applydebuff"
--]]
--Relics of Power
local warnUmbralShell					= mod:NewFadesAnnounce(282741, 1)
local warnCustodyoftheDeep				= mod:NewCountAnnounce(284772, 3)
--General
local warnPact							= mod:NewCastAnnounce(282675, 4)
--Zaxasj the Speaker
local warnDarkHeraldFaded				= mod:NewFadesAnnounce(282561, 1)
local warnDarkHerald					= mod:NewTargetNoFilterAnnounce(282561, 3)
--Fa'thuul the Feared
local warnShearMind						= mod:NewStackAnnounce(282384, 2, nil, "Tank")
local warnVoidCrash						= mod:NewSpellAnnounce(285416, 2)
local warnCrushingDoubt					= mod:NewTargetAnnounce(282432, 2)

--Relics of Power
local specWarnUmbralShell				= mod:NewSpecialWarningTargetChange(282741, "Dps", nil, nil, 1, 2)
local specWarnStormofAnnihilation		= mod:NewSpecialWarningSpell(286755, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelming			= mod:NewSpecialWarningTarget(282914, nil, nil, nil, 3)--A wipe basically
--Zaxasj the Speaker
local specWarnAphoticBlast				= mod:NewSpecialWarningYou(282386, false, nil, 2, 1, 2)
local yellAphoticBlast					= mod:NewFadesYell(282386)
local specWarnAgentofDemise				= mod:NewSpecialWarningTargetChange(282540, "-Healer", nil, nil, 1, 2)
local yellAgentofDemise					= mod:NewYell(282540, nil, nil, nil, "YELL")
local specWarnCerebralAssault			= mod:NewSpecialWarningDodgeCount(282589, nil, nil, nil, 3, 2)
local specWarnDarkherald				= mod:NewSpecialWarningYou(282561, nil, nil, nil, 1, 2)
local yellDarkherald					= mod:NewYell(282561)
local specWarnPowerStack				= mod:NewSpecialWarningStack(282566, nil, 6, nil, nil, 1, 6)
local specWarnVisagefromBeyond			= mod:NewSpecialWarningSwitch(282515, "-Healer", nil, nil, 1, 2)
--Fa'thuul the Feared
local specWarnShearMind					= mod:NewSpecialWarningStack(282384, nil, 3, nil, nil, 1, 6)
local specWarnShearMindTaunt			= mod:NewSpecialWarningTaunt(282384, nil, nil, nil, 1, 2)
local specWarnCrushingDoubt				= mod:NewSpecialWarningYouPos(282432, nil, nil, nil, 1, 2)
local yellCrushingDoubt					= mod:NewPosYell(282432)
local yellCrushingDoubtFades			= mod:NewIconFadesYell(282432)
local specWarnEldritchRevelation		= mod:NewSpecialWarningSwitch(282617, false, nil, 2, 1, 2)
local specWarnWitnesstheEnd				= mod:NewSpecialWarningInterruptCount(282621, false, nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(287876, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerAbyssalCollapse				= mod:NewCastTimer(20, 282886, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerStormofAnnihilation			= mod:NewCastTimer(15, 286755, 196871, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--Short text "Storm"
local timerPact							= mod:NewCastSourceTimer(12, 282675, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
local timerVisageActive					= mod:NewBuffActiveTimer(60, 282515, nil, nil, nil, 1)
--Zaxasj the Speaker
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18974))
local timerCerebralAssaultCD			= mod:NewCDCountTimer(31.5, 282589, nil, nil, nil, 3, nil, nil, nil, 1, 5)--inlineIcon, keep, countdown, countdownMax
local timerDarkherald					= mod:NewTargetTimer(20, 282561, nil, nil, nil, 5)
local timerDarkheraldCD					= mod:NewCDCountTimer(32.7, 282561, nil, nil, nil, 3, nil, nil, nil, 3, 3)
local timerTerrifyingEcho				= mod:NewCastTimer(15, 282517, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Fa'thuul the Feared
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18983))
local timerShearMindCD					= mod:NewCDTimer(8.4, 282384, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerVoidCrashCD					= mod:NewCDTimer(13.3, 285416, nil, nil, nil, 3)
local timerCrushingDoubtCD				= mod:NewCDCountTimer(40.1, 282432, nil, nil, nil, 3, nil, nil, nil, 2, 3)

local berserkTimer						= mod:NewBerserkTimer(780)

mod:AddSetIconOption("SetIconCrushingDoubt", 282432, true, false, {1, 2})
mod:AddSetIconOption("SetIconDarkherald", 282561, true, false, {6})
mod:AddSetIconOption("SetIconOnAdds", 282617, true, true, {3, 4, 5})
mod:AddRangeFrameOption(6, 283524)
mod:AddInfoFrameOption(282741, true)
mod:AddNamePlateOption("NPAuraOnEcho", 282517)

--mod.vb.phase = 1
mod.vb.shieldCount = 0
mod.vb.assaultCount = 0
mod.vb.heraldCount = 0
mod.vb.crushingDoubtCount = 0
mod.vb.CrushingDoubtIcon = 1
mod.vb.addIcon = 3
mod.vb.umbrelTarget = nil
mod.vb.heraldTarget = nil
local castsPerGUID = {}
local playerWitness = false
local playerPromise = false

local updateInfoFrame
do
	local heraldName, UmbrelShield = DBM:GetSpellInfo(282561), DBM:GetSpellInfo(282741)
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
		--Umbral Absorb Check
		if mod.vb.umbrelTarget then
			local absorbAmount = select(16, DBM:UnitDebuff(mod.vb.umbrelTarget, 282741))
			if absorbAmount then
				addLine(UmbrelShield, math.floor(absorbAmount))
			end
		end
		--Witness the End tracker
		if playerWitness then
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 282621)
			local remaining = expireTime-GetTime()
			if spellName and expireTime then
				addLine(DBM_CORE_DEADLY_ICON..spellName, math.floor(remaining))
			end
		end
		--Herald
		if mod.vb.heraldTarget then
			addLine(heraldName, mod.vb.heraldTarget)
		end
		--Personal Promise of Power
		if playerPromise then
			local spellName2, _, currentStack2 = DBM:UnitDebuff("player", 282566)
			if spellName2 and currentStack2 then
				addLine(spellName2, currentStack2)
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.shieldCount = 0
	self.vb.assaultCount = 0
	self.vb.heraldCount = 0
	self.vb.crushingDoubtCount = 0
	self.vb.CrushingDoubtIcon = 1
	self.vb.addIcon = 3
	self.vb.umbrelTarget = nil
	self.vb.heraldTarget = nil
	playerWitness = false
	playerPromise = false
	--Zaxasj the Speaker
	if not self:IsLFR() then
		timerDarkheraldCD:Start(14-delay, 1)--SUCCESS
		if self:IsMythic() then
			timerCerebralAssaultCD:Start(15-delay, 1)
		else
			timerCerebralAssaultCD:Start(30-delay, 1)
		end
	else--LFR
		timerCerebralAssaultCD:Start(32.4-delay, 1)
	end
	--Fa'thuul the Feared
	timerShearMindCD:Start(8.4-delay)--SUCCESS
	timerVoidCrashCD:Start(13-delay)--SUCCESS
	timerCrushingDoubtCD:Start(18.1-delay, 1)
	berserkTimer:Start(self:IsMythic() and 570 or 780-delay)--Mythic and normal berserks verified. LFR still unknown if bererks at 13 min.
	if self.Options.NPAuraOnPresence then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(10, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 282621) then
		playerWitness = true
	end
	if DBM:UnitDebuff("player", 282566) then
		playerPromise = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282675 then
		warnPact:Show()
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		--146497 Zaxasj, 146495 Fa'thuul
		if cid == 146497 then
			timerPact:Start(12, L.Zaxasj)
		else
			timerPact:Start(12, L.Fathuul)
		end
	elseif spellId == 282589 or spellId == 285154 then
		self.vb.assaultCount = self.vb.assaultCount + 1
		specWarnCerebralAssault:Show(self.vb.assaultCount)
		specWarnCerebralAssault:Play("shockwave")
		local timer = self:IsMythic() and 31.5 or 41.5
		timerCerebralAssaultCD:Start(timer, self.vb.assaultCount+1)
	elseif spellId == 282515 then
		specWarnVisagefromBeyond:Show()
		specWarnVisagefromBeyond:Play("bigmob")
	elseif spellId == 282617 then
		specWarnEldritchRevelation:Show()
		specWarnEldritchRevelation:Play("bigmob")
	elseif spellId == 282517 then
		timerTerrifyingEcho:Start()
		if self.Options.NPAuraOnEcho then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 15)
		end
	elseif (spellId == 283540 or spellId == 282621) then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon == 6 then--3-5 (to match markers bw uses)
				self.vb.addIcon = 3
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWitnesstheEnd:Show(args.sourceName, count)
			if count == 1 then
				specWarnWitnesstheEnd:Play("kick1r")
			elseif count == 2 then
				specWarnWitnesstheEnd:Play("kick2r")
			elseif count == 3 then
				specWarnWitnesstheEnd:Play("kick3r")
			elseif count == 4 then
				specWarnWitnesstheEnd:Play("kick4r")
			elseif count == 5 then
				specWarnWitnesstheEnd:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnWitnesstheEnd:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282561 then
		self.vb.heraldCount = self.vb.heraldCount + 1
		local timer = self:IsMythic() and 18.2 or 32.7
		timerDarkheraldCD:Start(timer, self.vb.heraldCount+1)--Kept here because boss can stutter cast so START is bad place to start timer
	elseif spellId == 282384 then
		timerShearMindCD:Start()
	elseif spellId == 282407 or spellId == 285416 then
		warnVoidCrash:Show()
		timerVoidCrashCD:Start()
	elseif spellId == 283066 then
		self.vb.shieldCount = self.vb.shieldCount + 1
		warnCustodyoftheDeep:Show(self.vb.shieldCount)
		timerAbyssalCollapse:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282741 then
		self.vb.umbrelTarget = DBM:GetEnemyUnitIdByGUID(args.destGUID)
		local cid = self:GetCIDFromGUID(args.destGUID)
		--146497 Zaxasj, 146495 Fa'thuul
		if cid == 146497 then
			specWarnUmbralShell:Show(L.Zaxasj)
		else
			specWarnUmbralShell:Show(L.Fathuul)
		end
		specWarnUmbralShell:Play("attackshield")
	elseif spellId == 282742 then
		specWarnStormofAnnihilation:Show()
		specWarnStormofAnnihilation:Play("aesoon")
		timerStormofAnnihilation:Start()
	elseif spellId == 282914 then
		specWarnPowerOverwhelming:Show(args.destName)
	elseif spellId == 283524 or spellId == 282386 then
		if args:IsPlayer() then
			if spellId == 282386 then--Heroic/Mythic
				local amount = args.amount or 1
				if amount == 1 then
					specWarnAphoticBlast:Show()
					specWarnAphoticBlast:Play("targetyou")
				end
				yellAphoticBlast:Cancel()
				yellAphoticBlast:Countdown(spellId)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
		end
	elseif spellId == 282540 then
		if not args:IsPlayer() then
			specWarnAgentofDemise:CombinedShow(1, args.destName)
			specWarnAgentofDemise:ScheduleVoice(1, "targetchange")
		else
			yellAgentofDemise:Yell()
		end
	elseif spellId == 282561 then
		timerDarkherald:Start(args.destName)
		self.vb.heraldTarget = args.destName
		if args:IsPlayer() then
			specWarnDarkherald:Show()
			specWarnDarkherald:Play("targetyou")
			yellDarkherald:Yell()
		else
			warnDarkHerald:Show(args.destName)
		end
		if self.Options.SetIconDarkherald then
			self:SetIcon(args.destName, 6)
		end
	elseif spellId == 282384 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnShearMind:Show(amount)
					specWarnShearMind:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off and aren't dealing with an add
						specWarnShearMindTaunt:Show(args.destName)
						specWarnShearMindTaunt:Play("tauntboss")
					else
						warnShearMind:Show(args.destName, amount)
					end
				end
			else
				warnShearMind:Show(args.destName, amount)
			end
		end
	elseif spellId == 282432 then
		warnCrushingDoubt:CombinedShow(1, args.destName)
		local icon = self.vb.CrushingDoubtIcon
		if args:IsPlayer() then
			specWarnCrushingDoubt:Show(self:IconNumToTexture(icon))
			specWarnCrushingDoubt:Play("mm"..icon)
			yellCrushingDoubt:Yell(icon, icon, icon)
			yellCrushingDoubtFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconCrushingDoubt then
			self:SetIcon(args.destName, icon)
		end
		self.vb.CrushingDoubtIcon = self.vb.CrushingDoubtIcon + 1
	elseif spellId == 287876 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")--This particular case it's not a watch feet GTFO, it's a run away since you're too far into darkness
	elseif spellId == 282621 and args:IsPlayer() then
		playerWitness = true
	elseif spellId == 282566 and args:IsPlayer() then
		playerPromise = true
		local amount = args.amount or 1
		if amount >= 6 then
			specWarnPowerStack:Show(amount)
			specWarnPowerStack:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282741 then
		self.vb.umbrelTarget = nil
		warnUmbralShell:Show()
	elseif spellId == 282742 then
		timerStormofAnnihilation:Stop()
	elseif spellId == 282386 then
		if args:IsPlayer() then
			yellAphoticBlast:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 282561 then
		self.vb.heraldTarget = nil
		timerDarkherald:Stop(args.destName)
		if args:IsPlayer() then
			warnDarkHeraldFaded:Show()
		end
		if self.Options.SetIconDarkherald then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 282432 then
		if self.Options.SetIconCrushingDoubt then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 282621 and args:IsPlayer() then
		playerWitness = false
	elseif spellId == 282566 and args:IsPlayer() then
		playerPromise = false
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 282515 then
		local timer = self:IsMythic() and 120 or self:IsHeroic() and 90
		if timer then
			timerVisageActive:Start(timer, args.destGUID)
		end
	end
end


--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 287876 and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144996 then--Visage from beyond
		timerTerrifyingEcho:Stop()
		if self.Options.NPAuraOnEcho then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
		timerVisageActive:Stop(args.destGUID)
	elseif cid == 145053 then--Eldritch Abomination
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 287762 then--Crushing Doubt
		self.vb.CrushingDoubtIcon = 1
		self.vb.crushingDoubtCount = self.vb.crushingDoubtCount + 1
		local timer = self:IsMythic() and 45 or 60.1
		timerCrushingDoubtCD:Start(timer, self.vb.crushingDoubtCount+1)
	end
end
