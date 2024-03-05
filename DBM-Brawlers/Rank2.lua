local mod	= DBM:NewMod("BrawlRank2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(46712)

mod:RegisterEvents(
	"SPELL_CAST_START 133302 229124",
	"SPELL_CAST_SUCCESS 283199 283188",
--	"SPELL_AURA_APPLIED 229884",
--	"SPELL_AURA_REMOVED 229884",
	"PLAYER_TARGET_CHANGED"
)

--TODO, boom broom timer
local warnPowershot				= mod:NewCastAnnounce(229124, 4)--Johnny Awesome
local warnSMaSHtun				= mod:NewSpellAnnounce(283188, 3)--Mama Stormstout
local warnColdCrash				= mod:NewSpellAnnounce(283199, 4)--Mama Stormstout

local specWarnPowerShot			= mod:NewSpecialWarningMoveTo(229124, nil, nil, nil, 1, 2)--Johnny Awesome
local specWarnColdCrash			= mod:NewSpecialWarningMoveTo(283199, nil, nil, nil, 3, 2)--Mama Stormstout

local timerPowerShotCD			= mod:NewCDTimer(15.5, 229124, nil, nil, nil, 3)--Johnny Awesome
local timerColdCrashCD			= mod:NewCDTimer(13.4, 283199, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)----Mama Stormstout

mod:AddBoolOption("SetIconOnBlat", true)--Blat

local brawlersMod = DBM:GetModByName("BrawlersGeneral")
local blatGUID = ""
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
			timerPowerShotCD:SetSTFade(true)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 283199 then
		timerColdCrashCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnColdCrash:Show(L.Sand)
			specWarnColdCrash:Play("findshelter")
		else
			warnColdCrash:Show()
			timerColdCrashCD:SetSTFade(true)
		end
	elseif args.spellId == 283188 then
		warnSMaSHtun:Show()
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
	if self.Options.SetIconOnBlat and UnitGUID("target") == blatGUID and GetRaidTargetIndex("target") ~= 8 then
		self:SetIcon("target", 8)
	end
end
