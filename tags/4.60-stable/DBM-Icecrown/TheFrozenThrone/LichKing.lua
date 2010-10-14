local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36597)
mod:RegisterCombat("combat")
mod:SetMinSyncRevision(3913)
mod:SetUsedIcons(2, 3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DISPEL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SWING_DAMAGE",
	"SWING_MISSED"
)

local isPAL = select(2, UnitClass("player")) == "PALADIN"
local isPRI = select(2, UnitClass("player")) == "PRIEST"

local warnRemorselessWinter = mod:NewSpellAnnounce(74270, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetAnnounce(69200, 3) --Transition Add
local warnShamblingSoon		= mod:NewSoonAnnounce(70372, 2) --Phase 1 Add
local warnShamblingHorror	= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls		= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage	= mod:NewTargetAnnounce(72143, 3, nil, mod:IsHealer() or mod:IsTank() or mod:CanRemoveEnrage()) --Phase 1 Add Ability
local warnNecroticPlague	= mod:NewTargetAnnounce(73912, 4) --Phase 1+ Ability
local warnNecroticPlagueJump= mod:NewAnnounce("WarnNecroticPlagueJump", 4, 73912) --Phase 1+ Ability
local warnInfest			= mod:NewSpellAnnounce(73779, 3, nil, mod:IsHealer()) --Phase 1 & 2 Ability
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
local valkyrWarning			= mod:NewAnnounce("ValkyrWarning", 3, 71844)--Phase 2 Ability
local warnDefileSoon		= mod:NewSoonAnnounce(73708, 3)	--Phase 2+ Ability
local warnSoulreaper		= mod:NewSpellAnnounce(73797, 4, nil, mod:IsTank() or mod:IsHealer()) --Phase 2+ Ability
local warnDefileCast		= mod:NewTargetAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3, 71844) --Phase 2 Add
local warnPhase3Soon		= mod:NewAnnounce("WarnPhase3Soon", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul		= mod:NewTargetAnnounce(74325, 4) --Phase 3 Ability
local warnTrapCast			= mod:NewTargetAnnounce(73539, 3) --Phase 1 Heroic Ability
local warnRestoreSoul		= mod:NewCastAnnounce(73650, 2) --Phase 3 Heroic

local specWarnSoulreaper	= mod:NewSpecialWarningYou(73797) --Phase 1+ Ability
local specWarnNecroticPlague= mod:NewSpecialWarningYou(73912) --Phase 1+ Ability
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200) --Transition Add
local specWarnYouAreValkd	= mod:NewSpecialWarning("SpecWarnYouAreValkd") --Phase 2+ Ability
local specWarnPALGrabbed	= mod:NewSpecialWarning("SpecWarnPALGrabbed", nil, false) --Phase 2+ Ability
local specWarnPRIGrabbed	= mod:NewSpecialWarning("SpecWarnPRIGrabbed", nil, false) --Phase 2+ Ability
local specWarnDefileCast	= mod:NewSpecialWarning("SpecWarnDefileCast") --Phase 2+ Ability
local specWarnDefileNear	= mod:NewSpecialWarning("SpecWarnDefileNear", false) --Phase 2+ Ability
local specWarnDefile		= mod:NewSpecialWarningMove(73708) --Phase 2+ Ability
local specWarnWinter		= mod:NewSpecialWarningMove(73791) --Transition Ability
local specWarnHarvestSoul	= mod:NewSpecialWarningYou(74325) --Phase 3+ Ability
local specWarnInfest		= mod:NewSpecialWarningSpell(73779, false) --Phase 1+ Ability
local specwarnSoulreaper	= mod:NewSpecialWarningTarget(73797, mod:IsTank()) --phase 2+
local specWarnTrap			= mod:NewSpecialWarningYou(73539) --Heroic Ability
local specWarnTrapNear		= mod:NewSpecialWarning("SpecWarnTrapNear") --Heroic Ability
local specWarnHarvestSouls	= mod:NewSpecialWarningSpell(74297) --Heroic Ability
local specWarnValkyrLow		= mod:NewSpecialWarning("SpecWarnValkyrLow")

