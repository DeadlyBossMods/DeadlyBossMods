local mod	= DBM:NewMod(687, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60701, 60708, 60709, 60710)--Adds: 60731 Undying Shadow, 60958 Pinning Arrow
mod:SetModelID(41813)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
	    		 or select(2, UnitClass("player")) == "PRIEST"
	    		 or select(2, UnitClass("player")) == "SHAMAN"

--on heroic 2 will be up at same time, so most announces are "target" type for source distinction.
--Unless it's a spell that doesn't directly affect the boss (ie summoning an add isn't applied to boss, it's a new mob).
--Zian
local warnChargedShadows		= mod:NewTargetAnnounce(117685, 2)
local warnUndyingShadows		= mod:NewSpellAnnounce(117506, 3)--Target scanning?
local warnFixate				= mod:NewTargetAnnounce(118303, 4)--Maybe spammy late fight, if zian is first boss you get? (adds are immortal, could be many up)
local warnShieldOfDarkness		= mod:NewTargetAnnounce(117697, 4)
--Meng
local warnCrazyThought			= mod:NewCastAnnounce(117833, 2, nil, false)--Just doesn't seem all that important right now.
local warnMaddeningShout		= mod:NewSpellAnnounce(117708, 4)
local warnCrazed				= mod:NewTargetAnnounce(117737, 3)--Basically stance change
local warnCowardice				= mod:NewTargetAnnounce(117756, 3)--^^
local warnDelirious				= mod:NewTargetAnnounce(117837, 3, nil, mod:CanRemoveEnrage())--Heroic Ability
--Qiang
local warnAnnihilate			= mod:NewCastAnnounce(117948, 4)
local warnFlankingOrders		= mod:NewSpellAnnounce(117910, 4)
local warnImperviousShield		= mod:NewTargetAnnounce(117961, 3)--Heroic Ability
--Subetai
local warnVolley				= mod:NewSpellAnnounce(118094, 3)--118088 trigger ID, but we use the other ID cause it has a tooltip/icon
local warnPinnedDown			= mod:NewTargetAnnounce(118135, 4)--We warn for this one since it's more informative then warning for just Rain of Arrows
local warnPillage				= mod:NewTargetAnnounce(118047, 3)
local warnSleightOfHand			= mod:NewTargetAnnounce(118162, 4)--Heroic Ability
--All
local warnActivated				= mod:NewTargetAnnounce(118212, 3, 78740)

--Zian
local specWarnUndyingShadow		= mod:NewSpecialWarningSwitch("ej5854", mod:IsDps())
local specWarnFixate			= mod:NewSpecialWarningYou(118303)
local yellFixate				= mod:NewYell(118303)
local specWarnShieldOfDarkness	= mod:NewSpecialWarningTarget(117697, nil, nil, nil, true)--Heroic Ability
local specWarnShieldOfDarknessD	= mod:NewSpecialWarningDispel(117697, isDispeller)--Heroic Ability
--Meng
local specWarnMaddeningShout	= mod:NewSpecialWarningSpell(117708, nil, nil, nil, true)
local specWarnCrazyThought		= mod:NewSpecialWarningInterrupt(117833, mod:IsTank())--At very least tank should be able to do this, probably on their own.
local specWarnDelirious			= mod:NewSpecialWarningDispel(117837, mod:CanRemoveEnrage())--Heroic Ability
--Qiang
local specWarnAnnihilate		= mod:NewSpecialWarningSpell(117948)--Maybe tweak options later or add a bool for it, cause on heroic, it's not likely ranged will be in front of Qiang if Zian or Subetai are up.
local specWarnFlankingOrders	= mod:NewSpecialWarningSpell(117910, nil, nil, nil, true)
local specWarnImperviousShield	= mod:NewSpecialWarningTarget(117961)--Heroic Ability
--Subetai
local specWarnPinningArrow		= mod:NewSpecialWarningSwitch("ej5861", mod:IsDps())
local specWarnPillage			= mod:NewSpecialWarningMove(118047)--Works as both a You and near warning
local specWarnSleightOfHand		= mod:NewSpecialWarningTarget(118162)--Heroic Ability

