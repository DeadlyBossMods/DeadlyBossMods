local mod	= DBM:NewMod(870, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71889)
mod:SetZone()

mod:RegisterCombat("combat")
--mod:SetMinCombatTime(35)--Don't think needed but leaving here in case it is

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"WORLD_STATE_UI_TIMER_UPDATE"
)

--Massive Crate of Goods
local warnReturnToStone			= mod:NewSpellAnnounce(145489, 2)
local warnSetToBlow				= mod:NewTargetAnnounce(145987, 4)--145996 is cast ID
--Stout Crate of Goods
local warnForbiddenMagic		= mod:NewTargetAnnounce(145230, 2)
local warnMatterScramble		= mod:NewSpellAnnounce(145288, 3)
local warnCrimsonRecon			= mod:NewCastAnnounce(142947, 4)
local warnEnergize				= mod:NewSpellAnnounce(145461, 3)--May be script spellid that doesn't show in combat log
local warnTorment				= mod:NewSpellAnnounce(142934, 3, nil, mod:IsHealer())
local warnMantidSwarm			= mod:NewSpellAnnounce(142539, 3, nil, mod:IsTank())
local warnResidue				= mod:NewCastAnnounce(145786, 4, nil, nil, mod:IsMagicDispeller())
local warnRageoftheEmpress		= mod:NewCastAnnounce(145812, 4, nil, nil, mod:IsMagicDispeller())
local warnWindStorm				= mod:NewSpellAnnounce(145816, 3)--Stunable?
--Lightweight Crate of Goods
local warnHardenFlesh			= mod:NewSpellAnnounce(144922, 2, nil, false)
local warnEarthenShard			= mod:NewSpellAnnounce(144923, 2, nil, false)
local warnSparkofLife			= mod:NewSpellAnnounce(142694, 3, nil, false)
local warnBlazingCharge			= mod:NewTargetAnnounce(145712, 3)
local warnEnrage				= mod:NewTargetAnnounce(145692, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())--Do not have timer for this yet, add not alive long enough.
--Crate of Pandaren Relics
local warnBreathofFire			= mod:NewSpellAnnounce(146222, 3)--Do not have timer for this yet, add not alive long enough.
local warnGustingCraneKick		= mod:NewSpellAnnounce(146180, 3)
local warnPathofBlossoms		= mod:NewTargetAnnounce(146256, 3)

--Massive Crate of Goods
local specWarnSetToBlowYou		= mod:NewSpecialWarningYou(145987)
local specWarnSetToBlow			= mod:NewSpecialWarningPreWarn(145996, nil, 4, nil, 3)
--Stout Crate of Goods
local specWarnForbiddenMagic	= mod:NewSpecialWarningInterrupt(145230, mod:IsMelee())
local specWarnMatterScramble	= mod:NewSpecialWarningSpell(145288, nil, nil, nil, 2)
local specWarnCrimsonRecon		= mod:NewSpecialWarningMove(142947, mod:IsTank())
local specWarnTorment			= mod:NewSpecialWarningSpell(142934, mod:IsHealer())
local specWarnMantidSwarm		= mod:NewSpecialWarningSpell(142539, mod:IsTank())
local specWarnResidue			= mod:NewSpecialWarningSpell(145786, mod:IsMagicDispeller())
local specWarnRageoftheEmpress	= mod:NewSpecialWarningSpell(145812, mod:IsMagicDispeller())
--Lightweight Crate of Goods
local specWarnHardenFlesh		= mod:NewSpecialWarningInterrupt(144922, false)
local specWarnEarthenShard		= mod:NewSpecialWarningInterrupt(144923, false)
local specWarnEnrage			= mod:NewSpecialWarningDispel(145692, mod:CanRemoveEnrage())--Question is, do we want to dispel it? might make this off by default since kiting it may be more desired than dispeling it
local specWarnBlazingCharge		= mod:NewSpecialWarningMove(145716)
local specWarnBubblingAmber		= mod:NewSpecialWarningMove(145748)
local specWarnPathOfBlossoms	= mod:NewSpecialWarningMove(146257)
--Crate of Pandaren Relics
local specWarnGustingCraneKick	= mod:NewSpecialWarningSpell(146180, nil, nil, nil, 2)

