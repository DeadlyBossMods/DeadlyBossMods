local mod	= DBM:NewMod(2031, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(125111)--or 124828
mod:SetEncounterID(2092)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 248317 257296 255594 252280 257645",
	"SPELL_CAST_SUCCESS 248165 248499 251815",
	"SPELL_AURA_APPLIED 248499 248396 250669 251570 255199",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 250669 251570 255199",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, is cone of death tank ony? update role defaults
--TODO, get correct spellID for p2 and don't use spell name to broad check all of them
--TODO, death fog GTFO
--TODO, icons or yells or both to help Soulburst and Soulbomb apart and gotten to right place.
--TODO, see if boss energy resets on stage change, if not, update timers for new 100 power ability on stage changes
--TODO, custom warning to combine soulburst and bomb into single message instead of two messages, while still separating targets
--Stage One: Storm and Sky
local warnConeofDeath				= mod:NewSpellAnnounce(248165, 2)
local warnBlightOrb					= mod:NewSpellAnnounce(248317, 2)
local warnWastingPlague				= mod:NewTargetAnnounce(248396, 1)
local warnSkyandSea					= mod:NewSpellAnnounce(255594, 1)
--Stage Two: The Protector Redeemed
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnSoulburst					= mod:NewTargetAnnounce(250669, 2)
local warnSoulbomb					= mod:NewTargetAnnounce(251570, 3)
local warnAvatarofAggra				= mod:NewTargetAnnounce(255199, 1)
--Stage Three: The Arcane Masters
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)

--Stage One: Storm and Sky
local specWarnTorturedRage			= mod:NewSpecialWarningCount(257296, nil, nil, nil, 2, 2)
local specWarnSweepingScythe		= mod:NewSpecialWarningTaunt(248499, nil, nil, nil, 1, 2)
local specWarnWastingPlague			= mod:NewSpecialWarningMoveAway(248396, nil, nil, nil, 1, 2)
local yellWastingPlague				= mod:NewYell(248396)
--local yellBurstingDreadflame		= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: The Protector Redeemed
local specWarnSoulburst				= mod:NewSpecialWarningMoveAway(250669, nil, nil, nil, 1, 2)
local yellSoulburst					= mod:NewYell(250669)
local yellSoulburstFades			= mod:NewFadesYell(250669)
local specWarnSoulbomb				= mod:NewSpecialWarningMoveTo(251570, nil, nil, nil, 1, 8)
local yellSoulbomb					= mod:NewYell(251570)
local yellSoulbombFades				= mod:NewFadesYell(251570)
local specWarnEdgeofObliteration	= mod:NewSpecialWarningSpell(251815, nil, nil, nil, 2, 2)
local specWarnAvatarofAggra			= mod:NewSpecialWarningYou(255199, nil, nil, nil, 1, 2)
--Stage Three: The Arcane Masters

