local mod	= DBM:NewMod(853, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71152, 71153, 71154, 71155, 71156, 71157, 71158, 71160, 71161)
--mod:SetQuestID(32744)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_DIED"
)

----------------------------------------------------------------------------------------------------------------------------------------
-- A moment of silence to remember Malik the Unscathed, the 10th paragon that perished an honorable death in battle against Shek'zeer --
----------------------------------------------------------------------------------------------------------------------------------------
--All
local warnActivated					= mod:NewTargetAnnounce(118212, 3, 143542)
--Kil'ruk the Wind-Reaver
local warnExposedVeins				= mod:NewStackAnnounce(142931, 2, nil, false)
local warnGouge						= mod:NewTargetAnnounce(143939, 3, nil, mod:IsTank() or mod:IsHealer())--Timing too variable for a CD
local warnImpact					= mod:NewSpellAnnounce(142232, 3)--Timing too variable for a CD
--Xaril the Poisoned-Mind
local warnTenderizingStirkes		= mod:NewStackAnnounce(142929, 2, nil, false)
local warnToxicInjection			= mod:NewSpellAnnounce(142528, 3)
mod:AddBoolOption("warnToxicCatalyst", true, "announce")
local warnToxicCatalystBlue			= mod:NewCastAnnounce(142725, 4, nil, nil, nil, false)
local warnToxicCatalystRed			= mod:NewCastAnnounce(142726, 4, nil, nil, nil, false)
local warnToxicCatalystYellow		= mod:NewCastAnnounce(142727, 4, nil, nil, nil, false)
local warnToxicCatalystOrange		= mod:NewCastAnnounce(142728, 4, nil, nil, nil, false)--Heroic
local warnToxicCatalystPurple		= mod:NewCastAnnounce(142729, 4, nil, nil, nil, false)--Heroic
local warnToxicCatalystGreen		= mod:NewCastAnnounce(142730, 4, nil, nil, nil, false)--Heroic
--local warnToxicCatalystWhite		= mod:NewCastAnnounce(142731, 3, nil, nil, nil, false)--Not in EJ
--Kaz'tik the Manipulator
local warnMesmerize					= mod:NewTargetAnnounce(142671, 3)
local warnSonicProjection			= mod:NewSpellAnnounce(143765, 3, nil, false)--Spammy, and target scaning didn't work
--Korven the Prime
local warnShieldBash				= mod:NewTargetAnnounce(143974, 3, nil, mod:IsTank() or mod:IsHealer())
local warnEncaseInAmber				= mod:NewTargetAnnounce(142564, 4)
--Iyyokuk the Lucid
local warnDiminish					= mod:NewSpellAnnounce(143666, 4, nil, false)--Spammy, target scanning was iffy
local warnCalculated				= mod:NewTargetAnnounce(144095, 3)--Wild variation on timing noted, 34-130.8 variation (wtf)
local warnInsaneCalculationFire		= mod:NewCastAnnounce(142416, 4)--3 seconds after 144095
--Ka'roz the Locust
local warnFlash						= mod:NewCastAnnounce(143709, 3)--62-70
local warnWhirling					= mod:NewTargetAnnounce(143701, 3)
local warnHurlAmber					= mod:NewSpellAnnounce(143759, 3)
--Skeer the Bloodseeker
local warnHewn						= mod:NewStackAnnounce(143275, 2, nil, false)
local warnBloodletting				= mod:NewSpellAnnounce(143280, 4)
--Rik'kal the Dissector
local warnGeneticAlteration			= mod:NewStackAnnounce(143279, 2, nil, false)
local warnInjection					= mod:NewStackAnnounce(143339)--Triggers 143340 at 10 stacks
local warnMutate					= mod:NewTargetAnnounce(143337, 3)
--Hisek the Swarmkeeper
local warnAim						= mod:NewTargetAnnounce(142948, 4)--Maybe wrong debuff id, maybe 144759 instead

