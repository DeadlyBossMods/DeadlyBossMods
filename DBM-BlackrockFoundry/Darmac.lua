local mod	= DBM:NewMod(1122, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76865)--No need to add beasts to this. It's always main boss that's engaged first and dies last.
mod:SetEncounterID(1694)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(12975)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155198 159043 159045",
	"SPELL_CAST_SUCCESS 155247 155399 154975",
	"SPELL_AURA_APPLIED 154960 155458 155459 155460 154981 155030 155236 155462 163247",
	"SPELL_AURA_APPLIED_DOSE 155030 155236",
	"SPELL_AURA_REMOVED 154960",
	"SPELL_PERIODIC_DAMAGE 159044 162277 156824 155657",
	"SPELL_ABSORBED 159044 162277 156824 155657",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Because boss numbering tends to get out of wack with things constantly joining/leaving fight. I've only seen boss1 and boss2 but for good measure.
)

--TODO, see if call pack beasts change on normal affects LFR too. I'm assuming it does because they tend to stay synced.
--TODO, see if above change also has any effect on FIRST cast and update "updatebeasttimers" functions accordingly if it does
--Boss basic attacks
local warnPinDownTargets			= mod:NewTargetAnnounce(154960, 3)
--Boss gained abilities (beast deaths grant boss new abilities)
local warnMount						= mod:NewTargetAnnounce(29769, 1)
local warnWolf						= mod:NewTargetAnnounce(155458, 1)--Grants Rend and Tear
local warnRylak						= mod:NewTargetAnnounce(155459, 1)--Grants Superheated Shrapnel
local warnElekk						= mod:NewTargetAnnounce(155460, 1)--Grants Tantrum
local warnClefthoof					= mod:NewTargetAnnounce(155462, 1)--Grants Epicenter
--Beast abilities (living beasts)
local warnSearingFangs				= mod:NewStackAnnounce(155030, 2, nil, "Tank")
local warnInfernoBreath				= mod:NewTargetAnnounce(154989, 4)
local warnCrushArmor				= mod:NewStackAnnounce(155236, 2, nil, "Tank")
local warnStampede					= mod:NewSpellAnnounce(155247, 3)

--Boss basic attacks
local specWarnCallthePack			= mod:NewSpecialWarningSwitch("OptionVersion2", 154975, "Tank", nil, nil, nil, nil, 2)
local specWarnPinDown				= mod:NewSpecialWarningSpell("OptionVersion2", 154960, "Ranged", nil, nil, nil, 2, nil, 2)
local yellPinDown					= mod:NewYell(154960)
--Boss gained abilities (beast deaths grant boss new abilities)
local specWarnRendandTear			= mod:NewSpecialWarningMove(155385, "Melee", nil, nil, nil, nil, 2)--Always returns to melee (tank)
local specWarnSuperheatedShrapnel	= mod:NewSpecialWarningSpell(155499, nil, nil, nil, 2)--Still iffy on it
local specWarnFlameInfusion			= mod:NewSpecialWarningMove(155657)
local specWarnTantrum				= mod:NewSpecialWarningCount(162275, nil, nil, nil, 2, nil, 2)
local specWarnEpicenter				= mod:NewSpecialWarningMove(159043)
--Beast abilities (living)
local specWarnSavageHowl			= mod:NewSpecialWarningTarget(155198, "Tank|Healer")
local specWarnSavageHowlDispel		= mod:NewSpecialWarningDispel("OptionVersion2", 155198, "RemoveEnrage", nil, nil, nil, nil, 2)
local specWarnConflag				= mod:NewSpecialWarningDispel(162277, false)--Just too buggy, cast 3 targets, but can be as high as 5 seconds apart, making warning very spammy. Therefor, MUST stay off by default to reduce DBM spam :\
local specWarnSearingFangs			= mod:NewSpecialWarningStack(155030, nil, 12)--Stack count assumed, may be 2
local specWarnSearingFangsOther		= mod:NewSpecialWarningTaunt(155030)--No evidence of this existing ANYWHERE in any logs. removed? Bugged?
local specWarnInfernoPyre			= mod:NewSpecialWarningMove(156824)
local specWarnCrushArmor			= mod:NewSpecialWarningStack(155236, nil, 3)--6-9 second cd, 15 second duration, 3 is smallest safe swap, sometimes 2 when favorable RNG
local specWarnCrushArmorOther		= mod:NewSpecialWarningTaunt(155236)
local specWarnInfernoBreath			= mod:NewSpecialWarningSpell(154989, nil, nil, nil, 2, nil, 2)
local yellInfernoBreath				= mod:NewYell(154989)