--Stage One: Storm and Sky
local timerSweepingScytheCD			= mod:NewAITimer(25, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerConeofDeathCD			= mod:NewAITimer(20, 248165, nil, nil, nil, 3)--20-30 in february, power based
local timerBlightOrbCD				= mod:NewAITimer(20, 248317, nil, nil, nil, 3)
local timerTorturedRageCD			= mod:NewAITimer(20, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerSkyandSeaCD				= mod:NewAITimer(20, 255594, nil, nil, nil, 5)
--Stage Two: The Protector Redeemed
local timerVolatileSoulCD			= mod:NewAITimer(20, 252280, nil, nil, nil, 3)
local timerEdgeofObliterationCD		= mod:NewAITimer(20, 251815, nil, nil, nil, 2)
local timerAvatarofAggraCD			= mod:NewAITimer(20, 255199, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage Three: The Arcane Masters

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Storm and Sky
--local countdownSingularity			= mod:NewCountdown(50, 235059)
--Stage Two: The Protector Redeemed

--Stage One: Storm and Sky
local voiceTorturedRage					= mod:NewVoice(257296)--aesoon
local voiceSweepingScythe				= mod:NewVoice(248499)--tauntboss
local voiceWastingPlague				= mod:NewVoice(248396)--runout
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Stage Two: The Protector Redeemed
local voiceSoulburst					= mod:NewVoice(250669)--targetyou/runout (on delay)
local voiceSoulbomb						= mod:NewVoice(251570)--targetyou/runtotank (on delay)
local voiceEdgeofObliteration			= mod:NewVoice(251815)--watchwave?
local voiceAvatarofAgrra				= mod:NewVoice(255199)--targetyou
--Stage Three: The Arcane Masters


mod:AddSetIconOption("SetIconOnAvatar", 255199, true)
mod:AddInfoFrameOption(258040, true)--Change to EJ entry since spell not localized
--mod:AddRangeFrameOption("5/10")

local avatarOfAggramar, aggramarsBoon = GetSpellInfo(255199), GetSpellInfo(255200)
mod.vb.phase = 1
mod.vb.TorturedRage = 0

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

local function delayedBoonCheck(self)
	if not UnitBuff("player", aggramarsBoon) then
		specWarnSoulbomb:Show(avatarOfAggramar)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.TorturedRage = 0
	timerConeofDeathCD:Start(1-delay)--was 10 in february
	timerBlightOrbCD:Start(1-delay)
	timerTorturedRageCD:Start(1-delay)
	timerSweepingScytheCD:Start(1-delay)
	timerSkyandSeaCD:Start(1-delay)
	if self.Options.InfoFrame then
		--DBM.InfoFrame:SetHeader(7.3_ARGUS_RAID_DEATH_TITAN_ENERGY)--Validator won't accept this global so disabled for now
		DBM.InfoFrame:Show(2, "enemypower", 2)
		--DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	local wowTOC, testBuild = DBM:GetTOC()
	if not testBuild then
		DBM:AddMsg(DBM_CORE_NEED_LOGS)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	local wowTOC, testBuild = DBM:GetTOC()
	if not testBuild then
		DBM:AddMsg(DBM_CORE_NEED_LOGS)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 248317 then
		warnBlightOrb:Show()
		timerBlightOrbCD:Start()
	elseif spellId == 257296 then
		self.vb.TorturedRage = self.vb.TorturedRage + 1
		specWarnTorturedRage:Show(self.vb.TorturedRage)
		voiceTorturedRage:Play("aesoon")
		timerTorturedRageCD:Start()
	elseif spellId == 255594 then
		warnSkyandSea:Show()
		timerSkyandSeaCD:Start()
	elseif spellId == 252280 then
		timerVolatileSoulCD:Start()
	elseif spellId == 257645 then--Temporal Blast (Stage 3)
		self.vb.phase = 3
		warnPhase3:Show()
		timerSweepingScytheCD:Stop()
		timerTorturedRageCD:Stop()
		timerVolatileSoulCD:Stop()
		timerEdgeofObliterationCD:Stop()
		timerAvatarofAggraCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248165 then
		warnConeofDeath:Show()
		timerConeofDeathCD:Start()
	elseif spellId == 248499 then
		timerSweepingScytheCD:Start()
	elseif spellId == 251815 then
		specWarnEdgeofObliteration:Show()
		voiceEdgeofObliteration:Play("watchwave")
		timerEdgeofObliterationCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then
		if not args:IsPlayer() then
			specWarnSweepingScythe:Show(args.destName)
			voiceSweepingScythe:Play("tauntboss")
		end
	elseif spellId == 248396 then
		warnWastingPlague:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnWastingPlague:Show()
			voiceWastingPlague:Play("runout")
			yellWastingPlague:Yell()
		end
	elseif spellId == 250669 then
		warnSoulburst:CombinedShow(0.3, args.destName)--2 Targets
		if args:IsPlayer() then
			specWarnSoulburst:Show()
			voiceSoulburst:Play("targetyou")
			voiceSoulburst:Schedule(10, "runout")
			yellSoulburst:Yell()
			yellSoulburstFades:Countdown(15)
		end
	elseif spellId == 251570 then
		if args:IsPlayer() then
			specWarnSoulbomb:Show(avatarOfAggramar)
			voiceSoulburst:Play("targetyou")
			voiceSoulburst:Schedule(10, "runout")
			self:Schedule(10, delayedBoonCheck, self)
			yellSoulbomb:Yell()
			yellSoulbombFades:Countdown(15)
		else
			warnSoulbomb:Show(args.destName)
		end
	elseif spellId == 255199 then
		if args:IsPlayer() then
			specWarnAvatarofAggra:Show()
			voiceAvatarofAgrra:Play("targetyou")
		else
			warnAvatarofAggra:Show(args.destName)
		end
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 1)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250669 then
		if args:IsPlayer() then
			yellSoulburstFades:Cancel()
			voiceSoulburst:Cancel()
		end
	elseif spellId == 251570 then
		if args:IsPlayer() then
			voiceSoulburst:Cancel()
			yellSoulbombFades:Cancel()
		end
	elseif spellId == 255199 then
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellName == GetSpellInfo(255683) and self.vb.phase < 2 then--Golganneth's Wrath
		self.vb.phase = 2
		warnPhase2:Show()
		timerConeofDeathCD:Stop()
		timerBlightOrbCD:Stop()
		timerTorturedRageCD:Stop()
		timerSweepingScytheCD:Stop()
		timerSkyandSeaCD:Stop()
		timerSweepingScytheCD:Start(2)
		timerTorturedRageCD:Start(2)
		timerVolatileSoulCD:Start(2)
		timerEdgeofObliterationCD:Start(2)
		timerAvatarofAggraCD:Start(2)
	end
end