--Zian
local timerChargingShadowsCD	= mod:NewCDTimer(12, 117685)
local timerUndyingShadowsCD		= mod:NewCDTimer(45.5, 117506)
local timerFixate			  	= mod:NewTargetTimer(20, 118303)
local timerCoalescingShadowsCD	= mod:NewNextTimer(60, 117539)--EJ says 30sec but logs more recent then last EJ update show 60 seconds on heroic (so probably adjusted since EJ was last revised)
local timerShieldOfDarknessCD  	= mod:NewCDTimer(42.5, 117697)
--Meng
local timerMaddeningShoutCD		= mod:NewCDTimer(50, 117708)--Most of his other stuff is just energy based, this is only ability i could find that actually was a CD
local timerDeliriousCD			= mod:NewCDTimer(20.5, 117837, nil, mod:CanRemoveEnrage())
--Qiang
local timerAnnihilateCD			= mod:NewCDTimer(40, 117948)
local timerFlankingOrdersCD		= mod:NewCDTimer(40, 117910)
local timerImperviousShieldCD	= mod:NewCDTimer(40, 117961)
--Subetai
local timerVolleyCD				= mod:NewCDTimer(41.5, 118094)--Pretty much all his stuff is 40-42 sec CD
local timerRainOfArrowsCD		= mod:NewCDTimer(41, 118122)
local timerPillageCD			= mod:NewCDTimer(40.5, 118047)
local timerSleightOfHandCD		= mod:NewCDTimer(42, 118162)
local timerSleightOfHand		= mod:NewBuffActiveTimer(11, 118162)--2+9 (cast+duration)

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For multiple abilities. the abiliies don't seem to target melee (unless a ranged is too close or a melee is too far.)

--cannot be used all of these yet, some do NOT match the yells right now
local Zian = EJ_GetSectionInfo(5852)--Only boss who's EJ entry matches his yell name.
--local Meng = EJ_GetSectionInfo(5835)
--local Qiang = EJ_GetSectionInfo(5841)
--local Subetai = EJ_GetSectionInfo(5846)
local bossesActivated = {}

function mod:OnCombatStart(delay)
	table.wipe(bossesActivated)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(117539) then
		timerCoalescingShadowsCD:Start(args.destGUID)--Basically, the rez timer for a defeated Undying Shadow that is going to re-animate in 60 seconds.
	elseif args:IsSpellID(117837) then
		warnDelirious:Show(args.destName)
		specWarnDelirious:Show(args.destName)
		timerDeliriousCD:Start()
	elseif args:IsSpellID(117756) then
		warnCowardice:Show(args.destName)
	elseif args:IsSpellID(117737) then
		warnCrazed:Show(args.destName)
	elseif args:IsSpellID(117697) then
		specWarnShieldOfDarknessD:Show(args.destName)
	elseif args:IsSpellID(118303) then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118303) then
		timerFixate:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(117685) then
		warnChargedShadows:Show(args.destName)
		timerChargingShadowsCD:Start()
	elseif args:IsSpellID(117506) then
		warnUndyingShadows:Show()
		timerUndyingShadowsCD:Start()
	elseif args:IsSpellID(117910) then
		warnFlankingOrders:Show()
		specWarnFlankingOrders:Show()
