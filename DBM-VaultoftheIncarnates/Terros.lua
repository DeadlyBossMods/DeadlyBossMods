local mod	= DBM:NewMod(2500, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(190496)
mod:SetEncounterID(2639)
mod:SetUsedIcons(1, 2, 3, 4, 5)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 380487 377166 377505 383073 376279",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 386352 381253 376276",
	"SPELL_AURA_APPLIED_DOSE 376276",
	"SPELL_AURA_REMOVED 386352 381253",
	"SPELL_PERIODIC_DAMAGE 382458",
	"SPELL_PERIODIC_MISSED 382458"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Note: https://www.wowhead.com/beta/spell=380557/rock-blast indicates target counts, up to 5 on mythic
--TODO, verify Brutal Reverberation placement. maybe an actual event or something to use
--TODO, auto mark awakened Earth (after spawn)? Need to check events for it first
--TODO, also figure out how to handle awakened earth debuff, is it really 30 seconds and applied after rock blast ends on same targets? remark those?
--TODO, is Frenzied Devstation replacing Resonating Annihilation, or does it get cast in addition to it once the 4x casts happen?
--TODO, keep an eye on https://www.wowhead.com/beta/spell=391570/reactive-dust . not sure what to do with it yet, since this tooltip says something diff than journal
--TODO, adjust time remaining on Concussive Slam debuff check
local warnRockBlastCast							= mod:NewCastAnnounce(380487, 3)
local warnRockBlast								= mod:NewTargetNoFilterAnnounce(380487, 3)
local warnConcussiveSlam						= mod:NewStackAnnounce(372158, 2, nil, "Tank|Healer")

local specWarnRockBlast							= mod:NewSpecialWarningYouPos(380487, nil, nil, nil, 1, 2)
local yellRockBlast								= mod:NewShortPosYell(380487)
local yellRockBlastFades						= mod:NewIconFadesYell(380487)
local specWarnBrutalReverberation				= mod:NewSpecialWarningDodge(386400, nil, nil, nil, 2, 2)
local specWarnAwakenedEarth						= mod:NewSpecialWarningYou(381253, nil, nil, nil, 1, 2)
local yellAwakenedEarthFades					= mod:NewShortFadesYell(381253)
local specWarnResonatingAnnihilation			= mod:NewSpecialWarningCount(377166, nil, nil, nil, 3, 2)
local specWarnFrenziedDevastation				= mod:NewSpecialWarningDodge(377505, nil, nil, nil, 2, 2)
local specWarnShatteringImpact					= mod:NewSpecialWarningDodge(383073, nil, nil, nil, 2, 2)
local specWarnConcussiveSlam					= mod:NewSpecialWarningDefensive(376279, nil, nil, nil, 1, 2)
local specWarnConcussiveSlamTaunt				= mod:NewSpecialWarningTaunt(376279, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(382458, nil, nil, nil, 1, 8)

local timerRockBlastCD							= mod:NewAITimer(35, 380487, nil, nil, nil, 3)
local timerResonatingAnnihilationCD				= mod:NewAITimer(35, 377166, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerFrenziedDevastationCD				= mod:NewAITimer(35, 377505, nil, nil, nil, 3)
local timerShatteringImpactCD					= mod:NewAITimer(35, 383073, nil, nil, nil, 3)
local timerConcussiveSlamCD						= mod:NewAITimer(35, 376279, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnRockBlast", 380487, true, false, {1, 2, 3, 4, 5})

mod.vb.DebuffIcon = 1
mod.vb.annihilationCount = 0

function mod:OnCombatStart(delay)
	self.vb.annihilationCount = 0
	timerRockBlastCD:Start(1-delay)
	timerResonatingAnnihilationCD:Start(1-delay)
	timerFrenziedDevastationCD:Start(1-delay)
	timerShatteringImpactCD:Start(1-delay)
	timerConcussiveSlamCD:Start(1-delay)
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
	if spellId == 380487 then
		self.vb.DebuffIcon = 1
		warnRockBlastCast:Show()
		timerRockBlastCD:Start()
	elseif spellId == 377166 then
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		specWarnResonatingAnnihilation:Show(self.vb.annihilationCount)
		specWarnResonatingAnnihilation:Play("specialsoon")
		timerResonatingAnnihilationCD:Start()
	elseif spellId == 377505 then
		specWarnFrenziedDevastation:Show()
		specWarnFrenziedDevastation:Play("watchwave")
		timerFrenziedDevastationCD:Start()
	elseif spellId == 383073 then
		specWarnShatteringImpact:Show()
		specWarnShatteringImpact:Play("watchstep")--Or shockwave?
		timerShatteringImpactCD:Start()
	elseif spellId == 376279 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnConcussiveSlam:Show()
			specWarnConcussiveSlam:Play("defensive")
		end
		timerConcussiveSlamCD:Start()
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
	if spellId == 386352 then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnRockBlast then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRockBlast:Show(self:IconNumToTexture(icon))
			specWarnRockBlast:Play("mm"..icon)
			yellRockBlast:Yell(icon, icon)
			yellRockBlastFades:Countdown(spellId, nil, icon)
		end
		warnRockBlast:CombinedShow(0.5, args.destName)
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 381253 then
		if args:IsPlayer() then
			specWarnAwakenedEarth:Show()
			specWarnAwakenedEarth:Play("targetyou")
			yellAwakenedEarthFades:Countdown(spellId)
		end
	elseif spellId == 376276 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") then
			specWarnConcussiveSlamTaunt:Show(args.destName)
			specWarnConcussiveSlamTaunt:Play("tauntboss")
		else
			warnConcussiveSlam:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 386352 then
		if self:AntiSpam(3, 1) then
			specWarnBrutalReverberation:Show()
			specWarnBrutalReverberation:Play("watchstep")
		end
		if self.Options.SetIconOnRockBlast then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRockBlastFades:Cancel()
		end
	elseif spellId == 381253 then
		if args:IsPlayer() then
			yellAwakenedEarthFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 382458 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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
