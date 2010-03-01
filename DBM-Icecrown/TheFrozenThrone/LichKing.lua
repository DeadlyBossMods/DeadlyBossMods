local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36597)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetMinSyncRevision(3489)
mod:SetUsedIcons(2, 3, 4, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DISPEL",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnRemorselessWinter = mod:NewSpellAnnounce(74270, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetAnnounce(69200, 3) --Transition Add
local warnShamblingHorror	= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls		= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage	= mod:NewTargetAnnounce(72143, 3, nil, mod:IsHealer() or mod:IsTank() or mod:CanRemoveEnrage()) --Phase 1 Add Ability
local warnNecroticPlague	= mod:NewTargetAnnounce(73912, 4) --Phase 1+ Ability
local warnInfest			= mod:NewSpellAnnounce(73779, 3, nil, mod:IsHealer()) --Phase 1 & 2 Ability
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 1)
local warnDefileSoon		= mod:NewSoonAnnounce(73708, 3)	--Phase 2+ Ability
local warnSoulreaper		= mod:NewSpellAnnounce(73797, 4, nil, mod:IsTank() or mod:IsHealer()) --Phase 2+ Ability
local warnDefileCast		= mod:NewTargetAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3) --Phase 2 Add
local warnPhase3Soon		= mod:NewAnnounce("WarnPhase3Soon", 1)
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul		= mod:NewTargetAnnounce(74325, 4) --Phase 3 Ability
local warnTrapCast			= mod:NewTargetAnnounce(73539, 3) --Phase 2+ Ability

local specWarnSoulreaper	= mod:NewSpecialWarningYou(73797) --Phase 1+ Ability
local specWarnNecroticPlague= mod:NewSpecialWarningYou(73912) --Phase 1+ Ability
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200, false) --Transition Add
local specWarnDefileCast	= mod:NewSpecialWarning("specWarnDefileCast") --Phase 2+ Ability
local specWarnDefileNear	= mod:NewSpecialWarning("specWarnDefileNear", false) --Phase 2+ Ability
local specWarnDefile		= mod:NewSpecialWarningMove(73708) --Phase 2+ Ability
local specWarnWinter		= mod:NewSpecialWarningMove(73791) --Transition Ability
local specWarnHarvestSoul	= mod:NewSpecialWarningYou(74325) --Phase 3+ Ability
local specWarnInfest		= mod:NewSpecialWarningSpell(73779, false) --Phase 1+ Ability
local specwarnSoulreaper	= mod:NewSpecialWarningTarget(73797, false) --phase 2+
local specWarnTrap			= mod:NewSpecialWarningYou(73539) --Heroic Ability

local timerCombatStart		= mod:NewTimer(54.5, "TimerCombatStart", 2457)
local timerPhaseTransition	= mod:NewTimer(62, "PhaseTransition")
local timerSoulreaper	 	= mod:NewTargetTimer(5.1, 73797, nil, mod:IsTank() or mod:IsHealer())
local timerSoulreaperCD	 	= mod:NewCDTimer(30, 73797, nil, mod:IsTank() or mod:IsHealer())
local timerHarvestSoul	 	= mod:NewTargetTimer(6, 74325)
local timerHarvestSoulCD	= mod:NewCDTimer(75, 74325)
local timerInfestCD			= mod:NewCDTimer(22, 73779, nil, mod:IsHealer())
local timerNecroticPlagueCleanse = mod:NewTimer(5, "TimerNecroticPlagueCleanse", 73912, false)
local timerNecroticPlagueCD	= mod:NewCDTimer(30, 73912)
local timerDefileCD			= mod:NewCDTimer(32, 72762)
local timerShamblingHorror 	= mod:NewNextTimer(60, 70372)
local timerDrudgeGhouls 	= mod:NewNextTimer(20, 70358)
local timerSummonValkyr 	= mod:NewCDTimer(45, 69037)
local timerVileSpirit 		= mod:NewNextTimer(30, 70498)
local timerTrapCD		 	= mod:NewCDTimer(16, 73539)
local timerRoleplay			= mod:NewTimer(129, "TimerRoleplay")	--may need tweaking

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddBoolOption("DefileIcon")
mod:AddBoolOption("NecroticPlagueIcon")
mod:AddBoolOption("RagingSpiritIcon")
mod:AddBoolOption("TrapIcon")
mod:AddBoolOption("YellOnDefile", true, "announce")
mod:AddBoolOption("YellOnTrap", true, "announce")

local phase	= 0
local warned_preP2 = false
local warned_preP3 = false

