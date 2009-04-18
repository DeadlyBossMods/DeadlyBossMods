local mod = DBM:NewMod("Mimiron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33432)
mod:SetZone()

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_CHANNEL_STOP"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee, "announce")
mod:AddBoolOption("PlaySoundOnDarkGlare", true, "announce")
mod:AddBoolOption("HealthFramePhase4", true)

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast", isMelee)
local warnDarkGlare			= mod:NewSpecialWarning("DarkGlare")
local blastWarn				= mod:NewAnnounce("WarnBlast", 4)
local shellWarn				= mod:NewAnnounce("WarnShell", 2)

local timerProximityMines	= mod:NewNextTimer(35, 63027)
local timerShockBlast		= mod:NewCastTimer(63631)
local timerP1toP2			= mod:NewTimer(43, "TimeToPhase2")
local timerP2toP3			= mod:NewTimer(25, "TimeToPhase3")
local timerSpinUp			= mod:NewCastTimer(4, 63414)
local timerDarkGlareCast	= mod:NewCastTimer(10, 63274)
local timerNextDarkGlare	= mod:NewNextTimer(41, 63274)
local timerNextShockblast	= mod:NewNextTimer(34, 63631)

local phase = 0 

function mod:OnCombatStart(delay)
	phase = 0
	self:NextPhase()
end

local spinningUp = GetSpellInfo(63414)
local lastSpinUp = 0
function mod:UNIT_SPELLCAST_CHANNEL_STOP(unit, spell)
	if spell == spinningUp and GetTime() - lastSpinUp < 3.9 then
		self:SendSync("SpinUpFail")
	end
end


function mod:SPELL_CAST_START(args)
	if args.spellId == 63631 then
		warnShockBlast:Show()
		timerShockBlast:Start()
		timerNextShockblast:Start()
		if self.Options.PlaySoundOnShockBlast then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63666 then -- Napalm Shell
		shellWarn:Show(args.destName)
		self:SetIcon(args.destName, 8, 6)
	elseif args.spellId == 64529 then -- Plasma Blast
		blastWarn:Show(args.destName)
		self:SetIcon(args.destName, 7, 6)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63027 then		-- mines
		timerProximityMines:Start()

	elseif args.spellId == 63414 then	-- Spinning UP (before Dark Glare)
		timerSpinUp:Start()
		timerDarkGlareCast:Schedule(4)
		timerNextDarkGlare:Schedule(19)	-- 4 (cast spinup) + 15 sec (cast dark glare)
		warnDarkGlare:Show()
		if self.Options.PlaySoundOnDarkGlare then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
		lastSpinUp = GetTime()
	end
end

function mod:NextPhase()
	phase = phase + 1
	if phase == 1 then
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
		end
	elseif phase == 2 then
		timerProximityMines:Stop()
		timerP1toP2:Start()
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
		end
	elseif phase == 3 then
		timerDarkGlareCast:Cancel()
		timerNextDarkGlare:Cancel()
		timerP2toP3:Start()
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33370, L.MobPhase3)
		end
	elseif phase == 4 then
		if self.Options.HealthFramePhase4 or self.Options.HealthFrame then
			DBM.BossHealth:Show(L.name)
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
			DBM.BossHealth:AddBoss(33370, L.MobPhase3)
		end
	end
end

do 
	local count = 0
	local last = 0
	local lastPhaseChange = 0
	function mod:SPELL_AURA_REMOVED(args)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if GetTime() - lastPhaseChange > 30 and (cid == 33432 or cid == 33651 or cid == 33370) then
			if args.timestamp == last then	-- all events in the same tick to detect the phases earlier (than the yell) and localization-independent
				count = count + 1
				if count > 10 then
					lastPhaseChange = GetTime()
					self:NextPhase()
				end
			else
				count = 1
			end
			last = args.timestamp
		end
	end
end


function mod:OnSync(event, args)
	if event == "SpinUpFail" then
		timerSpinUp:Cancel()
		timerDarkGlareCast:Cancel()
		timerNextDarkGlare:Cancel()
		warnDarkGlare:Cancel()
	end
end

