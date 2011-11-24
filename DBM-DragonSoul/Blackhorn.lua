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
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnHarpoon					= mod:NewTargetAnnounce(108038, 2)
local warnTwilightOnslaught			= mod:NewSpellAnnounce(108862, 4)
local warnTwilightFlames			= mod:NewSpellAnnounce(108051, 3)
local warnShockwave					= mod:NewTargetAnnounce(108862, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnHarpoon				= mod:NewSpecialWarningTarget(108038, false)
local specWarnTwilightOnslaught		= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnShockwaveNear			= mod:NewSpecialWarningClose(108046)
local specWarnShockwave				= mod:NewSpecialWarningMove(108046)
local specWarnTwilightFlames		= mod:NewSpecialWarningMove(108076)
local yellShockwave					= mod:NewYell(108046)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank(), 3)

local timerCombatStart				= mod:NewTimer(20.5, "TimerCombatStart", 2457)
local timerTwilightOnslaughtCD		= mod:NewNextTimer(35, 107588)
local timerSapperCD					= mod:NewTimer(40, "TimerSapper", 107752)
local timerDeckFireCD				= mod:NewCDTimer(20, 110095)--Not the best log, so not sure if this is accurate or actually based on other variables.
local timerTwilightFlamesCD			= mod:NewNextTimer(8, 108051)
local timerShockwaveCD				= mod:NewCDTimer(23, 108046)
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, mod:IsTank() or mod:IsHealer())

local phase2Started = false
local lastFlames = 0

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
	phase2Started = false
	timerCombatStart:Start(-delay)
	timerSapperCD:Start(69-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerTwilightOnslaughtCD:Start(42-delay)--Not sure if variation is cause it was heroic or cause the first one is not consistent
		timerDeckFireCD:Start(60-delay)--Consistent?
	else
		timerTwilightOnslaughtCD:Start(48-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107588) then--Assumed since it's only cast ID spellid in ptr.wowhead
		warnTwilightOnslaught:Show()
		specWarnTwilightOnslaught:Show()
		timerTwilightOnslaughtCD:Start()
	elseif args:IsSpellID(108046) then--Assumed since it's only cast ID spellid in ptr.wowhead
		self:ScheduleMethod(0.2, "ShockwaveTarget")
		timerShockwaveCD:Start()
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
	--"<2059.6> [CLEU] SPELL_AURA_APPLIED#false#0xF150DFAC0000253E#Skyfire Cannon#2584#0#0xF150DFAC0000253E#Skyfire Cannon#2584#0#108040#Artillery Barrage#5#BUFF", -- [61321]
	--"<2067.7> [CAST_SUCCEEDED] Goriona:Possible Target<nil>:target:Eject Passenger 1::0:60603", -- [61429]
	--"<2069.5> [MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Looks like I'm doing this myself. Good!#Warmaster Blackhorn###Goriona##0#0##0#564##0#false", -- [61454]
	elseif args:IsSpellID(108040) and not phase2Started then--Goriona is being shot by the ships Artillery Barrage (phase 2 trigger)
		phase2Started = true
		--timerDeckFireCD:Cancel()--This continue into phase 2 or do we cancel it?
		Phase2:Show()
		timerCombatStart:Start(10)--8-10 seconds until blackhorn gets ejected by Goriona. Not sure if he's targetable at eject passenger or yell so using 10 for now.
		timerTwilightFlamesCD:Start(22)
		timerShockwaveCD:Start()--23-26 second variation
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(108051) then
		warnTwilightFlames:Show()--Target scanning? will need to put drake on focus and see
		timerTwilightFlamesCD:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(108076, 109222, 109223, 109224) then
		if args:IsPlayer() and GetTime() - lastFlames > 3  then
			specWarnTwilightFlames:Show()
			lastFlames = GetTime()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.SapperEmote or msg:find(L.SapperEmote) then
		timerSapperCD:Start()
	elseif msg:find(L.DeckFire) then
		timerDeckFireCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56427 then
		DBM:EndCombat(self)
	elseif cid == 56781 then
		timerTwilightFlamesCD:Cancel()
	end
end
