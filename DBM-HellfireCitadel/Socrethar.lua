local mod	= DBM:NewMod(1427, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(92330)
mod:SetEncounterID(1794)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181288 180221 182051 183331 183329 184239 182392",
	"SPELL_CAST_SUCCESS 180008 184124",
	"SPELL_AURA_APPLIED 182038 182769 182900 184124",
	"SPELL_AURA_APPLIED_DOSE 182038",
	"SPELL_AURA_REMOVED 184124",
	"UNIT_DIED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, Prisons had no workable targetting of any kind during test. Study of logs and even videos showed no valid target scanning, debuff, whisper, nothing. As such, only aoe warning :\
--TODO, voice for reverberatingblow removed since it's instant cast and currently a bit wonky/buggy. Needs further review later.
--TODO, currently no way to detect fel orbs detonating, or if there is i don't have it in any of my logs, with no debuff, can't cancel hud for orbs at this time
--Soulbound Construct
local warnReverberatingBlow			= mod:NewCountAnnounce(180008, 3)
local warnFelPrison					= mod:NewTargetAnnounce(181288, 4)
local warnShatteredDefenses			= mod:NewStackAnnounce(182038, 3, nil, "Tank")
local warnVolatileFelOrb			= mod:NewTargetAnnounce(180221, 4)
--Adds
local warnGhastlyFixation			= mod:NewTargetAnnounce(182769, 4, nil, false)--Spammy
local warnVirulentHaunt				= mod:NewTargetAnnounce(182900, 4, nil, false)--Failed at fixate. Also spammy
local warnGiftoftheManari			= mod:NewTargetAnnounce(184124, 4)

--Soulbound Construct
local specWarnReverberatingBlow		= mod:NewSpecialWarningCount(180008, "Tank", nil, nil, 1)
local specWarnFelPrison				= mod:NewSpecialWarningDodge(181288, nil, nil, nil, 2, 2)
local specWarnVolatileFelOrb		= mod:NewSpecialWarningRun(180221, nil, nil, nil, 4, 2)
local yellVolatileFelOrb			= mod:NewYell(180221)
local specWarnFelChargeYou			= mod:NewSpecialWarningYou(182051, nil, nil, nil, 1, 2)
local yellCharge					= mod:NewYell(182051)
local specWarnFelCharge				= mod:NewSpecialWarningTarget(182051, "Melee", nil, nil, 2, 2)--Boss will often go through melee most of time, so they still need generic warning.
--Socrethar
local specWarnExertDominance		= mod:NewSpecialWarningInterrupt(183331, "-Healer", nil, nil, 1, 2)
local specWarnApocalypse			= mod:NewSpecialWarningSpell(183329, nil, nil, nil, 2, 2)
--Adds
local specWarnShadowWordAgony		= mod:NewSpecialWarningInterrupt(184239, false, nil, nil, 1, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(182392, "-Healer", nil, nil, 1, 2)
local specWarnGhastlyFixation		= mod:NewSpecialWarningRun(182769, nil, nil, nil, 4, 2)
local yellGhastlyFixation			= mod:NewYell(182769, nil, false)
local specWarnSargereiDominator		= mod:NewSpecialWarningSwitch("ej11456", "-Healer")
local specWarnGiftoftheManari		= mod:NewSpecialWarningYou(184124, nil, nil, nil, 1, 2)
local yellGiftoftheManari			= mod:NewYell(184124)

--Soulbound Construct
local timerReverberatingBlowCD		= mod:NewCDCountTimer(11, 180008)--11-12
local timerFelPrisonCD				= mod:NewCDTimer(29, 182994)--29-33
local timerVolatileFelOrbCD			= mod:NewNextTimer(23, 180221)
local timerFelChargeCD				= mod:NewNextTimer(23, 182051)
--Socrethar
local timerExertDominanceCD			= mod:NewCDTimer(6, 183331, nil, "-Healer")
local timerApocalypseCD				= mod:NewCDTimer(46, 183329)
--Adds
local timerGiftofManariCD			= mod:NewCDTimer(11, 184124)

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownReverberatingBlow	= mod:NewCountdown(11, 180008, "Tank", nil, 3)--Cast every 11 seconds, so use 3 count, not 5 count. Tank only for now, up to tank to aim boss correct, rest of raid shouldn't need countdown spam

--Construct
local voiceVolatileFelOrb			= mod:NewVoice(180221)--runout/keepmove
local voiceFelblazeCharge			= mod:NewVoice(182051)--runout/chargemove
local voiceFelPrison				= mod:NewVoice(182994)--watchstep
--Socrethar
local voiceExertDominance			= mod:NewVoice(183331, "-Healer")--kickcast
local voiceApocalypse				= mod:NewVoice(183329)--aesoon
--Adds
local voiceShadowWordAgony			= mod:NewVoice(184239, false)--kickcast
local voiceShadowBoltVolley			= mod:NewVoice(182392, "-Healer")--kickcast
local voiceGhastlyFixation			= mod:NewVoice(182769)--runout/keepmove
local voiceGiftoftheManari			= mod:NewVoice(184124)--scatter

mod:AddRangeFrameOption(10, 184124)
--mod:AddHudMapOption("HudMapOnOrb", 180221)--Unusuble until there is a way to cancel it
mod:AddHudMapOption("HudMapOnCharge", 182051)

mod.vb.ReverberatingBlow = 0
mod.vb.ManariTargets = 0

local debuffName = GetSpellInfo(184124)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.ManariTargets > 0 then
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:ChargeTarget(targetname, uId)
	if not targetname then
		specWarnFelCharge:Show(DBM_CORE_UNKNOWN)
		voiceFelblazeCharge:Play("chargemove")
		return
	end
	if targetname == UnitName("player") then
		if self:AntiSpam(2, 2) then
			specWarnFelChargeYou:Show()
			yellCharge:Yell()
			voiceFelblazeCharge:Play("runout")
		end
	else--Generic warning for anyone else. ranged can enable if needed, but melee default for sure
		specWarnFelCharge:Show(targetname)
		voiceFelblazeCharge:Play("chargemove")
	end
	if self.Options.HudMapOnCharge then
		DBMHudMap:RegisterRangeMarkerOnPartyMember(182051, "highlight", targetname, 5, 4, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)
	end
end

function mod:OrbTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		if self:AntiSpam(2, 3) then
			specWarnVolatileFelOrb:Show()
			yellVolatileFelOrb:Yell()
			voiceVolatileFelOrb:Play("runout")
			voiceVolatileFelOrb:Schedule(2, "keepmove")
		end
	else
		warnVolatileFelOrb:Show(targetname)
	end
--	if self.Options.HudMapOnOrb then
--		DBMHudMap:RegisterRangeMarkerOnPartyMember(180221, "highlight", targetname, 5, 20, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
--	end
end

function mod:OnCombatStart(delay)
	self.vb.ReverberatingBlow = 0
	self.vb.ManariTargets = 0
	timerReverberatingBlowCD:Start(7-delay, 1)
	countdownReverberatingBlow:Start(7-delay)
	timerFelPrisonCD:Start(25-delay)
	timerVolatileFelOrbCD:Start(12-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnCharge then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181288 then
		specWarnFelPrison:Show()
		timerFelPrisonCD:Start()
		voiceFelPrison:Play("watchstep")
	elseif spellId == 180221 then
		timerVolatileFelOrbCD:Start()
		--Must have delay, to avoid same bug as oregorger. Boss has many target scans
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "OrbTarget", 0.1, 10, true)
	elseif spellId == 182051 then
		--Must have delay, to avoid same bug as oregorger. Boss has many target scans
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "ChargeTarget", 0.1, 10, true)
	elseif spellId == 183331 then
		timerExertDominanceCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExertDominance:Show(args.sourceName)
			voiceExertDominance:Play("kickcast")
		end
	elseif spellId == 183329 then
		specWarnApocalypse:Show()
		voiceApocalypse:Play("aesoon")
		timerApocalypseCD:Start()
	elseif spellId == 184239 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowWordAgony:Show()
		voiceShadowWordAgony:Play("kickcast")
	elseif spellId == 182392 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show()
		voiceShadowBoltVolley:Play("kickcast")
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180008 then
		self.vb.ReverberatingBlow = self.vb.ReverberatingBlow + 1
		timerReverberatingBlowCD:Start(nil, self.vb.ReverberatingBlow+1)
		countdownReverberatingBlow:Start()
		if self.Options.SpecWarn180008count then
			specWarnReverberatingBlow:Show(self.vb.ReverberatingBlow)
		else
			warnReverberatingBlow:Show(self.vb.ReverberatingBlow)
		end
	elseif spellId == 184124 then
		timerGiftofManariCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182038 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnShatteredDefenses:Show(amount)
			--if amount % 2 == 0 or amount >= 5 then

			--end
		end
	elseif spellId == 182769 then
		warnGhastlyFixation:CombinedShow(2, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnGhastlyFixation:Show()
			yellGhastlyFixation:Yell()
			voiceGhastlyFixation:Play("runout")
			voiceGhastlyFixation:Schedule(2, "keepmove")
		end
	elseif spellId == 182900 then
		warnVirulentHaunt:CombinedShow(0.5, args.destName)
	elseif spellId == 184124 then
		self.vb.ManariTargets = self.vb.ManariTargets + 1
		warnGiftoftheManari:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnGiftoftheManari:Show()
			yellGiftoftheManari:Yell()
			voiceGiftoftheManari:Play("scatter")
		end
		updateRangeFrame(self)
	elseif spellId == 184053 then--Fel Barrior (Boss becomes immune to damage, Sargerei Dominator spawned and must die)
		specWarnSargereiDominator:Show()
		timerGiftofManariCD:Start(12, args.sourceGUID)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 184124 then
		self.vb.ManariTargets = self.vb.ManariTargets - 1
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92767 then--Sargerei Dominator
		timerGiftofManariCD:Cancel(args.destGUID)
	end
end

--backup, in event of target scan fail.
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:180221") then--Orb
		if self:AntiSpam(2, 3) then
			specWarnVolatileFelOrb:Show()
			yellVolatileFelOrb:Yell()
			voiceVolatileFelOrb:Play("runout")
			voiceVolatileFelOrb:Schedule(2, "keepmove")
		end
	elseif msg:find("spell:184247") then--Charge
		if self:AntiSpam(2, 2) then
			specWarnFelChargeYou:Show()
			yellCharge:Yell()
			voiceFelblazeCharge:Play("runout")
		end
	end
end

--"<127.45 18:26:51> [UNIT_SPELLCAST_SUCCEEDED] Soul of Socrethar(??) [[boss2:Soulfire Aura::0:183334]]", -- [4408]
--"<127.46 18:26:51> [UNIT_TARGETABLE_CHANGED] boss2#true#true#true#Soul of Socrethar#Creature-0-2012-1448-1434-92330-000042AB3A#elite#111036000", -- [4411]
--"<127.52 18:26:51> [UNIT_SPELLCAST_SUCCEEDED] Soulbound Construct(Grafarion) [[boss1:Construct is Good::0:180258]]", -- [4414]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 183334 then--Soulfire Aura. begin Socrethar phase
		timerReverberatingBlowCD:Cancel()
		countdownReverberatingBlow:Cancel()
		timerFelPrisonCD:Cancel()
		timerVolatileFelOrbCD:Cancel()
		timerFelChargeCD:Cancel()
		timerApocalypseCD:Start()--46-47. Small sample size (2 pulls)
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	end
end

function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if (cid == 92330) and not UnitExists(uId) then--Socrethar returning inactive and construct phase beginning again.
		timerExertDominanceCD:Cancel()
		self:UnregisterShortTermEvents()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
