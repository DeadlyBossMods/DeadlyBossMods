local mod	= DBM:NewMod(2476, "DBM-Party-Dragonflight", 2, 1197)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184422)
mod:SetEncounterID(2558)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 368990 369110 369198 369061",
	"SPELL_CAST_SUCCESS 369033 369049",
	"SPELL_AURA_APPLIED 369110 369198",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 369110 369198 368990"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, detect purging flames ending so timer for next one can start (assuming that is what it's based on)
--TODO, auto mark adds?
--TODO, target scan to warn warn for https://www.wowhead.com/beta/spell=369049/seeking-flame targets? doesn't seem like you can do much about it (no interrupts, no splash, just repheal)
--TODO, verify timer resets on boss switching in and out of Puring Flames stage
--[[
(ability.id = 368990 or ability.id = 369110 or ability.id = 369198 or ability.id = 369061) and type = "begincast"
 or ability.id = 369033 and type = "cast"
 or ability.id = 368990 and type = "removebuff"
 or (target.id = 186107 or target.id = 186173) and type = "death"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnActivateKeepers						= mod:NewSpellAnnounce(369033, 3)
local warnUnstableEmbers						= mod:NewTargetNoFilterAnnounce(369110, 3)
local warnSeekingFlame							= mod:NewYouAnnounce(369049, 3, nil, false)--In case you want to know, but not totally practical to enable by default

local specWarnPurgingFlames						= mod:NewSpecialWarningDodgeCount(368990, nil, nil, nil, 2, 2)
local specWarnUnstableEmbers					= mod:NewSpecialWarningMoveAway(369110, nil, nil, nil, 1, 2)
local yellUnstableEmbers						= mod:NewYell(369110)
local yellUnstableEmbersFades					= mod:NewShortFadesYell(369110)
local specWarnSearingClap						= mod:NewSpecialWarningDefensive(369061, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerActivateKeepersCD					= mod:NewCDTimer(35, 369033, nil, nil, nil, 1)
local timerPurgingFlamesCD						= mod:NewCDCountTimer(35, 368990, nil, nil, nil, 6)--Maybe swap for activate keepers instead
local timerUnstableEmbersCD						= mod:NewCDCountTimer(12, 369110, nil, nil, nil, 3)
local timerSearingClapCD						= mod:NewCDTimer(35, 369061, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

mod.vb.addsRemaining = 0
mod.vb.embersCount = 0
mod.vb.purgingCount = 0

function mod:OnCombatStart(delay)
	self.vb.addsRemaining = 0
	self.vb.embersCount = 0
	self.vb.purgingCount = 0
	timerActivateKeepersCD:Start(3.5-delay)
	timerSearingClapCD:Start(4.7-delay)
	timerUnstableEmbersCD:Start(13.1-delay, 1)
	timerPurgingFlamesCD:Start(20.4-delay, 1)
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
	if spellId == 368990 then
		self.vb.purgingCount = self.vb.purgingCount + 1
		specWarnPurgingFlames:Show(self.vb.purgingCount)
		specWarnPurgingFlames:Play("farfromline")

		--Stop, just in case, but the timers shouldn't be running at this point since they are already conditioned not to start extra times
		timerActivateKeepersCD:Stop()
		timerUnstableEmbersCD:Stop()
		timerSearingClapCD:Stop()
	elseif spellId == 369110 or spellId == 369198 then--110 confirmed, 198 unknown
		self.vb.embersCount = self.vb.embersCount + 1
		if self.vb.embersCount == 1 and self.vb.purgingCount >= 1 then
			timerUnstableEmbersCD:Start(12, 2)
		end
	elseif spellId == 369061 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSearingClap:Show()
			specWarnSearingClap:Play("defensive")
		end
--		timerSearingClapCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 369033 then
		warnActivateKeepers:Show()
		self.vb.addsRemaining = self.vb.addsRemaining + (self:IsMythic() and 6 or self:IsHeroic() and 4 or 3)
	elseif spellId == 369049 and args:IsPlayer() and self:AntiSpam(3, 1) then
		warnSeekingFlame:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 369110 or spellId == 369198 then--110 confirmed, 198 unknown
		warnUnstableEmbers:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnUnstableEmbers:Show()
			specWarnUnstableEmbers:Play("runout")
			yellUnstableEmbers:Yell()
			yellUnstableEmbersFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 369110 or spellId == 369198 then
		if args:IsPlayer() then
			yellUnstableEmbersFades:Cancel()
		end
	elseif spellId == 368990 then--Purging Flames over
		self.vb.embersCount = 0
		timerUnstableEmbersCD:Start(1.9, 1)
		timerActivateKeepersCD:Start(5.5)
		timerSearingClapCD:Start(6.7)
		timerPurgingFlamesCD:Start(26.1, self.vb.purgingCount+1)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 186107 or cid == 186173 then--Vault Keeper
		self.vb.addsRemaining = self.vb.addsRemaining - 1
		if self.vb.addsRemaining == 0 then

		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
