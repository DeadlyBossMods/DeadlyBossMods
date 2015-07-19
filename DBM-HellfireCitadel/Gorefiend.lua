local mod	= DBM:NewMod(1372, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90199)
mod:SetEncounterID(1783)
mod:SetZone()
mod:SetUsedIcons(2, 1)
mod:SetHotfixNoticeRev(13911)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181973 181582 187814",
	"SPELL_CAST_SUCCESS 179977 182170 181085",
	"SPELL_AURA_APPLIED 179864 179977 179909 179908 180148 181295 185982 189434 185189",
	"SPELL_AURA_APPLIED_DOSE 185189",
	"SPELL_AURA_REMOVED 179909 179908 181295 181973 185982",
	"SPELL_PERIODIC_DAMAGE 179995",
	"SPELL_ABSORBED 179995",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 181973 or ability.id = 181582 or ability.id = 187814) and type = "begincast" or (ability.id = 179977 or ability.id = 182170 or ability.id = 181085) and type = "cast" or (ability.id = 179864 or ability.id = 185982 or ability.id = 189131) and (type = "applydebuff" or type = "applybuff")
--TODO, Touch of Doom was 25 seconds in LFR, tested after heroic. changed? VERIFY
local warnShadowofDeath					= mod:NewTargetCountAnnounce(179864, 3)
local warnTouchofDoom					= mod:NewTargetAnnounce(179978, 4)
local warnSharedFate					= mod:NewTargetCountAnnounce(179909, 4)--Announce all 2/3
local warnHungerforLife					= mod:NewTargetAnnounce(180148, 3, nil, false)--Knowing who has it not very important, only if it's on you
local warnGoreboundSpiritSoon			= mod:NewSoonAnnounce("ej11020", 3, 187814)
local warnRagingCharge					= mod:NewSpellAnnounce(187814, 3, nil, "Melee")
local warnCrushingDarkness				= mod:NewCastAnnounce(180017, 3, 6, nil, false)

local specWarnShadowofDeath				= mod:NewSpecialWarning("specWarnShadowofDeath", nil, nil, nil, 1, 5)
local specWarnShadowofDeathTank			= mod:NewSpecialWarningTaunt(179864)
local specWarnTouchofDoom				= mod:NewSpecialWarningRun(179977, nil, nil, nil, 4, 2)
local yellTouchofDoom					= mod:NewYell(179977)
local specWarnDoomWell					= mod:NewSpecialWarningMove(179995)
local specWarnSharedFate				= mod:NewSpecialWarningMoveTo(179908, nil, nil, nil, 3, 2)--Only non rooted player get moveto. rooted player can't do anything.
local yellSharedFate					= mod:NewYell(179909)--Only rooted player should yell
local specWarnFeastofSouls				= mod:NewSpecialWarningSpell(181973, nil, nil, nil, 2)--Energy based
local specWarnFeastofSoulsEnded			= mod:NewSpecialWarningEnd(181973)
local specWarnHungerforLife				= mod:NewSpecialWarningRun(180148, nil, nil, nil, 4, 2)
local specWarnEnragedSpirit				= mod:NewSpecialWarningSwitch("ej11378", "-Healer")
local specWarnGoreboundSpirit			= mod:NewSpecialWarningSwitch("ej11020", "-Healer")
local specWarnBurning					= mod:NewSpecialWarningStack(185189, nil, 5)
local specWarnBurningOther				= mod:NewSpecialWarningTaunt(185189, nil, nil, nil, nil, 2)
local specWarnBellowingShout			= mod:NewSpecialWarningInterrupt(181582, "-Healer", nil, nil, 1, 2)