--Boss basic attacks
mod:AddTimerLine(CORE_ABILITIES)--Core Abilities
local timerPinDownCD				= mod:NewCDTimer("OptionVersion2", 20.5, 155365, nil, "Ranged")--Every 20 seconds unless delayed by other things. CD timer used for this reason
local timerCallthePackCD			= mod:NewCDTimer("OptionVersion2", 31.5, 154975, nil, "Tank")--almost always 31, but cd resets to 11 whenever boss dismounts a beast (causing some calls to be less or greater than 31 seconds apart. In rare cases, boss still interrupts his own cast/delays cast even when not caused by gaining beast buff
--Boss gained abilities (beast deaths grant boss new abilities)
mod:AddTimerLine(SPELL_BUCKET_ABILITIES_UNLOCKED)--Abilities Unlocked
local timerRendandTearCD			= mod:NewCDTimer(12, 155385)
local timerSuperheatedShrapnelCD	= mod:NewCDTimer(15, 155499)--15-30sec variation observed.
local timerTantrumCD				= mod:NewNextCountTimer(30, 162275)--No varation, ever. Always highest priority spell and always a next timer, now that all the update code is working 100%
local timerEpicenterCD				= mod:NewCDCountTimer(20, 159043, nil, "Melee")
--Beast abilities (living)
mod:AddTimerLine(BATTLE_PET_DAMAGE_NAME_8)--Beast
local timerSavageHowlCD				= mod:NewCDTimer("OptionVersion2", 25, 155198, nil, "Healer|Tank|RemoveEnrage")
local timerConflagCD				= mod:NewCDTimer("OptionVersion2", 20, 155399, nil, "Healer")
local timerStampedeCD				= mod:NewCDTimer(20, 155247)--20-30 as usual
local timerInfernoBreathCD			= mod:NewNextTimer(20.5, 154989)

local berserkTimer					= mod:NewBerserkTimer(720)

local countdownPinDown				= mod:NewCountdown(20.5, 154960, "Ranged")
local countdownCallPack				= mod:NewCountdown("Alt31", 154975, "Tank")
local countdownEpicenter			= mod:NewCountdown("AltTwo20", 159043, "Melee")

local voiceCallthePack				= mod:NewVoice("OptionVersion2", 154975, "Tank") --killmob
local voiceSavageHowl				= mod:NewVoice(155198, "RemoveEnrage") --trannow
local voicePinDown					= mod:NewVoice(154960, "Ranged") --helpme
local voiceInfernoBreath			= mod:NewVoice(154989) --breathsoon
local voiceRendandTear				= mod:NewVoice(155385, "Melee")  --runaway
local voiceCrushArmor				= mod:NewVoice(155236) --changemt
local voiceTantrum					= mod:NewVoice(162275) --aesoon


mod:AddRangeFrameOption("8/7/3", nil, "-Melee")
mod:AddSetIconOption("SetIconOnSpear", 154960)--Not often I make icon options on by default but this one is universally important. YOu always break players out of spear, in any strat.

mod.vb.RylakAbilities = false
mod.vb.WolfAbilities = false
mod.vb.ElekkAbilities = false
mod.vb.FaultlineAbilites= false
mod.vb.tantrumCount = 0
mod.vb.epicenterCount = 0
local activeBossGUIDS = {}

local function updateBeasts(cid, status, beastName)
	if DBM.BossHealth:IsShown() then
		if status == 3 then--Add Boss, keep Beast
			DBM.BossHealth:AddBoss(76865, L.name)
		elseif status == 2 then--Just Remove Beast
			DBM.BossHealth:RemoveBoss(cid, beastName)
		elseif status == 1 then--Add beast, remove boss
			DBM.BossHealth:RemoveBoss(76865)
			DBM.BossHealth:AddBoss(cid, beastName)
		else--Status 0, remove beast add boss
			DBM.BossHealth:RemoveBoss(cid)
			DBM.BossHealth:AddBoss(76865, L.name)
		end
	end
end

local function updateBeastTimers(self, all, spellId, adjust)
	local dismountAdjust = 0--default of 0, so -0 doesn't affect timers unless mythic and UNIT_TARGETABLE is trigger
	if adjust then dismountAdjust = 2 end--Dismount event is a little slow, fires 2 seconds after true dismount, so must adjust all timers for dismounts
	if self.vb.WolfAbilities and (self:IsMythic() and spellId == 155458 or all) then--Cruelfang
		if self.vb.RylakAbilities then--If he also has rylak abilities, first rend and tear is 12 seconds, not 6
			timerRendandTearCD:Start(12-dismountAdjust)
		else
			timerRendandTearCD:Start(6-dismountAdjust)
		end
	end
	if self.vb.RylakAbilities and (self:IsMythic() and spellId == 155459 or all) then--Dreadwing
		timerSuperheatedShrapnelCD:Start(9-dismountAdjust)
	end
	if self.vb.ElekkAbilities and (self:IsMythic() and spellId == 163247 or all) then--Ironcrusher
		if self.vb.RylakAbilities then--Only verified with all 3 on normal. Unknown of JUST elekk and rylak cuase +1 second without wolf
			timerTantrumCD:Start(18-dismountAdjust, self.vb.tantrumCount+1)
		else--Verified true for elekk alone, and elekk with wolf
			timerTantrumCD:Start(17-dismountAdjust, self.vb.tantrumCount+1)
		end
	end
	if self.vb.FaultlineAbilites and (self:IsMythic() and spellId == 155462 or all) then--Faultline
		timerEpicenterCD:Start(24, self.vb.epicenterCount+1)
		countdownEpicenter:Start(24)
	end
	--Base ability Timers are reset any time boss gains new abilites. Timers are next timers but vary depending on what abilities boss possesses
	if adjust then return end--adjust true means triggered by boss dismounted on mythic, this doesn't reset pin down or call of the pack
	if self.vb.RylakAbilities then--Rylak delays call of the pack and pin down as well. (Well, that or whatever beast you do 3rd. Still need to determine if rylak, or third beast)
		if self.vb.ElekkAbilities and self.vb.WolfAbilities then--Wolf, elekk AND rylak
			timerCallthePackCD:Start(17)
			countdownCallPack:Cancel()
			countdownCallPack:Start(17)
			timerPinDownCD:Start(24)
			countdownPinDown:Cancel()
			countdownPinDown:Start(24)
		else--TODO, i need data on rylak with wolf (2) or rylak with elekk (2).
			timerCallthePackCD:Start(15)--rylak alone verified 15 seconds
			countdownCallPack:Cancel()
			countdownCallPack:Start(15)
			timerPinDownCD:Start(13.5)
			countdownPinDown:Cancel()
			countdownPinDown:Start(13.5)
		end
	else--Elekk alone verified, wolf alone verified. Wolf AND Elekk together verified. These timers only alter once rylak abilities activated.
		timerCallthePackCD:Start(11)
		countdownCallPack:Cancel()
		countdownCallPack:Start(11)
		timerPinDownCD:Start(12)
		countdownPinDown:Cancel()
		countdownPinDown:Start(12)
	end
end

function mod:BreathTarget(targetname, uId)
	if not targetname then return end
	warnInfernoBreath:Show(targetname)
	if targetname == UnitName("player") then
		yellInfernoBreath:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.RylakAbilities = false
	self.vb.WolfAbilities = false
	self.vb.ElekkAbilities = false
	self.vb.FaultlineAbilites = false
	self.vb.tantrumCount = 0
	table.wipe(activeBossGUIDS)
	timerCallthePackCD:Start(9.5-delay)--Time for cast finish, not cast start, because only cast finish is sure thing. cast start can be interrupted
	countdownCallPack:Start(9.5-delay)
	timerPinDownCD:Start(11-delay)
	countdownPinDown:Start(11-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3)
	end
	berserkTimer:Start(-delay)--Verified 12 min normal and heroic.
	if self:IsMythic() then
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155198 then
		if self.Options.SpecWarn155198dispel2 then
			specWarnSavageHowlDispel:Schedule(1.5, args.sourceName)
		else
			specWarnSavageHowl:Schedule(1.5, args.sourceName)
		end
		timerSavageHowlCD:Start()
		voiceSavageHowl:Play("trannow")
	elseif spellId == 159043 or spellId == 159045 then--Beast version/Boss version
		self.vb.epicenterCount = self.vb.epicenterCount + 1
		if self:IsMelee() and self:AntiSpam(3, 2) then
			specWarnEpicenter:Show()--Warn melee during cast to move outa head of time.
		end
		timerEpicenterCD:Start(nil, self.vb.epicenterCount+1)
		countdownEpicenter:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155247 then
		warnStampede:Show()
		timerStampedeCD:Start()
	elseif spellId == 155399 then
		timerConflagCD:Start()
	elseif spellId == 154975 then--Moved to success because spell cast start is interrupted, a lot, and no sense in announcing it if he didn't finish it. if he self interrupts it can be delayed as much as 15 seconds.
		if self:IsTank() then
			specWarnCallthePack:Show()
			voiceCallthePack:Play("killmob")
		else
			specWarnCallthePack:Schedule(5)--They come out very slow and staggered, allow 5 seconds for tank to pick up then call switch for everyone else
			voiceCallthePack:Schedule(5, "killmob")
		end
		if self:IsDifficulty("normal", "lfr") then
			timerCallthePackCD:Start(41.5)--40+1.5
			countdownCallPack:Start(41.5)	
		else
			timerCallthePackCD:Start()--30+1.5
			countdownCallPack:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 154960 then
		warnPinDownTargets:CombinedShow(0.5, args.destName)
		if self.Options.SetIconOnSpear then
			self:SetSortedIcon(1, args.destName, 8, nil, true)
		end
		if args:IsPlayer() then
			yellPinDown:Yell()
		else
			voicePinDown:Cancel()
			voicePinDown:Schedule(0.5, "helpme")
		end
	elseif spellId == 154981 and self:CheckDispelFilter() then
		specWarnConflag:CombinedShow(2, args.destName)
	elseif spellId == 155030 then
		local amount = args.amount or 1
		if amount % 3 == 0 and amount >= 12 then--Stack assumed, may need revising
			warnSearingFangs:Show(args.destName, amount)
			if amount >= 12 then
				if args:IsPlayer() then
					specWarnSearingFangs:Show(amount)
				else
					if not UnitDebuff("player", GetSpellInfo(155030)) and not UnitIsDeadOrGhost("player") then
						specWarnSearingFangsOther:Show(args.destName)
					end
				end
			end
		end
	elseif spellId == 155236 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		if amount >= 3 and args:IsPlayer() then
			specWarnCrushArmor:Show(amount)
		elseif amount >= 2 and not args:IsPlayer() then--Swap at 2 WHEN POSSIBLE but 50/50 you have to go to 3.
			if not UnitDebuff("player", GetSpellInfo(155236)) and not UnitIsDeadOrGhost("player") then
				specWarnCrushArmorOther:Show(args.destName)
			end
			voiceCrushArmor:Play("changemt")
		end
	elseif args:IsSpellID(155458, 155459, 155460, 155462, 163247) then
		DBM:Debug("SPELL_AURA_APPLIED, Boss absorbing beast abilities", 2)
		if spellId == 155458 then--Wolf Aura
			self.vb.WolfAbilities = true
			warnWolf:Show(args.destName)
		elseif spellId == 155459 then--Rylak Aura
			self.vb.RylakAbilities = true
			warnRylak:Show(args.destName)
		elseif spellId == 155460 or spellId == 163247 then--Elekk Aura (two spellids because mythic has diff Id)
			self.vb.ElekkAbilities = true
			warnElekk:Show(args.destName)
		elseif spellId == 155462 then--Mythic Beast
			self.vb.FaultlineAbilites = true
			warnClefthoof:Show(args.destName)
		end
		--Seems changed on mythic, ALL beast timers reset now in all modes, period.
		--Leaving old code in case 6.1 changes it back. Most recent 6.1 tests showed boss only update gained spellid
--		if not self:IsMythic() then--Not mythic, boss gaining ability means he just dismounted, start/update all timers.
			updateBeastTimers(self, true)
--		else--On mythic, boss already on ground already casting other things, so only update timers for new ability he just gained.
--			updateBeastTimers(self, false, spellId)
--		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
local spellId = args.spellId
	if spellId == 154960 and self.Options.SetIconOnSpear then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 159044 or spellId == 162277) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnEpicenter:Show()
	elseif spellId == 156824 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnInfernoPyre:Show()
	elseif spellId == 155657 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnFlameInfusion:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 76884 or cid == 76874 or cid == 76945 or cid == 76946 then
				DBM:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT, Boss mounting", 2)
				local name = UnitName(unitID)
				updateBeasts(cid, 1, name)
				warnMount:Show(name)
				if cid == 76884 then--Cruelfang
					timerRendandTearCD:Start(5)
					timerSavageHowlCD:Start(15)
					if self.Options.RangeFrame and not self.vb.RylakAbilities then
						DBM.RangeCheck:Show(7)--Upgrade range frame to 7 now that he has rend and tear.
					end
					--Cancel timers for abilities he can't use from other dead beasts
					timerSuperheatedShrapnelCD:Cancel()
					timerTantrumCD:Cancel()
				elseif cid == 76874 then--Dreadwing
					timerInfernoBreathCD:Start(6)
					timerConflagCD:Start(12)
					if self.Options.RangeFrame then
						DBM.RangeCheck:Show(8)--Update range frame to 8 for Scrapnal. TODO, again, see if melee affected by this or not
					end
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerTantrumCD:Cancel()
				elseif cid == 76945 then--Ironcrusher
					timerStampedeCD:Start(15)
					timerTantrumCD:Start(25, self.vb.tantrumCount+1)
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerSuperheatedShrapnelCD:Cancel()
				elseif cid == 76946 then--Faultline
					self.vb.epicenterCount = 0
					self:UnregisterShortTermEvents()--UNIT_TARGETABLE_CHANGED no longer used, and in fact unregistered to prevent bug with how it fires when faultline dies
					timerEpicenterCD:Start(10, 1)
					countdownEpicenter:Start(10)
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerSuperheatedShrapnelCD:Cancel()
					timerTantrumCD:Cancel()
				end
			end
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if (cid == 76865) and UnitExists(uId) and self:IsMythic() then--Boss dismounting living beast on mythic
		DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Dismounting", 2)
		updateBeasts(cid, 3)
		updateBeastTimers(self, true, nil, true)
	end