--[[local function isunitdebuffed(spellID)
	local name = GetSpellInfo(spellID)
	if not name then return false end

	for i=1, 40, 1 do
		local debuffname = UnitDebuff("player", i, "HARMFUL")
		if debuffname == name then
			return true
		end
	end
	return false
end--]]

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	phase = 0
	warned_preP2 = false
	warned_preP3 = false
	self:NextPhase()
end

function mod:DefileTarget()
	local targetname = self:GetBossTarget(36597)
	if not targetname then return end
		warnDefileCast:Show(targetname)
		if self.Options.DefileIcon then
			self:SetIcon(targetname, 8, 10)
		end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		if self.Options.YellOnDefile then
			SendChatMessage(L.YellDefile, "YELL")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show()
			end
		end
	end
end

function mod:TrapTarget()
	local targetname = self:GetBossTarget(36597)
	if not targetname then return end
		warnTrapCast:Show(targetname)
		if self.Options.TrapIcon then
			self:SetIcon(targetname, 6, 10)
		end
	if targetname == UnitName("player") then
		specWarnTrap:Show()
		if self.Options.YellOnTrap then
			SendChatMessage(L.YellTrap, "YELL")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 74270, 74271, 74272) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		timerShamblingHorror:Cancel()
		timerDrudgeGhouls:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()
		timerNecroticPlagueCD:Cancel()
		timerDefileCD:Cancel()
		timerTrapCD:Cancel()
		warnDefileSoon:Cancel()
	elseif args:IsSpellID(72262) then -- Quake (phase transition end)
		warnQuake:Show()
		self:NextPhase()
	elseif args:IsSpellID(70372) then -- Shambling Horror
		warnShamblingHorror:Show()
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
		self:ScheduleMethod(0.1, "DefileTarget")
		warnDefileSoon:Schedule(27)
		timerDefileCD:Start()
	elseif args:IsSpellID(73539) then -- Shadow Trap (Heroic)
		self:ScheduleMethod(0.1, "TrapTarget")
		timerTrapCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70337, 73912, 73913, 73914) then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell, there is no way to detect jumps to other players.)
		warnNecroticPlague:Show(args.destName)
		timerNecroticPlagueCD:Start()
		timerNecroticPlagueCleanse:Start()
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 7, 5)
		end
		if args:IsPlayer() then
			specWarnNecroticPlague:Show()
		end
--[[		if (isunitdebuffed(70338) or isunitdebuffed(73785) or isunitdebuffed(73786) or isunitdebuffed(73787) or isunitdebuffed(70337) or isunitdebuffed(73912) or isunitdebuffed(73913) or isunitdebuffed(73914)) then
			specWarnNecroticPlague:Show()
		end--]]
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
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 8, 5)
		end
	elseif args:IsSpellID(68980, 74325, 74326, 74327) then -- Harvest Soul
		warnHarvestSoul:Show(args.destName)
		timerHarvestSoul:Start(args.destName)
		timerHarvestSoulCD:Start()
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72143, 72146) then -- Shambling Horror enrage effect.
		warnShamblingEnrage:Show(args.destName)
	end
end
--[[
function mod:SPELL_DISPEL(args)
	if args:IsSpellID(70337, 73912, 73913, 73914, 70338, 73785, 73786, 73787) then -- Necrotic Plague
		self:SetIcon(args.destName, 0)
	end
end
--]]
do
	local valkIcons = {}
	local currentIcon = 2
	local iconsSet = 0
	local function resetValkIconState()
		table.wipe(valkIcons)
		currentIcon = 2
		iconsSet = 0
	end
	
	local lastValk = 0
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(69037) then -- Summon Val'kyr
			if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
				warnSummonValkyr:Show()
				timerSummonValkyr:Start()
				lastValk = time()
				resetValkIconState()
			end
			valkIcons[args.destGUID] = currentIcon
			currentIcon = currentIcon + 1
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if DBM:GetRaidRank() > 0 and not (iconsSet == 3 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 1 and self:IsDifficulty("normal10", "heroic10")) then
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
	local lastDefile = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and time() - lastDefile > 2 then		-- Defile Damage
			specWarnDefile:Show()
			lastDefile = time()
		end
	end
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
		timerShamblingHorror:Start(20)
		timerDrudgeGhouls:Start(10)
		timerNecroticPlagueCD:Start(27)
	elseif phase == 2 then
		timerSummonValkyr:Start(20)
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		timerInfestCD:Start(13)
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
		self:SendSync("LKPull")
	elseif msg == L.LKRoleplay or msg:find(L.LKRoleplay) then
		self:SendSync("LKRoleplay")
	end
end

function mod:OnSync(msg, arg)
	if msg == "LKPull" then
		timerCombatStart:Start()
	elseif msg == "LKRoleplay" then
		timerRoleplay:Start()
	end
end