local timerShadowofDeathCDDps			= mod:NewTimer(30, "SoDDPS", 179864, "Dps", nil, 5)
local timerShadowofDeathCDTank			= mod:NewTimer(30, "SoDTank", 179864, "Tank", nil, 5)
local timerShadowofDeathCDHealer		= mod:NewTimer(30, "SoDHealer", 179864, "Healer", nil, 5)
local timerTouchofDoomCD				= mod:NewCDTimer(18, 179977, nil, nil, nil, 3)--25 seconds in LFR, tested after heroic. changed? VERIFY
local timerSharedFateCD					= mod:NewNextCountTimer(29, 179909, nil, nil, nil, 3)--29-31
local timerCrushingDarknessCD			= mod:NewNextTimer(10, 180017, nil, false, 2, 2)--Actually 16, but i delay start by 6 seconds for reduced spam
local timerFeastofSouls					= mod:NewNextTimer(123.5, 181973, nil, nil, nil, 6)--Probably next timer too, or close to it, depends how consistent energy gains are, may have small variation, like gruul

local timerDigest						= mod:NewCastTimer(40, 181295)
local timerCrushingDarkness				= mod:NewCastTimer(6, 180017, nil, false)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownShadowofDeath			= mod:NewCountdownFades("Alt5", 179864)
local countdownDigest					= mod:NewCountdown("Alt40", 181295)

local voiceTouchofDoom					= mod:NewVoice(179977)--runout
local voiceHungerforLife				= mod:NewVoice(180148)--justrun
local voiceBellowingShout				= mod:NewVoice(181582, "-Healer")--kickcast
local voiceShadowofDeath				= mod:NewVoice(179864)--teleyou, new voice, teleport into a new phase phase
local voiceSharedFate					= mod:NewVoice(179909)--linegather, new voice, like Blood-Queen Lana'thel's Pact of the Darkfallen, line gather will be better.
local voiceBurning						= mod:NewVoice(185189) --changemt

mod:AddSetIconOption("SetIconOnFate", 179909)
mod:AddHudMapOption("HudMapOnSharedFate", 179909)--Smart hud, distinquishes rooted from non rooted by color coding.
mod:AddArrowOption("SharedFateArrow", 179909, true, 2)
mod:AddRangeFrameOption(5, 182049)
mod:AddInfoFrameOption(181295)

mod.vb.rootedFate = nil
mod.vb.rootedFate2 = nil--Just in case, but if this happens you're doing things badly
mod.vb.shadowOfDeathCount = 0
mod.vb.sharedFateCount = 0
mod.vb.playersWithDigest = 0
local playerDown = false
local playersCount = 0
local sharedFateTimers = {19, 28, 25, 22}
local digestFilter
do
	local digestDebuff = GetSpellInfo(181295)
	digestFilter = function(uId)
		if not UnitDebuff(uId, digestDebuff) then
			return true
		end
	end
end
--[[
Time   Player Role   # of players sent, if your raid size is...
                          10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29
0:02      DPS             1   1   1   2   2   2   2   2   2   3   3   3   3   3   3   4   4   4   4   4
0:13      Tank            1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
0:30      Healer          1   1   1   1   1   1   1   1   1   1   2   2   2   2   2   2   2   2   2   2
0:38      DPS             1   1   1   1   1   2   2   2   2   2   2   3   3   3   3   3   3   4   4   4
1:05      Healer          0   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   2
1:14      DPS             1   1   1   1   1   1   1   2   2   2   2   2   2   3   3   3   3   4   4   4

Mythic
3s: 2 DPS
9s: 1 tank
21s: 2 healers
30s: 2 DPS
57s: 2 DPS
66s: 2 healers
69s: 1 tank
84s: 2 DPS
--]]
--local shadowofDeathTimers = {2, 11, 17, 7, 28, 8}
--local shadowofDeathTimers10 = {2, 11, 17, 7, 36}--Special case, 1:05 cast doesn't happen with exactly 10 players.
--local shadowofDeathTimersMythic = {2, 6, 12, 9, 27, 8, 3, 15}

