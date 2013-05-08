local mod	= DBM:NewMod(679, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60051, 60043, 59915, 60047)--Cobalt: 60051, Jade: 60043, Jasper: 59915, Amethyst: 60047
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnCobaltOverload			= mod:NewSpellAnnounce(115840, 4)
local warnJadeOverload				= mod:NewSpellAnnounce(115842, 4)
local warnJasperOverload			= mod:NewSpellAnnounce(115843, 4)
local warnAmethystOverload			= mod:NewSpellAnnounce(115844, 4)
local warnCobaltMine				= mod:NewSpellAnnounce(129424, 4)
local warnJadeShards				= mod:NewSpellAnnounce(116223, 3, nil, false)
local warnJasperChains				= mod:NewTargetAnnounce(130395, 4)
local warnAmethystPool				= mod:NewTargetAnnounce(130774, 3, nil, false)
local warnPowerDown					= mod:NewSpellAnnounce(116529, 4, nil, not mod:IsTank())

local specWarnOverloadSoon			= mod:NewSpecialWarning("SpecWarnOverloadSoon", nil, nil, nil, 2)
local specWarnJasperChains			= mod:NewSpecialWarningYou(130395)
local specWarnBreakJasperChains		= mod:NewSpecialWarning("specWarnBreakJasperChains", false)
local yellJasperChains				= mod:NewYell(130395, nil, false)
--local specWarnCobaltMine			= mod:NewSpecialWarningYou(129424)
local specWarnCobaltMineNear		= mod:NewSpecialWarningClose(129424)
--local yellCobaltMine				= mod:NewYell(129424)
local specWarnAmethystPool			= mod:NewSpecialWarningMove(130774)
local specWarnPowerDown				= mod:NewSpecialWarningSpell(116529, not mod:IsTank())

local timerPetrification			= mod:NewNextTimer(76, 125091)
local timerCobaltMineCD				= mod:NewNextTimer(8.5, 129424)
local timerJadeShardsCD				= mod:NewCDTimer(9, 116223, nil, false)--9~12
local timerJasperChainsCD			= mod:NewCDTimer(12, 130395)--11-13
local timerAmethystPoolCD			= mod:NewCDTimer(6, 130774, nil, false)

local berserkTimer					= mod:NewBerserkTimer(420)

mod:AddBoolOption("ArrowOnJasperChains")
mod:AddBoolOption("InfoFrame")

local expectedBosses = 3
local Jade = EJ_GetSectionInfo(5773)
local Jasper = EJ_GetSectionInfo(5774)
local Cobalt = EJ_GetSectionInfo(5771)
local Amethyst = EJ_GetSectionInfo(5691)
local Overload = {
	["Cobalt"] = GetSpellInfo(115840),
	["Jade"] = GetSpellInfo(115842),
	["Jasper"] = GetSpellInfo(115843),
	["Amethyst"] = GetSpellInfo(115844)
}
local activePetrification = nil
local playerHasChains = false
local jasperChainsTargets = {}
local amethystPoolTargets = {}

local function warnAmethystPoolTargets()
	warnAmethystPool:Show(table.concat(amethystPoolTargets, "<, >"))
	timerAmethystPoolCD:Start()
	table.wipe(amethystPoolTargets)
end

local function poolTargetCheck(name)
	if #amethystPoolTargets > 0 and name then
		for i = 1, #amethystPoolTargets do
			if amethystPoolTargets[i] == name then
				return false
			end
		end
	end
	return true
end

local function warnJasperChainsTargets()
	warnJasperChains:Show(table.concat(jasperChainsTargets, "<, >"))
	table.wipe(jasperChainsTargets)
end

function mod:ThreeBossStart(delay)
	for i = 1, 5 do
		local id = self:GetUnitCreatureId("boss"..i)
		if id == 60051 then -- cobalt
			if self:IsDifficulty("lfr25") then
				timerCobaltMineCD:Start(10.5-delay-1)
			else
				timerCobaltMineCD:Start(-delay-1)
			end
		elseif id == 60043 then -- jade
			timerJadeShardsCD:Start(-delay-1)
		elseif id == 59915 then -- jasper
			timerJasperChainsCD:Start(-delay-1)
		elseif id == 60047 then -- amethyst
			timerAmethystPoolCD:Start(-delay-1)
		end
	end
end

