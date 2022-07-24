local mod	= DBM:NewMod(2501, "DBM-Party-Dragonflight", 4, 1199)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189901)
mod:SetEncounterID(2611)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 376780 377017 377204 377473",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 376780 377018 377022 377522",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 376780",
	"SPELL_PERIODIC_DAMAGE 377542",
	"SPELL_PERIODIC_MISSED 377542"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Molten Gold/hardened gold are just so inconsiquential that I suspect blizzard will change or scrap it
--TODO, verify Kiln target scan
--[[
ability.id = 376780 and (type = "begincast" or type = "applybuff" or type = "removebuff")
 or (ability.id = 377017 or ability.id = 377204 or ability.id = 377473) and type = "begincast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnMagmaShield							= mod:NewTargetNoFilterAnnounce(376780, 3)
local warnMagmaShieldOver						= mod:NewEndAnnounce(376780, 1)
local warnMoltenGold							= mod:NewTargetNoFilterAnnounce(377018, 2, nil, "Healer")
local warnHardenedGold							= mod:NewYouAnnounce(377022, 2)--So inconsiquential it doesn't even deserve a special announcement
local warnBurningPursuit						= mod:NewTargetNoFilterAnnounce(377522, 3)

local specWarnDragonsKiln						= mod:NewSpecialWarningDodge(377204, nil, nil, nil, 2, 2)
local yellDragonsKiln							= mod:NewYell(377204)
local specWarnBurningEmber						= mod:NewSpecialWarningDodge(377477, nil, nil, nil, 2, 2)
local specWarnBurningPursuit					= mod:NewSpecialWarningYou(377522, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(377542, nil, nil, nil, 1, 8)

local timerMagmaShieldCD						= mod:NewCDTimer(33.4, 376780, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerMoltenGoldCD							= mod:NewCDTimer(35, 377018, nil, nil, nil, 3)
local timerDragonsKilnCD						= mod:NewCDTimer(21, 377204, nil, nil, nil, 3)
local timerBurningEmberCD						= mod:NewCDTimer(35, 377477, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(376780, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:DragonsKilnTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellDragonsKiln:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerDragonsKilnCD:Start(7-delay)
	timerMoltenGoldCD:Start(14.7-delay)
	timerBurningEmberCD:Start(22-delay)
	timerMagmaShieldCD:Start(34.1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 376780 then
--		timerMagmaShieldCD:Start()
	elseif spellId == 377017 then
		timerMoltenGoldCD:Start()
	elseif spellId == 377204 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DragonsKilnTarget", 0.1, 8, true)
		specWarnDragonsKiln:Show()
		specWarnDragonsKiln:Play("shockwave")
		timerDragonsKilnCD:Start()
	elseif spellId == 377473 then
		specWarnBurningEmber:Show()
		specWarnBurningEmber:Play("watchstep")
		timerBurningEmberCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 376780 then
		warnMagmaShield:Show(args.destName)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
		--Do timers stop and restart after shield, or pause and resume?
		timerDragonsKilnCD:Stop()
		timerMoltenGoldCD:Stop()
		timerBurningEmberCD:Stop()
	elseif spellId == 377018 then
		warnMoltenGold:Show(args.destName)
	elseif spellId == 377022 and args:IsPlayer() then
		warnHardenedGold:Show()
	elseif spellId == 377522 then
		if args:IsPlayer() then
			specWarnBurningPursuit:Show()
			specWarnBurningPursuit:Play("targetyou")
		else
			warnBurningPursuit:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 376780 then
		warnMagmaShieldOver:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		timerMoltenGoldCD:Start(10)
		timerBurningEmberCD:Start(14.3) -- ~1
		timerDragonsKilnCD:Start(18.6) -- ~1
		timerMagmaShieldCD:Start(30.9)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 377542 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) and not DBM:UnitDebuff("player", 377022) then--GTFO filtered if you have Hardened Gold
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
