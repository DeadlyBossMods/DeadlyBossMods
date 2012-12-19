local mod	= DBM:NewMod(689, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60009)--60781 Soul Fragment
mod:SetModelID(41192)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)
--Phase order is controlled by players. it is only pre determined order in LFR and LFR only.
--Heroic a player can do ANY phase first. It even says this in encounter journal.
--on normal, it lets you choose nature or fire first but it will not allow arcane first.
--none the less, the player can still control it on normal, just not to degree of heroic. The EJ says it's random on normal but it's not.

local warnPhase						= mod:NewAnnounce("WarnPhase", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
--Nature/Fist
local warnLightningLash				= mod:NewStackAnnounce(131788, 3, nil, mod:IsTank())
local warnLightningFists			= mod:NewSpellAnnounce(116157, 3)
local warnEpicenter					= mod:NewCountAnnounce(116018, 4)

--Fire/Spear
local warnFlamingSpear				= mod:NewStackAnnounce(116942, 3, nil, mod:IsTank())
local warnWildSpark					= mod:NewTargetCountAnnounce(116784, 4)
local yellWildSpark					= mod:NewYell(116784)
local warnDrawFlame					= mod:NewCountAnnounce(116711, 4)
local warnWildfireInfusion			= mod:NewStackAnnounce(116821, 3, nil, mod:IsHealer())

--Arcane/Staff
local warnArcaneShock				= mod:NewStackAnnounce(131790, 3, nil, mod:IsTank())
local warnArcaneResonance			= mod:NewTargetAnnounce(116417, 4)
local warnArcaneVelocity			= mod:NewCountAnnounce(116364, 4)

--Shadow/Shield (Heroic Only)
local warnShadowBurn				= mod:NewStackAnnounce(131792, 3, nil, mod:IsTank())
local warnChainsOfShadow			= mod:NewSpellAnnounce(118783, 2, nil, false)
local warnSiphoningShield			= mod:NewCountAnnounce(117203, 4)

--Tank Abilities
local warnReversalLightningFists	= mod:NewTargetAnnounce(118302, 2)--this spell can interrupt Epicenter, so needs to warn.
local warnNullBarrior				= mod:NewSpellAnnounce(115817, 2)

--Nature/Fist
local specWarnLightningLash			= mod:NewSpecialWarningStack(131788, mod:IsTank(), 2)
local specWarnLightningLashOther	= mod:NewSpecialWarningTarget(131788, mod:IsTank())
local specWarnEpicenter				= mod:NewSpecialWarningRun(116018, nil, nil, nil, true)

--Fire/Spear
local specWarnFlamingSpear			= mod:NewSpecialWarningStack(116942, mod:IsTank(), 2)
local specWarnFlamingSpearOther		= mod:NewSpecialWarningTarget(116942, mod:IsTank())
local specWarnWildSpark				= mod:NewSpecialWarningYou(116784)
local specWarnWildfire				= mod:NewSpecialWarningMove(116793)
local specWarnDrawFlame				= mod:NewSpecialWarningSpell(116711, nil, nil, nil, true)

--Arcane/Staff
local specWarnArcaneShock			= mod:NewSpecialWarningStack(131790, mod:IsTank(), 2)
local specWarnArcaneShockOther		= mod:NewSpecialWarningTarget(131790, mod:IsTank())
local specWarnArcaneResonance		= mod:NewSpecialWarningYou(116417)
local yellArcaneResonance			= mod:NewYell(116417)
local specWarnArcaneVelocity		= mod:NewSpecialWarningSpell(116364, nil, nil, nil, true)

--Shadow/Shield (Heroic Only)
local specWarnShadowBurn			= mod:NewSpecialWarningStack(131792, mod:IsTank(), 2)
local specWarnShadowBurnOther		= mod:NewSpecialWarningTarget(131792, mod:IsTank())
local specWarnSiphoningShield		= mod:NewSpecialWarningSpell(117203)

--Tank Abilities
local specWarnNullBarrior			= mod:NewSpecialWarningSpell(115817) -- Null Barrier is important all members, espcially Earth and Arcane Phase.

--Nature/Fist
local timerLightningLash			= mod:NewTargetTimer(20, 131788, nil, mod:IsTank())
local timerLightningLashCD			= mod:NewCDTimer(9, 131788, nil, mod:IsTank())--9-20 second variation.
local timerLightningFistsCD			= mod:NewCDTimer(14, 116157)
local timerEpicenterCD				= mod:NewCDCountTimer(30, 116018)
local timerEpicenter				= mod:NewBuffActiveTimer(10, 116018)

--Fire/Spear
local timerFlamingSpear				= mod:NewTargetTimer(20, 116942, nil, mod:IsTank())
local timerFlamingSpearCD			= mod:NewCDTimer(9, 116942, nil, mod:IsTank())--8-11second variation, usually 10 though.
local timerWildSpark				= mod:NewTargetTimer(5, 116784)
local timerDrawFlame				= mod:NewBuffActiveTimer(6, 116711)
local timerDrawFlameCD				= mod:NewNextCountTimer(30, 116711)--30 seconds after last ended.

--Arcane/Staff
local timerArcaneShock				= mod:NewTargetTimer(20, 131790, nil, mod:IsTank())
local timerArcaneShockCD			= mod:NewCDTimer(9, 131790, nil, mod:IsTank())--not comfirmed
local timerArcaneResonanceCD		= mod:NewCDTimer(15, 116417)--CD is also duration, it's just cast back to back to back.
local timerArcaneVelocityCD			= mod:NewCDCountTimer(18, 116364)--18 seconds after last ended.
local timerArcaneVelocity			= mod:NewBuffActiveTimer(8, 116364)

--Shadow/Shield (Heroic Only)
local timerShadowBurn				= mod:NewTargetTimer(20, 131792, nil, mod:IsTank())
local timerShadowBurnCD				= mod:NewCDTimer(9, 131792, nil, mod:IsTank())
local timerChainsOfShadowCD			= mod:NewCDTimer(6, 118783, nil, false)--6-10sec variation noted
local timerSiphoningShieldCD		= mod:NewCDCountTimer(35, 117203)--35-38sec variation noted

--Tank Abilities
local timerReversalLightningFists	= mod:NewBuffFadesTimer(20, 118302)
local timerNullBarrior				= mod:NewBuffFadesTimer(6, 115817)
local timerNullBarriorCD			= mod:NewCDTimer(55, 115817)

local soundEpicenter				= mod:NewSound(116018)
local soundWildSpark				= mod:NewSound(116784)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local phase = 0
local wildfireCount = 0
local sparkCount = 0
local fragmentCount = 5
local specialCount = 0
local arcaneResonanceTargets = {}

local function warnWildfire()
	warnWildfireInfusion:Cancel()
	warnWildfireInfusion:Schedule(1, L.name, wildfireCount)
end

local function warnArcaneResonanceTargets()
	warnArcaneResonance:Show(table.concat(arcaneResonanceTargets, "<, >"))
	table.wipe(arcaneResonanceTargets)
end

function mod:OnCombatStart(delay)
	phase = 0
	wildfireCount = 0
	sparkCount = 0
	specialCount = 0
	table.wipe(arcaneResonanceTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(131788) then
		warnLightningLash:Show(args.destName, 1)
		timerLightningLash:Start(args.destName)
		timerLightningLashCD:Start()
	elseif args:IsSpellID(116942) then
		warnFlamingSpear:Show(args.destName, 1)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
	elseif args:IsSpellID(131790) then
		warnArcaneShock:Show(args.destName, 1)
		timerArcaneShock:Start(args.destName)
		timerArcaneShockCD:Start()
	elseif args:IsSpellID(131792) then
		warnShadowBurn:Show(args.destName, 1)
		timerShadowBurn:Start(args.destName)
		timerShadowBurnCD:Start()
	elseif args:IsSpellID(118302) then
		warnReversalLightningFists:Show(args.destName)
		timerReversalLightningFists:Start()
	elseif args:IsSpellID(116784) then
		sparkCount = sparkCount + 1
		warnWildSpark:Show(sparkCount, args.destName)
		timerWildSpark:Start(args.destName)
		if args:IsPlayer() then
			specWarnWildSpark:Show()
			soundWildSpark:Play()
			yellWildSpark:Yell()
		end
	elseif args:IsSpellID(116711) then
		sparkCount = 0
		specialCount = specialCount + 1
		warnDrawFlame:Show(specialCount)
		timerDrawFlame:Start()
		specWarnDrawFlame:Show()
	elseif args:IsSpellID(116821) then
		wildfireCount = 1
		warnWildfire()
	elseif args:IsSpellID(116417) then
		-- seems that affects 2 players in 25man lfr. so use multiple target warning.
		arcaneResonanceTargets[#arcaneResonanceTargets + 1] = args.destName
		timerArcaneResonanceCD:Start()
		self:Unschedule(warnArcaneResonanceTargets)
		self:Schedule(0.3, warnArcaneResonanceTargets)
		if args:IsPlayer() then
			specWarnArcaneResonance:Show()
			yellArcaneResonance:Yell()
		end
	elseif args:IsSpellID(116364) then
		specialCount = specialCount + 1
		warnArcaneVelocity:Show(specialCount)
		specWarnArcaneVelocity:Show()
		timerArcaneVelocity:Start()
	end
end

-- split Flaming Spear (Arcane Resonance also uses SPELL_AURA_APPLIED_DOSE, buggy)
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(131788) then
		warnLightningLash:Show(args.destName, args.amount or 1)
		timerLightningLash:Start(args.destName)
		timerLightningLashCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnLightningLash:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(131788)) then
				specWarnLightningLashOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(116942) then
		warnFlamingSpear:Show(args.destName, args.amount or 1)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnFlamingSpear:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(116942)) then
				specWarnFlamingSpearOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(131790) then
		warnArcaneShock:Show(args.destName, args.amount or 1)
		timerArcaneShock:Start(args.destName)
		timerArcaneShockCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnArcaneShock:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(131790)) then
				specWarnArcaneShockOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(131792) then
		warnShadowBurn:Show(args.destName, args.amount or 1)
		timerShadowBurn:Start(args.destName)
		timerShadowBurnCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnShadowBurn:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(131792)) then
				specWarnShadowBurnOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(116821) then
		wildfireCount = args.amount or 1
		warnWildfire()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(131788) then
		timerLightningLash:Cancel(args.destName)
	elseif args:IsSpellID(116942) then
		timerFlamingSpear:Cancel(args.destName)
	elseif args:IsSpellID(131790) then
		timerArcaneShock:Cancel(args.destName)
	elseif args:IsSpellID(131792) then
		timerShadowBurn:Cancel(args.destName)
	elseif args:IsSpellID(118302) then
		timerReversalLightningFists:Cancel()
	elseif args:IsSpellID(116018) then
		timerEpicenter:Cancel()--Epicenter can be removed by Lightning Fists (tank can steal). So added remove stuff.
	elseif args:IsSpellID(116784) then
		timerWildSpark:Cancel(args.destName)
	elseif args:IsSpellID(116711) then
		timerDrawFlameCD:Start(nil, specialCount + 1)
	elseif args:IsSpellID(116364) then
		timerArcaneVelocity:Cancel()
		timerArcaneVelocityCD:Start(nil, specialCount + 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(116018) then
		specialCount = specialCount + 1
		warnEpicenter:Show(specialCount)
		specWarnEpicenter:Show()
		soundEpicenter:Play()
		timerEpicenter:Start()
		timerEpicenterCD:Start(nil, specialCount + 1)
	elseif args:IsSpellID(116157) then
		warnLightningFists:Show()
		timerLightningFistsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(118783) then
		warnChainsOfShadow:Show()
		timerChainsOfShadowCD:Start()
	elseif args:IsSpellID(115817) then
		warnNullBarrior:Show()
		specWarnNullBarrior:Show()
		timerNullBarrior:Start()
		if self:IsDifficulty("lfr25") then
			timerNullBarriorCD:Start(25)
		else
			timerNullBarriorCD:Start()
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 116793 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnWildfire:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Nature or msg:find(L.Nature) then
		self:SendSync("Earth")
	elseif msg == L.Fire or msg:find(L.Fire) then
		self:SendSync("Flame")
	elseif msg == L.Arcane or msg:find(L.Arcane) then
		self:SendSync("Purple")
	elseif msg == L.Shadow or msg:find(L.Shadow) then
		self:SendSync("Dark")
	end
end

function mod:OnSync(msg)
	if msg == "Earth" then
		phase = phase + 1
		warnPhase:Show(phase)
		timerLightningLashCD:Start(7)
		timerLightningFistsCD:Start(12)
		timerEpicenterCD:Start(18, 1)--It's either this, or this +10. Not yet sure what causes the +10
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == "Flame" then
		phase = phase + 1
		warnPhase:Show(phase)
		timerFlamingSpearCD:Start(5.5)
		timerDrawFlameCD:Start(35, 1)--No variation, or not enough logs of fire phase.
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == "Purple" then
		phase = phase + 1
		warnPhase:Show(phase)
		timerArcaneShockCD:Start(7)
		-- 10/13 01:11:24.437  YELL: Oh sage of the ages! Instill to me your arcane wisdom!
		-- 10/13 01:11:36.671  SPELL_CAST_SUCCESS,0xF150EA690000478E,"",0x10a48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,116417,"",0x40
		timerArcaneResonanceCD:Start(12)
		timerArcaneVelocityCD:Start(14.5, 1)--It's either this, or this +10. Not yet sure what causes the +10
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif msg == "Dark" then
		phase = phase + 1
		warnPhase:Show(phase)
		timerSiphoningShieldCD:Start(4, 1)--either this, or this +5. Not yet sure what causes the +5
		timerChainsOfShadowCD:Start(6)
		timerShadowBurnCD:Start(9)--9-11 variation
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 117203 and self:AntiSpam(2, 1) then--Siphoning Shield
		specialCount = specialCount + 1
		warnSiphoningShield:Show(specialCount)
		specWarnSiphoningShield:Show()
		timerSiphoningShieldCD:Start(nil, specialCount + 1)
	elseif spellId == 121631 and self:AntiSpam(2, 2) then--Draw Essence.
		--Best place to cancel timers, vs duplicating cancel code in all 4 yells above.
		specialCount = 0
		timerFlamingSpearCD:Cancel()
		timerDrawFlameCD:Cancel()
		timerArcaneShockCD:Cancel()
		timerArcaneResonanceCD:Cancel()
		timerArcaneVelocityCD:Cancel()
		timerLightningLashCD:Cancel()
		timerLightningFistsCD:Cancel()
		timerEpicenterCD:Cancel()
		timerShadowBurnCD:Cancel()
		timerSiphoningShieldCD:Cancel()
		timerChainsOfShadowCD:Cancel()
	end
end
