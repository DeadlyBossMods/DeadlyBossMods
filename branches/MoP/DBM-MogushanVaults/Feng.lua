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

--Seems that Feng always change transforms Nature -> Fire -> Arcane -> Shadow(heroic)
--Nature/Fist (Phase 1)
local warnPhase1					= mod:NewPhaseAnnounce(1)
local warnLightningFists			= mod:NewSpellAnnounce(116157, 3)
local warnEpicenter					= mod:NewSpellAnnounce(116018, 4)

--Fire/Spear (Phase 2)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnFlamingSpear				= mod:NewStackAnnounce(116942, 3, nil, mod:IsTank())
local warnWildSpark					= mod:NewTargetCountAnnounce(116784, 4)
local yellWildSpark					= mod:NewYell(116784)
local warnDrawFlame					= mod:NewSpellAnnounce(116711, 4)

--Arcane/Staff (Phase 3)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnArcaneResonance			= mod:NewTargetAnnounce(116417, 4)
local warnArcaneVelocity			= mod:NewSpellAnnounce(116364, 4)

--Missing other ability entirely, cannot drycode it either, way too many spellids for it, no idea what's right.

--Shadow/Shield (Heroic Only, Phase 4)
local warnPhase4					= mod:NewPhaseAnnounce(4)
local warnChainsOfShadow			= mod:NewSpellAnnounce(118783, 2, nil, false)
local warnSiphoningShield			= mod:NewSpellAnnounce(117203, 4)

--Nature/Fist
local specWarnEpicenter				= mod:NewSpecialWarningRun(116018, nil, nil, nil, true)

--Fire/Spear
local specWarnFlamingSpear			= mod:NewSpecialWarningStack(116942, mod:IsTank(), 4)
local specWarnFlamingSpearOther		= mod:NewSpecialWarningTarget(116942, mod:IsTank())
local specWarnWildSpark				= mod:NewSpecialWarningYou(116784)
local specWarnWildfire				= mod:NewSpecialWarningMove(116793)
local specWarnDrawFlame				= mod:NewSpecialWarningSpell(116711, nil, nil, nil, true)

--Arcane/Staff
local specWarnArcaneResonance		= mod:NewSpecialWarningYou(116417)
local yellArcaneResonance			= mod:NewYell(116417)
local specWarnArcaneVelocity		= mod:NewSpecialWarningSpell(116364, nil, nil, nil, true)

--Shadow/Shield (Heroic Only)
local specWarnSiphoningShield		= mod:NewSpecialWarningSpell(117203)

--Nature/Fist
local timerLightningFistsCD			= mod:NewCDTimer(14, 116157)
local timerEpicenterCD				= mod:NewCDTimer(29, 116018)
local timerEpicenter				= mod:NewCastTimer(10, 116018)

--Fire/Spear
local timerFlamingSpear				= mod:NewTargetTimer(20, 116942, nil, mod:IsTank())
local timerFlamingSpearCD			= mod:NewCDTimer(8, 116942, nil, mod:IsTank())--8-11second variation, usually 10 though.
local timerWildSpark				= mod:NewTargetTimer(5, 116784)
local timerDrawFlame				= mod:NewBuffActiveTimer(6, 116711)
local timerDrawFlameCD				= mod:NewNextTimer(30, 116711)--30 seconds after last ended.

--Arcane/Staff
local timerArcaneResonanceCD		= mod:NewCDTimer(15, 116417)--CD is also duration, it's just cast back to back to back.
local timerArcaneVelocityCD			= mod:NewCDTimer(22, 116364)--22 seconds after last ended.
local timerArcaneVelocity			= mod:NewCastTimer(8, 116364)

--Shadow/Shield (Heroic Only)
local timerChainsOfShadowCD			= mod:NewCDTimer(6, 118783, nil, false)--6-10sec variation noted
local timerSiphoningShieldCD		= mod:NewCDTimer(45, 117203)--45-50sec variation noted

