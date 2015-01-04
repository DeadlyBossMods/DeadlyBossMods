local mod	= DBM:NewMod(1154, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76809, 99999)--76809 foreman feldspar, 76806 heart of the mountain, 76809 Security Guard, 76810 Furnace Engineer, 76811 Bellows Operator, 76815 Primal Elementalist, 78463 Slag Elemental, 76821 Firecaller
mod:SetEncounterID(1690)
mod:SetZone()
--mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155186 156937 177756",
	"SPELL_CAST_SUCCESS 160382 155179 174726 156932",
	"SPELL_AURA_APPLIED 155192 155196 158345 155242 155181 176121",
	"SPELL_AURA_APPLIED_DOSE 155242",
	"SPELL_AURA_REMOVED 155192 176121",
	"SPELL_PERIODIC_DAMAGE 156932 155223",
	"SPELL_PERIODIC_MISSED 156932 155223",
	"UNIT_DIED",
	"UNIT_POWER_FREQUENT boss1"
)

--TODO, figure out how to detect OTHER add spawns besides operator and get timers for them too. It's likely the'll require ugly scheduling and /yell logging. 
local warnBomb					= mod:NewTargetAnnounce(155192, 4)
local warnBellowsOperator		= mod:NewSpellAnnounce("ej9650", 4, 155181)
local warnDeafeningRoar			= mod:NewSpellAnnounce(177756, 3, nil, mod:IsTank())
local warnDefense				= mod:NewSpellAnnounce(160382, 2, nil, mod:IsTank())
local warnRepair				= mod:NewCastAnnounce(155179, 4, nil, nil, not mod:IsHealer())
local warnDropBombs				= mod:NewSpellAnnounce(174726, 1)
local warnRupture				= mod:NewTargetAnnounce(156932, 3)--Uses SPELL_CAST_SUCCESS because blizzard is dumb and debuff apply and standing in fire apply same spellid, only way to report ONLY debuff is use SUCCESS
local warnCauterizeWounds		= mod:NewCastAnnounce(155186, 4, nil, nil, not mod:IsHealer())
local warnFixate				= mod:NewTargetAnnounce(155196, 4)
local warnPryclasm				= mod:NewCastAnnounce(156937, 3, nil, nil, false)
local warnVolatileFire			= mod:NewTargetAnnounce(176121, 4)
local warnShieldsDown			= mod:NewSpellAnnounce(158345, 1, nil, mod:IsDps())
local warnHeartoftheMountain	= mod:NewSpellAnnounce("ej9641", 3, 2894)
local warnHeat					= mod:NewStackAnnounce(155242, 2, nil, mod:IsTank())

local specWarnBomb				= mod:NewSpecialWarningYou(155192, nil, nil, nil, 3, nil, true)
local specWarnBellowsOperator	= mod:NewSpecialWarningSwitch("ej9650", mod:IsDps(), nil, nil, nil, nil, true)
local specWarnDeafeningRoar		= mod:NewSpecialWarningSpell(177756, nil, nil, nil, 3)
local specWarnDefense			= mod:NewSpecialWarningMove(160382, mod:IsTank(), nil, nil, nil, nil, true)
local specWarnRepair			= mod:NewSpecialWarningInterrupt(155179, not mod:IsHealer(), nil, nil, nil, nil, true)
local specWarnRuptureOn			= mod:NewSpecialWarningYou(156932)
local specWarnRupture			= mod:NewSpecialWarningMove(156932, nil, nil, nil, nil, nil, true)
local specWarnFixate			= mod:NewSpecialWarningYou(155196)
local specWarnMelt				= mod:NewSpecialWarningMove(155223, nil, nil, nil, nil, nil, true)
local specWarnCauterizeWounds	= mod:NewSpecialWarningInterrupt(155186, not mod:IsHealer())--if spammy, will switch to target/focus type only
local specWarnPyroclasm			= mod:NewSpecialWarningInterrupt(156937, false)
local specVolatileFire			= mod:NewSpecialWarningMoveAway(176121)
local yellVolatileFire			= mod:NewYell(176121)
local specWarnShieldsDown		= mod:NewSpecialWarningSwitch("ej9655", mod:IsDps())
local specWarnHeartoftheMountain= mod:NewSpecialWarningSwitch("ej9641", mod:IsTank())
local specWarnHeat				= mod:NewSpecialWarningStack(155242, nil, 3, nil, nil, nil, nil, true)
local specWarnHeatOther			= mod:NewSpecialWarningTaunt(155242, nil, nil, nil, nil, nil, true)
local specWarnBlast				= mod:NewSpecialWarningSpell(155209, nil, nil, nil, 2)

local timerBomb					= mod:NewBuffFadesTimer(15, 155192)
local timerBlastCD				= mod:NewCDTimer(25, 155209)--25 seconds base. shorter when loading is being channeled by operators.
local timerEngineer				= mod:NewNextTimer(45, "ej9649", nil, nil, nil, 155179)
local timerBellowsOperator		= mod:NewNextTimer(60, "ej9655", nil, nil, nil, 155181)
local timerShieldsDown			= mod:NewBuffActiveTimer(25, 158345, nil, mod:IsDps())--Anyone else need?

local countdownBellowsOperator	= mod:NewCountdown(60, "ej9650")
local countdownEngineer			= mod:NewCountdown("Alt45", "ej9649")

