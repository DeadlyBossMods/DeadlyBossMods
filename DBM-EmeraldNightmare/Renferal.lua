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
	"SPELL_CAST_START 212707 210948 210547 215288 210308 210326",
	"SPELL_CAST_SUCCESS 210864 215443 218630",
	"SPELL_AURA_APPLIED 212514 210850 215449 218831 218144 218629",
	"SPELL_AURA_APPLIED_DOSE 212512",
	"SPELL_AURA_REMOVED 210850 218144 218629",
	"SPELL_PERIODIC_DAMAGE 213124",
	"SPELL_PERIODIC_MISSED 213124",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--"<8.27 16:55:29> [CLEU] SPELL_AURA_APPLIED##nil#Player-970-00081245#Sharik#215307#Web of Pain#DEBUFF#nil", -- [258]
--"<8.27 16:55:29> [CLEU] SPELL_AURA_APPLIED##nil#Player-970-00015E78#Kabrdr#215300#Web of Pain#DEBUFF#nil", -- [259]
--"<8.27 16:55:29> [CLEU] SPELL_AURA_APPLIED##nil#Player-970-00058E86#Dissconnect#215307#Web of Pain#DEBUFF#nil", -- [260]
--"<8.27 16:55:29> [CLEU] SPELL_AURA_APPLIED##nil#Player-970-000864D0#Ilneval#215300#Web of Pain#DEBUFF#nil", -- [261]
--TODO: Does web of pain actually need to annouce target. It's only cast a single time entire fight
--TODO: Does raking talons need anything?
--TODO: See if debuff scan works to compensate for necrotic venom targetting not showing in combat log. When/if fixed, add range frame and SAY
--TODO, Figure out real razorwing timer, right now it's screwed up because most people avoided boss during roc phase (boss doesn't cast it if no one near by)
--TODO, Shimering Feather (212993) also missing from combat log. Will add tracking for this when blizzard revises fight when/if they fix it. If they don't, UNIT_AURA it is!
--TODO, is violent winds timer.
--TODO, tangled webs warnings/timers?
--Spider Form
local warnSpiderForm				= mod:NewSpellAnnounce(210326, 2)
local warnFeedingTime				= mod:NewSpellAnnounce(212364, 3)
local warnWebWrap					= mod:NewTargetAnnounce(212514, 4)
local warnNecroticVenom				= mod:NewTargetAnnounce(218831, 3)
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
--local specWarnWebOfPain			= mod:NewSpecialWarningDefensive(215288, nil, nil, nil, 1, 2)
--local specWarnWebOfPainOther		= mod:NewSpecialWarningTaunt(215288, nil, nil, nil, 1, 2)
--Roc Form
local specWarnGatheringClouds		= mod:NewSpecialWarningSpell(212707, nil, nil, nil, 1, 2)
local specWarnDarkStorm				= mod:NewSpecialWarningMoveTo(210948, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(210948), nil, 1, 2)
local specWarnTwistingShadows		= mod:NewSpecialWarningMoveAway(210864, nil, nil, nil, 1, 2)
local specWarnTwistingShadowsMove	= mod:NewSpecialWarningMove(210864, nil, nil, nil, 1, 2)--For expires. visual is WAY off from debuff, if you wait for visual you'll die to this
local yellTwistingShadows			= mod:NewFadesYell(210864)
local specWarnRazorWing				= mod:NewSpecialWarningDodge(210547, nil, nil, nil, 3, 2)
----Mythic
local specViolentWinds				= mod:NewSpecialWarningYou(218144, nil, nil, nil, 3, 2)
local specWarnViolentWindsOther		= mod:NewSpecialWarningTaunt(218144, nil, nil, nil, 1, 2)

