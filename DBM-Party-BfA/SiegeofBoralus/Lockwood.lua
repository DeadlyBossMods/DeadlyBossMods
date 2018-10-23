local mod	= DBM:NewMod(2173, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(129208)
mod:SetEncounterID(2109)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 269029 268230",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1 boss2 boss3 boss4 boss5",--Adds only
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--boss and Adds
)

--TODO, cannons remaining, who's carrying ordinance, etc
local warnWithdraw					= mod:NewSpellAnnounce(268752, 2)
local warnCrimsonSwipe				= mod:NewSpellAnnounce(268230, 2, nil, false, 2)--Can't be avoided by tanks, so opt in, not opt out
local warnUnstableOrdnance			= mod:NewSpellAnnounce(268995, 1)

local specWarnCleartheDeck			= mod:NewSpecialWarningDodge(269029, "Tank", nil, nil, 3, 2)
local specWarnHeavySlash			= mod:NewSpecialWarningDodge(257288, "Tank", nil, nil, 1, 2)
local specWarnBroadside				= mod:NewSpecialWarningDodge(268260, "Tank", nil, nil, 1, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerWithdrawCD				= mod:NewCDTimer(40, 268752, nil, nil, nil, 6)
local timerCleartheDeckCD			= mod:NewCDTimer(20, 269029, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Need more data
local timerCrimsonSwipeCD			= mod:NewCDTimer(9, 268230, nil, false, 2, 5, nil, DBM_CORE_TANK_ICON)
local timerBroadsideCD				= mod:NewCDTimer(9, 268260, nil, nil, nil, 3)--Need more data

--mod:AddRangeFrameOption(5, 194966)

mod.vb.bossGone = false

function mod:OnCombatStart(delay)
	self.vb.bossGone = false
	timerCleartheDeckCD:Start(4.3-delay)
	timerWithdrawCD:Start(13.1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then
	
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 269029 then
		specWarnCleartheDeck:Show()
		specWarnCleartheDeck:Play("shockwave")
		timerCleartheDeckCD:Start()
	elseif spellId == 268230 then
		if self:AntiSpam(3, 1) then
			warnCrimsonSwipe:Show()
		end
		timerCrimsonSwipeCD:Start(nil, args.sourceGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 141532 then--Ashvane Deckhand
		timerCrimsonSwipeCD:Stop(args.destGUID)
	end
end

--Not in combat log what so ever
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 257288 and self:AntiSpam(3, 1) then
		specWarnHeavySlash:Show()
		specWarnHeavySlash:Play("shockwave")
	elseif spellId == 268260 then--Broadside 
		specWarnBroadside:Show()
		specWarnBroadside:Play("watchstep")
		timerBroadsideCD:Start(10.9)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 268752 then--Withdraw (boss Leaving)
		self.vb.bossGone = true
		warnWithdraw:Show()
		timerCleartheDeckCD:Stop()
		timerBroadsideCD:Start(11.3)
	elseif spellId == 268745 and self.vb.bossGone then--Energy Tracker (boss returning)
		self.vb.bossGone = false
		timerBroadsideCD:Stop()
		timerCleartheDeckCD:Start(4.3)
		timerWithdrawCD:Start(36)
	elseif spellId == 268963 then--Unstable Ordnance
		warnUnstableOrdnance:Show()
		timerBroadsideCD:Stop()
	end
end
