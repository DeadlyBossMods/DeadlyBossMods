local mod	= DBM:NewMod(2599, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214503)
mod:SetEncounterID(2898)
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 456420 435401 432965 435403 439559 453258 442428",
	"SPELL_CAST_SUCCESS 439511",
	"SPELL_AURA_APPLIED 459273 438845 435410 434155 439191",
	"SPELL_AURA_APPLIED_DOSE 459273 438845",
	"SPELL_AURA_REMOVED 459273 434155 439191"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out how tanks survive being hit for 15 million on mythic, cause I see no viable strategy besides 3 tanking. On heroic and lower you can 2 tank...kinda
--TODO, GTFO for rain of arrows with correct ID
--TODO, remove icons and icon yells when blizzard makes phase blades a private aura and add PA sound instead
--TODO, move timer for phase blades to correct cast event
--TODO, change option keys to match BW for weak aura compatability before live
local warnCosmicShards							= mod:NewCountAnnounce(459273, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(459273))--Player
local warnPhaseBlades							= mod:NewTargetNoFilterAnnounce(434155, 3)
local warnRainofArrows							= mod:NewCountAnnounce(453258, 3)
local warnDecimate								= mod:NewTargetNoFilterAnnounce(442428, 3)

local specWarnShatteringSweep					= mod:NewSpecialWarningCount(456420, nil, nil, nil, 2, 2)
local specWarnExpose							= mod:NewSpecialWarningDefensive(435401, nil, nil, nil, 1, 2)
local specWarnPhaseLunge						= mod:NewSpecialWarningDefensive(435403, nil, nil, nil, 1, 2)
local specWarnExposedWeakness					= mod:NewSpecialWarningTaunt(438845, nil, nil, nil, 1, 2)
local specWarnPiercedDefenses					= mod:NewSpecialWarningTaunt(435410, nil, nil, nil, 1, 2)
local specWarnPhaseBlades						= mod:NewSpecialWarningYou(434155, nil, nil, nil, 1, 2)
local yellPhaseBlades							= mod:NewPosYell(434155)
local yellPhaseBladesFades						= mod:NewIconFadesYell(434155)
local specWarnDecimate							= mod:NewSpecialWarningYou(442428, nil, nil, nil, 1, 2)
local yellDecimate								= mod:NewPosYell(442428)
local yellDecimateFades							= mod:NewIconFadesYell(442428)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerShatteringSweepCD					= mod:NewAITimer(49, 456420, nil, nil, nil, 2)
local timerCosmicShards							= mod:NewBuffFadesTimer(6, 459273, nil, nil, nil, 5)
local timerCaptainsFlourishCD					= mod:NewAITimer(40, 439511, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerPhaseBladesCD						= mod:NewAITimer(49, 434155, nil, nil, nil, 3)
local timerRainofArrowsCD						= mod:NewAITimer(49, 453258, nil, nil, nil, 3)
local timerDecimateCD							= mod:NewAITimer(49, 442428, nil, nil, nil, 3)

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnPhaseBlades", 434155, true, 0, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnDecimate", 442428, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.sweepCount = 0
mod.vb.tankCombo = 0
mod.vb.comboCount = 0
mod.vb.bladesCount = 0
mod.vb.bladesIcon = 1
mod.vb.arrowsCount = 0
mod.vb.decimateCount = 0
mod.vb.decimateIcon = 1

function mod:OnCombatStart(delay)
	self.vb.sweepCount = 0
	self.vb.tankCombo = 0
	self.vb.comboCount = 0
	self.vb.bladesCount = 0
	self.vb.arrowsCount = 0
	self.vb.decimateCount = 0
	timerShatteringSweepCD:Start(1)
	timerCaptainsFlourishCD:Start(1)
	timerPhaseBladesCD:Start(1)
	timerRainofArrowsCD:Start(1)
	timerDecimateCD:Start(1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 456420 then
		self.vb.sweepCount = self.vb.sweepCount + 1
		specWarnShatteringSweep:Show()
		specWarnShatteringSweep:Play("aesoon")
		timerShatteringSweepCD:Start()
	elseif spellId == 435401 or spellId == 432965 then--Likely diff ID for first and second swing.
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnExpose:Show()
			specWarnExpose:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			--This doesn't check TankSwapBehavior dropdown because this always validates that the player about to get hit by this, shouldn't be hit by it
			--if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
			--	local _, _, _, _, _, expireTimeTarget = DBM:UnitDebuff("boss1target", 407547)
			--	if (expireTimeTarget and expireTimeTarget-GetTime() >= 2) and self:AntiSpam(1, 1) then
			--		specWarnFlamingSlashTaunt:Show(UnitName("boss1target"))
			--		specWarnFlamingSlashTaunt:Play("tauntboss")
			--	end
			--end
		end
	elseif spellId == 435403 then
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPhaseLunge:Show()
			specWarnPhaseLunge:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			--This doesn't check TankSwapBehavior dropdown because this always validates that the player about to get hit by this, shouldn't be hit by it
			if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
				local _, _, _, _, _, expireTimeTarget = DBM:UnitDebuff("boss1target", 435410)--Target has Pierced Defenses already and can't take this 500% damage hit
				if (expireTimeTarget and expireTimeTarget-GetTime() >= 2) and self:AntiSpam(1, 1) then
					specWarnPiercedDefenses:Show(UnitName("boss1target"))
					specWarnPiercedDefenses:Play("tauntboss")
				end
			end
		end
	elseif spellId == 439559 or spellId == 453258 then
		self.vb.arrowsCount = self.vb.arrowsCount + 1
		warnRainofArrows:Show(self.vb.arrowsCount)
		timerRainofArrowsCD:Start()
	elseif spellId == 442428 then
		self.vb.decimateCount = self.vb.decimateCount + 1
		self.vb.decimateIcon = 1
		timerDecimateCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439511 then
		self.vb.firstHitTank = ""
		self.vb.tankCombo = self.vb.tankCombo + 1
		self.vb.comboCount = 0
		timerCaptainsFlourishCD:Start()--nil, self.vb.tankCombo+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 459273 and args:IsPlayer() then
		warnCosmicShards:Cancel()
		--0.5 aggregation so all ones blowing up at once during Shattering Sweep are only single warned
		warnCosmicShards:Schedule(05, args.amount or 1)
		timerCosmicShards:Stop()
		timerCosmicShards:Start()
	elseif (spellId == 438845 or spellId == 435410) and not args:IsPlayer() then--Exposed weakness / Pierced Defenses
		--local alertTaunt
		if self.vb.comboCount == 1 then
			self.vb.firstHitTank = args.destName
		end
		if spellId == 438845 and (args.amount or 1) == 2 then--Only thing we can be sure of, you don't want a tank taking all 3 hits
			specWarnExposedWeakness:Show(args.destName)
			specWarnExposedWeakness:Play("tauntboss")
		end
		--if self.Options.TankSwapBehavior == "OnlyIfDanger" then
		--	--This means there are 0 preemtive taunts at all and you only taunt when a combo hit starts and it's not safe for the current target to take
		--	--This uses minimum amount of taunts but poses greater risk of messup since it's reactiev only and not proactive
		--	return
		--elseif self.Options.TankSwapBehavior == "DoubleSoak" and self.vb.comboCount == 2 and args.destName == self.vb.firstHitTank then
		--	--This basically means the first tank took first 2 hits then 2nd tank taunts 3rd
		--	alertTaunt = true
		--elseif self.Options.TankSwapBehavior == "MinMaxSoak" and self.vb.comboCount == 1 then
		--	--Min Max soaking to spread combo across both tanks to mitigate having one tank eat all the damage
		--	--Other tank got first part of combo, and you do NOT have debuff for next part of combo, make you taunt next part of combo so one tank doesn't get both debuffs
		--	--This condition is mostly a "first combo" catch, where the SPELL_CAST_START checks would fail to assign the tanks automatically based on what they took in previous combo
		--	local checkedSpellId
		--	if spellId == 438845 then
		--		checkedSpellId = 435410
		--	else
		--		checkedSpellId = 438845
		--	end
		--	if not DBM:UnitDebuff("player", checkedSpellId) then
		--		alertTaunt = true
		--	end
		--end
		--if alertTaunt and self:AntiSpam(1, 1) then
		--	specWarnFlamingSlashTaunt:Show(args.destName)
		--	specWarnFlamingSlashTaunt:Play("tauntboss")
		--end
	elseif spellId == 434155 then
		if self:AntiSpam(10, 2) then
			self.vb.bladesIcon = 1
			timerPhaseBladesCD:Start()
		end
		local icon = self.vb.bladesIcon
		if self.Options.SetIconOnPhaseBlades then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnPhaseBlades:Show()
			specWarnPhaseBlades:Play("targetyou")
			yellPhaseBlades:Yell(icon, icon)
			yellPhaseBladesFades:Countdown(5, nil, icon)
		end
		warnPhaseBlades:PreciseShow(4, args.destName)--4 is max targets, but it can scale down to less
		self.vb.bladesIcon = self.vb.bladesIcon + 1
	elseif spellId == 439191 then
		local icon = self.vb.decimateIcon
		if self.Options.SetIconOnDecimate then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDecimate:Show()
			specWarnDecimate:Play("targetyou")
			yellDecimate:Yell(icon, icon)
			yellDecimateFades:Countdown(5, nil, icon)
		end
		warnDecimate:PreciseShow(3, args.destName)--3 is max targets, but it can scale down to less
		self.vb.decimateIcon = self.vb.decimateIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 459273 and args:IsPlayer() then
		timerCosmicShards:Stop()
	elseif spellId == 434155 then
		if self.Options.SetIconOnPhaseBlades then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellPhaseBladesFades:Cancel()
		end
	elseif spellId == 439191 then
		if self.Options.SetIconOnDecimate then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDecimateFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]