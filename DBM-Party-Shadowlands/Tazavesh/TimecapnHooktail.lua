local mod	= DBM:NewMod(2449, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175546)
mod:SetEncounterID(2419)
mod:SetHotfixNoticeRev(20220405000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 347149 350517 347151",
	"SPELL_CAST_SUCCESS 352345",
	"SPELL_AURA_APPLIED 354334",
	"SPELL_PERIODIC_DAMAGE 358947",
	"SPELL_PERIODIC_MISSED 358947"
)

--Notes: Cannon Barrage has no entries for cast, only damage, no clean timers/warnings for it so omitted
--TODO, Fix hook swipe when blizzard re-enables the ability they accidentally deleted.
--[[
(ability.id = 347149 or ability.id = 350517 or ability.id = 347151) and type = "begincast"
 or ability.id = 352345 and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--Boss
local warnHookd						= mod:NewTargetNoFilterAnnounce(354334, 2, nil, "Healer")
local warnDoubleTime				= mod:NewCastAnnounce(350517, 3)

local specWarnInfiniteBreath		= mod:NewSpecialWarningCount(347149, "Tank", nil, nil, 1, 2)
local specWarnAnchorShot			= mod:NewSpecialWarningYou(352345, nil, nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(358947, nil, nil, nil, 1, 8)

local timerInfiniteBreathCD			= mod:NewCDTimer(12, 347149, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerHookSwipeCD				= mod:NewCDTimer(12, 347151, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerDoubleTimeCD				= mod:NewCDTimer(54.6, 350517, nil, nil, nil, 3)

mod:GroupSpells(347151, 354334)--Group Hook'd debuff with Hook Swipe
--Corsair Cannoneers
--local warnCannonBarrage				= mod:NewSpellAnnounce(347370, 3)
local warnAnchorShot				= mod:NewTargetNoFilterAnnounce(352345, 3)

local timerAnchorShotCD				= mod:NewCDTimer(11, 352345, nil, nil, nil, 3)

mod.vb.breathCount = 0
mod.vb.anchorCount = 0

--Maybe worth adding?
--"Super Saison-356133-npc:180015-000048C7C5 = pull:28.5, 30.4, 30.4",
--"Sword Toss-368661-npc:179386-000048C7C6 = pull:12.7, 14.6, 14.6",
--These are handled different right now but might sequence if other handling faulters
--"Infinite Breath-347149-npc:175546-000048CB60 = pull:15.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 7.0, 12.0, 12.0, 12.0, 12.0, 7.0, 12.0, 12.0, 12.0", -- [9]
--"Anchor Shot-352345-npc:176178-000048C7C5 = pull:59.0, 21.0, 20.0, 14.0, 21.0, 20.0, 14.0, 21.0, 20.0", -- [1]

function mod:OnCombatStart(delay)
	self.vb.breathCount = 0
	self.vb.anchorCount = 0
--	timerHookSwipeCD:Start(8.2-delay)--April 5th hotfixes broke it and he doesn't cast this anymore
	timerInfiniteBreathCD:Start(15-delay)
	timerDoubleTimeCD:Start(55-delay)
	--Cannoneers
	timerAnchorShotCD:Start(58.9-delay)
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
		--When he casts double time it removes 5 seconds from current breath timer
		timerInfiniteBreathCD:RemoveTime(5)
		--It also removes 6 seconds from current Anchor Shot timer
--		timerAnchorShotCD:RemoveTime(6)--Handled via counting for now, but counting may fail if pull is long enough
	elseif spellId == 347151 then
--		timerHookSwipeCD:Start()--Work Needed
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 352345 then
		self.vb.anchorCount = self.vb.anchorCount + 1
		if args:IsPlayer() then
			specWarnAnchorShot:Show()
			specWarnAnchorShot:Play("targetyou")
		else
			warnAnchorShot:Show(args.destName)
		end
		if self.vb.anchorCount % 3 == 0 then
			timerAnchorShotCD:Start(14)
		else
			timerAnchorShotCD:Start(20)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354334 then
		warnHookd:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 358947 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
