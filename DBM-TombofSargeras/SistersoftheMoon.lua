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
	"SPELL_CAST_START 236694 236442",
	"SPELL_CAST_SUCCES 236480 236541 236547 237633 236304 236712 236518",
	"SPELL_AURA_APPLIED 234995 234996 236550 236596 233264 233263 236712 239264 236519",
	"SPELL_AURA_APPLIED_DOSE 234995 234996 239264",
	"SPELL_AURA_REMOVED 233264 236712",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, phase detection to remove/add timers etc.
--TODO, figure out which of the MANY scripts are for glaive storm
--TODO, figure out same for Twilight Glaive
--TODO, figure out how to actually pre warn moon glaive and give it a warning.
--TODO, figure out what to do Spectral Glaive. Why does iti even exist, totally redundant waste of space, already have Moon Glaive
--TODO, is there even a point to Shadow shot?
--TODO, NP auras on Rapid Shot and Incorporeal Shot once I can actually find events for them
--TODO, infoframe showing absorbs remaining on boss/players if possible to get remaining shield from UnitBuff/UnitDebuff in an onupdate call?
--TODO, fine tune all option defaults once what targets or doesn't target x and y is known. Fight can't have too much timer/warning spam
--TODO, announce lunar strike? more redundancy in encounter that isn't needed IMO
--Captain Yathae Moonstrike
local warnIncorporealShot			= mod:NewTargetAnnounce(236304, 3)
local warnRapidShot					= mod:NewTargetAnnounce(236596, 3)
local warnMoonBurn					= mod:NewTargetAnnounce(236519, 3)
--Priestess Lunaspyre
local warnLunarBeacon				= mod:NewTargetAnnounce(236712, 3)
local warnLunarFire					= mod:NewStackAnnounce(239264, 2, nil, "Tank")

--All
local specWarnFontofElune			= mod:NewSpecialWarningStack(236357, nil, 7, nil, 2, 1, 6)--Stack unknown
--Huntress Kasparian
local specWarnGlaiveStorm			= mod:NewSpecialWarningDodge(236480, nil, nil, nil, 2, 2)
local specWarnTwilightGlaive		= mod:NewSpecialWarningDodge(236541, nil, nil, nil, 2, 2)
local specWarnDiscorporate			= mod:NewSpecialWarningTaunt(236550, nil, nil, nil, 1, 2)
--Captain Yathae Moonstrike
local specWarnCallMoontalon			= mod:NewSpecialWarningSwitch(236694, "-Healer", nil, nil, 1, 2)
local specWarnTwilightVolley		= mod:NewSpecialWarningSpell(236442, nil, nil, nil, 2, 2)
local specWarnRapidShot				= mod:NewSpecialWarningMoveAway(236596, nil, nil, nil, 1, 2)
local yellRapidShot					= mod:NewYell(236596)
--Priestess Lunaspyre
local specWarnEmbraceofEclipse		= mod:NewSpecialWarningTarget(233264, "Dps|Healer", nil, nil, 3, 2)
local specWarnLunarBeacon			= mod:NewSpecialWarningMoveAway(236712, nil, nil, nil, 1, 2)
local yellLunarBeacon				= mod:NewFadesYell(236712)
local specWarnLunarFire				= mod:NewSpecialWarningStack(239264, nil, 4, nil, nil, 1, 2)
local specWarnLunarFireOther		= mod:NewSpecialWarningTaunt(239264, nil, nil, nil, 1, 2)

--Huntress Kasparian
local timerGlaiveStormCD			= mod:NewAITimer(31, 236480, nil, nil, nil, 3)
local timerTwilightGlaiveCD			= mod:NewAITimer(31, 236541, nil, nil, nil, 3)
local timerMoonGlaiveCD				= mod:NewAITimer(31, 236547, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSpectralGlaiveCD			= mod:NewAITimer(31, 237633, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerMoonBurnCD				= mod:NewAITimer(31, 236518, nil, nil, nil, 3)
--Captain Yathae Moonstrike
local timerIncorporealShotCD		= mod:NewAITimer(31, 236304, nil, nil, nil, 3)
local timerCallMoontalonCD			= mod:NewAITimer(31, 236694, nil, nil, nil, 1)
local timerTwilightVolleyCD			= mod:NewAITimer(31, 236442, nil, nil, nil, 2)--Cast while inactive. active too?
local timerRapidShotCD				= mod:NewAITimer(31, 236596, nil, nil, nil, 3)
--Priestess Lunaspyre
local timerEmbraceofEclipseCD		= mod:NewAITimer(31, 233264, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DAMAGE_ICON)
local timerLunarBeaconCD			= mod:NewAITimer(31, 236712, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Huntress Kasparian
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--All
local voiceFontofElune				= mod:NewVoice(228003)--stackhigh
--Huntress Kasparian
local voiceGlaiveStorm				= mod:NewVoice(236480)--watchstep
local voiceTwilightGlaive			= mod:NewVoice(236541)--watchstep?
local voiceDiscorporate				= mod:NewVoice(236550)--tauntboss
--Captain Yathae Moonstrike
local voiceCallMoontalon			= mod:NewVoice(236694, "-Healer")--killbigmob
local voiceTwilightVolley			= mod:NewVoice(236442)--aesoon
local voiceRapidShot				= mod:NewVoice(236596)--runout
--Priestess Lunaspyre
local voiceEmbraceofEclipse			= mod:NewVoice(233264, "Dps|Healer")--targetchange/healall
local voiceLunarBeacon				= mod:NewVoice(236712)--runout
local voiceLunarFire				= mod:NewVoice(239264)--tauntboss/stackhigh

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	timerGlaiveStormCD:Start(1-delay)
	timerTwilightGlaiveCD:Start(1-delay)
	timerMoonGlaiveCD:Start(1-delay)
	timerSpectralGlaiveCD:Start(1-delay)
	timerMoonBurnCD:Start(1-delay)--11
	timerTwilightVolleyCD:Start(1-delay)--15.5
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236480 then--Likely completely wrong, but gives me something to copy/paste later when I move it
		specWarnGlaiveStorm:Show()
		voiceGlaiveStorm:Play("watchstep")
		timerGlaiveStormCD:Start()
	elseif spellId == 236541 then--^^
		specWarnTwilightGlaive:Show()
		voiceTwilightGlaive:Play("watchstep")
		timerTwilightGlaiveCD:Start()
	elseif spellId == 236547 then
		timerMoonGlaiveCD:Start()
	elseif spellId == 237633 then
		timerSpectralGlaiveCD:Start()
	elseif spellId == 236304 then--Most definitely wrong.this fight is missing a ton of debuffs/cast Ids, having only scripts/damage events currently
		warnIncorporealShot:Show(args.destName)
		timerIncorporealShotCD:Start()
	elseif spellId == 236712 then
		timerLunarBeaconCD:Start()
	elseif spellId == 236518 then
		timerMoonBurnCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 234995 or spellId == 234996) and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
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
	elseif spellId == 233264 then--Dpser Embrace of the Eclipse
		if not self:IsHealer() then
			specWarnEmbraceofEclipse:Show(args.destName)
			voiceEmbraceofEclipse:Play("targetchange")
		end
		timerEmbraceofEclipseCD:Start()
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