local voicePhaseChange			= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRepair				= mod:NewVoice(155179, not mod:IsHealer()) --int
local voiceBomb 				= mod:NewVoice(155192) --bombyou.ogg, bomb on you
local voiceDefense 				= mod:NewVoice(160382, mod:IsTank()) --taunt mobout
local voiceBellowsOperator 		= mod:NewVoice("ej9650", mod:IsDps())
local voiceRupture				= mod:NewVoice(156932) --runaway
local voiceMelt					= mod:NewVoice(155223) --runaway
local voiceHeat					= mod:NewVoice(155242, mod:IsTank()) --changemt

mod:AddRangeFrameOption(8, 176121)

mod.vb.machinesDead = 0
mod.vb.elementalistsDead = 0
local UnitPower, UnitBuff = UnitPower, UnitBuff
local dkAMS = GetSpellInfo(48707)

--I was pretty bad at doing /yell adds in my chat log so this may not be perfect.
--It may not be 45 at all. Or at least first may not be 45 so rest will be off by a couple sec.
--Todo, verify and improve. Putting timer in to catch it if wrong faster, but adding warnings only after it's right.
local function Adds()
	timerEngineer:Start()
	countdownEngineer:Start()
	mod:Schedule(45, Adds)
end

function mod:OnCombatStart(delay)
	self.vb.machinesDead = 0
	self.vb.elementalistsDead = 0
	self:Schedule(45, Adds)
	timerEngineer:Start()
	countdownEngineer:Start()
	if self:AntiSpam(10, 0) then--Force this antispam on pull so first two adds "loading" doesn't start 60 second timer
		timerBellowsOperator:Start(55-delay)
		countdownBellowsOperator:Start(55-delay)
	end
	timerBlastCD:Start(25-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155186 then
		warnCauterizeWounds:Show()
		specWarnCauterizeWounds:Show(args.sourceName)
	elseif spellId == 156937 then
		warnPryclasm:Show()
		specWarnPyroclasm:Show(args.sourceName)
	elseif spellId == 177756 and self:CheckTankDistance(args.sourceGUID, 30) then
		warnDeafeningRoar:Show()
		specWarnDeafeningRoar:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 160382 and self:CheckTankDistance(args.sourceGUID, 30) then
		warnDefense:Show()
		specWarnDefense:Show()
		voiceDefense:Play("mobout")
	elseif spellId == 155179 then--Repair should NOT check tank distance, because these mobs run to lowest health regulator, even if it's on OTHER side of where their tank is.
		warnRepair:Show()
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 174726 and self:CheckTankDistance(args.sourceGUID, 30) then
		warnDropBombs:Show()
	elseif spellId == 156932 then
		warnRupture:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and not UnitBuff("player", dkAMS) then--Because forced to use SUCCESS, extra check to avoid giving death knight a warning if they blocked it with AMS
			specWarnRuptureOn:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155192 then
		if self:CheckTankDistance(args.sourceGUID, 30) then
			warnBomb:Show(args.destName)
		end
		if args:IsPlayer() then
			specWarnBomb:Show()
			timerBomb:Start()
			voiceBomb:Play("bombrun")
		end
	elseif spellId == 155196 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	elseif spellId == 158345 and self:AntiSpam(10, 3) then--Might be SPELL_CAST_SUCCESS instead.
		warnShieldsDown:Show()
		specWarnShieldsDown:Show()
		timerShieldsDown:Start()
	elseif spellId == 155242 then
		local amount = args.amount or 1
		warnHeat:Show(args.destName, amount)
		if amount >= 3 then
			voiceHeat:Play("changemt")
			if args:IsPlayer() then
				specWarnHeat:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155242)) and not UnitIsDeadOrGhost("player") then
					specWarnHeatOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155181 and self:AntiSpam(10, 0) then--Loading (The two that come can be upwards of 5 seconds apart so at least 10 second antispam)
		warnBellowsOperator:Show()
		specWarnBellowsOperator:Show()
		timerBellowsOperator:Start()
		countdownBellowsOperator:Start()
		voiceBellowsOperator:Play("killmob")
	elseif spellId == 176121 then
		warnVolatileFire:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specVolatileFire:Show()
			if not self:IsLFR() then
				yellVolatileFire:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155192 and args:IsPlayer() then
		timerBomb:Cancel()
	elseif spellId == 176121 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 156932 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnRupture:Show()
		voiceRupture:Play("runaway")
	elseif spellId == 155223 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnMelt:Show()
		voiceMelt:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76815 then--Elementalist
		self.vb.elementalistsDead = self.vb.elementalistsDead + 1
		if self.vb.elementalistsDead == 4 then
			warnHeartoftheMountain:Show()
			specWarnHeartoftheMountain:Show()
		end
	elseif cid == 76808 then--Regulators
		self.vb.machinesDead = self.vb.machinesDead + 1
		if self.vb.machinesDead == 2 then
			self:Unschedule(Adds)
			timerEngineer:Cancel()
			countdownEngineer:Cancel()
			timerBellowsOperator:Cancel()
			countdownBellowsOperator:Cancel()	
		end
	end
end

--Maybe awkward way of doing it since timer will kind of skip when operators are out, but most accurate way of doing it.
--emote to emote shows variation even when loading doesn't add power. sometimes 24, sometimes 27. This timer may be closer, we'll see
--Probably very high cpu usage
function mod:UNIT_POWER_FREQUENT(uId)
	local bossPower = UnitPower("boss1") --Get Boss Power
	bossPower = bossPower / 4 --Divide it by 4 (cause he gains 4 power per second and we need to know how many seconds to subtrack from CD)
	timerBlastCD:Update(bossPower, 25)
	if bossPower == 23 and self:AntiSpam(5, 5) then--Cast in 2 seconds
		specWarnBlast:Show()
	end
end