local timerCombatStart		= mod:NewTimer(53.5, "TimerCombatStart", 2457)
local timerPhaseTransition	= mod:NewTimer(62.5, "PhaseTransition", 72262)
local timerSoulreaper	 	= mod:NewTargetTimer(5.1, 73797, nil, mod:IsTank() or mod:IsHealer())
local timerSoulreaperCD	 	= mod:NewNextTimer(30.5, 73797, nil, mod:IsTank() or mod:IsHealer())
local timerHarvestSoul	 	= mod:NewTargetTimer(6, 74325)
local timerHarvestSoulCD	= mod:NewNextTimer(75, 74325)
local timerInfestCD			= mod:NewNextTimer(22.5, 73779, nil, mod:IsHealer())
local timerNecroticPlagueCleanse = mod:NewTimer(5, "TimerNecroticPlagueCleanse", 73912, false)
local timerNecroticPlagueCD	= mod:NewNextTimer(30, 73912)
local timerDefileCD			= mod:NewNextTimer(32.5, 72762)
local timerEnrageCD			= mod:NewCDTimer(20, 72143, nil, mod:IsTank() or mod:CanRemoveEnrage())
local timerShamblingHorror 	= mod:NewNextTimer(60, 70372)
local timerDrudgeGhouls 	= mod:NewNextTimer(20, 70358)
local timerRagingSpiritCD	= mod:NewNextTimer(22, 69200)
local timerSummonValkyr 	= mod:NewCDTimer(45, 71844)
local timerVileSpirit 		= mod:NewNextTimer(30.5, 70498)
local timerTrapCD		 	= mod:NewNextTimer(15.5, 73539)
local timerRestoreSoul 		= mod:NewCastTimer(40, 73650)
local timerRoleplay			= mod:NewTimer(162, "TimerRoleplay", 72350)

local berserkTimer			= mod:NewBerserkTimer(900)

local soundDefile			= mod:NewSound(72762)

mod:AddBoolOption("SpecWarnHealerGrabbed", mod:IsTank() or mod:IsHealer(), "announce")
mod:AddBoolOption("DefileIcon")
mod:AddBoolOption("NecroticPlagueIcon")
mod:AddBoolOption("RagingSpiritIcon")
mod:AddBoolOption("TrapIcon")
mod:AddBoolOption("ValkyrIcon")
mod:AddBoolOption("HarvestSoulIcon")
mod:AddBoolOption("YellOnDefile", true, "announce")
mod:AddBoolOption("YellOnTrap", true, "announce")
mod:AddBoolOption("AnnounceValkGrabs", false)
mod:AddBoolOption("AnnouncePlagueStack", false, "announce")
--mod:AddBoolOption("DefileArrow")
mod:AddBoolOption("TrapArrow")
mod:AddBoolOption("LKBugWorkaround", true)--Use old scan method without syncing or latency check (less reliable but not dependant on other DBM users in raid)

local phase	= 0
local lastPlagueCast = 0
local warned_preP2 = false
local warned_preP3 = false
local warnedValkyrGUIDs = {}
local LKTank

function mod:OnCombatStart(delay)
	phase = 0
	lastPlagueCast = 0
	warned_preP2 = false
	warned_preP3 = false
	LKTank = nil
	self:NextPhase()
	table.wipe(warnedValkyrGUIDs)
end

function mod:DefileTarget()
	local target = self:GetBossTarget(36597)
	if not target then return end
	if mod:LatencyCheck() then--Only send sync if you have low latency.
		self:SendSync("DefileOn", target)
	end
end

function mod:TankTrap()
	if mod:LatencyCheck() then
		self:SendSync("TrapOn", LKTank)
	end
end

function mod:TrapTarget()
	local targetname = self:GetBossTarget(36597)
	if not targetname then return end
	if targetname ~= LKTank then--If scan doesn't return tank abort other scans and do other warnings.
		self:UnscheduleMethod("TrapTarget")
		self:UnscheduleMethod("TankTrap")--Also unschedule tanktrap since we got a scan that returned a non tank.
		if mod:LatencyCheck() then
			self:SendSync("TrapOn", targetname)
		end
	else
		self:UnscheduleMethod("TankTrap")
		self:ScheduleMethod(1, "TankTrap") --If scan returns tank schedule warnings for tank after all other scans have completed. If none of those scans return another player this will be allowed to fire.
	end