function mod:OnCombatStart(delay)
	self.vb.rootedFate = nil
	self.vb.rootedFate2 = nil
	self.vb.shadowOfDeathCount = 0
	self.vb.sharedFateCount = 0
	self.vb.playersWithDigest = 0
	playerDown = false
	playersCount = DBM:GetGroupSize()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5, digestFilter)
	end
	if self:IsMythic() then
		timerShadowofDeathCDDps:Start(2-delay, "2x"..DBM_CORE_DAMAGE_ICON)
		timerShadowofDeathCDTank:Start(9-delay, "1x"..DBM_CORE_TANK_ICON)
		timerShadowofDeathCDHealer:Start(21-delay, "2x"..DBM_CORE_HEALER_ICON)
	else
		local numDpsPlayers = 1
		local numHealerPlayers = 1
		--Counts for 1nd cast here
		if playersCount >= 13 and playersCount < 19 then
			numDpsPlayers = 2
		elseif playersCount >= 19 and playersCount < 25 then
			numDpsPlayers = 3
		elseif playersCount >= 25 and playersCount < 31 then
			numDpsPlayers = 4
		end
		if playersCount >= 20 then numHealerPlayers = 2 end--2 healers 20 players or over
		timerShadowofDeathCDDps:Start(2-delay, numDpsPlayers.."x"..DBM_CORE_DAMAGE_ICON, 1)
		timerShadowofDeathCDTank:Start(13-delay, "1x"..DBM_CORE_TANK_ICON, 2)
		timerShadowofDeathCDHealer:Start(30-delay, numHealerPlayers.."x"..DBM_CORE_HEALER_ICON, 3)
	end
	timerCrushingDarknessCD:Start(5-delay)
	timerTouchofDoomCD:Start(9-delay)
	timerSharedFateCD:Start(19-delay, 1)
	timerFeastofSouls:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnSharedFate then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

