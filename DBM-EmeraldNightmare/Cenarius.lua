local mod	= DBM:NewMod(1750, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 14741 $"):sub(12, -3))
mod:SetCreatureID(104636)
mod:SetEncounterID(1877)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 210290 212726 212630 211073 211192 211368 214529",
	"SPELL_CAST_SUCCESS 210280 214505 214876",
	"SPELL_AURA_APPLIED 210346 211368",
	"SPELL_AURA_REMOVED 210346",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED"
)

--TODO, see if target scanning works for nightmare brambles
--TODO, see if destructive Nightmares has a fixate of sorts to warn one being changed by bad whisps
--TODO, evaluate stomp and need of timer/etc
--TODO, GTFOs probably
--TODO, timers for adds for things that matter, probably Twisted Touch of Life
--Cenarius
local warnBeastsOfNightmare			= mod:NewSpellAnnounce(214876, 2)--Generic for now, figure out what to do with later.
----Forces of Nightmare
local warnDesiccatingStomp			= mod:NewCastAnnounce(211073, 3, nil, nil, "Melee")--Basic warning for now, will change to special if needed
local warnRottenBreath				= mod:NewTargetAnnounce(211192, 2)
--Malfurion Stormrage
local warnCleansingGround			= mod:NewCastAnnounce(212630, 1)

--Cenarius
local specWarnCreepingNightmares	= mod:NewSpecialWarningSpell(210280, nil, nil, nil, 2)--No voice yet, need to see it better.
local specWarnNightmareBrambles		= mod:NewSpecialWarningDodge(210290, nil, nil, nil, 2, 2)
local specWarnDreadThorns			= mod:NewSpecialWarningMoveAway(210346, "Tank", nil, nil, 1, 2)--Move away warning? Have to move away from other adds
local specWarnForcesOfNightmare		= mod:NewSpecialWarningSwitch(212726, nil, nil, nil, 1, 2)--Switch warning or just spell warning?
local specWarnSpearOfNightmares		= mod:NewSpecialWarningSpell(214529, nil, nil, nil, 1, 2)
local specWarnSpearOfNightmaresOther= mod:NewSpecialWarningTaunt(214529, nil, nil, nil, 1, 2)
local specWarnEntangledNightmares	= mod:NewSpecialWarningSwitch(214505, "Dps", nil, nil, 1, 2)
----Forces of Nightmare
local yellRottenBreath				= mod:NewYell(211192)
local specWarnTouchofLife			= mod:NewSpecialWarningInterrupt(211368, "HasInterrupt")
local specWarnTouchofLifeDispel		= mod:NewSpecialWarningDispel(211368, "MagicDispeller")

--Cenarius
local timerCreepingNightmaresCD		= mod:NewAITimer(16, 210280, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerNightmareBramblesCD		= mod:NewAITimer(16, 210290, nil, nil, nil, 3)--targeted?
local timerDreadThornsCD			= mod:NewAITimer(16, 210346, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerForcesOfNightmareCD		= mod:NewAITimer(16, 212726, nil, nil, nil, 1)
local timerSpearOfNightmaresCD		= mod:NewAITimer(16, 214529, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Forces of Nightmare
--Malfurion Stormrage
local timerCleansingGroundCD		= mod:NewAITimer(16, 212630, nil, nil, nil, 3)--targeted or role?

--Cenarius
--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
----Forces of Nightmare

--Cenarius
local voiceNightmareBrambles		= mod:NewVoice(210290)--watchstep
local voiceDreadThorns				= mod:NewVoice(210346, "Tank")--bossout
local voiceForcesOfNightmare		= mod:NewVoice(212726)--mobsoon
local voiceSpearOfNightmares		= mod:NewVoice(214529, "Tank")--defensive/tauntboss
----Forces of Nightmare
local voiceTouchOfLife				= mod:NewVoice(211368)--kickcast/dispelnow

--mod:AddRangeFrameOption("5")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)--HUD on targets of target scans maybe?

mod.vb.phase = 1

function mod:BreathTarget(targetname, uId)
	if not targetname then return end
	warnRottenBreath:Show(targetname)
	if targetname == UnitName("player") then
		yellRottenBreath:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerCreepingNightmaresCD:Start(1-delay)
	timerNightmareBramblesCD:Start(1-delay)
	timerDreadThornsCD:Start(1-delay)
	timerForcesOfNightmareCD:Start(1-delay)
	timerCleansingGroundCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 210290 then
		specWarnNightmareBrambles:Show()
		voiceNightmareBrambles:Play("watchstep")
		timerNightmareBramblesCD:Start()
	elseif spellId == 212726 then
		specWarnForcesOfNightmare:Show()
		voiceForcesOfNightmare:Play("mobsoon")
		timerForcesOfNightmareCD:Start()
	elseif spellId == 212630 then
		warnCleansingGround:Show()
		timerCleansingGroundCD:Start()
	elseif spellId == 211073 then
		warnDesiccatingStomp:Show()
	elseif spellId == 211192 then
		self:BossTargetScanner(args.sourceGUID, "BreathTarget", 0.1, 15)
	elseif spellId == 211368 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnTouchofLife:Show(args.sourceName)
		voiceTouchOfLife:Play("kickcast")
	elseif spellId == 214529 then
		timerSpearOfNightmaresCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104636, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnSpearOfNightmares:Show()
			voiceSpearOfNightmares:Play("defensive")
		else
			if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, targetName) then return end--You are not near current tank, you're probably 3rd tank on Doom Guards that never taunts massive blast
			specWarnSpearOfNightmaresOther:Schedule(1, targetName)
			voiceSpearOfNightmares:Schedule(2.5, "tauntboss")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 210280 then--Creeping Nightmares cast, maybe? Might use APPLIED only
		specWarnCreepingNightmares:Show()
		timerCreepingNightmaresCD:Start()
	elseif spellId == 214505 then
		specWarnEntangledNightmares:Show()
	elseif spellId == 214876 then
		warnBeastsOfNightmare:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 210346 then
		specWarnDreadThorns:Show()
		voiceDreadThorns:Play("bossout")
		timerDreadThornsCD:Start()--Here for now because AI timer, but move to SPELL_AURA_REMOVED with data
	elseif spellId == 211368 then
		specWarnTouchofLifeDispel:Show(args.destName)
		voiceTouchOfLife:Play("dispelnow")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 210346 then
--		timerDreadThornsCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105495 then--Scorned Sister
		--Cancel Timers here
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