end	


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76884 or cid == 76874 or cid == 76945 or cid == 76946 then--Beasts
		--Split timer cancels up by CID. if for SOME REASON someone is stupid enough to have two beasts at once on mythic
		--when one dies, don't want to cancel wrong timers
		if cid == 76884 then
			timerSavageHowlCD:Cancel()
		elseif cid == 76874 then
			timerConflagCD:Cancel()
			timerInfernoBreathCD:Cancel()
		elseif cid == 76945 then
			timerStampedeCD:Cancel()
		elseif cid == 76946 then
			timerEpicenterCD:Cancel()
			countdownEpicenter:Cancel()
		end
		if self:IsMythic() then
			updateBeasts(cid, 2)
		else
			updateBeasts(cid, 0)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:154989") then
		--self:BossTargetScanner(76874, "BreathTarget", 0.1, 25, nil, nil, false)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 155221 then--IronCrusher Tantrum
		self.vb.tantrumCount = self.vb.tantrumCount + 1
		specWarnTantrum:Show(self.vb.tantrumCount)
		timerTantrumCD:Start(nil, self.vb.tantrumCount+1)
		voiceTantrum:Play("aesoon")
	elseif spellId == 155520 then--Beastlord Darmac Tantrum
		self.vb.tantrumCount = self.vb.tantrumCount + 1
		specWarnTantrum:Show(self.vb.tantrumCount)
		timerTantrumCD:Start(34, self.vb.tantrumCount+1)--This one may also be 30 seconds, but I saw 34 consistently
		voiceTantrum:Play("aesoon")
	elseif spellId == 155497 then--Superheated Shrapnel
		specWarnSuperheatedShrapnel:Show()
		timerSuperheatedShrapnelCD:Start()
	elseif spellId == 155385 or spellId == 155515 then--Both versions of spell(boss and beast), they seem to have same cooldown so combining is fine
		specWarnRendandTear:Show()
		timerRendandTearCD:Start()
		voiceRendandTear:Play("runaway")
	elseif spellId == 155365 then--Cast
		specWarnPinDown:Show()
		timerPinDownCD:Start()
		countdownPinDown:Start()
	elseif spellId == 155423 then--Face Random Non-Tank
		specWarnInfernoBreath:Show()
		timerInfernoBreathCD:Start()
		voiceInfernoBreath:Play("breathsoon")
		self:BossTargetScanner(76874, "BreathTarget", 0.1, 25, nil, nil, false)
		DBM:Debug("TESTING THINGS!: "..UnitName(uId.."target"))
	end
end