--Massive Crate of Goods
local timerReturnToStoneCD		= mod:NewNextTimer(12, 145489)
local timerSetToBlowCD			= mod:NewNextTimer(9.5, 145996)
local timerSetToBlow			= mod:NewBuffFadesTimer(30, 145996)
--Stout Crate of Goods
local timerEnrage				= mod:NewTargetTimer(10, 145692)
local timerMatterScrambleCD		= mod:NewCDTimer(18, 145288)--18-22 sec variation. most of time it's 20 exactly, unsure what causes the +-2 variations
local timerCrimsonReconCD		= mod:NewNextTimer(15, 142947)
local timerMantidSwarmCD		= mod:NewCDTimer(35, 142539)
local timerResidueCD			= mod:NewCDTimer(18, 145786, nil, mod:IsMagicDispeller())
local timerWindstormCD			= mod:NewCDTimer(34, 145816, nil, false)--Spammy but might be useful to some, if they aren't releasing a ton of these at once.
local timerRageoftheEmpressCD	= mod:NewCDTimer(18, 145812, nil, mod:IsMagicDispeller())
--Lightweight Crate of Goods
----Most of these timers are included simply because of how accurate they are. Predictable next timers. However, MANY of these adds up at once.
----They are off by default and a user elected choice to possibly pick one specific timer they are in charge of dispeling/interrupting or whatever
local timerHardenFleshCD		= mod:NewNextTimer(8, 144922, nil, false)
local timerEarthenShardCD		= mod:NewNextTimer(10, 144923, nil, false)
local timerBlazingChargeCD		= mod:NewNextTimer(12, 145712, nil, false)
--Crate of Pandaren Relics
local timerGustingCraneKickCD	= mod:NewCDTimer(18, 146180)
local timerPathOfBlossomsCD		= mod:NewCDTimer(15, 146253)

local countdownSetToBlow		= mod:NewCountdownFades(29, 145996)

mod:AddBoolOption("InfoFrame")

local activeBossGUIDS = {}
local setToBlowTargets = {}

local function warnSetToBlowTargets()
	warnSetToBlow:Show(table.concat(setToBlowTargets, "<, >"))
	table.wipe(setToBlowTargets)
end

function mod:BlazingChargeTarget(targetname)
	if not targetname then
		print("DBM DEBUG: BlazingChargeTarget Scan failed")
		return
	end
	warnBlazingCharge:Show(targetname)
end

function mod:PathofBlossomsTarget(targetname)
	if not targetname then
		print("DBM DEBUG: PathofBlossomsTarget Scan failed")
		return
	end
	warnPathofBlossoms:Show(targetname)
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(activeBossGUIDS)
	table.wipe(setToBlowTargets)
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here because it doesn't need to stay perma registered until boss dies.
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 145996 then
		timerSetToBlowCD:Start(args.sourceGUID)
	elseif args.spellId == 145288 then
		warnMatterScramble:Show()
		specWarnMatterScramble:Show()
		timerMatterScrambleCD:Start(args.sourceGUID)
	elseif args.spellId == 145461 then
		warnEnergize:Show()
	elseif args.spellId == 142934 then
		warnTorment:Show()
		specWarnTorment:Show()
	elseif args.spellId == 142539 then
		warnMantidSwarm:Show()
		specWarnMantidSwarm:Show()
		timerMantidSwarmCD:Start(args.sourceGUID)
	elseif args.spellId == 145816 then
		warnWindStorm:Show()
		timerWindstormCD:Start(args.sourceGUID)
	elseif args.spellId == 144922 then
		local source = args.sourceName
		warnHardenFlesh:Show()
		timerHardenFleshCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnHardenFlesh:Show(source)
		end
	elseif args.spellId == 144923 then
		local source = args.sourceName
		warnEarthenShard:Show()
		timerEarthenShardCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnEarthenShard:Show(source)
		end
	elseif args.spellId == 146222 then
		warnBreathofFire:Show()
	elseif args.spellId == 146180 then
		warnGustingCraneKick:Show()
		specWarnGustingCraneKick:Show()
		timerGustingCraneKickCD:Start(args.sourceGUID)
	elseif args.spellId == 145489 then
		warnReturnToStone:Show()
		timerReturnToStoneCD:Start(args.sourceGUID)
	elseif args.spellId == 142947 then--Pre warn more or less
		warnCrimsonRecon:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 145687 and not self:IsInCombat() then--Unstable Defensive System
		DBM:StartCombat(self, 0)
	elseif args.spellId == 142694 then
		warnSparkofLife:Show()
