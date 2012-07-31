local mod	= DBM:NewMod(679, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60051, 60043, 59915, 60047)--Cobalt: 60051 Jade: 60043 Jasper: 59915
mod:SetModelID(41892)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnCobaltOverload			= mod:NewCastAnnounce(115840, 4, 7)
local warnJadeOverload				= mod:NewCastAnnounce(115842, 4, 7)
local warnJasperOverload			= mod:NewCastAnnounce(115843, 4, 7)
local warnAmethystOverload			= mod:NewCastAnnounce(115844, 4, 7)
--local warnCobaltGrasp				= mod:NewTargetAnnounce(116281, 3)
local warnJadeShards				= mod:NewSpellAnnounce(116223, 3)
local warnJasperChains				= mod:NewTargetAnnounce(116207, 4)
local warnAmethystPool				= mod:NewSpellAnnounce(116235, 3, nil, mod:IsMelee())

local specWarnCobaltOverload		= mod:NewSpecialWarningSpell(115840, nil, nil, nil, true)
local specWarnJadeOverload			= mod:NewSpecialWarningSpell(115842, nil, nil, nil, true)
local specWarnJasperOverload		= mod:NewSpecialWarningSpell(115843, nil, nil, nil, true)
local specWarnAmethystOverload		= mod:NewSpecialWarningSpell(115844, nil, nil, nil, true)
--local specWarnCobaltGrasp			= mod:NewSpecialWarningDispel(116281, false)
local specWarnJasperChains			= mod:NewSpecialWarningYou(115844)
local yellJasperChains				= mod:NewYell(115844)
local specWarnAmethystPool			= mod:NewSpecialWarningMove(130774)

local timerCobaltOverload			= mod:NewCastTimer(7, 115840)
local timerJadeOverload				= mod:NewCastTimer(7, 115842)
local timerJasperOverload			= mod:NewCastTimer(7, 115843)
local timerAmethystOverload			= mod:NewCastTimer(7, 115844)
--local timerGobaltGrasp			= mod:NewTargetTimer(6, 116281)
--local timerGobaltGraspCD			= mod:NewCDTimer(12, 116281)--12-15second variations
local timerJadeShardsCD				= mod:NewNextTimer(20.5, 116223)--Always 20.5 seconds
local timerJasperChainsCD			= mod:NewCDTimer(12, 115844)--11-13
local timerAmethystPoolCD			= mod:NewCDTimer(6, 116235, nil, mod:IsMelee())

local expectedBosses = 3
local Jade = EJ_GetSectionInfo(5773)
local Jasper = EJ_GetSectionInfo(5774)
local Cobalt = EJ_GetSectionInfo(5771)
local Amethyst = EJ_GetSectionInfo(5691)
local jasperChainsTargets = {}

local function warnJasperChainsTargets()
	warnJasperChains:Show(table.concat(jasperChainsTargets, "<, >"))
	table.wipe(jasperChainsTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(jasperChainsTargets)
	if self:IsDifficulty("normal25", "heroic25") then
--		timerGobaltGraspCD:Start(-delay)
		timerJasperChainsCD:Start(-delay)
		timerJadeShardsCD:Start(-delay)
		timerAmethystPoolCD:Start(-delay)
		expectedBosses = 4--Only fight all 4 at once on 25man (excluding LFR)
	else
		expectedBosses = 3--Else you get a random set of 3/4
		--Timers here will require more work (IE scanning boss1-4 to determine which boss is NOT up then start timers for all but him)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(130395) then
		jasperChainsTargets[#jasperChainsTargets + 1] = args.destName
		timerJasperChainsCD:Start()
		self:Unschedule(warnJasperChainsTargets)
		self:Schedule(0.3, warnJasperChainsTargets)
		if args:IsPlayer() then
			specWarnJasperChains:Show()
			yellJasperChains:Yell()
		end
	elseif args:IsSpellID(130774) and args:IsPlayer() then
		specWarnAmethystPool:Show()
--[[elseif args:IsSpellID(116281) then
		warnCobaltGrasp:Show(args.destName)
		timerGobaltGrasp:Start(args.destName)
		timerGobaltGraspCD:Start()--]]
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(116281) then
		timerGobaltGrasp:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(116223) then
		warnJadeShards:Show()
		timerJadeShardsCD:Start()
--	elseif args:IsSpellID(116207) then
--		warnJasperCleave:Show(args.destName)
--		timerJasperCleaveCD:Start()
	elseif args:IsSpellID(116235) then
		warnAmethystPool:Show()
		timerAmethystPoolCD:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg, boss)
	if msg == L.Overload or msg:find(L.Overload) then--Cast trigger is an emote 5 seconds before, CLEU only shows explosion. Just like nefs electrocute
		self:SendSync("Overload", boss == Cobalt and "Cobalt" or boss == Jade and "Jade" or boss == Jasper and "Jasper" or boss == Amethyst and "Amethyst" or "Unknown")
	end
end

function mod:OnSync(msg, boss)
	if msg == "Overload" then
		if boss == "Cobalt" then
			warnCobaltOverload:Show()
			specWarnCobaltOverload:Show()
			timerCobaltOverload:Start()
		elseif boss == "Jade" then
			warnJadeOverload:Show()
			specWarnJasperOverload:Show()
			timerJadeOverload:Start()
		elseif boss == "Jasper" then
			warnJasperOverload:Show()
			specWarnJasperOverload:Show()
			timerJasperOverload:Start()
		elseif boss == "Amethyst" then
			warnAmethystOverload:Show()
			specWarnAmethystOverload:Show()
			timerAmethystOverload:Start()
		end
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