end

--for those that want to avoid latency check.
function mod:OldDefileTarget()
	local targetname = self:GetBossTarget(36597)
	if not targetname then return end
		warnDefileCast:Show(targetname)
		if self.Options.DefileIcon then
			self:SetIcon(targetname, 8, 10)
		end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		soundDefile:Play()
		if self.Options.YellOnDefile then
			SendChatMessage(L.YellDefile, "SAY")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnDefileNear:Show()
--				if self.Options.DefileArrow then
--					DBM.Arrow:ShowRunAway(x, y, 15, 5)
--				end
			end
		end
	end
end

function mod:OldTankTrap()
	warnTrapCast:Show(LKTank)
	if self.Options.TrapIcon then
		self:SetIcon(LKTank, 8, 10)
	end
	if LKTank == UnitName("player") then
		specWarnTrap:Show()
		if self.Options.YellOnTrap then
			SendChatMessage(L.YellTrap, "SAY")
		end
	end
	local uId = DBM:GetRaidUnitId(LKTank)
	if uId ~= "none" then
		local inRange = CheckInteractDistance(uId, 2)
		local x, y = GetPlayerMapPosition(uId)
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition(uId)
		end
		if inRange then
			specWarnTrapNear:Show()
			if self.Options.TrapArrow then
				DBM.Arrow:ShowRunAway(x, y, 10, 5)
			end
		end
	end
end

