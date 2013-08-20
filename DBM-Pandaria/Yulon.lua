if GetBuildInfo() ~= "5.4.0" then return end
local mod	= DBM:NewMod(858, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71955)
mod:SetZone()
mod:SetMinSyncRevision(10162)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnJadefireBreath		= mod:NewSpellAnnounce(144530, 2, nil, mod:IsTank())
local warnJadefireBolt			= mod:NewSpellAnnounce(144532, 3)--Target scanning works but only grabs one of like 3-5 targets.
local warnJadefireWall			= mod:NewSpellAnnounce(144533, 4)

local specWarnJadefireBreath	= mod:NewSpecialWarningSpell(144530, mod:IsTank())
local specWarnJadefireBlaze		= mod:NewSpecialWarningMove(144538)
local specWarnJadefireWall		= mod:NewSpecialWarningSpell(144533, nil, nil, nil, 2)

local timerJadefireBreathCD		= mod:NewCDTimer(18.5, 144530, nil, mod:IsTank())
local timerJadefireBoltCD		= mod:NewCDTimer(18, 144532)
local timerJadefireWallCD		= mod:NewNextTimer(60, 144533)

mod:AddBoolOption("RangeFrame", true)--For jadefire bolt/blaze (depending how often it's cast, if it's infrequent i'll kill range finder)

local yellTriggered = false

function mod:OnCombatStart(delay)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerJadefireBreathCD:Start(6-delay)
		timerJadefireBoltCD:Start(15-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(11)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	yellTriggered = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144530 then
		warnJadefireBreath:Show()
		specWarnJadefireBreath:Show()
		timerJadefireBreathCD:Start()
	elseif args.spellId == 144545 then
		warnJadefireBolt:Show()
		timerJadefireBoltCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144537 and args:IsPlayer() then
		specWarnJadefireBlaze:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Victory then
		self:SendSync("Victory")
	elseif msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 71955 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 71955 then
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	elseif msg == L.Wave1 or msg == L.Wave2 then
		self:SendSync("Wave")
	end
end

--This method works without local and doesn't fail with curse of tongs but requires at least ONE person in raid targeting boss to be running dbm (which SHOULD be most of the time)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	elseif msg == "Wave" and self:IsInCombat() then
		warnJadefireWall:Show()
		specWarnJadefireWall:Show()
		timerJadefireWallCD:Start()
	end
end
