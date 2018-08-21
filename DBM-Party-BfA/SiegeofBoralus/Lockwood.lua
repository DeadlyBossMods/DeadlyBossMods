local mod	= DBM:NewMod(2173, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(129208)
mod:SetEncounterID(2109)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 269029 268230 268260",
	"SPELL_CAST_SUCCESS 268752",
	"UNIT_DIED"
)

--TODO, cannons remaining, who's carrying ordinance, etc
local warnWithdraw					= mod:NewSpellAnnounce(268752, 2)
local warnCrimsonSwipe				= mod:NewSpellAnnounce(268230, 2, nil, "Tank")
local warnBroadside					= mod:NewSpellAnnounce(268260, 2)

local specWarnCleartheDeck			= mod:NewSpecialWarningDodge(269029, "Tank", nil, nil, 3, 2)
--local specWarnBroadside			= mod:NewSpecialWarningDodge(268260, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCleartheDeckCD			= mod:NewAITimer(13, 269029, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerCrimsonSwipeCD			= mod:NewAITimer(13, 268230, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerCleartheDeckCD:Start(1-delay)
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
		--timerCrimsonSwipeCD:Start(nil, args.sourceGUID)
	elseif spellId == 268260 and self:AntiSpam(3, 1) then
		warnBroadside:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 268752 then
		warnWithdraw:Show()
		timerCleartheDeckCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 141532 then--Ashvane Deckhand
		--timerCrimsonSwipeCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
