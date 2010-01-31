local mod	= DBM:NewMod("Auriaya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetCreatureID(33515)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"UNIT_DIED"
)

local canInterrupt
do
	local class = select(2, UnitClass("player"))
	canInterrupt = class == "SHAMAN"
		or class == "WARRIOR"
		or class == "ROGUE"
		or class == "MAGE"
end

local warnSwarm 		= mod:NewTargetAnnounce(64396, 2)
local warnFear 			= mod:NewSpellAnnounce(64386, 3)
local warnFearSoon	 	= mod:NewAnnounce("WarnFearSoon", 1, 64386)
local warnCatDied 		= mod:NewAnnounce("WarnCatDied", 3, 64455)
local warnCatDiedOne	= mod:NewAnnounce("WarnCatDiedOne", 3, 64455)
local warnSonic			= mod:NewSpellAnnounce(64688, 2)

local specWarnBlast		= mod:NewSpecialWarning("SpecWarnBlast", canInterrupt)
local specWarnVoid 		= mod:NewSpecialWarning("SpecWarnVoid")

local enrageTimer		= mod:NewBerserkTimer(600)
local timerDefender 	= mod:NewTimer(35, "timerDefender")
local timerFear			= mod:NewCastTimer(64386)
local timerNextFear 	= mod:NewNextTimer(35.5, 64386)
local timerNextSwarm 	= mod:NewNextTimer(36, 64396)
local timerNextSonic 	= mod:NewNextTimer(27, 64688)
local timerSonic		= mod:NewCastTimer(64688)

mod:AddBoolOption("HealthFrame", true)

local isFeared			= false

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerNextFear:Start(40-delay)
	timerNextSonic:Start(60-delay)
	timerDefender:Start(60-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64678, 64389) then -- Sentinel Blast
		specWarnBlast:Show()
	elseif args:IsSpellID(64386) then -- Terrifying Screech
		warnFear:Show()
		timerFear:Start()
		timerNextFear:Schedule(2)
		warnFearSoon:Schedule(34)
	elseif args:IsSpellID(64688, 64422) then --Sonic Screech
		warnSonic:Show()
		timerSonic:Start()
		timerNextSonic:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64396) then -- Guardian Swarm
		warnSwarm:Show(args.destName)
		timerNextSwarm:Start()
	elseif args:IsSpellID(64455) then -- Feral Essence
		DBM.BossHealth:AddBoss(34035, L.Defender:format(9))
	elseif args:IsSpellID(64386) and args:IsPlayer() then
		isFeared = true		
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64386) and args:IsPlayer() then
		isFeared = false	
	end
end

local catLives = 9
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34035 then
		catLives = catLives - 1
		if catLives > 0 then
			if catLives == 1 then
				warnCatDiedOne:Show()
				timerDefender:Start()
			else
				warnCatDied:Show(catLives)
				timerDefender:Start()
         	end
			if self.Options.HealthFrame then
				DBM.BossHealth:RemoveBoss(34035)
				DBM.BossHealth:AddBoss(34035, L.Defender:format(catLives))
			end
		else
			if self.Options.HealthFrame then
				DBM.BossHealth:RemoveBoss(34035)
			end
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(64459, 64675) and args:IsPlayer() then -- Feral Defender Void Zone
		specWarnVoid:Show()
	end
end