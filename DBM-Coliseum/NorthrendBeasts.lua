local mod	= DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1,2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local canTranq = select(2, UnitClass("player")) == "HUNTER"
              or select(2, UnitClass("player")) == "ROGUE"

local warnImpaleOn			= mod:NewTargetAnnounce(67478, 2)
local warnFireBomb			= mod:NewSpellAnnounce(66317, 4, nil, false)
local warnBreath			= mod:NewSpellAnnounce(67650, 1)
local warnRage				= mod:NewSpellAnnounce(67657, 3)
local warnSlimePool			= mod:NewSpellAnnounce(67643, 2)
local warnToxin				= mod:NewTargetAnnounce(66823, 2)
local warnBile				= mod:NewTargetAnnounce(66869, 3)
local WarningSnobold		= mod:NewAnnounce("WarningSnobold", 2)
local warnEnrageWorm		= mod:NewSpellAnnounce(68335, 3)

local specWarnImpale3		= mod:NewSpecialWarning("SpecialWarningImpale3", false)
local specWarnAnger3		= mod:NewSpecialWarning("SpecialWarningAnger3", false)
local specWarnFireBomb		= mod:NewSpecialWarning("SpecialWarningFireBomb")
local specWarnSlimePool		= mod:NewSpecialWarning("SpecialWarningSlimePool")
local specWarnToxin			= mod:NewSpecialWarning("SpecialWarningToxin")
local specWarnBile			= mod:NewSpecialWarning("SpecialWarningBile")
local specWarnSilence		= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge		= mod:NewSpecialWarning("SpecialWarningCharge")
local specWarnChargeNear	= mod:NewSpecialWarning("SpecialWarningChargeNear")
local specWarnTranq         = mod:NewSpecialWarning("SpecialWarningTranq", canTranq)

