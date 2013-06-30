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
	"UNIT_DIED"
)

----------------------------------------------------------------------------------------------------------------------------------------
-- A moment of silence to remember Malik the Unscathed, the 10th paragon that perished an honorable death in battle against Shek'zeer --
----------------------------------------------------------------------------------------------------------------------------------------
--All
local warnActivated					= mod:NewTargetAnnounce(118212, 3, 143542)
--Kil'ruk the Wind-Reaver
local warnExposedVeins				= mod:NewStackAnnounce(142931, 2, nil, false)
local warnGouge						= mod:NewTargetAnnounce(143939, 3, nil, mod:IsTank() or mod:IsHealer())
local warnImpact					= mod:NewSpellAnnounce(142232, 3)--Check target scanning, once we even figure out which is correct ID for cast
--Xaril the Poisoned-Mind
local warnTenderizingStirkes		= mod:NewStackAnnounce(142929, 2, nil, false)
local warnToxicInjection			= mod:NewSpellAnnounce(142528, 3)
mod:AddBoolOption("warnToxicCatalyst", true, "announce")
local warnToxicCatalystBlue			= mod:NewCastAnnounce(142725, 3, nil, nil, nil, false)
local warnToxicCatalystRed			= mod:NewCastAnnounce(142726, 3, nil, nil, nil, false)
local warnToxicCatalystYellow		= mod:NewCastAnnounce(142727, 3, nil, nil, nil, false)
local warnToxicCatalystOrange		= mod:NewCastAnnounce(142728, 3, nil, nil, nil, false)--Heroic
local warnToxicCatalystPurple		= mod:NewCastAnnounce(142729, 3, nil, nil, nil, false)--Heroic
local warnToxicCatalystGreen		= mod:NewCastAnnounce(142730, 3, nil, nil, nil, false)--Heroic
--local warnToxicCatalystWhite		= mod:NewCastAnnounce(142731, 3, nil, nil, nil, false)--Not in EJ
--Kaz'tik the Manipulator
local warnMesmerize					= mod:NewTargetAnnounce(142671, 3)
local warnSonicProjection			= mod:NewTargetAnnounce(143765, 3)--target scanning assumed. unverified
--Korven the Prime
local warnShieldBash				= mod:NewTargetAnnounce(143974, 3, nil, mod:IsTank() or mod:IsHealer())
local warnEncaseInAmber				= mod:NewTargetAnnounce(142564, 4)
--Iyyokuk the Lucid
local warnDiminish					= mod:NewTargetAnnounce(143666, 4, nil, mod:IsHealer())--Target scanning assumed
local warnCalculated				= mod:NewTargetAnnounce(144095, 3)
local warnInsaneCalculationFire		= mod:NewCastAnnounce(142416, 3)--6 seconds after 144095 i assume
--Ka'roz the Locust
local warnFlash						= mod:NewCastAnnounce(143709, 3)--Flash (143700) trigger spell. also 143704 followup?
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
local specWarnActivatedVulnerable	= mod:NewSpecialWarning("specWarnActivatedVunerable", mod:IsTank())--Alternate activate warning to warn a tank not to pick up a specific boss
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
--Kaz'tik the Manipulator
local specWarnMesmerize				= mod:NewSpecialWarningYou(142671)
local specWarnKunchongs				= mod:NewSpecialWarningSwitch("ej8043", mod:IsDps())
local specWarnSonicProjection		= mod:NewSpecialWarningYou(143765)
local yellSonicProjection			= mod:NewYell(143765)
--Korven the Prime
local specWarnShieldBash			= mod:NewSpecialWarningYou(143974)
local specWarnShieldBashOther		= mod:NewSpecialWarningTarget(143974, mod:IsTank() or mod:IsHealer())
local specWarnEncaseInAmber			= mod:NewSpecialWarningTarget(142564, mod:IsDps())
--Iyyokuk the Lucid
local specWarnDiminish				= mod:NewSpecialWarningYou(143666)
local specWarnDiminishOther			= mod:NewSpecialWarningTarget(143666, mod:IsHealer())
local specWarnCalculated			= mod:NewSpecialWarningYou(144095)
local yellCalculated				= mod:NewYell(144095)
local specWarnInsaneCalculationFire	= mod:NewSpecialWarningSpell(142416, nil, nil, nil, 2)
--Ka'roz the Locust
local specWarnFlash					= mod:NewSpecialWarningSpell(143709, nil, nil, nil, 2)
local specWarnWhirling				= mod:NewSpecialWarningYou(143701)
local yellWhirling					= mod:NewYell(143701)
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
--Korven the Prime
local timerShieldBash				= mod:NewTargetTimer(6, 143974, mod:IsTank())
local timerEncaseInAmber			= mod:NewTargetTimer(10, 142564)
--Iyyokuk the Lucid
local timerCalculated				= mod:NewBuffFadesTimer(6, 144095)
--Ka'roz the Locust
local timerWhirling					= mod:NewBuffFadesTimer(5, 143701)
--Rik'kal the Dissector
local timerMutate					= mod:NewBuffFadesTimer(20, 143337)
--Hisek the Swarmkeeper
local timerAim						= mod:NewTargetTimer(5, 142948)--or is it 7, conflicting tooltips

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnAim", true)--multi boss fight, will use star and avoid moving skull off a kill target

local activatedTargets = {}--A table, for the 3 on pull
local calculatedTargets = {}
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

