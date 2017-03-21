local mod	= DBM:NewMod(1898, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(108573)--121227 Illiden? 121193 Shadowsoul
mod:SetEncounterID(2051)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 238502 237725 238999 239214",
	"SPELL_CAST_SUCCESS 239932 235059 236378 236710 237590 236498 238502 239785",
	"SPELL_AURA_APPLIED 239932 236378 236710 237590 236498 236597 241721",
	"SPELL_AURA_APPLIED_DOSE 239932",
	"SPELL_AURA_REMOVED 236378 236710 237590 236498 241721",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"--Illiden might cast important stuff, or adds?
)

--TODO, verify scripting of armageddon, and how to better refine warning type based on role once examined thoroughly
--TODO, fine tune reflections with appropriate functions like range, etc if needed. Custom voices with correct actions other than "targetyou"
--TODO, verify Shadow Reflection expire times, 3 8s and a 7. one has a cast time and other 3 do not. suspicious!
--TODO, find a way to detect WHO is targetted by focused dreadflame, no clear spellid visible from journal alone. probably an emote or whisper
--TODO, more work on bursting, find that target too.
--TODO, verify/correct event for Malignant Anguish, it's likely a channeled/buff type interrupt since spellID has no cast time.
--TODO, if multiple hopelessness adds spawn at once, auto mark them so healers can be assigned to diff targets by raid icon
--TODO, correct phase detection
--TODO, do we need shadow gaze warnings for player other then self?
--TODO, how many shadowsouls? Also add a "remaining warning" for it as well.
--TODO, fix demonic obelisk if it's not in combat log. Also consider what type of warning it should be
--TODO, buff active timer for expiring rifts? they seem to last 50 seconds based on data. So timer similar to elisande bubble timer?
--TODO, also verify cast event for tear rift. 239214 cast ID is a script and might not be combat log reliable
--TODO, flame orb work. target of fixate after spawn. more than one spawn? if not, remove antispam
--TODO, if above is successful, add range frame (10 yards) for fixated flame orb person.
--Intermission: Eternal Flame
local warnBurstingDreadFlame		= mod:NewSpellAnnounce(238430, 2)--Generic for now until more known, likely something cast fairly often
--Stage Three: Darkness of A Thousand Souls
local warnDemonicObelisk			= mod:NewSpellAnnounce(239785, 2)
local warnTearRift					= mod:NewSpellAnnounce(239214, 2)--Positive message color?

--Stage One: The Betrayer
local specWarnFelclaws				= mod:NewSpecialWarningStack(239932, nil, 2, nil, nil, 1, 2)
local specWarnFelclawsOther			= mod:NewSpecialWarningTaunt(239932, nil, nil, nil, 1, 2)
local specWarnRupturingSingularity	= mod:NewSpecialWarningDodge(235059, nil, nil, nil, 2, 2)
local specWarnArmageddon			= mod:NewSpecialWarningSpell(240910, nil, nil, nil, 2, 2)
local specWarnSRWailing				= mod:NewSpecialWarningYou(236378, nil, nil, nil, 1, 2)
local yellSRWailing					= mod:NewFadesYell(236378)
local specWarnSRErupting			= mod:NewSpecialWarningYou(236710, nil, nil, nil, 1, 2)
local yellSRErupting				= mod:NewFadesYell(236710)
--Intermission: Eternal Flame
local specWarnFocusedDreadflame		= mod:NewSpecialWarningSpell(238502, nil, nil, nil, 1, 2)--Change to more specific warning if target name can be found
--Stage Two: Reflected Souls
local specWarnSRHopeless			= mod:NewSpecialWarningYou(237590, nil, nil, nil, 1, 2)
local yellSRHopeless				= mod:NewFadesYell(237590)
local specWarnSRMalignant			= mod:NewSpecialWarningYou(236498, nil, nil, nil, 1, 2)
local yellSRMalignant				= mod:NewFadesYell(236498)
local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local specWarnDarknessofSouls		= mod:NewSpecialWarningMoveTo(238999, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(238999), nil, 3, 2)
local specWarnFlamingOrbSpawn		= mod:NewSpecialWarningSpell(239253, nil, nil, nil, 1, 2)--Spawn warning (todo, another warning for fixate target if possible)

