local mod	= DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36476)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
			or select(2, UnitClass("player")) == "WARRIOR"
			or select(2, UnitClass("player")) == "DEATHKNIGHT"

local warnPursuitCast			= mod:NewCastAnnounce(68987)
local warnPoisonNova			= mod:NewCastAnnounce(68989)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local warnPustulantFlesh		= mod:NewTargetAnnounce(69581)
local timerPustulantFlesh		= mod:NewTargetTimer(10, 69581)
local timerPoisonNova			= mod:NewCastTimer(5, 68989)
local warnPursuit				= mod:NewAnnounce("warnPursuit")
local specWarnToxic				= mod:NewSpecialWarning("specWarnToxic")
local specWarnMines				= mod:NewSpecialWarning("specWarnMines")
local specWarnPursuit			= mod:NewSpecialWarning("specWarnPursuit")
local specWarnPoisonNova		= mod:NewSpecialWarning("specWarnPoisonNova", isMelee)

mod:AddBoolOption("PlaySoundOnPoisonNova", isMelee)
mod:AddBoolOption("PlaySoundOnPursuit", true)
mod:AddBoolOption("SetIconOnPursuitTarget", true)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68987) then							-- Pursuit
		warnPursuitCast:Show()
	elseif args:IsSpellID(68989, 70434) then				-- Poison Nova
		warnPoisonNova:Show()
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
		if self.Options.PlaySoundOnPoisonNova then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69029, 70850) then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	elseif args:IsSpellID(69581, 70273) and self:IsInCombat() then	-- Pustulant Flesh
		warnPustulantFlesh:Show(args.destName)
		timerPustulantFlesh:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69581, 70273) and self:IsInCombat() then		-- Pustulant Flesh
		timerPustulantFlesh:Cancel(args.destName)
	end
end

do 
	local lasttoxic = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69024, 70436) and args:IsPlayer() and time() - lasttoxic > 2 then		-- Toxic Waste, MOVE!
			specWarnToxic:Show()
			lasttoxic = time()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Barrage then
		specWarnMines:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg) 
	if msg == L.IckPursuit or msg:match(L.IckPursuit) then 
		self:SendSync("Pursuit", UnitName("player"))
	end 
end 

function mod:OnSync(msg, target) 
	if msg == "Pursuit" then 
		warnPursuit:Show(target)
	if target == UnitName("player") then 
		specWarnPursuit:Show() 
		if self.Options.PlaySoundOnPursuit then 
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav") 
		end 
	end 
		if self.Options.SetIconOnPursuitTarget then 
			self:SetIcon(target, 8, 12) 
		end 
	end 
end 