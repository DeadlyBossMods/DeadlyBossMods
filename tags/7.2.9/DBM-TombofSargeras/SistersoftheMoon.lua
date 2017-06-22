local mod	= DBM:NewMod(1903, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118523, 118374, 118518)--118523 Huntress kasparian, 118374 Captain Yathae Moonstrike, 118518 Prestess Lunaspyre
mod:SetEncounterID(2050)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(16282)
mod.respawnTime = 14

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 236694 236442 236712",
	"SPELL_CAST_SUCCESS 236480 236547 236518 233263 237561 236672 239264",
	"SPELL_AURA_APPLIED 234995 234996 236550 236596 233264 233263 236712 239264 236519 237561 236305",
	"SPELL_AURA_APPLIED_DOSE 234995 234996 239264",
	"SPELL_AURA_REMOVED 236712 233263 233264",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, figure out which of the MANY scripts are for glaive storm
--TODO, figure out how to actually pre warn moon glaive and give it a warning.
--TODO, is there even a point to Shadow shot?
--TODO, fine tune all option defaults once what targets or doesn't target x and y is known. Fight can't have too much timer/warning spam
--TODO, announce lunar strike? more redundancy in encounter that isn't needed IMO
--TODO, video fight and improve timer interactions to better deal with huge variation in stuff like moon glaive timer.
--TODO, both 54 timers were 58 on mythic, see if that's new consistency
--[[
(ability.id = 236694 or ability.id = 236442 or ability.id = 239379 or ability.id = 236712) and type = "begincast" or
(ability.id = 236480 or ability.id = 237561 or ability.id = 236547 or ability.id = 236518 or ability.id = 233263 or ability.id = 239264 or ability.id = 236672) and type = "cast" or
(ability.id = 236305) and type = "applydebuff"
--]]
--Huntress Kasparian
--local warnTwilightGlaive			= mod:NewTargetAnnounce(237561, 3)
--Captain Yathae Moonstrike
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnIncorporealShot			= mod:NewTargetAnnounce(236305, 3)
local warnRapidShot					= mod:NewTargetAnnounce(236596, 3)
--Priestess Lunaspyre
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnLunarBeacon				= mod:NewTargetAnnounce(236712, 3)
local warnLunarFire					= mod:NewStackAnnounce(239264, 2, nil, "Tank")
local warnMoonBurn					= mod:NewTargetAnnounce(236519, 3)

--All
local specWarnFontofElune			= mod:NewSpecialWarningStack(236357, nil, 12, nil, 2, 1, 6)--Stack unknown
--Huntress Kasparian
local specWarnGlaiveStorm			= mod:NewSpecialWarningDodge(236480, nil, nil, nil, 2, 2)
local specWarnTwilightGlaiveOther	= mod:NewSpecialWarningTarget(237561, nil, nil, nil, 2, 2)
local specWarnTwilightGlaive		= mod:NewSpecialWarningMoveAway(237561, nil, nil, nil, 2, 2)
local yellTwilightGlaive			= mod:NewYell(237561)
local specWarnDiscorporate			= mod:NewSpecialWarningMoveTo(236550, nil, nil, nil, 1, 7)
local specWarnDiscorporateSwap		= mod:NewSpecialWarningTaunt(236550, nil, nil, nil, 1, 2)
--Captain Yathae Moonstrike
local specWarnCallMoontalon			= mod:NewSpecialWarningSwitch(236694, "-Healer", nil, nil, 1, 2)
local specWarnTwilightVolley		= mod:NewSpecialWarningDodge(236442, nil, nil, nil, 2, 2)
local yellTwilightVolley			= mod:NewYell(236442)
local specWarnIncorpShot			= mod:NewSpecialWarningMoveAway(236305, nil, nil, nil, 1, 2)
local yellIncorpShot				= mod:NewYell(236305)
local specWarnRapidShot				= mod:NewSpecialWarningMoveAway(236596, nil, nil, nil, 1, 2)
local yellRapidShot					= mod:NewYell(236596)
--Priestess Lunaspyre
local specWarnEmbraceofEclipse		= mod:NewSpecialWarningTarget(233264, "Dps|Healer", nil, nil, 3, 2)
local specWarnLunarBeacon			= mod:NewSpecialWarningMoveAway(236712, nil, nil, nil, 1, 2)
local yellLunarBeacon				= mod:NewFadesYell(236712)
local specWarnLunarFire				= mod:NewSpecialWarningStack(239264, nil, 4, nil, nil, 1, 2)
local specWarnLunarFireOther		= mod:NewSpecialWarningTaunt(239264, nil, nil, nil, 1, 2)
local specWarnMoonBurn				= mod:NewSpecialWarningMoveTo(236519, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(236519), nil, 1, 7)--Add voice filter when it has a voice

