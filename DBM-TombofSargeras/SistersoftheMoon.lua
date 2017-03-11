local mod	= DBM:NewMod(1903, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118523, 118374, 118518)--118523 Huntress kasparian, 118374 Captain Yathae Moonstrike, 118518 Prestess Lunaspyre
mod:SetEncounterID(2050)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 15

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 236694 236442 236712",
	"SPELL_CAST_SUCCESS 236480 236547 237633 236518 233263 237561",
	"SPELL_AURA_APPLIED 234995 234996 236550 236596 233264 233263 236712 239264 236519 237561",
	"SPELL_AURA_APPLIED_DOSE 234995 234996 239264",
	"SPELL_AURA_REMOVED 233264 236712",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, phase detection to remove/add timers etc.
--TODO, figure out which of the MANY scripts are for glaive storm
--TODO, figure out how to actually pre warn moon glaive and give it a warning.
--TODO, figure out what to do Spectral Glaive. Why does iti even exist, totally redundant waste of space, already have Moon Glaive
--TODO, is there even a point to Shadow shot?
--TODO, infoframe showing absorbs remaining on boss/players if possible to get remaining shield from UnitBuff/UnitDebuff in an onupdate call?
--TODO, fine tune all option defaults once what targets or doesn't target x and y is known. Fight can't have too much timer/warning spam
--TODO, announce lunar strike? more redundancy in encounter that isn't needed IMO
--TODO, video fight and improve timer interactions to better deal with huge variation in stuff like moon glaive timer.
--[[
(ability.id = 236694 or ability.id = 236442 or ability.id = 239379 or ability.id = 236712) and type = "begincast" or
(ability.id = 236480 or ability.id = 237561 or ability.id = 236547 or ability.id = 237633 or ability.id = 236518 or ability.id = 236596 or ability.id = 233263 or ability.id = 239264) and type = "cast" or
(ability.id = 236305 or ability.id = 236596) and type = "applydebuff"
--]]
--Huntress Kasparian
local warnTwilightGlaive			= mod:NewTargetAnnounce(237561, 3)
--Captain Yathae Moonstrike
local warnIncorporealShot			= mod:NewTargetAnnounce(236305, 3)
local warnRapidShot					= mod:NewTargetAnnounce(236596, 3)
--Priestess Lunaspyre
local warnLunarBeacon				= mod:NewTargetAnnounce(236712, 3)
local warnLunarFire					= mod:NewStackAnnounce(239264, 2, nil, "Tank")
local warnMoonBurn					= mod:NewTargetAnnounce(236519, 3)

--All
local specWarnFontofElune			= mod:NewSpecialWarningStack(236357, nil, 12, nil, 2, 1, 6)--Stack unknown
--Huntress Kasparian
local specWarnGlaiveStorm			= mod:NewSpecialWarningDodge(236480, nil, nil, nil, 2, 2)
local specWarnTwilightGlaive		= mod:NewSpecialWarningMoveAway(237561, nil, nil, nil, 2, 2)
local yellTwilightGlaive			= mod:NewYell(237561)
local specWarnDiscorporate			= mod:NewSpecialWarningTaunt(236550, nil, nil, nil, 1, 2)
--Captain Yathae Moonstrike
local specWarnCallMoontalon			= mod:NewSpecialWarningSwitch(236694, "-Healer", nil, nil, 1, 2)
local specWarnTwilightVolley		= mod:NewSpecialWarningSpell(236442, nil, nil, nil, 2, 2)
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
local specWarnMoonBurn				= mod:NewSpecialWarningYou(236519, nil, nil, nil, 1)--Add voice filter when it has a voice