--		specWarnSparkofLife:Show()
	elseif args.spellId == 142947 then
		specWarnCrimsonRecon:Show()--Done here because we want to warn when we need to move mobs, not on cast start (when we can do nothing)
		timerCrimsonReconCD:Start(args.sourceGUID)
	elseif args.spellId == 145712 then
		timerBlazingChargeCD:Start(args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "BlazingChargeTarget", 0.025, 12)
	elseif args.spellId == 146253 then
		timerPathOfBlossomsCD:Start(args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "PathofBlossomsTarget", 0.025, 12)
	elseif args.spellId == 145230 then
		local source = args.sourceName
		warnForbiddenMagic:Show(args.destName)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnForbiddenMagic:Show(source)
		end
	elseif args.spellId == 145786 then
		warnResidue:Show()
		timerResidueCD:Start(args.sourceGUID)
		specWarnResidue:Show()
	elseif args.spellId == 145812 then
		warnRageoftheEmpress:Show()
		specWarnRageoftheEmpress:Show()
		timerRageoftheEmpressCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145987 then
		setToBlowTargets[#setToBlowTargets + 1] = args.destName
		self:Unschedule(warnSetToBlowTargets)
		self:Schedule(0.5, warnSetToBlowTargets)
		if args:IsPlayer() then
			specWarnSetToBlowYou:Show()
			countdownSetToBlow:Start()
			timerSetToBlow:Start()
			specWarnSetToBlow:Schedule(26)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
				self:Schedule(32, hideRangeFrame)
			end
		end
	elseif args.spellId == 145692 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		timerEnrage:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 145987 and args:IsPlayer() then
		countdownSetToBlow:Cancel()
		timerSetToBlow:Cancel()
		specWarnSetToBlow:Cancel()
	elseif args.spellId == 145692 then
		timerEnrage:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 145716 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBlazingCharge:Show()
	elseif spellId == 145748 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnBubblingAmber:Show()
	elseif spellId == 146257 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnPathOfBlossoms:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71408 then--Shao-Tien Colossus
		timerReturnToStoneCD:Cancel(args.destGUID)
	elseif cid == 71409 then--Ka'thik Demolisher
		timerSetToBlowCD:Cancel(args.destGUID)
	elseif cid == 71395 then--Modified Anima Golem
		timerMatterScrambleCD:Cancel(args.destGUID)
		timerCrimsonReconCD:Cancel(args.destGUID)
	elseif cid == 71397 then--Ka'thik Swarmleader
		timerMantidSwarmCD:Cancel(args.destGUID)
		timerResidueCD:Cancel(args.destGUID)
	elseif cid == 71405 then--Ka'thik Wind Wielder
		timerWindstormCD:Cancel(args.destGUID)
		timerRageoftheEmpressCD:Cancel(args.destGUID)
	elseif cid == 71380 then--Animated Stone Mogu
		timerHardenFleshCD:Cancel(args.destGUID)
		timerEarthenShardCD:Cancel(args.destGUID)
	elseif cid == 71385 then--Ka'thik Bombardier
		timerBlazingChargeCD:Cancel(args.destGUID)
	elseif cid == 72810 then--Wise Mistweaver Spirit
		timerGustingCraneKickCD:Cancel(args.destGUID)
	elseif cid == 72828 then--Nameless Windwalker Spirit
		timerPathOfBlossomsCD:Cancel(args.destGUID)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		if UnitExists("boss"..i) and not activeBossGUIDS[UnitGUID("boss"..i)] then--Check if new units exist we haven't detected yet.
			activeBossGUIDS[UnitGUID("boss"..i)] = true
			local cid = self:GetCIDFromGUID(UnitGUID("boss"..i))
			if cid == 71408 then--Shao-Tien Colossus
				timerReturnToStoneCD:Start(5)
			elseif cid == 71409 then--Ka'thik Demolisher (doesn't actually fire IEEU yet, hoping that's just a bug)
				timerSetToBlowCD:Start(5)
			end
		end
	end
end

function mod:WORLD_STATE_UI_TIMER_UPDATE(...)
--	print(...)
end
