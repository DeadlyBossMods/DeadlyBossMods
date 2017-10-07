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
	"SPELL_CAST_START 248317 257296 255594",
	"SPELL_CAST_SUCCESS 248165 248499",
	"SPELL_AURA_APPLIED 248499",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, is cone of death tank ony? update role defaults
--TODO, get correct spellID for p2 and don't use spell name to broad check all of them
--TODO, death fog GTFO
--TODO, icons or yells or both to help Soulburst and Soulbomb apart and gotten to right place.
--Stage One: Storm and Sky
local warnConeofDeath				= mod:NewSpellAnnounce(248165, 2)
local warnBlightOrb					= mod:NewSpellAnnounce(248317, 2)
local warnSkyandSea					= mod:NewSpellAnnounce(255594, 1)
--Stage Two: The Protector Redeemed
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)

--Stage One: Storm and Sky
local specWarnTorturedRage			= mod:NewSpecialWarningCount(257296, nil, nil, nil, 2, 2)
local specWarnSweepingScythe		= mod:NewSpecialWarningTaunt(248499, nil, nil, nil, 1, 2)
--local yellBurstingDreadflame		= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: The Protector Redeemed

--Stage One: Storm and Sky
local timerSweepingScytheCD			= mod:NewAITimer(25, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerConeofDeathCD			= mod:NewAITimer(20, 248165, nil, nil, nil, 3)--20-30 in february, power based
local timerBlightOrbCD				= mod:NewAITimer(20, 248317, nil, nil, nil, 3)
local timerTorturedRageCD			= mod:NewAITimer(20, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerSkyandSeaCD				= mod:NewAITimer(20, 255594, nil, nil, nil, 5)
--Stage Two: The Protector Redeemed

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Storm and Sky
--local countdownSingularity			= mod:NewCountdown(50, 235059)
--Stage Two: The Protector Redeemed

--Stage One: Storm and Sky
local voiceTorturedRage					= mod:NewVoice(257296)--aesoon
local voiceSweepingScythe				= mod:NewVoice(248499)--tauntboss
--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Stage Two: The Protector Redeemed


--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
mod:AddInfoFrameOption(258040, true)--Change to EJ entry since spell not localized
--mod:AddRangeFrameOption("5/10")

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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248165 then
		warnConeofDeath:Show()
		timerConeofDeathCD:Start()
	elseif spellId == 248499 then
		timerSweepingScytheCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then
		if not args:IsPlayer() then
			specWarnSweepingScythe:Show(args.destName)
			voiceSweepingScythe:Play("tauntboss")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 236378 then

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
	end
end
