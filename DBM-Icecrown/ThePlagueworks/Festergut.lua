local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnInhaledBlight		= mod:NewAnnounce("InhaledBlight", 3, 71912)
local warnGastricBloat		= mod:NewAnnounce("WarnGastricBloat", 2, 72551, mod:IsTank() or mod:IsHealer())
local warnGasSpore			= mod:NewTargetAnnounce(69279, 4)
local warnVileGas			= mod:NewTargetAnnounce(73020, 3)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(71219)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279)
local specWarnVileGas		= mod:NewSpecialWarningYou(71218)
local specWarnGastricBloat	= mod:NewSpecialWarningStack(72551, nil, 9)
local specWarnInhaled3		= mod:NewSpecialWarningStack(71912, mod:IsTank(), 3)

local timerGasSpore			= mod:NewBuffActiveTimer(12, 69279)
local timerVileGas			= mod:NewBuffActiveTimer(6, 71218, nil, mod:IsRanged())
local timerGasSporeCD		= mod:NewNextTimer(40, 69279)		-- Every 40 seconds except after 3rd and 6th cast, then it's 50sec CD
local timerPungentBlight	= mod:NewNextTimer(33, 71219)		-- 33 seconds after 3rd stack of inhaled
local timerInhaledBlight	= mod:NewNextTimer(34, 71912)		-- 34 seconds'ish
local timerGastricBloat		= mod:NewTargetTimer(100, 72551, nil, mod:IsTank() or mod:IsHealer())	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(11, 72551, nil, mod:IsTank() or mod:IsHealer()) 		-- 10 to 14 seconds

local berserkTimer			= mod:NewBerserkTimer(300)

local warnGoo				= mod:NewSpellAnnounce(72549, 4)
local timerGooCD			= mod:NewNextTimer(10, 72549)

mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("SetIconOnGasSpore", true)
mod:AddBoolOption("AnnounceSporeIcons", false)

local gasSporeTargets	= {}
local gasSporeIconTargets	= {}
local vileGasTargets	= {}
local gasSporeCast 	= 0
local lastGoo = 0

--[[
local mRange = { }
local mPoints = { 
	[0] = { 0.19828705489635, 0.653256416320 },
	[1] = { 0.21672140061855, 0.63018447160721 },
	[2] = { 0.21968087553978, 0.6705778837204 }
}
local noCheck = true

local function findMin(a)
	local min = a[1]
	local index = 1
	for i, v in ipairs(a) do
		if v < min then
			index = i
			min = v
		end
	end
	return min, index
end
--]]

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetSporeIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(gasSporeIconTargets, sort_by_group)
			local gasSporeIcon = 8
			for i, v in ipairs(gasSporeIconTargets) do
				if self.Options.AnnounceSporeIcons then
					SendChatMessage(L.SporeSet:format(gasSporeIcon, UnitName(v)), "RAID")
				end
				mod:SetIcon(UnitName(v), gasSporeIcon, 12)
				gasSporeIcon = gasSporeIcon - 1
			end
			table.wipe(gasSporeIconTargets)
		end
	end
end

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	timerGasSpore:Start()
--[[
	if not noCheck then
		for _, point in ipairs(mPoints) do 
			for i, v in ipairs(gasSporeTargets) do
				mRange[i] = DBM.RangeCheck:GetDistance(DBM:GetRaidUnitId(v), point[1], point[2])
			end
			local value, index = findMin(mRange)
			if gasSporeTargets[index] == UnitName("player") then	-- found my shortest way
				DBM.Arrow:ShowRunTo(point[1], point[2])
			end
			table.remove(gasSporeTargets, index)
			table.wipe(mRange)
		end
	end
	noCheck = true
--]]
	table.wipe(gasSporeTargets)
end

local function warnVileGasTargets()
	warnVileGas:Show(table.concat(vileGasTargets, "<, >"))
	table.wipe(vileGasTargets)
	timerVileGas:Start()
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)
	timerGasSporeCD:Start(20-delay)--This may need tweaking
	table.wipe(gasSporeTargets)
	table.wipe(vileGasTargets)
	gasSporeIcon = 8
	gasSporeCast = 0
	lastGoo = 0
--	noCheck = true
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerGooCD:Start(13-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specWarnPungentBlight:Show()
		timerInhaledBlight:Start(38)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(72299) then -- Malleable Goo Summon Trigger (10 player normal) (the other 3 spell ids are not needed here since all spells have the same name)
		self:SendSync("Goo")
	end
end

function mod:OnSync(event, arg)
	if event == "Goo" then
		if time() - lastGoo > 5 then
			warnGoo:Show()
			if mod:IsDifficulty("heroic25") then
				timerGooCD:Start()
			else
				timerGooCD:Start(30)--30 seconds in between goos on 10 man heroic
			end
			lastGoo = time()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		gasSporeCast = gasSporeCast + 1
		if (gasSporeCast < 9 and (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25"))) or (gasSporeCast < 6 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10"))) then
			timerGasSporeCD:Start()
		elseif (gasSporeCast >= 9 and (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25"))) or (gasSporeCast >= 6 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10"))) then
			timerGasSporeCD:Start(50)--Basically, the third time spores are placed on raid, it'll be an extra 10 seconds before he applies first set of spores again.
			gasSporeCast = 0
		end
		if args:IsPlayer() then
--			noCheck = false	-- check for distance and show the arrow
			specWarnGasSpore:Show()
		end
		if self.Options.SetIconOnGasSpore then
			table.insert(gasSporeIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetSporeIcons")
			if ((mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) and #gasSporeIconTargets >= 3) or ((mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10")) and #gasSporeIconTargets >= 2) then
				self:SetSporeIcons()
			else
				self:ScheduleMethod(0.2, "SetSporeIcons")
			end
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 3 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		warnInhaledBlight:Show(args.amount or 1)
		if (args.amount or 1) >= 3 then
			specWarnInhaled3:Show(args.amount)
			timerPungentBlight:Start()
		end
		if (args.amount or 1) <= 2 then	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	elseif args:IsSpellID(72219, 72551, 72552, 72553) then	-- Gastric Bloat
		warnGastricBloat:Show(args.spellName, args.destName, args.amount or 1)
		timerGastricBloat:Start(args.destName)
		timerGastricBloatCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 9 then
			specWarnGastricBloat:Show(args.amount)
		end
	elseif args:IsSpellID(69240, 71218, 73019, 73020) then	-- Vile Gas(Heroic Spellids drycoded, may not be correct)
		vileGasTargets[#vileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
		end
		self:Unschedule(warnVileGasTargets)
		self:Schedule(0.8, warnVileGasTargets)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


