local mod	= DBM:NewMod(2436, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175646)
mod:SetEncounterID(2424)
mod:SetHotfixNoticeRev(20220405000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 346947 346286 346742 346293",
	"SPELL_CAST_SUCCESS 346962",
	"SPELL_AURA_APPLIED 346844 346329 346962 346403 356374 369133",
	"SPELL_AURA_REMOVED 346962"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, package tracking with icon/infoframe for tosses as well?
local warnHazardousLiquids			= mod:NewSpellAnnounce(346286, 2)
local warnAlchemicalResidue			= mod:NewTargetNoFilterAnnounce(346844, 2, nil, false, 2)
local warnUnstableGoods				= mod:NewTargetNoFilterAnnounce(369133, 2)--Holding package

local specWarnUnstableGoods			= mod:NewSpecialWarningCount(346947, nil, nil, nil, 1, 2)
local specWarnFanMail				= mod:NewSpecialWarningCount(346293, nil, nil, nil, 2, 2)
local specWarnMoneyOrder			= mod:NewSpecialWarningMoveTo(346962, nil, nil, nil, 1, 2)
local yellMoneyOrder				= mod:NewYell(346962, nil, nil, nil, "YELL")
local yellMoneyOrderFades			= mod:NewShortFadesYell(346962, nil, nil, nil, "YELL")
local specWarnGTFO					= mod:NewSpecialWarningGTFO(346329, nil, nil, nil, 1, 8)

local timerUnstableGoodsCD			= mod:NewCDTimer(51.8, 346947, nil, nil, nil, 5)
local timerHazardousLiquidsCD		= mod:NewCDTimer(52.1, 346286, nil, nil, nil, 3)
local timerFanMailCD				= mod:NewCDTimer(25.1, 346293, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerMoneyOrderCD				= mod:NewCDTimer(50.6, 346962, nil, nil, nil, 3)

mod:GroupSpells(369133, 346947)--Unstable goods, one for spawn and one for holdin it, two diff icons so separated on purpose

mod.vb.goodPhase = 0
mod.vb.fanCount = 0

function mod:OnCombatStart(delay)
	self.vb.goodPhase = 0
	self.vb.fanCount = 0
	timerHazardousLiquidsCD:Start(6.9-delay)
	timerFanMailCD:Start(16.1-delay)
	timerMoneyOrderCD:Start(23.4-delay)
	timerUnstableGoodsCD:Start(30.6-delay)--START
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 346947 then
		self.vb.goodPhase = self.vb.goodPhase + 1
		specWarnUnstableGoods:Show(self.vb.goodPhase)
		specWarnUnstableGoods:Play("specialsoon")
		timerUnstableGoodsCD:Start()
	elseif spellId == 346286 then
		warnHazardousLiquids:Show()
		timerHazardousLiquidsCD:Start()
	elseif spellId == 346742 or spellId == 346293 then--Which one used? or maybe it's hard and non hard?
		self.vb.fanCount = self.vb.fanCount + 1
		specWarnFanMail:Show(self.vb.fanCount)
		specWarnFanMail:Play("aesoon")
		timerFanMailCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 346962 then
		timerMoneyOrderCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 346844 then
		warnAlchemicalResidue:CombinedShow(1, args.destName)
	elseif spellId == 346329 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 346962 then
		if args:IsPlayer() then
			specWarnMoneyOrder:Show(DBM_COMMON_L.ALLIES)
			yellMoneyOrder:Yell()
			yellMoneyOrderFades:Countdown(spellId)
		else
			specWarnMoneyOrder:Show(args.destName)
		end
		specWarnMoneyOrder:Play("gathershare")
	elseif spellId == 369133 or spellId == 356374 or spellId == 346403 then--369133 confirmed, other 2 unknown
		warnUnstableGoods:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 346962 then
		if args:IsPlayer() then
			yellMoneyOrderFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then

	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