local function warnCalculatedTargets()
	warnCalculated:Show(table.concat(calculatedTargets, "<, >"))
	table.wipe(calculatedTargets)
	timerCalculated:Start()
end

function mod:SonicProjectionTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: SonicProjectionTarget Scan failed")
		return
	end
	warnSonicProjection:Show(targetname)
	if targetname == UnitName("player") then
		specWarnSonicProjection:Show()
		yellSonicProjection:Yell()
	end
end

function mod:DiminishTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: DiminishTarget Scan failed")
		return
	end
	warnDiminish:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDiminish:Show()
	else
		specWarnDiminishOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(calculatedTargets)
--	table.wipe(activatedTargets)--iffy on wiping here so doing it on combat end instead
end

function mod:OnCombatEnd()
	table.wipe(activatedTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end


function mod:SPELL_CAST_START(args)
	if args.spellId == 142725 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystBlue:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142532)) then
			specWarnCatalystBlue:Show()
		end
	elseif args.spellId == 142726 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystRed:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142533)) then
			specWarnCatalystRed:Show()
		end
	elseif args.spellId == 142727 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystYellow:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142534)) then
			specWarnCatalystYellow:Show()
		end
	elseif args.spellId == 142728 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystOrange:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142547)) then
			specWarnCatalystOrange:Show()
		end
	elseif args.spellId == 142729 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystPurple:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142548)) then
			specWarnCatalystPurple:Show()
		end
	elseif args.spellId == 142730 then
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystGreen:Show()
		end
		if self.Options.specWarnToxicCatalyst and UnitDebuff("player", GetSpellInfo(142549)) then
			specWarnCatalystGreen:Show()
		end
	elseif args.spellId == 143765 then
		self:BossTargetScanner(71156, "SonicProjectionTarget", 0.025, 12)
	elseif args.spellId == 143666 then
		self:BossTargetScanner(71160, "DiminishTarget", 0.025, 12)
	elseif args.spellId == 142416 then
		warnInsaneCalculationFire:Show()
		specWarnInsaneCalculationFire:Show()
	elseif args.spellId == 143709 then
		warnFlash:Show()
		specWarnFlash:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)--Range assumed, spell tooltips not informative enough
		end
	elseif args.spellId == 143280 then
		warnBloodletting:Show()
		specWarnBloodletting:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142264 then--guessed id
		warnImpact:Show()
	elseif args.spellId == 142528 then
		warnToxicInjection:Show()
	elseif args.spellId == 143761 then--Supposed periodic trigger during Hurl Amber buff
		local target = self:GetBossTarget(71154)
		print("DBM DEBUG: Hurl Amber on ", target or "Unknown")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143542 then
		--A soon warning? Pull filtering needed?
		print("DBM Debug: Activation on "..args.destName.." next")
	elseif args.spellId == 142931 then
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
		if args.IsPlayer() then
			specWarnShieldBash:Show()
		else
			specWarnShieldBashOther:Show(args.destName)
		end
	elseif args.spellId == 144095 then
		calculatedTargets[#calculatedTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnCalculated:Show()
			yellCalculated:Yell()
		end
		self:Unschedule(warnCalculatedTargets)
		self:Schedule(0.3, warnCalculatedTargets)
	elseif args.spellId == 143701 then
		warnWhirling:Show(args.destName)
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
		print("DBM DEV REMINDER: Watch Ka'roz's targets")
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
	if args.spellId == 143542 then--Ready to Fight
		--Do first 3 fire before or after IEEU? mod functionality hinges on this being after :\
		--Otherwise, will just rewriting the activation controller to use IEEU
		activatedTargets[#activatedTargets + 1] = args.destName
		self:Unschedule(warnActivatedTargets)
		--Activation Controller
		local vulnerable = false
		local cid = args:GetDestCreatureID()
		if cid == 71161 then--Kil'ruk the Wind-Reaver
			if UnitDebuff("player", GetSpellInfo(142929)) then vulnerable = true end
		elseif cid == 71157 then--Xaril the Poisoned-Mind
			if UnitDebuff("player", GetSpellInfo(142931)) then vulnerable = true end
		elseif cid == 71156 then--Kaz'tik the Manipulator
		
		elseif cid == 71155 then--Korven the Prime
		
		elseif cid == 71160 then--Iyyokuk the Lucid
		
		elseif cid == 71154 then--Ka'roz the Locust
		
		elseif cid == 71152 then--Skeer the Bloodseeker
			if UnitDebuff("player", GetSpellInfo(143279)) then vulnerable = true end
		elseif cid == 71158 then--Rik'kal the Dissector
			if UnitDebuff("player", GetSpellInfo(143275)) then vulnerable = true end
		elseif cid == 71153 then--Hisek the Swarmkeeper
		
		end
		--Down here so we can send tank vulnerable status
		self:Schedule(0.3, warnActivatedTargets, vulnerable)
	elseif args.spellId == 142564 then
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
		
	elseif cid == 71156 then--Kaz'tik the Manipulator
		
	elseif cid == 71155 then--Korven the Prime
		
	elseif cid == 71160 then--Iyyokuk the Lucid
		
	elseif cid == 71154 then--Ka'roz the Locust
		
	elseif cid == 71152 then--Skeer the Bloodseeker
		
	elseif cid == 71158 then--Rik'kal the Dissector
		
	elseif cid == 71153 then--Hisek the Swarmkeeper
		
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
