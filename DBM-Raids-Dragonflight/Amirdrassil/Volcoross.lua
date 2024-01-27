local mod	= DBM:NewMod(2557, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(208478)
mod:SetEncounterID(2737)
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 421672 420933 421616 420415 423117 421703",
	"SPELL_CAST_SUCCESS 421284",
	"SPELL_SUMMON 420421",
	"SPELL_AURA_APPLIED 421207 419054 427201",
	"SPELL_AURA_APPLIED_DOSE 419054",
	"SPELL_AURA_REMOVED 421207 427201 419054",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 421082 423494",
	"SPELL_PERIODIC_MISSED 421082 423494",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 421672 or ability.id = 420933 or ability.id = 421616 or ability.id = 420415 or ability.id = 423117 or ability.id = 421703) and type = "begincast"
 or ability.id = 421284 and type = "cast"
 or ability.id = 420421
--]]
--TODO, disgorge targets?
--TODO, chat bubbles for Coiling Flames
--TODO, work out right taunt timing, just swap for each jaws or on venom stacks?
--TODO, add obvious https://www.wowhead.com/ptr-2/spell=424218/combusting-rage if tanks aren't in range?
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(22309))
local warnSperentsFury								= mod:NewCountAnnounce(421672, 3)
local warnMoltenVenom								= mod:NewStackAnnounce(419054, 2, nil, "Tank|Healer")
local warnSerpentsWrath								= mod:NewSpellAnnounce(421703, 4)
local warnVolcanicDisgorge							= mod:NewTargetCountAnnounce(421616, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnCoilingFlames							= mod:NewSpecialWarningYou(421207, nil, 7897, nil, 1, 2)
local yellCoilingFlames								= mod:NewYell(421207, 7897)--Shortname Flames
local yellCoilingFlamesFades						= mod:NewShortFadesYell(421207)
local specWarnCoilingEruption						= mod:NewSpecialWarningYou(427201, nil, nil, nil, 1, 2)
local yellCoilingEruption							= mod:NewShortYell(427201, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")--NewShortPosYell
local yellCoilingEruptionFades						= mod:NewShortFadesYell(427201, nil, nil, nil, "YELL")--NewIconFadesYell

--local specWarnMoltenVenom							= mod:NewSpecialWarningStack(419054, nil, 6, nil, nil, 1, 6)
--local specWarnMoltenVenomSwap						= mod:NewSpecialWarningTaunt(419054, nil, nil, nil, 1, 2)--Need to evaulate whether tanks swap for this or jaws. double tank mechanic fights are redundant
local specWarnFloodoftheFirleands					= mod:NewSpecialWarningSoakCount(420933, nil, nil, nil, 2, 2)
local specWarnVolcanicDisgorge						= mod:NewSpecialWarningYou(421616, nil, nil, nil, 2, 2)
local yellVolcanicDisgorge							= mod:NewShortYell(421616, DBM_COMMON_L.POOLS)
local specWarnScorchtailCrash						= mod:NewSpecialWarningDodgeCount(420415, nil, 136870, nil, 3, 2)
local specWarnCataclysmJaws							= mod:NewSpecialWarningDefensive(423117, nil, nil, nil, 1, 2)
local specWarnCataclysmJawsTaunt					= mod:NewSpecialWarningTaunt(423117, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(421082, nil, nil, nil, 1, 8)

local timerSerpentsFuryCD							= mod:NewNextCountTimer(70, 421672, 7897, nil, nil, 3)--Shortname "Flames"
local timerCoilingFlames							= mod:NewCastTimer(7.5, 421672, 7897, nil, nil, 5)
local timerCoilingEruption							= mod:NewCastTimer(16, 427201, L.DebuffSoaks, nil, nil, 5)
local timerFloodoftheFirelandsCD					= mod:NewNextCountTimer(70, 420933, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 5)
local timerVolcanicDisgorgeCD						= mod:NewNextCountTimer(10, 421616, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3)
local timerScorchtailCrashCD						= mod:NewCDCountTimer(20, 420415, 136870, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Short name "Tail Slam"
local timerCataclysmJawsCD							= mod:NewNextCountTimer(10, 423117, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnCoilingFlames", 421207, false, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnCoilingEruption", 427201, false, false, {1, 2, 3, 4})--Off by default since other mods don't use icons at all

mod.vb.flamesIcon = 1
mod.vb.furyCount = 0
mod.vb.floodCount = 0
mod.vb.volcanicCount = 0
mod.vb.tailCount = 0
mod.vb.jawsCount = 0
local playerStacks = 0

local allTimers = {
	--Cata Jaws
	[423117] = {4.8, 30.0, 30.0, 40.0, 30.0, 40.0, 30.0, 25.0, 25.0, 20.0},
	--Volcanic Disgorge
	[421616] = {29.9, 20.0, 40.0, 10.0, 10.0, 10.0, 10.0, 30.0, 10.0, 10.0, 10.0, 10.0, 40.0, 20.0},
	--Scorchtail Crash
	[420421] = {19.9, 20, 20, 30, 7.5, 7.4, 7.4, 7.3, 27.5, 7.4, 7.5, 7.5, 7.4, 27, 19.9, 20}
}

function mod:DisgorgeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVolcanicDisgorge:Show()
		specWarnVolcanicDisgorge:Play("targetyou")
		yellVolcanicDisgorge:Yell()
	else
		warnVolcanicDisgorge:Show(self.vb.volcanicCount, targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.flamesIcon = 1
	self.vb.furyCount = 0
	self.vb.floodCount = 0
	self.vb.volcanicCount = 0
	self.vb.tailCount = 0
	self.vb.jawsCount = 0
	playerStacks = 0
	timerCataclysmJawsCD:Start(4.8-delay, 1)
	timerSerpentsFuryCD:Start(9.8-delay, 1)
	timerScorchtailCrashCD:Start(20-delay, 1)
	timerVolcanicDisgorgeCD:Start(29.8-delay, 1)
	timerFloodoftheFirelandsCD:Start(69.8-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421672 then
		self.vb.furyCount = self.vb.furyCount + 1
		self.vb.flamesIcon = 1
		warnSperentsFury:Show(self.vb.furyCount)
		timerSerpentsFuryCD:Start(nil, self.vb.furyCount+1)
		timerCoilingFlames:Start(7.5)
	elseif spellId == 420933 then
		self.vb.floodCount = self.vb.floodCount + 1
		specWarnFloodoftheFirleands:Show(self.vb.floodCount)
		specWarnFloodoftheFirleands:Play("helpsoak")
		timerFloodoftheFirelandsCD:Start(nil, self.vb.floodCount+1)
	elseif spellId == 421616 then
		self.vb.volcanicCount = self.vb.volcanicCount + 1
--		self:BossTargetScanner(args.sourceGUID, "DisgorgeTarget", 0.1, 8, true)
--		specWarnVolcanicDisgorge:Show(self.vb.volcanicCount)
--		specWarnVolcanicDisgorge:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.volcanicCount+1)
		if timer then
			timerVolcanicDisgorgeCD:Start(timer, self.vb.volcanicCount+1)
		end
--	elseif spellId == 420415 then

	elseif spellId == 423117 then
		self.vb.jawsCount = self.vb.jawsCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnCataclysmJaws:Show()
			specWarnCataclysmJaws:Play("defensive")
		elseif playerStacks < 3 then
			local bossTarget = UnitName("boss1target") or DBM_COMMON_L.UNKNOWN
			specWarnCataclysmJawsTaunt:Show(bossTarget)
			specWarnCataclysmJawsTaunt:Play("tauntboss")
		end
		local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.jawsCount+1)
		if timer then
			timerCataclysmJawsCD:Start(timer, self.vb.jawsCount+1)
		end
	elseif spellId == 421703 then
		warnSerpentsWrath:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 420421 then
		self.vb.tailCount = self.vb.tailCount + 1
		specWarnScorchtailCrash:Show(self.vb.tailCount)
		specWarnScorchtailCrash:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.tailCount+1)
		if timer then
			timerScorchtailCrashCD:Start(timer, self.vb.tailCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421207 then
		--local icon = self.vb.flamesIcon
		--if self.Options.SetIconOnCoilingFlames then
		--	self:SetIcon(args.destName, icon)
		--end
		if args:IsPlayer() then
			specWarnCoilingFlames:Show()
			specWarnCoilingFlames:Play("targetyou")
			yellCoilingFlames:Yell()
			yellCoilingFlamesFades:Countdown(spellId)
		end
		if self:IsMythic() and self:AntiSpam(5, 2) then
			timerCoilingEruption:Start(16, self.vb.furyCount)--Time until mythic debuffs expire so combination of this one expiring, next one applying, and also expiring
		end
	elseif spellId == 427201 then
		local icon = self.vb.flamesIcon
		if self.Options.SetIconOnCoilingEruption then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnCoilingEruption:Show()
			specWarnCoilingEruption:Play("targetyou")
			yellCoilingEruption:Yell(icon, icon)--icon, icon
			yellCoilingEruptionFades:Countdown(spellId)--, nil, icon
		end
		self.vb.flamesIcon = self.vb.flamesIcon + 1
	elseif spellId == 419054 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if args:IsPlayer() then
				playerStacks = amount
			end
			if amount % 3 == 0 then
				warnMoltenVenom:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421207 then
		--if self.Options.SetIconOnCoilingFlames then
		--	self:SetIcon(args.destName, 0)
		--end
		if args:IsPlayer() then
			yellCoilingFlamesFades:Cancel()
		end
	elseif spellId == 427201 then
		if self.Options.SetIconOnCoilingEruption then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellCoilingEruptionFades:Cancel()
		end
	elseif spellId == 419054 then
		if args:IsPlayer() then
			playerStacks = 0
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 423494 or spellId == 421082) and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--"<31.18 15:55:30> [UNIT_SPELLCAST_START] Volcoross(75.6%-43.0%){Target:Nnoggie} -Volcanic Disgorge- 2.5s [[boss1:Cast-3-5773-2549-5244-421616-0099903FD1:421616]]",
--"<31.18 15:55:30> [CLEU] SPELL_CAST_START#Creature-0-5773-2549-5244-208478-0000103F2B#Volcoross(75.6%-43.0%)##nil#421616#Volcanic Disgorge#nil#nil",
--"<31.20 15:55:30> [UNIT_TARGET] boss1#Volcoross#Target: ??#TargetOfTarget: ??",
--"<31.69 15:55:30> [UNIT_TARGET] boss1#Volcoross#Target: Revvezt#TargetOfTarget: Volcoross",
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 421616 then
		self:BossUnitTargetScanner(uId, "DisgorgeTarget", 1.1, true)--Allow tank true
	end
end

--Maybe still use this later with clever filtering
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 421356 or spellId == 421359 or spellId == 421684 then--Scorchtail Crash

	end
end
