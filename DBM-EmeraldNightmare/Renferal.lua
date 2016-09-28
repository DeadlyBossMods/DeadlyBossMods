local mod	= DBM:NewMod(1744, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106087)
mod:SetEncounterID(1876)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212707 210948 210547 215288 210308 210326 215582",
	"SPELL_CAST_SUCCESS 210864 215443 218630",
	"SPELL_AURA_APPLIED 212514 215449 218831 218144 218629 215582 215307 215300",
	"SPELL_AURA_APPLIED_DOSE 212512 215582",
	"SPELL_AURA_REMOVED 218144 218629",
	"SPELL_PERIODIC_DAMAGE 213124",
	"SPELL_PERIODIC_MISSED 213124",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Shimering Feather (212993) also missing from combat log. Will add tracking for this when blizzard revises fight when/if they fix it. If they don't, UNIT_AURA it is!
--TODO, tangled webs warnings/timers if I can find any way to detect it, right now i can't.
--Spider Form
local warnSpiderForm				= mod:NewSpellAnnounce(210326, 2)
local warnFeedingTime				= mod:NewSpellAnnounce(212364, 3)
local warnWebWrap					= mod:NewTargetAnnounce(212514, 4)
local warnNecroticVenom				= mod:NewTargetAnnounce(218831, 3)
local warnWebOfPain					= mod:NewTargetAnnounce(215307, 2)
----Mythic
local warnNightmareSpawn			= mod:NewSpellAnnounce(218630, 3)
--Roc Form
local warnRocForm					= mod:NewSpellAnnounce(210308, 2)
local warnTwistingShadows			= mod:NewTargetCountAnnounce(210864, 3)
----Mythic
local warnViolentWinds				= mod:NewTargetAnnounce(218144, 4)

--Spider Form
local specWarnFeedingTime			= mod:NewSpecialWarningSwitch(212364, "-Healer", nil, nil, 1, 2)
local specWarnVenomousPool			= mod:NewSpecialWarningMove(213124, nil, nil, nil, 1, 2)
local specWarnWebWrap				= mod:NewSpecialWarningStack(212512, nil, 5)
local specWarnNecroticVenom			= mod:NewSpecialWarningMoveAway(218831, nil, nil, nil, 1, 2)
local yellNecroticVenom				= mod:NewFadesYell(218831)
local yellViolentWinds				= mod:NewYell(218144)
local specWarnWebofPain				= mod:NewSpecialWarningYou(215307)
--Roc Form
local specWarnGatheringClouds		= mod:NewSpecialWarningSpell(212707, nil, nil, nil, 1, 2)
local specWarnDarkStorm				= mod:NewSpecialWarningMoveTo(210948, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(210948), nil, 1, 2)
local specWarnTwistingShadows		= mod:NewSpecialWarningMoveAway(210864, nil, nil, nil, 1, 2)
local specWarnTwistingShadowsMove	= mod:NewSpecialWarningMove(210864, nil, nil, nil, 1, 2)--For expires. visual is WAY off from debuff, if you wait for visual you'll die to this
local yellTwistingShadows			= mod:NewFadesYell(210864)
local specWarnRazorWing				= mod:NewSpecialWarningDodge(210547, nil, nil, nil, 3, 2)
local specWarnRakingTalon			= mod:NewSpecialWarningDefensive(215582, nil, nil, nil, 1, 2)
local specWarnRakingTalonOther		= mod:NewSpecialWarningTaunt(215582, nil, nil, nil, 1, 2)
----Mythic
local specViolentWinds				= mod:NewSpecialWarningYou(218144, nil, nil, nil, 3, 2)
local specWarnViolentWindsOther		= mod:NewSpecialWarningTaunt(218144, nil, nil, nil, 1, 2)