--All
--NOTE, this is purely off assumption the ones that make you vunerable to eachother don't spawn at same time.
--It's also possible tehse tank only activate warnings are useless if 4 vulnerability mobs always spawns in pairs
--Then it just means it's an anti solo tank mechanic and we don't need special warnings for it.
local specWarnActivated				= mod:NewSpecialWarningTarget(118212)
local specWarnActivatedVulnerable	= mod:NewSpecialWarning("specWarnActivatedVulnerable", mod:IsTank())--Alternate activate warning to warn a tank not to pick up a specific boss
--Kil'ruk the Wind-Reaver
local specWarnGouge					= mod:NewSpecialWarningYou(143939)
local specWarnGougeOther			= mod:NewSpecialWarningTarget(143939, mod:IsTank() or mod:IsHealer())
--Xaril the Poisoned-Mind
mod:AddBoolOption("specWarnToxicInjection", true, "announce")--Combine the 7 special warnings for same spell into 1
local specWarnToxicBlue				= mod:NewSpecialWarningYou(142532, nil, false)
local specWarnToxicRed				= mod:NewSpecialWarningYou(142533, nil, false)
local specWarnToxicYellow			= mod:NewSpecialWarningYou(142534, nil, false)
local specWarnToxicOrange			= mod:NewSpecialWarningYou(142547, nil, false)--Heroic
local specWarnToxicPurple			= mod:NewSpecialWarningYou(142548, nil, false)--Heroic
local specWarnToxicGreen			= mod:NewSpecialWarningYou(142549, nil, false)--Heroic
--local specWarnToxicWhite			= mod:NewSpecialWarningYou(142550, nil, false)--Not in EJ
mod:AddBoolOption("specWarnToxicCatalyst", true, "announce")--Combine the cataclysts as well.
local specWarnCatalystBlue			= mod:NewSpecialWarningYou(142725, nil, false, nil, 3)
local specWarnCatalystRed			= mod:NewSpecialWarningYou(142726, nil, false, nil, 3)
local specWarnCatalystYellow		= mod:NewSpecialWarningYou(142727, nil, false, nil, 3)
local specWarnCatalystOrange		= mod:NewSpecialWarningYou(142728, nil, false, nil, 3)--Heroic
local specWarnCatalystPurple		= mod:NewSpecialWarningYou(142729, nil, false, nil, 3)--Heroic
local specWarnCatalystGreen			= mod:NewSpecialWarningYou(142730, nil, false, nil, 3)--Heroic
--local specWarnCatalystWhite		= mod:NewSpecialWarningYou(142731, nil, false, nil, 3)--Not in EJ
mod:AddBoolOption("yellToxicCatalyst", true, "misc")--And lastly, combine yells
local yellCatalystBlue				= mod:NewYell(142725, nil, nil, false)
local yellCatalystRed				= mod:NewYell(142726, nil, nil, false)
local yellCatalystYellow			= mod:NewYell(142727, nil, nil, false)
local yellCatalystOrange			= mod:NewYell(142728, nil, nil, false)
local yellCatalystPurple			= mod:NewYell(142729, nil, nil, false)
local yellCatalystGreen				= mod:NewYell(142730, nil, nil, false)
--Kaz'tik the Manipulator
local specWarnMesmerize				= mod:NewSpecialWarningYou(142671)
local yellMesmerize					= mod:NewYell(142671, nil, false)
local specWarnKunchongs				= mod:NewSpecialWarningSwitch("ej8043", mod:IsDps())
--Korven the Prime
local specWarnShieldBash			= mod:NewSpecialWarningYou(143974)
local specWarnShieldBashOther		= mod:NewSpecialWarningTarget(143974, mod:IsTank() or mod:IsHealer())
local specWarnEncaseInAmber			= mod:NewSpecialWarningTarget(142564, mod:IsDps())--Conflicted on using this or NewSpecialWarningSwitch, switch won't have targetname
--Iyyokuk the Lucid
local specWarnCalculated			= mod:NewSpecialWarningYou(144095)
local yellCalculated				= mod:NewYell(144095)
local specWarnCriteriaLinked		= mod:NewSpecialWarning("specWarnCriteriaLinked")--Linked to Calculated target
local specWarnInsaneCalculationFire	= mod:NewSpecialWarningSpell(142416, nil, nil, nil, 2)
--Ka'roz the Locust
local specWarnFlash					= mod:NewSpecialWarningSpell(143709, nil, nil, nil, 2)
local specWarnWhirling				= mod:NewSpecialWarningYou(143701)
local yellWhirling					= mod:NewYell(143701, nil, false)
local specWarnWhirlingNear			= mod:NewSpecialWarningClose(143701)
--Skeer the Bloodseeker
local specWarnBloodletting			= mod:NewSpecialWarningSwitch(143280, not mod:IsHealer())
--Rik'kal the Dissector
local specWarnMutate				= mod:NewSpecialWarningYou(143337)
--Hisek the Swarmkeeper
local specWarnAim					= mod:NewSpecialWarningYou(142948)
local yellAim						= mod:NewYell(142948)
local specWarnAimOther				= mod:NewSpecialWarningTarget(142948)

