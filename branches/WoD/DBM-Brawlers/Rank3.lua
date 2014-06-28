local mod	= DBM:NewMod("BrawlRank3", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(28649)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 33975 136334 132666 134777 133302",
	"PLAYER_TARGET_CHANGED"
)

local warnPyroblast				= mod:NewCastAnnounce(33975, 3)--Hits fairly hard, interruptable, not make or break though. So no special warning. If it hits you you won't wipe.
local warnFireWall				= mod:NewSpellAnnounce(132666, 4)
local warnDevastatingThrust		= mod:NewSpellAnnounce(134777, 4)--1.5 second cast, does 2 million damage. pretty brutal

local specWarnFireWall			= mod:NewSpecialWarningSpell(132666)
local specWarnDevastatingThrust	= mod:NewSpecialWarningMove(134777)

local timerFirewallCD			= mod:NewCDTimer(18, 132666)--18-22 sec variation
local timerDevastatingThrustCD	= mod:NewCDTimer(12, 134777)--Need more data to verify CD

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SetIconOnBlat", true)

local brawlersMod = DBM:GetModByName("Brawlers")
local blatGUID = 0

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(33975, 136334) then--Spellid is used by 5 diff mobs in game, but SetZone sould filter the other 4 mobs.
		warnPyroblast:Show()
	elseif args.spellId == 132666 then
		warnFireWall:Show()
		timerFirewallCD:Start()--First one is 5 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireWall:Show()
		end
	elseif args.spellId == 134777 then
		warnDevastatingThrust:Show()
		timerDevastatingThrustCD:Start()--First one is 7-8 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnDevastatingThrust:Show()
		end
	elseif args.spellId == 133302 then--Blat splitting
		blatGUID = args.sourceGUID
	end
end

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnBlat and not DBM.Options.DontSetIcons and UnitGUID("target") == blatGUID then
		SetRaidTarget("target", 8)
	end
end