local function sharedFateDelay(self)
	if self.vb.rootedFate2 then--Check this first, assume you are linked to most recent
		specWarnSharedFate:Show(self.vb.rootedFate2)
		voiceSharedFate:Play("linegather")
	elseif self.vb.rootedFate then
		specWarnSharedFate:Show(self.vb.rootedFate)
		voiceSharedFate:Play("linegather")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181973 then
		specWarnFeastofSouls:Show()
	elseif spellId == 181582 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBellowingShout:Show(args.sourceName)
		voiceBellowingShout:Play("kickcast")
	elseif spellId == 187814 then
		warnRagingCharge:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 179977 then
		timerTouchofDoomCD:Start()
	elseif spellId == 182170 then--LFR version
		timerTouchofDoomCD:Start(25)
	elseif spellId == 181085 then
		self.vb.sharedFateCount = self.vb.sharedFateCount + 1
		local cooldown = sharedFateTimers[self.vb.sharedFateCount+1]
		if cooldown then
			timerSharedFateCD:Start(cooldown, self.vb.sharedFateCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 179864 then
		if self:AntiSpam(2, 4) then
			self.vb.shadowOfDeathCount = self.vb.shadowOfDeathCount + 1
			local count = self.vb.shadowOfDeathCount
			if self:IsMythic() then
				if count == 1 or count == 4 or count == 5 then--DPS 4x (3 timers)
					timerShadowofDeathCDDps:Start(27, "2x"..DBM_CORE_DAMAGE_ICON)
				elseif count == 2 then--Tank 2x (1 timer)
					timerShadowofDeathCDTank:Start(60, "1x"..DBM_CORE_TANK_ICON)
				elseif count == 3 then--Healer 2x (1 timer)
					timerShadowofDeathCDHealer:Start(45, "2x"..DBM_CORE_HEALER_ICON)
				end	
			else
				if count == 1 or count == 4 then--DPS 3x (2 timers)
					local numPlayers = 1
					--Counts for 2nd cast generated here
					if playersCount >= 15 and playersCount < 21 then
						numPlayers = 2
					elseif playersCount >= 21 and playersCount < 27 then
						numPlayers = 3
					elseif playersCount >= 27 and playersCount < 31 then
						numPlayers = 4
					end
					--Adjust count for 3rd cast off the 2nd cast above
					if count == 4 and (playersCount == 15 or playersCount == 16 or playersCount == 21 or playersCount == 22 or playersCount == 25 or playersCount == 26) then--subtrack 1 from above for 2nd cast
						numPlayers = numPlayers - 1
					end
					timerShadowofDeathCDDps:Start(36, numPlayers.."x"..DBM_CORE_DAMAGE_ICON)
				elseif count == 2 then--Tank 1x (0 timers)
					--Do nothing, only one tank is sent
					--timerShadowofDeathCDTank:Start(60, "1x"..DBM_CORE_TANK_ICON)
				elseif count == 3 and playersCount > 10 then--Healer 2x (1 timer). Only gets a 2nd one if > 10 players
					local numPlayers = 1--Only one healer for 11-28 players
					if playersCount >= 29 then numPlayers = 2 end--Only 2 healers for player count 29 and 30
					timerShadowofDeathCDHealer:Start(36, numPlayers.."x"..DBM_CORE_HEALER_ICON)
				end
			end
		end
		warnShadowofDeath:CombinedShow(0.5, self.vb.shadowOfDeathCount, args.destName)
		if args:IsPlayer() then
			specWarnShadowofDeath:Show(self.vb.shadowOfDeathCount)
			countdownShadowofDeath:Start()
			voiceShadowofDeath:Play("teleyou")
		end
		--Check if it's a tank (todo, maybe just change it to count == 2 to reduce cpu, the tank is pretty much always 2/6
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") and not UnitIsUnit("player", uId) then
			--It is a tank and we're not tanking. Fire taunt warning
			specWarnShadowofDeathTank:Show(args.destName)
		end
	elseif spellId == 179977 or spellId == 189434 then
		if not playerDown then
			warnTouchofDoom:CombinedShow(0.5, args.destName)
		end
		if args:IsPlayer() then
			specWarnTouchofDoom:Show()
			voiceTouchofDoom:Play("runout")
			yellTouchofDoom:Yell()
		end
	elseif spellId == 179909 then--Root version
		if not playerDown then
			warnSharedFate:CombinedShow(0.5, args.destName)
		end
		if self.vb.rootedFate then--One already exists
			self.vb.rootedFate2 = args.destName
		else
			self.vb.rootedFate = args.destName
		end
		if self.Options.SetIconOnFate then
			if self.vb.rootedFate2 then
				self:SetIcon(args.destName, 2)
			else
				self:SetIcon(args.destName, 1)
			end
		end
		if self.Options.HudMapOnSharedFate and not playerDown then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179909, "highlight", args.destName, 3.5, 900, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
		end
		if args:IsPlayer() then
			yellSharedFate:Yell()
		end
	elseif spellId == 179908 then--Non root version (must run to rooted player)
		warnSharedFate:CombinedShow(0.5, self.vb.sharedFateCount, args.destName)
		if args:IsPlayer() then
			self:Schedule(0.5, sharedFateDelay, self)--Just in case rooted ID fires after non rooted ones
		end
		if self.Options.HudMapOnSharedFate and not playerDown then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(179908, "highlight", args.destName, 3.5, 900, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)--Yellow
		end
	elseif spellId == 180148 then
		warnHungerforLife:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(5, 2) then
			specWarnHungerforLife:Show()
			voiceHungerforLife:Play("justrun")
		end
	elseif spellId == 181295 then
		self.vb.playersWithDigest = self.vb.playersWithDigest + 1
		if args:IsPlayer() then
			if self:IsMythic() then
				timerDigest:Start(30)
				countdownDigest:Start(30)
			else
				timerDigest:Start()
				countdownDigest:Start()
			end
			playerDown = true
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.InfoFrame and self.vb.playersWithDigest == 1 then--coming from 0, open infoframe
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", 181295)
		end
	elseif spellId == 185982 and not playerDown then--Cast when a Enraged Spirit in stomach reaches 70%
		warnGoreboundSpiritSoon:Show()
	elseif spellId == 185189 then
		local amount = args.amount or 1
		if (amount >= 5) and self:AntiSpam(3, 5) then
			voiceBurning:Play("changemt")
			if args:IsPlayer() then
				specWarnBurning:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnBurningOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 179909 then--Root version
		if self.vb.rootedFate == args.destName then
			self.vb.rootedFate = nil
		elseif self.vb.rootedFate2 == args.destName then
			self.vb.rootedFate2 = nil
		end
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:FreeEncounterMarkerByTarget(179909, args.destName)
		end
		if self.Options.SetIconOnFate then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 179908 then--Non root version (must run to rooted player)
		if self.Options.HudMapOnSharedFate then
			DBMHudMap:FreeEncounterMarkerByTarget(179908, args.destName)
		end
	elseif spellId == 181295 then
		self.vb.playersWithDigest = self.vb.playersWithDigest - 1
		if args:IsPlayer() then
			timerDigest:Cancel()
			countdownDigest:Cancel()
			playerDown = false
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5, digestFilter)
			end
		end
		if self.Options.InfoFrame and self.vb.playersWithDigest == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 181973 then--Phase restart
		self.vb.shadowOfDeathCount = 0
		specWarnFeastofSoulsEnded:Show()
		--Timers exactly same as pull
		if self:IsMythic() then
			timerShadowofDeathCDDps:Start(2, "2x"..DBM_CORE_DAMAGE_ICON)
			timerShadowofDeathCDTank:Start(9, "1x"..DBM_CORE_TANK_ICON)
			timerShadowofDeathCDHealer:Start(21, "2x"..DBM_CORE_HEALER_ICON)
		else
			local numDpsPlayers = 1
			local numHealerPlayers = 1
			--Counts for 1nd cast here
			if playersCount >= 13 and playersCount < 19 then
				numDpsPlayers = 2
			elseif playersCount >= 19 and playersCount < 25 then
				numDpsPlayers = 3
			elseif playersCount >= 25 and playersCount < 31 then
				numDpsPlayers = 4
			end
			if playersCount >= 20 then numHealerPlayers = 2 end--2 healers 20 players or over
			timerShadowofDeathCDDps:Start(2, numDpsPlayers.."x"..DBM_CORE_DAMAGE_ICON)
			timerShadowofDeathCDTank:Start(13, "1x"..DBM_CORE_TANK_ICON)
			timerShadowofDeathCDHealer:Start(30, numHealerPlayers.."x"..DBM_CORE_HEALER_ICON)
		end
		timerCrushingDarknessCD:Start(5)
		timerTouchofDoomCD:Start(9)
		timerSharedFateCD:Start(19, 1)
		timerFeastofSouls:Start()
	elseif spellId == 185982 and not playerDown then
		--When it fades, it means it's casting Expel Soul and returning to surface as a Gorebound Spirit
		--This is cleaner than IEEU and fires at same time
		specWarnGoreboundSpirit:Show()
	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 180016 and self:AntiSpam(2, 1) then--Crushing Darkness
		warnCrushingDarkness:Show()
		timerCrushingDarkness:Start()
		timerCrushingDarknessCD:Schedule(6)--Delay timer by 6 seconds, so it doesn't start until after cast timer ends, reduce timer spam
	--"<39.51 18:23:36> [UNIT_SPELLCAST_SUCCEEDED] Gorefiend(Slootbag) [[boss1:Empower Spirits::0:180192]]", -- [2949]
	--"<41.98 18:23:38> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#boss1#true#true#true#Gorefiend#Vehicle-0-2012-1448-7347-90199-0000381EB8#elite#375918859#boss2#true#true#true#Gorebound Spirit
	elseif spellId == 185753 and playerDown then--Tank Add Exploit Protection (Enraged Spirit Spawn)
		specWarnEnragedSpirit:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 179995 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnDoomWell:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