--Spider Form
mod:AddTimerLine(GetSpellInfo(210326))
local timerSpiderFormCD				= mod:NewNextTimer(70, 210326, nil, nil, nil, 6)
local timerFeedingTimeCD			= mod:NewNextTimer(15.5, 212364, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerNecroticVenomCD			= mod:NewNextTimer(26.5, 215443, nil, nil, nil, 3)--This only targets ranged, but melee/tanks need to be sure to also move away from them
local timerNightmareSpawnCD			= mod:NewNextTimer(10, 218630, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
--Roc Form
mod:AddTimerLine(GetSpellInfo(210308))
local timerRocFormCD				= mod:NewNextTimer(47, 210308, nil, nil, nil, 6)
local timerGatheringCloudsCD		= mod:NewNextTimer(6, 212707, nil, nil, nil, 2)
local timerDarkStormCD				= mod:NewNextTimer(16, 210948, nil, nil, nil, 2)
local timerTwistingShadowsCD		= mod:NewNextCountTimer(21.5, 210864, nil, nil, nil, 3)
local timerRazorWingCD				= mod:NewCDTimer(17, 210547, nil, nil, nil, 3)--Needs more timer data when fight done properly
--local timerViolentWindsCD			= mod:NewAITimer(6, 218144, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON..DBM_CORE_TANK_ICON)

local berserkTimer					= mod:NewBerserkTimer(540)

local countdownPhase				= mod:NewCountdown(30, 155005)
--Spider Form
local countdownNecroticVenom		= mod:NewCountdown("AltTwo26", 215443)
--Roc Form

--Spider Form
local voiceFeedingTime				= mod:NewVoice(212364, "-Healer")--killmob
local voiceNecroticVenom			= mod:NewVoice(218831)--runout
--local voiceWebOfPain				= mod:NewVoice(215288)--defensive/tauntboss
local voiceVenomousPool				= mod:NewVoice(213124)--runaway
--Roc Form
local voiceTwistingShadows			= mod:NewVoice(210864)--runout/runaway
local voiceGatheringClouds			= mod:NewVoice(212707)--aesoon
local voiceDarkStorm				= mod:NewVoice(212707)--findshelter
local voiceRazorWing				= mod:NewVoice(210547)--carefly
local voiceViolentWinds				= mod:NewVoice(218144)--justrun/keepmove/tauntboss

--mod:AddRangeFrameOption("5")--Add range frame to Necrotic Debuff if detecting it actually works with FindDebuff()
mod:AddSetIconOption("SetIconOnWinds", 218144)
--mod:AddHudMapOption("HudMapOnMC", 163472)

mod.vb.twistedCast = 0
local eyeOfStorm = GetSpellInfo(211127)
local scanTime = 0

local function findDebuff(self, spellName)
	scanTime = scanTime + 1
	local found = 0
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, spellName) then
			warnNecroticVenom:CombinedShow(0.2, name)
			if name == UnitName("player") then
				specWarnNecroticVenom:Show()
				voiceNecroticVenom:Play("runout")
				if self:IsMythic() then--Assumed, but if heroic is 10 seconds, one must assume all lesser difficulties also 10 seconds. Leaving ONLY mythic to be 5
					yellNecroticVenom:Yell(5)
					yellNecroticVenom:Schedule(4, 1)
					yellNecroticVenom:Schedule(3, 2)
					yellNecroticVenom:Schedule(2, 3)
				else
					yellNecroticVenom:Yell(10)
					yellNecroticVenom:Schedule(9, 1)
					yellNecroticVenom:Schedule(8, 2)
					yellNecroticVenom:Schedule(7, 3)
				end
			end
		end
	end
	if found == 0 and scanTime < 6 then--Scan for 3 sec, not forever.
		self:Schedule(0.5, findDebuff, spellName)--Check again if we didn't find any yet
	end
end

function mod:OnCombatStart(delay)
	timerFeedingTimeCD:Start(-delay)
	timerNecroticVenomCD:Start(26.5-delay)
	countdownNecroticVenom:Start()
	timerRocFormCD:Start(45-delay)
	countdownPhase:Start(45-delay)
	berserkTimer:Start(-delay)--540 heroic, other difficulties not confirmed
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
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
		specWarnRazorWing:Show()
		voiceRazorWing:Play("carefly")
		timerRazorWingCD:Start()
--[[	elseif spellId == 215288 then
		local targetName, uId, bossuid = self:GetBossTarget(106087, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnWebOfPain:Show()
			voiceWebOfPain:Play("defensive")
		else
			specWarnWebOfPainOther:Schedule(1.4, targetName)
			voiceWebOfPain:Schedule(1.4, "tauntboss")
		end--]]
	elseif spellId == 210326 then--Spider Form
		timerRazorWingCD:Stop()
		warnSpiderForm:Show()
		timerFeedingTimeCD:Start()
		timerNecroticVenomCD:Start()
		countdownNecroticVenom:Start()
		timerRocFormCD:Start()
		countdownPhase:Start(47)
	elseif spellId == 210308 then--Roc Form
		self.vb.twistedCast = 0
		warnRocForm:Show()
		timerGatheringCloudsCD:Start()
		timerDarkStormCD:Start()
		timerTwistingShadowsCD:Start(42, 1)
		timerSpiderFormCD:Start()
		countdownPhase:Start(70)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 210864 then
		self.vb.twistedCast = self.vb.twistedCast + 1
		if self.vb.twistedCast == 1 then--Only cast twice per roc form
			timerTwistingShadowsCD:Start(21.5, 2)
		end
	elseif spellId == 215443 then
		scanTime = 0
		self:Schedule(0.1, findDebuff, self, args.spellName)
	elseif spellId == 218630 then
		warnNightmareSpawn:Show()
		timerNightmareSpawnCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212514 then
		warnWebWrap:Show(args.destName)
	elseif spellId == 210850 then
		warnTwistingShadows:CombinedShow(0.5, self.vb.twistedCast, args.destName)
		if args:IsPlayer() then
			specWarnTwistingShadows:Show()
			voiceTwistingShadows:Play("runout")
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellTwistingShadows:Schedule(remaining-1, 1)
				yellTwistingShadows:Schedule(remaining-2, 2)
				yellTwistingShadows:Schedule(remaining-3, 3)
			end
		end
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
	if spellId == 210850 and args:IsPlayer() then
		specWarnTwistingShadowsMove:Show()--Not a bug, it alerts you when to move to avoid your own tornado
		voiceTwistingShadows:Play("runaway")
		yellTwistingShadows:Cancel()
	elseif spellId == 218144 then
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
		specWarnFeedingTime:Show()
		voiceFeedingTime:Play("killmob")
--	elseif spellId == 218073 then--Venomous Spiderling Summoned Spider Spawn

--	elseif spellId == 215505 then--Summon Skittering Spiderling
		--Likely primary scrip tand best one to use for announce
--	elseif spellId == 215507 then--Summon Skittering Spiderling
		--Spawns actual mob
--	elseif spellId == 215508 then--Summon Skittering Spiderling
		--Trigger missle triggered by 215505
	end
end