local soundEpicenter				= mod:NewSound(116018)

local sparkCount = 0
local fragmentCount = 5
local arcaneResonanceTargets = {}

local function warnArcaneResonanceTargets()
	warnArcaneResonance:Show(table.concat(arcaneResonanceTargets, "<, >"))
	table.wipe(arcaneResonanceTargets)
end

function mod:OnCombatStart(delay)
	sparkCount = 0
	table.wipe(arcaneResonanceTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(116942) then
		warnFlamingSpear:Show(args.destName, 1)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
	elseif args:IsSpellID(116784) then
		sparkCount = sparkCount + 1
		warnWildSpark:Show(sparkCount, args.destName)
		timerWildSpark:Start(args.destName)
		if args:IsPlayer() then
			specWarnWildSpark:Show()
			yellWildSpark:Yell()
		end
	elseif args:IsSpellID(116711) then
		sparkCount = 0
		warnDrawFlame:Show()
		specWarnDrawFlame:Show()
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
		warnArcaneVelocity:Show()
		specWarnArcaneVelocity:Show()
		timerArcaneVelocity:Start()
	end
end

-- split Flaming Spear (Arcane Resonance also uses SPELL_AURA_APPLIED_DOSE, buggy)
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(116942) then
		warnFlamingSpear:Show(args.destName, args.amount or 1)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 3 then
			specWarnFlamingSpear:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitDebuff("player", GetSpellInfo(116942)) and not UnitIsDeadOrGhost("player") then
				specWarnFlamingSpearOther:Show(args.destName)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(116018) then
		timerEpicenter:Cancel()--Epicenter can be removed by Lightning Fists (tank can steal). So added remove stuff.
	elseif args:IsSpellID(116942) then
		timerFlamingSpear:Cancel(args.destName)
	elseif args:IsSpellID(116784) then
		timerWildSpark:Cancel(args.destName)
	elseif args:IsSpellID(116711) then
		timerDrawFlameCD:Start()
	elseif args:IsSpellID(116364) then
		timerArcaneVelocity:Cancel()
		timerArcaneVelocityCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(116018) then
		warnEpicenter:Show()
		specWarnEpicenter:Show()
		soundEpicenter:Play()
		timerEpicenter:Start()
		timerEpicenterCD:Start()
	elseif args:IsSpellID(116157) then
		warnLightningFists:Show()
		timerLightningFistsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(118783) then
		warnChainsOfShadow:Show()
		timerChainsOfShadowCD:Start()
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
		warnPhase1:Show()
		timerLightningFistsCD:Start(6.5)
		timerEpicenterCD:Start(19)
	elseif msg == L.Fire or msg:find(L.Fire) then
		warnPhase2:Show()
		timerFlamingSpearCD:Start(5.5)
		timerDrawFlameCD:Start(35)
	elseif msg == L.Arcane or msg:find(L.Arcane) then
		warnPhase3:Show()
		timerArcaneResonanceCD:Start(14)
		timerArcaneVelocityCD:Start(16.5)
	elseif msg == L.Shadow or msg:find(L.Shadow) then
		warnPhase4:Show()
		timerSiphoningShieldCD:Start(6)
		timerChainsOfShadowCD:Start(10)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 117203 and self:AntiSpam(2, 1) then--Siphoning Shield:
		warnSiphoningShield:Show()
		specWarnSiphoningShield:Show()
		timerSiphoningShieldCD:Start()
	elseif spellId == 121631 and self:AntiSpam(2, 2) then--Draw Essence.
		--Best place to cancel timers, vs duplicating cancel code in all 4 yells above.
		timerFlamingSpearCD:Cancel()
		timerDrawFlameCD:Cancel()
		timerArcaneResonanceCD:Cancel()
		timerArcaneVelocityCD:Cancel()
		timerLightningFistsCD:Cancel()
		timerEpicenterCD:Cancel()
		timerSiphoningShieldCD:Cancel()
		timerChainsOfShadowCD:Cancel()
	end
end