function mod:OldTrapTarget()
	local targetname = self:GetBossTarget(36597)
	if not targetname then return end
	if targetname ~= LKTank then--If scan doesn't return tank abort other scans and do other warnings.
		self:UnscheduleMethod("OldTrapTarget")
		self:UnscheduleMethod("OldTankTrap")--Also unschedule tanktrap since we got a scan that returned a non tank.
		warnTrapCast:Show(targetname)
		if self.Options.TrapIcon then
			self:SetIcon(targetname, 8, 10)
		end
		if targetname == UnitName("player") then
			specWarnTrap:Show()
			if self.Options.YellOnTrap then
				SendChatMessage(L.YellTrap, "SAY")
			end
		end
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnTrapNear:Show()
				if self.Options.TrapArrow then
					DBM.Arrow:ShowRunAway(x, y, 10, 5)
				end
			end
		end
	else
		self:UnscheduleMethod("OldTankTrap")
		self:ScheduleMethod(1, "OldTankTrap") --If scan returns tank schedule warnings for tank after all other scans have completed. If none of those scans return another player this will be allowed to fire.
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 74270, 74271, 74272) or args:IsSpellID(72259, 74273, 74274, 74275) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		timerRagingSpiritCD:Start(6)
		warnShamblingSoon:Cancel()
		timerShamblingHorror:Cancel()
		timerDrudgeGhouls:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()
		timerNecroticPlagueCD:Cancel()
		timerTrapCD:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
	elseif args:IsSpellID(72262) then -- Quake (phase transition end)
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		self:NextPhase()
	elseif args:IsSpellID(70372) then -- Shambling Horror
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
	elseif args:IsSpellID(70358) then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif args:IsSpellID(70498) then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args:IsSpellID(70541, 73779, 73780, 73781) then -- Infest
		warnInfest:Show()
		specWarnInfest:Show()
		timerInfestCD:Start()
	elseif args:IsSpellID(72762) then -- Defile
		if self.Options.LKBugWorkaround then
			self:ScheduleMethod(0.1, "OldDefileTarget")
		else
			self:ScheduleMethod(0.1, "DefileTarget")
		end
		warnDefileSoon:Cancel()
		warnDefileSoon:Schedule(27)
		timerDefileCD:Start()
	elseif args:IsSpellID(73539) then -- Shadow Trap (Heroic)
		timerTrapCD:Start()
		if self.Options.LKBugWorkaround then
			self:ScheduleMethod(0.01, "OldTrapTarget")
			self:ScheduleMethod(0.02, "OldTrapTarget")
			self:ScheduleMethod(0.03, "OldTrapTarget")
			self:ScheduleMethod(0.04, "OldTrapTarget")
			self:ScheduleMethod(0.05, "OldTrapTarget")
			self:ScheduleMethod(0.06, "OldTrapTarget")
			self:ScheduleMethod(0.07, "OldTrapTarget")
			self:ScheduleMethod(0.08, "OldTrapTarget")
			self:ScheduleMethod(0.09, "OldTrapTarget")
			self:ScheduleMethod(0.1, "OldTrapTarget")
		else
			self:ScheduleMethod(0.01, "TrapTarget")
			self:ScheduleMethod(0.02, "TrapTarget")
			self:ScheduleMethod(0.03, "TrapTarget")
			self:ScheduleMethod(0.04, "TrapTarget")
			self:ScheduleMethod(0.05, "TrapTarget")
			self:ScheduleMethod(0.06, "TrapTarget")
			self:ScheduleMethod(0.07, "TrapTarget")
			self:ScheduleMethod(0.08, "TrapTarget")
			self:ScheduleMethod(0.09, "TrapTarget")
			self:ScheduleMethod(0.1, "TrapTarget")
		end
	elseif args:IsSpellID(73650) then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
	elseif args:IsSpellID(72350) then -- Fury of Frostmourne
		mod:SetWipeTime(160)--Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay, hopefully without breaking mod.
		timerRoleplay:Start()
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		timerDefileCD:Cancel()
		timerHarvestSoulCD:Cancel()
		berserkTimer:Cancel()
		warnDefileSoon:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70337, 73912, 73913, 73914) then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell)
		warnNecroticPlague:Show(args.destName)
		timerNecroticPlagueCD:Start()
		timerNecroticPlagueCleanse:Start()
		lastPlagueCast = GetTime()
		if args:IsPlayer() then
			specWarnNecroticPlague:Show()
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 5, 5)
		end
	elseif args:IsSpellID(69409, 73797, 73798, 73799) then -- Soul reaper (MT debuff)
		warnSoulreaper:Show(args.destName)
		specwarnSoulreaper:Show(args.destName)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start()
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
		end
	elseif args:IsSpellID(69200) then -- Raging Spirit
		warnRagingSpirit:Show(args.destName)
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
		end
		if phase == 1 then
			timerRagingSpiritCD:Start()
		else
			timerRagingSpiritCD:Start(17)
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 7, 5)
		end
	elseif args:IsSpellID(68980, 74325, 74326, 74327) then -- Harvest Soul
		warnHarvestSoul:Show(args.destName)
		timerHarvestSoul:Start(args.destName)
		timerHarvestSoulCD:Start()
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
		end
		if self.Options.HarvestSoulIcon then
			self:SetIcon(args.destName, 6, 6)
		end
	elseif args:IsSpellID(73654, 74295, 74296, 74297) then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
	end
end

function mod:SPELL_DISPEL(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 70337 or args.extraSpellId == 73912 or args.extraSpellId == 73913 or args.extraSpellId == 73914 or args.extraSpellId == 70338 or args.extraSpellId == 73785 or args.extraSpellId == 73786 or args.extraSpellId == 73787) then
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

