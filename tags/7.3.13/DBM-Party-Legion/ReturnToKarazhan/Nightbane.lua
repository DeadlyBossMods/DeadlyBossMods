local mod	= DBM:NewMod("Nightbane", "DBM-Party-Legion", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114895)
mod:SetEncounterID(2031)
mod:SetZone()
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(15430)
mod.respawnTime = 25

mod.onlyMythic = true--VERIFY how they actually do this

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 228839 228837 228785 229307",
	"SPELL_CAST_SUCCESS 228796 228829",
	"SPELL_AURA_APPLIED 228796",
	"SPELL_AURA_REMOVED 228796",
	"SPELL_PERIODIC_DAMAGE 228808",
	"SPELL_PERIODIC_MISSED 228808",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Infernal Power http://www.wowhead.com/spell=228792/infernal-power
--TODO, Absorb Vitality? http://www.wowhead.com/spell=228835/absorb-vitality
--TODO, tweak breath warning?
local warnIgniteSoul				= mod:NewTargetAnnounce(228796, 4)
local warnBreath					= mod:NewSpellAnnounce(228785, 3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)

local specWarnReverbShadows			= mod:NewSpecialWarningInterruptCount(229307, "HasInterrupt", nil, nil, 1, 3)
local specWarnCharredEarth			= mod:NewSpecialWarningMove(228808, nil, nil, nil, 1, 2)
local specWarnIgniteSoul			= mod:NewSpecialWarningMoveTo(228796, nil, nil, nil, 3, 2)
local yellIgniteSoul				= mod:NewFadesYell(228796)
local specWarnFear					= mod:NewSpecialWarningSpell(228837, nil, nil, nil, 2, 2)

local timerReverbShadowsCD			= mod:NewCDTimer(12, 229307, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--12-16
local timerBreathCD					= mod:NewCDTimer(23, 228785, nil, "Tank", nil, 5)--23-35
local timerCharredEarthCD			= mod:NewCDTimer(20, 228806, nil, nil, nil, 3)--20-25
local timerBurningBonesCD			= mod:NewCDTimer(18.3, 228829, nil, nil, nil, 3)--20-25
local timerIgniteSoulCD				= mod:NewCDTimer(25, 228796, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

local timerFearCD					= mod:NewCDTimer(43, 228837, nil, nil, nil, 2)--43-46

--local berserkTimer				= mod:NewBerserkTimer(300)

local countdownIngiteSoul			= mod:NewCountdownFades("AltTwo9", 228796)

local voiceReverbShadows			= mod:NewVoice(229307, "HasInterrupt")--kickcast
local voiceCharredEarth				= mod:NewVoice(228808)--runaway
local voiceIgniteSoul				= mod:NewVoice(228796)--targetyou (maybe something better?)

local voiceFear						= mod:NewVoice(228837)--fearsoon

mod:AddSetIconOption("SetIconOnIgnite", 228796, true)
mod:AddInfoFrameOption(228829, true)

mod.vb.phase = 1
mod.vb.interruptCount = 0

local charredEarth = GetSpellInfo(228808)

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.interruptCount = 0
	timerBreathCD:Start(8.5-delay)
	timerCharredEarthCD:Start(15-delay)
	timerReverbShadowsCD:Start(17-delay)
	timerBurningBonesCD:Start(19.4-delay)
	timerIgniteSoulCD:Start(20-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(228829))
		DBM.InfoFrame:Show(5, "playerdebuffstacks", 228829)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 228839 then--Phase 2 (can be detected earlier with yell, but this is better than localizing)
		self.vb.phase = 2
		warnPhase2:Show()
		timerIgniteSoulCD:Stop()
		timerBurningBonesCD:Stop()
		timerCharredEarthCD:Stop()
		timerReverbShadowsCD:Stop()
		timerBreathCD:Stop()
	elseif spellId == 228837 then
		specWarnFear:Show()
		voiceFear:Play("fearsoon")
		timerFearCD:Start()
	elseif spellId == 228785 then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif spellId == 229307 then
		self.vb.interruptCount = self.vb.interruptCount + 1
		timerReverbShadowsCD:Start()
		specWarnReverbShadows:Show(args.sourceName, self.vb.interruptCount)
		if self.vb.interruptCount == 1 then
			voiceReverbShadows:Play("kick1r")
		elseif self.vb.interruptCount == 2 then
			voiceReverbShadows:Play("kick2r")
			self.vb.interruptCount = 0
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 228796 then
		timerIgniteSoulCD:Start()
	elseif spellId == 228829 then
		timerBurningBonesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228796 then
		countdownIngiteSoul:Start()
		if args:IsPlayer() then
			specWarnIgniteSoul:Show(charredEarth)
			voiceIgniteSoul:Play("targetyou")
			--Yes a 5 count (not typical 3). This debuff is pretty much EVERYTHING
			yellIgniteSoul:Schedule(1, 8)
			yellIgniteSoul:Schedule(2, 7)
			yellIgniteSoul:Schedule(3, 6)
			yellIgniteSoul:Schedule(4, 5)
			yellIgniteSoul:Schedule(5, 4)
		else
			warnIgniteSoul:Show(args.destName)
		end
		if self.Options.SetIconOnIgnite then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 228796 then
		if args:IsPlayer() then
			yellIgniteSoul:Cancel()
		end
		countdownIngiteSoul:Cancel()
		if self.Options.SetIconOnIgnite then
			self:SetIcon(args.destName, 0)
		end
	end
end

do
	local filteredDebuff = GetSpellInfo(228796)--Don't tell you to move out of charred earth if you are losing health on purpose
	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 228808 and destGUID == UnitGUID("player") and not UnitDebuff("player", filteredDebuff) and self:AntiSpam(2, 1) then
			specWarnCharredEarth:Show()
			voiceCharredEarth:Play("runaway")
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114903 then--Bonecurse
		self.vb.phase = 3
		self.vb.interruptCount = 0
		warnPhase3:Show()
		timerBreathCD:Start(12)
		timerFearCD:Start(20)
		timerCharredEarthCD:Start(23)
		timerIgniteSoulCD:Start(24)
		timerBurningBonesCD:Start(25)
		timerReverbShadowsCD:Start(30)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 228806 then--Charred Earth pre cast
		timerCharredEarthCD:Start()
	end
end
