local mod	= DBM:NewMod("BrawlRank3", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(28649)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 133302 229124",
	"SPELL_CAST_SUCCESS 232504",
	"PLAYER_TARGET_CHANGED"
)

--TODO, powershot spellid/event is drycoded, it may be a SUCCESS or APPLIED channel event.
local warnShadowTorch			= mod:NewSpellAnnounce(232504, 3)--Shadowmaster Aameen
local warnPowershot				= mod:NewCastAnnounce(229124, 4)--Johnny Awesome

local specWarnShadowTorch		= mod:NewSpecialWarningDodge(232504, nil, nil, nil, 3, 2)--Shadowmaster Aameen
local specWarnPowerShot			= mod:NewSpecialWarningMoveTo(229124, nil, nil, nil, 1, 2)--Johnny Awesome

local timerShadowTorchCD		= mod:NewCDTimer(5.3, 232504, nil, nil, nil, 3)-- 5.3, 6.2, 5.9, 6.1, 6.0 Shadowmaster Aameen
local timerPowerShotCD			= mod:NewCDTimer(15.5, 229124, nil, nil, nil, 3)--Johnny Awesome

mod:AddBoolOption("SetIconOnBlat", true)--Blat

local brawlersMod = DBM:GetModByName("Brawlers")
local blatGUID = 0
local GetRaidTargetIndex = GetRaidTargetIndex

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133302 then--Blat splitting
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

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 232504 then
		timerShadowTorchCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowTorch:Show()
			specWarnShadowTorch:Play("farfromline")
		else
			warnShadowTorch:Show()
		end
	end
end

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnBlat and not DBM.Options.DontSetIcons and UnitGUID("target") == blatGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