--Huntress Kasparian
local timerGlaiveStormCD			= mod:NewAITimer(31, 236480, nil, nil, nil, 3)
local timerTwilightGlaiveCD			= mod:NewCDTimer(31, 237561, nil, nil, nil, 3)
local timerMoonGlaiveCD				= mod:NewCDTimer(13.4, 236547, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--13.4-30 second variation, have fun with that
--Captain Yathae Moonstrike
local timerIncorporealShotCD		= mod:NewCDTimer(54.7, 236305, nil, nil, nil, 3)
local timerCallMoontalonCD			= mod:NewCDTimer(31, 236694, nil, nil, nil, 1)
local timerTwilightVolleyCD			= mod:NewCDTimer(15.8, 236442, nil, nil, nil, 2)--Cast while inactive.
local timerRapidShotCD				= mod:NewCDTimer(18.2, 236596, nil, nil, nil, 3)--18.2 but sometimes 30
--Priestess Lunaspyre
local timerEmbraceofEclipseCD		= mod:NewCDTimer(54.3, 233264, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DAMAGE_ICON)--Used while inactive
local timerLunarBeaconCD			= mod:NewAITimer(31, 236712, nil, nil, nil, 3)
local timerLunarFireCD				= mod:NewCDTimer(11, 239264, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerMoonBurnCD				= mod:NewCDTimer(23, 236519, nil, nil, nil, 3)--Used while inactive

--local berserkTimer				= mod:NewBerserkTimer(300)

--Huntress Kasparian
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--All
local voiceFontofElune				= mod:NewVoice(236357)--changemoon
--Huntress Kasparian
local voiceGlaiveStorm				= mod:NewVoice(236480)--watchstep
local voiceTwilightGlaive			= mod:NewVoice(237561)--runout
local voiceDiscorporate				= mod:NewVoice(236550)--changemoon/tauntboss
--Captain Yathae Moonstrike
local voiceCallMoontalon			= mod:NewVoice(236694, "-Healer")--killbigmob
local voiceTwilightVolley			= mod:NewVoice(236442)--watchstep
local voiceIncorpShot				= mod:NewVoice(236305)--targetyou
local voiceRapidShot				= mod:NewVoice(236596)--runout
--Priestess Lunaspyre
local voiceEmbraceofEclipse			= mod:NewVoice(233264, "Dps|Healer")--targetchange/healall
local voiceLunarBeacon				= mod:NewVoice(236712)--runout
local voiceLunarFire				= mod:NewVoice(239264)--tauntboss/stackhigh
local voiceMoonBurn					= mod:NewVoice(236519)--changemoon

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(233263, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.phase = 1
mod.vb.twilightGlaiveCount = 0
mod.vb.eclipseCount = 0
mod.vb.beaconCount = 0
local astralPurge = GetSpellInfo(234998)

function mod:VolleyTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellTwilightVolley:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.twilightGlaiveCount = 0
	self.vb.eclipseCount = 0
	self.vb.beaconCount = 0
	timerMoonBurnCD:Start(9.6-delay)
	timerMoonGlaiveCD:Start(14.4-delay)--16.6 on lat mythic test
	timerTwilightVolleyCD:Start(15.5-delay)--15.5-17
	timerTwilightGlaiveCD:Start(17.4-delay)
	timerIncorporealShotCD:Start(48-delay)
	timerEmbraceofEclipseCD:Start(48-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 236694 then
		specWarnCallMoontalon:Show()
		voiceCallMoontalon:Play("killbigmob")
		--timerCallMoontalonCD:Start()
	elseif spellId == 236442 then
		specWarnTwilightVolley:Show()
		voiceTwilightVolley:Play("watchstep")
		timerTwilightVolleyCD:Start()
		if self.vb.phase == 2 then
			self:BossTargetScanner(args.sourceGUID, "VolleyTarget", 0.1, 9)
		end
	elseif spellId == 236712 then
		self.vb.beaconCount = self.vb.beaconCount + 1
		if self.vb.beaconCount % 2 == 0 then
			timerLunarBeaconCD:Start(21.9)
		else
			timerLunarBeaconCD:Start(35)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236480 then--Likely completely wrong, but gives me something to copy/paste later when I move it
		specWarnGlaiveStorm:Show()
		voiceGlaiveStorm:Play("watchstep")
		timerGlaiveStormCD:Start()
	elseif spellId == 237561 then--^^
		self.vb.twilightGlaiveCount = self.vb.twilightGlaiveCount + 1
		--if self.vb.twilightGlaiveCount % 2 == 0 then
		--	timerTwilightGlaiveCD:Start(30)
		--else
			timerTwilightGlaiveCD:Start(18.2)
		--end
	elseif spellId == 236547 then
		timerMoonGlaiveCD:Start()
	elseif spellId == 236518 then
		timerMoonBurnCD:Start()
	elseif spellId == 233263 then
		timerEmbraceofEclipseCD:Start()
	elseif spellId == 236672 then
		timerRapidShotCD:Start()
	elseif spellId == 239264 then
		timerLunarFireCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 234995 or spellId == 234996) and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 12 then
			specWarnFontofElune:Show(amount)
			voiceFontofElune:Play("changemoon")
		end
	elseif spellId == 239264 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 4 then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnLunarFire:Show(amount)
					voiceLunarFire:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnLunarFireOther:Show(args.destName)
						voiceLunarFire:Play("tauntboss")
					else
						warnLunarFire:Show(args.destName, amount)
					end
				end
			else
				if amount % 2 == 0 then
					warnLunarFire:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 236550 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				specWarnDiscorporate:Show(astralPurge)
				voiceDiscorporate:Play("changemoon")
			else
				specWarnDiscorporateSwap:Show(args.destName)
				voiceDiscorporate:Play("tauntboss")
			end
		end
	elseif spellId == 236596 then
		if args:IsPlayer() then
			specWarnRapidShot:Show()
			voiceRapidShot:Play("runout")
			yellRapidShot:Yell()
		else
			warnRapidShot:Show(args.destName)
		end
	elseif spellId == 236305 then
		timerIncorporealShotCD:Start()
		if args:IsPlayer() then
			specWarnIncorpShot:Show()
			voiceIncorpShot:Play("targetyou")
			yellIncorpShot:Yell()
		else
			warnIncorporealShot:Show(args.destName)
		end
	elseif spellId == 233264 then--Dpser Embrace of the Eclipse
		self.vb.eclipseCount = self.vb.eclipseCount + 1
		if not self:IsHealer() then
			specWarnEmbraceofEclipse:Show(args.destName)
			voiceEmbraceofEclipse:Play("targetchange")
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "allabsorb", args.spellName)
		end
	elseif spellId == 233263 then--Healer Embrace of the Eclipse
		self.vb.eclipseCount = self.vb.eclipseCount + 1
		if self:IsHealer() then
			specWarnEmbraceofEclipse:CombinedShow(0.5, args.destName)
			if self:AntiSpam(3, 1) then
				voiceEmbraceofEclipse:Play("healall")
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "allabsorb", args.spellName)
		end
	elseif spellId == 236712 then
		warnLunarBeacon:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLunarBeacon:Show()
			voiceLunarBeacon:Play("runout")
			yellLunarBeacon:Schedule(5, 1)
			yellLunarBeacon:Schedule(4, 2)
			yellLunarBeacon:Schedule(3, 3)
		end
	elseif spellId == 236519 then
		warnMoonBurn:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnMoonBurn:Show(astralPurge)
			voiceMoonBurn:Play("changemoon")
		end
	elseif spellId == 237561 then
		if args:IsPlayer() then
			specWarnTwilightGlaive:Show()
			voiceTwilightGlaive:Play("runout")
			yellTwilightGlaive:Yell()
		else
			specWarnTwilightGlaiveOther:Show(args.destName)
			voiceTwilightGlaive:Play("farfromline")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 236712 and args:IsPlayer() then
		yellLunarBeacon:Cancel()
	elseif spellId == 233263 or spellId == 233264 then--Healer & boss Embrace of the Eclipse
		self.vb.eclipseCount = self.vb.eclipseCount - 1
		if self.Options.InfoFrame and self.vb.eclipseCount == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	--"<177.28 17:55:28> [UNIT_SPELLCAST_SUCCEEDED] Huntress Kasparian(Omegal) [[boss1:Captain Yathae Becomes Active Conversation::3-2083-1676-9420-243044-0023448060:243044]]", -- [3688]
	--"<177.62 17:55:28> [CHAT_MSG_MONSTER_SAY] No more dawdling, Kasparian! Victory shall be mine!#Captain Yathae Moonstrike###Omegal##0#0##0#451#nil#0#false#false#false#false", -- [3698]
	if spellId == 243044 then--Captain Yathae Becomes Active Conversation (Phase 2)
		self.vb.phase = 2
		warnPhase2:Show()
		timerMoonGlaiveCD:Stop()
		timerTwilightVolleyCD:Stop()
		timerTwilightGlaiveCD:Stop()
		timerIncorporealShotCD:Stop()
		timerCallMoontalonCD:Start(3.3)--Review
		timerTwilightGlaiveCD:Start(6)
		timerTwilightVolleyCD:Start(10.9)--Review
		timerRapidShotCD:Start(15.8)--Review
		timerGlaiveStormCD:Start(2)--Unknown, didn't get this far
	elseif spellId == 243047 then--Lunaspyre Becomes Active Conversation (Phase 3)
		self.vb.phase = 3
		warnPhase3:Show()
		timerRapidShotCD:Stop()
		timerTwilightVolleyCD:Stop()
		timerEmbraceofEclipseCD:Stop()
		timerMoonBurnCD:Stop()
		timerCallMoontalonCD:Stop()
		
		--AI timers for now
		timerLunarFireCD:Start(6)
		timerMoonBurnCD:Start(11)
		timerTwilightVolleyCD:Start(17)
		timerLunarBeaconCD:Start(18)
		--timerIncorporealShotCD:Start()--Never used in my log, maybe not used on normal
	end
end