do
	local lastDefile = 0
	local lastRestore = 0
	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(72143, 72146, 72147, 72148) then -- Shambling Horror enrage effect.
			warnShamblingEnrage:Show(args.destName)
			timerEnrageCD:Start()
		elseif args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and time() - lastDefile > 2 then		-- Defile Damage
			specWarnDefile:Show()
			lastDefile = time()
		elseif args:IsSpellID(73650) and time() - lastRestore > 3 then		-- Restore Soul (Heroic)
			lastRestore = time()
			timerHarvestSoulCD:Start(60)
			timerVileSpirit:Start(10)--May be wrong too but we'll see, didn't have enough log for this one.
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(70338, 73785, 73786, 73787) then	--Necrotic Plague (hop IDs only since they DO fire for >=2 stacks, since function never announces 1 stacks anyways don't need to monitor LK casts/Boss Whispers here)
		if self.Options.AnnouncePlagueStack and DBM:GetRaidRank() > 0 then
			if args.amount % 10 == 0 or (args.amount >= 10 and args.amount % 5 == 0) then		-- Warn at 10th stack and every 5th stack if more than 10
				SendChatMessage(L.PlagueStackWarning:format(args.destName, (args.amount or 1)), "RAID")
			elseif (args.amount or 1) >= 30 and not warnedAchievement then						-- Announce achievement completed if 30 stacks is reached
				SendChatMessage(L.AchievementCompleted:format(args.destName, (args.amount or 1)), "RAID_WARNING")
				warnedAchievement = true
			end
		end
	end
end	

do
	local valkIcons = {}
	local valkyrTargets = {}
	local currentIcon = 2
	local grabIcon = 2
	local iconsSet = 0
	local lastValk = 0
	
	local function resetValkIconState()
		table.wipe(valkIcons)
		currentIcon = 2
		iconsSet = 0
	end
	
	local function scanValkyrTargets()
		if (time() - lastValk) < 10 then    -- scan for like 10secs
			for i=0, GetNumRaidMembers() do        -- for every raid member check ..
				if UnitInVehicle("raid"..i) and not valkyrTargets[i] then      -- if person #i is in a vehicle and not already announced 
					valkyrWarning:Show(UnitName("raid"..i))  -- UnitName("raid"..i) returns the name of the person who got valkyred
					valkyrTargets[i] = true          -- this person has been announced
					if UnitName("raid"..i) == UnitName("player") then
						specWarnYouAreValkd:Show()
						if mod:IsHealer() then--Is player that's grabbed a healer
							if isPAL then
								mod:SendSync("PALGrabbed", UnitName("player"))--They are a holy paladin
							elseif isPRI then
								mod:SendSync("PRIGrabbed", UnitName("player"))--They are a disc/holy priest
							end
						end
					end
					if mod.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 0 then
						if mod.Options.ValkyrIcon then
							SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, UnitName("raid"..i)), "RAID")
							grabIcon = grabIcon + 1
						else
							SendChatMessage(L.ValkGrabbed:format(UnitName("raid"..i)), "RAID")
						end
					end
				end
			end
			mod:Schedule(0.5, scanValkyrTargets)  -- check for more targets in a few
		else
			wipe(valkyrTargets)       -- no more valkyrs this round, so lets clear the table
			grabIcon = 2
		end
	end  
	
	
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(69037) then -- Summon Val'kyr
			if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
				warnSummonValkyr:Show()
				timerSummonValkyr:Start()
				lastValk = time()
				scanValkyrTargets()
				if self.Options.ValkyrIcon then
					resetValkIconState()
				end
			end
			if self.Options.ValkyrIcon then
				valkIcons[args.destGUID] = currentIcon
				currentIcon = currentIcon + 1
			end
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if self.Options.ValkyrIcon and (DBM:GetRaidRank() > 0 and not (iconsSet == 3 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 1 and self:IsDifficulty("normal10", "heroic10"))) then
			for i = 1, GetNumRaidMembers() do
				local uId = "raid"..i.."target"
				local guid = UnitGUID(uId)
				if valkIcons[guid] then
					SetRaidTarget(uId, valkIcons[guid])
					iconsSet = iconsSet + 1
					valkIcons[guid] = nil
				end
			end
		end
	end, 1)
end

do 
	local lastWinter = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(68983, 73791, 73792, 73793) and args:IsPlayer() and time() - lastWinter > 2 then		-- Remorseless Winter
			specWarnWinter:Show()
			lastWinter = time()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) and uId == "target" and self:GetUnitCreatureId(uId) == 36609 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 and not warnedValkyrGUIDs[UnitGUID(uId)] then
		warnedValkyrGUIDs[UnitGUID(uId)] = true
		specWarnValkyrLow:Show()
	end
	if phase == 1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 36597 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.73 then
		warned_preP2 = true
		warnPhase2Soon:Show()
	elseif phase == 2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 36597 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.43 then
		warned_preP3 = true
		warnPhase3Soon:Show()
	end