function mod:OnCombatStart(delay)
	activePetrification = nil
	playerHasChains = false
	table.wipe(jasperChainsTargets)
	table.wipe(amethystPoolTargets)
	berserkTimer:Start()--7 min berserk on heroic 10 and 25 at least, unsure about normal/LFR, since i've never seen a log reach 7 min yet in LFR or normal
	if self:IsDifficulty("normal25", "heroic25") then
		timerCobaltMineCD:Start(-delay)
		timerJadeShardsCD:Start(-delay)
		timerJasperChainsCD:Start(-delay)
		timerAmethystPoolCD:Start(-delay)
		expectedBosses = 4--Only fight all 4 at once on 25man (excluding LFR)
	else
		expectedBosses = 3--Else you get a random set of 3/4
		self:ScheduleMethod(1, "ThreeBossStart", delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnJasperChains then
		DBM.Arrow:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 130395 then
		jasperChainsTargets[#jasperChainsTargets + 1] = args.destName
		timerJasperChainsCD:Start()
		self:Unschedule(warnJasperChainsTargets)
		self:Schedule(0.3, warnJasperChainsTargets)
		if activePetrification ~= "Jasper" then
			if self.Options.ArrowOnJasperChains and #jasperChainsTargets == 2 then
				if jasperChainsTargets[1] == UnitName("player") then
					DBM.Arrow:ShowRunTo(jasperChainsTargets[2])
				elseif jasperChainsTargets[2] == UnitName("player") then
					DBM.Arrow:ShowRunTo(jasperChainsTargets[1])
				end
			end
		end
		if args:IsPlayer() then
			playerHasChains = true
			specWarnJasperChains:Show()
			if not self:IsDifficulty("lfr25") then
				yellJasperChains:Yell()
			end
			local uId = DBM:GetBossUnitId(Jasper)
			if uId and UnitPower(uId) <= 50 and activePetrification == "Jasper" then--Make sure his energy isn't already high, otherwise breaking chains when jasper will only be active for a few seconds is bad
				specWarnBreakJasperChains:Show()
				DBM.Arrow:Hide()
			end
		end
	elseif args.spellId == 130774 and args:IsPlayer() then
		specWarnAmethystPool:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 130395 and args:IsPlayer() then
		playerHasChains = false
		if self.Options.ArrowOnJasperChains then
			DBM.Arrow:Hide()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 115840 then -- Cobalt
		warnCobaltOverload:Show()
		if activePetrification == "Cobalt" then
			timerPetrification:Cancel()
		end
		activePetrification = nil
	elseif args.spellId == 115842 then -- Jade
		warnJadeOverload:Show()
		if activePetrification == "Jade" then
			timerPetrification:Cancel()
		end
		activePetrification = nil
	elseif args.spellId == 115843 then -- Jasper
		warnJasperOverload:Show()
		if activePetrification == "Jasper" then
			timerPetrification:Cancel()
		end
		activePetrification = nil
	elseif args.spellId == 115844 then -- Amethyst
		warnAmethystOverload:Show()
		if activePetrification == "Amethyst" then
			timerPetrification:Cancel()
		end
		activePetrification = nil
	elseif args.spellId == 116223 then
		warnJadeShards:Show()
		timerJadeShardsCD:Start()
	elseif args:IsSpellID(116235, 130774) then--is 116235 still used? my logs show ONLY 130774 being used.
		if poolTargetCheck(args.destName) then--antispam can not prevent spam, try another way.
			amethystPoolTargets[#amethystPoolTargets + 1] = args.destName
			self:Unschedule(warnAmethystPoolTargets)
			self:Schedule(0.5, warnAmethystPoolTargets)
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg, boss)
	if msg == L.Overload or msg:find(L.Overload) then--Cast trigger is an emote 7 seconds before, CLEU only shows explosion. Just like nefs electrocute
		self:SendSync("Overload", boss == Cobalt and "Cobalt" or boss == Jade and "Jade" or boss == Jasper and "Jasper" or boss == Amethyst and "Amethyst" or "Unknown")
	elseif msg:find("spell:116529") then
		warnPowerDown:Show()
		specWarnPowerDown:Show()
	end
end

function mod:OnSync(msg, boss)
	-- if boss aprats from 10 yard and get Solid Stone, power no longer increase. If this, overlord not casts. So timer can be confusing. Disabled for find better way. 
	if msg == "Overload" and boss ~= activePetrification then
		specWarnOverloadSoon:Show(Overload[boss])
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 60051 or cid == 60043 or cid == 59915 or cid == 60047 then--Fight is over. NYI, amethyst guardian CID is not yet known.
		expectedBosses = expectedBosses - 1
		if expectedBosses == 0 then
			DBM:EndCombat(self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 115852 and self:AntiSpam(2, 1) then
		activePetrification = "Cobalt"
		timerPetrification:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(Cobalt)
			DBM.InfoFrame:Show(5, "enemypower", 1, nil, nil, ALTERNATE_POWER_INDEX)
		end
	elseif spellId == 116006 and self:AntiSpam(2, 2) then
		activePetrification = "Jade"
		timerPetrification:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(Jade)
			DBM.InfoFrame:Show(5, "enemypower", 1, nil, nil, ALTERNATE_POWER_INDEX)
		end
	elseif spellId == 116036 and self:AntiSpam(2, 3) then
		activePetrification = "Jasper"
		timerPetrification:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(Jasper)
			DBM.InfoFrame:Show(5, "enemypower", 1, nil, nil, ALTERNATE_POWER_INDEX)
		end
		if playerHasChains then
			local uId = DBM:GetBossUnitId(Jasper)
			if uId and UnitPower(uId) <= 50 then--Make sure his energy isn't already high, otherwise breaking chains when jasper will only be active for a few seconds is bad
				specWarnBreakJasperChains:Show()
				DBM.Arrow:Hide()
			end
		end
	elseif spellId == 116057 and self:AntiSpam(2, 4) then
		activePetrification = "Amethyst"
		timerPetrification:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(Amethyst)
			DBM.InfoFrame:Show(5, "enemypower", 1, nil, nil, ALTERNATE_POWER_INDEX)
		end
	elseif spellId == 129424 and self:AntiSpam(2, 5) then
		warnCobaltMine:Show()
		if self:IsDifficulty("lfr25") then
			timerCobaltMineCD:Start(10.5)
		else
			timerCobaltMineCD:Start()
		end
	end
end
