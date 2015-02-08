local mod	= DBM:NewMod(1162, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77692)
mod:SetEncounterID(1713)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 157060 157054 156704 157592 158217",
	"SPELL_CAST_SUCCESS 158130 170469",
	"SPELL_AURA_APPLIED 156766 161923 173917 156852",
	"SPELL_AURA_APPLIED_DOSE 156766"
)

--TODO, see how second trembling earth CD works and if current code even works for other timers. Mythic pulls were very short :\
local warnCrushingEarth				= mod:NewTargetAnnounce(161923, 3, nil, false)--Players who failed to move. Off by default since announcing failures is not something DBM generally does by default. Can't announce pre cast unfortunately. No detection
local warnStoneGeyser				= mod:NewSpellAnnounce(158130, 2)
local warnWarpedArmor				= mod:NewStackAnnounce(156766, 2, nil, "Tank")

local specWarnGraspingEarth			= mod:NewSpecialWarningMoveTo(157060, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(157060), nil, nil, nil, 2)
local specWarnThunderingBlows		= mod:NewSpecialWarningSpell(157054, nil, nil, nil, 3)
local specWarnRipplingSmash			= mod:NewSpecialWarningDodge(157592, nil, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningCount(156852, nil, nil, nil, 2)
local specWarnSlam					= mod:NewSpecialWarningSpell(156704, "Tank")
local specWarnWarpedArmor			= mod:NewSpecialWarningStack(156766, nil, 2)
local specWarnWarpedArmorOther		= mod:NewSpecialWarningTaunt(156766)
local specWarnTremblingEarth		= mod:NewSpecialWarningSpell(173917, nil, nil, nil, 2)
local specWarnCalloftheMountain		= mod:NewSpecialWarningCount(158217, nil, nil, nil, 3)

local timerGraspingEarthCD			= mod:NewCDTimer(114, 157060)--Unless see new logs on normal showing it can still be 111, raising to 115, average i saw was 116-119
local timerThunderingBlowsCD		= mod:NewNextTimer(12, 157054)
local timerRipplingSmashCD			= mod:NewCDTimer(27, 157592)--If it comes off CD early enough into ThunderingBlows/Grasping Earth, he skips a cast. Else, he'll cast it very soon after.
--local timerStoneGeyserCD			= mod:NewNextTimer(30, 158130)
local timerStoneBreathCD			= mod:NewCDCountTimer(22.5, 156852)
local timerSlamCD					= mod:NewCDTimer(23, 156704, nil, "Tank")
local timerWarpedArmorCD			= mod:NewCDTimer(14, 156766, nil, "Tank")
local timerTremblingEarthCD			= mod:NewNextTimer(30, 173917)
local timerTremblingEarth			= mod:NewBuffActiveTimer(25, 173917)
local timerCalloftheMountain		= mod:NewCastTimer(5, 158217)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownThunderingBlows		= mod:NewCountdown(12, 157054)
local countdownTremblingEarth		= mod:NewCountdownFades("Alt25", 173917)

local voiceGraspingEarth 			= mod:NewVoice(157060)--157060, safenow
local voiceWarpedArmor				= mod:NewVoice(156766)

mod.vb.mountainCast = 0
mod.vb.stoneBreath = 0

function mod:OnCombatStart(delay)
	self.vb.mountainCast = 0
	self.vb.stoneBreath = 0
	timerStoneBreathCD:Start(8-delay, 1)--8-10
	timerWarpedArmorCD:Start(15-delay)
	timerSlamCD:Start(25-delay)--More data needed
	timerRipplingSmashCD:Start(30-delay)
	timerGraspingEarthCD:Start(51-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 157060 then
		self.vb.stoneBreath = 0
		specWarnGraspingEarth:Show(RUNES)
		timerThunderingBlowsCD:Start()
		countdownThunderingBlows:Start()
		timerSlamCD:Cancel()
		timerStoneBreathCD:Cancel()
		timerRipplingSmashCD:Cancel()
		timerWarpedArmorCD:Cancel()
		voiceGraspingEarth:Play("157060")
		voiceGraspingEarth:Schedule(12, "safenow")
		if self:IsMythic() then
			timerTremblingEarthCD:Start()
			timerGraspingEarthCD:Start(123)--TODO, see if normal is still 111 after last
		else
			timerGraspingEarthCD:Start()
			timerStoneBreathCD:Start(31, 1)
			timertimerRipplingSmashCD:Start(41)
		end
	elseif spellId == 157054 then
		specWarnThunderingBlows:Show()
		--Starting timers for slam and rippling seem useless, 10-30 sec variation for first ones.
		--after that they get back into their consistency
	elseif spellId == 157592 then
		specWarnRipplingSmash:Show()
		timerRipplingSmashCD:Start()
	elseif spellId == 156704 then
		specWarnSlam:Show()
		timerSlamCD:Start()
	elseif spellId == 158217 then--Probably not in combat log, it's scripted. Probably needs a UNIT_SPELLCAST event
		self.vb.mountainCast = self.vb.mountainCast + 1
		specWarnCalloftheMountain:Show(self.vb.mountainCast)
		timerCalloftheMountain:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158130 or spellId == 170469 then--Are both used? eliminate one that isn't if not
		warnStoneGeyser:Show()
		--Does it need a special warning?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156766 then
		local amount = args.amount or 1
		warnWarpedArmor:Show(args.destName, amount)
		timerWarpedArmorCD:Start()
		if amount >= 2 then
			voiceWarpedArmor:Play("changemt")
			if args:IsPlayer() then
				specWarnWarpedArmor:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(156766)) and not UnitIsDeadOrGhost("player") then
					specWarnWarpedArmorOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 161923 then
		warnCrushingEarth:CombinedShow(0.5, args.destName)
	elseif spellId == 173917 then
		specWarnTremblingEarth:Show()
		timerTremblingEarth:Start()
		countdownTremblingEarth:Start()
		timerSlamCD:Cancel()--Can't cast slam during this
		timerRipplingSmashCD:Cancel()--Or rippling
		timerWarpedArmorCD:Cancel()
		timerStoneBreathCD:Cancel()
	elseif spellId == 156852 then
		self.vb.stoneBreath = self.vb.stoneBreath + 1
		specWarnStoneBreath:Show(self.vb.stoneBreath)
		timerStoneBreathCD:Start(nil, self.vb.stoneBreath+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
