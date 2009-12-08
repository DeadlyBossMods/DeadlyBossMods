local mod	= DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36476, 36477)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local warnPustulantFlesh		= mod:NewTargetAnnounce(69581)
local timerPustulantFlesh		= mod:NewTargetTimer(10, 69581)
local specWarnToxic				= mod:NewSpecialWarning("specWarnToxic")
local specWarnPursuit			= mod:NewSpecialWarning("specWarnPursuit")

mod:AddBoolOption("PlaySoundOnPursuit", true)
mod:AddBoolOption("SetIconOnPursuitTarget", true)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68987) then							-- Pursuit
		warnPursuitCast:Show()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69029, 70850) then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	elseif args:IsSpellID(69581, 70273) then							-- Pustulant Flesh
		warnPustulantFlesh:Show(args.destName)
		timerPustulantFlesh:Show(args.destName)
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

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg == L.IckPursuit then
		specWarnPursuit:Show()
		if self.Options.PlaySoundOnPursuit then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	local target = msg and msg:match(L.IckPursuit)
	if target then
		self:SendSync("Pursuit", target)
	end
end

function mod:OnSync(msg, target)
	if msg == "Pursuit" then
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