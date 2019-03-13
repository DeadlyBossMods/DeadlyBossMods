local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(28115)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 33975 136334"
--	"SPELL_AURA_APPLIED 236155",
--	"SPELL_AURA_APPLIED_DOSE 236155",
--	"SPELL_AURA_REMOVED 228981"
--	"PLAYER_TARGET_CHANGED"
)

--TODO, stickes stack warning for Aura of Rot
local warnPyroblast				= mod:NewCastAnnounce(33975, 3)--Sanoriak
local warnFireWall				= mod:NewSpellAnnounce(132666, 4)--Sanoriak

local specWarnFireWall			= mod:NewSpecialWarningSpell(132666, nil, nil, nil, 2, 2)--Sanoriak

local timerFirewallCD			= mod:NewCDTimer(17, 132666, nil, nil, nil, 3)--Sanoriak

local brawlersMod = DBM:GetModByName("Brawlers")
--local DominikaGUID = 0

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(33975, 136334) then--Spellid is used by 5 diff mobs in game, but SetZone sould filter the other 4 mobs.
		warnPyroblast:Show()
	elseif args.spellId == 132666 then
		timerFirewallCD:Start()--First one is 5 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireWall:Show()
			specWarnFireWall:Play("watchstep")
		else
			warnFireWall:Show()
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 236155 and args:IsPlayer() then
		local amount = args.amount or 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 228981 then
		timerWaterShield:Stop(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownWaterShield:Cancel()
		end
	end
end

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnDominika and not DBM.Options.DontSetIcons and UnitGUID("target") == DominikaGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
--]]
