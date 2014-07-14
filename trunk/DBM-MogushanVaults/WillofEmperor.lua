local mod	= DBM:NewMod(677, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60399, 60400)--60396 (Rage), 60397 (Strength), 60398 (Courage), 60480 (Titan Spark), 60399 (Qin-xi), 60400 (Jan-xi)
mod:SetEncounterID(1407)
mod:SetZone()
--mod:SetMinSyncRevision(7708)

mod:RegisterCombat("emote", L.Pull)
mod:SetMinCombatTime(25)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 116525 116778 116829",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 target focus",--For this boss we want target/focus and boss1-2
	"UNIT_POWER_FREQUENT boss1 boss2"
)

mod:RegisterEvents(
	"RAID_BOSS_EMOTE"
)

--Rage
local warnRageActivated			= mod:NewCountAnnounce("ej5678", 3, 116525)
local warnFocusedAssault		= mod:NewTargetAnnounce(116525, 2, nil, false)--Completely and totally spammy, this option is just here for those that want this info despite the spam.
--Strength
local warnStrengthActivated		= mod:NewCountAnnounce("ej5677", 3, 116550)
local warnEnergizingSmash		= mod:NewSpellAnnounce(116550, 3, nil, mod:IsMelee())--Also might be spammy
--Courage
local warnCourageActivated		= mod:NewCountAnnounce("ej5676", 3, 116778)
local warnFocusedDefense		= mod:NewTargetAnnounce(116778, 4)
--Jan-xi and Qin-xi
local warnBossesActivatedSoon	= mod:NewPreWarnAnnounce("ej5726", 10, 3, 116815)
local warnBossesActivated		= mod:NewSpellAnnounce("ej5726", 3, 116815)
local warnArcLeft				= mod:NewCountAnnounce(116968, 4, 89570, mod:IsMelee())--This is a pre warn, gives you time to move
local warnArcRight				= mod:NewCountAnnounce(116971, 4, 87219, mod:IsMelee())--This is a pre warn, gives you time to move
local warnArcCenter				= mod:NewCountAnnounce(116972, 4, 74922, mod:IsMelee())--This is a pre warn, gives you time to move
local warnStomp					= mod:NewCountAnnounce(116969, 4, nil, mod:IsMelee())--This is NOT a pre warn, only fires when stomp ends cast. :(
local warnTitanGas				= mod:NewCountAnnounce(116779, 4)

--Rage
local specWarnFocusedAssault	= mod:NewSpecialWarningYou(116525, false)
--Strength
local specWarnStrengthActivated	= mod:NewSpecialWarningSpell("ej5677", mod:IsTank())--These still need to be tanked. so give tanks special warning when these spawn, and dps can enable it too depending on dps strat.
--Courage
local specWarnCourageActivated	= mod:NewSpecialWarningSwitch("ej5676", mod:IsDps())--These really need to die asap. If they reach the tank, you will have a dead tank on hands very soon after.
local specWarnFocusedDefense	= mod:NewSpecialWarningYou(116778)
--Sparks (Heroic Only)
local specWarnFocusedEnergy		= mod:NewSpecialWarningYou(116829)
--Jan-xi and Qin-xi
local specWarnBossesActivated	= mod:NewSpecialWarningSwitch("ej5726", mod:IsTank())
local specWarnCombo				= mod:NewSpecialWarningSpell("ej5672", mod:IsMelee())
local specWarnTitanGas			= mod:NewSpecialWarningSpell(116779, nil, nil, nil, 2)

--Rage
local timerRageActivates		= mod:NewNextCountTimer(30, "ej5678", nil, nil, nil, 116525)
--Strength
local timerStrengthActivates	= mod:NewNextCountTimer(50, "ej5677", nil, nil, nil, 116550)--It's actually 50-55 variation but 50 is good enough.
--Courage
local timerCourageActivates		= mod:NewNextCountTimer(100, "ej5676", nil, nil, nil, 116778)
--Jan-xi and Qin-xi
local timerBossesActivates		= mod:NewNextTimer(107, "ej5726", nil, nil, nil, 116815)--Might be a little funny sounding "Next Jan-xi and Qin-xi" May just localize it later.
local timerTitanGas				= mod:NewBuffActiveTimer(30, 116779)
local timerTitanGasCD			= mod:NewNextCountTimer(150, 116779)

local berserkTimer				= mod:NewBerserkTimer(780)

mod:AddBoolOption("CountOutCombo")
mod:AddBoolOption("InfoFrame", false)
mod:AddBoolOption("ArrowOnCombo", mod:IsTank())--Very accurate for tank, everyone else not so much (tanks always in front, and boss always faces tank, so if he spins around on you, you expect it, melee on other hand have backwards arrows if you spun him around.

--Upvales, don't need variables
local focusedAssault = GetSpellInfo(116525)
local UnitIsUnit, UnitPower, UnitGUID = UnitIsUnit, UnitPower, UnitGUID
--Important, needs recover
mod.vb.comboMob = nil
mod.vb.comboCount = 0
mod.vb.titanGasCast = 0
mod.vb.courageCount = 0
mod.vb.strengthCount = 0
mod.vb.rageCount = 0

local rageTimers = {
	[0] = 15.6,--Varies from heroic vs normal, number here doesn't matter though, we don't start this on pull we start it off first yell (which does always happen).
	[1] = 33,
	[2] = 33,
	[3] = 33,
	[4] = 33,--no idea, maybe this one is just random 33-40, rest are dead on though.
	[5] = 33,
	[6] = 83,
	[7] = 33,
	[8] = 33,
	[9] = 83,
	[10]= 33,
	[11]= 33,
	[12]= 83,
--Rest are all 33
--timers variate slightly so never will be perfect but trying to get as close as possible. seem same in all modes.
}

local function addsDelay(add)
	if add == "Courage" then
		mod.vb.courageCount = mod.vb.courageCount + 1
		warnCourageActivated:Show(mod.vb.courageCount)
		specWarnCourageActivated:Show()
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if mod.vb.courageCount >= 2 then
			timerCourageActivates:Start(150, mod.vb.courageCount+1)
		else
			timerCourageActivates:Start(100, mod.vb.courageCount+1)
		end
	elseif add == "Strength" then
		mod.vb.strengthCount = mod.vb.strengthCount + 1
		warnStrengthActivated:Show(mod.vb.strengthCount)
		specWarnStrengthActivated:Show()
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if mod.vb.strengthCount == 4 or mod.vb.strengthCount == 6 or mod.vb.strengthCount == 8 then--Unverified
			timerStrengthActivates:Start(100, mod.vb.strengthCount+1)
		else
			timerStrengthActivates:Start(50, mod.vb.strengthCount+1)
		end
	elseif add == "Rage" then
		mod.vb.rageCount = mod.vb.rageCount + 1
		warnRageActivated:Show(mod.vb.rageCount)
		--Titan gas delay has funny interaction with these and causes 30 or 60 second delays. Pretty much have to use a table.
		timerRageActivates:Start(rageTimers[mod.vb.rageCount] or 33, mod.vb.rageCount+1)
		mod:Schedule(rageTimers[mod.vb.rageCount] or 33, addsDelay, "Rage")--Because he doesn't always yell, schedule next one here as a failsafe
	elseif add == "Boss" then
		warnBossesActivated:Show()
		specWarnBossesActivated:Show(10)
		if not mod:IsHeroic() then
			timerTitanGasCD:Start(113, 1)
		end
	end
end


function mod:OnCombatStart(delay)
	self.vb.comboMob = nil
	self.vb.comboCount = 0
	self.vb.titanGasCast = 0
	self.vb.rageCount = 0
	self.vb.strengthCount = 0
	self.vb.courageCount = 0
	if self:IsHeroic() then--Heroic trigger is shorter, everything comes about 6 seconds earlier
		timerStrengthActivates:Start(35-delay, 1)
		timerCourageActivates:Start(69-delay, 1)
		timerBossesActivates:Start(101-delay)
	else
		timerStrengthActivates:Start(42-delay, 1)
		timerCourageActivates:Start(75-delay, 1)
		timerBossesActivates:Start(-delay)
	end
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(focusedAssault)
		DBM.InfoFrame:Show(10, "playerbaddebuff", 116525)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnCombo then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 116525 then
		warnFocusedAssault:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedAssault:Show()
		end
	elseif spellId == 116778 then
		warnFocusedDefense:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedDefense:Show()
		end
	elseif spellId == 116829 then
--		warnFocusedEnergy:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedEnergy:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Rage or msg:find(L.Rage) then--Apparently boss only yells sometimes, so this isn't completely reliable
		self:Unschedule(addsDelay, "Rage")--Unschedule any failsafes that triggered and resync to yell
		self:Schedule(14, addsDelay, "Rage")
		timerRageActivates:Start(14, self.vb.rageCount+1)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Strength or msg:find(L.Strength) then
		self:Unschedule(addsDelay, "Strength")
		self:Schedule(9, addsDelay, "Strength")
	elseif msg == L.Courage or msg:find(L.Courage) then
		self:Unschedule(addsDelay, "Courage")
		self:Schedule(10, addsDelay, "Courage")
	elseif msg == L.Boss or msg:find(L.Boss) then
		warnBossesActivatedSoon:Show()
		self:Schedule(10, addsDelay, "Boss")
	elseif msg:find("spell:116779") then
		if self:IsHeroic() then--On heroic the boss activates this perminantly on pull and it's always present
			if not self:IsInCombat() then
				DBM:StartCombat(self, 0)
			end
		else--Normal/LFR
			self.vb.titanGasCast = self.vb.titanGasCast + 1
			warnTitanGas:Show(self.vb.titanGasCast)
			specWarnTitanGas:Show()
			if self.vb.titanGasCast < 4 then -- after Titan Gas casted 4 times, Titan Gas lasts permanently. (soft enrage)
				timerTitanGas:Start()
				timerTitanGasCD:Start(150, self.vb.titanGasCast+1)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 116556 then
		warnEnergizingSmash:Show()
	end
	--Melee that wasn't targeting boss when it started, but is targeting boss now so activate warnings immediately.
	--It's safe to assume MELEE are on boss, they are in range of attacks
	if not self.vb.comboMob and self:IsMelee() and (UnitIsUnit(uId, "boss1") or UnitIsUnit(uId, "boss2")) then
		self.vb.comboMob = UnitGUID(uId)
	end
	if (self.vb.comboMob or "") == UnitGUID(uId) then
		if spellId == 116968 then--Arc Left
			self.vb.comboCount = self.vb.comboCount + 1
			if self.Options.CountOutCombo and self.vb.comboCount < 11 then
				DBM:PlayCountSound(self.vb.comboCount)
			end
			warnArcLeft:Show(self.vb.comboCount)
			if self.Options.ArrowOnCombo then
				if self:IsTank() then--Assume tank is in front of the boss
					DBM.Arrow:ShowStatic(90, 3)
				else--Assume anyone else is behind the boss
					DBM.Arrow:ShowStatic(270, 3)
				end
			end
		elseif spellId == 116971 then--Arc Right
			self.vb.comboCount = self.vb.comboCount + 1
			if self.Options.CountOutCombo and self.vb.comboCount < 11 then
				DBM:PlayCountSound(self.vb.comboCount)
			end
			warnArcRight:Show(self.vb.comboCount)
			if self.Options.ArrowOnCombo then
				if self:IsTank() then--Assume tank is in front of the boss
					DBM.Arrow:ShowStatic(270, 3)
				else--Assume anyone else is behind the boss
					DBM.Arrow:ShowStatic(90, 3)
				end
			end
		elseif spellId == 116972 then--Arc Center
			self.vb.comboCount = self.vb.comboCount + 1
			if self.Options.CountOutCombo and self.vb.comboCount < 11 then
				DBM:PlayCountSound(self.vb.comboCount)
			end
			warnArcCenter:Show(self.vb.comboCount)
			if self.Options.ArrowOnCombo then
				if self:IsTank() then--Assume tank is in front of the boss
					DBM.Arrow:ShowStatic(0, 3)
				end
			end
		elseif spellId == 116969 or spellId == 132425 then--Stomp
			self.vb.comboCount = self.vb.comboCount + 1
			if self.Options.CountOutCombo and self.vb.comboCount < 11 then
				DBM:PlayCountSound(self.vb.comboCount)
			end
			warnStomp:Show(self.vb.comboCount)
		end
		if self.vb.comboCount == (self:IsHeroic() and 10 or 5) then
			self.vb.comboMob = nil
			self.vb.comboCount = 0
		end
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	if (uId == "target" or uId == "targettarget") and not UnitIsFriend(uId, "player") and not self.vb.comboMob then
		local powerLevel = UnitPower(uId)
		if powerLevel >= 18 then--Give more than 1 second to find comboMob
			self.vb.comboMob = UnitGUID(uId)
			if powerLevel == 18 then
				specWarnCombo:Show()
			end
		end
	--split because we want to prefer target over focus. IE I focus other boss while targeting one i'm tanking. previous method bugged out and gave me combo warnings for my focus and NOT my target
	--Now target should come first and focus should be af allback IF not targeting a boss.
	elseif (uId == "focus") and not UnitIsFriend(uId, "player") and not self.vb.comboMob then
		local powerLevel = UnitPower(uId)
		if powerLevel >= 18 then
			self.vb.comboMob = UnitGUID(uId)
			if powerLevel == 18 then
				specWarnCombo:Show()
			end
		end
	end
end