--		timerFlankingOrdersCD:Start()--Not yet known
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(118162) then
		warnSleightOfHand:Show(args.sourceName)
		specWarnSleightOfHand:Show(args.sourceName)
		timerSleightOfHand:Start()
		timerSleightOfHandCD:Start()
	elseif args:IsSpellID(117506) then
		warnUndyingShadows:Show()
		timerUndyingShadowsCD:Start()
	elseif args:IsSpellID(117697) then
		warnShieldOfDarkness:Show(args.sourceName)
		specWarnShieldOfDarkness:Show(args.sourceName)
		timerShieldOfDarknessCD:Start()
	elseif args:IsSpellID(117833) then
		warnCrazyThought:Show()
		specWarnCrazyThought:Show(args.sourceName)
	elseif args:IsSpellID(117708) then
		warnMaddeningShout:Show()
		specWarnMaddeningShout:Show()
		timerMaddeningShoutCD:Start()
	elseif args:IsSpellID(117948) then
		warnAnnihilate:Show()
		specWarnAnnihilate:Show()
		timerAnnihilateCD:Start()
	elseif args:IsSpellID(117961) then
		warnImperviousShield:Show(args.sourceName)
		specWarnImperviousShield:Show(args.sourceName)
--		timerImperviousShieldCD:Start()--Not yet known
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 118088 and self:AntiSpam(2, 1) then--Volley
		warnVolley:Show()
		timerVolleyCD:Start()
	elseif spellId == 118121 and self:AntiSpam(2, 2) then--Rain of Arrows
		timerRainOfArrowsCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.Pillage) then
		timerPillageCD:Start()
		if target then
			warnPillage:Show(target)
			if target == UnitName("player") then
				specWarnPillage:Show()
				local uId = DBM:GetRaidUnitId(target)
				if uId then
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					local inRange = DBM.RangeCheck:GetDistance("player", x, y)
					if inRange and inRange < 9 then
						specWarnPillage:Show()
					end
				end
			end
		end
	end
end

--Phase change controller. Even for pull.
--This is better then localizing their yells because each boss has 2 or 3 pull yells.
--Besides, if they ever get the dang EJ to match the game, we won't even need to localize boss names even.
function mod:CHAT_MSG_MONSTER_YELL(msg, boss)
	if not self:IsInCombat() or bossesActivated[boss] then return end--Ignore yells out of combat or from bosses we already activated.
	if not bossesActivated[boss] then bossesActivated[boss] = true end--Once we activate off bosses first yell, add them to ignore.
	if boss == Zian then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerChargingShadowsCD:Start(14.2)
			timerUndyingShadowsCD:Start(20.2)
			timerShieldOfDarknessCD:Start(40)
		else
			--Needs to be added later
		end
	elseif boss == L.Meng then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerMaddeningShoutCD:Start(20.5)
			timerDeliriousCD:Start()
		else
			--Needs to be added later
		end
	elseif boss == L.Qiang then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerAnnihilateCD:Start(10.5)
			timerFlankingOrdersCD:Start(25)
			timerImperviousShieldCD:Start(40.7)
		else
			--Needs to be added later
		end
	elseif boss == L.Subetai then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerVolleyCD:Start(5.7)
			timerRainOfArrowsCD:Start(15.3)
			timerPillageCD:Start(25.8)
			timerSleightOfHandCD:Start(40.7)
		else
			--Needs to be added later
		end
	end
end

--of note, this is completely and totally WRONG. I have NO IDEA how they defeat since we coudln't defeat any of them on heroic, and i never got to test normal (or get worth a crap logs for it either).
--point being, this is a template only and not even remotely functional, no timer cancelation will work since the only time they die is when you defeat ALL 4.
--I'll need a transcriptor log that actually has real transitions in it to figure out how they actually phase out (ie become inactive but not dead).
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 60701 then--Zian
		--This boss retains Undying Shadows
		timerChargingShadowsCD:Cancel()
		timerShieldOfDarknessCD:Cancel()
	elseif cid == 60708 then--Meng
		--This boss retains Maddening Shout
		timerDeliriousCD:Cancel()
	elseif cid == 60709 then--Qiang
		--This boss retains Flanking Orders
		timerAnnihilateCD:Cancel()
		timerImperviousShieldCD:Cancel()
	elseif cid == 60710 then--Subetai
		--This boss retains Pillage
		timerVolleyCD:Cancel()
		timerRainOfArrowsCD:Cancel()
		timerSleightOfHandCD:Cancel()
	end
end
