local mod = DBM:NewMod("Rotface", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36627)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)


local nextWallSlime			= mod:NewTimer(20, "NextPoisonSlimePipes")
local nextSlimeSpray		= mod:NewNextTimer(21, 69508)
local warnSlimeSpray		= mod:NewSpellAnnounce(69508)

local nextStickyOoze		= mod:NewNextTimer(16, 69774)
local warnStickyOoze		= mod:NewSpellAnnounce(69774)

local specWarnStickyOoze	= mod:NewSpecialWarning("SpecWarnStickyOoze")
mod:AddBoolOption("PlaySoundOnStickyOoze", true, "announce")

local warnRadiatingOoze		= mod:NewSpellAnnounce(69760)
local specWarnRadiatingOoze	= mod:NewSpecialWarning("SpecWarnRadiationOoze")

function mod:OnCombatStart(delay)
	nextWallSlime:Start(25-delay)
	self:ScheduleMethod(25-delay, "WallSlime")
end

function mod:WallSlime()
	if self:IsInCombat() then
		nextWallSlime:Start()
		self:UnscheduleMethod("WallSlime")
		self:ScheduleMethod(20, "WallSlime")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69508) then
		nextSlimeSpray:Start()
		warnSlimeSpray:Show()
	elseif args:IsSpellID(69774) then
		nextStickyOoze:Start()
		warnStickyOoze:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args:IsSpellID(71208) then
		specWarnOoze:Show()
		if self.Options.PlaySoundOnStickyOoze then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args:IsSpellID(69760) then
		warnRadiatingOoze:Show()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(69761, 71212) and args:IsPlayer() then
		specWarnRadiatingOoze:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSlimePipes then
		self:SendSync("PoisonSlimePipes")
	end
end

function mod:OnSync(msg, arg)
	if msg == "PoisonSlimePipes" then
		self:WallSlime()
	end
end