--Stage One: The Betrayer
local timerFelclawsCD				= mod:NewAITimer(31, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRupturingSingularityCD	= mod:NewAITimer(31, 235059, nil, nil, nil, 3)
local timerArmageddonCD				= mod:NewAITimer(31, 240910, nil, nil, nil, 5)
local timerShadowReflectionCD		= mod:NewAITimer(31, "ej15238", nil, nil, nil, 3, 236378)--Wailing icon used.
--Intermission: Eternal Flame
local timerFocusedDreadflameCD		= mod:NewAITimer(31, 238502, nil, nil, nil, 3)
local timerBurstingDreadflameCD		= mod:NewAITimer(31, 238429, nil, nil, nil, 3)
--Stage Two: Reflected Souls
local timerHopelessness				= mod:NewCastTimer(8, 237725, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
--Intermission: Deceiver's Veil
local timerSightlessGaze			= mod:NewBuffActiveTimer(20, 241721, nil, nil, nil, 5)
--Stage Three: Darkness of A Thousand Souls
local timerDarknessofSoulsCD		= mod:NewAITimer(31, 238999, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerDemonicObeliskCD			= mod:NewAITimer(31, 239785, nil, nil, nil, 3)
local timerTearRiftCD				= mod:NewAITimer(31, 239214, nil, nil, nil, 3)
local timerFlamingOrbCD				= mod:NewAITimer(31, 239253, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage One: The Betrayer
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Stage One: The Betrayer
local voiceFelclaws					= mod:NewVoice(239932)--tauntboss
local voiceRupturingSingularity		= mod:NewVoice(235059)--watchstep
local voiceArmageddon				= mod:NewVoice(240910)--helpsoak
local voiceSRWailing				= mod:NewVoice(236378)--targetyou (temp, more customized after seen)
local voiceSRErupting				= mod:NewVoice(236710)--targetyou (temp, more customized after seen)
--Intermission: Eternal Flame
local voiceFocusedDreadflame		= mod:NewVoice(238502)--helpsoak/range5?
--Stage Two: Reflected Souls
local voiceSRHopeless				= mod:NewVoice(237590)--targetyou (temp, more customized after seen)
local voiceSRMalignant				= mod:NewVoice(236498)--targetyou (temp, more customized after seen)
local voiceMalignantAnguish			= mod:NewVoice(236597)--kickcast
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local voiceDarknesofSouls			= mod:NewVoice(238999)--findshelter


--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
mod:AddRangeFrameOption("5/10")--238502/239253

mod.vb.phase = 1
mod.vb.shadowSoulsRemaining = 3--Need real number
local shelterName = GetSpellInfo(239130)

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
	timerFelclawsCD:Start(1-delay)
	timerRupturingSingularityCD:Start(1-delay)
	timerArmageddonCD:Start(1-delay)
	timerShadowReflectionCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 238502 then
		specWarnFocusedDreadflame:Show()
		voiceFocusedDreadflame:Play("helpsoak")
		timerFocusedDreadflameCD:Start()
		if not self:IsEasy() then--TODO, this isn't mentioned in intermission, only in phase 2+ version. Investigate
			voiceFocusedDreadflame:Schedule(1, "range5")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 237725 and self:AntiSpam(5, 2) then--Assume they all spawn/begin casting at same time
		timerHopelessness:Start()
	elseif spellId == 238999 then
		specWarnDarknessofSouls:Show(shelterName)
		voiceDarknesofSouls:Play("findshelter")
		timerDarknessofSoulsCD:Start()
	elseif spellId == 239214 then
		warnTearRift:Show()
		timerTearRiftCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 239932 then
		timerFelclawsCD:Start()
	elseif spellId == 235059 then
		specWarnRupturingSingularity:Show()
		voiceRupturingSingularity:Play("watchstep")
		timerRupturingSingularityCD:Start()
	elseif (spellId == 236378 or spellId == 236710 or spellId == 237590 or spellId == 236498) and self:AntiSpam(5, 1) then
		--Assumed for now, reflections happen at same time, so no sense in more than one timer
		timerShadowReflectionCD:Start()--1 timer to rule them all!
	elseif spellId == 238502 and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 239785 then
		warnDemonicObelisk:Show()
		timerDemonicObeliskCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239932 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--timerFelclaws:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnFelclaws:Show(amount)
					voiceFelclaws:Play("stackhigh")
				else
					if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnFelclawsOther:Show(args.destName)
						voiceFelclaws:Play("tauntboss")
					end
				end
			end
		end
	elseif spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			specWarnSRWailing:Show()
			voiceSRWailing:Play("targetyou")
			yellSRWailing:Schedule(4, 3)
			yellSRWailing:Schedule(5, 2)
			yellSRWailing:Schedule(6, 1)
		end
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			specWarnSRErupting:Show()
			voiceSRErupting:Play("targetyou")
			yellSRErupting:Schedule(5, 3)
			yellSRErupting:Schedule(6, 2)
			yellSRErupting:Schedule(7, 1)
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRHopeless:Show()
			voiceSRHopeless:Play("targetyou")
			yellSRHopeless:Schedule(5, 3)
			yellSRHopeless:Schedule(6, 2)
			yellSRHopeless:Schedule(7, 1)
		end
	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRMalignant:Show()
			voiceSRMalignant:Play("targetyou")
			yellSRMalignant:Schedule(5, 3)
			yellSRMalignant:Schedule(6, 2)
			yellSRMalignant:Schedule(7, 1)
		end
	elseif spellId == 236597 then
		if self:CheckInterruptFilter(args.destGUID) then
			specWarnMalignantAnguish:Show(args.destName)
			voiceMalignantAnguish:Play("kickcast")
		end
	elseif spellId == 241721 and args:IsPlayer() then
		timerSightlessGaze:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			yellSRWailing:Cancel()
		end
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			yellSRErupting:Cancel()
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			yellSRHopeless:Cancel()
		end
	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			yellSRMalignant:Cancel()
		end
	elseif spellId == 241721 and args:IsPlayer() then
		timerSightlessGaze:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then--Shadowsoul
		--Uncomment when actual counts are known
--		self.vb.shadowSoulsRemaining = self.vb.shadowSoulsRemaining - 1
--		if self.vb.shadowSoulsRemaining == 0 then
--			self.vb.phase = 3
--			timerDarknessofSoulsCD:Start(1)
--			timerDemonicObeliskCD:Start(1)
--			timerTearRiftCD:Start(1)
--			timerFlamingOrbCD:Start(1)
--		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 242377 then--Kil'jaeden Take Off Sound (intermission 1?)
		--Cancel some timers too
		self.vb.phase = 1.5
		timerFocusedDreadflameCD:Start(1)--If this is wrong trigger this will not work idealy, but if it is, yay!
		timerBurstingDreadflameCD:Start(1)
	elseif spellId == 242902 then--Kil'jaden Intro Conversation (not my typo, blizz spelled their own npc wrong)
	
	elseif spellId == 240910 then--Armageddon. Assuming scripted and not in combat log
		specWarnArmageddon:Show()
		voiceArmageddon:Play("helpsoak")
		timerArmageddonCD:Start()
	elseif spellId == 238430 then--Bursting Dreadflame, likely the projectile script that's not in combat log
		warnBurstingDreadFlame:Show()
		timerBurstingDreadflameCD:Start()
	elseif spellId == 241983 and self.vb.phase < 2.5 then--Deceiver's Veil
		--Cancel some timers too
		self.vb.phase = 2.5
		self.vb.shadowSoulsRemaining = 3--Need real number
	elseif spellId == 239254 and self:AntiSpam(5, 3) then--Flaming Orb (more likely than combat log. this spell looks like it's entirely scripted)
		specWarnFlamingOrbSpawn:Show()
		timerFlamingOrbCD:Start()
	end
end