local enrageTimer			= mod:NewEnrageTimer(223)
local timerCombatStart		= mod:NewTimer(23, "TimerCombatStart")
local timerNextBoss			= mod:NewTimer(190, "TimerNextBoss")
local timerSubmerge			= mod:NewTimer(45, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp") 
local timerEmerge			= mod:NewTimer(10, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local timerBreath			= mod:NewCastTimer(5, 67650)
local timerNextStomp		= mod:NewNextTimer(20, 66330)
local timerNextImpale		= mod:NewNextTimer(10, 67477)
local timerRisingAnger      = mod:NewNextTimer(20.5, 66636)
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758)
local timerNextCrash		= mod:NewCDTimer(55, 67662)
local timerSweepCD			= mod:NewCDTimer(17, 66794)
local timerSlimePoolCD		= mod:NewCDTimer(12, 66883)
local timerAcidicSpewCD		= mod:NewCDTimer(21, 66819)
local timerMoltenSpewCD		= mod:NewCDTimer(21, 66820)
local timerParalyticSprayCD	= mod:NewCDTimer(17, 66901)
local timerBurningSprayCD	= mod:NewCDTimer(21, 66902)
local timerParalyticBiteCD	= mod:NewCDTimer(25, 66824)
local timerBurningBiteCD	= mod:NewCDTimer(15, 66879)

mod:AddBoolOption("PingCharge")
mod:AddBoolOption("SetIconOnChargeTarget", true, "announce")
mod:AddBoolOption("SetIconOnBileTarget", true, "announce")
mod:AddBoolOption("ClearIconsOnIceHowl", true, "announce")

local bileTargets			= {}
local toxinTargets			= {}
local burnIcon				= 8
local phases				= {}
local DreadscaleActive		= true  	-- Is dreadscale moving?
local DreadscaleDead	= false
local AcidmawDead	= false

local function updateHealthFrame(phase)
	if phases[phase] then
		return
	end
	phases[phase] = true
	if phase == 1 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(34796, L.Gormok)
	elseif phase == 2 then
		DBM.BossHealth:AddBoss(35144, L.Acidmaw)
		DBM.BossHealth:AddBoss(34799, L.Dreadscale)
	elseif phase == 3 then
		DBM.BossHealth:AddBoss(34797, L.Icehowl)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(bileTargets)
	table.wipe(toxinTargets)
	table.wipe(phases)
	burnIcon = 8
	DreadscaleActive = true
	DreadscaleDead = false
	AcidmawDead = false
	specWarnSilence:Schedule(37-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerNextBoss:Start(175 - delay)
		timerNextBoss:Schedule(170)
	end
	timerNextStomp:Start(38-delay)
	timerRisingAnger:Start(48-delay)
	timerCombatStart:Start(-delay)
	updateHealthFrame(1)
end

function mod:warnToxin()
	warnToxin:Show(table.concat(toxinTargets, "<, >"))
	table.wipe(toxinTargets)
end

function mod:warnBile()
	warnBile:Show(table.concat(bileTargets, "<, >"))
	table.wipe(bileTargets)
	burnIcon = 8
end

function mod:WormsEmerge()
	timerSubmerge:Show()
	if not AcidmawDead then
		if DreadscaleActive then
			timerSweepCD:Start(16)
			timerParalyticSprayCD:Start(10)			
		else
			timerSlimePoolCD:Start(14)
			timerParalyticBiteCD:Start(5)			
			timerAcidicSpewCD:Start(10)
		end
	end
	if not DreadscaleDead then
		if DreadscaleActive then
			timerSlimePoolCD:Start(14)
			timerMoltenSpewCD:Start(10)
			timerBurningBiteCD:Start(5)
		else
			timerSweepCD:Start(16)
			timerBurningSprayCD:Start(16)
		end
	end	
	self:ScheduleMethod(45, "WormsSubmerge")
end

function mod:WormsSubmerge()
	timerEmerge:Show()
	timerSweepCD:Cancel()
	timerSlimePoolCD:Cancel()
	timerMoltenSpewCD:Cancel()
	timerParalyticSprayCD:Cancel()
	timerBurningBiteCD:Cancel()
	timerAcidicSpewCD:Cancel()
	timerBurningSprayCD:Cancel()
	timerParalyticBiteCD:Cancel()
	DreadscaleActive = not DreadscaleActive
	self:ScheduleMethod(10, "WormsEmerge")
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then					-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName)
	elseif args:IsSpellID(67657, 66759, 67658, 67659) then				-- Frothing Rage
		warnRage:Show()
		specWarnTranq:Show()
	elseif args:IsSpellID(66823, 67618, 67619, 67620) then				-- Paralytic Toxin
		self:UnscheduleMethod("warnToxin")
		toxinTargets[#toxinTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnToxin:Show()
		end
		mod:ScheduleMethod(0.2, "warnToxin")
	elseif args:IsSpellID(66869) then		-- Burning Bile
		self:UnscheduleMethod("warnBile")
		bileTargets[#bileTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBile:Show()
		end
		if mod.Options.SetIconOnBileTarget and burnIcon > 0 then
			mod:SetIcon(args.destName, burnIcon, 15)
			burnIcon = burnIcon - 1
		end
		mod:ScheduleMethod(0.2, "warnBile")
		updateHealthFrame(2) 
	elseif args:IsSpellID(66758) then
		timerStaggeredDaze:Start()
	elseif args:IsSpellID(66636) then		-- Rising Anger
		WarningSnobold:Show()
		timerRisingAnger:Show()
	elseif args:IsSpellID(68335) then
		warnEnrageWorm:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then		-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName)
		if (args.amount >= 3 and not self:IsDifficulty("heroic10", "heroic25") ) or ( args.amount >= 2 and self:IsDifficulty("heroic10", "heroic25") ) then 
			if args:IsPlayer() then
				specWarnImpale3:Show(args.amount)
			end
		end
	elseif args:IsSpellID(66636) then		-- Rising Anger
		WarningSnobold:Show()
		if args.amount <= 3 then
			timerRisingAnger:Show()
		elseif args.amount >= 3 then
			specWarnAnger3:Show(args.amount)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66689, 67650, 67651, 67652) then		-- Arctic Breath
		timerBreath:Start()
		warnBreath:Show()
	elseif args:IsSpellID(66313) then						-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args:IsSpellID(66330, 67647, 67648, 67649) then	-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)						-- prewarn ~1,5 sec before next
	elseif args:IsSpellID(66794, 67644, 67645, 67646) then		-- Sweep stationary worm
		timerSweepCD:Start()
	elseif args:IsSpellID(66821) then							-- Molten spew
		timerMoltenSpewCD:Start()
	elseif args:IsSpellID(66818) then							-- Acidic Spew
		timerAcidicSpewCD:Start()
	elseif args:IsSpellID(66901, 67615, 67616, 67617) then		-- Paralytic Spray
		timerParalyticSprayCD:Start()
	elseif args:IsSpellID(66902, 67627, 67628, 67629) then		-- Burning Spray
		timerBurningSprayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(67641, 66883, 67642, 67643) then		-- Slime Pool Cloud Spawn
		warnSlimePool:Show()
		timerSlimePoolCD:Show()
	elseif args:IsSpellID(66824, 67612, 67613, 67614) then		-- Paralytic Bite
		timerParalyticBiteCD:Start()
	elseif args:IsSpellID(66879, 67624, 67625, 67626) then		-- Burning Bite
		timerBurningBiteCD:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsPlayer() and (args:IsSpellID(66320, 67472, 67473, 67475) or args:IsSpellID(66317)) then	-- Fire Bomb (66317 is impact damage, not avoidable but leaving in because it still means earliest possible warning to move. Other 4 are tick damage from standing in it)
		specWarnFireBomb:Show()
	elseif args:IsPlayer() and args:IsSpellID(66881, 67638, 67639, 67640) then				-- Slime Pool
		specWarnSlimePool:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.Charge) or msg:find(L.Charge) then
		timerNextCrash:Start()
		if self.Options.ClearIconsOnIceHowl then
			self:ClearIcons()
		end
		if target == UnitName("player") then
			specWarnCharge:Show()
			if self.Options.PingCharge then
				Minimap:PingLocation()
			end
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnChargeNear:Show()
				end
			end
		end
		if self.Options.SetIconOnChargeTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2")
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		self:SendSync("Phase3")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34796 then
		specWarnSilence:Cancel()
		timerNextStomp:Stop()
		timerNextImpale:Stop()
		DBM.BossHealth:RemoveBoss(cid) -- remove Gormok from the health frame
	elseif cid == 35144 then
		AcidmawDead = true
		timerParalyticSprayCD:Cancel()
		timerParalyticBiteCD:Cancel()
		timerAcidicSpewCD:Cancel()
		if DreadscaleActive then
			timerSweepCD:Cancel()
		else
			timerSlimePoolCD:Cancel()
		end
		if DreadscaleDead then
			DBM.BossHealth:RemoveBoss(35144)
			DBM.BossHealth:RemoveBoss(34799)
		end
	elseif cid == 34799 then
		DreadscaleDead = true
		timerBurningSprayCD:Cancel()
		timerBurningBiteCD:Cancel()
		timerMoltenSpewCD:Cancel()
		if DreadscaleActive then
			timerSlimePoolCD:Cancel()
		else
			timerSweepCD:Cancel()
		end
		if AcidmawDead then
			DBM.BossHealth:RemoveBoss(35144)
			DBM.BossHealth:RemoveBoss(34799)
		end
	end
end

function mod:OnSync(msg, arg)
	if msg == "Phase2" then
		self:ScheduleMethod(17, "WormsEmerge")
		timerCombatStart:Show(15)
		updateHealthFrame(2)
	elseif msg == "Phase3" then
		updateHealthFrame(3)
		if self:IsDifficulty("heroic10", "heroic25") then
			enrageTimer:Start()
		end
		self:UnscheduleMethod("WormsSubmerge")
		timerNextCrash:Start(45)
		timerNextBoss:Cancel()
		timerSubmerge:Cancel()
	end
end