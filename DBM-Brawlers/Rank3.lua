local mod	= DBM:NewMod("BrawlRank3", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(28649)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 134740 133607 134777 133302",
	"PLAYER_TARGET_CHANGED"
)

local warnVolatileFlames		= mod:NewSpellAnnounce(134740, 3)--Vian the Volatile
local warnFireLine				= mod:NewCastAnnounce(133607, 4, 2)--Vian the Volatile
local warnDevastatingThrust		= mod:NewSpellAnnounce(134777, 4)--Ixx

local specWarnFireLine			= mod:NewSpecialWarningDodge(133607)--Vian the Volatile
local specWarnDevastatingThrust	= mod:NewSpecialWarningDodge(134777)--Ixx

local timerVolatileFlamesCD		= mod:NewCDTimer(11, 134740)--Vian the Volatile
local timerFireLineCD			= mod:NewCDTimer(15, 133607)--Vian the Volatile
local timerDevastatingThrustCD	= mod:NewCDTimer(12, 134777)--Ixx

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SetIconOnBlat", true)--Blat

local brawlersMod = DBM:GetModByName("Brawlers")
local blatGUID = 0
local GetRaidTargetIndex = GetRaidTargetIndex

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134740 then
		warnVolatileFlames:Show()
		timerVolatileFlamesCD:Start()
	elseif args.spellId == 133607 then
		warnFireLine:Show()
		timerFireLineCD:Start()--First one is 9-10 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireLine:Show()
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
	if self.Options.SetIconOnBlat and not DBM.Options.DontSetIcons and UnitGUID("target") == blatGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
