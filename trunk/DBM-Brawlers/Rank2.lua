local mod	= DBM:NewMod("BrawlRank2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(46712)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133302 229124",
--	"SPELL_AURA_APPLIED 229884",
--	"SPELL_AURA_REMOVED 229884",
	"PLAYER_TARGET_CHANGED"
)

--TODO, boom broom timer
local warnPowershot				= mod:NewCastAnnounce(229124, 4)--Johnny Awesome

local specWarnPowerShot			= mod:NewSpecialWarningMoveTo(229124, nil, nil, nil, 1, 2)--Johnny Awesome

local timerPowerShotCD			= mod:NewCDTimer(15.5, 229124, nil, nil, nil, 3)--Johnny Awesome

mod:AddBoolOption("SetIconOnBlat", true)--Blat

local brawlersMod = DBM:GetModByName("Brawlers")
local blatGUID = 0
local GetRaidTargetIndex = GetRaidTargetIndex

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133302 then
		blatGUID = args.sourceGUID
	elseif args.spellId == 229124 then
		timerPowerShotCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnPowerShot:Show(PET)
			specWarnPowerShot:Play("findshelter")
		else
			warnPowershot:Show()
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 229884 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 229884 then

	end
end
--]]

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnBlat and not DBM.Options.DontSetIcons and UnitGUID("target") == blatGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
