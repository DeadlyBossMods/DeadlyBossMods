local mod	= DBM:NewMod(2449, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175546)
mod:SetEncounterID(2419)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 347149 350517 352345",
	"SPELL_CAST_SUCCESS 347370",
	"SPELL_AURA_APPLIED 354334",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 358947",
	"SPELL_PERIODIC_MISSED 358947",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is swipe a cast ability on cd or just something that's cast when someone is by tail/in wrong place?
--TODO, stronger warn cannon barrage?
--TODO, target scan anchor shot, or emote that can be used for pre target?
local warnHookd						= mod:NewTargetNoFilterAnnounce(354334, 2, nil, "Healer")
local warnDoubleTime				= mod:NewCastAnnounce(350517, 3)
local warnBrute						= mod:NewCountAnnounce("ej23833", 2, 215841)
--Corsair Cannoneers
local warnCannonBarrage				= mod:NewSpellAnnounce(347370, 3)
local warnAnchorShot				= mod:NewCastAnnounce(352345, 3)

local specWarnInfiniteBreath		= mod:NewSpecialWarningCount(347149, "Tank", nil, nil, 1, 2)
--local yellEmbalmingIchor			= mod:NewYell(327664)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(358947, nil, nil, nil, 1, 8)

local timerInfiniteBreathCD			= mod:NewAITimer(15.8, 347149, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerDoubleTimeCD				= mod:NewAITimer(11, 350517, nil, nil, nil, 3)
local timerBruteCD					= mod:NewAITimer(11, "ej23833", nil, nil, nil, 1, 215841)
--Corsair Cannoneers
local timerCannonBarrageCD			= mod:NewAITimer(11, 347370, nil, nil, nil, 3)
local timerAnchorShotCD				= mod:NewAITimer(11, 352345, nil, nil, nil, 3)

mod.vb.breathCount = 0
mod.vb.bruteCount = 0

function mod:OnCombatStart(delay)
	self.vb.breathCount = 0
	self.vb.bruteCount = 0
	timerInfiniteBreathCD:Start(1-delay)
	timerDoubleTimeCD:Start(1-delay)
	timerBruteCD:Start(1-delay)
	--Cannoneers
	timerCannonBarrageCD:Start(1-delay)
	timerAnchorShotCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 347149 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnInfiniteBreath:Show(self.vb.breathCount)
		specWarnInfiniteBreath:Play("breathsoon")
		timerInfiniteBreathCD:Start()
	elseif spellId == 350517 then
		warnDoubleTime:Show()
		timerDoubleTimeCD:Start()
	elseif spellId == 352345 then
		warnAnchorShot:Show()
		timerAnchorShotCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 347370 then
		warnCannonBarrage:Show()
		timerCannonBarrageCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354334 then
		warnHookd:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 358947 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 351150 then--Call Brutes (Assumed, not verified)
		self.vb.bruteCount = self.vb.bruteCount + 1
		warnBrute:Show(self.vb.bruteCount)
		timerBruteCD:Start()
	end
end