--Kil'ruk the Wind-Reaver
local timerGouge					= mod:NewTargetTimer(10, 143939, mod:IsTank())
--Xaril the Poisoned-Mind
local timerToxicCatalystCD			= mod:NewCDTimer(33, "ej8036")
--Korven the Prime
local timerShieldBash				= mod:NewTargetTimer(6, 143974, mod:IsTank())
local timerShieldBashCD				= mod:NewCDTimer(17, 143974, mod:IsTank())
local timerEncaseInAmber			= mod:NewTargetTimer(10, 142564)
--Iyyokuk the Lucid
local timerCalculated				= mod:NewBuffFadesTimer(6, 144095)
--Ka'roz the Locust
local timerFlashCD					= mod:NewCDTimer(64, 143709)
local timerWhirling					= mod:NewBuffFadesTimer(5, 143701)
--Rik'kal the Dissector
local timerMutate					= mod:NewBuffFadesTimer(20, 143337)
--Hisek the Swarmkeeper
local timerAim						= mod:NewTargetTimer(5, 142948)--or is it 7, conflicting tooltips

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnAim", true)--multi boss fight, will use star and avoid moving skull off a kill target

local activatedTargets = {}--A table, for the 3 on pull
local whirlingTargets = {}
local activeBossGUIDS = {}
local UnitDebuff = UnitDebuff
local GetSpellInfo = GetSpellInfo

local function warnActivatedTargets(vulnerable)
	if #activatedTargets > 1 then
		warnActivated:Show(table.concat(activatedTargets, "<, >"))
		specWarnActivated:Show(table.concat(activatedTargets, ", "))
	else
		warnActivated:Show(activatedTargets[1])
		if vulnerable and mod:IsTank() then
			specWarnActivatedVulnerable:Show(activatedTargets[1])
		else
			specWarnActivated:Show(activatedTargets[1])
		end
	end
	table.wipe(activatedTargets)
end