--Spider Form
mod:AddTimerLine(GetSpellInfo(210326))
local timerSpiderFormCD				= mod:NewNextTimer(132, 210326, nil, nil, nil, 6)
local timerFeedingTimeCD			= mod:NewNextCountTimer(50, 212364, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerNecroticVenomCD			= mod:NewNextCountTimer(21.8, 215443, nil, nil, nil, 3)--This only targets ranged, but melee/tanks need to be sure to also move away from them
local timerNightmareSpawnCD			= mod:NewNextTimer(10, 218630, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
--Roc Form
mod:AddTimerLine(GetSpellInfo(210308))
local timerRocFormCD				= mod:NewNextTimer(47, 210308, nil, nil, nil, 6)
local timerGatheringCloudsCD		= mod:NewNextTimer(15.8, 212707, nil, nil, nil, 2)
local timerDarkStormCD				= mod:NewNextTimer(26, 210948, nil, nil, nil, 2)
local timerTwistingShadowsCD		= mod:NewNextCountTimer(21.5, 210864, nil, nil, nil, 3)
local timerRazorWingCD				= mod:NewNextTimer(32.5, 210547, nil, nil, nil, 3)--Needs more timer data when fight done properly
local timerRakingTalonsCD			= mod:NewCDCountTimer(32, 215582, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerViolentWindsCD			= mod:NewAITimer(6, 218144, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON..DBM_CORE_TANK_ICON)

local berserkTimer					= mod:NewBerserkTimer(540)

local countdownPhase				= mod:NewCountdown(30, 155005)
--Spider Form
local countdownNecroticVenom		= mod:NewCountdown("AltTwo21", 215443)
--Roc Form

--Spider Form
local voiceFeedingTime				= mod:NewVoice(212364, "-Healer")--killmob
local voiceNecroticVenom			= mod:NewVoice(218831)--runout
local voiceVenomousPool				= mod:NewVoice(213124)--runaway
--Roc Form
local voiceTwistingShadows			= mod:NewVoice(210864)--runout/runaway
local voiceGatheringClouds			= mod:NewVoice(212707)--aesoon
local voiceDarkStorm				= mod:NewVoice(212707)--findshelter
local voiceRazorWing				= mod:NewVoice(210547)--carefly
local voiceViolentWinds				= mod:NewVoice(218144)--justrun/keepmove/tauntboss
local voiceRakingTalon				= mod:NewVoice(215582)--defensive/tauntboss

--mod:AddRangeFrameOption("5")--Add range frame to Necrotic Debuff if detecting it actually works with FindDebuff()
mod:AddSetIconOption("SetIconOnWinds", 218144)

mod.vb.feedingTimeCast = 0
mod.vb.venomCast = 0
mod.vb.twistedCast = 0
mod.vb.talonsCast = 0
mod.vb.razorWingCast = 0
local eyeOfStorm = GetSpellInfo(211127)
local scanTime = 0

local function findDebuff(self, spellName, spellId)
	scanTime = scanTime + 1
	local found = 0
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, spellName) then
			found = found + 1
			if spellId == 210864 then
				warnTwistingShadows:CombinedShow(0.1, self.vb.twistedCast, name)
				if name == UnitName("player") then
					specWarnTwistingShadows:Show()
					voiceTwistingShadows:Play("runout")
					local _, _, _, _, _, _, expires = UnitDebuff("Player", spellName)
					local debuffTime = expires - GetTime()
					if debuffTime then
						yellTwistingShadows:Schedule(debuffTime-1, 1)
						yellTwistingShadows:Schedule(debuffTime-2, 2)
						yellTwistingShadows:Schedule(debuffTime-3, 3)
					end
				end
			else
				warnNecroticVenom:CombinedShow(0.1, name)
				if name == UnitName("player") then
					specWarnNecroticVenom:Show()
					voiceNecroticVenom:Play("runout")
					local _, _, _, _, _, _, expires = UnitDebuff("Player", spellName)
					local debuffTime = expires - GetTime()
					if debuffTime then
						yellNecroticVenom:Schedule(debuffTime - 1, 1)
						yellNecroticVenom:Schedule(debuffTime - 2, 2)
						yellNecroticVenom:Schedule(debuffTime - 3, 3)
					end
				end
			end
		end
	end
	if found == 0 and scanTime < 6 then--Scan for 1.8 sec, not forever.
		self:Schedule(0.3, findDebuff, self, spellName, spellId)
	end
end

function mod:OnCombatStart(delay)
	self.vb.venomCast = 0
	self.vb.feedingTimeCast = 0
	timerNecroticVenomCD:Start(12.2-delay, 1)
	countdownNecroticVenom:Start(12.2)
	timerFeedingTimeCD:Start(15.5-delay, 1)
	timerRocFormCD:Start(90-delay)--Some variation expected. I've seen 90-92. Always happens with energy based bosses
	countdownPhase:Start(90-delay)
	berserkTimer:Start(-delay)--540 heroic, other difficulties not confirmed
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212707 then
		specWarnGatheringClouds:Show()
		voiceGatheringClouds:Play("aesoon")
	elseif spellId == 210948 then
		specWarnDarkStorm:Show(eyeOfStorm)
		voiceDarkStorm:Play("findshelter")
	elseif spellId == 210547 then
		self.vb.razorWingCast = self.vb.razorWingCast + 1
		specWarnRazorWing:Show()
		voiceRazorWing:Play("carefly")
		if self.vb.razorWingCast < 3 then
			timerRazorWingCD:Start(nil, self.vb.razorWingCast+1)
		end
	elseif spellId == 215582 then
		self.vb.talonsCast = self.vb.talonsCast + 1
		local targetName, uId, bossuid = self:GetBossTarget(106087, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnRakingTalon:Show()
			voiceRakingTalon:Play("defensive")
		end
		if self.vb.talonsCast < 3 then
			timerRakingTalonsCD:Start(nil, self.vb.talonsCast+1)
		end
	elseif spellId == 210326 then--Spider Form
		DBM:Debug("CLEU: Spider Form Cast")
	elseif spellId == 210308 then--Roc Form
		DBM:Debug("CLEU: Roc Form Cast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 210864 then
		self.vb.twistedCast = self.vb.twistedCast + 1
		--Only cast 4x per roc form (used to be 3, but roc form is 127 seconds now, up from like 97)
		if self.vb.twistedCast == 1 then
			timerTwistingShadowsCD:Start(40, 2)
		elseif self.vb.twistedCast == 2 then
			timerTwistingShadowsCD:Start(21.5, 3)
		elseif self.vb.twistedCast == 3 then
			timerTwistingShadowsCD:Start(32.5, 4)
		end
		self:Schedule(0.75, findDebuff, self, args.spellName, spellId)
	elseif spellId == 215443 then
		scanTime = 0
		self.vb.venomCast = self.vb.venomCast + 1
		self:Schedule(0.75, findDebuff, self, args.spellName, spellId)
		if self.vb.venomCast < 4 then--Cast 4x per spider form
			timerNecroticVenomCD:Start(nil, self.vb.venomCast+1)
		end
	elseif spellId == 218630 then
		warnNightmareSpawn:Show()
		timerNightmareSpawnCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212514 then
		warnWebWrap:Show(args.destName)
	elseif spellId == 215449 or spellId == 218831 then
		DBM:AddMsg("If you see this message, it means targetting debuffs for Necrotic Venom were added to combat log. Report this to DBM authors to help improve mods")
	elseif spellId == 218144 then
		if args:IsPlayer() then
			specViolentWinds:Show()
			voiceViolentWinds:Play("justrun")
			voiceViolentWinds:Schedule(1, "keepmove")
			yellViolentWinds:Yell()
		elseif self.Options.SpecWarn218144taunt then
			specWarnViolentWindsOther:Show(args.destName)
			voiceViolentWinds:Play("tauntboss")
		else
			warnViolentWinds:Show(args.destName)
		end
		if self.Options.SetIconOnWinds then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 215582 then
		if not args:IsPlayer() then--Player is not current target
			specWarnRakingTalonOther:Show(args.destName)
			voiceRakingTalon:Play("tauntboss")
		end
	elseif spellId == 215307 or spellId == 215300 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if not self:IsTanking(uId) then
			warnWebOfPain:CombinedShow(0.3, args.destName)
			if args:IsPlayer() then
				specWarnWebofPain:Show()
			end
		end
	elseif spellId == 218629 then--Plausable nightmare spawn enable
		
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 212512 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 5 then
			specWarnWebWrap:Show(amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 218144 then
		if self.Options.SetIconOnWinds then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 218629 then
		timerNightmareSpawnCD:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 213124 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnVenomousPool:Show()
		voiceVenomousPool:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 212364 then--Feeding Time
		self.vb.feedingTimeCast = self.vb.feedingTimeCast + 1
		specWarnFeedingTime:Show(self.vb.feedingTimeCast)
		voiceFeedingTime:Play("killmob")
		if self.vb.feedingTimeCast < 2 then
			timerFeedingTimeCD:Start(nil, 2)
		end
	elseif spellId == 226039 then--Bird Transform
		DBM:Debug("Bird Transform Cast")
		self.vb.twistedCast = 0
		self.vb.talonsCast = 0
		self.vb.razorWingCast = 0
		warnRocForm:Show()
		timerTwistingShadowsCD:Start(7, 1)
		timerGatheringCloudsCD:Start()--15.8-16
		timerDarkStormCD:Start()--26
		timerRakingTalonsCD:Start(52, 1)
		timerRazorWingCD:Start(59, 1)
		timerSpiderFormCD:Start()
		countdownPhase:Start(132)--132-135 (used to be 127, so keep an eye on it)
	elseif spellId == 226055 then--Spider Transform
		DBM:Debug("Spider Transform Cast")
		self.vb.venomCast = 0
		self.vb.feedingTimeCast = 0
		timerRazorWingCD:Stop()
		warnSpiderForm:Show()
		timerNecroticVenomCD:Start(12.2, 1)
		countdownNecroticVenom:Start(12.2)
		timerFeedingTimeCD:Start(15.5, 1)
		timerRocFormCD:Start(92)
		countdownPhase:Start(92)
	end
end
