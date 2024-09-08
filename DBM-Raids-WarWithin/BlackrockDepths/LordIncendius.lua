local mod	= DBM:NewMod(2665, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226304)
mod:SetEncounterID(3043)
mod:SetUsedIcons(8, 7, 6)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 463503 463486 463472 463495",
	"SPELL_SUMMON 463470",
	"SPELL_AURA_APPLIED 463504",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 463492",
	"SPELL_PERIODIC_MISSED 463492",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, verify firewall event and change it as needed
--TODO, add tank to switch alert if adds need to be tanked
--TODO, add total for auto marking
--TODO, possibly calculate cast time for https://www.wowhead.com/ptr-2/spell=463471/blaze and add cast bar or cast nameplate prio bar
--TODO, possibly non emphasized warning for https://www.wowhead.com/ptr-2/spell=463500/blowback target that announces to tanks and healers
local warnFirewall							= mod:NewCountAnnounce(463487, 3)
local warnConsumptiveFlames					= mod:NewTargetNoFilterAnnounce(463503, 3, nil, "Healer")
local warnDyingFlare						= mod:NewCastAnnounce(463472, 4)

local specWarnSummonFlameGeyser				= mod:NewSpecialWarningSwitchCount(463486, "Dps", nil, nil, 1, 2)
local specWarnScorchingWind					= mod:NewSpecialWarningCount(463495, nil, nil, nil, 2, 13)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(463492, nil, nil, nil, 1, 8)

local timerFirewallCD						= mod:NewAITimer(10, 463487, nil, nil, nil, 3)
local timerConsumptiveFlamesCD				= mod:NewAITimer(10, 463503, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerSummonFlameGeyserCD				= mod:NewAITimer(10, 463486, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDyingFlare						= mod:NewCastNPTimer(10, 463472, nil, nil, nil, 3)--Nameplate only prio cast timer with glow feature
local timerScorchingWindCD					= mod:NewAITimer(10, 463495, nil, nil, nil, 2)

--mod:AddNamePlateOption("NPOnHoney", 443983)
mod:AddSetIconOption("SetIconOnAdds", 463486, true, 5, {8, 7, 6})

--local castsPerGUID = {}
mod.vb.FirewallCount = 0
mod.vb.ConsumptiveFlamesCount = 0
mod.vb.SummonFlameGeyserCount = 0
mod.vb.addIcon = 8
mod.vb.scorchingWindCount = 0

function mod:OnCombatStart(delay)
	self.vb.FirewallCount = 0
	self.vb.ConsumptiveFlamesCount = 0
	self.vb.SummonFlameGeyserCount = 0
	self.vb.addIcon = 8
	self.vb.scorchingWindCount = 0
	timerFirewallCD:Start(1-delay)
	timerConsumptiveFlamesCD:Start(1-delay)
	timerSummonFlameGeyserCD:Start(1-delay)
	timerScorchingWindCD:Start(1-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 463503 then
		self.vb.ConsumptiveFlamesCount = self.vb.ConsumptiveFlamesCount + 1
		timerConsumptiveFlamesCD:Start()
	elseif spellId == 463486 then
		self.vb.SummonFlameGeyserCount = self.vb.SummonFlameGeyserCount + 1
		self.vb.addIcon = 8
		specWarnSummonFlameGeyser:Show(self.vb.SummonFlameGeyserCount)
		specWarnSummonFlameGeyser:Play("killmob")
		timerSummonFlameGeyserCD:Start()
	elseif spellId == 463472 then
		if self:AntiSpam(2.5, 1) then
			warnDyingFlare:Show()
		end
		timerDyingFlare:Start(nil, args.sourceGUID)
	elseif spellId == 463495 then
		self.vb.scorchingWindCount = self.vb.scorchingWindCount + 1
		specWarnScorchingWind:Show(self.vb.scorchingWindCount)
		specWarnScorchingWind:Play("pushbackincoming")
		specWarnScorchingWind:ScheduleVoice(1.5, "keepmove")
		timerScorchingWindCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 463470 then
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnAdds")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end

--[[
function mod:SPELL_CAST_SUCCES(args)
	local spellId = args.spellId
	if spellId == 463490 or spellId == 463489 or spellId == 463488 then--Locational based scripts for Firewall, may be in log
		self.vb.FirewallCount = self.vb.FirewallCount + 1
		warnFirewall:Show(self.vb.FirewallCount)
		timerFirewallCD:Start()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 463504 then
		warnConsumptiveFlames:CombinedShow(0.3, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 440134 then

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 463492 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
--https://www.wowhead.com/ptr-2/npc=230079/flame-geyser
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 218016 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 463487 then
		self.vb.FirewallCount = self.vb.FirewallCount + 1
		warnFirewall:Show(self.vb.FirewallCount)
		timerFirewallCD:Start()
	end
end
