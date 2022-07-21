local mod	= DBM:NewMod(2494, "DBM-Party-Dragonflight", 4, 1199)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181861)
mod:SetEncounterID(2610)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 374365 375068 375251",
	"SPELL_CAST_SUCCESS 375436",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 375204",
	"SPELL_PERIODIC_MISSED 375204"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 374365 or ability.id = 375068 or ability.id = 375251 or ability.id = 375439) and type = "begincast"
 or ability.id = 375436 and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--TODO, verify target scan for lava spray, or maybe use RAID_BOSS_WHISPER?
--TODO, longer pull with actually more than one mutation
local warnVolatileMutation						= mod:NewCountAnnounce(374365, 3)
local warnLavaSpray								= mod:NewTargetNoFilterAnnounce(375251, 3)

local specWarnMagmaLob							= mod:NewSpecialWarningDodge(375068, nil, nil, nil, 2, 2)
local specWarnLavaSpray							= mod:NewSpecialWarningYou(375251, nil, nil, nil, 1, 2)
local yellLavaSpray								= mod:NewYell(375251)
local specWarnBlazingCharge						= mod:NewSpecialWarningDodge(375436, nil, nil, nil, 2, 2)
local yellBlazingCharge							= mod:NewYell(375436)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(375204, nil, nil, nil, 1, 8)

local timerVolatileMutationCD					= mod:NewCDTimer(35, 374365, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerMagmaLobCD							= mod:NewCDTimer(8, 375068, nil, nil, nil, 3)--8 unless delayed by other casts
local timerLavaSrayCD							= mod:NewCDTimer(23.4, 375251, nil, nil, nil, 3)
local timerBlazingChargeCD						= mod:NewCDTimer(23, 375436, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

mod.vb.mutationCount = 0

function mod:LavaSprayTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnLavaSpray:Show()
		specWarnLavaSpray:Play("targetyou")
		yellLavaSpray:Yell()
	else
		warnLavaSpray:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.mutationCount = 0
	timerVolatileMutationCD:Start(25.8-delay)
	timerMagmaLobCD:Start(8-delay)
	timerLavaSrayCD:Start(7.2-delay)
	timerBlazingChargeCD:Start(19.7-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 374365 then
		self.vb.mutationCount = self.vb.mutationCount + 1
		warnVolatileMutation:Show(self.vb.mutationCount)
--		timerVolatileMutationCD:Start()--Unknown, most kills too short
	elseif spellId == 375068 then
		specWarnMagmaLob:Show()
		specWarnMagmaLob:Play("watchstep")
		timerMagmaLobCD:Start()
	elseif spellId == 375251 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "LavaSprayTarget", 0.1, 8, true)
		timerLavaSrayCD:Start()
--	elseif spellId == 375439 then--Backup Trigger for Blazing Charge

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 375436 then--Blazing Charge trigger with target information (Although pretty sure it's always on the tank)
		specWarnBlazingCharge:Show()
		specWarnBlazingCharge:Play("chargemove")
		timerBlazingChargeCD:Start()
		if args:IsPlayer() then
			yellBlazingCharge:Yell()
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 375204 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
