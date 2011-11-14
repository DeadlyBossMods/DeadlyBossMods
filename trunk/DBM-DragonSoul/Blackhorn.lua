if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(332, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56598)--56427 is Boss, but engage trigger needs the ship which is 56598
mod:SetModelID(39399)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnHarpoon					= mod:NewTargetAnnounce(108038, 2)
local warnTwilightOnslaught			= mod:NewSpellAnnounce(108862, 4)
local warnShockwave					= mod:NewTargetAnnounce(108862, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnHarpoon				= mod:NewSpecialWarningTarget(108038, false)
local specWarnTwilightOnslaught		= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnShockwaveNear			= mod:NewSpecialWarningClose(108046)--Cast on you
local specWarnShockwave				= mod:NewSpecialWarningMove(108046)--Standing in circle it left behind.
local yellShockwave					= mod:NewYell(108046)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank(), 3)

local timerCombatStart				= mod:NewTimer(20.5, "TimerCombatStart", 2457)
local timerTwilightOnslaughtCD		= mod:NewNextTimer(35, 107588)
local timerSapperCD					= mod:NewTimer(40, "TimerSapper", 107752)
--local timerShockwaveCD				= mod:NewNextTimer(20, 108046)--Forgot to log the good pull where i saw this phase :(
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, mod:IsTank() or mod:IsHealer())

function mod:ShockwaveTarget()
	local targetname = self:GetBossTarget(56427)
	if not targetname then return end
	warnShockwave:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShockwave:Show()
		yellShockwave:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 13 then--Might be able to tune range?
				specWarnShockwaveNear:Show(targetname)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	timerCombatStart:Start(-delay)
	timerTwilightOnslaughtCD:Start(48-delay)--Need a log with actual engage time for this
	timerSapperCD:Start(70-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107588) then--Assumed since it's only cast ID spellid in ptr.wowhead
		warnTwilightOnslaught:Show()
		specWarnTwilightOnslaught:Show()
		timerTwilightOnslaughtCD:Start()
	elseif args:IsSpellID(108046) then--Assumed since it's only cast ID spellid in ptr.wowhead
		self:ScheduleMethod(0.2, "ShockwaveTarget")
--		timerShockwaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(108043) then
		warnSunder:Show(args.destName, args.amount or 1)
		timerSunder:Start(args.destName)
		if (args.amount or 0) >= 3 and args:IsPlayer() then
			specWarnSunder:Show(args.amount)
		end
	elseif args:IsSpellID(108038) then
		warnHarpoon:Show(args.destName)
		specWarnHarpoon:Show(args.destName)
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.SapperEmote or msg:find(L.SapperEmote) then
		timerSapperCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 56427 then
		DBM:EndCombat(self)
	end
end