end

function mod:NextPhase()
	phase = phase + 1
	if phase == 1 then
		berserkTimer:Start()
		warnShamblingSoon:Schedule(15)
		timerShamblingHorror:Start(20)
		timerDrudgeGhouls:Start(10)
		timerNecroticPlagueCD:Start(27)
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerTrapCD:Start()
		end
	elseif phase == 2 then
		timerSummonValkyr:Start(20)
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		timerInfestCD:Start(14)
		warnDefileSoon:Schedule(33)
	elseif phase == 3 then
		timerVileSpirit:Start(20)
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		timerHarvestSoulCD:Start(14)
		warnDefileSoon:Schedule(33)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LKPull or msg:find(L.LKPull) then
		timerCombatStart:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)--We get this whisper for all plagues, ones cast by lich king and ones from dispel jumps.
	if msg:find(L.PlagueWhisper) and self:IsInCombat() then--We do a combat check with lich king since rotface uses the same whisper message and we only want this to work on lich king.
		if GetTime() - lastPlagueCast > 1 then--We don't want to send sync if it came from a spell cast though, so we ignore whisper unless it was at least 1 second after a cast.
			specWarnNecroticPlague:Show()
			self:SendSync("PlagueOn", UnitName("player"))
		end
	end
end

function mod:SWING_DAMAGE(args)
	if args:GetSrcCreatureID() == 36597 then--Lich king Tank
		LKTank = args.destName
	end
end

function mod:SWING_MISSED(args)
	if args:GetSrcCreatureID() == 36597 then--Lich king Tank
		LKTank = args.destName
	end
end

function mod:OnSync(msg, target)
	if msg == "PALGrabbed" then--Does this function fail to alert second healer if 2 different paladins are grabbed within < 2.5 seconds?
		if self.Options.specWarnHealerGrabbed then
			specWarnPALGrabbed:Show(target)
		end
	elseif msg == "PRIGrabbed" then--Does this function fail to alert second healer if 2 different priests are grabbed within < 2.5 seconds?
		if self.Options.specWarnHealerGrabbed then
			specWarnPRIGrabbed:Show(target)
		end
	elseif msg == "TrapOn" then
		if not self.Options.LKBugWorkaround then
			warnTrapCast:Show(target)
			if self.Options.TrapIcon then
				self:SetIcon(player, 8, 10)
			end
			if target == UnitName("player") then
				specWarnTrap:Show()
				if self.Options.YellOnTrap then
					SendChatMessage(L.YellTrap, "SAY")
				end
			end
			local uId = DBM:GetRaidUnitId(target)
			if uId ~= "none" then
				local inRange = CheckInteractDistance(uId, 2)
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				if inRange then
					specWarnTrapNear:Show()
					if self.Options.TrapArrow then
						DBM.Arrow:ShowRunAway(x, y, 10, 5)
					end
				end
			end
		end
	elseif msg == "DefileOn" then
		if not self.Options.LKBugWorkaround then
			warnDefileCast:Show(target)
			if self.Options.DefileIcon then
				self:SetIcon(target, 8, 10)
			end
			if target == UnitName("player") then
				specWarnDefileCast:Show()
				soundDefile:Play()
				if self.Options.YellOnDefile then
					SendChatMessage(L.YellDefile, "SAY")
				end
			elseif target then
				local uId = DBM:GetRaidUnitId(target)
				if uId then
					local inRange = CheckInteractDistance(uId, 2)
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					if inRange then
						specWarnDefileNear:Show()
--						if self.Options.DefileArrow then
--							DBM.Arrow:ShowRunAway(x, y, 15, 5)
--						end
					end
				end
			end
		end
	elseif msg == "PlagueOn" and self:IsInCombat() then
		if GetTime() - lastPlagueCast > 1 then --We also do same 1 second check here
			warnNecroticPlagueJump:Show(target)
			timerNecroticPlagueCleanse:Start()
			if self.Options.NecroticPlagueIcon then
				self:SetIcon(target, 5, 5)
			end
		end
	end
end
