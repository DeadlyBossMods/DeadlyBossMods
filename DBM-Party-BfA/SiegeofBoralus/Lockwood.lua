local mod	= DBM:NewMod(2173, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(129208)
mod:SetEncounterID(2109)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 269029 268230",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1 boss2 boss3 boss4 boss5",--boss and Adds
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--boss and Adds
)

--TODO, cannons remaining, who's carrying ordinance, etc
local warnWithdraw					= mod:NewSpellAnnounce(268752, 2)
local warnCrimsonSwipe				= mod:NewSpellAnnounce(268230, 2, nil, false, 2)--Can't be avoided by tanks, so opt in, not opt out
local warnUnstableOrdnance			= mod:NewSpellAnnounce(268995, 1)

local specWarnCleartheDeck			= mod:NewSpecialWarningDodge(269029, "Tank", nil, nil, 3, 2)
local specWarnHeavySlash			= mod:NewSpecialWarningDodge(257288, "Tank", nil, nil, 1, 2)
local specWarnBroadside				= mod:NewSpecialWarningDodge(268260, "Tank", nil, nil, 1, 2)

local timerWithdrawCD				= mod:NewCDTimer(40, 268752, nil, nil, nil, 6)
local timerCleartheDeckCD			= mod:NewCDTimer(20, 269029, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Need more data
local timerCrimsonSwipeCD			= mod:NewCDTimer(9, 268230, nil, false, 2, 5, nil, DBM_CORE_TANK_ICON)
local timerBroadsideCD				= mod:NewCDTimer(9, 268260, nil, nil, nil, 3)--Need more data

mod.vb.bossGone = false

function mod:OnCombatStart(delay)
	self.vb.bossGone = false
	timerCleartheDeckCD:Start(4.3-delay)
	timerWithdrawCD:Start(13.1-delay)
end

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