local function warnWhirlingTargets()
	warnWhirling:Show(table.concat(whirlingTargets, "<, >"))
	table.wipe(whirlingTargets)
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function CheckBosses(GUID)
	for i = 1, 5 do
		local vulnerable = false
		if UnitExists("boss"..i) and not activeBossGUIDS[UnitGUID("boss"..i)] then--Check if new units exist we haven't detected and added yet.
			activeBossGUIDS[UnitGUID("boss"..i)] = true
			activatedTargets[#activatedTargets + 1] = UnitName("boss"..i)
			--Activation Controller
			local cid = mod:GetCIDFromGUID(UnitGUID("boss"..i))
			if cid == 71161 then--Kil'ruk the Wind-Reaver
				if UnitDebuff("player", GetSpellInfo(142929)) then vulnerable = true end
			elseif cid == 71157 then--Xaril the Poisoned-Mind
				if UnitDebuff("player", GetSpellInfo(142931)) then vulnerable = true end
			elseif cid == 71156 then--Kaz'tik the Manipulator
		
			elseif cid == 71155 then--Korven the Prime
				timerShieldBashCD:Start(21)
			elseif cid == 71160 then--Iyyokuk the Lucid
		
			elseif cid == 71154 then--Ka'roz the Locust
				timerFlashCD:Start(11.5)
			elseif cid == 71152 then--Skeer the Bloodseeker
				if UnitDebuff("player", GetSpellInfo(143279)) then vulnerable = true end
			elseif cid == 71158 then--Rik'kal the Dissector
				if UnitDebuff("player", GetSpellInfo(143275)) then vulnerable = true end
			elseif cid == 71153 then--Hisek the Swarmkeeper
		
			end
		end
		warnActivatedTargets(vulnerable)--Down here so we can send tank vulnerable status
	end
end

function mod:OnCombatStart(delay)
	table.wipe(activeBossGUIDS)
	table.wipe(activatedTargets)
	table.wipe(whirlingTargets)
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to make sure we wipe variables on pull
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--"<13.6 19:16:29> [UNIT_SPELLCAST_SUCCEEDED] Iyyokuk the Lucid [[boss2:Jump to Center::0:143545]]", -- [95]
--^don't let above fool you, not all of the paragons fire this spell!!! that is why we MUST use IEEU
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	self:Unschedule(CheckBosses)
	self:Schedule(0.2, CheckBosses)--Delay check to make sure we run function only once on pull
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142725 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystBlue:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142532)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystBlue:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystBlue:Yell()
			end
		end
	elseif args.spellId == 142726 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystRed:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142533)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystRed:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystRed:Yell()
			end
		end
	elseif args.spellId == 142727 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystYellow:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142534)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystYellow:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystYellow:Yell()
			end
		end
	elseif args.spellId == 142728 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystOrange:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142547)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystOrange:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystOrange:Yell()
			end
		end
	elseif args.spellId == 142729 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystPurple:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142548)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystPurple:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystPurple:Yell()
			end
		end
	elseif args.spellId == 142730 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystGreen:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142549)) then
			if self.Options.specWarnToxicCatalyst then
				specWarnCatalystGreen:Show()
			end
			if self.Options.yellToxicCatalyst then
				yellCatalystGreen:Yell()
			end
		end
	elseif args.spellId == 143765 then
		warnSonicProjection:Show()
	elseif args.spellId == 143666 then
		warnDiminish:Show()
	elseif args.spellId == 142416 then
		warnInsaneCalculationFire:Show()
		specWarnInsaneCalculationFire:Show()
	elseif args.spellId == 143709 then
		warnFlash:Show()
		specWarnFlash:Show()
		timerFlashCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)--Range assumed, spell tooltips not informative enough
			self:Schedule(5, hideRangeFrame)
		end
	elseif args.spellId == 143280 then
		warnBloodletting:Show()
		specWarnBloodletting:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142528 then
		warnToxicInjection:Show()
		timerToxicCatalystCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142931 then
		local amount = args.amount or 1
		warnExposedVeins:Show(args.destName, amount)
	elseif args.spellId == 142929 then
		local amount = args.amount or 1
		warnTenderizingStirkes:Show(args.destName, amount)
	elseif args.spellId == 143275 then
		local amount = args.amount or 1
		warnHewn:Show(args.destName, amount)
	elseif args.spellId == 143279 then
		local amount = args.amount or 1
		warnGeneticAlteration:Show(args.destName, amount)
	elseif args.spellId == 143339 then
		local amount = args.amount or 1
		warnInjection:Show(args.destName, amount)
	elseif args.spellId == 142532 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicBlue:Show()
	elseif args.spellId == 142533 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicRed:Show()
	elseif args.spellId == 142534 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicYellow:Show()
	elseif args.spellId == 142547 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicOrange:Show()
	elseif args.spellId == 142548 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicPurple:Show()
	elseif args.spellId == 142549 and self.Options.specWarnToxicInjection and args:IsPlayer() then
		specWarnToxicGreen:Show()
	elseif args.spellId == 142671 then
		warnMesmerize:Show(args.destName)
		if args.IsPlayer() then
			specWarnMesmerize:Show()
			yellMesmerize:Yell()
		else
			specWarnKunchongs:Show()
		end
	elseif args.spellId == 142564 then
		warnEncaseInAmber:Show(args.destName)
		specWarnEncaseInAmber:Show(args.destName)
		timerEncaseInAmber:Start(args.destName)
	elseif args.spellId == 143939 then
		warnGouge:Show(args.destName)
		timerGouge:Start(args.destName)
		if args.IsPlayer() then
			specWarnGouge:Show()
		else
			specWarnGougeOther:Show(args.destName)
		end
	elseif args.spellId == 143974 then
		warnShieldBash:Show(args.destName)
		timerShieldBash:Start(args.destName)
		timerShieldBashCD:Start()
		if args.IsPlayer() then
			specWarnShieldBash:Show()
		else
			specWarnShieldBashOther:Show(args.destName)
		end
	elseif args.spellId == 143701 then
		whirlingTargets[#whirlingTargets + 1] = args.destName
		self:Unschedule(warnWhirlingTargets)
		self:Schedule(0.5, warnWhirlingTargets)
		if args.IsPlayer() then
			specWarnWhirling:Show()
			yellWhirling:Yell()
			timerWhirling:Start()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 6 then
					specWarnWhirlingNear:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 143759 then
		warnHurlAmber:Show()
	elseif args.spellId == 143337 then
		warnMutate:Show(args.destName)
		if args.IsPlayer() then
			specWarnMutate:Show()
			timerMutate:Start()
		end
	elseif args.spellId == 142948 then
		warnAim:Show(args.destName)
		timerAim:Start(args.destName)
		if args.IsPlayer() then
			specWarnAim:Show()
			yellAim:Yell()
		else
			specWarnAimOther:Show(args.destName)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		if self.Options.SetIconOnAim then
			self:SetIcon(args.destName, 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 142564 then
		timerEncaseInAmber:Cancel(args.destName)
	elseif args.spellId == 143939 then
		timerGouge:Cancel(args.destName)
	elseif args.spellId == 143974 then
		timerShieldBash:Cancel(args.destName)
	elseif args.spellId == 143700 and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif args.spellId == 142948 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnAim then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71161 then--Kil'ruk the Wind-Reaver
		
	elseif cid == 71157 then--Xaril the Poisoned-Mind
		timerToxicCatalystCD:Cancel()
	elseif cid == 71156 then--Kaz'tik the Manipulator
		
	elseif cid == 71155 then--Korven the Prime
		timerShieldBashCD:Cancel()
	elseif cid == 71160 then--Iyyokuk the Lucid
		
	elseif cid == 71154 then--Ka'roz the Locust
		timerFlashCD:Cancel()
	elseif cid == 71152 then--Skeer the Bloodseeker
		
	elseif cid == 71158 then--Rik'kal the Dissector
		
	elseif cid == 71153 then--Hisek the Swarmkeeper
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 142264 then
		warnImpact:Show()
	end
end
------------------
--Normal Only?
--143605 Red Sword
--143606 Purple Sword
--143607 Blue Sword
--143608 Green Sword
--143609 Yellow Sword

--143610 Red Drum
--143611 Purple Drum
--143612 Blue Drum
--143613 Green Drum
--143614 Yellow Drum

--143615 Red Bomb
--143616 Purple Bomb
--143617 Blue Bomb
--143618 Green Bomb
--143619 Yellow Bomb
----------------------
--Heroic Only?
--143620 Red Mantid
--143621 Purple Mantid
--143622 Blue Mantid
--143623 Green Mantid
--143624 Yellow Mantid

--143627 Red Staff
--143628 Purple Staff
--143629 Blue Staff
--143630 Green Staff
--143631 Yellow Staff

local Debuffs = {
GetSpellInfo(143605), GetSpellInfo(143606), GetSpellInfo(143607), GetSpellInfo(143608), GetSpellInfo(143609),
GetSpellInfo(143610), GetSpellInfo(143611), GetSpellInfo(143612), GetSpellInfo(143613), GetSpellInfo(143614),
GetSpellInfo(143615), GetSpellInfo(143616), GetSpellInfo(143617), GetSpellInfo(143618), GetSpellInfo(143619),
GetSpellInfo(143620), GetSpellInfo(143621), GetSpellInfo(143622), GetSpellInfo(143623), GetSpellInfo(143624),
GetSpellInfo(143627), GetSpellInfo(143628), GetSpellInfo(143629), GetSpellInfo(143630), (GetSpellInfo(143631))
}
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg == L.calculatedTarget or msg:find(L.calculatedTarget) then
		local target = DBM:GetFullNameByShortName(target)
		warnCalculated:Show(target)
		timerCalculated:Start()
		if target == UnitName("player") then
			specWarnCalculated:Show()
			yellCalculated:Yell()
		else--it's not us, so now lets do some some of our own "calculations"
			local uId = DBM:GetRaidUnitId(target)
			local targetShape, targetColor, targetNumber
			local playerShape, playerColor, playerNumber
			for _, spellname in ipairs(Debuffs) do--Scan calculated target's random debuffs
				local name, _, _, count = UnitDebuff(uId, spellname)
				if name and count then--Found
					local color, shape = strsplit(" ", name)--Split name
					targetShape, targetColor, targetNumber = color, shape, count
					break
				end
			end
			if targetShape and targetColor and targetNumber then--Found theirs, now lets compare to ours
				for _, spellname in ipairs(Debuffs) do
					local name, _, _, count = UnitDebuff("player", spellname)
					if name and count then--Found
						local color, shape = strsplit(" ", name)
						playerShape, playerColor, playerNumber = color, shape, count
						break
					end
				end
			end
			if playerShape and playerColor and playerNumber then--Victory, we have theirs and ours
				local criteriaMatched = 0--Now to start checking matches.
				if targetShape == playerShape then criteriaMatched = criteriaMatched + 1 end
				if targetColor == playerColor then criteriaMatched = criteriaMatched + 1 end
				if targetNumber == playerNumber then criteriaMatched = criteriaMatched + 1 end
				if (criteriaMatched == 1 and self:IsDifficulty("lfr25")) or (criteriaMatched == 2 and self:IsDifficulty("normal10", "normal25", "flex")) or (criteriaMatched == 3 and self:IsDifficulty("heroic10", "heroic25")) then
					specWarnCriteriaLinked:Show(target)
--					yellCalculated:Yell()
				end
			end
		end
	end
end