--Huntress Kasparian
local timerGlaiveStormCD			= mod:NewAITimer(31, 236480, nil, nil, nil, 3)
local timerTwilightGlaiveCD			= mod:NewCDTimer(31, 237561, nil, nil, nil, 3)
local timerMoonGlaiveCD				= mod:NewCDTimer(13.4, 236547, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--13.4-30 second variation, have fun with that
local timerSpectralGlaiveCD			= mod:NewAITimer(31, 237633, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--Captain Yathae Moonstrike
local timerIncorporealShotCD		= mod:NewCDTimer(54.7, 236305, nil, nil, nil, 3)
local timerCallMoontalonCD			= mod:NewAITimer(31, 236694, nil, nil, nil, 1)
local timerTwilightVolleyCD			= mod:NewCDTimer(19.4, 236442, nil, nil, nil, 2)--Cast while inactive.
local timerRapidShotCD				= mod:NewAITimer(31, 236596, nil, nil, nil, 3)
--Priestess Lunaspyre
local timerEmbraceofEclipseCD		= mod:NewCDTimer(54.3, 233264, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DAMAGE_ICON)--Used while inactive
local timerLunarBeaconCD			= mod:NewAITimer(31, 236712, nil, nil, nil, 3)
local timerMoonBurnCD				= mod:NewCDTimer(23, 236519, nil, nil, nil, 3)--Used while inactive

--local berserkTimer				= mod:NewBerserkTimer(300)

--Huntress Kasparian
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--All
local voiceFontofElune				= mod:NewVoice(236357)--stackhigh
--Huntress Kasparian
local voiceGlaiveStorm				= mod:NewVoice(236480)--watchstep
local voiceTwilightGlaive			= mod:NewVoice(237561)--runout
local voiceDiscorporate				= mod:NewVoice(236550)--tauntboss
--Captain Yathae Moonstrike
local voiceCallMoontalon			= mod:NewVoice(236694, "-Healer")--killbigmob
local voiceTwilightVolley			= mod:NewVoice(236442)--aesoon
local voiceIncorpShot				= mod:NewVoice(236305)--targetyou
local voiceRapidShot				= mod:NewVoice(236596)--runout
--Priestess Lunaspyre
local voiceEmbraceofEclipse			= mod:NewVoice(233264, "Dps|Healer")--targetchange/healall
local voiceLunarBeacon				= mod:NewVoice(236712)--runout
local voiceLunarFire				= mod:NewVoice(239264)--tauntboss/stackhigh
--local voiceMoonBurn					= mod:NewVoice(236519)--??? findastral? need to know how astral works first.

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.phase = 1
mod.vb.twilightGlaiveCount = 0

function mod:OnCombatStart(delay)
	self.vb.twilightGlaiveCount = 0
	timerMoonBurnCD:Start(10-delay)
	timerMoonGlaiveCD:Start(14.4-delay)
	timerTwilightVolleyCD:Start(15.5-delay)--15.5-17
	timerTwilightGlaiveCD:Start(18.3-delay)
	timerIncorporealShotCD:Start(48-delay)
	timerEmbraceofEclipseCD:Start(48-delay)
end

function mod:OnCombatEnd()
	self.vb.phase = 1
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 236694 then
		specWarnCallMoontalon:Show()
		voiceCallMoontalon:Play("killbigmob")
		timerCallMoontalonCD:Start()
	elseif spellId == 236442 then
		specWarnTwilightVolley:Show()
		voiceTwilightVolley:Play("aesoon")
		timerTwilightVolleyCD:Start()
	elseif spellId == 236712 then
		timerLunarBeaconCD:Start()
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
		if self.vb.twilightGlaiveCount % 2 == 0 then
			timerTwilightGlaiveCD:Start(30)
		else
			timerTwilightGlaiveCD:Start(18.2)
		end
	elseif spellId == 236547 then
		timerMoonGlaiveCD:Start()
	elseif spellId == 237633 then
		timerSpectralGlaiveCD:Start()
	elseif spellId == 236518 then
		timerMoonBurnCD:Start()
	elseif spellId == 233263 then
		timerEmbraceofEclipseCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 234995 or spellId == 234996) and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 12 then
			specWarnFontofElune:Show(amount)
			voiceFontofElune:Play("stackhigh")
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
			if not args:IsPlayer() then
				specWarnDiscorporate:Show(args.destName)
				voiceDiscorporate:Play("tauntboss")
			end
		end
	elseif spellId == 236596 then
		timerRapidShotCD:Start()--Maybe move to SUCCESS event if there is one
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
		if not self:IsHealer() then
			specWarnEmbraceofEclipse:Show(args.destName)
			voiceEmbraceofEclipse:Play("targetchange")
		end
	elseif spellId == 233263 then--Healer Embrace of the Eclipse
		if self:IsHealer() then
			specWarnEmbraceofEclipse:CombinedShow(0.5, args.destName)
			if self:AntiSpam(3, 1) then
				voiceEmbraceofEclipse:Play("healall")
			end
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
			specWarnMoonBurn:Show()
		end
	elseif spellId == 237561 then
		if args:IsPlayer() then
			specWarnTwilightGlaive:Show()
			voiceTwilightGlaive:Play("runout")
			yellTwilightGlaive:Yell()
		else
			warnTwilightGlaive:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 236712 and args:IsPlayer() then
		yellLunarBeacon:Cancel()
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
	--["236547-Moon Glaive"] = "pull:14.6, 15.8, 15.8, 25.5, 16.9"
	--["236547-Moon Glaive"] = "pull:14.4, 14.6, 17.0, 29.2, 15.7, 27.9, 20.6, 30.3, 18.2, 18.2, 30.3, 13.4",
	if spellId == 236547 then--Moon Glaive
		timerMoonGlaiveCD:Start()
	end
end

